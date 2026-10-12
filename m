Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352E361657;
	Mon, 12 Oct 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810930; cv=none; b=WCBM8l5dVSq5iTKlREFUoN1euFDIAL1Iy51abfOBz48Ek8K89b0ZjyWmZEfIu6r8jSXEKYM5o69Ev7N923w2ZfaR9FJLpAfSz5sielOYftXWhmkOD9+ghPophWfEMRMF7MTISmnV8/sEMneFLzJQZM5q5yDaXJqhvPh6qWoFY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810930; c=relaxed/simple;
	bh=87Z5wXakwM2SBA0LtA98Xz97ueWTs8gUlnp4z9EuICg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1Mm4nEZc7l38E9NB6/OwJECBUy9OOO9+wUYWRpuYotM0YoYlBoOKNA/rrVlQm3ka+YVcWG7XQMzW6voVzMo1rdX9M9j6AfWynZMQIkLDuO/RcmeHqeQEx6h6RaSNq6/dwISmUQPD7/EUW7aSSG4EEs7YgIGjdr8DDXWgmwFilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWcQoxwR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWcQoxwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6180F1F0089C;
	Mon, 12 Oct 2026 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810928;
	bh=5fFmmsalEJ8rn/mFFObhE7/w2pmhRmvhmfuadykfxNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oWcQoxwRhBf76ez8SbqVtF8aQhUdwv3gXrmKfhGgR/ndPg6qP/F+PSDIBLwCLiBL+
	 Bjiw+FGMtkJHFGBCR6ScH1IUfx0SX4DwHEhICJTH0/GKYID2WYA+H4X43U9FjBD19p
	 HTMKgR+4Wez7HED3LI1GXfeYdM261jZR6pDeuKL8UdByl8V8EHJadhTplfbCQcjkfx
	 Sq1B/DP3ypdB/QIfn8lgyms7tZF/pdfkSy5UYoT6gaOSV5K/wrT0k81Spi2cEySmvI
	 kMM7Ma1qXRh2/M47s0Rtw1raX19NMiLSAgl+4O7RqEDBhYWRKLxBKNvDY+J9mqDRCx
	 B0g/bOmaey02g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 15:15:16 +0200
Subject: [PATCH 2/4] namei: check for removed names in LOOKUP_REVAL walks
 too
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-namei-reval-v1-2-515664de33b5@kernel.org>
References: <20261012-work-namei-reval-v1-0-515664de33b5@kernel.org>
In-Reply-To: <20261012-work-namei-reval-v1-0-515664de33b5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Neil Brown <neil@brown.name>, 
 Jan Kara <jack@suse.cz>, fuse-devel@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10555; i=brauner@kernel.org;
 h=from:subject:message-id; bh=87Z5wXakwM2SBA0LtA98Xz97ueWTs8gUlnp4z9EuICg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSduZvOzLaqfNqt2cHLT8Z8nPKx/E3YLKe7Nr1y/5il1
 2RxeVlzdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkJYPhv/MfhaPJrdGaIt+m
 XxJYPz91AosFr/7tPL5/10/HvZSIV2P47/rgqkh1zJFNNQ3672xF3qWfOWl5cdnsbYpXL67jLBF
 oYQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Chris reported that a walk with LOOKUP_REVAL can still open the file
under the mounts of a name that was unlinked while the walk looked at
it. unlink_may_reveal() skips its check for LOOKUP_REVAL because that is
the last attempt. But any -ESTALE from an earlier component gets a walk
there, e.g., one that a FUSE server hands back from ->lookup() or
->get_link(), and then the race can be won just the same.

His fix repeats the LOOKUP_REVAL walk for as long as it runs into a
removed name. Nothing bounds that loop though. A FUSE server can unlink
a name whenever it is asked to revalidate it and have it looked up again
whenever it is asked to revalidate the parent. With a raw FUSE server
doing that a single open() did 28452 LOOKUP_REVAL walks in 20 seconds
and kept going until the server stopped.

So don't repeat anything. Make the check in every refwalk. A walk
without LOOKUP_REVAL still fails with -ESTALE and is repeated with
LOOKUP_REVAL. That is the last attempt and if a name lost its mounts
under it as well it fails with -ENOENT.

This relies on the previous patch. Without it the check fires for any
name that is removed under a walk and turns a harmless race into a
spurious -ENOENT. In a storm like the one in the previous patch open()
failed with -ENOENT 19 times in 15.7 million calls.

The reproducer below mounts a tmpfs file on f1 in an open_tree() copy of
a raw FUSE mount and opens f1 through a symlink whose first readlink
fails with -ESTALE, so the open is repeated with LOOKUP_REVAL. In that
walk the FUSE server answers the revalidation of f1 only after another
thread had f1 unlinked through the FUSE mount itself. On 7.3.0-rc6 with
the previous patch the open reads what the tmpfs file covered. With
this patch it fails with -ENOENT. The selftest at the end of this series
covers this and the walk that never ends.

  // SPDX-License-Identifier: GPL-2.0
  /*
   * reval_reveal: a walk with LOOKUP_REVAL must not open what a mount
   * covered when the name under the mount is unlinked while the walk
   * looks at it.
   *
   * F is a fuse mount with the file f1 and the symlink lnk -> f1. F' is
   * an open_tree() copy of F with a tmpfs file mounted on F'/f1. A child
   * opens F'/lnk. Its first readlink fails with ESTALE, so the open is
   * repeated with LOOKUP_REVAL. In that walk the server answers the
   * revalidation of f1 only after it had F/f1 unlinked, which detaches
   * the mount. Reading "UNDER" means the walk opened f1 under the
   * detached mount.
   */
  #define _GNU_SOURCE
  #include <errno.h>
  #include <fcntl.h>
  #include <pthread.h>
  #include <sched.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mount.h>
  #include <sys/stat.h>
  #include <sys/syscall.h>
  #include <sys/uio.h>
  #include <sys/wait.h>
  #include <unistd.h>
  #include <linux/fuse.h>
  #include <linux/mount.h>

  #define DIR	"/tmp/rr"
  #define F	DIR "/F"

  static int ffd, todo[2], done[2];
  static volatile pid_t child;
  static volatile int estale = 1, unlink_f1 = 1, f1_gone;

  static void die(const char *what)
  {
  	fprintf(stderr, "FATAL %s: %s\n", what, strerror(errno));
  	exit(2);
  }

  static void reply(uint64_t unique, int error, const void *data,
  		  size_t len)
  {
  	struct fuse_out_header oh = {
  		sizeof(oh) + (error ? 0 : len), error, unique
  	};
  	struct iovec iov[2] = { { &oh, sizeof(oh) }, { (void *)data, len } };

  	if (writev(ffd, iov, (error || !len) ? 1 : 2) < 0)
  		return;
  }

  static void entry(uint64_t unique, uint64_t id)
  {
  	struct fuse_entry_out e = {
  		.nodeid = id, .generation = 1, .entry_valid = 3600, .attr_valid = 3600,
  		.attr = { .ino = id, .nlink = 1, .blksize = 4096, .size = 5,
  			  .mode = id == 2 ? S_IFREG | 0644 : S_IFLNK | 0777 },
  	};

  	reply(unique, 0, &e, sizeof(e));
  }

  static void *server(void *arg)
  {
  	static __thread char buf[FUSE_MIN_READ_BUFFER + 65536];
  	struct fuse_in_header *ih = (void *)buf;
  	char *in = buf + sizeof(*ih);
  	char c = 0;

  	for (;;) {
  		if (read(ffd, buf, sizeof(buf)) < (ssize_t)sizeof(*ih)) {
  			if (errno == EINTR)
  				continue;
  			return NULL;
  		}
  		switch (ih->opcode) {
  		case FUSE_INIT: {
  			struct fuse_init_out o = { .major = FUSE_KERNEL_VERSION,
  				.minor = FUSE_KERNEL_MINOR_VERSION, .max_write = 4096 };

  			reply(ih->unique, 0, &o, sizeof(o));
  			break;
  		}
  		case FUSE_LOOKUP:
  			if (!strcmp(in, "lnk")) {
  				entry(ih->unique, 3);
  			} else if (!strcmp(in, "f1") && (pid_t)ih->pid == child &&
  				   __sync_lock_test_and_set(&unlink_f1, 0)) {
  				/* have F/f1 unlinked before answering */
  				if (write(todo[1], &c, 1) != 1 || read(done[0], &c, 1) != 1)
  					die("helper");
  				entry(ih->unique, 2);
  			} else if (!strcmp(in, "f1") && !f1_gone) {
  				entry(ih->unique, 2);
  			} else {
  				reply(ih->unique, -ENOENT, NULL, 0);
  			}
  			break;
  		case FUSE_GETATTR: {
  			struct fuse_attr_out o = {
  				.attr_valid = 3600,
  				.attr = { .ino = ih->nodeid, .nlink = 1, .size = 5,
  					  .mode = ih->nodeid == 1 ? S_IFDIR | 0755 :
  						  ih->nodeid == 2 ? S_IFREG | 0644 :
  						  S_IFLNK | 0777 },
  			};

  			reply(ih->unique, 0, &o, sizeof(o));
  			break;
  		}
  		case FUSE_READLINK:
  			if ((pid_t)ih->pid == child && __sync_lock_test_and_set(&estale, 0))
  				reply(ih->unique, -ESTALE, NULL, 0);
  			else
  				reply(ih->unique, 0, "f1", 2);
  			break;
  		case FUSE_OPEN: {
  			struct fuse_open_out o = { .open_flags = FOPEN_DIRECT_IO };

  			reply(ih->unique, 0, &o, sizeof(o));
  			break;
  		}
  		case FUSE_READ:
  			reply(ih->unique, 0, "UNDER", 5);
  			break;
  		case FUSE_UNLINK:
  			f1_gone = 1;
  			/* fall through */
  		case FUSE_FLUSH:
  		case FUSE_RELEASE:
  			reply(ih->unique, 0, NULL, 0);
  			break;
  		case FUSE_FORGET:
  		case FUSE_BATCH_FORGET:
  		case FUSE_INTERRUPT:
  			break;
  		default:
  			reply(ih->unique, -ENOSYS, NULL, 0);
  		}
  	}
  }

  static void *helper(void *arg)
  {
  	char c;

  	while (read(todo[0], &c, 1) == 1) {
  		if (unlink(F "/f1"))
  			die("unlink F/f1");
  		if (write(done[1], &c, 1) != 1)
  			die("helper");
  	}
  	return NULL;
  }

  int main(void)
  {
  	char opts[64], buf[64] = "", c = 0;
  	int tfd, mfd, go[2], res[2], fd;
  	struct stat st;
  	pthread_t t;

  	if (unshare(CLONE_NEWNS) ||
  	    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL))
  		die("unshare");
  	mkdir(DIR, 0755);
  	if (mount("rr", DIR, "tmpfs", 0, NULL) || mkdir(F, 0755))
  		die("tmpfs");
  	fd = open(DIR "/cover", O_CREAT | O_WRONLY, 0644);
  	if (fd < 0 || write(fd, "COVER", 5) != 5)
  		die("cover");
  	close(fd);
  	ffd = open("/dev/fuse", O_RDWR);
  	snprintf(opts, sizeof(opts),
  		 "fd=%d,rootmode=40000,user_id=0,group_id=0", ffd);
  	if (ffd < 0 || mount("rr", F, "fuse", 0, opts))
  		die("fuse");
  	if (pipe(todo) || pipe(done) || pipe(go) || pipe(res))
  		die("pipe");
  	for (int i = 0; i < 4; i++)
  		pthread_create(&t, NULL, server, NULL);
  	pthread_create(&t, NULL, helper, NULL);

  	/* F' with the tmpfs file mounted on F'/f1 */
  	if (stat(F "/f1", &st))
  		die("stat F/f1");
  	tfd = syscall(SYS_open_tree, AT_FDCWD, F, OPEN_TREE_CLONE);
  	mfd = syscall(SYS_open_tree, AT_FDCWD, DIR "/cover", OPEN_TREE_CLONE);
  	if (tfd < 0 || mfd < 0 ||
  	    syscall(SYS_move_mount, mfd, "", tfd, "f1",
  		    MOVE_MOUNT_F_EMPTY_PATH))
  		die("cover F'/f1");

  	child = fork();
  	if (!child) {
  		if (read(go[0], &c, 1) != 1)
  			_exit(2);
  		fd = openat(tfd, "lnk", O_RDONLY);
  		if (fd < 0)
  			snprintf(buf, sizeof(buf), "%s", strerror(errno));
  		else if (read(fd, buf, sizeof(buf) - 1) < 0)
  			_exit(2);
  		_exit(write(res[1], buf, sizeof(buf)) != sizeof(buf));
  	}
  	if (write(go[1], &c, 1) != 1 ||
  	    read(res[0], buf, sizeof(buf)) != sizeof(buf))
  		die("child");
  	waitpid(child, NULL, 0);
  	printf("open of F'/lnk: %s\n", buf);
  	return !strcmp(buf, "UNDER");
  }

Fixes: 8189ab688f5a ("namei: don't reveal overmounted entries in refwalk")
Reported-by: Chris Mason <mason@kernel.org>
Link: https://patch.msgid.link/20261011161843.11360-1-mason@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namei.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9efc7426ebfb..63c3648b363a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2097,25 +2097,26 @@ static noinline const char *pick_link(struct nameidata *nd, struct path *link,
  * __detach_mounts() marks it before the mounts are detached, so a walk
  * that doesn't find them anymore sees the mark. Any other dentry is fine
  * to step onto. The walk found the name before it was removed.
+ *
+ * The walk fails with -ESTALE and is repeated with LOOKUP_REVAL. That is
+ * the last attempt, so there it fails with -ENOENT.
  */
-static bool unlink_may_reveal(struct nameidata *nd, int flags,
-			      struct path *path, struct dentry *dentry)
+static int unlink_may_reveal(struct nameidata *nd, int flags,
+			     struct path *path, struct dentry *dentry)
 {
 	/* ".." and LOOKUP_DOWN may land on an unhashed directory */
 	if (flags & WALK_NOFOLLOW)
-		return false;
-	if (nd->flags & LOOKUP_REVAL)
-		return false;
+		return 0;
 	/* We crossed onto a mount and the name led us here while it still existed */
 	if (path->mnt != nd->path.mnt)
-		return false;
+		return 0;
 	/* only a name that went away while covered is flagged */
 	if (likely(!(READ_ONCE(dentry->d_flags) & DCACHE_UNCOVERED)))
-		return false;
+		return 0;
 	if (!cant_mount(dentry) || !d_unlinked(dentry))
-		return false;
+		return 0;
 	dput(no_free_ptr(path->dentry));
-	return true;
+	return nd->flags & LOOKUP_REVAL ? -ENOENT : -ESTALE;
 }
 
 /*
@@ -2147,8 +2148,9 @@ static noinline const char *step_into_slowpath(struct nameidata *nd, int flags,
 			if (unlikely(!inode))
 				return ERR_PTR(-ENOENT);
 		} else {
-			if (unlikely(unlink_may_reveal(nd, flags, &path, dentry)))
-				return ERR_PTR(-ESTALE);
+			err = unlink_may_reveal(nd, flags, &path, dentry);
+			if (unlikely(err))
+				return ERR_PTR(err);
 			dput(nd->path.dentry);
 			if (nd->path.mnt != path.mnt)
 				mntput(nd->path.mnt);

-- 
2.53.0

