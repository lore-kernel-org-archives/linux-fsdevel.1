Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9C57D208
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201971; cv=none; b=cDWSCTEjmY+yk7M5Vh+fsIvoO30hbyXUC4woLP9uWbu+WQuRWRWUULEuZcDtOj7n/L1Spd2tOlqBH/oe0w8c3oU7OtoJ4UGALgVDaijfXtidEcaN1Wb1aVnewxMxDF78Yq3njo5+/4zjKZ7ezMq4xMapAR359hj0yl+/Au4me2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201971; c=relaxed/simple;
	bh=vVPl82I0C3uQBrS9LYdp8YNP0IB2qNwWdH923lGVrU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JkLRi/UxCQg1pRaL/uuKRC5F77NwPYd0E27xUWJC4bP+hd3sZIigD8TKz32u63Mmg71oqTiHKKPHBDMGvNmPKW/u/KCUuSD8jcOY9yhw+GWs1ABDjL+bdQEW7H8bM6FJ0tKPbZXJiuvap5xHG8MOhdHUvgS2ZDC+Z3t7oN4/mwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDCvluAu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDCvluAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776A21F00893;
	Wed, 23 Sep 2026 22:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790201970;
	bh=9J03Qe1gtni+OJzxo2cbcj3X+Rg95uG3mC4saM7hVbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LDCvluAuGq6jR2c/FAg2MDMFLcyFct7lYjjdtS5sFESf8sZD7F27fXPXFNdPADgfZ
	 IphXDFgxKWtKND5EZ/aado/ni3BKWwC3vqdgzqlbbuTrPmu+0oBXc8VnxcO6phLUsB
	 tjtxqo70rWQj3KrpkgMA18VDe4hDskajw8iiFyBZi0JbZhX8N6UPT3WU3OT5MMdyQ6
	 xV5yC2I5NKFgCwXW5ELBxkUUQ/HU6ZFJ1KsNCWKOBCx3vsS6byZyZkSWsW4mHIWJFi
	 STXp0UKhk9H++6ClFxxRhL5gR54Y2hjj9TINf3sD7GZ60yVJxiqqfYyqBBI3fwQWUJ
	 LPsTd1Xay4X+A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Sep 2026 00:18:54 +0200
Subject: [PATCH RFC 5/6] selftests/filesystems: check the two-step cycle
 over crossed loop images
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-work-mount-knullfs-v1-5-ae89b29f7cb3@kernel.org>
References: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
In-Reply-To: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4326; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vVPl82I0C3uQBrS9LYdp8YNP0IB2qNwWdH923lGVrU0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtCUhOd1kx2W7VJJVZb4wbJ5kVxz2ZxBNU1XTC9aLWV
 1HLRSK1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO59JeR4ZDOEo9aed0dd5WW
 CNQYya/h+apT639+s5xa3s8tkdbabYwMK2SmPDJdLFh75lG30LTcvd5y358dvfucfW+i3OuzS+9
 IMwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Two tmpfs mounts in a child namespace, each carrying the image of the
loop mount below the other. Check that both loop devices are released
after:

- rmdir of the first tmpfs' mountpoint from the parent namespace, which
  leaves the loop mount below it connected while its image's mount lives

- rmdir of the second, which takes it down with the loop mount whose
  image is on the first, by then dead, tmpfs

Each dead tmpfs then owns a loop mount whose filesystem pins the other.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../filesystems/mount_cycle/loop_cycle_test.c      | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c b/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
index 67fc3e420c92..4f4c88397861 100644
--- a/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
+++ b/tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
@@ -204,6 +204,34 @@ static int loop_mount(const char *img, const char *mp)
 	return n;
 }
 
+/*
+ * Two tmpfs mounts, each carrying the image of the loop mount below the
+ * other: the loop mount below /mnt_dir/vol has its image on /mnt_dir/vol2
+ * and the other way round.
+ */
+static int crossed_child(int to_parent, int from_parent)
+{
+	int n[2];
+	char c;
+
+	if (unshare(CLONE_NEWNS) || mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		return CHILD_NS;
+	if (mkdir("/mnt_dir/vol", 0755) || mount("tmpfs", "/mnt_dir/vol", "tmpfs", 0, NULL) ||
+	    mkdir("/mnt_dir/vol2", 0755) || mount("tmpfs", "/mnt_dir/vol2", "tmpfs", 0, NULL))
+		return CHILD_NS;
+	n[0] = loop_mount("/mnt_dir/vol2/img", "/mnt_dir/vol/mnt");
+	if (n[0] < 0)
+		return -n[0];
+	n[1] = loop_mount("/mnt_dir/vol/img", "/mnt_dir/vol2/mnt");
+	if (n[1] < 0)
+		return -n[1];
+	if (write(to_parent, n, sizeof(n)) != sizeof(n))
+		return CHILD_PIPE;
+	if (read(from_parent, &c, 1) != 1)
+		return CHILD_PIPE;
+	return CHILD_OK;
+}
+
 /*
  * In its own mount namespace the child mounts a tmpfs on /mnt_dir/vol,
  * puts a filesystem image on it, binds a loop device to the image and
@@ -374,4 +402,64 @@ TEST_F(loop_cycle, dissolved_tree_loop_mount_released)
 	assert_loop_released(_metadata, self);
 }
 
+/*
+ * The cycle in two steps: rmdir of /mnt_dir/vol leaves the loop mount
+ * below it connected while its image's mount, /mnt_dir/vol2, is alive;
+ * then rmdir of /mnt_dir/vol2 takes that one with the loop mount whose
+ * image is on the dead /mnt_dir/vol. Each dead mount now owns a loop
+ * mount whose filesystem pins the other.
+ */
+TEST_F(loop_cycle, crossed_images_released)
+{
+	int to_parent[2], to_child[2];
+	char sysfs[2][64], dev[2][32];
+	int status, n[2] = { -1, -1 };
+	pid_t pid;
+
+	ASSERT_EQ(pipe(to_parent), 0);
+	ASSERT_EQ(pipe(to_child), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(to_parent[0]);
+		close(to_child[1]);
+		_exit(crossed_child(to_parent[1], to_child[0]));
+	}
+	close(to_parent[1]);
+	close(to_child[0]);
+
+	if (read(to_parent[0], n, sizeof(n)) != sizeof(n)) {
+		waitpid(pid, &status, 0);
+		if (WIFEXITED(status) && WEXITSTATUS(status) == CHILD_MOUNT)
+			SKIP(return, "test requires a FAT filesystem");
+		ASSERT_EQ(status, 0);
+	}
+	for (int i = 0; i < 2; i++) {
+		snprintf(dev[i], sizeof(dev[i]), "/dev/loop%d", n[i]);
+		snprintf(sysfs[i], sizeof(sysfs[i]), "/sys/block/loop%d/loop/backing_file", n[i]);
+	}
+
+	/* step one: the mount with the first loop mount below it goes */
+	ASSERT_EQ(rmdir("/mnt_dir/vol"), 0);
+
+	/* step two: the other one, with the loop mount whose image is on the first */
+	ASSERT_EQ(rmdir("/mnt_dir/vol2"), 0);
+
+	/* the child leaves: its namespace and every reference it held are gone */
+	ASSERT_EQ(write(to_child[1], "", 1), 1);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_EQ(status, 0);
+	close(to_parent[0]);
+	close(to_child[1]);
+
+	/* nothing can reach the four mounts any more */
+	for (int i = 0; i < 2; i++) {
+		ASSERT_FALSE(mounted_anywhere(dev[i]));
+		strcpy(self->dev, dev[i]);
+		strcpy(self->sysfs, sysfs[i]);
+		assert_loop_released(_metadata, self);
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0

