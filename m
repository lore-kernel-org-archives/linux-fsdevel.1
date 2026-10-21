Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587123;
	b=XBOYN6m/E1LJsRBjoHeLcnpPdBgeyUYzcjeey9wxPGORGE6KMkXKk8ZHX8z8tqomMfwr
	 OMW2DMRHbBfPfBwKeBHYr+U/hDHvP/yaoU6sN8N0opoB3KvPcY0ilSiTJbT1V6JxgU/Qn
	 TLj1oYAKvqe5bO4aOYKMwmcfpCMBFnER/YEfFLl8Iu02JA1ZMa+xP9/7r95BYdNCKbGWX
	 IyveF/XHkNLp+h6I6ooxhu9+g0IQN2xMBYJ940AE0PYKQWMsECe3TOMkzfj7qPE3S7+lp
	 tTUB+8vrK2AQ7X0opcXpbQzU4zrRBC0ZGi3+uQtiTIl9uqgKuLh3XA3I0x+Gdm35GLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NqgNTIU8DzhUyVmfZ9IEslpzXfUEbYHbQzea+4YWsnA=;
	b=I5mVwmvreRtKXzldHC7KF04ztftYhIlrKKDcgaDAZT9XVbw2HF4Qcz2Mcoc+SSzqvQ6I
	 Ld7syydjwVbgInpfITl6NoKrPrQRbBW4OUCwNGF6iBxEXvuQtTec0dHcUX/WmiIoq99hr
	 8O7r7zU/waLZAphkzBw2l2VX3L3e/wxcUm7gnidwcCpG1v7nvK6ej/F1e+mtFbP9jTI+Y
	 2mDSTee0OYRtP6zqKe9wsuF08qiCNnGK2InBFdfwyUJ+14eLKIsKzo8+Dw5EbyI3A7p2L
	 sumq/pS4+eaeQKEYPhZNXvMWKH76dFO3fK0dK2OtUstczKw+cmhM9ZrtJUNPPw2IPzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dsgd3ogS;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4A760A2602
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 12:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E4A760A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dsgd3ogS
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so970872a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587122; x=1793191922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NqgNTIU8DzhUyVmfZ9IEslpzXfUEbYHbQzea+4YWsnA=;
        b=Dsgd3ogSlQcPBJBCZ31wb+xZztOMjZNuOOUcbagbQ8lgOSc/ZuMB0N+wT4pScjpfUl
         xyD4PivUQIXT6h8CaM2YqN8J4DrZaqBvZztxzIqIor1S5L96bi2FuWFpHhkAXZ76ItCk
         3Xh83I9s+Mar1lz5AUysvz0JrW21TslJ8PiJQVYWhYjjGCU8LFzEfOPs5qvX0FJ9aX4q
         s/83ztYY93krzbrXDYVgOEDc+qo//tw3EeVxdBxxvLU4WM4y41I8oTzxlW9lbeO3Mttr
         LgQRzm9rH/yOiGWqheyWUPMdlZyHkZW36wA27d+z/A+dXH7u76rYgTyZYXTjE7Aj/o5K
         5ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587122; x=1793191922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NqgNTIU8DzhUyVmfZ9IEslpzXfUEbYHbQzea+4YWsnA=;
        b=LXDxg8B1CrvFQzBJJw6hPqQodaKBQfrZ9jHPhcsQhA+JHxQPRLvTyjCcgc0INCHeeV
         CCf1G5gcwa/pcv43w7dt3StAZkSlNxLEpjWdq6A4n3ThYCh+3d2zPAvAHSioJS+vFCgM
         U0xYcFBLG9lDmtuqMN294PFbI7q7YdS5zn+t2lJ8c+cIawHd8Q0JAyZKIb8O8jzwZbaY
         K1AmSC7nhBumFznARmmePxlKf/Bn1vvBkTgZWmF7mubobldEb56PNTdg+LT5MDyb47DV
         cK8lgH/ETjhFXyp8Kgi2IIkdzrOh1wsK7ViRbHTondAvVcBJdVERFar0rQGBRKPHNDq6
         qXrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwruJTuPiZUN6v0N72Vrnpa8ehjrQOs07ud/VhUb+F28a+1EfFiUqt5ljqe09SAKxtbI67AY4f3Wn2CGxvl@vger.kernel.org
X-Gm-Message-State: AFq9FYLol3xvHO51EGjfGCcMW0L6i+kjjud0Fa77pQagLxjfOQw32oOk
	QpVnkNoTMjhaOnh4RgrvrBwhzjNhBBhXsKcMUe2r4HmzzhJfkb7bFI60
X-Gm-Gg: AYBFou0JpZJQUZIonPhdCYn1yzRbYAP/KQITMvJ4lCTTMsb0IiSC8h00ebdwVtx9p3v
	Gt/R8Beha2HK93DyibRDNTuhwSJkelI9lo+tTmBnu0QW4zbguMXGMWjdSxSx1HaYuR9cbcRAoYA
	3fG0xb+eYDpGdxDzMjUJUJkGJNFIW9t5mhm27mJ8OnR9tFI6Vtm+4CAG/owSfyXO8Lu6Y2WPWDK
	EHAX+bzGhVlJuImVmwfip5uTR2y0QaX61zqdqXrDLjbcBpnhThbjU+32F4pBAmRkt0lqL186RiQ
	7NyzhlEnWSuFCCXsGJC1if6qBTwMaItWz1XmVYxm7N5UHIZZT9jwscngJLu71c0bbhY4K0fuySf
	qIgWIxDc9Zu3Y/DESeVyCCbtZ0IfiUgMxc43LfFkT35se+UGptXsJEKqnOrGBmJuiKtVjnK3POm
	EoQ5nHklXrOBcNSevBue931t2w3aInMIH1Z7UnqtzuBNskRrD7n7uSPLbr4A/um42bPJz1jw8mZ
	zx7T4h+B2sHTVgS20TO/f2WkE0Ph2yNy77EZ4zQ83OR8KzBusNuUSw/ViV2aiig0fmFfNH4L89K
	h+CNZI7Gr/O+z/3/CBKTh0v4EZGYPGxFDV8yDBLa2V5D7FdoIJVKWivtJ71qez0bgGprjWQlkNI
	VE/MGwcg2SB8bv0S28UZzjhr72sqk+mBj8G4YKlN3Mjk0vjT/U3Oc8Ji8iSknULxwrcD8X5QqUa
	fVjm3HrUNzAk1KBxEEq0Q2g8lO
X-Received: by 2002:a17:907:9d1a:b0:c46:7462:6332 with SMTP id a640c23a62f3a-c46797a6203mr156125566b.37.1792587121409;
        Wed, 21 Oct 2026 05:52:01 -0700 (PDT)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4679004464sm73128366b.67.2026.10.21.05.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:52:00 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Kent <raven@themaw.net>
Cc: Tejun Heo <tj@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	driver-core@lists.linux.dev,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH 2/2] autofs: do not wait for the daemon while splice holds a pipe
Date: Wed, 21 Oct 2026 14:51:50 +0200
Message-ID: <fec81a3d24a29d4db2b165e95425330e41a68d98.1792577179.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792577179.git.krystianmkaniewski@gmail.com>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com> <cover.1792577179.git.krystianmkaniewski@gmail.com>
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

splice holds the mutex of a pipe while it calls ->write_iter() of the
target file in iter_file_splice_write() or ->splice_read() of the source
file in splice_file_to_pipe(). When such a callback looks up a path in an
autofs mount, autofs sends a request through its daemon pipe and waits
for the daemon. A write to /sys/power/resume that comes from splice() does
this, so lockdep still reports &pipe->mutex --> &sbi->pipe_mutex -->
&pipe->mutex after of->mutex is gone from the sysfs store path. When the
spliced pipe is the daemon pipe itself, the task can wait for the mutex
that it already holds, which SIGKILL does not end, or wait for a daemon
that cannot read its pipe.

Mark the task while splice runs such a callback with a pipe really locked
(pipe->files set, as in pipe_lock()), and make autofs return -EAGAIN in
that context instead of sending a mount request or waiting for a pending
mount or expire. A new mount is refused before AUTOFS_INF_PENDING is set,
because another lookup that sees the flag would send the request instead.
The short wait for expire selection does not depend on the daemon and is
kept. RCU walks, lookups that need no request and all other callers keep
their behavior, and a child does not inherit the mark.

A lookup from such a callback that needs an automount now fails with
-EAGAIN instead of waiting for the daemon. This affects splice() from a
pipe into a file whose write handler looks up a path under an autofs
mount that is not mounted yet, for example /sys/power/resume. sendfile()
into a file goes through the private pipe of the task, which is never
locked, and keeps its behavior.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
 fs/autofs/expire.c    |  6 ++++++
 fs/autofs/root.c      | 28 ++++++++++++++++++++++++++--
 fs/splice.c           | 13 ++++++++++++-
 include/linux/sched.h |  2 ++
 kernel/fork.c         |  1 +
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 5c2d459e1e484..9f3bf1473acd4 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -514,6 +514,12 @@ int autofs_expire_wait(const struct path *path, int rcu_walk)
 	}
 	if (state & AUTOFS_INF_EXPIRING) {
 		spin_unlock(&sbi->fs_lock);
+		/*
+		 * The expire waits for the daemon, which may need a pipe that
+		 * the splice of this task holds. Refuse instead of waiting.
+		 */
+		if (unlikely(current->in_splice_pipe_callback))
+			return -EAGAIN;
 
 		pr_debug("waiting for expire %p name=%pd\n", dentry, dentry);
 
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index b36439f4521eb..c4e04998a2345 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -252,6 +252,8 @@ static int autofs_mount_wait(const struct path *path, bool rcu_walk)
 	if (ino->flags & AUTOFS_INF_PENDING) {
 		if (rcu_walk)
 			return -ECHILD;
+		if (unlikely(current->in_splice_pipe_callback))
+			return -EAGAIN;
 		pr_debug("waiting for mount name=%pd\n", path->dentry);
 		status = autofs_wait(sbi, path, NFY_MOUNT);
 		pr_debug("mount wait done status=%d\n", status);
@@ -263,10 +265,18 @@ static int autofs_mount_wait(const struct path *path, bool rcu_walk)
 	return status;
 }
 
+static bool autofs_expire_wait_blocked(int status)
+{
+	/* A marked caller is refused before a daemon can return a status. */
+	return status == -EAGAIN &&
+	       unlikely(current->in_splice_pipe_callback);
+}
+
 static int do_expire_wait(const struct path *path, bool rcu_walk)
 {
 	struct dentry *dentry = path->dentry;
 	struct dentry *expiring;
+	int status;
 
 	expiring = autofs_lookup_expiring(dentry, rcu_walk);
 	if (IS_ERR(expiring))
@@ -280,7 +290,11 @@ static int do_expire_wait(const struct path *path, bool rcu_walk)
 		 * be quite complete, but the directory has been removed
 		 * so it must have been successful, just wait for it.
 		 */
-		autofs_expire_wait(&this, 0);
+		status = autofs_expire_wait(&this, 0);
+		if (autofs_expire_wait_blocked(status)) {
+			dput(expiring);
+			return status;
+		}
 		autofs_del_expiring(expiring);
 		dput(expiring);
 	}
@@ -359,6 +373,8 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 	 * the mount.
 	 */
 	status = do_expire_wait(path, 0);
+	if (autofs_expire_wait_blocked(status))
+		return ERR_PTR(-EAGAIN);
 	if (status && status != -EAGAIN)
 		return NULL;
 
@@ -405,6 +421,11 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 				goto done;
 			}
 		}
+		/* Do not publish PENDING without issuing its mount request. */
+		if (unlikely(current->in_splice_pipe_callback)) {
+			spin_unlock(&sbi->fs_lock);
+			return ERR_PTR(-EAGAIN);
+		}
 		ino->flags |= AUTOFS_INF_PENDING;
 		spin_unlock(&sbi->fs_lock);
 		status = autofs_mount_wait(path, 0);
@@ -442,8 +463,11 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 	}
 
 	/* Wait for pending expires */
-	if (do_expire_wait(path, rcu_walk) == -ECHILD)
+	status = do_expire_wait(path, rcu_walk);
+	if (status == -ECHILD)
 		return -ECHILD;
+	if (autofs_expire_wait_blocked(status))
+		return -EAGAIN;
 
 	/*
 	 * This dentry may be under construction so wait on mount
diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1ab..1756a8579776f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -686,6 +686,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		struct kiocb kiocb;
 		struct iov_iter from;
 		unsigned int head, tail;
+		bool was_in_splice_pipe_callback;
 		size_t left;
 		int n;
 
@@ -733,7 +734,11 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
 		init_sync_kiocb(&kiocb, out);
 		kiocb.ki_pos = sd.pos;
+		was_in_splice_pipe_callback = current->in_splice_pipe_callback;
+		if (pipe->files)
+			current->in_splice_pipe_callback = true;
 		ret = out->f_op->write_iter(&kiocb, &from);
+		current->in_splice_pipe_callback = was_in_splice_pipe_callback;
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
@@ -1282,12 +1287,18 @@ ssize_t splice_file_to_pipe(struct file *in,
 			    loff_t *offset,
 			    size_t len, unsigned int flags)
 {
+	bool was_in_splice_pipe_callback;
 	ssize_t ret;
 
 	pipe_lock(opipe);
 	ret = wait_for_space(opipe, flags);
-	if (!ret)
+	if (!ret) {
+		was_in_splice_pipe_callback = current->in_splice_pipe_callback;
+		if (opipe->files)
+			current->in_splice_pipe_callback = true;
 		ret = do_splice_read(in, offset, opipe, len, flags);
+		current->in_splice_pipe_callback = was_in_splice_pipe_callback;
+	}
 	pipe_unlock(opipe);
 	if (ret > 0)
 		wakeup_pipe_readers(opipe);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 705970d07614f..3ffa284976cc6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1025,6 +1025,8 @@ struct task_struct {
 	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
+	/* A file callback is running while splice holds a pipe mutex. */
+	unsigned			in_splice_pipe_callback:1;
 #ifndef TIF_RESTORE_SIGMASK
 	unsigned			restore_sigmask:1;
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 5ef413368912e..d774e5092766c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2133,6 +2133,7 @@ __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
+	p->in_splice_pipe_callback = 0;
 	/*
 	 * Must run before the first fallible op, so error paths never
 	 * free the parent's ret_stack.
-- 
2.53.0

