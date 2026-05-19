Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B163264C1;
	Tue, 19 May 2026 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229873; cv=none; b=L5ubiMelKeWwePEucETIkAhJDQSpekyoOF8w/B8utIeu8xnkPl73XKx0EYwyrvKqrrc0U1ZudlAyb5U9pqJL1MkTt95mDcED7HuQs1cEYSGtyoWzRXSQxKB9NIh8STztiCsE0q6lzX21a0HYL3bFXaCVp2jBx92AGp230RB2rQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229873; c=relaxed/simple;
	bh=+wJBaEMKng06bDqGFL5EvalXmROBC7hlkMjAqIf18pQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qk8ds/TuNW7LFazBqXR5WhdKfF9P2TtDLm9xc2wMvUmSEGRMc19GEifcejWxecCwUifzx6Mc7d/SQwBpIiPzMSfwTX2/haC518OQ6PoN/PryzoeQQywd+4owprKkS3vZvcmNXh6fYzIxeSDazqwxCnWuctqcKJE/FXeMSuwxvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O34tS8vY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O34tS8vY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C5A831F000E9;
	Tue, 19 May 2026 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229871;
	bh=PFLfNtgYeG/EiYhAdZncmmS0GTw+DkxWbgryupf8Sdc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=O34tS8vYzoA0S1CP1g5J4EqX5Wf0rF3OUzEjD4G89H9HM8deT1XtjUpRtLRF6fDL1
	 1ad0uQsbx7RYiURY2tN4u7s4hiveWfjp7ar5hx8bbI/uvBCc7ntsizxoItCbjOimwQ
	 RZdma59H2dTT6Ey80nTXhtsYSkz0mbx5joVJjPLgUuozOfZfiBJXAMGCugdVHQ4KpL
	 SkgzcuRSvuRLaWHJ9hjjpZM0c9kT6AwzAIvckfmz1A8Tdc+o5oBdM7j/AW7GGtz+07
	 OXNd1eaFRo/1SguBusZHysRWIi1JeRX7lHSRHlJjqahPu0GkiPhfqu7FwR1R4CTcbL
	 jrhRYVLhsvwaw==
Date: Tue, 19 May 2026 15:31:11 -0700
Subject: [PATCH 1/9] fuse: advertise support for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946198.2439242.10191924284924817231.stgit@frogsfrogsfrogs>
In-Reply-To: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Advertise our new IO paths programmatically by creating an ioctl that
can return the capabilities of the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h                               |    4 ++++
 include/uapi/linux/fuse.h                          |    9 +++++++++
 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 +-
 fs/fuse/dev.c                                      |    3 +++
 fs/fuse/fuse_iomap.c                               |   13 +++++++++++++
 5 files changed, 30 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 714ab728066631..144ff1a579674d 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -59,6 +59,9 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
 int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -81,6 +84,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
+# define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1f1f9392a441f5..0344ab22411837 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1161,6 +1161,13 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+/* basic file I/O functionality through iomap */
+#define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1168,6 +1175,8 @@ struct fuse_backing_map {
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 331223761ffffd..1175e6795cf439 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -399,7 +399,7 @@ Code  Seq#    Include File                                             Comments
 0xCF  02     fs/smb/client/cifs_ioctl.h
 0xDD  00-3F                                                            ZFCP device driver see drivers/s390/scsi/
                                                                        <mailto:aherrman@de.ibm.com>
-0xE5  00-3F  linux/fuse.h
+0xE5  00-FF  linux/fuse.h
 0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                     ChromeOS EC driver
 0xEE  00-09  uapi/linux/pfrut.h                                        Platform Firmware Runtime Update and Telemetry
 0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                       sisfb (in development)
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d21eebbe12d4c9..75e1e3f8a4ddd1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2712,6 +2712,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_SYNC_INIT:
 		return fuse_dev_ioctl_sync_init(file);
 
+	case FUSE_DEV_IOC_IOMAP_SUPPORT:
+		return fuse_dev_ioctl_iomap_support(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 01cb3b709ddbd5..14e86791c4d8f9 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2064,3 +2064,16 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
 		inode_unlock_shared(inode);
 	return ret;
 }
+
+int fuse_dev_ioctl_iomap_support(struct file *file,
+				 struct fuse_iomap_support __user *argp)
+{
+	struct fuse_iomap_support ios = { };
+
+	if (fuse_iomap_enabled())
+		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+
+	if (copy_to_user(argp, &ios, sizeof(ios)))
+		return -EFAULT;
+	return 0;
+}

