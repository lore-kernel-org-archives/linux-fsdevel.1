Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7A35CB73
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705018; cv=none; b=LBl/oy4fnzI+2PpsYcN3VB0Bl8J5RMxk+vFW5BuqWiSLjYdbUOURa2MZIXquEOEGjbBgXg7r8xGJeDycYhEqyuT6lsmRUdTsLqcxp6uLIMjaagIyHTNYPLO+imw0HiK/QqaMXfGuJqZbWE5RSSYDVwYWNQmOQHljnKSoGq0EvrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705018; c=relaxed/simple;
	bh=MIlbvjEO+Z8DdolqF1kyDEGWmEwrPm6BtluQqi2zedY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PGhBhjPJiqA/NK2VhC8JL/FURcehIlu3cZKi7u2pzxlt2Vx3qkd/WEarEy8TJIIXQPpQ4RvBGj5wIcot8ZCwxwPbxlS5jbubTXeB9106nYM4kPB1olFMK4YE1LtiSaXuyKyIHBZK4divSIOGJYGMVY0eMNrKrvp2EQetcIn+Cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKLqNFcd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKLqNFcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFA9C19421;
	Mon, 16 Mar 2026 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773705018;
	bh=MIlbvjEO+Z8DdolqF1kyDEGWmEwrPm6BtluQqi2zedY=;
	h=Date:From:To:Cc:Subject:From;
	b=sKLqNFcdKiGGZQHjrt2HbLUaSWpdCUqskKb00L0uRBvwnQleJiPY8JEDxSRAFwoas
	 j718vjf5X4CpeRBB1QmVBRCy1n5m924yGd1rlrM1uPMBgYvQ+NzzI6uEgTGc9gA3yT
	 D0dlQYqHTsm6nfEr5B5Ci/9jVPOtSBlmy4ISLeTLcb1YxRDtO5V1SQPWwXesTw2LUD
	 jlIn6PQa/0b55+koppkBkUsvJz8s5HDoOvfr+HEHFBE4HW1/Yj5gjpqvNEFg7gOgCO
	 7WcjCd/vxhHWagymt6X+pnXabDCjjkzjzyNUlqZa+BB8fGX3iei7VsR0wCT5nbKrgC
	 Xa9aS7t8O89Dw==
Date: Mon, 16 Mar 2026 16:50:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com
Cc: bernd@bsbernd.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: [GIT PULL v2] libfuse: run fuse servers as a contained service
Message-ID: <20260316235017.GK1742010@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bernd,

I hope you're feeling better!

Please have a look at this branch with changes for libfuse.  This second
PR contains a bunch of new things:

 * Cleaned up error code handling and logging
 * Examples of systemd-enabled high and low-level fuse servers
 * Most of the checkpatch complaints addressed
 * fuservicemount3 can now be a setuid program to allow unprivileged
   userspace to fire up a contained filesystem driver.  This could be
   opening Pandora's box...

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 9a003db94e0b4df6f984181468135fac96409b09:

Rename doc/libfuse-operations.txt to doc/fuse-operations.txt (2026-03-12 20:54:19 +0100)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-03-16

for you to fetch changes up to 4ba4e3a12bb27cd64abfb56279ed342b08f555da:

nullfs: support fuse systemd service mode (2026-03-15 21:32:35 -0700)

----------------------------------------------------------------
libfuse: run fuse servers as a contained service [v8 1/9]

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel.

Bernd indicated that he might be interested in looking at the fuse
system service containment patches sooner than later, so I've separated
them from the iomap stuff and here we are.  With this patchset, we can
at least shift fuse servers to contained systemd services, albeit
without any of the performance improvements of iomap.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (11):
mount_service: add systemd/inetd socket service mounting helper
mount_service: create high level fuse helpers
mount_service: read fuse.conf to enable allow_other for unprivileged mounts
mount_service: use the new mount api for the mount service
mount_service: port over the other non-root user checks
mount.fuse3: integrate systemd service startup
mount_service: allow installation as a setuid program
example/service_ll: create a sample systemd service fuse server
example/hello_ll: port to single-file common code
example/service: create a sample systemd service for a high-level fuse server
nullfs: support fuse systemd service mode

example/single_file.h                       |   92 ++
include/fuse.h                              |   31 +
include/fuse_service.h                      |  203 ++++
include/fuse_service_priv.h                 |  127 +++
lib/fuse_i.h                                |    5 +
lib/util.h                                  |   35 +
util/fuser_conf.h                           |   47 +
util/mount_service.h                        |   40 +
.github/workflows/abicheck.yml              |    2 +-
.github/workflows/abicheck_prev_release.yml |    2 +-
.github/workflows/pr-ci.yml                 |    2 +-
README.md                                   |    3 +
doc/fuservicemount3.8                       |   32 +
doc/meson.build                             |    3 +
example/hello_ll.c                          |  124 +--
example/meson.build                         |   28 +-
example/null.c                              |   23 +-
example/nullfile.socket.in                  |   16 +
example/nullfile@.service                   |  102 ++
example/service_hl.c                        |  436 ++++++++
example/service_hl.socket.in                |   16 +
example/service_hl@.service                 |  102 ++
example/service_ll.c                        |  421 ++++++++
example/service_ll.socket.in                |   16 +
example/service_ll@.service                 |  102 ++
example/single_file.c                       |  394 ++++++++
include/meson.build                         |    4 +
lib/fuse_service.c                          |  989 ++++++++++++++++++
lib/fuse_service_stub.c                     |   96 ++
lib/fuse_versionscript                      |   17 +
lib/helper.c                                |  110 +-
lib/meson.build                             |   14 +-
lib/mount.c                                 |   57 +-
meson.build                                 |   63 ++
meson_options.txt                           |    6 +
test/ci-build.sh                            |    7 +
util/fuser_conf.c                           |  337 +++++++
util/fusermount.c                           |  313 +-----
util/fuservicemount.c                       |   66 ++
util/install_helper.sh                      |    5 +
util/meson.build                            |   19 +-
util/mount.fuse.c                           |   58 +-
util/mount_service.c                        | 1434 +++++++++++++++++++++++++++
43 files changed, 5523 insertions(+), 476 deletions(-)
create mode 100644 example/single_file.h
create mode 100644 include/fuse_service.h
create mode 100644 include/fuse_service_priv.h
create mode 100644 util/fuser_conf.h
create mode 100644 util/mount_service.h
create mode 100644 doc/fuservicemount3.8
create mode 100644 example/nullfile.socket.in
create mode 100644 example/nullfile@.service
create mode 100644 example/service_hl.c
create mode 100644 example/service_hl.socket.in
create mode 100644 example/service_hl@.service
create mode 100644 example/service_ll.c
create mode 100644 example/service_ll.socket.in
create mode 100644 example/service_ll@.service
create mode 100644 example/single_file.c
create mode 100644 lib/fuse_service.c
create mode 100644 lib/fuse_service_stub.c
create mode 100644 util/fuser_conf.c
create mode 100644 util/fuservicemount.c
create mode 100644 util/mount_service.c

NOTE: This is what I saw when I ran checkpatch.pl via the CI wrapper
scripts, and with strcpy complaints turned off.  Nearly all the
complaints are from hoisting code from fusermount.c into fuser_conf.c.
I don't know if you want me to correct all the checkpatch complaints
from the old code?  Or just copy-paste and ignore checkpatch because
all that code already works?

(My own preference is to copy-paste the code and then apply whatever
style fixes as a subsequent commit, so that the changes are easier to
spot.)

ERROR: Macros with complex values should be enclosed in parentheses
#83: FILE: example/single_file.h:77:
+#define SINGLE_FILE_OPT_KEYS \
+	FUSE_OPT_KEY("ro",		SINGLE_FILE_RO), \
+	FUSE_OPT_KEY("rw",		SINGLE_FILE_RW), \
+	FUSE_OPT_KEY("dio",		SINGLE_FILE_DIO), \
+	FUSE_OPT_KEY("nodio",		SINGLE_FILE_NODIO), \
+	FUSE_OPT_KEY("sync",		SINGLE_FILE_SYNC), \
+	FUSE_OPT_KEY("nosync",		SINGLE_FILE_NOSYNC), \
+	FUSE_OPT_KEY("size=%s",		SINGLE_FILE_SIZE), \
+	FUSE_OPT_KEY("blocksize=%s",	SINGLE_FILE_BLOCKSIZE)

WARNING: Missing a blank line after declarations
#599: FILE: util/fuser_conf.h:23:
+	struct mntent *entp = getmntent(stream);
+	if(entp != NULL) {

ERROR: space required before the open parenthesis '('
#599: FILE: util/fuser_conf.h:23:
+	if(entp != NULL) {

WARNING: return of an errno should typically be negative (ie: return -ENOENT)
#2477: FILE: example/single_file.c:115:
+		return ENOENT;

WARNING: return of an errno should typically be negative (ie: return -ENOENT)
#2533: FILE: example/single_file.c:171:
+		return ENOENT;

ERROR: do not initialise globals to 0
#4453: FILE: util/fuser_conf.c:31:
+int user_allow_other = 0;

WARNING: Missing a blank line after declarations
#4466: FILE: util/fuser_conf.c:44:
+	char *dest = buf;
+	while (1) {

WARNING: Missing a blank line after declarations
#4469: FILE: util/fuser_conf.c:47:
+		int offset = next_src - src;
+		memmove(dest, src, offset);

ERROR: space required before the open parenthesis '('
#4473: FILE: util/fuser_conf.c:51:
+		if(*src == '\0') {

ERROR: space required before the open parenthesis '('
#4479: FILE: util/fuser_conf.c:57:
+		if('0' <= src[0] && src[0] < '2' &&

ERROR: code indent should use tabs where possible
#4483: FILE: util/fuser_conf.c:61:
+^I^I^I        | (src[1] - '0') << 3$

ERROR: code indent should use tabs where possible
#4484: FILE: util/fuser_conf.c:62:
+^I^I^I        | (src[2] - '0') << 0;$

WARNING: Missing a blank line after declarations
#4502: FILE: util/fuser_conf.c:80:
+	FILE *fp = setmntent(mtab, "r");
+	if (fp == NULL) {

ERROR: space prohibited before that '++' (ctx:WxO)
#4510: FILE: util/fuser_conf.c:88:
+			count ++;
 			      ^

WARNING: Missing a blank line after declarations
#4592: FILE: util/fuser_conf.c:170:
+	char *s = strchr(line, '#');
+	if (s != NULL)

ERROR: trailing statements should be on next line
#4594: FILE: util/fuser_conf.c:172:
+	for (s = line + strlen(line) - 1;
+	     s >= line && isspace((unsigned char) *s); s--);

ERROR: trailing statements should be on next line
#4597: FILE: util/fuser_conf.c:175:
+	for (s = line; isspace((unsigned char) *s); s++);

WARNING: Missing a blank line after declarations
#4605: FILE: util/fuser_conf.c:183:
+	int tmp;
+	if (strcmp(line, "user_allow_other") == 0)

ERROR: space required before the open parenthesis '('
#4609: FILE: util/fuser_conf.c:187:
+	else if(line[0])

WARNING: Missing a blank line after declarations
#4618: FILE: util/fuser_conf.c:196:
+	FILE *fp = fopen(FUSE_CONF, "r");
+	if (fp != NULL) {

WARNING: Missing a blank line after declarations
#4622: FILE: util/fuser_conf.c:200:
+		int isnewline = 1;
+		while (fgets(line, sizeof(line), fp) != NULL) {

ERROR: space required before the open parenthesis '('
#4630: FILE: util/fuser_conf.c:208:
+			} else if(line[strlen(line)-1] == '\n') {

WARNING: line length of 116 exceeds 100 columns
#4631: FILE: util/fuser_conf.c:209:
+				fprintf(stderr, "%s: reading %s: line %i too long\n", progname, FUSE_CONF, linenum);

ERROR: space prohibited before that '++' (ctx:WxO)
#4636: FILE: util/fuser_conf.c:214:
+				linenum ++;
 				        ^

WARNING: braces {} are not necessary for single statement blocks
#4638: FILE: util/fuser_conf.c:216:
+		if (!isnewline) {
+			fprintf(stderr, "%s: reading %s: missing newline at end of file\n", progname, FUSE_CONF);
+
+		}

WARNING: line length of 113 exceeds 100 columns
#4639: FILE: util/fuser_conf.c:217:
+			fprintf(stderr, "%s: reading %s: missing newline at end of file\n", progname, FUSE_CONF);

WARNING: Block comments use a trailing */ on a separate line
#4704: FILE: util/fuser_conf.c:282:
+	 * Use a whitelist to be safe. */

WARNING: Block comments use a trailing */ on a separate line
#4710: FILE: util/fuser_conf.c:288:
+	 * overlaid. */

WARNING: Prefer ARRAY_SIZE(f_type_whitelist)
#4751: FILE: util/fuser_conf.c:329:
+	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {

total: 13 errors, 16 warnings, 6633 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/tmp/moo.patch has style problems, please review.

NOTE: Ignored message types: AVOID_EXTERNS COMMIT_MESSAGE EMAIL_SUBJECT ENOSYS ENOSYS_SYSCALL FILE_PATH_CHANGES FROM_SIGN_OFF_MISMATCH GIT_COMMIT_ID MAINTAINERS PREFER_ATTRIBUTE_ALWAYS_UNUSED PREFER_DEFINED_ATTRIBUTE_MACRO QUOTED_COMMIT_ID SPDX_LICENSE_TAG STRCPY

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
