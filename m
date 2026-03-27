Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615A30DD1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574796; cv=none; b=UPElRz+34X3JnVtZ5Wiz47YRvwZ2zqCqYn0PR5p8XnbdwjQxz+H8dhIQc9Y2O8HSUouHPQGMMsX8RBfwqXJHJLJxh4IYR1sibWon8694OQwbhCRJ1EhPn3g6GPv3AROMLqkdhqy8cZMaSQMGoQFOVqldmmctWVv1Hlg4uqNFCBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574796; c=relaxed/simple;
	bh=Et9GTvMWxN7v8HfEjeTrRgjir/BfQAj1H8XEL6WEPks=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpP6kUWiRatStyqrGrItKO6mwWvy4QsOp8KSYDQrq1I/3ZxG5GJfgUpFS12n3eg/tTletKvVYI39E/ZMOPbE46ozknFT28o1OBhb1XWL8J3v/EFcKH0yzuuJ7IpQ1gAirKDZ6Q45kJbBGdDmBUHu5jvJswBjbB46tAZjyl5Yaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klFWEQf5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klFWEQf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE77C116C6;
	Fri, 27 Mar 2026 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574796;
	bh=Et9GTvMWxN7v8HfEjeTrRgjir/BfQAj1H8XEL6WEPks=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=klFWEQf5ROAr77qsHd4W9n/zUz32/vKOsR18RBRw/rySwaHH/4u8krgIY/3uhe85w
	 zcDKDjtzoQ6FfdioKloCYUrqMBvjeuYpl1bNU+3WOB/4g7kwQ3mxLvxw5Ow7EVlcUE
	 kNZUN1ZumvaPxwqHfi7Rk8CJs6cr0WSVibspImuF8QXPDJxEAGMEKv/t/9Zp18sywZ
	 oG7W9dX8s10gbXltQWSiulmN1KXl8Sp8ABEopajghjGRcYYeNYqDToMyNUSZXIXRHc
	 Krvb5vucU10RyfF4LR+tgrfIG93U6TEIF9oBwGJFamRt+7eZjIVRc4+CPuDo450f2y
	 4IZnri8EzY56g==
Date: Thu, 26 Mar 2026 18:26:35 -0700
Subject: [PATCH 07/17] util: fix checkpatch complaints in fuser_conf.[ch]
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463240.1008428.16407586154955923908.stgit@frogsfrogsfrogs>
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

Fix the checkpatch complaints because we touched some code.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/fuser_conf.h |    3 ++-
 util/fuser_conf.c |   41 ++++++++++++++++++++++++++---------------
 2 files changed, 28 insertions(+), 16 deletions(-)


diff --git a/util/fuser_conf.h b/util/fuser_conf.h
index 1228595ca2c933..8a1bd586e13093 100644
--- a/util/fuser_conf.h
+++ b/util/fuser_conf.h
@@ -17,7 +17,8 @@ void unescape(char *buf);
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
index 9969192433ee3e..6b41bb60c63392 100644
--- a/util/fuser_conf.c
+++ b/util/fuser_conf.c
@@ -27,7 +27,7 @@
 #include <stdint.h>
 #endif
 
-int user_allow_other = 0;
+int user_allow_other;
 int mount_max = 1000;
 
 // Older versions of musl libc don't unescape entries in /etc/mtab
@@ -38,25 +38,27 @@ void unescape(char *buf)
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
@@ -74,6 +76,7 @@ static int count_fuse_fs_mtab(const char *progname)
 	int count = 0;
 	const char *mtab = _PATH_MOUNTED;
 	FILE *fp = setmntent(mtab, "r");
+
 	if (fp == NULL) {
 		fprintf(stderr, "%s: failed to open %s: %s\n", progname, mtab,
 			strerror(errno));
@@ -82,7 +85,7 @@ static int count_fuse_fs_mtab(const char *progname)
 	while ((entp = GETMNTENT(fp)) != NULL) {
 		if (strcmp(entp->mnt_type, "fuse") == 0 ||
 		    strncmp(entp->mnt_type, "fuse.", 5) == 0)
-			count ++;
+			count++;
 	}
 	endmntent(fp);
 	return count;
@@ -164,12 +167,15 @@ static int count_fuse_fs(const char *progname)
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
@@ -177,11 +183,12 @@ static void strip_line(char *line)
 static void parse_line(const char *progname, char *line, int linenum)
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
@@ -190,10 +197,12 @@ static void parse_line(const char *progname, char *line, int linenum)
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
@@ -202,16 +211,18 @@ void read_conf(const char *progname)
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

