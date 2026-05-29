Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1283264EA
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060373; cv=none; b=pmweWfQiDg/UDhROu3xj/wpd2FtYKd3sbeMaCb5V1Oq03GLSun6xBnpEpJbtOeX2i/wZx879NryBAfek4QDngS0xovTRoTbx/nWjsJOslp/sWAiQG/hUGd4sE+xz6f5KG+ZF0/WdJpeI7reibd3T65e1N+iexjrCUfnLNV6nl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060373; c=relaxed/simple;
	bh=dGRgEL6swzJB8YYgGNjvjlHYTTzZHRh9CGbzH7Nuupw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtHEyP0sNaSR3CSQ6Bl4BAjo/OkeKQ8fo9rkn7ZcrQQg+ZlRh34jT7xsMD3KYRhTEHZKKhnnmHDfgHen7Yt8+LPrMsIEbJniU0IiOIcG9irRLgZYslwuI8d32AHBed3CQPXSDwnBJe8qOemdj71/Tz9FLE3u+doEVJmw2W2u2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTfcf8Zy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTfcf8Zy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba928852a5so97891525ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780060371; x=1780665171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vmq+XnGc2xFQDaiWK+vJ6XdpgCZZ/AvN0Z8WhEzc4M=;
        b=DTfcf8ZyjZXV6ix4Sj1/T61yTBqPzQJdDtoEhEhsUOrFFN9B36XDzbx2aE/kfk96zl
         2DU6Q8ZOGsv3P47SeWqyXuov2jTyelv/Ngo7bW2xRp6clDpXBthuuRbhvb3FUstBiSRA
         GDTO0whcS9BYdyno1Nv0HE/LUU2oAaOyszarWyy+9c/yYzxJkgkriwEouQvhgNzD/uhv
         zYbpVKY/Tg7aA1dN2FvY4LBXmO/z9/cwjFdo+ZVG5WQ3O/0VNzaZYYbXiAX/Yq8uBHdi
         ngt5FAJNc2nsodHciGBT5212sBf4De9V50GenGSZFa8maVFAZP2jhrjHWSPjh8psF0Ja
         3Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780060371; x=1780665171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vmq+XnGc2xFQDaiWK+vJ6XdpgCZZ/AvN0Z8WhEzc4M=;
        b=eshmD9/u4RP1yLSXR1yFHCWr02E0A3kuzcoeP2Am8efYfY+UKlS38tslfZC1s/gd+/
         7OSgSjBItGF2GrmKlylJeACXEpT/lYHVZEtNQGlvM0547+iIgTGNOXQfqM7JVgFDI/zZ
         BzLlrIx1pElduGMfWZ43w4tStRdWGgZ6UVg9tDe/cckx+c/xgW9KLU3VPGV20nvTs+TY
         6vxs8cUkAaS8zCsNoCp3a6UkzH52g1Uhd2nYkew7j8sXqGf/XwVqB+PI0zeQn3P7rmSL
         5gN2NSDdKB+tGnFIxZoGmJt4T51RwETNisN1bLK46DY0K5Tpb4MvQJtI6beXuH/dOVyM
         k51Q==
X-Gm-Message-State: AOJu0Ywex7uQKEbr3TSLnzICpbdFsGAbw6CKO7EwrQ+5TcQplbJBF1Tn
	pWoslLIS4fR9L+HSlfLrNaMX/8183Fa+BM/g6aKk2ZsxrT621nsVgPA1
X-Gm-Gg: Acq92OHgqt1B4Q+gDFOk2HBAow3wA2F039xzJMyg3ui2T+SoQRsYHRV2Iiq7/Ke8Lc6
	e5XOiGhg57dIvMBynfI6QfL2dFxvqhuh3mjAxDucpmEwWSMBLGF9Z4MMqLo5uWqb9PtGgr3R7t3
	0gb1sMc0KPHBdoYleLoiKsFHQWJegSl+bxk6WHomEfwng9os5K1I3sbiUGPozS+C6gIh8GgGALv
	JLXovkOQk7UR1ugci7a0cBneaBij4IAq+vLYH/arcTX3PI63czr14lbH3St5X3QE97dP54S6aBf
	m2uw1omK+K/Tttls6UHu0nS1MXtQjwCgQc6SSm3x7bMyAGbwSkYzNY+iiMW1cjq2dDoO/HYMohW
	l+MY/Xzx0n93gVjyl/b6q+HmjUoK+FyfBGw0LxlF6qEd1VbJUgvpoai9+XerGrY5i+b19hUs6pm
	QkF//06IZhE/Qk3PIUDvJtauSKB3+fCWcYMA8Fk69RHm7WCw8ZmqtvIEkiFunQ+PZaUnz55kF7D
	Cu5Fa4aA9OHyfdlRg==
X-Received: by 2002:a17:902:ce0c:b0:2bd:6327:b4f5 with SMTP id d9443c01a7336-2bf20cdbdd2mr34287215ad.40.1780060370904;
        Fri, 29 May 2026 06:12:50 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:14aa:de8f:50e3:19a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd85dsm19191035ad.25.2026.05.29.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:12:50 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Subject: [PATCH v3] eventpoll: fix use-after-free in clear_tfile_check_list()
Date: Fri, 29 May 2026 18:42:42 +0530
Message-ID: <20260529131242.89876-1-kartikey406@gmail.com>
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
Link: https://lore.kernel.org/all/20260529042507.87593-1-kartikey406@gmail.com/T/ [v2]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v3: Drop the (struct epitems_head *) casts on EP_UNACTIVE_PTR.
    void * converts implicitly to typed pointers in C; the casts
    were noise.
v2: Reuse the existing EP_UNACTIVE_PTR sentinel instead of adding a
    new EP_TFILE_LIST_END define, per review feedback.
---
 fs/eventpoll.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a569e98d4a99..1756c5f489a0 100644
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
+		head->next = ctx->tfile_check_list ? : EP_UNACTIVE_PTR;
 		ctx->tfile_check_list = head;
 	}
 }
@@ -1685,7 +1691,7 @@ static int reverse_path_check(struct ep_ctl_ctx *ctx)
 {
 	struct epitems_head *p;
 
-	for (p = ctx->tfile_check_list; p; p = p->next) {
+	for (p = ctx->tfile_check_list; p != EP_UNACTIVE_PTR; p = p->next) {
 		int error;
 		path_count_init(ctx);
 		rcu_read_lock();
@@ -2438,11 +2444,12 @@ static int ep_loop_check(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
 static void clear_tfile_check_list(struct ep_ctl_ctx *ctx)
 {
 	rcu_read_lock();
-	while (ctx->tfile_check_list) {
+	while (ctx->tfile_check_list != EP_UNACTIVE_PTR) {
 		struct epitems_head *head = ctx->tfile_check_list;
 		ctx->tfile_check_list = head->next;
 		unlist_file(head);
 	}
+	ctx->tfile_check_list = EP_UNACTIVE_PTR;
 	rcu_read_unlock();
 }
 
@@ -2601,7 +2608,7 @@ int do_epoll_ctl_file(struct file *f, int op, struct epoll_key *tf,
 	int full_check;
 	struct eventpoll *ep;
 	struct epitem *epi;
-	struct ep_ctl_ctx ctx = { };
+	struct ep_ctl_ctx ctx = { .tfile_check_list = EP_UNACTIVE_PTR };
 
 	/* The target file descriptor must support poll */
 	if (!file_can_poll(tf->file))
-- 
2.43.0

