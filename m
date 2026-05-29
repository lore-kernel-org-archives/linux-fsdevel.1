Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AE3E9C3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064752; cv=none; b=IkTpsyrfQAWr4b/E1W2GpA7+SITJaGghvhVRt3YbyFXul9j6OWiiSb+BQx+SCH78GUrreT6q1qZj0nc+lRtUADgwaTeGMB9TrBC3F0w89ncCFQN+viJBXY14zj//32Ctk8qHLIHlYwHlZh8V4L4dDCry7qNlWBs8/XL5Zihv5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064752; c=relaxed/simple;
	bh=LQB2kaz9QSTegWvTSJZra84FuHw/6aS/0tC7TZJBexg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Klg9ikBpNFq5tG1L58BSvydrC8JcGDFcqkBbmWYX+f+6J60oFPDfQqQZEZHt0AqbfrnwJhn3g5qQs6dPJQfajl+yfFQlR13xF5iqcsEQxAKraIwIY31DG6ylVAeUNLAugc74NWv7rj6vd+CMA2FC/FzMkVLbCFpEywcDN3G3yvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tI83X0Wc; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI83X0Wc"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304f0039c02so954212eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780064749; x=1780669549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSyq379iMRs5CLWz1GrbdWaHEBM9DGZinDVUSvey/oI=;
        b=tI83X0WchL7gjQ2oluUFBAo/ZebSlRKORALLuCgrXZQGyjwQzS/eYBi110hPoL1BqB
         gsu/Ww03ymPS48ic4QT3uXGkRqq2dpyZkAd58fWsEZ9++I5DfYKL55Gx2nl7ANPPQtVW
         vOsyDpAI+9FWf4N5hUSOpqbMEVWeTNFyZZ2hIdCJnn6W13x/+l4WFLSWDITGkL1UlhtK
         0Fh+T6jDLd7aqqH7Vy65wuOahfe+2HDRpSP7PJKZNUWRhjMDE4G3epPslso00135C69q
         X4ERhsKlBi01O1l2mZU304EpNM3a3mv15wYrT2vx9vL1E4tYmFIiRwdhmuNsT9OxLKxs
         syKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064749; x=1780669549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSyq379iMRs5CLWz1GrbdWaHEBM9DGZinDVUSvey/oI=;
        b=c1xPRGBtDASxt9C8AA6FvAsDirG21nihv+YjSnuTphjDMtsWRJR11k477wpM0Bwh4Y
         xYR5eSzk7ThYIRtY1DNtnH7AgL3cnMsQ4uVePBnUcypsu65V0kNMCO3ZHoCy63jUs6V9
         mhPFttK5VqQQOOYeGenlsffeXl5yg8URp8RXfLtOAnJfPTVqllo9PCbIILHI2uVAg0nX
         vYFI5LOjJqfCUXIaP+FkZvWp5WFfPedZTAFPItstQRp0IAveHVNYewvfD85Wdwut9bwQ
         FzZ6ZfzyXBsphQv+maMaZgBV5Yfj7kpss/skz5JwDbb4xfMK59OHy1+0bySmEjg+GKg+
         aHaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GHAguKgPDJeIm/xXiWZaRzWxLflOdg9OTm1heqgmOzKpu2a54IOHYoFO6IikV+2lh1wxBtqQineB/cECD@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhncEvYZXawUcRHblZq3mdGdSzrKY3j5+3N9JsTsIXXQuVOMK
	zIRPr92b16v/2gfTbKJlIJc1wz2hJorWmuwagdlK37+7KSFRKhaF9emE
X-Gm-Gg: Acq92OEUFxTq4nz1rGUehm1C9otjgDFh7HPva2GqTc++73joeypohO5yS3vROvWjCRe
	XWPbWneHJlMdtMBpA1AabOnbW042Gj0qs5zSZMakxHRgn42J91UD/K+5FB6FNP1MTdBM020W8nn
	0RvHUe7UYegn8hC4vg2nXRRMtroDs4/k410/zA6s/b9caW2onPmPnZOmn86mfyc5Hxmmlp5jNYx
	kpkyG3pp2u4lkUhVGB2QoU7T8SBJjkgqFndx/y7qwnR1EpcynrpWgVV7HeaWIwbDXwgeikai0Yl
	l954PUT0bBpCR4rv/shXeA59dvidkip9lKWmnZQcE7KT+AQ4qubq5v5KTSp3irdZ+Zm0E8iNkXq
	vNFqKMmS8XqzA6W/EzhmyBSmH4X6TDdg/4B0TSHoYbsGBxPDT5EnughrkYYIajRynIHRoxkFvoC
	7w6KjpXUyP5wS37oaoZlY8K6edGG9DaOkp
X-Received: by 2002:a05:7300:5714:b0:304:1fb6:88fd with SMTP id 5a478bee46e88-304fa693196mr4791eec.29.1780064749422;
        Fri, 29 May 2026 07:25:49 -0700 (PDT)
Received: from zhanwei.. ([192.227.223.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2efb4esm1534916eec.8.2026.05.29.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:25:47 -0700 (PDT)
From: Zhan Wei <zhanwei919@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e70e1b6cba8714543f7c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Zhan Wei <zhanwei919@gmail.com>
Subject: [PATCH] eventpoll: restore EP_UNACTIVE_PTR sentinel for ctx->tfile_check_list
Date: Fri, 29 May 2026 22:25:33 +0800
Message-ID: <20260529142533.23696-1-zhanwei919@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e09c77d94003 ("eventpoll: hoist CTL_ADD scratch state into
struct ep_ctl_ctx") moved tfile_check_list from a file-scope global into
the stack-allocated struct ep_ctl_ctx, and in doing so replaced the
EP_UNACTIVE_PTR sentinel with NULL on the grounds that "NULL is the
obvious 'empty' value and zero-init handles it for free", describing the
change as "No functional change". It is not.

epitems_head->next is overloaded with two roles:

  1. the "next" pointer that threads a head onto ctx->tfile_check_list;
  2. a membership flag: ep_remove_file() uses
     !smp_load_acquire(&v->next) to mean "this head is not on any
     pending ctx->tfile_check_list and is therefore safe to free".

Before that change the EP_UNACTIVE_PTR sentinel kept the two roles
disjoint: a head on the list always had a non-NULL ->next (another head,
or the sentinel at the tail), so ->next == NULL was equivalent to "never
listed". With the sentinel gone the list is NULL-terminated, so the tail
head's ->next is NULL as well. ep_remove_file()'s gate can no longer
distinguish "never listed" from "listed at the tail", and misfires on
the tail head.

The reader (reverse_path_check_proc) holds epnested_mutex +
rcu_read_lock; the freer (ep_remove_file) holds ep->mtx + file->f_lock.
The two sides share no mutex -- the sentinel was the invariant the gate
relied on to know it could skip the read side. With it gone,
ep_remove_file() frees the tail head while reverse_path_check_proc() is
still walking it, producing the slab-use-after-free read. The syzbot
reproducer hits this within seconds on a multi-CPU VM.

Restore the sentinel: initialize ctx.tfile_check_list to EP_UNACTIVE_PTR
in do_epoll_ctl_file(), and terminate the walk on "!= EP_UNACTIVE_PTR"
in reverse_path_check() and clear_tfile_check_list(). The tail head's
->next becomes the sentinel again rather than NULL, so
ep_remove_file()'s gate regains its exclusivity and stops misfiring on
the tail. ep_remove_file() itself is unchanged.

This restores the invariant the file-scope tfile_check_list relied on
before that change while preserving the ctx packaging it introduced.

Reported-by: syzbot+e70e1b6cba8714543f7c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e70e1b6cba8714543f7c
Fixes: e09c77d94003 ("eventpoll: hoist CTL_ADD scratch state into struct ep_ctl_ctx")
Suggested-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/all/20260528-rotwild-summt-kuhhandel-7276ef4c33b7@brauner.io/
Signed-off-by: Zhan Wei <zhanwei919@gmail.com>
---
 fs/eventpoll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a569e98d4a99..abef3bc48cc4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -429,7 +429,11 @@ struct ep_ctl_ctx {
 	/*
 	 * Singly-linked list of epitems_head objects collected during
 	 * ep_loop_check_proc(), then walked by reverse_path_check().
-	 * NULL means empty.
+	 * Terminated by EP_UNACTIVE_PTR, not NULL: epitems_head->next
+	 * doubles as a membership flag (a NULL ->next means "not on this
+	 * list", see ep_remove_file()), so the list uses a non-NULL
+	 * sentinel to keep the tail head distinguishable from an unlisted
+	 * one.
 	 */
 	struct epitems_head *tfile_check_list;
 
@@ -1685,7 +1689,7 @@ static int reverse_path_check(struct ep_ctl_ctx *ctx)
 {
 	struct epitems_head *p;
 
-	for (p = ctx->tfile_check_list; p; p = p->next) {
+	for (p = ctx->tfile_check_list; p != EP_UNACTIVE_PTR; p = p->next) {
 		int error;
 		path_count_init(ctx);
 		rcu_read_lock();
@@ -2438,7 +2442,7 @@ static int ep_loop_check(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
 static void clear_tfile_check_list(struct ep_ctl_ctx *ctx)
 {
 	rcu_read_lock();
-	while (ctx->tfile_check_list) {
+	while (ctx->tfile_check_list != EP_UNACTIVE_PTR) {
 		struct epitems_head *head = ctx->tfile_check_list;
 		ctx->tfile_check_list = head->next;
 		unlist_file(head);
@@ -2601,7 +2605,9 @@ int do_epoll_ctl_file(struct file *f, int op, struct epoll_key *tf,
 	int full_check;
 	struct eventpoll *ep;
 	struct epitem *epi;
-	struct ep_ctl_ctx ctx = { };
+	struct ep_ctl_ctx ctx = {
+		.tfile_check_list = EP_UNACTIVE_PTR,
+	};
 
 	/* The target file descriptor must support poll */
 	if (!file_can_poll(tf->file))
-- 
2.43.0

