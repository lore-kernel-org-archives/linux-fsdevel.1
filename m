Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C31339388;
	Sat, 22 Aug 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787420278; cv=none; b=pV4DkUTAXGllKQqesMEPM8n4qe3ep5Mcd+kB9cNNBwedkgyL9KRNpsG1P8BkJ5k4VMNWnbPaGInnNunaNDWc+/AfcTd9WByH3TuJDmmBwM1TCLnjN925XqRXGNape07nxPCrdvdtYvl7f9uiSPxkYdLYLQkPi0QoHD28T8es+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787420278; c=relaxed/simple;
	bh=NiT7kFgnRRlDj4dSJamfGUm8INn1A4/9maoROe34qqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEHj6jxFUG44xQH8mGoHful0kYIxLYglRyloIVvxEH0P3PgcPxL0ZnlWJ0kT2zGCWmp9mzxl5mHrDspMWD0Hr1qMdfVHw4CA8a0alWZN5z1mJT2dnrVz7t5fe+KTogQI631rqUVTxERXh4btmQEVhP9esTNA4UTCd6VGsdLe6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=JJWjnmij; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="JJWjnmij"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id EECCF1D455;
	Sat, 22 Aug 2026 17:37:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me EECCF1D455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1787420268; bh=NiT7kFgnRRlDj4dSJamfGUm8INn1A4/9maoROe34qqw=;
	h=From:To:Cc:Subject:Date:From;
	b=JJWjnmijaFaxfj9+dFaxZxlac1x+jr3CNSfuw28HpPhXFA+oGH0sBr5GLO6EStItS
	 A/wa62+7E8DczL08USBGJgL1ug4g9oLlHuBOol6CPWQwX50CkIHRKWsYmFudU77IJW
	 4D2zpCNWotk41SEEs6BHbNiyOir9K59d0maBbYO0=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 7+3kJmveiWohyQAA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 22 Aug 2026 17:37:47 +0000
From: David Timber <dxdt@dev.snart.me>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [RFC PATCH] fat: add noflush mount option
Date: Sun, 23 Aug 2026 02:37:32 +0900
Message-ID: <20260822173732.10230-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On most distros, udisks manages users' removable volume mount requests.
Udisks is configured to always mount FAT volumes with the 'flush' mount
option. This is largely okay for populating directory in small sizes,
but when a large number of files are involved, the flush behaviour acts
as a bottleneck point in fat_file_release(). The user may want to
disable the flush option temporarily before commencing such an intensive
operation.

To cover this use case, introduce the new 'noflush' mount option. When
used in the mount options to mount a volume, it overrides the 'flush'
option previously specified. When used in remount, update it updates the
flag.

This is a breaking change as traditionally, the mount options other than
rw and ro are ignored. The patch breaks this tradition by allowing
reconfiguration of 'flush' and 'noflush' mount options.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/fat/inode.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 28f78df086ef..850df43ba354 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -813,10 +813,14 @@ int fat_reconfigure(struct fs_context *fc)
 	bool new_rdonly;
 	struct super_block *sb = fc->root->d_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct fat_mount_options *new_opts = fc->fs_private;
 	fc->sb_flags |= SB_NODIRATIME | (sbi->options.isvfat ? 0 : SB_NOATIME);
 
 	sync_filesystem(sb);
 
+	/* allow reconfiguring "flush" or "noflush" */
+	sbi->options.flush = new_opts->flush;
+
 	/* make sure we update state on remount. */
 	new_rdonly = fc->sb_flags & SB_RDONLY;
 	if (new_rdonly != sb_rdonly(sb)) {
@@ -1047,7 +1051,7 @@ enum {
 	Opt_charset, Opt_shortname, Opt_utf8, Opt_utf8_bool,
 	Opt_uni_xl, Opt_uni_xl_bool, Opt_nonumtail, Opt_nonumtail_bool,
 	Opt_obsolete, Opt_flush, Opt_tz, Opt_rodir, Opt_errors, Opt_discard,
-	Opt_nfs, Opt_nfs_enum, Opt_time_offset, Opt_dos1xfloppy,
+	Opt_nfs, Opt_nfs_enum, Opt_time_offset, Opt_dos1xfloppy, Opt_noflush
 };
 
 static const struct constant_table fat_param_check[] = {
@@ -1110,6 +1114,7 @@ const struct fs_parameter_spec fat_param_spec[] = {
 	fsparam_flag	("debug",	Opt_debug),
 	fsparam_flag	("sys_immutable", Opt_immutable),
 	fsparam_flag	("flush",	Opt_flush),
+	fsparam_flag	("noflush",	Opt_noflush),
 	fsparam_enum	("tz",		Opt_tz, fat_param_tz),
 	fsparam_s32	("time_offset",	Opt_time_offset),
 	fsparam_enum	("errors",	Opt_errors, fat_param_errors),
@@ -1167,10 +1172,6 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
 	struct fs_parse_result result;
 	int opt;
 
-	/* remount options have traditionally been ignored */
-	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
-		return 0;
-
 	opt = fs_parse(fc, fat_param_spec, param, &result);
 	/* If option not found in fat_param_spec, try vfat/msdos options */
 	if (opt == -ENOPARAM) {
@@ -1183,6 +1184,18 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
 	if (opt < 0)
 		return opt;
 
+	/* remount options have traditionally been ignored */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		switch (opt) {
+		/* but there are exceptions */
+		case Opt_flush:
+		case Opt_noflush:
+			break;
+		default:
+			return 0;
+		}
+	}
+
 	switch (opt) {
 	case Opt_check:
 		opts->name_check = result.uint_32;
@@ -1235,6 +1248,9 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
 	case Opt_flush:
 		opts->flush = 1;
 		break;
+	case Opt_noflush:
+		opts->flush = 0;
+		break;
 	case Opt_time_offset:
 		/*
 		 * GMT+-12 zones may have DST corrections so at least
-- 
2.55.0

