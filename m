Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559D3B3BEF
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633861; cv=none; b=sTwMGc7MV85enA4c+ZTvOYsIYNrzDSIsifoWLV1W3SX6fUSVkQ1qWuCqPV/60oUnzOJ9VG9z4y7NVh7ZtK6lzh8uKz4lkwnY79uufPs2yVVf5FSlCt2eYZkUd9sjlWDfZ8graA6BSkFndKQx2qZ5ov3WyfmG9vMGnDAAAT0psA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633861; c=relaxed/simple;
	bh=gEqid7c+m6ijx5jTrpg4wSZ7TosE7r2GvCBJXx9+aGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4eeiFg2BfFXPs3y/GE++vsnkhniA+QvNHPu6ZsHpoPPuNGsNYAIK57mfMwdYE1gXOHwjZD05oQeRQXiqJ+QLEeYDRrts/H6G0ug3qi5e8pnvavvj0JTWuWeHdOr4krx1Ks6b/tKmIVpCuVei0sAV6v7US504AZbWKq40icyZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=vs705sP3; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="vs705sP3"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id E04831CBC3;
	Wed,  4 Mar 2026 14:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me E04831CBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772633852; bh=gEqid7c+m6ijx5jTrpg4wSZ7TosE7r2GvCBJXx9+aGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vs705sP3x9AQaDJCOauGKGwASn0bQc/xkNp3UN5c9faKKnvd8cKN+TuIDmKb1GMmP
	 Q5N7zxs945l2K3RGo/eo0U1ezsmkTHn5jhpaskrM+8/7MnZbYU0q4ZwbQsk0DLFuIV
	 A5cjEICZsYman8QFDDKKPEN+VnCdZcAPVdlIkeg4=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id ZxyOLvk+qGnLtgEA8KYfjw:T2
	(envelope-from <dxdt@dev.snart.me>); Wed, 04 Mar 2026 14:17:31 +0000
From: David Timber <dxdt@dev.snart.me>
To: linux-fsdevel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v2 1/1] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
Date: Wed,  4 Mar 2026 23:16:45 +0900
Message-ID: <20260304141713.533168-2-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260304141713.533168-1-dxdt@dev.snart.me>
References: <CAKYAXd_8vG6V0NRT_kb76n_yo+d9vvcx6JZbMARC5+C1ovboqw@mail.gmail.com>
 <20260304141713.533168-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a file in exfat fs gets truncated up or fallocated up, only
additional clusters are allocated and isize updated whilst VDL(valid
data length) remains unchanged. If an application writes to the file
past the VDL, significant IO delay can occur as the skipped range
[VDL, offset) has to be zeroed out before returning to userspace. Some
users may find this caveat unacceptible.

Some niche applications(especially embedded systems) may want to query
the discrepancy between the VDL and isize before doing lseek() and
write() to estimate the delay from implicit zeroring.

The commit introduces a new ioctl,

	#define EXFAT_IOC_GET_VALID_DATA	_IOR('r', 0x14, __u64)

which correspond to

	`fsutil file queryvaliddata ...`

command in Windows.

With the new ioctl, applications could assess the delay that may incur
and make decisions accordingly before seeking past the VDL to write.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/file.c            | 22 ++++++++++++++++++++++
 include/uapi/linux/exfat.h |  4 +++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 90cd540afeaa..a13044a7065a 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -449,6 +449,22 @@ static int exfat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 	return err;
 }
 
+static int exfat_ioctl_get_valid_data(struct inode *inode, unsigned long arg)
+{
+	u64 valid_size;
+
+	/*
+	 * Doesn't really make sense to acquire lock for a getter op but we have
+	 * to stay consistent with the grandfather clause -
+	 * ioctl_get_attributes().
+	 */
+	inode_lock(inode);
+	valid_size = EXFAT_I(inode)->valid_size;
+	inode_unlock(inode);
+
+	return put_user(valid_size, (__u64 __user *)arg);
+}
+
 static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 {
 	struct fstrim_range range;
@@ -544,10 +560,15 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	u32 __user *user_attr = (u32 __user *)arg;
 
 	switch (cmd) {
+	/* inode-specific ops */
 	case FAT_IOCTL_GET_ATTRIBUTES:
 		return exfat_ioctl_get_attributes(inode, user_attr);
 	case FAT_IOCTL_SET_ATTRIBUTES:
 		return exfat_ioctl_set_attributes(filp, user_attr);
+	case EXFAT_IOC_GET_VALID_DATA:
+		return exfat_ioctl_get_valid_data(inode, arg);
+
+	/* fs-wide ops */
 	case EXFAT_IOC_SHUTDOWN:
 		return exfat_ioctl_shutdown(inode->i_sb, arg);
 	case FITRIM:
@@ -556,6 +577,7 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return exfat_ioctl_get_volume_label(inode->i_sb, arg);
 	case FS_IOC_SETFSLABEL:
 		return exfat_ioctl_set_volume_label(inode->i_sb, arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/exfat.h b/include/uapi/linux/exfat.h
index 46d95b16fc4b..da65aef416cc 100644
--- a/include/uapi/linux/exfat.h
+++ b/include/uapi/linux/exfat.h
@@ -12,7 +12,9 @@
  * exfat-specific ioctl commands
  */
 
-#define EXFAT_IOC_SHUTDOWN _IOR('X', 125, __u32)
+#define EXFAT_IOC_SHUTDOWN		_IOR('X', 125, __u32)
+/* Get the current valid data length(VDL) of a file */
+#define EXFAT_IOC_GET_VALID_DATA	_IOR('r', 0x14, __u64)
 
 /*
  * Flags used by EXFAT_IOC_SHUTDOWN
-- 
2.53.0.1.ga224b40d3f.dirty

