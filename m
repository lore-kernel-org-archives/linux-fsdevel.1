Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451012;
	b=XNbbKldHtHTjwSpVnjTobmrJpWrw0mKUFrxoJ2xwY07Qmu68bly9/BJVlJJ53CclLmMM
	 mViieTloAylIP7+uixq1zbsbMF/HJQHCnhrBPWMh5suTpIe2iOlHUVQbsEJRKJF2Zh8IY
	 ijFIaZWUxy0uIf8a0NfeVP20UbGKdpj6HyU0d15XSpCYlb4oY7L9oYtTk5ZXgVdCLYXgn
	 Ti9ay2CAX5e2wxQqbtasr00vgC/xQ0aRDohpQlhaP7/s+UiIvECUpQkKqBluY2w1xFGDd
	 aJnTMKWsypR46HXVOiAEXma0ngre4c9APXtzBnV+CVoB+2T8ZnDmEioCYu9/5+AhwKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451012;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=96qZrlKa0nMa4mVz4JEu16eJHxjAVrKtxFSmlRDsfC8=;
	b=Y5Yxy3vJTiCcxL50SoLCuU2q6aJqc4T8NDogPf+s+HmCq3J5gaCw/7i2tKxZoJxAUt1d
	 7+tq4VcyKacvXUvcYZu5IXu+qk4cNd1SRR2TcbqMJxaHjU81h/RjxbV2UKa1l7ZVnvNaz
	 8ZehH8frOiSb9VnV7BhZ9EYragQ4NXCl0FZCZR1qZnOBBIWWSMd29Kw5tIJ+lgvKVx3Jl
	 pjAxhr4c+WwafXV5s2qEh9KzQ40Ju5f8oSO+c28CPIh30aEtkfOVm/GhET1xfFLtMDAV2
	 rH8uQRMJDsI+/cqev69dI1YcwnV2N2k12XrXTFZE9T55nU2iK7tKddwnsCWn5gow/Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ELGNTuxq;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C59606A320
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 23:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C59606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ELGNTuxq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792451011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=96qZrlKa0nMa4mVz4JEu16eJHxjAVrKtxFSmlRDsfC8=;
	b=ELGNTuxq0znCl95x9psQssyv6L2Uphvf9vSBAVmOq3Qt6+x42hR9npTKGUAvzPjsSsuihL
	wVq1JKClz3+6+iz2n+VdBqAhqWy9dXXEytBlIYrto/CGPokwMvQK/eIQTR/fTb/8jMN64b
	fQ+BMWnLqbWGJF/mIQwuXZ9TSbffY9A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-PQOrDeJhOQamjiMghr3uvg-1; Mon,
 19 Oct 2026 23:03:27 +0000
X-MC-Unique: PQOrDeJhOQamjiMghr3uvg-1
X-Mimecast-MFC-AGG-ID: PQOrDeJhOQamjiMghr3uvg_1792451006
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E00C18052C1;
	Mon, 19 Oct 2026 23:03:26 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B42718005B7;
	Mon, 19 Oct 2026 23:03:23 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+181b8b439f5207144b16@syzkaller.appspotmail.com,
	Seiji Nishikawa <snishika@redhat.com>
Subject: [PATCH] inotify: do not expose a zero mask while replacing a watch
Date: Tue, 20 Oct 2026 08:03:20 +0900
Message-ID: <20261019230320.1855016-1-snishika@redhat.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When inotify_add_watch() is called on an existing watch without
IN_MASK_ADD, inotify_update_existing_watch() first sets mark->mask to 0
and clears the inotify mark flags, and then sets the new bits. This is
done under mark->lock, but event delivery reads mask and flags without
that lock, in send_to_group(), fsnotify_iter_select_report_types(),
fsnotify_ignore_mask(), fsnotify_handle_inode_event() and
inotify_handle_inode_event().

So if an event comes in the middle of the update, a lockless reader of
mark->mask can see 0 and drop the event, even when both the old mask
and the new mask include the bit for that event. KCSAN reports this as
a data race:

==================================================================
BUG: KCSAN: data-race in __se_sys_inotify_add_watch / fsnotify_handle_inode_event

write to 0xffff88811afe9be0 of 4 bytes by task 3651 on cpu 0:
 inotify_update_existing_watch fs/notify/inotify/inotify_user.c:558 [inline]
 inotify_update_watch fs/notify/inotify/inotify_user.c:632 [inline]
 __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:769 [inline]
 __se_sys_inotify_add_watch+0x2ea/0x720 fs/notify/inotify/inotify_user.c:717
 __x64_sys_inotify_add_watch+0x43/0x50 fs/notify/inotify/inotify_user.c:717
 x64_sys_call+0xa19/0x2550 arch/x86/include/generated/asm/syscalls_64.h:255
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x112/0x360 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811afe9be0 of 4 bytes by task 3653 on cpu 1:
 fsnotify_handle_inode_event+0x18a/0x230 fs/notify/fsnotify.c:272
 fsnotify_handle_event fs/notify/fsnotify.c:330 [inline]
 send_to_group fs/notify/fsnotify.c:378 [inline]
 fsnotify+0x16ae/0x1860 fs/notify/fsnotify.c:597
 __fsnotify_parent+0x2f8/0x3a0 fs/notify/fsnotify.c:241
 fsnotify_parent include/linux/fsnotify.h:96 [inline]
 fsnotify_path include/linux/fsnotify.h:113 [inline]
 fsnotify_file include/linux/fsnotify.h:127 [inline]
 fsnotify_close include/linux/fsnotify.h:461 [inline]
 __fput+0x1e2/0x630 fs/file_table.c:498
 fput_close_sync+0xad/0x190 fs/file_table.c:617
 __do_sys_close fs/open.c:1560 [inline]
 __se_sys_close fs/open.c:1545 [inline]
 __x64_sys_close+0x55/0xf0 fs/open.c:1545
 x64_sys_call+0x812/0x2550 arch/x86/include/generated/asm/syscalls_64.h:4
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x112/0x360 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00002018 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3653 Comm: syz-executor126 Not tainted syzkaller #0 PREEMPT(lazy)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
==================================================================

The old value 0x00002018 in the report is FS_UNMOUNT |
FS_CLOSE_NOWRITE | FS_CLOSE_WRITE. The syzbot reproducer has one thread
that calls inotify_add_watch() on a regular file in a loop, always with
IN_CLOSE_WRITE | IN_CLOSE_NOWRITE and without IN_MASK_ADD, and another
thread that opens and closes the same file. Calling inotify_add_watch()
again on a watched file with the same mask is allowed, and it returns
the same watch descriptor. But each such call still sets the mask to 0
first, as described above, so the mask changes from 0x2018 to 0 and
then back to 0x2018. The report shows the first thread (task 3651, in
inotify_add_watch()) setting the mask to 0 while the second thread
(task 3653, in close()) was reading it.

The same problem can happen to the IN_EXCL_UNLINK and IN_ONESHOT bits
in mark->flags.

To check that events are really dropped, the dropped events were
counted with bpftrace while the syzbot reproducer was running. The
kernel is v7.3-rc7 built with the syzbot config plus CONFIG_KPROBES and
CONFIG_KPROBE_EVENTS. The script counts the calls of
fsnotify_handle_inode_event() that return without calling
inotify_handle_inode_event(), that is, the events dropped there:

kprobe:fsnotify_handle_inode_event
/comm == "repro" || comm == "repro_add"/
{
	@calls = count();
	@pending[tid] = 1;
}

kprobe:inotify_handle_inode_event
/@pending[tid] == 1/
{
	@passed = count();
	@pending[tid] = 0;
}

kretprobe:fsnotify_handle_inode_event
/@pending[tid] == 1/
{
	@dropped = count();
	@pending[tid] = 0;
}

With the reproducer built as "repro", 1551 of 213431 events were
dropped in 5 seconds:

@calls: 213431
@dropped: 1551
@passed: 211880

With IN_MASK_ADD added to the inotify_add_watch() call in the
reproducer, built as "repro_add", no events were dropped:

@calls: 195658
@dropped: 0
@passed: 195658

With this patch, no events were dropped with "repro", even without
IN_MASK_ADD:

@calls: 337082
@dropped: 0
@passed: 337082

Commit 38035c04f586 ("inotify: move control flags from mask to mark
flags") changed the call without IN_MASK_ADD to first clear the mask and
the inotify flags, and then OR in the new bits with the same code as the
IN_MASK_ADD case. The mask is cleared and set again under mark->lock,
but the lockless readers do not take that lock, so they can see the
zero mask after it is cleared and before the new bits are set, and
drop events.

Write the new mask and flags to the mark with one WRITE_ONCE() each, so
a lockless reader sees either the old value or the new value, never a
zero mask in between. Also use READ_ONCE() in the lockless readers on
the event delivery path, to pair with the WRITE_ONCE() and mark these
reads as intentionally lockless.

Fixes: 38035c04f586 ("inotify: move control flags from mask to mark flags")
Reported-by: syzbot+181b8b439f5207144b16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=181b8b439f5207144b16
Cc: stable@vger.kernel.org
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 fs/notify/fsnotify.c                 | 10 +++++-----
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/inotify/inotify_user.c     | 17 +++++++++++++----
 include/linux/fsnotify_backend.h     |  4 ++--
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7e2f330fd283..4687ba54da01 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -264,12 +264,12 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
 	if (WARN_ON_ONCE(!inode && !dir))
 		return 0;
 
-	if ((inode_mark->flags & FSNOTIFY_MARK_FLAG_EXCL_UNLINK) &&
+	if ((READ_ONCE(inode_mark->flags) & FSNOTIFY_MARK_FLAG_EXCL_UNLINK) &&
 	    path && d_unlinked(path->dentry))
 		return 0;
 
 	/* Check interest of this mark in case event was sent with two marks */
-	if (!(mask & inode_mark->mask & ALL_FSNOTIFY_EVENTS))
+	if (!(mask & READ_ONCE(inode_mark->mask) & ALL_FSNOTIFY_EVENTS))
 		return 0;
 
 	return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
@@ -349,7 +349,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	/* clear ignored on inode modification */
 	if (mask & FS_MODIFY) {
 		fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
-			if (!(mark->flags &
+			if (!(READ_ONCE(mark->flags) &
 			      FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
 				mark->ignore_mask = 0;
 		}
@@ -358,7 +358,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	/* Are any of the group marks interested in this event? */
 	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 		group = mark->group;
-		marks_mask |= mark->mask;
+		marks_mask |= READ_ONCE(mark->mask);
 		marks_ignore_mask |=
 			fsnotify_effective_ignore_mask(mark, is_dir, type);
 	}
@@ -439,7 +439,7 @@ static bool fsnotify_iter_select_report_types(
 			 * But is *this mark* watching children?
 			 */
 			if (type == FSNOTIFY_ITER_TYPE_PARENT &&
-			    !(mark->mask & FS_EVENT_ON_CHILD) &&
+			    !(READ_ONCE(mark->mask) & FS_EVENT_ON_CHILD) &&
 			    !(fsnotify_ignore_mask(mark) & FS_EVENT_ON_CHILD))
 				continue;
 
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 7c326ec2e8a8..da506ef03a25 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -129,7 +129,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 		fsnotify_destroy_event(group, fsn_event);
 	}
 
-	if (inode_mark->flags & FSNOTIFY_MARK_FLAG_IN_ONESHOT)
+	if (READ_ONCE(inode_mark->flags) & FSNOTIFY_MARK_FLAG_IN_ONESHOT)
 		fsnotify_destroy_mark(inode_mark, group);
 
 	return 0;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 5f19c24ec187..98a13699ee66 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -554,12 +554,21 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	i_mark = container_of(fsn_mark, struct inotify_inode_mark, fsn_mark);
 
 	spin_lock(&fsn_mark->lock);
+	/*
+	 * Event delivery reads mask and flags without mark->lock, so update
+	 * each of them with a single store and never expose a partial value.
+	 */
 	if (replace) {
-		fsn_mark->mask = 0;
-		fsn_mark->flags &= ~INOTIFY_MARK_FLAGS;
+		WRITE_ONCE(fsn_mark->mask, inotify_arg_to_mask(inode, arg));
+		WRITE_ONCE(fsn_mark->flags,
+			   (fsn_mark->flags & ~INOTIFY_MARK_FLAGS) |
+			   inotify_arg_to_flags(arg));
+	} else {
+		WRITE_ONCE(fsn_mark->mask,
+			   fsn_mark->mask | inotify_arg_to_mask(inode, arg));
+		WRITE_ONCE(fsn_mark->flags,
+			   fsn_mark->flags | inotify_arg_to_flags(arg));
 	}
-	fsn_mark->mask |= inotify_arg_to_mask(inode, arg);
-	fsn_mark->flags |= inotify_arg_to_flags(arg);
 	spin_unlock(&fsn_mark->lock);
 
 	fsnotify_recalc_mask(fsn_mark->connector);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a6d5c1a89cff..5f0b94bfde8e 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -802,7 +802,7 @@ static inline __u32 fsnotify_ignore_mask(struct fsnotify_mark *mark)
 	__u32 ignore_mask = mark->ignore_mask;
 
 	/* The event flags in ignore mask take effect */
-	if (mark->flags & FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS)
+	if (READ_ONCE(mark->flags) & FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS)
 		return ignore_mask;
 
 	/*
@@ -812,7 +812,7 @@ static inline __u32 fsnotify_ignore_mask(struct fsnotify_mark *mark)
 	 */
 	ignore_mask |= FS_ISDIR;
 	ignore_mask &= ~FS_EVENT_ON_CHILD;
-	ignore_mask |= mark->mask & FS_EVENT_ON_CHILD;
+	ignore_mask |= READ_ONCE(mark->mask) & FS_EVENT_ON_CHILD;
 
 	return ignore_mask;
 }
-- 
2.55.0

