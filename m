Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB743955C6;
	Wed, 26 Aug 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773421; cv=none; b=oRIEuOdHcO9GWc2LPK+NXB8gEhv/PXRZiZP4LVF+i31NMeiH/q17UUpX5xditc1gelVmO6/3WGju4nBZXBXI+JhHZLpKw7RlwpogW1gpD+J4CfwyakSEpJ0S+GZxaIyZMxHVWy4mC0gQi/o1Mn3LpiBiWcyxOwgTC+rJwL0pcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773421; c=relaxed/simple;
	bh=D5Jr0k6D/Oi0HcyoURRJriST6YNa6raH6CwzNUiEtDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQ0kHIhjCaNt4bBaVQbpSvnJzcKTqWQZtePVly6bSqStQYbmP7gAmScC1hdr2lj8k3m+V9u+Oq2jKSgJEENdqgoiPdjcd8Nr8s7g0jCxlCVXMPgxYHMJBlRvBQEbKvBO80GM8OekwuuCYNqLlIMN9qvfWacwRuLO6hUpOlC6FYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJWABkPc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJWABkPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998021F00ADB;
	Wed, 26 Aug 2026 19:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773403;
	bh=cRoLcH3zZrPQ16O+Me0k1vwpm1zfoNoeWzlLQ3RN8Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LJWABkPcw+pL5uO6VeANqfvFUhZHMSuUyRSDahsK8r/tz/FU5/igRF7RPN12U21CS
	 xJQEWu3BdDNxEcKjWTy2Rnw9VCFxw0Nd7I7dvLsIOKhGyMfiFwmAbGb0PV+qSh+1Z+
	 WlxHcdo/nwAoBtASXVgv/SLD+EKNSxl6dwElLKoo3veICMV4Fvoq4H3MF99F51HP9+
	 OWa2p56f8JgTHp3yPjNUHWL60HcB2oRRHejNTwephyK31rHsTbQTtocizXh1xnBaUe
	 IH7/1EWHLXzTtxDD5K/MG5UeaSa4NxHNld0qOH/aIcy1g0rujhTV6L65nVIJDbUGb2
	 yR/xL5irzk3mw==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 12/30] sysctl: net: use sysctl_field in IPv6 xfrm sysctls
Date: Wed, 26 Aug 2026 21:42:16 +0200
Message-ID: <c2f875e9200cceda4ca23bf1a2fc11df6f5336ef.1787771905.git.legion@kernel.org>
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

The IPv6 xfrm sysctl table is cloned for every non-init network
namespace only to rebind the xfrm6_gc_thresh data pointer. The
descriptor itself is static and does not need per-net storage.

Use a sysctl_field descriptor so the data pointer is derived from the
network namespace registration context. This keeps the table const
and removes the per-net allocation and free path.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/ipv6/xfrm6_policy.c | 48 +++++++++++------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 125ea9a5b8a0..3df9872100c8 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -186,56 +186,34 @@ static void xfrm6_policy_fini(void)
 }
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table xfrm6_policy_table[] = {
-	{
-		.procname       = "xfrm6_gc_thresh",
-		.data		= &init_net.xfrm.xfrm6_dst_ops.gc_thresh,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler   = proc_dointvec,
-	},
+static int *xfrm6_gc_thresh_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->xfrm.xfrm6_dst_ops.gc_thresh;
+}
+
+static const struct sysctl_field xfrm6_policy_table[] = {
+	SYSCTL_FIELD_INT("xfrm6_gc_thresh", 0644, xfrm6_gc_thresh_data),
 };
 
 static int __net_init xfrm6_net_sysctl_init(struct net *net)
 {
-	struct ctl_table *table;
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct ctl_table_header *hdr;
 
-	table = xfrm6_policy_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(xfrm6_policy_table), GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
-
-		table[0].data = &net->xfrm.xfrm6_dst_ops.gc_thresh;
-	}
-
-	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
-				     ARRAY_SIZE(xfrm6_policy_table));
+	hdr = register_sysctl_fields(&net->sysctls, "net/ipv6",
+				     xfrm6_policy_table, &ctx);
 	if (!hdr)
-		goto err_reg;
+		return -ENOMEM;
 
 	net->ipv6.sysctl.xfrm6_hdr = hdr;
 	return 0;
-
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
-	return -ENOMEM;
 }
 
 static void __net_exit xfrm6_net_sysctl_exit(struct net *net)
 {
-	const struct ctl_table *table;
-
-	if (!net->ipv6.sysctl.xfrm6_hdr)
-		return;
-
-	table = net->ipv6.sysctl.xfrm6_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv6.sysctl.xfrm6_hdr);
-	if (!net_eq(net, &init_net))
-		kfree(table);
 }
 #else /* CONFIG_SYSCTL */
 static inline int xfrm6_net_sysctl_init(struct net *net)
-- 
2.55.0

