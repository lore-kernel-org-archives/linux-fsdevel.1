Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A14647FB1A;
	Wed, 26 Aug 2026 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773459; cv=none; b=lzs7cOhqkRRdB4n8ueAp/YJ7I1uO3WMCyQZ5nXhtoaquyrJEGnObhJ22/CLp45D5wmv6t78bVrnvwGbfMISfBHUSG1rZE5Jz1/zYTvlMg6NfVZIs1ODSd/ZPS++eQ/7ktp2w1z0LkA89w8SlnNHnWWoWVV+ZDo+2sPHKuR2ihYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773459; c=relaxed/simple;
	bh=8nALYO+CR6FmkF08x+EV0iTBcAYc/NqrKS6OJYcgsUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYQTtyDe/96m6/KvVn1W0UR+EVLdwt03OpVwPDH/cizWguTw03uLL5FrhsiCooD330NZZKQJEj0z/GscBCiGudoK//TQJHwaEBguts6HHBjfjutydvGdbYxuqZWgazzGri01UWQc5U9F5uQqHNZHI4Km2QQ6mtoatMp5KeWi2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZPyONVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZPyONVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ECD1F00A3A;
	Wed, 26 Aug 2026 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773438;
	bh=5sX4EYF1jy9uIro8ioqvIBp0Bk/FrWD4EdLjKf0RI64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZPyONVfFnPUdry7zgorA2h5U72J6V8Aa0JFZ9UZvFv59tshCH+fn7cs4Bxpr5wNF
	 +TnPk/NTGEubcTJtWF+ueXTjAYlCELQ+gXpn/RFjYaL0p+gqQeo10GBqvQrt+r7ZK+
	 q1OfGvsl1Cqyx5+vV2ROpC9FfryKSZz+6JYCDOZW2QU4j3fhOJnVdZhs17uSQ21AXj
	 x9oTqRUGbBKwzZpfjHom5rvSZzvVM68EmUUi1vVYmnQTcnWUPWYNevZHfUEbM2h+bS
	 RhixfMP4x4/gVUedAQ4u3r0Iohdl64CY6+qixxkYiRg7wLdNbcErbtTdS3RdKEAMa0
	 /cmTs3L57hUWw==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 25/30] sysctl: bridge: use sysctl_field for br_netfilter sysctls
Date: Wed, 26 Aug 2026 21:42:29 +0200
Message-ID: <79750a1c9bc5b1bcdd86925800d4e668fde43112.1787771905.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787771905.git.legion@kernel.org>
References: <cover.1787771905.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_netfilter clones its sysctl table for each non-init network namespace
so the registration path can patch in namespace-local data pointers. The
copied table then has to be kept alive until namespace teardown only so
it can be freed after unregistering the sysctls.

Use sysctl_field to derive the br_netfilter per-net data from the
registration context instead. This keeps the sysctl descriptors static
and const, and removes the per-net table copy and unregister-time free.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/bridge/br_netfilter_hooks.c | 99 ++++++++++++---------------------
 1 file changed, 37 insertions(+), 62 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f4391..18eccde39885 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1181,43 +1181,37 @@ int brnf_sysctl_call_tables(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static struct ctl_table brnf_table[] = {
-	{
-		.procname	= "bridge-nf-call-arptables",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= brnf_sysctl_call_tables,
-	},
-	{
-		.procname	= "bridge-nf-call-iptables",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= brnf_sysctl_call_tables,
-	},
-	{
-		.procname	= "bridge-nf-call-ip6tables",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= brnf_sysctl_call_tables,
-	},
-	{
-		.procname	= "bridge-nf-filter-vlan-tagged",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= brnf_sysctl_call_tables,
-	},
-	{
-		.procname	= "bridge-nf-filter-pppoe-tagged",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= brnf_sysctl_call_tables,
-	},
-	{
-		.procname	= "bridge-nf-pass-vlan-input-dev",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= brnf_sysctl_call_tables,
-	},
+#define BRNF_DATA(field)						\
+static void *brnf_ ## field ## _data(const struct sysctl_context *ctx)	\
+{									\
+	struct brnf_net *brnet = net_generic(ctx->ns.net_ns, brnf_net_id); \
+									\
+	return &brnet->field;						\
+}
+
+BRNF_DATA(call_arptables)
+BRNF_DATA(call_iptables)
+BRNF_DATA(call_ip6tables)
+BRNF_DATA(filter_vlan_tagged)
+BRNF_DATA(filter_pppoe_tagged)
+BRNF_DATA(pass_vlan_indev)
+#undef BRNF_DATA
+
+static const struct sysctl_field brnf_table[] = {
+	SYSCTL_FIELD_CUSTOM("bridge-nf-call-arptables", 0644, sizeof(int),
+			 brnf_call_arptables_data, brnf_sysctl_call_tables),
+	SYSCTL_FIELD_CUSTOM("bridge-nf-call-iptables", 0644, sizeof(int),
+			 brnf_call_iptables_data, brnf_sysctl_call_tables),
+	SYSCTL_FIELD_CUSTOM("bridge-nf-call-ip6tables", 0644, sizeof(int),
+			 brnf_call_ip6tables_data, brnf_sysctl_call_tables),
+	SYSCTL_FIELD_CUSTOM("bridge-nf-filter-vlan-tagged", 0644, sizeof(int),
+			 brnf_filter_vlan_tagged_data,
+			 brnf_sysctl_call_tables),
+	SYSCTL_FIELD_CUSTOM("bridge-nf-filter-pppoe-tagged", 0644, sizeof(int),
+			 brnf_filter_pppoe_tagged_data,
+			 brnf_sysctl_call_tables),
+	SYSCTL_FIELD_CUSTOM("bridge-nf-pass-vlan-input-dev", 0644, sizeof(int),
+			 brnf_pass_vlan_indev_data, brnf_sysctl_call_tables),
 };
 
 static inline void br_netfilter_sysctl_default(struct brnf_net *brnf)
@@ -1232,33 +1226,18 @@ static inline void br_netfilter_sysctl_default(struct brnf_net *brnf)
 
 static int br_netfilter_sysctl_init_net(struct net *net)
 {
-	struct ctl_table *table = brnf_table;
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct brnf_net *brnet;
 
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(brnf_table), GFP_KERNEL);
-		if (!table)
-			return -ENOMEM;
-	}
-
 	brnet = net_generic(net, brnf_net_id);
-	table[0].data = &brnet->call_arptables;
-	table[1].data = &brnet->call_iptables;
-	table[2].data = &brnet->call_ip6tables;
-	table[3].data = &brnet->filter_vlan_tagged;
-	table[4].data = &brnet->filter_pppoe_tagged;
-	table[5].data = &brnet->pass_vlan_indev;
-
 	br_netfilter_sysctl_default(brnet);
 
-	brnet->ctl_hdr = register_net_sysctl_sz(net, "net/bridge", table,
-						ARRAY_SIZE(brnf_table));
-	if (!brnet->ctl_hdr) {
-		if (!net_eq(net, &init_net))
-			kfree(table);
-
+	brnet->ctl_hdr = register_sysctl_fields(&net->sysctls, "net/bridge",
+						brnf_table, &ctx);
+	if (!brnet->ctl_hdr)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -1266,11 +1245,7 @@ static int br_netfilter_sysctl_init_net(struct net *net)
 static void br_netfilter_sysctl_exit_net(struct net *net,
 					 struct brnf_net *brnet)
 {
-	const struct ctl_table *table = brnet->ctl_hdr->ctl_table_arg;
-
 	unregister_net_sysctl_table(brnet->ctl_hdr);
-	if (!net_eq(net, &init_net))
-		kfree(table);
 }
 
 static int __net_init brnf_init_net(struct net *net)
-- 
2.55.0

