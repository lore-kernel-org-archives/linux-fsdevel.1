Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06D2E9733
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574828; cv=none; b=HAJrvL6fAOqz0LaXsjwu/jsJeddVQOFFoOXf0veJzeybD2RiQKFCWpjTIcmAFjYFBnW+6xyY0lqAuX1UAfFkbXS0S0hsc5rgZOVGaEr0Djs6yWxz547wzFMkZndsLmWGxDQEnd2iCtKEdf8Tm9wBC4L2cvU7qq/ccxRe/Nq3Wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574828; c=relaxed/simple;
	bh=wNlxW6SpRJ2+gs6VNgC1IC/6YSB8WxThLLJYVfXOID0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6oF+xWXaS6P6K2ENRkXRGuy2bV2aMTUYiQNmNYVm4gVL/BsYeTlPlFK51lvKBRY/e3nINNcSEZfmmpGix93pc3E8HvnCWufs/aSYc2UazEeDm5vU4w/ZIoJnmcqldgoYNdVO+epVAUunVGpsNfA5ZyaPTltlQrnuhJwJ/eYD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFSHJ7BE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFSHJ7BE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A00CC116C6;
	Fri, 27 Mar 2026 01:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574827;
	bh=wNlxW6SpRJ2+gs6VNgC1IC/6YSB8WxThLLJYVfXOID0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KFSHJ7BE6/GZjZRlBIQ+XrLGs3I5FSvWFygzuHvYdZWK5fSu3claYjy4ufE9ifCIX
	 2EBWvi2OpqElxsQq3i9PvKxRj2Vssygk74CGfRRaAAljxXqo5ynv1Zho8vAzxzR3Ud
	 99X3EDpNJHtG1iez3aJZzsb7YF5ehPssRvAOh3cnJx0WXtMTCzZCcIzl0fDbQzxjon
	 TNBmcU/1RbYv1nCD9rp6L7bEQfXYYk/YBE4B25Cu35An87y8I6xyhw14xdL5W+pGDg
	 cpHpNHE9hVyVzL5X0FfhyfuJZAE4AxXDhDy+ZmwQ9Wh9qQzStseI1xXwbBkfnIUdUj
	 RIDohXTD6ow4Q==
Date: Thu, 26 Mar 2026 18:27:07 -0700
Subject: [PATCH 09/17] util: hoist the other non-root user limits
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463278.1008428.15200259489914116092.stgit@frogsfrogsfrogs>
In-Reply-To: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Hoist the rest of the security checks that occur when fusermount is
trying to start up a filesystem but is not running as root.  We'll want
that for fusermount in a moment.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/fuser_conf.h |   13 ++++++
 util/fuser_conf.c |  123 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 util/fusermount.c |  101 ++------------------------------------------
 3 files changed, 140 insertions(+), 97 deletions(-)


diff --git a/util/fuser_conf.h b/util/fuser_conf.h
index 8a1bd586e13093..0bf6f98ee49c32 100644
--- a/util/fuser_conf.h
+++ b/util/fuser_conf.h
@@ -8,6 +8,9 @@
 #ifndef FUSER_CONF_H_
 #define FUSER_CONF_H_
 
+#include <sys/vfs.h>
+#include <sys/stat.h>
+
 extern int user_allow_other;
 extern int mount_max;
 
@@ -34,4 +37,14 @@ int count_fuse_fs(const char *progname);
 
 void read_conf(const char *progname);
 
+void drop_privs(void);
+void restore_privs(void);
+
+int check_nonroot_mount_count(const char *progname);
+
+int check_nonroot_dir_access(const char *progname, const char *origmnt,
+			     const char *mnt, const struct stat *stbuf);
+
+int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf);
+
 #endif /* FUSER_CONF_H_ */
diff --git a/util/fuser_conf.c b/util/fuser_conf.c
index 6b41bb60c63392..7d239a48671b5b 100644
--- a/util/fuser_conf.c
+++ b/util/fuser_conf.c
@@ -20,6 +20,7 @@
 #include <errno.h>
 #include <mntent.h>
 #include <unistd.h>
+#include <sys/fsuid.h>
 
 #if defined HAVE_LISTMOUNT
 #include <linux/mount.h>
@@ -29,6 +30,8 @@
 
 int user_allow_other;
 int mount_max = 1000;
+static uid_t oldfsuid;
+static gid_t oldfsgid;
 
 // Older versions of musl libc don't unescape entries in /etc/mtab
 
@@ -240,3 +243,123 @@ void read_conf(const char *progname)
 			exit(1);
 	}
 }
+
+void drop_privs(void)
+{
+	if (getuid() != 0) {
+		oldfsuid = setfsuid(getuid());
+		oldfsgid = setfsgid(getgid());
+	}
+}
+
+void restore_privs(void)
+{
+	if (getuid() != 0) {
+		setfsuid(oldfsuid);
+		setfsgid(oldfsgid);
+	}
+}
+
+int check_nonroot_mount_count(const char *progname)
+{
+	if (mount_max == -1)
+		return 0;
+
+	int mount_count = count_fuse_fs(progname);
+
+	if (mount_count >= mount_max) {
+		fprintf(stderr,
+"%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n",
+			progname, FUSE_CONF);
+		return -1;
+	}
+
+	return 0;
+}
+
+int check_nonroot_dir_access(const char *progname, const char *origmnt,
+			     const char *mnt, const struct stat *stbuf)
+{
+	int res;
+
+	if ((stbuf->st_mode & S_ISVTX) && stbuf->st_uid != getuid()) {
+		fprintf(stderr, "%s: mountpoint %s not owned by user\n",
+			progname, origmnt);
+		return -1;
+	}
+
+	res = access(mnt, W_OK);
+	if (res == -1) {
+		fprintf(stderr, "%s: user has no write access to mountpoint %s\n",
+			progname, origmnt);
+		return -1;
+	}
+
+	return 0;
+}
+
+int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
+{
+	size_t i;
+
+	/* Do not permit mounting over anything in procfs - it has a couple
+	 * places to which we have "write access" without being supposed to be
+	 * able to just put anything we want there.
+	 * Luckily, without allow_other, we can't get other users to actually
+	 * use any fake information we try to put there anyway.
+	 * Use a whitelist to be safe. */
+
+	/* Define permitted filesystems for the mount target. This was
+	 * originally the same list as used by the ecryptfs mount helper
+	 * (https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/src/utils/mount.ecryptfs_private.c#L225)
+	 * but got expanded as we found more filesystems that needed to be
+	 * overlaid. */
+	typeof(fs_buf->f_type) f_type_whitelist[] = {
+		0x61756673 /* AUFS_SUPER_MAGIC */,
+		0x00000187 /* AUTOFS_SUPER_MAGIC */,
+		0xCA451A4E /* BCACHEFS_STATFS_MAGIC */,
+		0x9123683E /* BTRFS_SUPER_MAGIC */,
+		0x00C36400 /* CEPH_SUPER_MAGIC */,
+		0xFF534D42 /* CIFS_MAGIC_NUMBER */,
+		0x0000F15F /* ECRYPTFS_SUPER_MAGIC */,
+		0X2011BAB0 /* EXFAT_SUPER_MAGIC */,
+		0x0000EF53 /* EXT[234]_SUPER_MAGIC */,
+		0xF2F52010 /* F2FS_SUPER_MAGIC */,
+		0x65735546 /* FUSE_SUPER_MAGIC */,
+		0x01161970 /* GFS2_MAGIC */,
+		0x47504653 /* GPFS_SUPER_MAGIC */,
+		0x0000482b /* HFSPLUS_SUPER_MAGIC */,
+		0x000072B6 /* JFFS2_SUPER_MAGIC */,
+		0x3153464A /* JFS_SUPER_MAGIC */,
+		0x0BD00BD0 /* LL_SUPER_MAGIC */,
+		0X00004D44 /* MSDOS_SUPER_MAGIC */,
+		0x0000564C /* NCP_SUPER_MAGIC */,
+		0x00006969 /* NFS_SUPER_MAGIC */,
+		0x00003434 /* NILFS_SUPER_MAGIC */,
+		0x5346544E /* NTFS_SB_MAGIC */,
+		0x7366746E /* NTFS3_SUPER_MAGIC */,
+		0x5346414f /* OPENAFS_SUPER_MAGIC */,
+		0x794C7630 /* OVERLAYFS_SUPER_MAGIC */,
+		0xAAD7AAEA /* PANFS_SUPER_MAGIC */,
+		0x52654973 /* REISERFS_SUPER_MAGIC */,
+		0xFE534D42 /* SMB2_SUPER_MAGIC */,
+		0x73717368 /* SQUASHFS_MAGIC */,
+		0x01021994 /* TMPFS_MAGIC */,
+		0x24051905 /* UBIFS_SUPER_MAGIC */,
+		0x18031977 /* WEKAFS_SUPER_MAGIC */,
+#if __SIZEOF_LONG__ > 4
+		0x736675005346544e /* UFSD */,
+#endif
+		0x58465342 /* XFS_SB_MAGIC */,
+		0x2FC12FC1 /* ZFS_SUPER_MAGIC */,
+		0x858458f6 /* RAMFS_MAGIC */,
+	};
+	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {
+		if (f_type_whitelist[i] == fs_buf->f_type)
+			return 0;
+	}
+
+	fprintf(stderr, "%s: mounting over filesystem type %#010lx is forbidden\n",
+		progname, (unsigned long)fs_buf->f_type);
+	return -1;
+}
diff --git a/util/fusermount.c b/util/fusermount.c
index 3386ba4791cefd..54bd297e0ca6a9 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -134,25 +134,6 @@ static const char *get_user_name(void)
 	}
 }
 
-static uid_t oldfsuid;
-static gid_t oldfsgid;
-
-static void drop_privs(void)
-{
-	if (getuid() != 0) {
-		oldfsuid = setfsuid(getuid());
-		oldfsgid = setfsgid(getgid());
-	}
-}
-
-static void restore_privs(void)
-{
-	if (getuid() != 0) {
-		setfsuid(oldfsuid);
-		setfsgid(oldfsgid);
-	}
-}
-
 #ifndef IGNORE_MTAB
 /*
  * Make sure that /etc/mtab is checked and updated atomically
@@ -879,7 +860,6 @@ static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
 	const char *mnt = *mntp;
 	const char *origmnt = mnt;
 	struct statfs fs_buf;
-	size_t i;
 
 	res = lstat(mnt, stbuf);
 	if (res == -1) {
@@ -909,18 +889,8 @@ static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
 			return -1;
 		}
 
-		if ((stbuf->st_mode & S_ISVTX) && stbuf->st_uid != getuid()) {
-			fprintf(stderr, "%s: mountpoint %s not owned by user\n",
-				progname, origmnt);
+		if (!check_nonroot_dir_access(progname, origmnt, mnt, stbuf))
 			return -1;
-		}
-
-		res = access(mnt, W_OK);
-		if (res == -1) {
-			fprintf(stderr, "%s: user has no write access to mountpoint %s\n",
-				progname, origmnt);
-			return -1;
-		}
 	} else if (S_ISREG(stbuf->st_mode)) {
 		static char procfile[256];
 		*mountpoint_fd = open(mnt, O_WRONLY);
@@ -952,71 +922,13 @@ static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
 		return -1;
 	}
 
-	/* Do not permit mounting over anything in procfs - it has a couple
-	 * places to which we have "write access" without being supposed to be
-	 * able to just put anything we want there.
-	 * Luckily, without allow_other, we can't get other users to actually
-	 * use any fake information we try to put there anyway.
-	 * Use a whitelist to be safe. */
 	if (statfs(*mntp, &fs_buf)) {
 		fprintf(stderr, "%s: failed to access mountpoint %s: %s\n",
 			progname, mnt, strerror(errno));
 		return -1;
 	}
 
-	/* Define permitted filesystems for the mount target. This was
-	 * originally the same list as used by the ecryptfs mount helper
-	 * (https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/src/utils/mount.ecryptfs_private.c#L225)
-	 * but got expanded as we found more filesystems that needed to be
-	 * overlaid. */
-	typeof(fs_buf.f_type) f_type_whitelist[] = {
-		0x61756673 /* AUFS_SUPER_MAGIC */,
-		0x00000187 /* AUTOFS_SUPER_MAGIC */,
-		0xCA451A4E /* BCACHEFS_STATFS_MAGIC */,
-		0x9123683E /* BTRFS_SUPER_MAGIC */,
-		0x00C36400 /* CEPH_SUPER_MAGIC */,
-		0xFF534D42 /* CIFS_MAGIC_NUMBER */,
-		0x0000F15F /* ECRYPTFS_SUPER_MAGIC */,
-		0X2011BAB0 /* EXFAT_SUPER_MAGIC */,
-		0x0000EF53 /* EXT[234]_SUPER_MAGIC */,
-		0xF2F52010 /* F2FS_SUPER_MAGIC */,
-		0x65735546 /* FUSE_SUPER_MAGIC */,
-		0x01161970 /* GFS2_MAGIC */,
-		0x47504653 /* GPFS_SUPER_MAGIC */,
-		0x0000482b /* HFSPLUS_SUPER_MAGIC */,
-		0x000072B6 /* JFFS2_SUPER_MAGIC */,
-		0x3153464A /* JFS_SUPER_MAGIC */,
-		0x0BD00BD0 /* LL_SUPER_MAGIC */,
-		0X00004D44 /* MSDOS_SUPER_MAGIC */,
-		0x0000564C /* NCP_SUPER_MAGIC */,
-		0x00006969 /* NFS_SUPER_MAGIC */,
-		0x00003434 /* NILFS_SUPER_MAGIC */,
-		0x5346544E /* NTFS_SB_MAGIC */,
-		0x7366746E /* NTFS3_SUPER_MAGIC */,
-		0x5346414f /* OPENAFS_SUPER_MAGIC */,
-		0x794C7630 /* OVERLAYFS_SUPER_MAGIC */,
-		0xAAD7AAEA /* PANFS_SUPER_MAGIC */,
-		0x52654973 /* REISERFS_SUPER_MAGIC */,
-		0xFE534D42 /* SMB2_SUPER_MAGIC */,
-		0x73717368 /* SQUASHFS_MAGIC */,
-		0x01021994 /* TMPFS_MAGIC */,
-		0x24051905 /* UBIFS_SUPER_MAGIC */,
-		0x18031977 /* WEKAFS_SUPER_MAGIC */,
-#if __SIZEOF_LONG__ > 4
-		0x736675005346544e /* UFSD */,
-#endif
-		0x58465342 /* XFS_SB_MAGIC */,
-		0x2FC12FC1 /* ZFS_SUPER_MAGIC */,
-		0x858458f6 /* RAMFS_MAGIC */,
-	};
-	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {
-		if (f_type_whitelist[i] == fs_buf.f_type)
-			return 0;
-	}
-
-	fprintf(stderr, "%s: mounting over filesystem type %#010lx is forbidden\n",
-		progname, (unsigned long)fs_buf.f_type);
-	return -1;
+	return check_nonroot_fstype(progname, &fs_buf);
 }
 
 static int open_fuse_device(const char *dev)
@@ -1058,13 +970,8 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 	drop_privs();
 	read_conf(progname);
 
-	if (getuid() != 0 && mount_max != -1) {
-		int mount_count = count_fuse_fs(progname);
-		if (mount_count >= mount_max) {
-			fprintf(stderr, "%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n", progname, FUSE_CONF);
-			goto fail_close_fd;
-		}
-	}
+	if (getuid() != 0 && check_nonroot_mount_count(progname) != 0)
+		goto fail_close_fd;
 
 	// Extract any options starting with "x-"
 	res= extract_x_options(opts, &do_mount_opts, &x_opts);

