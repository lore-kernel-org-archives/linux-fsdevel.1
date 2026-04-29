Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523B298CA5;
	Wed, 29 Apr 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472513; cv=none; b=Gk0lWacTyPT9WZy/YtPWbXOvj46wldPWRjCstGcac5n24gf86SvaeoyCt2oBsMtMoqblWaeDE6oXyr3nZbTPAwrpzrHQ4wdkyrHNgbh+JgBkTjADEqb3H0Xb5EFUDAd1g/CazQsCAs0IlhlBaijJP6I2ykG2ug/ldso4wsz88VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472513; c=relaxed/simple;
	bh=z5rYkdnrSYr1cJN0VdBRoqEf8lHJTx3beUWkK3c3G2w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y17oRPujYYYCHQmerFd4Yt7BNY4IVJZ9oqyB3GnszR5aROJqWdK7jC6Ztj2bNJX9WevVxKg8RpNwOkcm9x1ukKOWtNLdgqqN2BuqlSbO6X83MxIoZvvw2UX4xmyzYmGOt8EBBLgWup1MGtE+WhvDrl1VLdKcnzDVTHqH23Yp/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVDXqMgZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVDXqMgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC400C2BCB8;
	Wed, 29 Apr 2026 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472512;
	bh=z5rYkdnrSYr1cJN0VdBRoqEf8lHJTx3beUWkK3c3G2w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BVDXqMgZqS4MB4GQBArLRqnO+UQEiVpZ8s77TU0NeIHfM5jECR8RAzRox4oKMzH/M
	 kPFgNI1tQTYBkHPm8aQzUHoegTWYkM3APldan62Uzy/RBW0a9P6MmlJpE7BKAzscT0
	 oKMOiAlW+6s0OhEzA2OD1lfVS2cwxmExkYJG8dsqL0+wCh84tZQGpvxpvXw2msF7SZ
	 OEWV1py+/Yn0+EAi4P13yYLJUgJ2lI9TfWZ9re21EY3nsWebf5kZKEeklcU/F+VjhP
	 3RzWTKGGPYD6SkNMV/KhKhpSzV/jbYdm4z6gHIcOoKmqsQFB6ARuTy+QHBG+IAJRPS
	 BIaxkEEduC3Gg==
Date: Wed, 29 Apr 2026 07:21:52 -0700
Subject: [PATCH 1/4] fuse: flush pending FUSE_RELEASE requests before sending
 FUSE_DESTROY
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747204010.4101397.3285870017286262302.stgit@frogsfrogsfrogs>
In-Reply-To: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
References: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

generic/488 fails with fuse2fs in the following fashion:

generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
(see /var/tmp/fstests/generic/488.full for details)

This test opens a large number of files, unlinks them (which really just
renames them to fuse hidden files), closes the program, unmounts the
filesystem, and runs fsck to check that there aren't any inconsistencies
in the filesystem.

Unfortunately, the 488.full file shows that there are a lot of hidden
files left over in the filesystem, with incorrect link counts.  Tracing
fuse_request_* shows that there are a large number of FUSE_RELEASE
commands that are queued up on behalf of the unlinked files at the time
that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
aborted, the fuse server would have responded to the RELEASE commands by
removing the hidden files; instead they stick around.

For upper-level fuse servers that don't use fuseblk mode this isn't a
problem because libfuse responds to the connection going down by pruning
its inode cache and calling the fuse server's ->release for any open
files before calling the server's ->destroy function.

For fuseblk servers this is a problem, however, because the kernel sends
FUSE_DESTROY to the fuse server, and the fuse server has to write all of
its pending changes to the block device before replying to the DESTROY
request because the kernel releases its O_EXCL hold on the block device.
This means that the kernel must flush all pending FUSE_RELEASE requests
before issuing FUSE_DESTROY.

For fuse-iomap servers this will also be a problem because iomap servers
are expected to release all exclusively-held resources before unmount
returns from the kernel.

Create a function to push all the background requests to the queue
before sending FUSE_DESTROY.  That way, all the pending file release
events are processed by the fuse server before it tears itself down, and
we don't end up with a corrupt filesystem.

Note that multithreaded fuse servers will need to track the number of
open files and defer a FUSE_DESTROY request until that number reaches
zero.  An earlier version of this patch made the kernel wait for the
RELEASE acknowledgements before sending DESTROY, but the kernel people
weren't comfortable with adding blocking waits to unmount.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_i.h |    3 +++
 fs/fuse/dev.c    |   18 ++++++++++++++++++
 fs/fuse/inode.c  |   10 +++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 17423d4e3cfa67..f83bd090ca28ea 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1286,6 +1286,9 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/* Flush all pending requests but do not wait for them. */
+void fuse_flush_requests(struct fuse_conn *fc);
+
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a909..2ff09d9f101d00 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2436,6 +2436,24 @@ static void end_polls(struct fuse_conn *fc)
 	}
 }
 
+/*
+ * Flush all pending requests but do not wait for them.  Only call this
+ * function when it is no longer possible for other threads to add requests.
+ */
+void fuse_flush_requests(struct fuse_conn *fc)
+{
+	spin_lock(&fc->lock);
+	spin_lock(&fc->bg_lock);
+	if (fc->connected) {
+		/* Push all the background requests to the queue. */
+		fc->blocked = 0;
+		fc->max_background = UINT_MAX;
+		flush_bg_queue(fc);
+	}
+	spin_unlock(&fc->bg_lock);
+	spin_unlock(&fc->lock);
+}
+
 /*
  * Abort all requests.
  *
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index deddfffb037fb8..21e55080faee2d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2113,8 +2113,16 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
-	if (fc->destroy)
+	if (fc->destroy) {
+		/*
+		 * Flush all pending requests before sending FUSE_DESTROY.  The
+		 * fuse server must reply to the flushed requests before
+		 * handling FUSE_DESTROY because unmount is about to release
+		 * its O_EXCL hold on the block device.
+		 */
+		fuse_flush_requests(fc);
 		fuse_send_destroy(fm);
+	}
 
 	fuse_abort_conn(fc);
 	fuse_wait_aborted(fc);

