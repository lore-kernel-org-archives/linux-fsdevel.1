Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98E44E67A
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460993; cv=none; b=YgWqRay/VmNWFQyjfOdwBK0CRBBRcyYg2xR9DUaXNdfZiQVUDhHZ7AA/TgxcasgeFkaNND4aYemrBCqxRKYFJJvDLYGWvKeqafatfBpvmfzuyw6a4buTZfI73TvqTxUAYHNhaKSN2F79DDwTtktGloUVaTbc3pabEO7S/X3DgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460993; c=relaxed/simple;
	bh=QZCW093E+D2nyI4UShEAXdlYzP5jckeOAUOyoHz6sC8=;
	h=Mime-Version:To:From:References:Cc:Subject:Content-Type:Date:
	 Message-Id:In-Reply-To; b=an9rOXSs4f0cpowqopXHFpegb/zICRxk/BhNa0bRmvYlFDdlDrT4pM3azY6yFinmPi6R+zqWqgBiHkUxhv2XZ/dAl46Fk+aZtQeEMPivBE6+Y6fa/24+mJ7VLlDlKef0gDtpOrZjMoWNXwlfGF5RlzGaf5cBVC0hAB9KHSNkQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d32zwSDS; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d32zwSDS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791460987; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ot3K2X/2YloRfCtV/mf2YWkwpChF9fDwu+aBl2Z5A1s=;
 b=d32zwSDSIQgcXUe3fEOf2LcslSEZPaMREjcF6FN4W77ZCuHbTVbTqldYUb2EaIRX4a/khD
 aunfd7WfJy13AH3WJs4JbW4XqyPMtc9WuuLRg4fTE2Z6DXiCTcBh8DfjYkcmHCC7FAUT2a
 sTri0P9jPNlx/i6TxFOysM7BtAuFe/dUFh3dlkV3J6DsXwzbGjHtK1QVj+2dJ3j+Uv7oxT
 eC5dYZIEzaJVBj24RowuGIbHmkS5GAX/K6xB4z59Leh9tsBKQxpzaumavVSc/e54WrgSmS
 pKryf1gm2CKppaCfaNjFc4K5eOfASBh5tpezamWWAD106z3nrFRIY4Y1KZV0DQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+26ac7867a+fe009c+vger.kernel.org+zhujia.zj@bytedance.com>
To: "Jan Kara" <jack@suse.cz>
From: "Jia Zhu" <zhujia.zj@bytedance.com>
References: <cover.1791452174.git.zhujia.zj@bytedance.com>
Cc: "Jia Zhu" <zhujia.zj@bytedance.com>, <amir73il@gmail.com>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] fsnotify: avoid unrelated mark reaper waits during group teardown
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu,  8 Oct 2026 20:02:39 +0800
Message-Id: <896a15acc6c13ea951d997cf3746082cdfabafc7.1791452174.git.zhujia.zj@bytedance.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <cover.1791452174.git.zhujia.zj@bytedance.com>

fsnotify_destroy_group() unconditionally flushes the global mark reaper,
so an empty inotify instance can hang on unrelated reclamation during
close or task exit:

  do_exit
    __fput
      inotify_release
        fsnotify_destroy_group
          fsnotify_wait_marks_destroyed
            __flush_work

Skip the flush when only the closing reference remains, allowing teardown
to finish without waiting for unrelated SRCU readers.

Verified in QEMU: empty groups and groups whose marks have been reclaimed
exit while an unrelated SRCU reader remains held; groups with pending
reclamation still wait.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/notify/group.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/notify/group.c b/fs/notify/group.c
index b56d1c1d9644a..052a419ee52a6 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -46,6 +46,7 @@ void fsnotify_group_stop_queueing(struct fsnotify_group *group)
  * the group reference.
  * Note that another thread calling fsnotify_clear_marks_by_group() may still
  * hold a ref to the group.
+ * The caller must hold a reference and exclude new marks.
  */
 void fsnotify_destroy_group(struct fsnotify_group *group)
 {
@@ -67,19 +68,22 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
 	 */
 	wait_event(group->notification_waitq, !atomic_read(&group->user_waits));
 
-	/*
-	 * Wait until all marks get really destroyed. We could actually destroy
-	 * them ourselves instead of waiting for worker to do it, however that
-	 * would be racy as worker can already be processing some marks before
-	 * we even entered fsnotify_destroy_group().
-	 */
-	fsnotify_wait_marks_destroyed();
+	/* Even detached marks hold a group reference until final destruction. */
+	if (refcount_read(&group->refcnt) == 1) {
+		/*
+		 * Pair the refcount read and this barrier with the release
+		 * decrement in fsnotify_put_group() (refcount_dec_and_test()),
+		 * ordering mark destruction before subsequent group teardown.
+		 */
+		smp_mb();
+	} else {
+		fsnotify_wait_marks_destroyed();
+	}
 
 	/*
-	 * Since we have waited for fsnotify_mark_srcu in
-	 * fsnotify_mark_destroy_list() there can be no outstanding event
-	 * notification against this group. So clearing the notification queue
-	 * of all events is reliable now.
+	 * Mark destruction waits for fsnotify_mark_srcu, so there can be no
+	 * outstanding event notification against this group. Clearing the
+	 * notification queue of all events is reliable now.
 	 */
 	fsnotify_flush_notify(group);
 
-- 
2.20.1
