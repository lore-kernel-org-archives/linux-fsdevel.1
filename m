Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21023304976
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574781; cv=none; b=f5uhiayqLN0LSgWM5unDsMjzo/3Ns04SZUIkntr4lZuO59CEfPYXy5Gpx1KxggjmAf8KLFhhYsR3/QY3+QYR1A2mWNH8PG3f4E6IlSanMSxDyQMfDnJ8o/W2y9ce7StHH7JoK/t6h7C65uijMQLElzS2Zfn3RS1yTyHHDUoywis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574781; c=relaxed/simple;
	bh=W0eB/ZHGu935lAWrtDyXLaEpqty4SCqZC+9xjWJwPdg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7iFGobJoMppLkbWyXew5lTS3IS7tQY20j1fnRV2o1uRB1Ofv2yTSbLiBhvRI6Yhuku+cZgen/i3onWkBbpEd/GA08WG7wGm/f1nctGh1E6C6J8hGhYgRP0lG2A6jeQHpASTfoLfJd5/SxoJ/fXnmSq9TeEFQqhhE86Juqt9DaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPjB/wpx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPjB/wpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20F6C116C6;
	Fri, 27 Mar 2026 01:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574780;
	bh=W0eB/ZHGu935lAWrtDyXLaEpqty4SCqZC+9xjWJwPdg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TPjB/wpxCi1BUKihLTyMMxQmg7GNcxV71UhaegMM7mEnK0H0F2V0gdo4I0mk2NFLl
	 rKq9LS6Ggmp82+av90GV9tcIbIiYeofysBx2pP8tmQWyEn8w5o/Wh94X6DtLU8gBTp
	 md+MpcC8MNG9p5CWBUxK82tv/GnjolIKIRCBivgllBQm17dGrKxt9bcp0UpBmXFZOB
	 RvV8malP80T749ZHsqGi9ifj8pBsX7Fdue2pVoVMIVGGvbhIw4SYzoV1CtiADm1EWx
	 +6COgWCJLxe9U77ZpKC42v1vZbFRlJs3kDm8/CxcdAJHWRAJoBFtp06Ki32EIx6b6o
	 2qD3aA2l3sVHg==
Date: Thu, 26 Mar 2026 18:26:20 -0700
Subject: [PATCH 06/17] util: hoist the fuse.conf parsing code
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463223.1008428.12285787116252115387.stgit@frogsfrogsfrogs>
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

Move all the code that parses fuse.conf into a separate file in util/ so
that fuservicemount can read the same file.  We'll add the limit
enforcement in separate patches.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/fuser_conf.h |   36 ++++++++
 util/fuser_conf.c |  231 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 util/fusermount.c |  221 +--------------------------------------------------
 util/meson.build  |    6 +
 4 files changed, 273 insertions(+), 221 deletions(-)
 create mode 100644 util/fuser_conf.h
 create mode 100644 util/fuser_conf.c


diff --git a/util/fuser_conf.h b/util/fuser_conf.h
new file mode 100644
index 00000000000000..1228595ca2c933
--- /dev/null
+++ b/util/fuser_conf.h
@@ -0,0 +1,36 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file LGPL2.txt.
+ */
+#ifndef FUSER_CONF_H_
+#define FUSER_CONF_H_
+
+extern int user_allow_other;
+extern int mount_max;
+
+void unescape(char *buf);
+
+#ifdef GETMNTENT_NEEDS_UNESCAPING
+static inline struct mntent *GETMNTENT(FILE *stream)
+{
+	struct mntent *entp = getmntent(stream);
+	if(entp != NULL) {
+		unescape(entp->mnt_fsname);
+		unescape(entp->mnt_dir);
+		unescape(entp->mnt_type);
+		unescape(entp->mnt_opts);
+	}
+	return entp;
+}
+#else
+#define GETMNTENT getmntent
+#endif // GETMNTENT_NEEDS_UNESCAPING
+
+int count_fuse_fs(const char *progname);
+
+void read_conf(const char *progname);
+
+#endif /* FUSER_CONF_H_ */
diff --git a/util/fuser_conf.c b/util/fuser_conf.c
new file mode 100644
index 00000000000000..9969192433ee3e
--- /dev/null
+++ b/util/fuser_conf.c
@@ -0,0 +1,231 @@
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * This program can be distributed under the terms of the GNU GPLv2.
+ * See the file GPL2.txt.
+ */
+/* This program parses fuse.conf */
+#define _GNU_SOURCE
+#include "fuse_config.h"
+#include "mount_util.h"
+#include "util.h"
+#include "fuser_conf.h"
+
+#include <string.h>
+#include <stddef.h>
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <mntent.h>
+#include <unistd.h>
+
+#if defined HAVE_LISTMOUNT
+#include <linux/mount.h>
+#include <syscall.h>
+#include <stdint.h>
+#endif
+
+int user_allow_other = 0;
+int mount_max = 1000;
+
+// Older versions of musl libc don't unescape entries in /etc/mtab
+
+// unescapes octal sequences like \040 in-place
+// That's ok, because unescaping can not extend the length of the string.
+void unescape(char *buf)
+{
+	char *src = buf;
+	char *dest = buf;
+	while (1) {
+		char *next_src = strchrnul(src, '\\');
+		int offset = next_src - src;
+		memmove(dest, src, offset);
+		src = next_src;
+		dest += offset;
+
+		if(*src == '\0') {
+			*dest = *src;
+			return;
+		}
+		src++;
+
+		if('0' <= src[0] && src[0] < '2' &&
+		   '0' <= src[1] && src[1] < '8' &&
+		   '0' <= src[2] && src[2] < '8') {
+			*dest++ = (src[0] - '0') << 6
+			        | (src[1] - '0') << 3
+			        | (src[2] - '0') << 0;
+			src += 3;
+		} else if (src[0] == '\\') {
+			*dest++ = '\\';
+			src += 1;
+		} else {
+			*dest++ = '\\';
+		}
+	}
+}
+
+#ifndef IGNORE_MTAB
+static int count_fuse_fs_mtab(const char *progname)
+{
+	struct mntent *entp;
+	int count = 0;
+	const char *mtab = _PATH_MOUNTED;
+	FILE *fp = setmntent(mtab, "r");
+	if (fp == NULL) {
+		fprintf(stderr, "%s: failed to open %s: %s\n", progname, mtab,
+			strerror(errno));
+		return -1;
+	}
+	while ((entp = GETMNTENT(fp)) != NULL) {
+		if (strcmp(entp->mnt_type, "fuse") == 0 ||
+		    strncmp(entp->mnt_type, "fuse.", 5) == 0)
+			count ++;
+	}
+	endmntent(fp);
+	return count;
+}
+
+#ifdef HAVE_LISTMOUNT
+static int count_fuse_fs_ls_mnt(const char *progname)
+{
+	#define SMBUF_SIZE 1024
+	#define MNT_ID_LEN 128
+
+	int fuse_count = 0;
+	int n_mounts = 0;
+	int ret = 0;
+	uint64_t mnt_ids[MNT_ID_LEN];
+	unsigned char smbuf[SMBUF_SIZE];
+	struct mnt_id_req req = {
+		.size = sizeof(struct mnt_id_req),
+	};
+	struct statmount *sm;
+
+	for (;;) {
+		req.mnt_id = LSMT_ROOT;
+
+		n_mounts = syscall(SYS_listmount, &req, &mnt_ids, MNT_ID_LEN, 0);
+		if (n_mounts == -1) {
+			if (errno != ENOSYS) {
+				fprintf(stderr, "%s: failed to list mounts: %s\n", progname,
+					strerror(errno));
+			}
+			return -1;
+		}
+
+		for (int i = 0; i < n_mounts; i++) {
+			req.mnt_id = mnt_ids[i];
+			req.param = STATMOUNT_FS_TYPE;
+			ret = syscall(SYS_statmount, &req, &smbuf, SMBUF_SIZE, 0);
+			if (ret) {
+				if (errno == ENOENT)
+					continue;
+
+				fprintf(stderr, "%s: failed to stat mount %lld: %s\n", progname,
+					req.mnt_id, strerror(errno));
+				return -1;
+			}
+
+			sm = (struct statmount *)smbuf;
+			if (sm->mask & STATMOUNT_FS_TYPE &&
+			    strcmp(&sm->str[sm->fs_type], "fuse") == 0)
+				fuse_count++;
+		}
+
+		if (n_mounts < MNT_ID_LEN)
+			break;
+		req.param = mnt_ids[MNT_ID_LEN - 1];
+	}
+	return fuse_count;
+}
+
+int count_fuse_fs(const char *progname)
+{
+	int count = count_fuse_fs_ls_mnt(progname);
+
+	return count >= 0 ? count : count_fuse_fs_mtab(progname);
+}
+#else
+int count_fuse_fs(const char *progname)
+{
+	return count_fuse_fs_mtab(progname);
+}
+#endif /* HAVE_LISTMOUNT */
+#else
+static int count_fuse_fs(const char *progname)
+{
+	return 0;
+}
+#endif /* IGNORE_MTAB */
+
+static void strip_line(char *line)
+{
+	char *s = strchr(line, '#');
+	if (s != NULL)
+		s[0] = '\0';
+	for (s = line + strlen(line) - 1;
+	     s >= line && isspace((unsigned char) *s); s--);
+	s[1] = '\0';
+	for (s = line; isspace((unsigned char) *s); s++);
+	if (s != line)
+		memmove(line, s, strlen(s)+1);
+}
+
+static void parse_line(const char *progname, char *line, int linenum)
+{
+	int tmp;
+	if (strcmp(line, "user_allow_other") == 0)
+		user_allow_other = 1;
+	else if (sscanf(line, "mount_max = %i", &tmp) == 1)
+		mount_max = tmp;
+	else if(line[0])
+		fprintf(stderr,
+			"%s: unknown parameter in %s at line %i: '%s'\n",
+			progname, FUSE_CONF, linenum, line);
+}
+
+void read_conf(const char *progname)
+{
+	FILE *fp = fopen(FUSE_CONF, "r");
+	if (fp != NULL) {
+		int linenum = 1;
+		char line[256];
+		int isnewline = 1;
+		while (fgets(line, sizeof(line), fp) != NULL) {
+			if (isnewline) {
+				if (line[strlen(line)-1] == '\n') {
+					strip_line(line);
+					parse_line(progname, line, linenum);
+				} else {
+					isnewline = 0;
+				}
+			} else if(line[strlen(line)-1] == '\n') {
+				fprintf(stderr, "%s: reading %s: line %i too long\n", progname, FUSE_CONF, linenum);
+
+				isnewline = 1;
+			}
+			if (isnewline)
+				linenum ++;
+		}
+		if (!isnewline) {
+			fprintf(stderr, "%s: reading %s: missing newline at end of file\n", progname, FUSE_CONF);
+
+		}
+		if (ferror(fp)) {
+			fprintf(stderr, "%s: reading %s: read failed\n", progname, FUSE_CONF);
+			exit(1);
+		}
+		fclose(fp);
+	} else if (errno != ENOENT) {
+		bool fatal = (errno != EACCES && errno != ELOOP &&
+			      errno != ENAMETOOLONG && errno != ENOTDIR &&
+			      errno != EOVERFLOW);
+		fprintf(stderr, "%s: failed to open %s: %s\n",
+			progname, FUSE_CONF, strerror(errno));
+		if (fatal)
+			exit(1);
+	}
+}
diff --git a/util/fusermount.c b/util/fusermount.c
index 6e66bf07300d6d..3386ba4791cefd 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -11,6 +11,7 @@
 #include "fuse_config.h"
 #include "mount_util.h"
 #include "util.h"
+#include "fuser_conf.h"
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -50,63 +51,8 @@
 
 static const char *progname;
 
-static int user_allow_other = 0;
-static int mount_max = 1000;
-
 static int auto_unmount = 0;
 
-#ifdef GETMNTENT_NEEDS_UNESCAPING
-// Older versions of musl libc don't unescape entries in /etc/mtab
-
-// unescapes octal sequences like \040 in-place
-// That's ok, because unescaping can not extend the length of the string.
-static void unescape(char *buf) {
-	char *src = buf;
-	char *dest = buf;
-	while (1) {
-		char *next_src = strchrnul(src, '\\');
-		int offset = next_src - src;
-		memmove(dest, src, offset);
-		src = next_src;
-		dest += offset;
-
-		if(*src == '\0') {
-			*dest = *src;
-			return;
-		}
-		src++;
-
-		if('0' <= src[0] && src[0] < '2' &&
-		   '0' <= src[1] && src[1] < '8' &&
-		   '0' <= src[2] && src[2] < '8') {
-			*dest++ = (src[0] - '0') << 6
-			        | (src[1] - '0') << 3
-			        | (src[2] - '0') << 0;
-			src += 3;
-		} else if (src[0] == '\\') {
-			*dest++ = '\\';
-			src += 1;
-		} else {
-			*dest++ = '\\';
-		}
-	}
-}
-
-static struct mntent *GETMNTENT(FILE *stream)
-{
-	struct mntent *entp = getmntent(stream);
-	if(entp != NULL) {
-		unescape(entp->mnt_fsname);
-		unescape(entp->mnt_dir);
-		unescape(entp->mnt_type);
-		unescape(entp->mnt_opts);
-	}
-	return entp;
-}
-#else
-#define GETMNTENT getmntent
-#endif // GETMNTENT_NEEDS_UNESCAPING
-
 /*
  * Take a ',' separated option string and extract "x-" options
  */
@@ -569,99 +515,7 @@ static int unmount_fuse(const char *mnt, int quiet, int lazy)
 	return res;
 }
 
-static int count_fuse_fs_mtab(void)
-{
-	struct mntent *entp;
-	int count = 0;
-	const char *mtab = _PATH_MOUNTED;
-	FILE *fp = setmntent(mtab, "r");
-	if (fp == NULL) {
-		fprintf(stderr, "%s: failed to open %s: %s\n", progname, mtab,
-			strerror(errno));
-		return -1;
-	}
-	while ((entp = GETMNTENT(fp)) != NULL) {
-		if (strcmp(entp->mnt_type, "fuse") == 0 ||
-		    strncmp(entp->mnt_type, "fuse.", 5) == 0)
-			count ++;
-	}
-	endmntent(fp);
-	return count;
-}
-
-#ifdef HAVE_LISTMOUNT
-static int count_fuse_fs_ls_mnt(void)
-{
-	#define SMBUF_SIZE 1024
-	#define MNT_ID_LEN 128
-
-	int fuse_count = 0;
-	int n_mounts = 0;
-	int ret = 0;
-	uint64_t mnt_ids[MNT_ID_LEN];
-	unsigned char smbuf[SMBUF_SIZE];
-	struct mnt_id_req req = {
-		.size = sizeof(struct mnt_id_req),
-	};
-	struct statmount *sm;
-
-	for (;;) {
-		req.mnt_id = LSMT_ROOT;
-
-		n_mounts = syscall(SYS_listmount, &req, &mnt_ids, MNT_ID_LEN, 0);
-		if (n_mounts == -1) {
-			if (errno != ENOSYS) {
-				fprintf(stderr, "%s: failed to list mounts: %s\n", progname,
-					strerror(errno));
-			}
-			return -1;
-		}
-
-		for (int i = 0; i < n_mounts; i++) {
-			req.mnt_id = mnt_ids[i];
-			req.param = STATMOUNT_FS_TYPE;
-			ret = syscall(SYS_statmount, &req, &smbuf, SMBUF_SIZE, 0);
-			if (ret) {
-				if (errno == ENOENT)
-					continue;
-
-				fprintf(stderr, "%s: failed to stat mount %lld: %s\n", progname,
-					req.mnt_id, strerror(errno));
-				return -1;
-			}
-
-			sm = (struct statmount *)smbuf;
-			if (sm->mask & STATMOUNT_FS_TYPE &&
-			    strcmp(&sm->str[sm->fs_type], "fuse") == 0)
-				fuse_count++;
-		}
-
-		if (n_mounts < MNT_ID_LEN)
-			break;
-		req.param = mnt_ids[MNT_ID_LEN - 1];
-	}
-	return fuse_count;
-}
-
-static int count_fuse_fs(void)
-{
-	int count = count_fuse_fs_ls_mnt();
-
-	return count >= 0 ? count : count_fuse_fs_mtab();
-}
-#else
-static int count_fuse_fs(void)
-{
-	return count_fuse_fs_mtab();
-}
-#endif
-
 #else /* IGNORE_MTAB */
-static int count_fuse_fs(void)
-{
-	return 0;
-}
-
 static int add_mount(const char *source, const char *mnt, const char *type,
 		     const char *opts)
 {
@@ -679,75 +533,6 @@ static int unmount_fuse(const char *mnt, int quiet, int lazy)
 }
 #endif /* IGNORE_MTAB */
 
-static void strip_line(char *line)
-{
-	char *s = strchr(line, '#');
-	if (s != NULL)
-		s[0] = '\0';
-	for (s = line + strlen(line) - 1;
-	     s >= line && isspace((unsigned char) *s); s--);
-	s[1] = '\0';
-	for (s = line; isspace((unsigned char) *s); s++);
-	if (s != line)
-		memmove(line, s, strlen(s)+1);
-}
-
-static void parse_line(char *line, int linenum)
-{
-	int tmp;
-	if (strcmp(line, "user_allow_other") == 0)
-		user_allow_other = 1;
-	else if (sscanf(line, "mount_max = %i", &tmp) == 1)
-		mount_max = tmp;
-	else if(line[0])
-		fprintf(stderr,
-			"%s: unknown parameter in %s at line %i: '%s'\n",
-			progname, FUSE_CONF, linenum, line);
-}
-
-static void read_conf(void)
-{
-	FILE *fp = fopen(FUSE_CONF, "r");
-	if (fp != NULL) {
-		int linenum = 1;
-		char line[256];
-		int isnewline = 1;
-		while (fgets(line, sizeof(line), fp) != NULL) {
-			if (isnewline) {
-				if (line[strlen(line)-1] == '\n') {
-					strip_line(line);
-					parse_line(line, linenum);
-				} else {
-					isnewline = 0;
-				}
-			} else if(line[strlen(line)-1] == '\n') {
-				fprintf(stderr, "%s: reading %s: line %i too long\n", progname, FUSE_CONF, linenum);
-
-				isnewline = 1;
-			}
-			if (isnewline)
-				linenum ++;
-		}
-		if (!isnewline) {
-			fprintf(stderr, "%s: reading %s: missing newline at end of file\n", progname, FUSE_CONF);
-
-		}
-		if (ferror(fp)) {
-			fprintf(stderr, "%s: reading %s: read failed\n", progname, FUSE_CONF);
-			exit(1);
-		}
-		fclose(fp);
-	} else if (errno != ENOENT) {
-		bool fatal = (errno != EACCES && errno != ELOOP &&
-			      errno != ENAMETOOLONG && errno != ENOTDIR &&
-			      errno != EOVERFLOW);
-		fprintf(stderr, "%s: failed to open %s: %s\n",
-			progname, FUSE_CONF, strerror(errno));
-		if (fatal)
-			exit(1);
-	}
-}
-
 static int begins_with(const char *s, const char *beg)
 {
 	if (strncmp(s, beg, strlen(beg)) == 0)
@@ -1271,10 +1056,10 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
 		return -1;
 
 	drop_privs();
-	read_conf();
+	read_conf(progname);
 
 	if (getuid() != 0 && mount_max != -1) {
-		int mount_count = count_fuse_fs();
+		int mount_count = count_fuse_fs(progname);
 		if (mount_count >= mount_max) {
 			fprintf(stderr, "%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n", progname, FUSE_CONF);
 			goto fail_close_fd;
diff --git a/util/meson.build b/util/meson.build
index 403fc68ef67ae8..47c5f8ac213675 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -1,18 +1,18 @@
 fuseconf_path = join_paths(get_option('prefix'), get_option('sysconfdir'), 'fuse.conf')
 
-executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c'],
+executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c', 'fuser_conf.c'],
            include_directories: include_dirs,
            install: true,
            install_dir: get_option('bindir'),
            c_args: '-DFUSE_CONF="@0@"'.format(fuseconf_path))
 
 if private_cfg.get('HAVE_SERVICEMOUNT', false)
-  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c'],
+  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c', 'fuser_conf.c'],
              include_directories: include_dirs,
              link_with: [ libfuse ],
              install: true,
              install_dir: get_option('sbindir'),
-             c_args: '-DFUSE_USE_VERSION=317')
+             c_args: ['-DFUSE_USE_VERSION=317', '-DFUSE_CONF="@0@"'.format(fuseconf_path)])
 endif
 
 executable('mount.fuse3', ['mount.fuse.c'],

