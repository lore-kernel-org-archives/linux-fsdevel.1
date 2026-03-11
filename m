Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD8390C8B;
	Wed, 11 Mar 2026 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773267984; cv=none; b=h7DixkVyJaXUVIvmC9xFavpoZarM54YH6X0MGSD2bAY9ttxUTq9JhZlI//gC2Gfpnk0P0q4QLi0/dT0t/GCqAmBY4kHAD9jnF/N2bCzdDm1kPHeayikpUhdBEJD7t5TEZFl6Aubcqu07VFZ5NQHi/Hhgi9ljnG3cUgNFdDkMjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773267984; c=relaxed/simple;
	bh=Vjvw77Pr4Dm7Oi1zVBCvO2CifIfuAUoy/I9/jkXqlg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWG+7Vr18VbWrJooPJBp0McRKeLw4g8R8JCssX5OwgvUAMc7WinaxrtPQT+8IY+o6x9SoJ2Cch2uFVd5BdNts0YAfJWMGLSKUi4dOvobAewuFrc6nnjEx5XCQhgqkoXizWqnNY8Q98gjR3xGYzSiP7V/oGKdR8JToC3te1dftvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=I9500/QA; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="I9500/QA"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id C472E1CBC3;
	Wed, 11 Mar 2026 22:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me C472E1CBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773267981; bh=Vjvw77Pr4Dm7Oi1zVBCvO2CifIfuAUoy/I9/jkXqlg8=;
	h=From:To:Cc:Subject:Date:From;
	b=I9500/QA36YXwifhco5UIYKouzclYdko8mfEuDE9v8UHF1XC37zt+DbXy82ntR1G7
	 VY6UPOMP97c6cwYTuDa6MY5w4pKmECcxqRM6uFYcudc7J95lgkH8Jc7sHlvDbF48CL
	 Smn6KwZ2UNEJ4r03rnh1wYldhlbKbOhJdJw8+na4=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id jUgSHgzssWmgqgQA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 11 Mar 2026 22:26:20 +0000
From: David Timber <dxdt@dev.snart.me>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
Date: Thu, 12 Mar 2026 07:26:13 +0900
Message-ID: <20260311222613.2010177-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a file in exfat fs gets truncated up or fallocate()'d up, only
additional clusters are allocated and isize updated whilst VDL(valid
data length) remains unchanged. If an application writes to the file
past the VDL, significant IO delay can occur as the skipped range
[VDL, offset) has to be zeroed out before returning to userspace. Some
users may find this caveat unacceptible.

Some niche applications(especially embedded systems) may want to query
the discrepancy between the VDL and isize before doing lseek() and
write() to estimate the delay from implicit zeroring.

The commit introduces a new ioctl EXFAT_IOC_GET_VALID_DATA, which
correspond to `fsutil file queryvaliddata ...` available on Windows.
With the new ioctl, applications could assess the delay that may incur
and make decisions accordingly before seeking past the VDL to write.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/file.c            | 22 ++++++++++++++++++++++
 include/uapi/linux/exfat.h |  6 ++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

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
index 050dcea0aa12..cbc10458122e 100644
--- a/include/uapi/linux/exfat.h
+++ b/include/uapi/linux/exfat.h
@@ -12,8 +12,10 @@
  * exfat-specific ioctl commands
  */
 
-#define EXFAT_IOCTL_MAGIC	0xEF			/* shared with ntfs3 */
-#define EXFAT_IOC_SHUTDOWN	_IOR('X', 125, __u32)
+#define EXFAT_IOCTL_MAGIC		0xEF			/* shared with ntfs */
+#define EXFAT_IOC_SHUTDOWN		_IOR('X', 125, __u32)
+/* Get the current valid data length(VDL) of a file */
+#define EXFAT_IOC_GET_VALID_DATA	_IOR(EXFAT_IOCTL_MAGIC, 0x01, __u64)
 
 /*
  * Flags used by EXFAT_IOC_SHUTDOWN
-- 
2.53.0.1.ga224b40d3f.dirty

