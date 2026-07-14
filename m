Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F52EA498
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991700; cv=none; b=FuTBv1Uhee8mozErLYiZJB80BklwQeK73I5r6KQ39jGvMIFZuQBHzp+56FYIUiDD9I+/NvKtxpnwmy1pAFQgX3lFpPv+LnKdWu9t6Zm4ko2B9SdRZ55Vvdlg/gsxRtwEiY6C/N/v4JwDAn6JQpVEfTkCcR//OKvIU9IqYFfoGY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991700; c=relaxed/simple;
	bh=1XJxmXwfqQafTIytUX2Z6Lul7wZpxa519y93Qpuhxxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cvPqClUFxrJBAK1f657CdVjLpWoA9TeBRoYQeN+RAn9YwBzXaBi7NVQsMsAz0DPQR4Vl5nIjRNgki/7yErjoTYUsq/jVsc4mXzP1ilzWT+I4gUHORtG8pWYpKMreodXa06S+01qr924MZpX2N8T7uwS76rZTlW01GSU+gKjedLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAelxqIG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAelxqIG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc891373e0so43594335ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783991697; x=1784596497; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W/hLy+UxJhCgbMBZlTiYLrb+eLGW2reQNpf7vQdSCic=;
        b=oAelxqIGk2wcP16+36JVIhIZ8dIU5t2qMKYq1SZ7Lr4ZqjwSK5tt7YtFw6/IvFWRiG
         TaXuJjLV9HkuyeJwF3woANKdTDo2vcuI5b+do+6E+OUvCvhoZSD3DK8Bne2Y8qCmnegs
         qSl1sz9dq4ZgqXfwSkGh6trm8oYTVm+ORDA9AIGtpWl5aOnVR4lc0rSqAxUTgvuH9Nz0
         ieJuyNOVpSprQyt704sIQBDArrKawfdgaNmOe8FLH7TPqHMwJhV3mcgUKJBlajRflthr
         YZVAK/vE1eeC7me8aga80bzi5BddxjF61FvW9Y4XNupThBnmI5wBUgfPCN3q92SWSP/q
         2S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783991697; x=1784596497;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W/hLy+UxJhCgbMBZlTiYLrb+eLGW2reQNpf7vQdSCic=;
        b=epCRBSsxY/DeJEhl5MC0jG7Ln4K1AACg3Jn6MVJOh+x86wMDPJy8CtyAys9fImCEp1
         60dwwImPDltGOivn5/jptYRqIpsAkDmChNCFLIjw+v9jTKckf44QNA/Ey3/JBpj5v/Fr
         NvM1HgD3WnwujnGe3GEMfvjvS71WfIHSfLzJSHhAOqychb+4kE4zGktYUEUS4FWMQsew
         6efVnh1QsylekwfLkNGgY+c3qOJ6wG52ssMVFUNkEy21Uam/ONj/jwwE4eNdDqIhdpUo
         MvhyrybUgBx7UiUUu6+ByLBDoHHQ6qKvIsSMLmLUdfqvIHyo4UqaJq2yAQNoJ305lA8y
         0pjg==
X-Gm-Message-State: AOJu0YzTgxThRmXs0WHkec4+898ZUPVx7ydFFQeAZCqv0yUpmRskkDYM
	OSzzkOkRZLiMjjmVzMyXGwecWDrZBT7QP75XJNGTsvpn/FHRxPiN5II0
X-Gm-Gg: AfdE7clPwz/XFKj3Ph1gnrOp9sOU23Xk2w52VuHPz1dzfBEWjcz3Wy4jFNs9xIs+D+9
	V3uTUDjTYLzHB9solH2pPwTvq0nYfV/gAjoyDRgeSZknAOao7gfYJfz0pHyb/tvNkhOs0lYQXA5
	4qNSG/fD6qrig3/Qm2q5QPmYZTYbWPPCDs3IczCybiU7nivxcXrhTGSbb7BpgM7MR/Km15Nduw3
	aAWRWEXaam6lB8WuI1rtFqS5AYFLskfMk1JNiflE6oFcidDr6qigzu/r4HEri0fOv8JhV1SHKb9
	aQRq6Q76F2Molz/Ekn5KGvginSLu9c0wO+TLl6syg+yq9ZmwZW7pKF2bmSrmWwzWW2XqG+/Ldyp
	4LOKJT0XbFD6KXbg7eQUxYrAlHMIFDgPIMjaT19t3qd0m/nZPF//G1EE5VzCiqK841Lg1M7Y3oE
	o2ala+d23XKCz9Fcyu9khB2A==
X-Received: by 2002:a17:902:c403:b0:2c0:e5ee:f55e with SMTP id d9443c01a7336-2ce9e7aa136mr108076075ad.7.1783991697251;
        Mon, 13 Jul 2026 18:14:57 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cee5ccb56esm8315355ad.84.2026.07.13.18.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 18:14:56 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Tue, 14 Jul 2026 09:14:54 +0800
Subject: [PATCH] fs/inode: replace goto-again rescan with cursor in
 evict_inodes()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-feat-fs-evict-inodes-cursor-v1-1-64818f31020e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI2NVWoC/x3MwQqDMAyA4VeRnA3YFjb0VYYHl6Yul3YkVYTiu
 6/s+MHP38BYhQ2WoYHyKSYld7hxAPpseWeU2A1+8o/p6QIm3iomw95SRcklsiEdakWRfKD5HQM
 5l6AfvspJrv/9td73D0kPkpZtAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>, Jing Wu <realwujing@gmail.com>
X-Mailer: b4 0.13.0

evict_inodes() traverses sb->s_inodes to reclaim all zero-refcount
inodes at unmount time.  When the traversal yields to the scheduler
via cond_resched(), the current code jumps back to a "goto again"
label and restarts the list_for_each_entry loop from the head.
Inodes already marked I_FREEING are skipped cheaply, but the
repeated scans make the total work O(n * r) where r is the number
of reschedule events -- proportional to O(n^2) in the worst case on
systems with many inodes and memory pressure.

Replace the goto-again pattern with a sentinel cursor node embedded
in sb->s_inodes.  list_move() advances the cursor past each visited
inode in O(1).  Dropping and reacquiring s_inode_list_lock around
cond_resched() leaves the cursor in place, so the loop resumes from
exactly the current position rather than the list head, giving O(n)
total traversal.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
evict_inodes() is called at unmount time to reclaim all zero-refcount
inodes on a superblock.  Its current implementation uses a "goto again"
pattern: after dropping s_inode_list_lock for cond_resched() and
dispose_list(), it restarts list_for_each_entry from the list head.

In the common case (clean unmount, all files closed) the goto loop
terminates quickly because dispose_list() removes evicted inodes before
the restart.  However, when many inodes have a positive refcount and
cannot be evicted -- as happens with a force-unmount while file
descriptors are still open -- the restarts scan O(n) skippable inodes
each time, making total work O(n * r) proportional to O(n^2) in the
worst case.

This series replaces the goto-again pattern with a sentinel cursor node
embedded in sb->s_inodes, allowing the traversal to resume from its
current position after each lock drop.
---
 fs/inode.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index acf206beb2e03..19197368c6a67 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -880,15 +880,31 @@ static void dispose_list(struct list_head *head)
  * called by superblock shutdown after having SB_ACTIVE flag removed,
  * so any inode reaching zero refcount during or after that call will
  * be immediately evicted.
+ *
+ * Use a cursor node embedded in sb->s_inodes to resume traversal after
+ * dropping s_inode_list_lock for cond_resched() + dispose_list().  This
+ * avoids restarting the scan from the list head on each reschedule, giving
+ * O(n) total traversal instead of O(n * r) where r is the reschedule count.
  */
 void evict_inodes(struct super_block *sb)
 {
 	struct inode *inode;
 	LIST_HEAD(dispose);
+	/*
+	 * Embed a cursor node directly in sb->s_inodes.  list_move() advances
+	 * it past each visited inode in O(1), so the loop resumes from exactly
+	 * the current position after lock drop rather than from the list head.
+	 */
+	struct list_head cursor;
 
-again:
 	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	list_add(&cursor, &sb->s_inodes);
+
+	while (cursor.next != &sb->s_inodes) {
+		inode = list_entry(cursor.next, struct inode, i_sb_list);
+		/* Leave the cursor immediately after the current inode. */
+		list_move(&cursor, &inode->i_sb_list);
+
 		if (icount_read_once(inode))
 			continue;
 
@@ -916,9 +932,11 @@ void evict_inodes(struct super_block *sb)
 			spin_unlock(&sb->s_inode_list_lock);
 			cond_resched();
 			dispose_list(&dispose);
-			goto again;
+			spin_lock(&sb->s_inode_list_lock);
 		}
 	}
+
+	list_del(&cursor);
 	spin_unlock(&sb->s_inode_list_lock);
 
 	dispose_list(&dispose);

---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260713-feat-fs-evict-inodes-cursor-c23c9bd3c11f

Best regards,
-- 
Jing Wu <realwujing@gmail.com>

