Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2647D921;
	Wed, 26 Aug 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773436; cv=none; b=D4Z/6KwSswIZtEKLXMfjybIicG3Qbw+oIBKDS0I6ctnbor+Qem9+cmDnwkA6b1fVFzNKfocQRIcSIj/9tWgcGfMwgUhLoH7oM/53+8pDz3mWHMhaibA/nWDW4me+0L4YHfEh5EgWnjTy0VyXSwJ5go0cZAxpU/iUnEdkWUTNkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773436; c=relaxed/simple;
	bh=sI/kUyzXktlix9nYygIoWOyiQtgSbyP8k4gLCQUEr7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8+2+a2t6g8DHXXpeBqixApwGyyxljmGhBOqFjmQNnIw9IGiJnV7+t+csSSvRLLd0Gz3B3J+bJ434XxPE9NtHkqkXvyrjjoU7IIG0MtX9jg5a1YUpUjD3UNIqd2uWNiX/ZaoNA9KIQOhO+YZorTAEvCRl5j+7M88yO3GJhmRbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlt2/cYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlt2/cYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B23A1F00A3A;
	Wed, 26 Aug 2026 19:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773414;
	bh=gSuXrvV4dEgJxnM7786wKmbirUdP6SvJDcxQS5c9d4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qlt2/cYFJFP+ruAcvyBzALxnhgRUlKhD3X4mUj2elfJJCGQqYfpmpcvtnjPqcInFK
	 UF6dXNUhkNT/R7jWzTC2rw+BZlZvMhvlABqhmCnKScyQ6EQjPssGkt7SzLGniBulDn
	 558Lv0/aAiU9zyyZEcc/bAwr5f85Pho2X5d38A2sNjczakzQ3zmzblMKiDXDcixtpY
	 QedzeCltFfqAPJzLoEw+kbrKrOY/IS57dyu38YyBe5Kffo+ZpLjH3mzrDor11zKxGq
	 +PHKESc8+eXU++wJBr/CbejwYkC4z0DMTdCRf45q5g8gsO2p2EbN6zWTSa+2ZFeHRG
	 KHlx0K3JvH6OQ==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 14/30] sysctl: net: use sysctl_field in 6lowpan fragment sysctls
Date: Wed, 26 Aug 2026 21:42:18 +0200
Message-ID: <7a92871913e86a8ce79bbb4e3e440f3b00e3df86.1787771905.git.legion@kernel.org>
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

The 6lowpan fragment sysctl table is cloned for every non-init network
namespace only to bind the entries to that namespace's fqdir. The clone
also has to patch the low/high threshold limits through extra1 and
extra2 before registration.

Use sysctl_field descriptors so the data and limit pointers are derived
from the registration context. This keeps the table const and removes
the per-net allocation, pointer patching, and free path while preserving
the existing unprivileged net namespace visibility rule.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/ieee802154/6lowpan/reassembly.c | 84 ++++++++++++-----------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index ddb6a5817d09..c54e50a213f4 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -326,25 +326,30 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 
 #ifdef CONFIG_SYSCTL
 
-static struct ctl_table lowpan_frags_ns_ctl_table[] = {
-	{
-		.procname	= "6lowpanfrag_high_thresh",
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "6lowpanfrag_low_thresh",
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "6lowpanfrag_time",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
+static unsigned long *lowpan_frags_high_thresh_data(const struct sysctl_context *ctx)
+{
+	return &net_ieee802154_lowpan(ctx->ns.net_ns)->fqdir->high_thresh;
+}
+
+static unsigned long *lowpan_frags_low_thresh_data(const struct sysctl_context *ctx)
+{
+	return &net_ieee802154_lowpan(ctx->ns.net_ns)->fqdir->low_thresh;
+}
+
+static void *lowpan_frags_timeout_data(const struct sysctl_context *ctx)
+{
+	return &net_ieee802154_lowpan(ctx->ns.net_ns)->fqdir->timeout;
+}
+
+static const struct sysctl_field lowpan_frags_ns_ctl_table[] = {
+	SYSCTL_FIELD_ULONG_MINMAX("6lowpanfrag_high_thresh", 0644,
+			       lowpan_frags_high_thresh_data,
+			       lowpan_frags_low_thresh_data, NULL),
+	SYSCTL_FIELD_ULONG_MINMAX("6lowpanfrag_low_thresh", 0644,
+			       lowpan_frags_low_thresh_data,
+			       NULL, lowpan_frags_high_thresh_data),
+	SYSCTL_FIELD_CUSTOM("6lowpanfrag_time", 0644, sizeof(int),
+			 lowpan_frags_timeout_data, proc_dointvec_jiffies),
 };
 
 /* secret interval has been deprecated */
@@ -361,55 +366,32 @@ static struct ctl_table lowpan_frags_ctl_table[] = {
 
 static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 {
-	struct ctl_table *table;
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	struct ctl_table_header *hdr;
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
-	size_t table_size = ARRAY_SIZE(lowpan_frags_ns_ctl_table);
-
-	table = lowpan_frags_ns_ctl_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(lowpan_frags_ns_ctl_table),
-				GFP_KERNEL);
-		if (table == NULL)
-			goto err_alloc;
-
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
-			table_size = 0;
-	}
 
-	table[0].data	= &ieee802154_lowpan->fqdir->high_thresh;
-	table[0].extra1	= &ieee802154_lowpan->fqdir->low_thresh;
-	table[1].data	= &ieee802154_lowpan->fqdir->low_thresh;
-	table[1].extra2	= &ieee802154_lowpan->fqdir->high_thresh;
-	table[2].data	= &ieee802154_lowpan->fqdir->timeout;
+	/* Don't export sysctls to unprivileged users */
+	if (!net_eq(net, &init_net) && net->user_ns != &init_user_ns)
+		return 0;
 
-	hdr = register_net_sysctl_sz(net, "net/ieee802154/6lowpan", table,
-				     table_size);
+	hdr = register_sysctl_fields(&net->sysctls, "net/ieee802154/6lowpan",
+				     lowpan_frags_ns_ctl_table, &ctx);
 	if (hdr == NULL)
-		goto err_reg;
+		return -ENOMEM;
 
 	ieee802154_lowpan->sysctl.frags_hdr = hdr;
 	return 0;
-
-err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-err_alloc:
-	return -ENOMEM;
 }
 
 static void __net_exit lowpan_frags_ns_sysctl_unregister(struct net *net)
 {
-	const struct ctl_table *table;
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
 
-	table = ieee802154_lowpan->sysctl.frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(ieee802154_lowpan->sysctl.frags_hdr);
-	if (!net_eq(net, &init_net))
-		kfree(table);
 }
 
 static struct ctl_table_header *lowpan_ctl_header;
-- 
2.55.0

