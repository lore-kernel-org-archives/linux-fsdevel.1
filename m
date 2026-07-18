Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882D3446C0
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784402160; cv=none; b=cl1xcnhMrE9a9BsDeBvh00dyPqF80Ph59jP38k3l8Sa/rWCltcNi/jk8lnTOWGjCznmxZ8r56fqFD9DaBbC8KcYR0AnKUwKzDchZiLSO0nipW3QZDgG6Y2zyJAG4FifcZNBc6OS9yq/kG9xNmOvbLZMQkf/aZb+TWc0a5fptNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784402160; c=relaxed/simple;
	bh=dUfONPU9riLiIRrViYYJAhG4mXBGTpEnKqbvgYwE/+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgQGt2edK6psiOPBLpexQD9Y4fi473jR7CUc70KsAnCP4Hz7Cnu1aDOwzC3GZPwNz9TujA4lwqsEUd9MKFZcuV1ojtuGgA5mSr5/3cXT9YKsRpYIxSBMynvo1Iwz0SjoJ66KpFs6DgJl7PB7c6qKKAkkRbi7mla7iEnSQEgybdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVukKhcN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVukKhcN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955484387cso2061045e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784402156; x=1785006956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpnnUCjvFhQvZ/hdXCpoqY+iircQ7nkPeqN838t5fO0=;
        b=eVukKhcNiFmVjVT2lO5UfxU7R7rUk6Bg6YNlOM0p1DD3jcr+L0m0CafcPvGHKmO7tW
         kS+meqo8K3daCJPE7E7FH/bfRIGkTwrxZAFye/igJsr64VgLsQ5F+vwHGI4KnI3uDkIM
         jeDseMHwHykeJ05g6kWLbc3XP9LI6IQSWQQ3whC613nIl0lRclaDPGcealG6iUJ67eJe
         ampn6kFwHxjOR7RN//p0nj5jnY5l5iCcuz6sqRJQXzbkeTT7gE/4K0LaLpAkLLpsENJK
         0/1+sxW7g20jzSOSlSbht9hE9MQPbGyi5Uis8nmDyVzw7EdACLwp9CXwPkkfL8x45sD5
         1VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784402156; x=1785006956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpnnUCjvFhQvZ/hdXCpoqY+iircQ7nkPeqN838t5fO0=;
        b=IuTXQP+sUctXLKdwTY/+hP9uaY75smchd5iKO4JQfhaV6z4Jg4HgiyBMo0MUW3TF6m
         E1ZRBicDIr9q8WidkJFS1OG+MkvRcsPSUm16vgxFAoNT25M8hFMm6eDJaMVS/60iC2rH
         hgwaji/W1/naUUyHjC26vSi+DJXQ6RcrGXC/JMPFMmrRHDBp17M1Kdre7olt//6OIXZ8
         VMPKejx/KlzCdGEhP5WTvZoO0UmDjFC8BIjfjpp1ZZy0yLcP/YtkM3Lz1eybvP3/J+vJ
         V5wEHeEsX2eYll9bzDQvMs/z9jGYS98NtT6kVjmheb+Ou/B9Mr5+gKKqju7hq+dvMZHV
         TxHA==
X-Forwarded-Encrypted: i=1; AHgh+RrF6Tz/kxoXEgSNeXqigVA9rK8cZvf128J+vOMp81ZQIbuHhs812mIZWoOr3J4UOFCIMvnIPgtZOXQEP9n4@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRSemAqz6TYnm5HIgX2lvj/dyh2qOb/Pvl9ftDLW+L7m7ZSob
	czEEG5lqyBWUrbI3vKgRR0kHuvzSJOobHqWFifsOCWs8ZY0sbYcztolq
X-Gm-Gg: AfdE7ckXUo/JYrW4+WWAc3KpuMEb7BsgFEHf+aIi81ZVqGyMWkAt4OpyWNngmb67OFr
	C57ghmz6mnh/5oo9Q5C8jzeQudlPdWgVwRIJ1fEw0cF7A73OSeeUcbR4LJsP4YwuAj7F9Bf7j5l
	h/8rM7f4OmVjn5VhIhCVYXbPhhC5aFoB3Kur5DScMixApSaBhIpNEjRk4ko4j7mUfcqbVly0thy
	ql2gWlSJFL5q9iY7AiwWzQYPwCUu6AFhByPFhagCIv/M8MMrU+wg+TmP4RrRL5ZZe5/91aUu/oN
	hS0c+SR3SjnUC0SfwAKQL0AmRzk3hsGqxrQvimd9/XRha7Lx6zYzfybt+V8pdEzGJxqBN80zQD+
	8gognurGStrpwHBVuYzCqOYaph0uDJww0IkPgNVKx3j/6xi9LFqQs+xwJPdys2o8XBQ7PjlbsqU
	l/Oz1eyQ==
X-Received: by 2002:a05:600c:46c3:b0:495:522f:d996 with SMTP id 5b1f17b1804b1-495522fdb00mr35405945e9.18.1784402156071;
        Sat, 18 Jul 2026 12:15:56 -0700 (PDT)
Received: from spark.Home ([2001:8a0:7280:4000:c2b:a5ab:a31c:e0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2e8529sm140037005e9.11.2026.07.18.12.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 12:15:55 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	fsverity@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Curtin <ericcurtin17@gmail.com>
Subject: [RFC PATCH 1/2] init: support mounting the root filesystem from an image file
Date: Sat, 18 Jul 2026 20:15:50 +0100
Message-ID: <20260718191551.1703670-2-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718191551.1703670-1-ericcurtin17@gmail.com>
References: <20260718191551.1703670-1-ericcurtin17@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Image-based Linux systems (bootc-style OS updaters, ChromeOS/Android-like
A/B schemes, embedded appliances) commonly keep one or more immutable
root filesystem images as plain files on a writable "carrier" filesystem
and pick one at boot.  Today that always requires an initramfs, even when
the initramfs has nothing else to do: the kernel can only mount a block
device (or NFS/CIFS/ubi/mtd) as root, so userspace must mount the
carrier, loop-mount the image and switch_root into it.

Add a rootimage= parameter naming an image file on the filesystem
specified by root=.  When set, root= only designates the carrier: after
mounting it as usual, mount the image file read-only on /image and make
that the root that prepare_namespace() pivots into.  The image is
mounted through the filesystem's file-backed mount support (available in
erofs since v6.12), so no loop device is involved.  rootimagefstype= and
rootimageflags= mirror rootfstype=/rootflags= for the image mount, while
"ro"/"rw"/rootflags= keep applying to the carrier.

The carrier mount is detached again by default; the image mount keeps
its superblock pinned, so userspace can still mount it later.  Since
systems following this model virtually always need the carrier mounted
(it holds their writable state), rootimagesrcdir= optionally names a
directory inside the image where the carrier mount is moved instead.

This is the file-backed analogue of what dm-mod.create= (CONFIG_DM_INIT)
already does for device-mapper targets: moving a fixed, declarative bit
of early-boot setup from initramfs userspace into the kernel so that
small and verified systems can boot with no initramfs at all.

Assisted-by: opencode:claude-fable-5
Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  29 ++++
 init/do_mounts.c                              | 158 ++++++++++++++++--
 2 files changed, 174 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8..5dbd56098 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6699,6 +6699,35 @@ Kernel parameters
 
 	rootfstype=	[KNL] Set root filesystem type
 
+	rootimage=	[KNL] Mount the actual root filesystem from this
+			filesystem image file (absolute path) located on the
+			filesystem specified by root=, instead of using that
+			filesystem as the root directly.  This allows
+			image-based systems that keep their (typically
+			read-only, e.g. erofs) root filesystem images as
+			plain files on a carrier filesystem to boot without
+			an initramfs.  The image is mounted read-only via
+			the filesystem's file-backed mount support (no loop
+			device is set up); "ro", "rw" and rootflags= keep
+			applying to the carrier filesystem.  Once the image
+			is mounted, the carrier mount is detached (but kept
+			busy by the image mount itself) unless
+			rootimagesrcdir= is also given.
+
+	rootimageflags=	[KNL] Set root image filesystem mount option string,
+			used together with rootimage=.
+
+	rootimagefstype= [KNL] Set root image filesystem type, used together
+			with rootimage=.  Default is to try all filesystems
+			known to the kernel that can mount a block device or
+			an image file.
+
+	rootimagesrcdir= [KNL] Directory (absolute path) inside the root
+			image where the mount of the carrier filesystem
+			holding the image (i.e. the filesystem specified by
+			root=) is moved to, instead of detaching it.  Used
+			together with rootimage=.
+
 	rootwait	[KNL] Wait (indefinitely) for root device to show up.
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 95e0b3a0f..1b96ef30b 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -122,13 +122,51 @@ __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
+/*
+ * rootimage= mounts the actual root filesystem from an image file located
+ * on the filesystem specified by root= instead of using that filesystem
+ * as the root directly.
+ */
+static char * __initdata root_image;
+static int __init root_image_setup(char *str)
+{
+	root_image = str;
+	return 1;
+}
+
+static char * __initdata root_image_fs_names;
+static int __init root_image_fs_names_setup(char *str)
+{
+	root_image_fs_names = str;
+	return 1;
+}
+
+static char * __initdata root_image_mount_data;
+static int __init root_image_data_setup(char *str)
+{
+	root_image_mount_data = str;
+	return 1;
+}
+
+static char * __initdata root_image_srcdir;
+static int __init root_image_srcdir_setup(char *str)
+{
+	root_image_srcdir = str;
+	return 1;
+}
+
+__setup("rootimage=", root_image_setup);
+__setup("rootimagefstype=", root_image_fs_names_setup);
+__setup("rootimageflags=", root_image_data_setup);
+__setup("rootimagesrcdir=", root_image_srcdir_setup);
+
 /* This can return zero length strings. Caller should check */
-static int __init split_fs_names(char *page, size_t size)
+static int __init split_fs_names(char *page, size_t size, char *names)
 {
 	int count = 1;
 	char *p = page;
 
-	strscpy(p, root_fs_names, size);
+	strscpy(p, names, size);
 	while (*p++) {
 		if (p[-1] == ',') {
 			p[-1] = '\0';
@@ -139,8 +177,9 @@ static int __init split_fs_names(char *page, size_t size)
 	return count;
 }
 
-static int __init do_mount_root(const char *name, const char *fs,
-				 const int flags, const void *data)
+static int __init do_mount_root(const char *name, const char *dir,
+				 const char *fs, const int flags,
+				 const void *data)
 {
 	struct super_block *s;
 	char *data_page = NULL;
@@ -154,11 +193,11 @@ static int __init do_mount_root(const char *name, const char *fs,
 		strscpy_pad(data_page, data, PAGE_SIZE);
 	}
 
-	ret = init_mount(name, "/root", fs, flags, data_page);
+	ret = init_mount(name, dir, fs, flags, data_page);
 	if (ret)
 		goto out;
 
-	init_chdir("/root");
+	init_chdir(dir);
 	s = current->fs->pwd.dentry->d_sb;
 	ROOT_DEV = s->s_dev;
 	printk(KERN_INFO
@@ -185,7 +224,7 @@ void __init mount_root_generic(char *name, char *pretty_name, int flags)
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	if (root_fs_names)
-		num_fs = split_fs_names(fs_names, PAGE_SIZE);
+		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 	else
 		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
 retry:
@@ -194,7 +233,7 @@ void __init mount_root_generic(char *name, char *pretty_name, int flags)
 
 		if (!*p)
 			continue;
-		err = do_mount_root(name, p, flags, root_mount_data);
+		err = do_mount_root(name, "/root", p, flags, root_mount_data);
 		switch (err) {
 			case 0:
 				goto out;
@@ -266,7 +305,8 @@ static void __init mount_nfs_root(void)
 	 */
 	timeout = NFSROOT_TIMEOUT_MIN;
 	for (try = 1; ; try++) {
-		if (!do_mount_root(root_dev, "nfs", root_mountflags, root_data))
+		if (!do_mount_root(root_dev, "/root", "nfs", root_mountflags,
+				   root_data))
 			return;
 		if (try > NFSROOT_RETRY_MAX)
 			break;
@@ -303,7 +343,7 @@ static void __init mount_cifs_root(void)
 
 	timeout = CIFSROOT_TIMEOUT_MIN;
 	for (try = 1; ; try++) {
-		if (!do_mount_root(root_dev, "cifs", root_mountflags,
+		if (!do_mount_root(root_dev, "/root", "cifs", root_mountflags,
 				   root_data))
 			return;
 		if (try > CIFSROOT_RETRY_MAX)
@@ -345,7 +385,7 @@ static int __init mount_nodev_root(char *root_device_name)
 	fs_names = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!fs_names)
 		return -EINVAL;
-	num_fs = split_fs_names(fs_names, PAGE_SIZE);
+	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 
 	for (i = 0, fstype = fs_names; i < num_fs;
 	     i++, fstype += strlen(fstype) + 1) {
@@ -353,8 +393,8 @@ static int __init mount_nodev_root(char *root_device_name)
 			continue;
 		if (!fs_is_nodev(fstype))
 			continue;
-		err = do_mount_root(root_device_name, fstype, root_mountflags,
-				    root_mount_data);
+		err = do_mount_root(root_device_name, "/root", fstype,
+				    root_mountflags, root_mount_data);
 		if (!err)
 			break;
 	}
@@ -402,6 +442,96 @@ void __init mount_root(char *root_device_name)
 	}
 }
 
+/*
+ * Mount the actual root filesystem from the image file rootimage= on the
+ * filesystem that was just mounted from root= (the "carrier"), so that
+ * image-based systems can boot without an initramfs.
+ *
+ * Called with the carrier mounted at /root and the cwd there.  The image
+ * is always mounted read-only; "ro"/"rw"/rootflags= keep applying to the
+ * carrier.  On success the cwd is the image's root, ready for the pivot
+ * in prepare_namespace().  The carrier mount is moved to rootimagesrcdir=
+ * inside the image if set, and detached otherwise; either way the image
+ * mount keeps the carrier superblock pinned.
+ */
+static void __init mount_root_image(void)
+{
+	unsigned long flags = MS_RDONLY | MS_SILENT;
+	char *path, *fs_names, *p;
+	struct file *file;
+	int num_fs, i, err;
+
+	if (root_image[0] != '/')
+		panic("VFS: rootimage= must be an absolute path");
+
+	path = kmalloc(PATH_MAX, GFP_KERNEL);
+	fs_names = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!path || !fs_names)
+		panic("VFS: unable to mount root image: not enough memory");
+
+	if (snprintf(path, PATH_MAX, "/root%s", root_image) >= PATH_MAX)
+		panic("VFS: rootimage= path too long");
+
+	/*
+	 * Nothing that could modify the carrier runs yet, so the image
+	 * cannot change between this open and the mount below.
+	 */
+	file = filp_open(path, O_RDONLY | O_LARGEFILE, 0);
+	if (IS_ERR(file))
+		panic("VFS: unable to open root image %s: error %ld",
+		      root_image, PTR_ERR(file));
+
+	err = init_mkdir("/image", 0700);
+	if (err < 0 && err != -EEXIST)
+		panic("VFS: unable to create /image: error %d", err);
+
+	if (root_image_fs_names)
+		num_fs = split_fs_names(fs_names, PAGE_SIZE,
+					root_image_fs_names);
+	else
+		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
+
+	for (i = 0, p = fs_names; i < num_fs; i++, p += strlen(p) + 1) {
+		if (!*p)
+			continue;
+		err = do_mount_root(path, "/image", p, flags,
+				    root_image_mount_data);
+		switch (err) {
+		case 0:
+			goto mounted;
+		case -EACCES:
+		case -EINVAL:
+		case -ENOTBLK:
+			continue;
+		}
+		panic("VFS: unable to mount root image %s: error %d",
+		      root_image, err);
+	}
+	panic("VFS: no filesystem could mount root image %s", root_image);
+
+mounted:
+	fput(file);
+
+	if (root_image_srcdir) {
+		if (root_image_srcdir[0] != '/')
+			panic("VFS: rootimagesrcdir= must be an absolute path");
+		if (snprintf(path, PATH_MAX, ".%s", root_image_srcdir) >=
+		    PATH_MAX)
+			panic("VFS: rootimagesrcdir= path too long");
+		err = init_mount("/root", path, NULL, MS_MOVE, NULL);
+		if (err)
+			pr_err("VFS: failed to move the root image's carrier filesystem to %s: error %d\n",
+			       root_image_srcdir, err);
+	} else {
+		err = -EINVAL;
+	}
+	if (err)
+		init_umount("/root", MNT_DETACH);
+
+	kfree(path);
+	kfree(fs_names);
+}
+
 /* wait for any asynchronous scanning to complete */
 static void __init wait_for_root(char *root_device_name)
 {
@@ -481,6 +611,8 @@ void __init prepare_namespace(void)
 	if (root_wait)
 		wait_for_root(saved_root_name);
 	mount_root(saved_root_name);
+	if (root_image)
+		mount_root_image();
 	devtmpfs_mount();
 
 	if (init_pivot_root(".", ".")) {
-- 
2.43.0

