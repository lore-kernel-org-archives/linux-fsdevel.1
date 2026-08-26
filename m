Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6447D461;
	Wed, 26 Aug 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773433; cv=none; b=FVoiPVJsK6ZsddoXsHdNtOZIwfhr4sSE4l2q5yZuhS+bUb5BKk9/npTb8WpYkihnjQmZpDbcf9vOWW5fCK60WyphlOCwSwn1AgmjnMv25adg0Ng4lBuUg1IcEc+jdVOuScIBUTpmYK2IhGEMEWS40PXMN91lelP2i8c/2KmKccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773433; c=relaxed/simple;
	bh=3/tkSl+Rm6AxmxG1YFc6tJTA5wNoTrzMnYoWZYyMx6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJ6bCN3SqDDzgZYIk3O/k0ceFZjyG+OrxBvPj1rH5AYwpS2AC9baDnHeGMY4cNgtIT4HulARdOZbbWyDwH0drfqwaFJuf3if8/G4SxLpb4bkCydakB1MAyLlMTdTeEWH+uapeJzdi+xLMXI38scJ8+RsiwFbOIsudor2HNQ+pRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlFg1uyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlFg1uyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE6E1F000E9;
	Wed, 26 Aug 2026 19:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773416;
	bh=YG9JUTeM8VHfg3RplgkE9skdZvncWnTp+6660YcUuqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PlFg1uyf5Mflms+UrIaBtWIerL+RR1cQKlHrSOh8yZo3D+nAATPXa9CzYFz09MtWL
	 OnuBu4oPuY/FRRN5g+qj6oKEYzaRCPT3/O7nA9s3m3h8uCG6Y48giaS9363HUKULqk
	 ykC5M6p2ObWHytuBk2BrY+PM5LjjK+PEWOfGPsXzkUeURVdJYSHim0jaiTkO4if7L2
	 MieO0gnO4e+eeesphmY5tQ7TkIPySwtMNjzTU3vXRtk905UGnTMRn3YHdC5pqepv84
	 Dore3N+W0WWvcdFZgYY1E85dxvyh3M8OJ7DwWizcIZbkLjCD2mg9oRSxV8R2fjADul
	 MJlNUJVyVWcHg==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 15/30] sysctl: net: use sysctl_field in vsock sysctls
Date: Wed, 26 Aug 2026 21:42:19 +0200
Message-ID: <e3333c3450f095fae22eb6af773619828908496c.1787771905.git.legion@kernel.org>
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

The vsock sysctl table is cloned for every non-init network namespace
only to bind the entries to that namespace's vsock state. The custom
mode handlers already derive the namespace from the data pointer, so the
table clone is just per-net storage for otherwise static descriptors.

Use sysctl_field descriptors so the data pointers are derived from the
registration context. This keeps the table const and removes the per-net
allocation, pointer patching, and free path.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/vmw_vsock/af_vsock.c | 91 ++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 44037b066a5f..74af67e01430 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2875,71 +2875,52 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 	return 0;
 }
 
-static struct ctl_table vsock_table[] = {
-	{
-		.procname	= "ns_mode",
-		.data		= &init_net.vsock.mode,
-		.maxlen		= VSOCK_NET_MODE_STR_MAX,
-		.mode		= 0444,
-		.proc_handler	= vsock_net_mode_string
-	},
-	{
-		.procname	= "child_ns_mode",
-		.data		= &init_net.vsock.child_ns_mode,
-		.maxlen		= VSOCK_NET_MODE_STR_MAX,
-		.mode		= 0644,
-		.proc_handler	= vsock_net_child_mode_string
-	},
-	{
-		.procname	= "g2h_fallback",
-		.data		= &init_net.vsock.g2h_fallback,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-};
+#ifdef CONFIG_SYSCTL
+static void *vsock_net_mode_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->vsock.mode;
+}
 
-static int __net_init vsock_sysctl_register(struct net *net)
+static void *vsock_net_child_mode_data(const struct sysctl_context *ctx)
 {
-	struct ctl_table *table;
+	return &ctx->ns.net_ns->vsock.child_ns_mode;
+}
 
-	if (net_eq(net, &init_net)) {
-		table = vsock_table;
-	} else {
-		table = kmemdup(vsock_table, sizeof(vsock_table), GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
+static int *vsock_g2h_fallback_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->vsock.g2h_fallback;
+}
 
-		table[0].data = &net->vsock.mode;
-		table[1].data = &net->vsock.child_ns_mode;
-		table[2].data = &net->vsock.g2h_fallback;
-	}
+static const struct sysctl_field vsock_table[] = {
+	SYSCTL_FIELD_CUSTOM("ns_mode", 0444, VSOCK_NET_MODE_STR_MAX,
+			    vsock_net_mode_data, vsock_net_mode_string),
+	SYSCTL_FIELD_CUSTOM("child_ns_mode", 0644, VSOCK_NET_MODE_STR_MAX,
+			    vsock_net_child_mode_data,
+			    vsock_net_child_mode_string),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("g2h_fallback", 0644,
+				       vsock_g2h_fallback_data,
+				       SYSCTL_ZERO, SYSCTL_ONE),
+};
+
+static int __net_init vsock_sysctl_register(struct net *net)
+{
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 
-	net->vsock.sysctl_hdr = register_net_sysctl_sz(net, "net/vsock", table,
-						       ARRAY_SIZE(vsock_table));
+	net->vsock.sysctl_hdr = register_sysctl_fields(&net->sysctls, "net/vsock",
+						       vsock_table, &ctx);
 	if (!net->vsock.sysctl_hdr)
-		goto err_reg;
+		return -ENOMEM;
 
 	return 0;
-
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
-	return -ENOMEM;
 }
-
-static void vsock_sysctl_unregister(struct net *net)
+#else
+static int __net_init vsock_sysctl_register(struct net *net)
 {
-	const struct ctl_table *table;
-
-	table = net->vsock.sysctl_hdr->ctl_table_arg;
-	unregister_net_sysctl_table(net->vsock.sysctl_hdr);
-	if (!net_eq(net, &init_net))
-		kfree(table);
+	return 0;
 }
+#endif
 
 static void vsock_net_init(struct net *net)
 {
@@ -2965,7 +2946,7 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
 
 static __net_exit void vsock_sysctl_exit_net(struct net *net)
 {
-	vsock_sysctl_unregister(net);
+	unregister_net_sysctl_table(net->vsock.sysctl_hdr);
 }
 
 static struct pernet_operations vsock_sysctl_ops = {
-- 
2.55.0

