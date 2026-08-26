Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42F238166;
	Wed, 26 Aug 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773420; cv=none; b=rHrjB3lE0wTIVbV6PF8BV3JhvgwF5izpc9KYnb0+6ZFp9SM/NrLtOuZXQr7wzaI60F9Y3mqgwzvDqCI/Gu9oH6I+HtNQtmf6enVTFqpgms56iPPl7qqtfbjFL+a1HGCfLYyMvQEvxM90EHK09gMZLik+Pjn68kV9VqQxlf+OXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773420; c=relaxed/simple;
	bh=8ST1562x/031b5eKE9OwzUTtPnmqoB3UyXdJuHmOZ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bStXBAZ8JXVNVpDyr4fFSxS/OELRYW9eNPzy2ziUhgQIf1Kd14fiJARz431LmkCNOnI8z/7QHqrrBMthl1ZcFT+0LEYGYHnmfVz2J3aJzgfp2bJNYFtzVt8jFuemSuCvadF8fTnKhVV3lL5jnYK7D6Wy1y4iJ+iqfu3LtD3K6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/xqGggD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/xqGggD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884211F0155A;
	Wed, 26 Aug 2026 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773411;
	bh=Q22I+Wp2vo1EQbuzN+2qIofbbMnBekjDGSjV/k5b0Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k/xqGggDGFDW0J+VheeNjdPdM5NWjv7K9HK52eLwdjLLANSatlAVyskGa0jPbZ2LG
	 6wBRDIbQ8BRq0O/wB3vfdtx/IW3OFPCPeOZD8HtxWlO9cMtcN/nK0UcDgz7v3HeyVl
	 k81Tr+JLuvP7VGlNOwbLmSxQPR1dg69ZwY93zd+W+3qhq9VpOIex3Dgl7oasZ8T5Ga
	 1y5zXrLunBj2CFt7x4RKZhFAwVQQc5XnQMaiCuo62CC8D7edAdFlS43xrYv+yuTWvC
	 DVOeCTLGwz72y9XKFX6W/BTkznIHpnSQ/mriNoN9y2/Wtc+kUWXMk0BQtHD/0Rg2Bu
	 Xf2sNs7vMXDSA==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 13/30] sysctl: net: use sysctl_field in IPv6 fragment sysctls
Date: Wed, 26 Aug 2026 21:42:17 +0200
Message-ID: <e3c4b49012ac2081008929482b6d18796d98214a.1787771905.git.legion@kernel.org>
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

The IPv6 fragment sysctl tables are cloned for every non-init network
namespace only to bind the entries to that namespace's fqdir. The clone
also has to patch the low/high threshold limits through extra1 and
extra2 before registration.

Use sysctl_field descriptors for the IPv6 fragment and conntrack
fragment sysctls. The data and limit pointers are derived from the
registration context, so the tables can stay const and the per-net
allocation, pointer patching, and free paths are no longer needed.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 77 ++++++++++---------------
 net/ipv6/reassembly.c                   | 77 ++++++++++---------------
 2 files changed, 60 insertions(+), 94 deletions(-)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 64ab23ff559b..f9785d9bd8f3 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -43,73 +43,56 @@ static struct nft_ct_frag6_pernet *nf_frag_pernet(struct net *net)
 
 #ifdef CONFIG_SYSCTL
 
-static struct ctl_table nf_ct_frag6_sysctl_table[] = {
-	{
-		.procname	= "nf_conntrack_frag6_timeout",
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "nf_conntrack_frag6_low_thresh",
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "nf_conntrack_frag6_high_thresh",
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
+static void *nf_ct_frag6_timeout_data(const struct sysctl_context *ctx)
+{
+	return &nf_frag_pernet(ctx->ns.net_ns)->fqdir->timeout;
+}
+
+static unsigned long *nf_ct_frag6_low_thresh_data(const struct sysctl_context *ctx)
+{
+	return &nf_frag_pernet(ctx->ns.net_ns)->fqdir->low_thresh;
+}
+
+static unsigned long *nf_ct_frag6_high_thresh_data(const struct sysctl_context *ctx)
+{
+	return &nf_frag_pernet(ctx->ns.net_ns)->fqdir->high_thresh;
+}
+
+static const struct sysctl_field nf_ct_frag6_sysctl_table[] = {
+	SYSCTL_FIELD_CUSTOM("nf_conntrack_frag6_timeout", 0644, sizeof(unsigned int),
+			 nf_ct_frag6_timeout_data, proc_dointvec_jiffies),
+	SYSCTL_FIELD_ULONG_MINMAX("nf_conntrack_frag6_low_thresh", 0644,
+			       nf_ct_frag6_low_thresh_data, NULL,
+			       nf_ct_frag6_high_thresh_data),
+	SYSCTL_FIELD_ULONG_MINMAX("nf_conntrack_frag6_high_thresh", 0644,
+			       nf_ct_frag6_high_thresh_data,
+			       nf_ct_frag6_low_thresh_data, NULL),
 };
 
 static int nf_ct_frag6_sysctl_register(struct net *net)
 {
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct nft_ct_frag6_pernet *nf_frag;
-	struct ctl_table *table;
 	struct ctl_table_header *hdr;
 
-	table = nf_ct_frag6_sysctl_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(nf_ct_frag6_sysctl_table),
-				GFP_KERNEL);
-		if (table == NULL)
-			goto err_alloc;
-	}
-
 	nf_frag = nf_frag_pernet(net);
 
-	table[0].data	= &nf_frag->fqdir->timeout;
-	table[1].data	= &nf_frag->fqdir->low_thresh;
-	table[1].extra2	= &nf_frag->fqdir->high_thresh;
-	table[2].data	= &nf_frag->fqdir->high_thresh;
-	table[2].extra1	= &nf_frag->fqdir->low_thresh;
-
-	hdr = register_net_sysctl_sz(net, "net/netfilter", table,
-				     ARRAY_SIZE(nf_ct_frag6_sysctl_table));
+	hdr = register_sysctl_fields(&net->sysctls, "net/netfilter",
+				     nf_ct_frag6_sysctl_table, &ctx);
 	if (hdr == NULL)
-		goto err_reg;
+		return -ENOMEM;
 
 	nf_frag->nf_frag_frags_hdr = hdr;
 	return 0;
-
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
-	return -ENOMEM;
 }
 
 static void __net_exit nf_ct_frags6_sysctl_unregister(struct net *net)
 {
 	struct nft_ct_frag6_pernet *nf_frag = nf_frag_pernet(net);
-	const struct ctl_table *table;
 
-	table = nf_frag->nf_frag_frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(nf_frag->nf_frag_frags_hdr);
-	if (!net_eq(net, &init_net))
-		kfree(table);
 }
 
 #else
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 11f9144bebbe..87bd9e1efbb3 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -424,25 +424,30 @@ static const struct inet6_protocol frag_protocol = {
 
 #ifdef CONFIG_SYSCTL
 
-static struct ctl_table ip6_frags_ns_ctl_table[] = {
-	{
-		.procname	= "ip6frag_high_thresh",
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "ip6frag_low_thresh",
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "ip6frag_time",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+static unsigned long *ip6_frags_high_thresh_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ipv6.fqdir->high_thresh;
+}
+
+static unsigned long *ip6_frags_low_thresh_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ipv6.fqdir->low_thresh;
+}
+
+static void *ip6_frags_timeout_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->ipv6.fqdir->timeout;
+}
+
+static const struct sysctl_field ip6_frags_ns_ctl_table[] = {
+	SYSCTL_FIELD_ULONG_MINMAX("ip6frag_high_thresh", 0644,
+			       ip6_frags_high_thresh_data,
+			       ip6_frags_low_thresh_data, NULL),
+	SYSCTL_FIELD_ULONG_MINMAX("ip6frag_low_thresh", 0644,
+			       ip6_frags_low_thresh_data,
+			       NULL, ip6_frags_high_thresh_data),
+	SYSCTL_FIELD_CUSTOM("ip6frag_time", 0644, sizeof(int),
+			 ip6_frags_timeout_data, proc_dointvec_jiffies),
 };
 
 /* secret interval has been deprecated */
@@ -459,45 +464,23 @@ static struct ctl_table ip6_frags_ctl_table[] = {
 
 static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
 {
-	struct ctl_table *table;
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct ctl_table_header *hdr;
 
-	table = ip6_frags_ns_ctl_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(ip6_frags_ns_ctl_table), GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
-
-	}
-	table[0].data	= &net->ipv6.fqdir->high_thresh;
-	table[0].extra1	= &net->ipv6.fqdir->low_thresh;
-	table[1].data	= &net->ipv6.fqdir->low_thresh;
-	table[1].extra2	= &net->ipv6.fqdir->high_thresh;
-	table[2].data	= &net->ipv6.fqdir->timeout;
-
-	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
-				     ARRAY_SIZE(ip6_frags_ns_ctl_table));
+	hdr = register_sysctl_fields(&net->sysctls, "net/ipv6",
+				     ip6_frags_ns_ctl_table, &ctx);
 	if (!hdr)
-		goto err_reg;
+		return -ENOMEM;
 
 	net->ipv6.sysctl.frags_hdr = hdr;
 	return 0;
-
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
-	return -ENOMEM;
 }
 
 static void __net_exit ip6_frags_ns_sysctl_unregister(struct net *net)
 {
-	const struct ctl_table *table;
-
-	table = net->ipv6.sysctl.frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv6.sysctl.frags_hdr);
-	if (!net_eq(net, &init_net))
-		kfree(table);
 }
 
 static struct ctl_table_header *ip6_ctl_header;
-- 
2.55.0

