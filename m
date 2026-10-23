Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748553;
	b=yXQYzG+zfHEK6twScmWfNI9PJCLRb8NNtr9GJ/D6kxSvsHnxud6BlVYhP622g7ypOuFH
	 uX0DlrJxZTsbAUT2pjggclE0od63uIR5hIJDfkMp7hg2NQPuxAmegpmJqVLpOKRf/EW3D
	 GGpq8Mylz9BRXVWrbrQzYVevHIU2SkaSkxcOxpbSNRWRUHfPzgW2U0cxsHbsEKdwigm1p
	 XZlUNucEZe8k1eMJ8LkBVmy2i8GhWW+N3a6V2lyBNths5HE3HEPdNZPhImUnCYWOT70t5
	 SSWYzMALzbUEBcacBAg2iI4GLPNbEJC/GGh8JQ2nEKtqlkDPPbqRZcUEcfs67ZeBg3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748553;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QbQXgJZBNPf9uUGmEGQishGin3XSN8UT1OUXNzeAC7Y=;
	b=jteQz5UHRjS0/6QpD3R9tyoStC21x8tNhvx9UA8Bup84JtehEjoWaD0OnCZymvJ8+Uto
	 SbPs0MRrt4+tU7PNj7oaqtvGFJlnWMqfeICp+09fEmbQzX3HsWMO885C5lUHmwgP+poj6
	 Rboa1XIAZAVrcINmFK8VT8oCTGAvqrCsolnqnQqQsMs5TTFQ8RF/baRVO/I322rulo/Qf
	 bWcmu46kkFHCTQiXqeBz91rXhezl7Q3xfgOASd0BEoUWwvVKSV4Y028jDJi/wj1TGepnH
	 PReFHLGR+q9QINwWnrxVLZIsLWd3NWvnqoy4gNZFHB79IZMRIqeTYLV2lY2LJgzXzkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKHqdkHH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718D606A31D;
	Fri, 23 Oct 2026 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKHqdkHH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9BF1F031E3;
	Fri, 23 Oct 2026 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748552;
	bh=QbQXgJZBNPf9uUGmEGQishGin3XSN8UT1OUXNzeAC7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OKHqdkHHQCnK+AURnMciqMUa/nq5Jkd6kRWzOINbMf5KKRW7zaNyj7934GkeyBuf6
	 fYVj1qqCjiGW8yxfj9Y/iZ4GfBS2Poofb1y0aWjwPndRacto98czXcgM1dlnd3rmql
	 JcxqTeCqF1v50uVC07r44gx9/Ep1dD/jD0zlBno1Z9cKPRgstLywwJg3nXWcA00HNN
	 5u7cS+jjvZm8esIKNeU/q/N3dvruam9G7262LmZLe9EtYZZeENzTZ96troIqP0XIut
	 mKqDzJUH06qmLWGUzS0p1Ys+O9jWAkjBQR3TT0xp4iPrIQFSFkiCRKcaZ/URNdk/4k
	 rObtuPEs0j5zA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 23 Oct 2026 11:41:04 +0200
Subject: [PATCH 4/5] super: make sync(2)'s wait for s_umount killable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-work-super-lock_helpers-v1-4-d0fcb3f2f275@kernel.org>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
In-Reply-To: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3709; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kRuPrplB/gOzOsYFuHPd2OQ0b+mojLH8C5bGqCOikmM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd1v67rdxL8aXC87XsDFdPiT59MfEdxyHuU6a7zmfl7
 wtRfdG5rKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiBVqMDNMz13+wCa/dZy2Q
 NjU/iO+tX4i06GYT9hUTSz/GzVigJ8DI8MB5xun/pwqOboqf9/yE5xEWDq8DVa0fbu7reh1rvG4
 uPxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

iterate_supers_sync() waits killably for a superblock that's being shut
down, but it takes s_umount of a live superblock uninterruptibly. So a
freeze_super() or remount that's stuck under s_umount, in
sync_filesystem() or ->freeze_fs() say, still hangs every sync(2) on
the machine without anyone being able to kill it.

That's inconsistent with fs_bdev_sync() which already uses a killable
super_lock() for both waits. And the reasoning is the same: if the task
is killed the walk stops and ksys_sync() returns, there's nobody left to
make a promise to. The emergency sync and the sync before suspend and
hibernation run from a workqueue where that can't happen. The PROM sync
on sparc32 runs in whatever task it interrupted but that one could
already be cut short while it waited for a superblock being shut down.

Let __iterate_supers() pass SUPER_LOCK_KILLABLE together with
SUPER_LOCK_WAIT_SHUTDOWN for SUPER_ITER_WAIT_SHUTDOWN. Only
iterate_supers_sync() passes that flag. The wait for SB_BORN doesn't
matter for sync(2) as iterate_supers_sync() skips unborn superblocks
anyway.

This can be reproduced by freezing a filesystem on a suspended dm-linear
device and calling sync(2) behind the freeze:

  truncate -s 512M img
  DEV=$(losetup -f --show img)
  mke2fs -q $DEV
  dmsetup create t --table "0 $(blockdev --getsz $DEV) linear $DEV 0"
  mount -t ext2 /dev/mapper/t /mnt
  dd if=/dev/urandom of=/mnt/f bs=1M count=64
  dmsetup suspend --nolockfs t
  fsfreeze --freeze /mnt &
  sleep 3
  sync &
  sleep 3
  kill -9 $!

fsfreeze sits in sync_filesystem() with s_umount held for writing.
Without this patch the sync stays in down_read() after the SIGKILL. With
it the sync goes away.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 0f3308fb99aa..a0f9eadf0da7 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1010,9 +1010,13 @@ static inline struct super_block *next_super(struct super_block *sb,
 static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 			    enum super_iter_flags_t flags)
 {
+	enum super_lock_flags_t lock_flags = 0;
 	struct super_block *sb, *p = NULL;
 	int ret = 0;
 
+	if (flags & SUPER_ITER_WAIT_SHUTDOWN)
+		lock_flags |= SUPER_LOCK_KILLABLE | SUPER_LOCK_WAIT_SHUTDOWN;
+
 	spin_lock(&sb_lock);
 
 	for (sb = first_super(flags);
@@ -1032,12 +1036,14 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 
 		if (flags & SUPER_ITER_UNLOCKED) {
 			f(sb, arg);
-		} else if (!super_lock(sb, 0)) {
-			f(sb, arg);
-			super_unlock_shared(sb);
-		} else if (flags & SUPER_ITER_WAIT_SHUTDOWN) {
-			/* whoever shuts it down writes it out, wait for that */
-			ret = super_wait(sb, SB_DYING, TASK_KILLABLE);
+		} else {
+			ret = super_lock(sb, lock_flags);
+			if (!ret) {
+				f(sb, arg);
+				super_unlock_shared(sb);
+			} else if (ret == -ENOENT) {
+				ret = 0;
+			}
 		}
 
 		if (p)
@@ -1085,8 +1091,8 @@ void iterate_supers_born(void (*f)(struct super_block *, void *), void *arg)
  * A superblock which is still being set up isn't passed to @f either, and
  * isn't waited for.  Nobody can have written to it yet.
  *
- * Return: 0 if all the superblocks were seen, -ERESTARTSYS if the task was
- *         killed while it waited for one.
+ * Return: 0 if all the superblocks were seen, -EINTR or -ERESTARTSYS if the
+ *         task was killed while it waited for one.
  */
 int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg)
 {

-- 
2.53.0

