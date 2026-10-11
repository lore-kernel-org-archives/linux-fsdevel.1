Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE5331EB7
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734202; cv=none; b=mk1idy78795SmpNpmiTQQHKNdeQgPSLwobMv5dMsxb09KOA9zmDAF3gsEWgR0wYVXTmRyhbYp3LEttApn2jgabygM58WN8jjlqI6WUtbfTNH++ielYTXHNg+wnw6Vb8B9Bx8Y5r3d+NyvosRryb5lBPOR7f+jUOLHYANYeC+zpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734202; c=relaxed/simple;
	bh=ikKEsWSUB4YG5Ph1h0m+dxdF9Rkl+uyh6dQ3lQ44EwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gfbkic0onMN3sw3bZeyj+/mEehetGdr7EP+tYWyX1+wq1GfnS+SNqXTLgAfsyx2YCi0XpeJqgd6ZJsZTYZQRy6H7LdgA0tYXKN5X19sCk5w6ABw0SKgD2sH64RtMmZXxrpkOz+8AW2iKuCP+r4jxzv/xE/6kijZ6pfCdrlk2Sj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM108RmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM108RmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A3F1F0089B;
	Sun, 11 Oct 2026 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734201;
	bh=aZmoTOssMXI6WTN1Su7j7YjS3GlC+2xxLZHDK3RlZoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eM108RmIFRTUM1SR42A7TI1qLBgLit+BMlxrpuEXJDYxgIOB3Ylibfetx9E7I2W8n
	 z+K9eiTR/HL70TwJBxpK7KWssNY8ndDQdwwLPgfPGKiVjOtuzF2kXTXaxHxjE99XUj
	 tzGTsvIJ7uGXMwDBjd6SHyUcMEhT+n6nveF1/sdDMIp9QOxP5EGNncHUoIbL8wyBPO
	 DUvtHAhklEMLnWyxyHMynGGF/I40BkHHI+ij+y1KlK3rritOHnB82QHvnhHrPVfC4B
	 sQFWEVzxWuxQTVhbeRW7SGToSWhCvMILUrrcI/HqVkU6N3RBmD0/1pqIp0ckv9Rjrl
	 3/max7G9+sRUg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:15 +0200
Subject: [PATCH 15/15] selftests/filesystems: add tests for reconfiguring a
 reused fs_context
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-15-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2898; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ikKEsWSUB4YG5Ph1h0m+dxdF9Rkl+uyh6dQ3lQ44EwI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jjn1UYVvWVR5o9+2vGnnspqr7xnXrP5k8oHtfbY9
 S0HCmev6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI0UaGf2YiT2ezZR9W/V3Q
 ttTB7llI/HdDRsVLMuurLrevfrPgbC4jw22r2zVBnSunBiWfbAyO/XveyTJ0S6bBtaerVb6t2Ln
 QmRcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add tests that "ro" doesn't leak into the next reconfiguration through
the same context:

- reconfiguration through the context fsmount() was called on
- second reconfiguration through a context from fspick()

Without the fix both make the read-only superblock read-write.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../filesystems/fspick_reconfigure_test.c          | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/filesystems/fspick_reconfigure_test.c b/tools/testing/selftests/filesystems/fspick_reconfigure_test.c
index 2908c7369264..a184a5af06d4 100644
--- a/tools/testing/selftests/filesystems/fspick_reconfigure_test.c
+++ b/tools/testing/selftests/filesystems/fspick_reconfigure_test.c
@@ -8,6 +8,9 @@
  * superblock read-only. Check that writes through a read-write bind mount of
  * a read-only ext4 superblock are still refused after such a reconfiguration
  * and that an explicit "rw" still makes the superblock read-write.
+ *
+ * After fsmount() and after each reconfiguration the context can be used for
+ * the next reconfiguration. A "ro" set before must not carry over into it.
  */
 #define _GNU_SOURCE
 #include <errno.h>
@@ -183,4 +186,46 @@ TEST_F(fspick_ro, reconfigure_rw)
 	ASSERT_EQ(create_file(self->bind), 0);
 }
 
+TEST_F(fspick_ro, reconfigure_after_fsmount_keeps_ro)
+{
+	char dev[32];
+	int fd, mfd;
+
+	/* Make room for the new mount, the bind mount keeps the superblock. */
+	ASSERT_EQ(sys_umount2(self->mnt, 0), 0);
+	self->mounted = false;
+
+	snprintf(dev, sizeof(dev), "/dev/loop%d", self->loop);
+	fd = sys_fsopen("ext4", FSOPEN_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(sys_fsconfig(fd, FSCONFIG_SET_STRING, "source", dev, 0), 0);
+	ASSERT_EQ(sys_fsconfig(fd, FSCONFIG_SET_FLAG, "ro", NULL, 0), 0);
+	ASSERT_EQ(sys_fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+	mfd = sys_fsmount(fd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_GE(mfd, 0);
+	ASSERT_EQ(sys_move_mount(mfd, "", AT_FDCWD, self->mnt,
+				 MOVE_MOUNT_F_EMPTY_PATH), 0);
+	self->mounted = true;
+	close(mfd);
+
+	ASSERT_EQ(sys_fsconfig(fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0), 0);
+	close(fd);
+	ASSERT_EQ(create_file(self->bind), -EROFS)
+		TH_LOG("reconfiguration after fsmount() made the superblock read-write");
+}
+
+TEST_F(fspick_ro, reconfigure_twice_keeps_ro)
+{
+	int fd;
+
+	fd = sys_fspick(AT_FDCWD, self->mnt, FSPICK_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(sys_fsconfig(fd, FSCONFIG_SET_FLAG, "ro", NULL, 0), 0);
+	ASSERT_EQ(sys_fsconfig(fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0), 0);
+	ASSERT_EQ(sys_fsconfig(fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0), 0);
+	close(fd);
+	ASSERT_EQ(create_file(self->bind), -EROFS)
+		TH_LOG("second reconfiguration made the superblock read-write");
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0

