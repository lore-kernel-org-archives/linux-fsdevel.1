Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC1383337
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779527479; cv=none; b=O8fe8j3gVlp2Ub6UnBG4WskPHDnkzlPECLEKcmJjSQ0bnF0Jjn+OjSg1q7FjgeRNPPO5ihyGwxKcUsS3tUvOWXunCMeQT4xIBHRo2NF3xPaglJAMGaMun1n1KGh+nEC0YWgJSHQ6RGGpG61+Iw54yzxEJd1Ux5OvrO9DbXlxPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779527479; c=relaxed/simple;
	bh=+6XWZLSwAFoEUg5RV++uOlpGIqHwmN4U8a5uZuhpo9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8hlubeQhEH9fgR0Nr8Un+ORoqBWTwE3kwcHxT3KPZiSaysCCx7xDpAYcKn7H8bGVAeEkLDu5ATfRV6eoR2zxc6fmJ0vhPqGes7VlJFpf6lj1B1RzU9dvGTWEHbEDQonJCdZA28c4H+alJ+8FFC8A0oJzDxdxXqSp9tRxacBkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvOqF53I; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvOqF53I"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-366330b6751so6380637a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779527475; x=1780132275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=klr/LoAsJ5dhO7nmwcabFkbvj22O90F2obfI9mlsW8M=;
        b=dvOqF53I/RkI/m7kPAsrVEfMDNcvQpVSNFxJMh9LNH9u3yuc09S7y5lRcJCwsp81dr
         Ew/ekHSf2+Xfur+zRgeDE8FEhRNOxk9roiYnkEUl8wwUVNpqFAvcGW0oJ6WlyTpsMkvS
         zbsB/9n0icAjSunBes4RJUFPi03Nlf/JO6uJAHpHZvpXGnvBQvMBWqDTy+YrqtIKdj6r
         4pBfcNsgBfBexOcS4vMAP+mLSNi4EFNMbzuheB7FLnT10tW6UfsOy24dIZuGhiL8D3BT
         ZWKD1Oz7PF4HTdmbZKbJokKHooMwyHZnL0zfmH37uKZXq5LO/0uPsUWGlIWmAOrICSbQ
         esqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779527475; x=1780132275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klr/LoAsJ5dhO7nmwcabFkbvj22O90F2obfI9mlsW8M=;
        b=pUnI5ucpHK11HtrFYxRrq38f92avf2jeR6vdu6UY/PxEg+cAqXaFEK1raB85gv6j84
         rvLe788r4rVyiBN+ESlYLjBroTq/dbmtyWwnuw7UENdh0mr3P9VXpFJw5Nu73LEGOLtl
         eGsHHeAhOae/Sq8egGf9e9ZZLAx/BDCRtZlKs3NN4pBiZPgPp58njw5EIgFVgehWiRnJ
         0yvNy/xS2Z6ia4VQi4dyMP5l6nA91bGco5+rh7zSXPIHka4OH1Yz6r9VQ4uGsy7gZSPA
         Nr9ntYoWkbCVLP6zHi9nkuspdk1hswtJSQP4p8bC8IyA4z83i28DAeW6kws48z8uZdmS
         bEqg==
X-Gm-Message-State: AOJu0YwyrwaBfUSU/KSauUbYcYs+n1NqaSI4bwwMVfxbZBdIMVOj2axA
	DZiSvkWOyuhWMz2/OYv8DoNiLpLdsmycFVI8JvVjEUQRvRaVGuXfo3gQ
X-Gm-Gg: Acq92OGo0GM/zc90zaGEnABDCBCnqYwB4GPDzFd9ToilX9U8vf/gURpFZUd4pELtaJP
	ctzBR5D8x1Izt4yPxFobo+fz9IzcY+WW9fOWDKfFEGnwi0fV+sIRxzASkNKXbXEEBBzb28++IXC
	I6jpzwpWCZyNhaFx5eQpgt6DPIk4T+Hjfb23idu1N2d2HSRGMRCMcBG2dLM7qCnkiS1+NJTfWSL
	/tCc/xIgg538tVdrUzKSRFPFQ1kCgvT16+Azdg5rztePdqCxsNJEl111I7tX9IrlhJovZHMU4Je
	ZHYD9XqB7LeP3HrWujmpNZ6eIpEy/mhk5MSCXrqZM0i9B6sCzHQlAcD7Xet3AMdZldzwndp2efB
	FuO+Eo2rVf2a2gvc2HQFepJ26SWTGP8VUMX/pMEmn9C4U8cQ3qswRXQto2qvUb6jZ+rN8Ggicfj
	GGd/dRfeC1atoQe9zOAFPdgB3JyCDXa1MkqLE0I6h/83IJ2qRM3VNWu4BvIARcK+OxoCiBkumKc
	v3BFzU=
X-Received: by 2002:a17:90b:5202:b0:368:c2b1:ec9e with SMTP id 98e67ed59e1d1-36a6781901fmr7213219a91.22.1779527475288;
        Sat, 23 May 2026 02:11:15 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:5219:64d7:4176:3a42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6772f486sm2374543a91.2.2026.05.23.02.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:11:13 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Subject: [PATCH] eventpoll: fix use-after-free in clear_tfile_check_list()
Date: Sat, 23 May 2026 14:41:07 +0530
Message-ID: <20260523091107.61880-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a slab-use-after-free read in
clear_tfile_check_list() during EPOLL_CTL_ADD when ep_insert()
takes an error path that calls ep_remove() before
do_epoll_ctl_file() drains ctx->tfile_check_list.

ep_remove_file() decides whether to kmem_cache_free() a struct
epitems_head by testing v->next == NULL, on the convention that
NULL means "this head is not linked on any check list".
list_file() pushes a head onto ctx->tfile_check_list by storing
the previous list head into head->next; when the list is empty
that store is NULL, so the head that ends up at the tail of the
check list also has next == NULL. ep_remove_file() then misreads
the tail as "not linked" and frees it. clear_tfile_check_list()
later walks the list and dereferences head->next on the freed
object:

  BUG: KASAN: slab-use-after-free in
       clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
  Allocated by task 5985:
    ep_attach_file fs/eventpoll.c:1751 [inline]
    ep_register_epitem fs/eventpoll.c:1833 [inline]
    ep_insert+0x512/0x1820 fs/eventpoll.c:1876
  Freed by task 5985:
    ep_remove+0x155/0x2a0 fs/eventpoll.c:1135
    ep_insert+0x1372/0x1820

Terminate ctx->tfile_check_list with a non-NULL sentinel
(EP_TFILE_LIST_END) so that next == NULL unambiguously means
"not on any check list". list_file() stores the sentinel when
the list is empty, reverse_path_check() and
clear_tfile_check_list() stop the walk on the sentinel, and
do_epoll_ctl_file() seeds ctx->tfile_check_list with it. The
guard in ep_remove_file() then correctly refuses to free a head
while it remains on the check list.

Reported-by: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=69a3d7738ad3aa175caf
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/eventpoll.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a569e98d4a99..349d79e8ddc8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -222,6 +222,15 @@
 
 #define EP_UNACTIVE_PTR ((void *) -1L)
 
+/* Non-NULL sentinel terminating ctx->tfile_check_list, so that
+ * "head->next == NULL" unambiguously means "this head is not on any
+ * check list" -- the invariant ep_remove_file() and list_file() rely
+ * on. Without this, the tail of the check list aliases the
+ * "not linked" state and ep_remove_file() may free a head that
+ * clear_tfile_check_list() still references.
+ */
+#define EP_TFILE_LIST_END ((struct epitems_head *)EP_UNACTIVE_PTR)
+
 #define EP_ITEM_COST (sizeof(struct epitem) + sizeof(struct eppoll_entry))
 
 /* Wait structure used by the poll hooks */
@@ -472,7 +481,7 @@ static void list_file(struct file *file, struct ep_ctl_ctx *ctx)
 
 	head = container_of(file->f_ep, struct epitems_head, epitems);
 	if (!head->next) {
-		head->next = ctx->tfile_check_list;
+		head->next = ctx->tfile_check_list ? : EP_TFILE_LIST_END;
 		ctx->tfile_check_list = head;
 	}
 }
@@ -1685,7 +1694,7 @@ static int reverse_path_check(struct ep_ctl_ctx *ctx)
 {
 	struct epitems_head *p;
 
-	for (p = ctx->tfile_check_list; p; p = p->next) {
+	for (p = ctx->tfile_check_list; p != EP_TFILE_LIST_END; p = p->next) {
 		int error;
 		path_count_init(ctx);
 		rcu_read_lock();
@@ -2438,11 +2447,12 @@ static int ep_loop_check(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
 static void clear_tfile_check_list(struct ep_ctl_ctx *ctx)
 {
 	rcu_read_lock();
-	while (ctx->tfile_check_list) {
+	while (ctx->tfile_check_list != EP_TFILE_LIST_END) {
 		struct epitems_head *head = ctx->tfile_check_list;
 		ctx->tfile_check_list = head->next;
 		unlist_file(head);
 	}
+	ctx->tfile_check_list = NULL;
 	rcu_read_unlock();
 }
 
@@ -2601,7 +2611,7 @@ int do_epoll_ctl_file(struct file *f, int op, struct epoll_key *tf,
 	int full_check;
 	struct eventpoll *ep;
 	struct epitem *epi;
-	struct ep_ctl_ctx ctx = { };
+	struct ep_ctl_ctx ctx = {.tfile_check_list = EP_TFILE_LIST_END };
 
 	/* The target file descriptor must support poll */
 	if (!file_can_poll(tf->file))
-- 
2.43.0

