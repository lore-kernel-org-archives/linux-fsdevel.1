Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C734CFDA;
	Mon, 12 Oct 2026 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810927; cv=none; b=b0YqkxCs1bmNckQiJv1c4n+tpKqzSW2V5iUHq9zmDIfE9CMMDd0OTq+jkMByyUcuWfsl6aGBOF5JG6R/GKTw369Et8JaHCvdQXeHjegdYSFPz0Wpims2/RAeT55l5VzeWH6loN8RpKShgq2GwgGYfTGFxHDRv4ifc9RJ9xMABgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810927; c=relaxed/simple;
	bh=Vrqt48tfuZZeql0zE0BJDHXdXBc387X9XMMpXVIxJaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ObodVdml2ZcRuIK+lPQ6N7GCg7TSun/HEElLzFmwiNhvigYNc9KtolGxCnSLrgKFBehNgXjImUa+y47+FVw4RTC+A0Pd92pL/0Bs3I1na1Pk199LZFcpdb1ozDl7wybM2aIu0BbZZBvyVW5Gznl2LHTsB9+iYyWQEWhh8oLeuEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox7FwO0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox7FwO0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136401F0089D;
	Mon, 12 Oct 2026 13:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810925;
	bh=+TqyXxRTj5VM1SNYH5XtopExfQX5MjIvdBOZ96Mbjeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ox7FwO0tLONm0apVvNsOr49TG2VUGkfmpHI8QGTqBZMdvccAhyjPOHTnbb64oGIS2
	 AhJ11eOO0WHdwfyPuvDXwr+2VoWGfglGMZnZPvWs8AfU5HGzrAkqQ/ubp3ttiPwV/c
	 E2KRE3USjrY8Hc3HPlLZ3mXxyfTXNHgsAR05c8kB6pqvtCChHZrP1pTPfYXJ8t4b5K
	 QejoRpy0fK9qJ/O4xYhMB0CPRR/Cy+g+z/RCDQgntq5ayjY3+ogEwE+F51W3+vR5S4
	 fmuJMIvYNyZFWYtX2gCNzP8pXCZXlOzEocQJyoMS5YdLP32N6YJJ4GcVhCRnUanm5J
	 boUphOkbnfrsA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 15:15:15 +0200
Subject: [PATCH 1/4] namei: only refuse names that lost their mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-namei-reval-v1-1-515664de33b5@kernel.org>
References: <20261012-work-namei-reval-v1-0-515664de33b5@kernel.org>
In-Reply-To: <20261012-work-namei-reval-v1-0-515664de33b5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Neil Brown <neil@brown.name>, 
 Jan Kara <jack@suse.cz>, fuse-devel@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7347; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Vrqt48tfuZZeql0zE0BJDHXdXBc387X9XMMpXVIxJaw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSduZv+tfZ1ZF3Plet8WsdP7DsZwmcfUZRd8Fu8YaGsX
 fZf4zuNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5qc7wV8D03tr8hF/fLn+W
 ebND+Wl0XYvtw/CSTUdiZi86dkdk/1lGhjnhM/Vd/qtf+L74a5uS4heVKxtSjq3Z4pNS/DNX7G7
 BMkYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since commit 8189ab688f5a ("namei: don't reveal overmounted entries in
refwalk") a refwalk refuses any dentry that was unlinked or renamed over
after it found it and the walk is repeated with LOOKUP_REVAL. But
dont_mount() is called for every name that goes away, not just for
mountpoints. So any unlink or rename that races with a refwalk sends it
through another full walk with LOOKUP_REVAL. On NFS or FUSE that
revalidates every component of the path again.

Only a dentry that still had mounts when its name went away can reveal
what they covered. So let __detach_mounts() mark the dentry with
DCACHE_UNCOVERED when it unhashes it, before the mounts are detached,
and only refuse a dentry that carries the mark.

The mark lives in d_flags just like DCACHE_MOUNTED and is set under
d_lock before the mounts go. So a walk that doesn't find the mounts
anymore sees the mark too.

A dentry that had no mounts when its name went away is stepped onto
like before 8189ab688f5a. The walk found the name before it was removed
and there was nothing to cross.

The reproducer below has twelve threads unlink a name on tmpfs and
create it again while twelve more open it with O_CREAT. Counting the
walks that are repeated with LOOKUP_REVAL with

  cd /sys/kernel/tracing
  echo 'p:reval path_openat flags=%dx:x32' >> kprobe_events
  echo 'hist:keys=flags if flags & 0x80' > events/kprobes/reval/trigger
  echo 1 > events/kprobes/reval/enable
  ./unlink_storm -t 300
  cat events/kprobes/reval/hist

finds 463 of them in 16.8 million opens on a KASAN kernel. With this
patch there are none in 16.9 million.

  // SPDX-License-Identifier: GPL-2.0
  /*
   * unlink_storm: refwalks racing unlink() and create of a single name.
   *
   * Writers unlink "N" and create it again, readers open it with O_CREAT.
   * None of the opens may fail. Count the walks that were repeated with
   * LOOKUP_REVAL with a kprobe on path_openat().
   *
   *   usage: unlink_storm [-t secs] [-w writers] [-r readers]
   */
  #define _GNU_SOURCE
  #include <errno.h>
  #include <fcntl.h>
  #include <pthread.h>
  #include <stdatomic.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mount.h>
  #include <sys/stat.h>
  #include <unistd.h>

  #define DIR "/tmp/us"

  static atomic_int stop;
  static atomic_long opens, failed;
  static atomic_int first_err;

  static void *writer(void *arg)
  {
  	while (!atomic_load(&stop)) {
  		int fd;

  		unlink(DIR "/N");
  		fd = open(DIR "/N", O_CREAT | O_RDWR | O_CLOEXEC, 0644);
  		if (fd >= 0)
  			close(fd);
  	}
  	return arg;
  }

  static void *reader(void *arg)
  {
  	while (!atomic_load(&stop)) {
  		int fd = open(DIR "/N", O_CREAT | O_RDWR | O_CLOEXEC, 0644);

  		if (fd < 0) {
  			int none = 0;

  			atomic_compare_exchange_strong(&first_err, &none, errno);
  			atomic_fetch_add(&failed, 1);
  		} else {
  			close(fd);
  		}
  		atomic_fetch_add(&opens, 1);
  	}
  	return arg;
  }

  int main(int argc, char **argv)
  {
  	int secs = 60, nw = 12, nr = 12, c, n = 0;
  	pthread_t t[256];

  	while ((c = getopt(argc, argv, "t:w:r:")) != -1) {
  		switch (c) {
  		case 't': secs = atoi(optarg); break;
  		case 'w': nw = atoi(optarg); break;
  		case 'r': nr = atoi(optarg); break;
  		default: return 2;
  		}
  	}
  	if (nw + nr > 256)
  		return 2;
  	mkdir(DIR, 0755);
  	if (mount("us", DIR, "tmpfs", 0, NULL)) {
  		perror("tmpfs");
  		return 2;
  	}
  	for (int i = 0; i < nw; i++)
  		pthread_create(&t[n++], NULL, writer, NULL);
  	for (int i = 0; i < nr; i++)
  		pthread_create(&t[n++], NULL, reader, NULL);
  	sleep(secs);
  	atomic_store(&stop, 1);
  	for (int i = 0; i < n; i++)
  		pthread_join(t[i], NULL);
  	printf("%ds: %ld opens, %ld failed%s%s\n", secs, atomic_load(&opens),
  	       atomic_load(&failed), first_err ? ", the first with " : "",
  	       first_err ? strerror(first_err) : "");
  	umount2(DIR, MNT_DETACH);
  	return atomic_load(&failed) ? 1 : 0;
  }

Fixes: 8189ab688f5a ("namei: don't reveal overmounted entries in refwalk")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namei.c             | 11 ++++++++---
 fs/namespace.c         |  8 ++++++--
 include/linux/dcache.h |  3 ++-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c87c14ee1a25..9efc7426ebfb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2092,6 +2092,11 @@ static noinline const char *pick_link(struct nameidata *nd, struct path *link,
  * don't reveal the underyling dentry during refwalk. In rcuwalk we
  * catch this via d_seq and another lookup for the name. Give the same
  * guarantee in refwalk.
+ *
+ * Only a dentry that still had mounts when its name went away matters.
+ * __detach_mounts() marks it before the mounts are detached, so a walk
+ * that doesn't find them anymore sees the mark. Any other dentry is fine
+ * to step onto. The walk found the name before it was removed.
  */
 static bool unlink_may_reveal(struct nameidata *nd, int flags,
 			      struct path *path, struct dentry *dentry)
@@ -2104,10 +2109,10 @@ static bool unlink_may_reveal(struct nameidata *nd, int flags,
 	/* We crossed onto a mount and the name led us here while it still existed */
 	if (path->mnt != nd->path.mnt)
 		return false;
-	/* only a name on its way out is flagged */
-	if (likely(!cant_mount(dentry)))
+	/* only a name that went away while covered is flagged */
+	if (likely(!(READ_ONCE(dentry->d_flags) & DCACHE_UNCOVERED)))
 		return false;
-	if (!d_unlinked(dentry))
+	if (!cant_mount(dentry) || !d_unlinked(dentry))
 		return false;
 	dput(no_free_ptr(path->dentry));
 	return true;
diff --git a/fs/namespace.c b/fs/namespace.c
index 3ed3766f3a18..54dcdb88513a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2029,7 +2029,8 @@ static int do_umount(struct mount *mnt, int flags)
  * leaking them.
  *
  * The dentry is unhashed before the mounts go so that no lookup finds
- * what they covered. The caller removes it for good afterwards.
+ * what they covered. DCACHE_UNCOVERED tells a walk that found it earlier
+ * that the mounts are gone. The caller removes it for good afterwards.
  *
  * The caller may hold dentry->d_inode->i_rwsem.
  */
@@ -2047,7 +2048,10 @@ void __detach_mounts(struct dentry *dentry)
 		return;
 
 	/* the name goes first, what covered it goes second */
-	d_drop(dentry);
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags |= DCACHE_UNCOVERED;
+	__d_drop(dentry);
+	spin_unlock(&dentry->d_lock);
 	event++;
 	while (mp.node.next) {
 		mnt = hlist_entry(mp.node.next, struct mount, mnt_mp_list);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4b1ff99608e0..673401db8c01 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -236,7 +236,8 @@ enum dentry_flags {
 	DCACHE_PAR_LOOKUP		= BIT(24),	/* being looked up (with parent locked shared) */
 	DCACHE_DENTRY_CURSOR		= BIT(25),
 	DCACHE_NORCU			= BIT(26),	/* No RCU delay for freeing */
-	DCACHE_PERSISTENT		= BIT(27)
+	DCACHE_PERSISTENT		= BIT(27),
+	DCACHE_UNCOVERED		= BIT(28),	/* lost its mounts on its way out */
 };
 
 #define DCACHE_MANAGED_DENTRY \

-- 
2.53.0

