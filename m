Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B537F8C4
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786800210; cv=none; b=CdJg7bk4msHf7x2VWcQQUvbz+28QNB4WQGbR45Q80M7LPFOLqeyYUZoHQOrbpSwXrBg1XZdkN3RWNgknRFl/XL+fdls+QAEeGJNbB4eRj1wTjGbdBMvjs1a9UOBUGDAllvC16L/UZN3Ltp8m5GG3GAHReEfYFUAZENpe7LsOubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786800210; c=relaxed/simple;
	bh=OglmZqwKgdSt2Rek1YoJNCPOn5vyK4uYTYh2MA6083Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdrDHcS9Np+VuAgcwYsGNA80q1g/73qcw3MXvNFRPxdGfOeSAgQat2ViIanHog4QtJgWrH6FO3SmrixHDE+73hgdXLYq7CwLx/xUdYkztss42g7YhEmYMdZPffPGFd5p2RlRyjehrZCshmhTYb65H7n680AplPDON/ZUZZP08VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DMKnbD00; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DMKnbD00"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OglmZqwKgdSt2Rek1YoJNCPOn5vyK4uYTYh2MA6083Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786800204; v=1; x=1787405004;
 b=DMKnbD003AIGSu0GY3G2ujcV0OIiUdNBLmzz3eNGi/v8DuPLSiCrSTOlblJO9ECfFOH8JhBf
 CNdLgCfRni1JgsMp/W7t9tjGuQ47x2N82Ggc5FchTAsq+pJpdyspEGrJBfHlxCR9ppUSUIasFbl
 siX3vDOATlh6XSvhT8jsMzNI=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: from ctao-book.. (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 6d4d7ca9e2396d50;
	Sat, 15 Aug 2026 13:23:14 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: clm@fb.com,
	dsterba@suse.com,
	sforshee@kernel.org,
	wqu@suse.com
Cc: josef@toxicpanda.com,
	brauner@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2] btrfs: allow idmapped DEFRAG ioctls
Date: Sat, 15 Aug 2026 21:22:59 +0800
Message-ID: <20260815132259.3935817-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

btrfs_ioctl_defrag() checks MAY_WRITE against nop_mnt_idmap, so on an
idmapped mount the owner comparison uses the caller's fsuid against the
raw on-disk uid and the ioctl fails with -EPERM even for the file's
owner.  Pass the mount idmap down so defrag works on idmapped mounts.

The check, added in 616d374efa23 ("btrfs: allow defrag on a file opened
read-only that has rw permissions"), is not a privilege gate.  It only
tests whether the file could have been opened for writing, and a user
who owns the file on the idmapped mount can already open it O_RDWR,
write() to it or fallocate() it.  Defragmenting a regular file only
rearranges the caller's own extents; there is nothing it can rewrite
that the caller could not rewrite anyway.  Whole-subvolume defrag on a
directory keeps its capable(CAP_SYS_ADMIN) requirement, and the
!capable() guard around this check is left as is.

FIDEDUPERANGE already works this way for unprivileged callers:
may_dedupe_file() in fs/remap_range.c compares the inode owner through
file_mnt_idmap(file) and falls back to inode_permission() with the same
idmap, and dedupe can rewrite one file's extents from another file's
contents, which is a stronger operation than defrag.

On regular mounts file_mnt_idmap() is nop_mnt_idmap and nothing
changes.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
v2: rewrite the commit message to explain why defrag is safe for
idmapped users (Seth Forshee); the code is unchanged.
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 72bc9d4f7708..607329dedd50 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2458,7 +2458,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 		 * running and allows defrag on files open in read-only mode.
 		 */
 		if (!capable(CAP_SYS_ADMIN) &&
-		    inode_permission(&nop_mnt_idmap, inode, MAY_WRITE)) {
+		    inode_permission(file_mnt_idmap(file), inode, MAY_WRITE)) {
 			ret = -EPERM;
 			goto out;
 		}
-- 
2.43.0

