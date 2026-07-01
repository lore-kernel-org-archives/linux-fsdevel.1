Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F77349CF8
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917674; cv=none; b=Fn3Cnt79RVNPaRzrteebn6Mx3xOupImpQ94YHeqNpclgPfx6fsyN5B1fdnUWn9wecLv11gaqppHiHix6u42/O0a3z5mGMXi5zwacL0nC2bH9VIyVIabyqLb+jv5k94Cy7KOzW/OEv4oBbhBynTa7eqBt8/xCbPA+pPevIqZUgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917674; c=relaxed/simple;
	bh=Dz/Z57ZGsfXWWY4JcWO+YjF+qshi4R9BNohjjEY1NXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LRiteBCz40V5qdQImxjvXdSRzTfX6r3t0i+KM2eqxyxE3QptQVB5AReODmzOMhFgubgkTlG8Fx3spOiPgFaIfveoXnExPfJPt+u7dUOxz+n0SFYSi2k7IgTQDLWd61YnbsirmBhlXrojDsfZ3yZVo7M0kK40ltN3rtpOGYPDqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb4MMJER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb4MMJER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED381F00A3A;
	Wed,  1 Jul 2026 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917673;
	bh=ne/BxaMWcnzyfRVhwNUMLDBnUt8Rg6Quw6SY7IUp3R0=;
	h=From:Date:Subject:To:Cc;
	b=Sb4MMJERpqIM+KNNqgFtMc+MSAI0nS+SB51HDl5yj+kg7yIo9HyG8wi1GmjuZlPTc
	 57ZFhcXJjx0jKmJsNw8y7qADkzqyhjc3hOUXB5ASPWw1JZ0fwQCISc/0L8DPtdqhrv
	 bJuzEipEsbnTTIu76cATG1km72VEZ7Gq8PIrEh6UxFdwbgX9gJdHDs0u1j38gxr+Ut
	 k0W852SysBDJeb7FRBMW4bP1peJIlQC49b5StC/lHh3GOmcZaYV6sqID3LkVRGpxm5
	 LiduVGEpO5SzD6Sq9he+jK6o1dWdwnwqmfnCihR21SkJSlTSmRVZ22PkyPP/j9KkQO
	 CiHL9V3m+sceA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 01 Jul 2026 16:54:23 +0200
Subject: [PATCH] kunit: use scoped_with_init_fs() in tests that resolve
 paths
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-work-kunit-nullfs-v1-1-dfa60270434f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAB4qRWoC/yWMwQ7CIBAFf6XZszQUG4n+iukB6CJIQ80C1aTpv
 wt6nJc3s0NC8pjg1u1AuPnk11hhOHVgnIoPZH6uDIKLC5d8YO+VAgsl+sxiWRabGI4SR22F5Hi
 F6r0Irf/8mvfpz6noJ5rcQu2hVUKmSUXj2rTViOzPfciOUM1wHF9sIRWxlwAAAA==
X-Change-ID: 20260701-work-kunit-nullfs-e47e4bf270e9
To: linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=14938; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Dz/Z57ZGsfXWWY4JcWO+YjF+qshi4R9BNohjjEY1NXA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5aqlbfz0sbHk8Y/H+c1kqzGbidjMXv2uf8e/diYkPO
 nev8986taOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAibAoMv9klMr4X5kx7+/Pm
 tQ2JO+ctWPHxgfaSvLLP+z++LHnP6lzP8L/syxO2HZrSzA+WPXyysv3f+62O8zj2he35qSAxh+f
 S+7vMAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

KUnit runs each test in a kthread (kunit_generic_run_threadfn_adapter()).
Since commit 32750c77e811 ("fs: start all kthreads in nullfs") every
kthread starts out with its fs_struct root and pwd pointing at an empty,
immutable nullfs and can no longer resolve paths.

Two test suites resolve paths from test context and now fail. The misc
minor tests create a device node and open it:

  # miscdev_test_static_basic: EXPECTATION FAILED at drivers/char/misc_minor_kunit.c:166
  failed to create node
  # miscdev_test_static_basic: EXPECTATION FAILED at drivers/char/misc_minor_kunit.c:170
  failed to open misc device: -2

init_mknod("/dev/...") resolves relative to current->fs, which is now
nullfs with no /dev, so node creation returns -ENOENT and the following
filp_open() fails with -ENOENT (-2). The initramfs tests hit the same
wall: they call unpack_to_rootfs() (init_mkdir()/init_mknod() under the
hood) and then verify with relative-name init_stat()/init_unlink()/
filp_open(), all of which resolve against the nullfs root and pwd.

Wrap the path-resolving regions of both suites in scoped_with_init_fs(),
which borrows the userspace init fs_struct (set up by init_userspace_fs()
before kunit_run_all_tests()) for the duration. This is the same opt-in
the rest of the tree uses for kthread path resolution. Doing it per test
rather than blanket-wrapping the KUnit runner keeps the nullfs isolation
in place for the many tests that should never touch the filesystem.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/r/akOrbOsKUqgZarGw@sirena.org.uk
Fixes: 32750c77e811 ("fs: start all kthreads in nullfs")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/char/misc_minor_kunit.c |  25 +++--
 init/initramfs_test.c           | 216 +++++++++++++++++++++++-----------------
 2 files changed, 137 insertions(+), 104 deletions(-)

diff --git a/drivers/char/misc_minor_kunit.c b/drivers/char/misc_minor_kunit.c
index e930c78e1ef9..e85210cbb640 100644
--- a/drivers/char/misc_minor_kunit.c
+++ b/drivers/char/misc_minor_kunit.c
@@ -5,6 +5,7 @@
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/fs_struct.h>
 #include <linux/init_syscalls.h>
 
 /* static minor (LCD_MINOR) */
@@ -160,18 +161,22 @@ static void __init miscdev_test_can_open(struct kunit *test, struct miscdevice *
 	char *devname;
 
 	devname = kasprintf(GFP_KERNEL, "/dev/%s", misc->name);
-	ret = init_mknod(devname, S_IFCHR | 0600,
-			 new_encode_dev(MKDEV(MISC_MAJOR, misc->minor)));
-	if (ret != 0)
-		KUNIT_FAIL(test, "failed to create node\n");
 
-	filp = filp_open(devname, O_RDONLY, 0);
-	if (IS_ERR(filp))
-		KUNIT_FAIL(test, "failed to open misc device: %ld\n", PTR_ERR(filp));
-	else
-		fput(filp);
+	/* Tests run in a nullfs kthread; borrow the init fs to resolve /dev. */
+	scoped_with_init_fs() {
+		ret = init_mknod(devname, S_IFCHR | 0600,
+				 new_encode_dev(MKDEV(MISC_MAJOR, misc->minor)));
+		if (ret != 0)
+			KUNIT_FAIL(test, "failed to create node\n");
+
+		filp = filp_open(devname, O_RDONLY, 0);
+		if (IS_ERR(filp))
+			KUNIT_FAIL(test, "failed to open misc device: %ld\n", PTR_ERR(filp));
+		else
+			fput(filp);
 
-	init_unlink(devname);
+		init_unlink(devname);
+	}
 	kfree(devname);
 }
 
diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index bc55306d226d..1fc990a66563 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -3,6 +3,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/init.h>
 #include <linux/init_syscalls.h>
 #include <linux/initrd.h>
@@ -116,38 +117,41 @@ static void __init initramfs_test_extract(struct kunit *test)
 			      GFP_KERNEL);
 	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-	ktime_get_real_ts64(&ts_before);
-	err = unpack_to_rootfs(cpio_srcbuf, len);
-	ktime_get_real_ts64(&ts_after);
-	if (err) {
-		KUNIT_FAIL(test, "unpack failed %s", err);
-		goto out;
-	}
+	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
+	scoped_with_init_fs() {
+		ktime_get_real_ts64(&ts_before);
+		err = unpack_to_rootfs(cpio_srcbuf, len);
+		ktime_get_real_ts64(&ts_after);
+		if (err) {
+			KUNIT_FAIL(test, "unpack failed %s", err);
+			goto out;
+		}
 
-	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st, 0), 0);
-	KUNIT_EXPECT_TRUE(test, S_ISREG(st.mode));
-	KUNIT_EXPECT_TRUE(test, uid_eq(st.uid, KUIDT_INIT(c[0].uid)));
-	KUNIT_EXPECT_TRUE(test, gid_eq(st.gid, KGIDT_INIT(c[0].gid)));
-	KUNIT_EXPECT_EQ(test, st.nlink, 1);
-	if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
-		KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[0].mtime);
-	} else {
-		KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
-		KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
-	}
-	KUNIT_EXPECT_EQ(test, st.blocks, c[0].filesize);
+		KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st, 0), 0);
+		KUNIT_EXPECT_TRUE(test, S_ISREG(st.mode));
+		KUNIT_EXPECT_TRUE(test, uid_eq(st.uid, KUIDT_INIT(c[0].uid)));
+		KUNIT_EXPECT_TRUE(test, gid_eq(st.gid, KGIDT_INIT(c[0].gid)));
+		KUNIT_EXPECT_EQ(test, st.nlink, 1);
+		if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
+			KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[0].mtime);
+		} else {
+			KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
+			KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
+		}
+		KUNIT_EXPECT_EQ(test, st.blocks, c[0].filesize);
 
-	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st, 0), 0);
-	KUNIT_EXPECT_TRUE(test, S_ISDIR(st.mode));
-	if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
-		KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[1].mtime);
-	} else {
-		KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
-		KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
-	}
+		KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st, 0), 0);
+		KUNIT_EXPECT_TRUE(test, S_ISDIR(st.mode));
+		if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
+			KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[1].mtime);
+		} else {
+			KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
+			KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
+		}
 
-	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-	KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+		KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+	}
 out:
 	kfree(cpio_srcbuf);
 }
@@ -197,8 +201,11 @@ static void __init initramfs_test_fname_overrun(struct kunit *test)
 		suffix_off--;
 	}
 
-	err = unpack_to_rootfs(cpio_srcbuf, len);
-	KUNIT_EXPECT_NOT_NULL(test, err);
+	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
+	scoped_with_init_fs() {
+		err = unpack_to_rootfs(cpio_srcbuf, len);
+		KUNIT_EXPECT_NOT_NULL(test, err);
+	}
 
 	kfree(cpio_srcbuf);
 }
@@ -233,22 +240,25 @@ static void __init initramfs_test_data(struct kunit *test)
 
 	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-	err = unpack_to_rootfs(cpio_srcbuf, len);
-	KUNIT_EXPECT_NULL(test, err);
+	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
+	scoped_with_init_fs() {
+		err = unpack_to_rootfs(cpio_srcbuf, len);
+		KUNIT_EXPECT_NULL(test, err);
 
-	file = filp_open(c[0].fname, O_RDONLY, 0);
-	if (IS_ERR(file)) {
-		KUNIT_FAIL(test, "open failed");
-		goto out;
-	}
+		file = filp_open(c[0].fname, O_RDONLY, 0);
+		if (IS_ERR(file)) {
+			KUNIT_FAIL(test, "open failed");
+			goto out;
+		}
 
-	/* read back file contents into @cpio_srcbuf and confirm match */
-	len = kernel_read(file, cpio_srcbuf, c[0].filesize, NULL);
-	KUNIT_EXPECT_EQ(test, len, c[0].filesize);
-	KUNIT_EXPECT_MEMEQ(test, cpio_srcbuf, c[0].data, len);
+		/* read back file contents into @cpio_srcbuf and confirm match */
+		len = kernel_read(file, cpio_srcbuf, c[0].filesize, NULL);
+		KUNIT_EXPECT_EQ(test, len, c[0].filesize);
+		KUNIT_EXPECT_MEMEQ(test, cpio_srcbuf, c[0].data, len);
 
-	fput(file);
-	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+		fput(file);
+		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	}
 out:
 	kfree(cpio_srcbuf);
 }
@@ -288,25 +298,28 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-	err = unpack_to_rootfs(cpio_srcbuf, len);
-	KUNIT_EXPECT_NULL(test, err);
+	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
+	scoped_with_init_fs() {
+		err = unpack_to_rootfs(cpio_srcbuf, len);
+		KUNIT_EXPECT_NULL(test, err);
 
-	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
+		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+		KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
 
-	/* mess up the csum and confirm that unpack fails */
-	c[0].csum--;
-	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
+		/* mess up the csum and confirm that unpack fails */
+		c[0].csum--;
+		len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-	err = unpack_to_rootfs(cpio_srcbuf, len);
-	KUNIT_EXPECT_NOT_NULL(test, err);
+		err = unpack_to_rootfs(cpio_srcbuf, len);
+		KUNIT_EXPECT_NOT_NULL(test, err);
 
-	/*
-	 * file (with content) is still retained in case of bad-csum abort.
-	 * Perhaps we should change this.
-	 */
-	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), -ENOENT);
+		/*
+		 * file (with content) is still retained in case of bad-csum abort.
+		 * Perhaps we should change this.
+		 */
+		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+		KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), -ENOENT);
+	}
 	kfree(cpio_srcbuf);
 }
 
@@ -344,17 +357,20 @@ static void __init initramfs_test_hardlink(struct kunit *test)
 
 	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-	err = unpack_to_rootfs(cpio_srcbuf, len);
-	KUNIT_EXPECT_NULL(test, err);
+	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
+	scoped_with_init_fs() {
+		err = unpack_to_rootfs(cpio_srcbuf, len);
+		KUNIT_EXPECT_NULL(test, err);
 
-	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
-	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
-	KUNIT_EXPECT_EQ(test, st0.ino, st1.ino);
-	KUNIT_EXPECT_EQ(test, st0.nlink, 2);
-	KUNIT_EXPECT_EQ(test, st1.nlink, 2);
+		KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
+		KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
+		KUNIT_EXPECT_EQ(test, st0.ino, st1.ino);
+		KUNIT_EXPECT_EQ(test, st0.nlink, 2);
+		KUNIT_EXPECT_EQ(test, st1.nlink, 2);
 
-	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
+		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+		KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
+	}
 
 	kfree(cpio_srcbuf);
 }
@@ -387,12 +403,15 @@ static void __init initramfs_test_many(struct kunit *test)
 	}
 
 	len = p - cpio_srcbuf;
-	err = unpack_to_rootfs(cpio_srcbuf, len);
-	KUNIT_EXPECT_NULL(test, err);
+	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
+	scoped_with_init_fs() {
+		err = unpack_to_rootfs(cpio_srcbuf, len);
+		KUNIT_EXPECT_NULL(test, err);
 
-	for (i = 0; i < INITRAMFS_TEST_MANY_LIMIT; i++) {
-		sprintf(thispath, "initramfs_test_many-%d", i);
-		KUNIT_EXPECT_EQ(test, init_unlink(thispath), 0);
+		for (i = 0; i < INITRAMFS_TEST_MANY_LIMIT; i++) {
+			sprintf(thispath, "initramfs_test_many-%d", i);
+			KUNIT_EXPECT_EQ(test, init_unlink(thispath), 0);
+		}
 	}
 
 	kfree(cpio_srcbuf);
@@ -439,22 +458,25 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
 	memcpy(tbufs->padded_fname, "padded_fname", sizeof("padded_fname"));
 	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_srcbuf);
 
-	err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
-	KUNIT_EXPECT_NULL(test, err);
+	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
+	scoped_with_init_fs() {
+		err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
+		KUNIT_EXPECT_NULL(test, err);
 
-	file = filp_open(c[0].fname, O_RDONLY, 0);
-	if (IS_ERR(file)) {
-		KUNIT_FAIL(test, "open failed");
-		goto out;
-	}
+		file = filp_open(c[0].fname, O_RDONLY, 0);
+		if (IS_ERR(file)) {
+			KUNIT_FAIL(test, "open failed");
+			goto out;
+		}
 
-	/* read back file contents into @cpio_srcbuf and confirm match */
-	len = kernel_read(file, tbufs->cpio_srcbuf, c[0].filesize, NULL);
-	KUNIT_EXPECT_EQ(test, len, c[0].filesize);
-	KUNIT_EXPECT_MEMEQ(test, tbufs->cpio_srcbuf, c[0].data, len);
+		/* read back file contents into @cpio_srcbuf and confirm match */
+		len = kernel_read(file, tbufs->cpio_srcbuf, c[0].filesize, NULL);
+		KUNIT_EXPECT_EQ(test, len, c[0].filesize);
+		KUNIT_EXPECT_MEMEQ(test, tbufs->cpio_srcbuf, c[0].data, len);
 
-	fput(file);
-	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+		fput(file);
+		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	}
 out:
 	kfree(tbufs);
 }
@@ -495,13 +517,16 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	memcpy(tbufs->fname_ok, "fname_ok", sizeof("fname_ok") - 1);
 	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_src);
 
-	/* unpack skips over fname_oversize instead of returning an error */
-	err = unpack_to_rootfs(tbufs->cpio_src, len);
-	KUNIT_EXPECT_NULL(test, err);
+	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
+	scoped_with_init_fs() {
+		/* unpack skips over fname_oversize instead of returning an error */
+		err = unpack_to_rootfs(tbufs->cpio_src, len);
+		KUNIT_EXPECT_NULL(test, err);
 
-	KUNIT_EXPECT_EQ(test, init_stat("fname_oversize", &st0, 0), -ENOENT);
-	KUNIT_EXPECT_EQ(test, init_stat("fname_ok", &st1, 0), 0);
-	KUNIT_EXPECT_EQ(test, init_rmdir("fname_ok"), 0);
+		KUNIT_EXPECT_EQ(test, init_stat("fname_oversize", &st0, 0), -ENOENT);
+		KUNIT_EXPECT_EQ(test, init_stat("fname_ok", &st1, 0), 0);
+		KUNIT_EXPECT_EQ(test, init_rmdir("fname_ok"), 0);
+	}
 
 	kfree(tbufs);
 }
@@ -539,8 +564,11 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 	/* inject_ox=true to add "0x" cpio field prefixes */
 	len = fill_cpio(c, ARRAY_SIZE(c), true, tbufs->cpio_src);
 
-	err = unpack_to_rootfs(tbufs->cpio_src, len);
-	KUNIT_EXPECT_NOT_NULL(test, err);
+	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
+	scoped_with_init_fs() {
+		err = unpack_to_rootfs(tbufs->cpio_src, len);
+		KUNIT_EXPECT_NOT_NULL(test, err);
+	}
 
 	kfree(tbufs);
 }

---
base-commit: 1b8a585da1b50b3db0e7bbd073ca274875539ea8
change-id: 20260701-work-kunit-nullfs-e47e4bf270e9

