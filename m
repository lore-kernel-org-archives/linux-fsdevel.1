Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCAD2F8BC3
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465266; cv=none; b=J3o4MuMEKlXPY/W3687mkiT98GxYKyiIUHIipe+wh0gu8WF3cSZ6S/EPLDraLUl+InMDTRkjhJwo/lmY+fadmEcmwmWcfrMrKFqM1Y9d/QO0GGSRxrcHJt+rTdHnrEmw6SfnlQ59Lap+rVOAhHSaB3WP1Gd44mZK0PhtKs5QBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465266; c=relaxed/simple;
	bh=sCgrEudUL2EwyvNHOVPpGOhp9GJITcyUXJp7Z4NABLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7L6odHx1fNweza/IGaVmYMJRONeIE59jIgagLwWhBNp/UXonBVqgK61ak9hFgJzuz1bg6qwK2q0my6i9ghn7EIfb2cjFtK62fyJlRLV5qV6+URQB5od5QEFLxRYvoNOVqXMImBCRIegCztvJDxD0z/M7LTBejzlraMlwaUD3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=R4xlr3ft; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="R4xlr3ft"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2adbfab4501so658445ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1774465261; x=1775070061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jCYdcHbAU8vXdPo+HmNvp6/WZwddntRiscW+I1qyME=;
        b=R4xlr3ftv/lchYB+/k28pxAs3v3CA0HYXVJs/481erJlMRqamIGHR96i561xICDHid
         V3Y8J12BzY0eOWP8lOSL720+TfBe9em6ipKmQ1X4dGHKshc1WGGt5dPiU8sHEY1DJx8F
         yqffUg3+lmJnPkAPDyh9c+ZIEuLMOj7rL0CCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774465261; x=1775070061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2jCYdcHbAU8vXdPo+HmNvp6/WZwddntRiscW+I1qyME=;
        b=AU39DB9+0KDYfbToy0+63u5kg4WV6PwULHS+ZSQyoIf1tXsZGvGo8Rjgt7eRGSchQj
         sWzpa2Wu4m9uQwHqZ5UeKskAyxnOwqBjdGnhBe8H7qojVHZV0MjQIUkjzOzeR82S2nMi
         85G7jqHuna01aaho0DBKglwuoJcAP1M4zKyZD9NcK9JryiHTozmFxBfOpICKzFjf6YJF
         tQ/LuFYyEzHV5+9aekEKOHT01+Py3FyLB9Hj1D1VcgK86AWDowP7lsbfivhqthDmntMZ
         fXqIhSknhDZP2ujgPDWoW7bMjwwNrE4hx/WEnh1UzOcwMg2BmK2WuPUdfGA7Yg+Dkt+c
         gc4A==
X-Forwarded-Encrypted: i=1; AJvYcCUasa2e7aS+6O9h9d7sMLxz+MH/Z4/qzU6ouggayEsilvn4uk3NsN2zR/p1pwXXTkGHTy4SeWJn5ZBC/Sne@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHrx+OXfQqSkIysZRbO18ylQmmLIjy4wOSWg0sndhlJP391BS
	lCNSmW8ZH6p5Y3KzYIqyeEi+6roXunc+M5AYoUIvnOokbra0D6M0DdknVuyE06wyBOQ=
X-Gm-Gg: ATEYQzwiMlkq0iPE74gpnIDj4GR0f3jTkKqrlyTdJ2jZDVBzFwH8x/S2xXNgXZFkJE0
	dnrST54VoXdG7BNYMGTR425TevIwnG9D1nK/Jl+4GlIxP+PoKD2/DWrhKiTsLGBc72EbqRryko1
	G3EKNlfiWRswDrBVdxUC+EcpV16kDCmMl/u2+m5PwMR5pKv5DzvvytaHbSSIn4XbgG8zyYZ/f7+
	epNWJOPeRjQ5uoh5liFb23N3UxqAftiLTaTKcyBhShhsmvtcP61Khtzo6d8TddvccnLGNpL1SZz
	JD6jRGV6WxAYs6VfRs3R4TuFLiDcwLyv0QTIZLzEz4JNjt2vCQs35V8K5kA223BgJt41leAtHzb
	U9aCFapow1ugU1YiBTrw69o0+809e3neo2GVpxwbbpfbB0y2PkWlRkkb46nTqCYBB5p4MDM+Ux8
	mVyl0ScN0ENKMO+z67i6vypCZQcHvg9LPHTbRI8Slkz7SfZGmfruJC00/p5OZfP+/DS9Ch4xdyv
	XXwMCx77zzLLXVrKS8sCQ==
X-Received: by 2002:a17:903:182:b0:2b0:6961:150a with SMTP id d9443c01a7336-2b0b0ad2a61mr54895465ad.38.1774465260637;
        Wed, 25 Mar 2026 12:01:00 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc79f7dbsm6483485ad.25.2026.03.25.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:00:59 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: manfred@colorfullife.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	rstoyanov@fedoraproject.org,
	ptikhomirov@virtuozzo.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [RFC PATCH 3/3] ipc/mqueue: implement fcntl(F_MQ_PEEK) for non-destructive message inspection
Date: Thu, 26 Mar 2026 00:30:25 +0530
Message-Id: <20260325190025.40312-4-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325190025.40312-1-ssrane_b23@ee.vjti.ac.in>
References: <20260325190025.40312-1-ssrane_b23@ee.vjti.ac.in>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for F_MQ_PEEK, a new fcntl command that reads a POSIX
message queue message by index without removing it from the queue.

Background:
CRIU (Checkpoint/Restore In Userspace) supports live container migration
and process checkpoint/restore.  POSIX message queues are a widely-used
IPC mechanism, but CRIU cannot checkpoint processes that hold open mqueue
file descriptors: there is no kernel interface to inspect queued messages
non-destructively.  The SysV IPC analogue (MSG_COPY for msgrcv) was
introduced specifically for CRIU in commit 4a674f34ba04 ("ipc: introduce
message queue copy feature").  This patch provides the equivalent for
POSIX mqueues.

Implementation:
The queue stores messages in a red-black tree (info->msg_tree) keyed
by priority, with each tree node holding a FIFO list of messages at
that priority level.  mq_peek_at_offset() walks this structure in
receive order (highest priority first, FIFO within priority) to locate
the message at the requested index without modifying any state.

Message payload is copied into a kvmalloc'd kernel buffer under
info->lock using pure memcpy() (no page faults possible).  This
correctly handles multi-segment messages by walking the msg_msgseg
chain.  The lock is released before copy_to_user() transfers the
kernel buffer to userspace.

A new include/linux/mqueue.h kernel header is added to declare
do_mq_peek() for use from fs/fcntl.c, following the same pattern as
include/linux/memfd.h for memfd_fcntl().

Concurrency:
The snapshot is consistent within the spin_lock() critical section.
Between two F_MQ_PEEK calls the queue may change (messages may be sent
or received).  This is documented snapshot semantics, analogous to
/proc entries.  CRIU freezes the target process via ptrace before
dumping, so in practice the queue is stable for the entire checkpoint
sequence.

Link: https://github.com/checkpoint-restore/criu/issues/2285
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 fs/fcntl.c             |   4 ++
 include/linux/mqueue.h |  19 ++++++
 ipc/mqueue.c           | 129 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 include/linux/mqueue.h

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f93dbca08435..32d0dcc8e544 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -24,6 +24,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
 #include <linux/memfd.h>
+#include <linux/mqueue.h>
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/rw_hint.h>
@@ -563,6 +564,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 			return -EFAULT;
 		err = fcntl_setdeleg(fd, filp, &deleg);
 		break;
+	case F_MQ_PEEK:
+		err = do_mq_peek(filp, argp);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/mqueue.h b/include/linux/mqueue.h
new file mode 100644
index 000000000000..a725fcf90d39
--- /dev/null
+++ b/include/linux/mqueue.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_MQUEUE_H
+#define __LINUX_MQUEUE_H
+
+#include <uapi/linux/mqueue.h>
+
+struct file;
+
+#ifdef CONFIG_POSIX_MQUEUE
+long do_mq_peek(struct file *filp, struct mq_peek_attr __user *uattr);
+#else
+static inline long do_mq_peek(struct file *filp,
+			       struct mq_peek_attr __user *uattr)
+{
+	return -EBADF;
+}
+#endif /* CONFIG_POSIX_MQUEUE */
+
+#endif /* __LINUX_MQUEUE_H */
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index bb7c9e5d2b90..5e73864a9657 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -286,6 +286,135 @@ static inline struct msg_msg *msg_get(struct mqueue_inode_info *info)
 	return msg;
 }
 
+/*
+ * mq_peek_at_offset - locate a message by receive-order index.
+ *
+ * Walk the priority tree from highest to lowest priority, and within each
+ * priority level in FIFO order, returning the message at position @offset
+ * (0 = next message that mq_receive() would dequeue).
+ *
+ * Must be called with info->lock held.  Does not modify queue state.
+ * Returns NULL if @offset >= mq_curmsgs.
+ */
+static struct msg_msg *mq_peek_at_offset(struct mqueue_inode_info *info,
+					 int offset)
+{
+	struct posix_msg_tree_node *leaf;
+	struct rb_node *node;
+	struct msg_msg *msg;
+	int count = 0;
+
+	for (node = info->msg_tree_rightmost; node; node = rb_prev(node)) {
+		leaf = rb_entry(node, struct posix_msg_tree_node, rb_node);
+		list_for_each_entry(msg, &leaf->msg_list, m_list) {
+			if (count == offset)
+				return msg;
+			count++;
+		}
+	}
+	return NULL;
+}
+
+/*
+ * mq_msg_copy_to_buf - copy message payload into a flat kernel buffer.
+ *
+ * Handles multi-segment messages by walking the msg_msgseg chain.
+ * Uses only memcpy() so it is safe to call under info->lock.
+ * Returns the number of bytes copied.
+ */
+static size_t mq_msg_copy_to_buf(struct msg_msg *msg, void *buf, size_t buf_len)
+{
+	size_t alen, to_copy, copied = 0;
+	struct msg_msgseg *seg;
+
+	to_copy = min(buf_len, msg->m_ts);
+
+	alen = min(to_copy, DATALEN_MSG);
+	memcpy(buf, msg + 1, alen);
+	copied += alen;
+	to_copy -= alen;
+
+	for (seg = msg->next; seg && to_copy > 0; seg = seg->next) {
+		alen = min(to_copy, DATALEN_SEG);
+		memcpy((char *)buf + copied, seg + 1, alen);
+		copied += alen;
+		to_copy -= alen;
+	}
+	return copied;
+}
+
+/*
+ * do_mq_peek - implement fcntl(F_MQ_PEEK).
+ *
+ * Read the message at position @attr.offset in receive order from the
+ * queue without removing it.  Position 0 is the message that the next
+ * mq_receive() would return (highest priority, FIFO within priority).
+ *
+ * The snapshot is consistent within the spin_lock() critical section.
+ * Between two F_MQ_PEEK calls the queue may change; this is documented
+ * snapshot semantics analogous to /proc entries.
+ *
+ * Returns bytes copied on success, -ENOMSG if offset >= mq_curmsgs.
+ */
+long do_mq_peek(struct file *filp, struct mq_peek_attr __user *uattr)
+{
+	struct mqueue_inode_info *info;
+	struct mq_peek_attr attr;
+	struct msg_msg *msg;
+	void *kbuf;
+	long ret;
+
+	if (filp->f_op != &mqueue_file_operations)
+		return -EBADF;
+
+	if (!(filp->f_mode & FMODE_READ))
+		return -EBADF;
+
+	if (copy_from_user(&attr, uattr, sizeof(attr)))
+		return -EFAULT;
+
+	if (attr.offset < 0 || !attr.buf_len || !attr.buf)
+		return -EINVAL;
+
+	info = MQUEUE_I(file_inode(filp));
+
+	/*
+	 * Allocate the kernel copy buffer before taking the spinlock.
+	 * Cap at mq_msgsize: no message can exceed it.
+	 */
+	kbuf = kvmalloc(min_t(size_t, attr.buf_len, info->attr.mq_msgsize),
+			GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	spin_lock(&info->lock);
+
+	msg = mq_peek_at_offset(info, attr.offset);
+	if (!msg) {
+		spin_unlock(&info->lock);
+		kvfree(kbuf);
+		return -ENOMSG;
+	}
+
+	/*
+	 * Copy the payload under the lock using pure memcpy() (no page
+	 * faults), then transfer to userspace after releasing the lock.
+	 */
+	ret = mq_msg_copy_to_buf(msg, kbuf,
+				 min_t(size_t, attr.buf_len,
+				       info->attr.mq_msgsize));
+	attr.msg_prio = msg->m_type;
+
+	spin_unlock(&info->lock);
+
+	if (copy_to_user(attr.buf, kbuf, ret) ||
+	    copy_to_user(uattr, &attr, sizeof(attr)))
+		ret = -EFAULT;
+
+	kvfree(kbuf);
+	return ret;
+}
+
 static struct inode *mqueue_get_inode(struct super_block *sb,
 		struct ipc_namespace *ipc_ns, umode_t mode,
 		struct mq_attr *attr)
-- 
2.34.1

