Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532561;
	b=w7By3dECDZ5xHvh7TgZJwdq11hqxj9YPJvCK1BhA8mHfhdRaBQKG32oe7fmxDzDVjuRY
	 pRunelsv0uGyFfWZ9phNNpAumauXtK0AvGW9s8Q4kadgXU2f8LnZEgLzRaJv9UgR4PQje
	 C4ApbK8mQQ6z0cpM6Sk+9t5XFf3GG/Gc7PzZMaOPVwoMdq7xDhFKtG0uUvoSy1PUWRxwO
	 LRWacVdzhMYorGinOF+AMUGHZpxN6RUZBJ7SqPcGNeFNS3MiO+SjxVlVu2nXsdHT+6AIT
	 Mf6sgNHBpnZkCcWrJqibJlzw6x0f/BaP+r3yqB1KsJTzzubtUpK0/HzMvPAhXgeOBjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NRGFHQowi9Z94fI9t282a6J9sXgMRTfXyGM/l5+fMlI=;
	b=WgDZ51MjPbFCITtB663OOHfqtMRSPGHT4q1kIelPjtgPt71Q+8W7e8RT068Lwzt/8NGd
	 nHS0l1nwrPWWLR2nt+kB2yGDhmpRd2mZxuRnpeogTpOSEdDpqiopAjboc87xdJWxCkGIa
	 +cTecHxoRmwlVYgsh/H7UWvEVP2VTz3yGc+0wS5yCFcMFuzMYryN6xuLL3KuAHstnPJ7F
	 quE9yVRggduxR1Xp9JjmRG/cFybrTqnXGT+Mk1uzCXmLYDz6Wg/wsCOp0WcV+FYZV4TWa
	 20tNSHGvVPpHKjqySEsVbysAvo4bzRxNKAOLRgVNMD44TN6BQ8paUlaA4NZJsEojSTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SCJg2kFb;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE0606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 15:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55AE0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SCJg2kFb
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so40753405e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795532559; x=1796137359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NRGFHQowi9Z94fI9t282a6J9sXgMRTfXyGM/l5+fMlI=;
        b=SCJg2kFb0Pje9fpjWW2zB2GH6+L87OMXQvIoAkKygbUkpsWzs/cjGtGHyVwQn7GUbR
         2qNgrBcNuXAXc3wSIH9TjxM67tc+ON5AP6F1axeHgPrWE1oHZyFgDyjRZ09rRx0deG4m
         0qLlStLzfOtZ1a4EcWpHJSJhqTDCfF/z17vWkzrYjBbtxNVyw/Q4Gr5LtQGoNvHx/igT
         m9SjUsRWVvMuCGOV43SnC8fqXNjiEhNOh34NF0yQU4jNMSQc4G8j4UtUvCyqJsbtoLk0
         NAW247w3WY2YopY3s9Cv+sFsc0O/I/H30rKwX52rTSdyDz5fPXce0DkzSKynNRLu+u/d
         a7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795532559; x=1796137359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRGFHQowi9Z94fI9t282a6J9sXgMRTfXyGM/l5+fMlI=;
        b=DfvHwhP3rWdGNnhIZkczJ91ZSi1PBnP4J/zZPbeiN4w2X7Bg25TrAUbH9U4V0hhDzc
         FGYfJlGFvoqMGzdzv/vnpHPj50kAhlNe76pIEVsjw4fl35nlqreCsncVod9wXuy0oesW
         ZecblOWBm1oMO8ZVYlMytc9Mj0nN5H7fmzDel/cf8a+LN5oN0MV3lLZWal/O0+oWMQCW
         Kyso9gMx64at/fFW0OPjv8REcPocL5mi0n9Yibyhr1Az6nMTnyCfI95LKjsVL4t63hZd
         XuJ2JChGuHB3IWK1P63306CQFi+Vn8roEj7+vj7cLwtyCDBXsMVh0QEPCMXNnkG6I0h3
         Dq4g==
X-Forwarded-Encrypted: i=1; AL+hErElAM/Jk8u9KoYB7Im1GxC8Z6zLMA6D8wD0jxMfHre2L6nG7nhBx1u5G7ANiZsXToVkWMzQCNSOorUqKmkz@vger.kernel.org
X-Gm-Message-State: APuU4Z+W3RHqf0dIVK7b+9FdwVfrqELv7E1vo2RrqEdRG8HXERUgNX17
	osFvLinlkB+25oX30kcRIvU24yqyMi/4ZJ5VlDZDeNhfmAYyYaqFCfPf
X-Gm-Gg: AZFdTZfnrxoSPXntjOgXtHTi+ccyWZrnFHRpFlOKomVuhWuaXabOgeNOHXT78z557lk
	CkpAgjs7x0CFKTDKLS8dEsK7cKnWY59DOutiynkEtiuWAj2vpgD1/1treF0fdd9omjfk57m1I2U
	C77Y204VGbVrXrEwV6/uwi05Q4E3XReHsyOgNAu5AHHEULdEILAh0dtslcA+uQUxQoFrWj/+CRc
	dqydhaBa4kIenmjDXBRZI3kHB3N6XxX6eTh67XtxImZQzDmHTjJ2bsd01W3B5NoEyikx3AYLPXA
	vFmaP5A/aSQSxlOA5PpTAqYL4JTPA30TqJJsFR66jI9WsnoDbtdcx2pnT2zb1jFyJus9nln2YeV
	IyWEUBMU6TXdiwGNm4LSbn1lIIBf+Bf6P7IEMqI7jDWtwyOBDhJjc/AfD+OTBPXe7+wo3rMnhMp
	YzkFxmzlQlw3zQd6YjNJ1Gp0h+wtTrOkgJEumM9UXh7W3uGpjj0eC1okhyIzleVynSWw44hlPs2
	itOpkEkciCzRaz4ERUMOy5/qeJKRaOvp0ffyHm+PpAl/uC5+gZx+jChmvr9peNh0o5i/Ko5NkPF
	pMZ/UT9Dq3pxWIjqnfopOE6Q
X-Received: by 2002:a05:600c:4f0f:b0:4bb:87f4:3674 with SMTP id 5b1f17b1804b1-4bb8880ef40mr381750235e9.15.1795532558297;
        Tue, 24 Nov 2026 07:02:38 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm232166435e9.3.2026.11.24.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:02:37 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Edward Adam Davis <eadavis@qq.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [PATCH] vfs: fix file_getattr hint to request xflags
Date: Tue, 24 Nov 2026 16:01:08 +0100
Message-ID: <20261124150108.189282-1-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When using a FUSE mount over an underlying filesystem that supports
xflags, querying them from userspace with file_getattr() strips them
because file_getattr sets flags_valid = true so FUSE uses
FS_IOC_GETFLAGS instead of FS_IOC_FSGETXATTR.

Fix it by setting fsx_valid = true instead.

Output when using a simple FUSE mount that simply forwards the ioctls to
the underlying fs:

before the fix:

  /xfs/file: FS_IOC_FSGETXATTR: ret=0, projid=69
  /xfs/file: file_getattr:      ret=0, projid=0
  /ext4/file: FS_IOC_FSGETXATTR: ret=0, projid=42
  /ext4/file: file_getattr:      ret=0, projid=0

after the fix:

  /xfs/file: FS_IOC_FSGETXATTR: ret=0, projid=69
  /xfs/file: file_getattr:      ret=0, projid=69
  /ext4/file: FS_IOC_FSGETXATTR: ret=0, projid=42
  /ext4/file: file_getattr:      ret=0, projid=42

Fixes: cb184dd19154 ("fs: init flags_valid before calling vfs_fileattr_get")
Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.11
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
Hi, I found this issue while working on the v2 of [1], here is the
reproducer, not in the commit message because of the size.

script:

  #!/bin/bash
  truncate -s 100M xfs.img
  truncate -s 100M ext4.img
  mkfs.xfs xfs.img
  mkfs.ext4 -O project ext4.img
  mkdir xfs ext4
  
  mount xfs.img xfs
  mount ext4.img ext4
  touch {xfs,ext4}/file
  
  chattr -p 69 xfs/file
  chattr -p 42 ext4/file
  
  mkdir fuse
  ./repro_fuse_getattr fuse "$PWD"/xfs/file
  ./repro_fuse_getattr fuse "$PWD"/ext4/file
  
  umount xfs ext4

where repro_fuse_getattr is a simple fuse mount, compiled with:

  gcc repro_fuse_getattr.c -o repro_fuse_getattr $(pkg-config fuse3 --cflags --libs)

and used like:

  ./repro_fuse_getattr <fuse_mount_dir> <full_path_to_real_file>

repro_fuse_getattr.c:

  #define _GNU_SOURCE
  #define FUSE_USE_VERSION 35
  #include <fuse3/fuse.h>
  #include <stdio.h>
  #include <string.h>
  #include <errno.h>
  #include <fcntl.h>
  #include <unistd.h>
  #include <sys/syscall.h>
  #include <sys/ioctl.h>
  #include <sys/mount.h>
  #include <linux/fs.h>
  
  /* needed to get the file's file descriptor for the ioctl */
  static int my_getattr(const char *path, struct stat *st, struct fuse_file_info *fi)
  {
  	memset(st, 0, sizeof(*st));
  	if (!strcmp(path, "/")) {
  		st->st_mode = S_IFDIR | 0755;
  		st->st_nlink = 2;
  		return 0;
  	}
  	return stat(fuse_get_context()->private_data, st) < 0 ? -errno : 0;
  }
  
  /* pass down the ioctl to the fs */
  static int my_ioctl(const char *path, unsigned int cmd, void *arg,
  		    struct fuse_file_info *fi, unsigned int flags, void *data)
  {
  	int fd = open(fuse_get_context()->private_data, O_RDONLY);
  	int ret = ioctl(fd, cmd, data);
  	close(fd);
  	return ret < 0 ? -errno : 0;
  }
  
  static const struct fuse_operations ops = {
  	.getattr = my_getattr,
  	.ioctl   = my_ioctl,
  };
  
  int main(int argc, char *argv[])
  {
  	const char *mnt = argv[1]; /* FUSE mount point */
  	const char *real_file = argv[2]; // full path of the file on the
  					 // underlying fs
  
  	/* start FUSE */
  	pid_t pid = fork();
  	if (pid == 0) {
  		char *fuse_argv[] = { "fuse", "-f", (char *)mnt, NULL };
  		return fuse_main(3, fuse_argv, &ops, (void *)real_file);
  	}
  
  	usleep(300000); /* wait for FUSE mount */
  
  	/* Query the file attributes through FUSE mount */
  	char fuse_file[4096];
  	snprintf(fuse_file, sizeof(fuse_file), "%s/file", mnt);
  
  	int fd = open(fuse_file, O_RDONLY);
  
  	struct fsxattr x = {};
  	int ret_fsget = ioctl(fd, FS_IOC_FSGETXATTR, &x);
  
  	struct file_attr fa = {};
  	long ret_sys = syscall(SYS_file_getattr, -100, fuse_file, &fa, sizeof(fa), 0);
  
  	close(fd);
  
  	printf("%s: FS_IOC_FSGETXATTR: ret=%d, projid=%u\n",
  	       real_file, ret_fsget, x.fsx_projid);
  	printf("%s: file_getattr:      ret=%ld, projid=%llu\n",
  	       real_file, ret_sys, (unsigned long long)fa.fa_projid);
  
  	umount(mnt);
  	return 0;
  }

Thanks,
koraynilay

[1]: https://lore.kernel.org/all/DN2YMTH77KWE.3IPE9OG8377X0@gmail.com/T/#t

 fs/file_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 833e03810b24..3b249a0a6b36 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -383,7 +383,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	struct path filepath __free(path_put) = {};
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa = { .flags_valid = true }; /* hint only */
+	struct file_kattr fa = { .fsx_valid = true }; /* hint only */
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);

base-commit: 3857587d9d6fa44d40d1c73bde6a39f6f7a5216c
-- 
2.56.0

