Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC51C352FA5;
	Wed, 22 Apr 2026 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900071; cv=none; b=Bz8ZwIFFZfLw+FMKjuLqmdCZGgYt454KnEZ75b8oq8c922TS1vH0l6hoc8qV2n4u8tu7ILPh80nAjpg4GeMLN8Z50U3KYzr7lZDddNx561U4or3aELk1VHqgPvXHHUTtUrsL9PYf1/PHdsG+AZ4WIZk4hekjnD1K5I1fEq0q4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900071; c=relaxed/simple;
	bh=Jhk+8s+9k3RV3crJ3E84tGyuPUcwxaQ6G1sKdTgN5C8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMue+G0tKZM8A+wyV3ooFD3w3I4XTYy2OqTY1Iio3C1Q6y2uH3Ua5m/wN1OHqBtFR7iZHZBFFo5AWewi+fYFLMDEXhGMH6wKsKCvmf2KCyzci/HXSfXHFGfSRM4cMVarAb0IkZMqfPeHO9SmaXG9B+IdFxE9LgnFjqv9i8lpKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsdV+pFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsdV+pFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB96C19425;
	Wed, 22 Apr 2026 23:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900071;
	bh=Jhk+8s+9k3RV3crJ3E84tGyuPUcwxaQ6G1sKdTgN5C8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WsdV+pFosRTqHcBWGc/qyoovcPjmrU/MWfHkCVFD90XUqal4vM8rTIiCWtCIEty6B
	 EsB54tG1BoPDFMQf/1e7YxLCnybNPachAO3ehaUWUBbYYOuUHdqo8wXFk2LqrxFUKt
	 irC9sihxBuoyptmjIDT11Reifqihfhnz1rDzxG52JILj8v2BNn0qdlR0j6LXtwQn6l
	 qvnPOzukV9YxRYFL3j9v8Bf871hoje81p0Goq1V4g5JGBHd3p39IR5oPiaw14RLEJC
	 4RpHDoOQJgv+k2dvCoBswcGBmKVXYuPjUykUPKgaiqOPT4lpYR38iMZ162PKW6qYmr
	 MKUitlLiwjchQ==
Date: Wed, 22 Apr 2026 16:21:10 -0700
Subject: [PATCH 07/13] util: fix checkpatch complaints in fuser_conf.[ch]
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
 miklos@szeredi.hu, fuse-devel@lists.linux.dev
Message-ID: <177689988666.3820166.5332962202376294528.stgit@frogsfrogsfrogs>
In-Reply-To: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
References: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Fix the checkpatch complaints because we touched some code.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/fuser_conf.h |    3 ++-
 util/fuser_conf.c |   51 +++++++++++++++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 19 deletions(-)


diff --git a/util/fuser_conf.h b/util/fuser_conf.h
index 5afe70709c5152..55ed745c964ed8 100644
--- a/util/fuser_conf.h
+++ b/util/fuser_conf.h
@@ -23,7 +23,8 @@ void unescape(char *buf);
 static inline struct mntent *GETMNTENT(FILE *stream)
 {
 	struct mntent *entp = getmntent(stream);
-	if(entp != NULL) {
+
+	if (entp != NULL) {
 		unescape(entp->mnt_fsname);
 		unescape(entp->mnt_dir);
 		unescape(entp->mnt_type);
diff --git a/util/fuser_conf.c b/util/fuser_conf.c
index dd60afaad31a0f..7efdd8c7023f91 100644
--- a/util/fuser_conf.c
+++ b/util/fuser_conf.c
@@ -28,7 +28,7 @@
 #include <stdint.h>
 #endif
 
-int user_allow_other = 0;
+int user_allow_other;
 int mount_max = 1000;
 static uid_t oldfsuid;
 static gid_t oldfsgid;
@@ -41,25 +41,27 @@ void unescape(char *buf)
 {
 	char *src = buf;
 	char *dest = buf;
+
 	while (1) {
 		char *next_src = strchrnul(src, '\\');
 		int offset = next_src - src;
+
 		memmove(dest, src, offset);
 		src = next_src;
 		dest += offset;
 
-		if(*src == '\0') {
+		if (*src == '\0') {
 			*dest = *src;
 			return;
 		}
 		src++;
 
-		if('0' <= src[0] && src[0] < '2' &&
-		   '0' <= src[1] && src[1] < '8' &&
-		   '0' <= src[2] && src[2] < '8') {
+		if ('0' <= src[0] && src[0] < '2' &&
+		    '0' <= src[1] && src[1] < '8' &&
+		    '0' <= src[2] && src[2] < '8') {
 			*dest++ = (src[0] - '0') << 6
-			        | (src[1] - '0') << 3
-			        | (src[2] - '0') << 0;
+				| (src[1] - '0') << 3
+				| (src[2] - '0') << 0;
 			src += 3;
 		} else if (src[0] == '\\') {
 			*dest++ = '\\';
@@ -77,6 +79,7 @@ static int count_fuse_fs_mtab(const char *progname)
 	int count = 0;
 	const char *mtab = _PATH_MOUNTED;
 	FILE *fp = setmntent(mtab, "r");
+
 	if (fp == NULL) {
 		fprintf(stderr, "%s: failed to open %s: %s\n", progname, mtab,
 			strerror(errno));
@@ -85,7 +88,7 @@ static int count_fuse_fs_mtab(const char *progname)
 	while ((entp = GETMNTENT(fp)) != NULL) {
 		if (strcmp(entp->mnt_type, "fuse") == 0 ||
 		    strncmp(entp->mnt_type, "fuse.", 5) == 0)
-			count ++;
+			count++;
 	}
 	endmntent(fp);
 	return count;
@@ -167,12 +170,15 @@ int count_fuse_fs(const char *progname)
 static void strip_line(char *line)
 {
 	char *s = strchr(line, '#');
+
 	if (s != NULL)
 		s[0] = '\0';
 	for (s = line + strlen(line) - 1;
-	     s >= line && isspace((unsigned char) *s); s--);
+	     s >= line && isspace((unsigned char) *s); s--) {
+	}
 	s[1] = '\0';
-	for (s = line; isspace((unsigned char) *s); s++);
+	for (s = line; isspace((unsigned char) *s); s++)
+		; /* empty */
 	if (s != line)
 		memmove(line, s, strlen(s)+1);
 }
@@ -180,11 +186,12 @@ static void strip_line(char *line)
 static void parse_line(const char *line, int linenum, const char *progname)
 {
 	int tmp;
+
 	if (strcmp(line, "user_allow_other") == 0)
 		user_allow_other = 1;
 	else if (sscanf(line, "mount_max = %i", &tmp) == 1)
 		mount_max = tmp;
-	else if(line[0])
+	else if (line[0])
 		fprintf(stderr,
 			"%s: unknown parameter in %s at line %i: '%s'\n",
 			progname, FUSE_CONF, linenum, line);
@@ -193,10 +200,12 @@ static void parse_line(const char *line, int linenum, const char *progname)
 void read_conf(const char *progname)
 {
 	FILE *fp = fopen(FUSE_CONF, "r");
+
 	if (fp != NULL) {
 		int linenum = 1;
 		char line[256];
 		int isnewline = 1;
+
 		while (fgets(line, sizeof(line), fp) != NULL) {
 			if (isnewline) {
 				if (line[strlen(line)-1] == '\n') {
@@ -205,16 +214,18 @@ void read_conf(const char *progname)
 				} else {
 					isnewline = 0;
 				}
-			} else if(line[strlen(line)-1] == '\n') {
-				fprintf(stderr, "%s: reading %s: line %i too long\n", progname, FUSE_CONF, linenum);
+			} else if (line[strlen(line)-1] == '\n') {
+				fprintf(stderr, "%s: reading %s: line %i too long\n",
+					progname, FUSE_CONF, linenum);
 
 				isnewline = 1;
 			}
 			if (isnewline)
-				linenum ++;
+				linenum++;
 		}
 		if (!isnewline) {
-			fprintf(stderr, "%s: reading %s: missing newline at end of file\n", progname, FUSE_CONF);
+			fprintf(stderr, "%s: reading %s: missing newline at end of file\n",
+				progname, FUSE_CONF);
 
 		}
 		if (ferror(fp)) {
@@ -287,6 +298,8 @@ int check_nonroot_dir_access(const char *progname, const char *origmnt,
 	return 0;
 }
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
 {
 	size_t i;
@@ -296,13 +309,15 @@ int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
 	 * able to just put anything we want there.
 	 * Luckily, without allow_other, we can't get other users to actually
 	 * use any fake information we try to put there anyway.
-	 * Use a whitelist to be safe. */
+	 * Use a whitelist to be safe.
+	 */
 
 	/* Define permitted filesystems for the mount target. This was
 	 * originally the same list as used by the ecryptfs mount helper
 	 * (https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/src/utils/mount.ecryptfs_private.c#L225)
 	 * but got expanded as we found more filesystems that needed to be
-	 * overlaid. */
+	 * overlaid.
+	 */
 	typeof(fs_buf->f_type) f_type_whitelist[] = {
 		0x61756673 /* AUFS_SUPER_MAGIC */,
 		0x00000187 /* AUTOFS_SUPER_MAGIC */,
@@ -343,7 +358,7 @@ int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
 		0x2FC12FC1 /* ZFS_SUPER_MAGIC */,
 		0x858458f6 /* RAMFS_MAGIC */,
 	};
-	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(f_type_whitelist); i++) {
 		if (f_type_whitelist[i] == fs_buf->f_type)
 			return 0;
 	}

