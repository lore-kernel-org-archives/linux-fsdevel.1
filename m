Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B80477E34;
	Wed, 26 Aug 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773408; cv=none; b=V0uaOo11AFUvxWyZ5Xlzuyqw/LvgU94USeTr1RlPaMDy+89iUXgwOiirF9WOMLfMqA0zhhiy02wQQb7ecrcuF/wuan4oV5ANTshte5Y0WBEq5Or+8fRYzMm3PstxbLwrO4wzY5CkYGr3CWtQHAtPg85N2r8QVdm3CBZ7MS5dNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773408; c=relaxed/simple;
	bh=ZpqbVeZzYanrINP3LVJnnmUExciqPtAbyNjfc7+28CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=It7NkS1+hP7rwR2QBPrepUGv7Y2CSjpKFyG8eSNhiCdW9zgDUHWqVIe+5CmRCGJweYTLnwBNQhiHGsZxH+6Fd+n1L4/xQTka2C+OrpEcqgWZ1KeclMGyEJF9RYvSVriz0pF8N4hvbmnBIlcxjAaLXoPTFymMrLBEawhIY8NOYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBQNavea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBQNavea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B186D1F000E9;
	Wed, 26 Aug 2026 19:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773395;
	bh=FFRBMh2gD+Dazm6QlWDbY4cg73OHWjcX87J7DKf4bHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SBQNaveafvpUKiWzQVoTBXQ3ecZeSVN9u034D6pZCwSQ8D7egiDa2lAJz2AMVBWu6
	 g0SFK0o8cUOFdxKslKgD0K6qNXx8G+WoIoZ8IN2TfBDKud+XBc5K8VC1iJem4x4gxp
	 m7Rf12wdg4kr1fXNYr9GzkHxwW6CEXpeKjBzvgEDtpytedB7Bttq8idvKCwPTCxt7G
	 aHa4pRRl+fewkbWwXtbLzOOHskCPMF5XSBgmkayh9lgoLxs+VTnRBv6wa2m79nm3Xf
	 qiTnh6bMtRbWwYoS08lRgK4b8FaM7v9VfLWy/acBTsk07QE+3pGT7lomODSkv6R0zq
	 aUASZobiGLiIg==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 08/30] sysctl: net: use sysctl_field in unix sysctl
Date: Wed, 26 Aug 2026 21:42:12 +0200
Message-ID: <039a9cacb041d90d2466eec7048a239920771863.1787771905.git.legion@kernel.org>
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

The unix sysctl table is cloned for non-init network namespaces only to
replace the data pointer with per-net storage. That keeps a mutable
ctl_table copy alive for each namespace even though the descriptor
itself is otherwise static.

Add a netns-aware sysctl_field registration helper and use it for the
unix sysctl table. The data pointer is derived from the registration
context, so the table can stay const and the per-net clone and free path
are no longer needed.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/sysctl.h     |  2 ++
 net/unix/sysctl_net_unix.c | 48 +++++++++++---------------------------
 2 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 056d10f4ab3d..bbdb0fcfbcd4 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -38,6 +38,7 @@ struct nsproxy;
 struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
+struct net;
 struct ipc_namespace;
 struct pid_namespace;
 struct user_namespace;
@@ -94,6 +95,7 @@ struct sysctl_context {
 		struct user_namespace *user_ns;
 		struct ipc_namespace *ipc_ns;
 		struct pid_namespace *pid_ns;
+		struct net *net_ns;
 	} ns;
 };
 
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index e02ed6e3955c..fc6687f9eaf4 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -5,58 +5,36 @@
  * Authors:	Mike Shaver.
  */
 
-#include <linux/slab.h>
-#include <linux/string.h>
 #include <linux/sysctl.h>
 #include <net/af_unix.h>
 #include <net/net_namespace.h>
 
 #include "af_unix.h"
 
-static struct ctl_table unix_table[] = {
-	{
-		.procname	= "max_dgram_qlen",
-		.data		= &init_net.unx.sysctl_max_dgram_qlen,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
+static int *unix_max_dgram_qlen_data(const struct sysctl_context *ctx)
+{
+	return &ctx->ns.net_ns->unx.sysctl_max_dgram_qlen;
+}
+
+static const struct sysctl_field unix_table[] = {
+	SYSCTL_FIELD_INT("max_dgram_qlen", 0644, unix_max_dgram_qlen_data),
 };
 
 int __net_init unix_sysctl_register(struct net *net)
 {
-	struct ctl_table *table;
-
-	if (net_eq(net, &init_net)) {
-		table = unix_table;
-	} else {
-		table = kmemdup(unix_table, sizeof(unix_table), GFP_KERNEL);
-		if (!table)
-			goto err_alloc;
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 
-		table[0].data = &net->unx.sysctl_max_dgram_qlen;
-	}
-
-	net->unx.ctl = register_net_sysctl_sz(net, "net/unix", table,
-					      ARRAY_SIZE(unix_table));
+	net->unx.ctl = register_sysctl_fields(&net->sysctls, "net/unix",
+					      unix_table, &ctx);
 	if (net->unx.ctl == NULL)
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
 
 void unix_sysctl_unregister(struct net *net)
 {
-	const struct ctl_table *table;
-
-	table = net->unx.ctl->ctl_table_arg;
 	unregister_net_sysctl_table(net->unx.ctl);
-	if (!net_eq(net, &init_net))
-		kfree(table);
 }
-- 
2.55.0

