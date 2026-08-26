Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6147DD79;
	Wed, 26 Aug 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773408; cv=none; b=DxTU0f6O6Fnh6mcfHyRQOO8aEN6kpYFsNpPcf89QHgsDHj/WVYAsXsERzVjeq1pn07lJ8CD6aaMadRxeS21aNnfslV/18D5MjgO6fU+ovEo3Dzxea1VpJjjmktSv71n0N8Ck5RD0qbP4Pv/JzqZCJijXWOT4sRJyxu7/tgLZBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773408; c=relaxed/simple;
	bh=M4xXVGuEyYSADViB2xXNehGgzQvDAzHyhyQxE/8MBW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOE6vjjkkkST7vgo2NwVdB78tkEt6greEUBuD2cJGwpX1e7EchRKtalVf7+Bb1AzEsY7NbmOm5smbAH4Z+WilkLfYUY6M/bDYpN/Vtan0/4GQKuS3DELeWUbC9NE0IKZHevdEiM8FgprhNoGhqr5UA7eEqv+I6PRSs1d5lgp/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBfSpyA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBfSpyA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE7E1F00ACF;
	Wed, 26 Aug 2026 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773397;
	bh=cK3qlZufeoDK+clSOnP3AqQ5pBHmcEqBxRsLto2CqXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CBfSpyA5dtNZmVhBd6bMSswSsFbJwYFTIAhDfeN/h675ORjbTlC/HphJBj4zln6RH
	 JXk83cxIXOXv8YkS5pV97dLOUvwFXlUSTWXQc9EsUUgnZI8SxKL/hksTZao+NwMO6o
	 JPEubVVDmaKtW6hr4b4GFFhHkRXdm0a9yNe+hXVZ5/Tyd2zAoup3PIgwKoIZMzwm5Z
	 XsEzBUga0ABYIjNUFBqB55QV0DtugHUk4NTuNbqlstvZLiV1Leyk/e0iSPl6y1cZ2B
	 gjsQKUUDnUw05l7Jv3W01dZp0+SvEgRRkOvGV5N9xJ9aATN/DeS3DYYJQS5XPWVxkj
	 c7S2DU26kwAag==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 09/30] sysctl: net: use sysctl_field in xfrm sysctls
Date: Wed, 26 Aug 2026 21:42:13 +0200
Message-ID: <accaf54c772bc10dc44e2716047ecb74d29ba95d.1787771905.git.legion@kernel.org>
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

The xfrm sysctl table is cloned for each network namespace only to
replace data pointers with per-net storage. The descriptors are
otherwise static, while unprivileged network namespaces still register
an empty table to preserve the existing visibility rule.

Use sysctl_field accessors to derive the per-net storage from the
registration context instead. This keeps the xfrm descriptors const and
removes the per-net ctl_table allocation and free path without changing
which sysctls are exposed.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/xfrm/xfrm_sysctl.c | 77 ++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index ca003e8a0376..1097dd4dc0dc 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/sysctl.h>
-#include <linux/slab.h>
 #include <net/net_namespace.h>
 #include <net/xfrm.h>
 
@@ -13,71 +12,55 @@ static void __net_init __xfrm_sysctl_init(struct net *net)
 }
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table xfrm_table[] = {
-	{
-		.procname	= "xfrm_aevent_etime",
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec
-	},
-	{
-		.procname	= "xfrm_aevent_rseqth",
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec
-	},
-	{
-		.procname	= "xfrm_larval_drop",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "xfrm_acq_expires",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
+#define XFRM_UINT_DATA(name)						\
+static unsigned int *xfrm_ ## name ## _data(const struct sysctl_context *ctx) \
+{									\
+	return &ctx->ns.net_ns->xfrm.name;				\
+}
+
+#define XFRM_INT_DATA(name)						\
+static int *xfrm_ ## name ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->xfrm.name;				\
+}
+
+XFRM_UINT_DATA(sysctl_aevent_etime)
+XFRM_UINT_DATA(sysctl_aevent_rseqth)
+XFRM_INT_DATA(sysctl_larval_drop)
+XFRM_INT_DATA(sysctl_acq_expires)
+
+static const struct sysctl_field xfrm_table[] = {
+	SYSCTL_FIELD_UINT("xfrm_aevent_etime", 0644, xfrm_sysctl_aevent_etime_data),
+	SYSCTL_FIELD_UINT("xfrm_aevent_rseqth", 0644, xfrm_sysctl_aevent_rseqth_data),
+	SYSCTL_FIELD_INT("xfrm_larval_drop", 0644, xfrm_sysctl_larval_drop_data),
+	SYSCTL_FIELD_INT("xfrm_acq_expires", 0644, xfrm_sysctl_acq_expires_data),
 };
 
 int __net_init xfrm_sysctl_init(struct net *net)
 {
-	struct ctl_table *table;
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	size_t table_size = ARRAY_SIZE(xfrm_table);
 
 	__xfrm_sysctl_init(net);
 
-	table = kmemdup(xfrm_table, sizeof(xfrm_table), GFP_KERNEL);
-	if (!table)
-		goto out_kmemdup;
-	table[0].data = &net->xfrm.sysctl_aevent_etime;
-	table[1].data = &net->xfrm.sysctl_aevent_rseqth;
-	table[2].data = &net->xfrm.sysctl_larval_drop;
-	table[3].data = &net->xfrm.sysctl_acq_expires;
-
 	/* Don't export sysctls to unprivileged users */
 	if (net->user_ns != &init_user_ns)
 		table_size = 0;
 
-	net->xfrm.sysctl_hdr = register_net_sysctl_sz(net, "net/core", table,
-						      table_size);
+	net->xfrm.sysctl_hdr = __register_sysctl_fields(&net->sysctls, "net/core",
+							xfrm_table, table_size,
+							&ctx, sizeof(ctx));
 	if (!net->xfrm.sysctl_hdr)
-		goto out_register;
-	return 0;
+		return -ENOMEM;
 
-out_register:
-	kfree(table);
-out_kmemdup:
-	return -ENOMEM;
+	return 0;
 }
 
 void __net_exit xfrm_sysctl_fini(struct net *net)
 {
-	const struct ctl_table *table;
-
-	table = net->xfrm.sysctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->xfrm.sysctl_hdr);
-	kfree(table);
 }
 #else
 int __net_init xfrm_sysctl_init(struct net *net)
-- 
2.55.0

