Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0A4A33F9;
	Mon, 20 Apr 2026 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691966; cv=none; b=EjQjFgBYRNsefQouzYIqzqiwPJ402FKOAYODNo/t+6+pzIQW1eiJ94Ly4BfqbHZU660/PH8CIXYr5zE67hS5gS3PikJx7KUeEfVHPVrv7jV1fz3uzM5ehMIlYWOSIJcBdmV/nFwySL9BkS87Nh46Yu1SvUVimBguy3Qy+RVuwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691966; c=relaxed/simple;
	bh=gyXi7Wuu5MP4FEFcZJMgcVPb0NAvr7dTrU/QX0T4Gsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbXTXQEnoan1u/L08jXVBVI5N9Ftlf6mvWGu8ZM+NXx2F7gPZFCavTXUu9DrKZmaF99s+uYZpeCRkXmQMnnwV+oEmCh2zSbTuENbKHMK8b89sAgqJVJzIvUPjB+1LEQwAKIRgVIMmuRy6SJZi8VvtSPElmj1d/ICEe20mHjihSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0OQMdEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0OQMdEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515AFC19425;
	Mon, 20 Apr 2026 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691966;
	bh=gyXi7Wuu5MP4FEFcZJMgcVPb0NAvr7dTrU/QX0T4Gsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r0OQMdEgh7amMOCw1wRY/70I4tb0MmUD3a1N7c9Lm0qEtp69OD0/7DbxddYGaN00g
	 yjq6QO0Ph0GpfXlXskkAKKOCP9G152v4Gcb4iIa8hkNAMnjJznjNCT+4xN+rDUvHvK
	 ErAJFITXhyuFmfsUWIthDZyQUeJ6KeNVhk3MW2FzLczvs7mk6hR41HBE5M7WgGcN6P
	 5kXNGvNM4mq3WjvwUV9M+Na0fj+mKqH38GVteN7tCRWnrzRb3pmf3Y7Zq6KjH8fb+r
	 Ezk9Le8cF5HnjmDlhxk7CUccu+TIXz5+R4GHXGIpmq3lLDH/bhDugqktYlcWogk9VB
	 vjXEHFoJNE3iQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 20 Apr 2026 15:32:35 +0200
Subject: [PATCH 1/3] pidfs: fix PIDFD_THREAD flag loss when opening pidfds
 via file handles
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-work-pidfs-v1-1-4bd614e1cb33@kernel.org>
References: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
In-Reply-To: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2810; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gyXi7Wuu5MP4FEFcZJMgcVPb0NAvr7dTrU/QX0T4Gsg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+0/qlIjm/kP3B/29L3u3b7j3vxrsUtqSZXl867vNdN
 dhTv3/q1I5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ1Egw/LM6fO8pt7mwzMqN
 jhc2bX7zIn+L1I0i58tM/3/J117dGB3H8L9C+FTtRaNtbSuT3fs+L2f0XK17oXVn6A5fS7PATo2
 uxdwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

pidfs_export_open() calls dentry_open() which internally calls
do_dentry_open() that strips O_EXCL from f_flags. Since PIDFD_THREAD is
defined as O_EXCL, thread pidfds opened via open_by_handle_at() silently
lose their thread-specific scope.

pidfs_alloc_file() already handles this by explicitly restoring the
PIDFD_THREAD flag after dentry_open() returns. Factor the common
dentry_open() + flag restoration into a shared pidfs_open_file() helper
and use it from both call sites.

Without this fix, a pidfd obtained via open_by_handle_at() with O_EXCL
will have PIDTYPE_TGID scope instead of PIDTYPE_PID scope, causing
pidfd_send_signal() to deliver signals to the entire thread group
instead of the specific thread.

Fixes: 30915e955528 ("pidfs: convert to path_from_stashed() helper")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index e3825ee246be..11eb53f3e50a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -897,14 +897,28 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
 	return 0;
 }
 
+/*
+ * Open a pidfs dentry. Pidfds are always O_RDWR and PIDFD_THREAD (O_EXCL)
+ * must be restored after dentry_open() as do_dentry_open() strips it.
+ */
+static struct file *pidfs_open_file(const struct path *path, unsigned int flags)
+{
+	struct file *f;
+
+	flags |= O_RDWR;
+	f = dentry_open(path, flags, current_cred());
+	if (!IS_ERR(f))
+		f->f_flags |= (flags & PIDFD_THREAD);
+	return f;
+}
+
 static struct file *pidfs_export_open(const struct path *path, unsigned int oflags)
 {
 	/*
-	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
-	 * O_RDWR as pidfds always are.
+	 * Clear O_LARGEFILE as open_by_handle_at() forces it.
 	 */
 	oflags &= ~O_LARGEFILE;
-	return dentry_open(path, oflags | O_RDWR, current_cred());
+	return pidfs_open_file(path, oflags);
 }
 
 static const struct export_operations pidfs_export_operations = {
@@ -1086,7 +1100,6 @@ static struct file_system_type pidfs_type = {
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 {
-	struct file *pidfd_file;
 	struct path path __free(path_put) = {};
 	int ret;
 
@@ -1104,13 +1117,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	VFS_WARN_ON_ONCE(!pid->attr);
 
 	flags &= ~PIDFD_STALE;
-	flags |= O_RDWR;
-	pidfd_file = dentry_open(&path, flags, current_cred());
-	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
-	if (!IS_ERR(pidfd_file))
-		pidfd_file->f_flags |= (flags & PIDFD_THREAD);
-
-	return pidfd_file;
+	return pidfs_open_file(&path, flags);
 }
 
 void __init pidfs_init(void)

-- 
2.47.3

