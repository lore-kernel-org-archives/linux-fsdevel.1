Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1E37107F
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780028722; cv=none; b=dT+PiLmQ8bBLQZWZBCLO+kILK9Pf8gHdmf9wtLIUKweOA4G2/mf0wRwOmnMVCq3bAMDEpwyTZ8bXN91PKvw6SLe6YMQyEXy9d0LQ+GguyPjZsgzT8KVchUA1lCBZk9Q+A93FU8fzotj2fNVR4N6CZyrslplPu6IJ1cvyHxvCPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780028722; c=relaxed/simple;
	bh=SKDZ+JkQB9hiitwCWJPWrobyYgdb2uq3qrf0kYLNKLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHIx6hsykWBY/JtH3O4oieaGerXA0APwl7oJcIC5cdbugEExD56K0q6dTGeb5s1dC7Pw26pqbrR3L/bwsdFD4Dgqd8Whze1hG9/X5VjXLEyA5y4hcjrxMKJi9CgnS3PNAx66Mtm7bVGM7ukgs1im1WPmKlwKejZjg7n22CYApl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FViA4jfs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FViA4jfs"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c80227c9572so6085202a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 21:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780028720; x=1780633520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyWtLsIqYZuNoksRZwNaNaPrzBtwQ/7aQZjTna3IWMk=;
        b=FViA4jfsLwmSUTLEigu+cDNWjbxMmsFPk0sv1aZkX0Ae9fH6kYGNEanz4UgFb7vmzt
         Ps8R4JyGf429p6MxIiD4EE2AEn2LQkPC9Aix1A6XKhO31M0LfEDX28U10GmfhItgo1SD
         N4zZK5ZGh34n82dNcN/rJ9xbYw9aFgwgIV2/y3bMi7stkk73PdRmP+q/xXeJ2loGpiv5
         H7EhFCiinSYOKX6rJo8+9JmRsWM2vWi53R0Iyt9C2tCiHAKgGwViNAJifguLfb5sk240
         cLAz4IMdpChmRQHFl2QVmGUgqoYu9q9gHGO88Csy08Vb4m0zV3L84gPlZRGzIiNJAH5A
         8s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780028720; x=1780633520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyWtLsIqYZuNoksRZwNaNaPrzBtwQ/7aQZjTna3IWMk=;
        b=FoR52wbIsONbrwj8TKY+sIi4NqT6w17qSOuHgFZ5A7pdtyt8NHrouEVcc0kkZ63N/k
         xE1ba4aVO9nrqFwgGAoKJ/tU3F787cUGvo/4jNmJ2yHYsxjjGsfk5R7fdlwBVLeTaT4O
         iuaGXwBseDRS2gcxP/ZMkXvYOW8GVLDWd7zoBXfBB40MXEvt2umIE5FgVxLPHFCbPiar
         KmH6yCs+qD/QGQclSRg0dTcmcIOh682w3Uks/Bvb5vB5x3401snLDKpTKsSUeHIYaeWJ
         4bgp1C1bEjBrjoSxUvs+yGyCrUDOx7aPtZqMfIui6bO+Pnk8o0AhiEv3nMKVnQN2+oep
         Ac/g==
X-Forwarded-Encrypted: i=1; AFNElJ989KI4qSlglXxpmwxmhfYhnmisk/8FRQeIOzMeI4l5s5+RlPlXTahyXz8XqZrY3xIm0WzLZ7AYPkbmQiFb@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2+FyXOUxS5GIV43gDaGpriWNBwR9U6Rtj/dclyMWbVWg7ofV
	zhl/f6HJr0Hfm8o9WIy7btcb7bp7wt5c0FCpNMfSyNrJdRyh8xv0oz75OGUbFQ==
X-Gm-Gg: Acq92OETWoZWsSSF4yduV3hvTLhyNGhbryKGjkoJb7mrsIRoEqmIlo+j4gKSQTY9J4t
	xH6anHfpiR3+M6Zxe9cZuXBo9l/oqz8fPA9zPz6vKnIAWRscCqegX4sp3vRJGIIhnnRwBUw3u3Q
	u/7Du+T71zANJgevzvYxk+N8TTdeT6XmiMklKmKvj+U1TZ1P3hrdehLMNrBPiGzlC72B1zDH8E7
	Ytiwx2XykGHOj+OLcMEDyjJINckmFtNio3e06m6JbYNvHD5+pnLCT1yBZuQykOv1b02tXPZr+6y
	jRlhTZlwbGynrsxBqMigCkE/bqNlEJ5ItiKgJOeBl65i401NKa8rJheqFuB9omyd9w36rgOWETm
	qMwg4wZhnkz9XK/H9mF2vW713JutW27Vio14ifmzTBf/KcPgYR9xGRIjNmhSpDYmEf52GmfSDi6
	oC1pMaiULbK0XaGdxXcdKzSV2blaWAaATIGRPx5Nc60ZZq5eDllmLWe+yW/tSo3pNHZsLq+LI7g
	pwDaIqXc1Kv1ZUAwq+U0VURaABQ
X-Received: by 2002:a05:6a00:4b06:b0:841:6414:44ce with SMTP id d2e1a72fcca58-84212b2683emr1342680b3a.22.1780028719994;
        Thu, 28 May 2026 21:25:19 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:357e:4de6:c770:8532])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214cc0d1csm355132b3a.42.2026.05.28.21.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 21:25:19 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Subject: [PATCH v2] eventpoll: fix use-after-free in clear_tfile_check_list()
Date: Fri, 29 May 2026 09:55:07 +0530
Message-ID: <20260529042507.87593-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a slab-use-after-free read in clear_tfile_check_list()
during EPOLL_CTL_ADD when ep_insert() takes an error path that calls
ep_remove() before do_epoll_ctl_file() drains ctx->tfile_check_list.

ep_remove_file() decides whether to kmem_cache_free() a struct
epitems_head by testing v->next == NULL, on the convention that NULL
means "this head is not linked on any check list". list_file() pushes
a head onto ctx->tfile_check_list by storing the previous list head
into head->next; when the list is empty that store is NULL, so the
head that ends up at the tail of the check list also has next == NULL.
ep_remove_file() then misreads the tail as "not linked" and frees it.
clear_tfile_check_list() later walks the list and dereferences
head->next on the freed object:

  BUG: KASAN: slab-use-after-free in
       clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
  Allocated by task 5985:
    ep_attach_file fs/eventpoll.c:1751 [inline]
    ep_register_epitem fs/eventpoll.c:1833 [inline]
    ep_insert+0x512/0x1820 fs/eventpoll.c:1876
  Freed by task 5985:
    ep_remove+0x155/0x2a0 fs/eventpoll.c:1135
    ep_insert+0x1372/0x1820

Terminate ctx->tfile_check_list with EP_UNACTIVE_PTR (the existing
non-NULL sentinel used elsewhere in this file for inactive list
slots) so that next == NULL unambiguously means "not on any check
list". list_file() stores the sentinel when the list is empty,
reverse_path_check() and clear_tfile_check_list() stop the walk on
the sentinel, and do_epoll_ctl_file() seeds ctx->tfile_check_list
with it. The guard in ep_remove_file() then correctly refuses to
free a head while it remains on the check list.

Reported-by: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=69a3d7738ad3aa175caf
Link: https://lore.kernel.org/all/20260523091107.61880-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2: Reuse the existing EP_UNACTIVE_PTR sentinel instead of adding a
    new EP_TFILE_LIST_END define, per review feedback.
---
 fs/eventpoll.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a569e98d4a99..2fc3b14d7ab2 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -472,7 +472,13 @@ static void list_file(struct file *file, struct ep_ctl_ctx *ctx)
 
 	head = container_of(file->f_ep, struct epitems_head, epitems);
 	if (!head->next) {
-		head->next = ctx->tfile_check_list;
+		/*
+		 * Terminate the check list with EP_UNACTIVE_PTR (non-NULL)
+		 * so that head->next == NULL unambiguously means "not on
+		 * any check list". ep_remove_file() relies on that
+		 * invariant to decide whether the head is safe to free.
+		 */
+		head->next = ctx->tfile_check_list ? : (struct epitems_head *)EP_UNACTIVE_PTR;
 		ctx->tfile_check_list = head;
 	}
 }
@@ -1685,7 +1691,7 @@ static int reverse_path_check(struct ep_ctl_ctx *ctx)
 {
 	struct epitems_head *p;
 
-	for (p = ctx->tfile_check_list; p; p = p->next) {
+	for (p = ctx->tfile_check_list; p != (struct epitems_head *)EP_UNACTIVE_PTR; p = p->next) {
 		int error;
 		path_count_init(ctx);
 		rcu_read_lock();
@@ -2438,11 +2444,12 @@ static int ep_loop_check(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
 static void clear_tfile_check_list(struct ep_ctl_ctx *ctx)
 {
 	rcu_read_lock();
-	while (ctx->tfile_check_list) {
+	while (ctx->tfile_check_list != (struct epitems_head *)EP_UNACTIVE_PTR) {
 		struct epitems_head *head = ctx->tfile_check_list;
 		ctx->tfile_check_list = head->next;
 		unlist_file(head);
 	}
+	ctx->tfile_check_list = (struct epitems_head *)EP_UNACTIVE_PTR;
 	rcu_read_unlock();
 }
 
@@ -2601,7 +2608,8 @@ int do_epoll_ctl_file(struct file *f, int op, struct epoll_key *tf,
 	int full_check;
 	struct eventpoll *ep;
 	struct epitem *epi;
-	struct ep_ctl_ctx ctx = { };
+	struct ep_ctl_ctx ctx = {.tfile_check_list =
+				 (struct epitems_head *)EP_UNACTIVE_PTR };
 
 	/* The target file descriptor must support poll */
 	if (!file_can_poll(tf->file))
-- 
2.43.0

