Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DBA3F8EDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149337; cv=none; b=o57Ud1gMEWEdS+EFsvTyoXXg4TDZdmHxnk8WwuBK1cW14kbGPIW6JMATLTHcINeG65/nJgI0MfHSuTaa+QS206MaRj3ce+yLeB2hV/UH6yddgpWnAX3+EjH/Qc7POXZeKfB6dE4mwhfiM3GpYxUU7cMqMFpKstBzknStHsgxdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149337; c=relaxed/simple;
	bh=VR8jcR7vb91b/Q6yTqwnPU6kUYss16B+Me5piaCsMVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpVMinCI3wmRdMmOXXC41D6r+aXRKbTe1xxVJSA8Z+pWkTOOlpnK9dbRwD+9ABOFCsKeETSkEaGCALtPslNkq9OWswSNxbdXitnyjjk8brROPWBCS/wn1ZdQcPRnFQ1cdXyFSeSsMZiWgUoioyzrD2x0XlRz0/Q70crJ9rP0cSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/AOCF6I; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/AOCF6I"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1428188f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785149333; x=1785754133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yeeZRNtXE4ctiTwj6rmjColhudnDiZUYGmbWolsb7d0=;
        b=M/AOCF6Im5biJSYaiNAHZ6EyE/lNUCnrSTLh6jSYImg6MPMGL0eqPnuyf+2BK6HMwh
         iJ693MCrTteSPu6Siu3ey7lLvMjxN1uypLtffocug0yeSUIURqCLmqq9nglokhpU6KEv
         okKy5yuopconc+pZnnIZUkiD6gE0tgD9ec1gZ8K+qcYArwkA+dHeHl//KFmXPpxzdbnK
         UbcNJAZmBzDcVlkzRqWjiuZxG6Lc2s/Gji//XvkT6wUPOa95RuoFXBWpidsISsRA5dir
         Qn+dx4CFPCm8S9qp28S59x4WbpG10h/l314hiOoNfgJuT3YcdzKz14+eQAgnRhQpkVP6
         4zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149333; x=1785754133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yeeZRNtXE4ctiTwj6rmjColhudnDiZUYGmbWolsb7d0=;
        b=U8Bebl3ywedm46DpQkt0E5stTF/CGh5x0snZ+uX6Jwmv1oZObUlRxII8bWGlW6Dn4I
         kZVJ3gnbShzfOuDkaobgmGeIeGA1aaLT0CD7CQqF4dL3Xc7aAA/bbygjNExN/zqfdRb7
         6vT6O8/8R9d46N8tHAijyYXO74l5qNl0wVXz6Xzr+BOVkFpyeAQGhG7FqKsAnDCAqmFf
         T3Y5z2bSvAk4M6AHRJwXuDBYy7YgfEMsFEzIezRGosnkfludGnXDa4gH6rALfLQh/JDo
         MOtF70aHHwCXyYgacW6Wjb5SzZK9pOsOHXv57EX9mefidchWWUNsxRvzqYbOmHiBz7gO
         qEqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rroc3DVTPl5edOBrvCCSoHK31EnKuWsdjKZAbQUlphdktXvzkmeoqF2JZEKr0ssmQ4CKFL7mUhDLdmv/GKS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6R5SiszdIqPi3RA56YDexKwLcOXOlYgdxnOblE0ks53q0qMeh
	aW4y5ODnOS+1aHDOthy8L3nKQWw1ll/9/M7xNQKauhcLrQZPenE3Y1HI
X-Gm-Gg: AR+sD12m141eB70CbaQQtec768UjwWXrzIkjxuqD3vGlk3hJoaA9zCL7FeCcEU71ItM
	qoVqFrFF5+Lk3t032Syp0tOJsJjWytN5LuCmX/j/cc66VAoTIolzYasweLX8CDQxn3+HUkwzYrw
	jkzO0K25mCDQmmbJv7ZQ/ZSSvK8CZ1q37cLmMeWzBY5b7K2ATuh14ZTGXDH5TYMN63j4toFoxlo
	YxnRdu7vVrC3WuWELaWQzG3MahxZd/ndFrI5ich0/lwt3Ui53Usbqryy/ui8KlvhBWST+wKqwgJ
	ns4b5Ay5xNFN3D1WzzNpAiOzf7M5Y3JU0QOn0q/AodZaWvBKZS41W7WRfN5X6929zb0pewqzuoR
	8qy9w7HtGIS2XH4vKMhXdRUkcCIu5nO6AowxSqOvN8gvmkn6XLiYPIFOmreCBVJSbXEnSw/02Su
	tizeUXSg==
X-Received: by 2002:a05:6000:2012:b0:47f:77a8:7e20 with SMTP id ffacd0b85a97d-47f9fea5857mr10557039f8f.35.1785149332831;
        Mon, 27 Jul 2026 03:48:52 -0700 (PDT)
Received: from spark.Home ([2001:8a0:7280:4000:53fe:effd:424:fa7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm49056188f8f.6.2026.07.27.03.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:48:51 -0700 (PDT)
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
Subject: [RFC PATCH v2 3/4] init: support mounting the root filesystem from an image file
Date: Mon, 27 Jul 2026 11:48:44 +0100
Message-ID: <20260727104845.2607444-4-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727-gepaukt-eislauf-waran-7c03f0e47609@brauner>
References: <20260727-gepaukt-eislauf-waran-7c03f0e47609@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Image-based Linux systems (bootc-style OS updaters, ChromeOS/Android-like
A/B schemes, embedded appliances) commonly keep one or more immutable
root filesystem images as plain files on a writable "carrier"
filesystem and pick one at boot. Today that always requires an
initramfs, even when the initramfs has nothing else to do: the kernel
can only mount a block device (or NFS/CIFS/ubi/mtd) as root, so
userspace must mount the carrier, loop-mount the image and switch_root
into it.

Add a rootimage= parameter naming an image file on the filesystem
specified by root=. When set, root= only designates the carrier: after
mounting it as usual, mount the image file read-only on /image and make
that the root that prepare_namespace() pivots into. The image is
mounted through the filesystem's file-backed mount support (available
in erofs since v6.12) using path_mount_file()/init_mount_file() from
the preceding patches: the image is opened exactly once, and that same
struct file is what actually gets mounted, rather than a path for the
filesystem driver to resolve a second time on its own.
rootimagefstype= and rootimageflags= mirror rootfstype=/rootflags= for
the image mount, while "ro"/"rw"/rootflags= keep applying to the
carrier.

rootimagesrcdir= names a directory inside the image where the carrier
mount is moved once the image is up, since systems following this model
virtually always need continued access to the carrier for their
writable state. Unlike an earlier version of this patch, this is
mandatory rather than defaulting to silently detaching the carrier:
that default made it too easy to end up with a carrier mount that's
still alive (the image mount pins its superblock either way) but
unreachable from the new namespace, with no equivalent of
/sys/block/loopX/loop/backing_file to even tell what it was. Systems
that positively don't need the carrier again can still get the old
behaviour with rootimagesrcdir=none, but have to say so.

This is the file-backed analogue of what dm-mod.create= (CONFIG_DM_INIT)
already does for device-mapper targets: moving a fixed, declarative bit
of early-boot setup from initramfs userspace into the kernel so that
small and verified systems can boot with no initramfs at all.

Assisted-by: opencode:claude-fable-5
Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  34 ++++
 init/do_mounts.c                              | 188 +++++++++++++++++-
 2 files changed, 217 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..a1cd5973e497 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6732,6 +6732,40 @@ Kernel parameters
 
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
+			applying to the carrier filesystem.  Requires
+			rootimagesrcdir=.
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
+			root=) is moved to.  Mandatory when rootimage= is
+			used, since image-based systems almost always need
+			continued access to the carrier for their writable
+			state, and there would otherwise be no way to reach
+			it again once switch_root has happened.  Pass
+			rootimagesrcdir=none instead to explicitly detach the
+			carrier mount, accepting that it becomes unreachable
+			(though still pinned alive by the image mount) after
+			boot.
+
 	rootwait	[KNL] Wait (indefinitely) for root device to show up.
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 55ed3ac0b70f..316421d8b65b 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -122,13 +122,52 @@ __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
+/*
+ * rootimage= mounts the actual root filesystem from an image file located
+ * on the filesystem specified by root= (the "carrier") instead of using
+ * that filesystem as the root directly, so that image-based systems can
+ * boot without an initramfs.  See mount_root_image().
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
+static int __init split_fs_names(char *page, size_t size, const char *names)
 {
 	int count = 1;
 	char *p = page;
 
-	strscpy(p, root_fs_names, size);
+	strscpy(p, names, size);
 	while (*p++) {
 		if (p[-1] == ',') {
 			p[-1] = '\0';
@@ -186,7 +225,7 @@ void __init mount_root_generic(char *name, char *pretty_name, int flags)
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	if (root_fs_names)
-		num_fs = split_fs_names(fs_names, PAGE_SIZE);
+		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 	else
 		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
 retry:
@@ -244,7 +283,144 @@ void __init mount_root_generic(char *name, char *pretty_name, int flags)
 out:
 	put_page(page);
 }
- 
+
+/*
+ * Like do_mount_root(), but the source is the already-open @file rather
+ * than a device/path name for the filesystem to resolve on its own; see
+ * mount_root_image().  Unlike do_mount_root(), ROOT_DEV is left alone:
+ * it identifies the carrier (the boot device), which remains meaningful,
+ * while a file-backed root image typically has no device of its own.
+ */
+static int __init do_mount_root_file(struct file *file, const char *dir,
+				     const char *fs, const int flags,
+				     const void *data)
+{
+	struct super_block *s;
+	struct page *p = NULL;
+	char *data_page = NULL;
+	int ret;
+
+	if (data) {
+		p = alloc_page(GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+		data_page = page_address(p);
+		strscpy_pad(data_page, data, PAGE_SIZE);
+	}
+
+	ret = init_mount_file(file, dir, fs, flags, data_page);
+	if (ret)
+		goto out;
+
+	init_chdir(dir);
+	s = current->fs->pwd.dentry->d_sb;
+	printk(KERN_INFO "VFS: Mounted root image (%s filesystem)%s.\n",
+	       s->s_type->name, sb_rdonly(s) ? " readonly" : "");
+
+out:
+	if (p)
+		put_page(p);
+	return ret;
+}
+
+/*
+ * Mount the actual root filesystem from the image file rootimage= on the
+ * filesystem that was just mounted from root= (the "carrier"), so that
+ * image-based systems can boot without an initramfs.
+ *
+ * Called with the carrier mounted at /root and the cwd there.  The image
+ * file is opened exactly once, and that same struct file is what actually
+ * gets mounted via do_mount_root_file(), rather than a path that the
+ * filesystem driver would then have to resolve again on its own with no
+ * guarantee of landing on the same thing.
+ *
+ * On success the cwd is the image's root, ready for the pivot in
+ * prepare_namespace().  rootimagesrcdir= is mandatory: the carrier is
+ * moved there inside the image, since image-based systems almost always
+ * need continued access to it for their writable state, and silently
+ * leaving it detached-but-pinned by default made it too easy to end up
+ * with a carrier mount that's alive but unreachable from the new
+ * namespace.  rootimagesrcdir=none opts into that explicitly instead.
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
+	if (!root_image_srcdir)
+		panic("VFS: rootimage= requires rootimagesrcdir= (use rootimagesrcdir=none to detach the carrier instead, making it unreachable after boot)");
+	if (strcmp(root_image_srcdir, "none") && root_image_srcdir[0] != '/')
+		panic("VFS: rootimagesrcdir= must be an absolute path or \"none\"");
+
+	path = kmalloc(PATH_MAX, GFP_KERNEL);
+	fs_names = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!path || !fs_names)
+		panic("VFS: unable to mount root image: not enough memory");
+
+	if (snprintf(path, PATH_MAX, "/root%s", root_image) >= PATH_MAX)
+		panic("VFS: rootimage= path too long");
+
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
+		err = do_mount_root_file(file, "/image", p, flags,
+					root_image_mount_data);
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
+	/*
+	 * do_mount_root_file() took its own reference to the file (see
+	 * vfs_parse_fs_param_file()); this reference was only needed to
+	 * open it in the first place.
+	 */
+	fput(file);
+
+	if (!strcmp(root_image_srcdir, "none")) {
+		init_umount("/root", MNT_DETACH);
+	} else {
+		if (snprintf(path, PATH_MAX, "/image%s", root_image_srcdir) >=
+		    PATH_MAX)
+			panic("VFS: rootimagesrcdir= path too long");
+		err = init_mount("/root", path, NULL, MS_MOVE, NULL);
+		if (err)
+			panic("VFS: failed to move the root image's carrier filesystem to %s: error %d",
+			      root_image_srcdir, err);
+	}
+
+	kfree(path);
+	kfree(fs_names);
+}
+
 #ifdef CONFIG_ROOT_NFS
 
 #define NFSROOT_TIMEOUT_MIN	5
@@ -346,7 +522,7 @@ static int __init mount_nodev_root(char *root_device_name)
 	fs_names = (void *)__get_free_page(GFP_KERNEL);
 	if (!fs_names)
 		return -EINVAL;
-	num_fs = split_fs_names(fs_names, PAGE_SIZE);
+	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 
 	for (i = 0, fstype = fs_names; i < num_fs;
 	     i++, fstype += strlen(fstype) + 1) {
@@ -482,6 +658,8 @@ void __init prepare_namespace(void)
 	if (root_wait)
 		wait_for_root(saved_root_name);
 	mount_root(saved_root_name);
+	if (root_image)
+		mount_root_image();
 	devtmpfs_mount();
 
 	if (init_pivot_root(".", ".")) {
-- 
2.43.0

