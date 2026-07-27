Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981623F8EB9
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149338; cv=none; b=puAnmleEx1XCEXrzbPS0hxMu79kBf1Rwc0nNbY0NadQ+cdqBuqMx3Hen0X6JLrlyDeOVVJL9YvWuAOpolUykPHmS90NxQ/MQ5uoVsYTSCxpCUJTv/jC9qpwn2WNM3FgVOCLbLHwmShswkB/E1+vvoccAFbRmtBkUJIebmxSI3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149338; c=relaxed/simple;
	bh=hg0VxiqwTG4GDY1/68YGOpUKyd6ueq3zktC9mXA0kkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjxAuLDrp33AwQ5Vp/bJXUV9bjJhTc7XzKfqPp+xQurmBYXevN+tRJzjFwSjXkBozPtXj/SxuJBEon0SQfxkHBPFmWSyQxy7o2Dbc1rWKnZ3E/raYff6oM88kEpaermPkWRgubgmRvdpazSyiRB81lQqb15vhRisG5pMDv7Lnsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEG79+Y4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEG79+Y4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f84023916so2568621f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785149335; x=1785754135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIBDnTFBEfRAPDF98N/BG5njMjm4UBvysiUnpdybqUo=;
        b=EEG79+Y4Kse89xbLnsVuiEUS12b4VQILf6iOr9AkS+kIpHI6yOxJLRr2CP+4vzP+Dd
         5rxcmvUdLmgKlXlJzHmKL8OgX/hvsRpuznNXRKMZa8xj7SYW5IXmK1PT//ur4ha/hXbE
         Pp03MlJcwKaB8Y9wC1+OC1DPYajZAUIcTrjTF18CxY4J+yeZj3HV98LxSiJmeRGhdRg7
         2CuCQaARXoIKZm6lvZipA87hT3ssbbyE8UB0P78rf3SAIv6g81kD2zIh936Bjsh1nVfY
         UFLEwo5BZPoIscf84qBrxI4/CluevAR65jEf7hTskd+B/9YIoVkL0BRlbta15jjj4LKC
         /F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149335; x=1785754135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gIBDnTFBEfRAPDF98N/BG5njMjm4UBvysiUnpdybqUo=;
        b=UFcSxFd8NBsS23T7NLAwCmRv+KTyV+WEJjUr1p76Riliide4RrrCA4zQdjFvVbiBUA
         33yxDDmIMOWf0WA1seM4EJBxeAg16BvIgjvVnFQMIb30kMhrleTXBHswawvgpO1DOxJh
         ebgV/gb+a0VGP7VjVbdRYbgIWTdcadJmo67ODxB52YDTMq6hgbv2Ns65Ix6fXFOX6KF4
         l+jpNKWi5ebIrSHDylb2LjU6ZDPI+yR+ppZ1appJ/lQm24Kyygz//agZjkfpYj88Yi3K
         oLguOBgyGNredg6o6UAZyv3/QS2G1POlFrWhvwm8GunaOYGQEHrNQTiL0B/TCeNnq320
         GNRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsVnId+eo9nyLFeple0ePoUZlYU/KZ+X1sSIEc9UKPH21cKNQ37wp/ji+migzQuYq97YCx726knQdt6IiI@vger.kernel.org
X-Gm-Message-State: AOJu0Yydw0AjcETeOSCksrKEKrEfrxjVpoUn/zaCWKhTAINKG2Ip2GYK
	w5tCHZp2OJQo2abvaEDCVnklk1yoHzqJWUV8H/kDBaCDVDBfQ9Kl0cH2
X-Gm-Gg: AR+sD11ZmqA7S6jEA/OSmd1oJfKdx3BH1OUqxkAzZZtkukctbr5FZVDVnkD8P56CVWG
	XpIjqJl1QfTBIfhUVi5+e5OkBkl650CkiH35ijbVx2EXE7ezQCvCImFRmHZnKsmEjQyBbAaw/bi
	NlQGfH4wgN/c76sGCXvetOqThDaAzddYsfYgn9A9O87qAmKLqxmzSnuFwdsrJiobsgs9jQbl4Nx
	BMSVu6znCKFA35fB8Jp+UHhy/qFyQvsALZEyUH3ujW8zbhAfKkCevOAo78aVM1SzqAG0y06z8Ac
	P4FZr+x/I3Tn5spBFvBOnNXZojv2Ho74eDp+c/FiVZKktYCGGci02l7yWVzYPKDtvphI456/SPc
	dGAPrZDGrCOp5kxk4Blw4WsJuHMBag5VKJ/B8wpZ87VaQWCfRhIEdqL65sjNzRHhhogAjoyB567
	KE947Xbw==
X-Received: by 2002:a05:6000:178e:b0:47f:9d0e:f94 with SMTP id ffacd0b85a97d-47f9fea4247mr10061977f8f.36.1785149334424;
        Mon, 27 Jul 2026 03:48:54 -0700 (PDT)
Received: from spark.Home ([2001:8a0:7280:4000:53fe:effd:424:fa7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm49056188f8f.6.2026.07.27.03.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:48:53 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/4] init: support pinning the root image's fsverity digest
Date: Mon, 27 Jul 2026 11:48:45 +0100
Message-ID: <20260727104845.2607444-5-ericcurtin17@gmail.com>
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

When the root filesystem is mounted from an image file with rootimage=,
the carrier filesystem holding the image is typically writable and
therefore untrusted. Systems that seal their root images with fsverity
currently need an initramfs for the sole purpose of checking that the
image carries the expected fsverity digest before mounting it.

Add rootimageverity=<hash algorithm>:<hex digest>, which requires the
rootimage= file to have fsverity enabled with exactly this file digest
and fails the boot otherwise, using the same fsverity_get_digest()
interface that IMA and overlayfs already use for digest pinning.
Verification runs on the exact struct file that mount_root_image() then
hands to do_mount_root_file(): the fd-based mount from the preceding
patches means there is no separate path lookup afterwards that could
resolve to something else, and nothing between the check and the mount
that a userspace-less boot could race.

Combined with a trusted kernel command line (e.g. a signed unified
kernel image, or a TPM-measured bootloader configuration), this extends
the chain of trust to every byte of the root filesystem without any
userspace boot stage: the digest pins the image's Merkle tree, and
fsverity keeps verifying all data read from the image against it at
runtime, so post-boot tampering with the carrier filesystem is detected
as well. It is the file-backed counterpart of setting up a dm-verity
target for a partition-backed root via dm-mod.create=.

Two things this does not and cannot do:

 - Establish trust in the carrier filesystem itself. Reaching the image
   file at all means parsing carrier filesystem metadata (superblock,
   directory entries, extents) before any of this runs, the same way a
   dm-verity root still needs a trusted block layer underneath it -
   this is meant to sit on top of an already-appropriately-trusted
   carrier (e.g. one that is itself dm-verity/LUKS-backed, or a
   well-audited always-read-only filesystem), not conjure trust in an
   arbitrary writable one.

 - Cover erofs images that pull in extra devices via
   rootimageflags=device=device=..., since the pinned digest only ever
   applies to the primary image file. Refuse to boot in that
   combination rather than give a false sense of integrity.

Assisted-by: opencode:claude-fable-5
Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 22 +++++
 init/do_mounts.c                              | 91 ++++++++++++++++++-
 2 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1cd5973e497..dcb5a78fba55 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6766,6 +6766,28 @@ Kernel parameters
 			(though still pinned alive by the image mount) after
 			boot.
 
+	rootimageverity= [KNL] Require the root image specified by
+			rootimage= to have fsverity enabled with this file
+			digest, given as <hash algorithm>:<hex digest>,
+			e.g. sha256:dd1b3fa9...  The boot is aborted if the
+			image carries no or a different fsverity digest, or
+			if rootimageflags= adds extra devices via device=
+			(their contents would not be covered by the digest).
+			Because fsverity keeps verifying data read from the
+			image against its Merkle tree at runtime, a trusted
+			(e.g. signed or TPM-measured) kernel command line
+			extends the chain of trust to the complete root
+			filesystem contents without an initramfs, provided
+			the carrier filesystem holding the image is itself
+			from a trusted source (rootimage= verifies the image
+			file; it does not and cannot retroactively establish
+			trust in the carrier filesystem code and metadata
+			that had to be parsed to reach that file in the first
+			place - the same way a dm-verity root still needs a
+			trusted block layer under it).  Requires
+			CONFIG_FS_VERITY and a carrier filesystem with
+			fsverity support.
+
 	rootwait	[KNL] Wait (indefinitely) for root device to show up.
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 316421d8b65b..d4362fd758d8 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -24,6 +24,9 @@
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
 #include <linux/raid/detect.h>
+#include <linux/fsverity.h>
+#include <linux/hex.h>
+#include <crypto/hash_info.h>
 #include <uapi/linux/mount.h>
 
 #include "do_mounts.h"
@@ -156,10 +159,18 @@ static int __init root_image_srcdir_setup(char *str)
 	return 1;
 }
 
+static char * __initdata root_image_verity;
+static int __init root_image_verity_setup(char *str)
+{
+	root_image_verity = str;
+	return 1;
+}
+
 __setup("rootimage=", root_image_setup);
 __setup("rootimagefstype=", root_image_fs_names_setup);
 __setup("rootimageflags=", root_image_data_setup);
 __setup("rootimagesrcdir=", root_image_srcdir_setup);
+__setup("rootimageverity=", root_image_verity_setup);
 
 /* This can return zero length strings. Caller should check */
 static int __init split_fs_names(char *page, size_t size, const char *names)
@@ -323,16 +334,73 @@ static int __init do_mount_root_file(struct file *file, const char *dir,
 	return ret;
 }
 
+#ifdef CONFIG_FS_VERITY
+/*
+ * Require the root image to carry the fsverity file digest given by
+ * rootimageverity=<hash algorithm>:<hex digest>.  @file must have been
+ * opened so that its fsverity information is loaded, and must be the
+ * exact file that do_mount_root_file() then mounts (see
+ * mount_root_image()): unlike checking a file and then separately
+ * mounting a path that is assumed, but not guaranteed, to name the same
+ * thing, there is no lookup left for anything to race or disagree with
+ * between this check and the mount.
+ *
+ * Any deviation fails the boot: with a trusted command line this pins
+ * the complete image contents, which fsverity keeps verifying against
+ * the image's Merkle tree as they are read.
+ */
+static void __init verify_root_image(struct file *file)
+{
+	u8 want[FS_VERITY_MAX_DIGEST_SIZE], got[FS_VERITY_MAX_DIGEST_SIZE];
+	enum hash_algo want_algo, got_algo;
+	int want_size, got_size, i;
+	char *hex;
+
+	hex = strchr(root_image_verity, ':');
+	if (!hex)
+		panic("VFS: rootimageverity= expects <algorithm>:<hex digest>");
+	*hex++ = '\0';
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, root_image_verity);
+	if (i < 0)
+		panic("VFS: rootimageverity=: unknown hash algorithm \"%s\"",
+		      root_image_verity);
+	want_algo = i;
+	want_size = hash_digest_size[want_algo];
+	if (strlen(hex) != 2 * want_size || hex2bin(want, hex, want_size))
+		panic("VFS: rootimageverity=: expected %d-byte hex digest",
+		      want_size);
+
+	got_size = fsverity_get_digest(file_inode(file), got, NULL, &got_algo);
+	if (!got_size)
+		panic("VFS: root image does not have fsverity enabled");
+	if (got_algo != want_algo || got_size != want_size ||
+	    memcmp(want, got, want_size))
+		panic("VFS: root image fsverity digest mismatch: expected %s:%*phN, got %s:%*phN",
+		      hash_algo_name[want_algo], want_size, want,
+		      hash_algo_name[got_algo], got_size, got);
+
+	pr_info("VFS: verified root image fsverity digest %s:%*phN\n",
+		hash_algo_name[want_algo], want_size, want);
+}
+#else /* !CONFIG_FS_VERITY */
+static void __init verify_root_image(struct file *file)
+{
+	panic("VFS: rootimageverity= requires CONFIG_FS_VERITY");
+}
+#endif /* !CONFIG_FS_VERITY */
+
 /*
  * Mount the actual root filesystem from the image file rootimage= on the
  * filesystem that was just mounted from root= (the "carrier"), so that
  * image-based systems can boot without an initramfs.
  *
  * Called with the carrier mounted at /root and the cwd there.  The image
- * file is opened exactly once, and that same struct file is what actually
- * gets mounted via do_mount_root_file(), rather than a path that the
- * filesystem driver would then have to resolve again on its own with no
- * guarantee of landing on the same thing.
+ * file is opened exactly once; that same struct file is optionally
+ * fsverity-checked and is what actually gets mounted via
+ * do_mount_root_file(), so there is no window in which the checked file
+ * could be swapped for another before it is mounted, and no independent,
+ * second path lookup for a filesystem driver to disagree with about what
+ * "the image" refers to.
  *
  * On success the cwd is the image's root, ready for the pivot in
  * prepare_namespace().  rootimagesrcdir= is mandatory: the carrier is
@@ -355,6 +423,16 @@ static void __init mount_root_image(void)
 		panic("VFS: rootimage= requires rootimagesrcdir= (use rootimagesrcdir=none to detach the carrier instead, making it unreachable after boot)");
 	if (strcmp(root_image_srcdir, "none") && root_image_srcdir[0] != '/')
 		panic("VFS: rootimagesrcdir= must be an absolute path or \"none\"");
+	/*
+	 * A digest pinned via rootimageverity= only ever covers the
+	 * primary image file; an erofs image that pulls in extra devices
+	 * via rootimageflags=device=... would silently leave those
+	 * unverified, so refuse rather than give a false sense of
+	 * integrity.
+	 */
+	if (root_image_verity && root_image_mount_data &&
+	    strstr(root_image_mount_data, "device="))
+		panic("VFS: rootimageverity= does not cover extra devices added via rootimageflags=device=; refusing to boot");
 
 	path = kmalloc(PATH_MAX, GFP_KERNEL);
 	fs_names = kmalloc(PAGE_SIZE, GFP_KERNEL);
@@ -369,6 +447,9 @@ static void __init mount_root_image(void)
 		panic("VFS: unable to open root image %s: error %ld",
 		      root_image, PTR_ERR(file));
 
+	if (root_image_verity)
+		verify_root_image(file);
+
 	err = init_mkdir("/image", 0700);
 	if (err < 0 && err != -EEXIST)
 		panic("VFS: unable to create /image: error %d", err);
@@ -401,7 +482,7 @@ static void __init mount_root_image(void)
 	/*
 	 * do_mount_root_file() took its own reference to the file (see
 	 * vfs_parse_fs_param_file()); this reference was only needed to
-	 * open it in the first place.
+	 * open it and, if requested, check its fsverity digest.
 	 */
 	fput(file);
 
-- 
2.43.0

