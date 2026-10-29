Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305540;
	b=W5RLV6Md8IEWUPPJVxMuCslpenxPHm/jKWdWSQRUc64wEBaxRwiYwvQrPNbB/bVIQ/MO
	 SqEL9fh0L6zIcdqwg34+QFZpFmrCDB+n4x7JnkzGrO5Iq0GU0q3biuKMyViwJcoRiIKTg
	 H2HJxKdmLeYEM2upcSKsGYyofjMQNq9b4pFtytVSzF+/sRnmzKPc0dn4MLwGii5pf7ZqY
	 FQEibazHJd+U2MhsRxGl97xOlrLXDzuH4k47CqoTgZ6Utg55+muiFyAGEu1ygHP3Z6P5g
	 ZLCIaQREjWMz7L9FPaYUVBUvZntUUSZSaF4+/y8GhmBefubhIncUVcQIGyxmkaFABpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AJ2rr9yl7nzCTLgX0OQTyS4SWxqI0qu4DuqhR4MK27g=;
	b=FrhrgBeKGdOB9Iv2Qd8xNEn5hDZd84CInsgCfUAASCTgye1PrkxV4SrEcDx6h/7mvbdK
	 nB3k4RlESA6z1HzRX29eI2ffg7n8eoMMa623JGuDbG9jcVjH5sitHo5LzObQgCrlSjAJO
	 YZ1zzx63LkY4ViXYoMjk619fLruVYcGArdKlWlTKw2eFj1BDqD4PlAHZi88H6O9NQOuXV
	 /YbUue1EJnF2cQgyMRhVoDLy1NC27WnI37PBqYjh7u2FMtKcXKj6SuSXRpwp+DWLOL9Vo
	 si22ja+NAcijm6+heRbnLxaSYSfnhoII8dTV3/oIcKowir7F/i4VPHREJmrc2qxgGkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HuJXZvMB;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C00606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 20:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56C00606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HuJXZvMB
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-19305bcb6d5so642609c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793305539; x=1793910339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AJ2rr9yl7nzCTLgX0OQTyS4SWxqI0qu4DuqhR4MK27g=;
        b=HuJXZvMBZqZoZ1IJ0Au4NTWas5k2JraJEWR7azsu0LGrObUsqThdtmt+JZDaWSq4ZK
         uc7Wg05f4u/OPDeLCtehyc1CTXTHEc3wutW/Q4C4J+fbSzkMBxxHIS+FxiUUFw2R0CeP
         tLnGc2MDnQ2D+nOlg6AIBbve0lsUSoHb0BFl3IycI8f5oeUjoDK+4XDHqTHtNPO0LUuZ
         J8jSConYemvnfwHycleXl7t8ktZxRyRlw5/vX34jw/tDxCtdEVgEmaGpCtk3mdCu/mE0
         r1STlzOFry6MWpl50GFApT4Ghie5PrwQyRt7/PnamieplaiodoF/dccgy3l+XMF2US3U
         1G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305539; x=1793910339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AJ2rr9yl7nzCTLgX0OQTyS4SWxqI0qu4DuqhR4MK27g=;
        b=rjR1SmN4ngcvt7dgWz9MV9s8D9J3qDlv+gZ3HrrzpLK4bJuu/IP4mgrg/uWdrYnFPv
         L72CPYfS6djL4moO38ghm3XDgB1fi/uKBDrzCT+T1qCNkqiUpaA6tmg8sr+2JpTHhFd+
         IN98ocOTZ3WmAHqeHdTKrvv4ARgpqWqYHmVMs/lHKLG9/fmflgFlbJtpOYa/XtUHse/P
         pxorsuzRpB3+OO2A7AKw6xZFz94piyLHVq70UvlH95sSpfW5i1D2Y6yohtyMRoFddtwA
         gbK2p2+6WUN/+w50E/2OT/V+4CwZTfpIh1S5TwnOTHoB7sAIDlbO18DeQ2GDRQd6TpdH
         UMLg==
X-Forwarded-Encrypted: i=1; AKwUvBy2uA1o7qUU+dsoCH+BBF4S5oOPHSuHUGJFFv/7IQkvN5/2ODlSCtfQF89+xEzzwPtk4menkQYpTWTHderC@vger.kernel.org
X-Gm-Message-State: AFq9FYJNhDmMRe3yVZGx0Uwf7zJobVG9JT2qsYu9+JfC4HClL79/0A2/
	RQh1uKWWESGW82YBPbwJXivbja4X79ffNsa5grIeIp7RygLpmco52hzD
X-Gm-Gg: AYBFou3FYcEISws3InZUuwl3834GBeZC1mkdFl4UrEw5p/BidueMGkSlC1ce8C5O/9b
	FzMzFsFr2P1nUgSGizR/puhqHlVUd8I6JgB5GUa1viNilHJwNgZ7+f7AY+4DMXjLXJ32ZkGk8X0
	mqo8cosxH/1X/EGqrf+EFjVmJL43WJm9b36m/qUK6p2pQD5AXLluJ5Yac4UA+p64NsjB01qjlGS
	ebWARwSSr0qHQXEyv2qKUyPAdLVzNpL2I9UIdXsMF1T4Y6J3zxZq3nAIRuiN4HdlUU7PRWZeSiR
	u3mxnfZ3VVYMDi8nUDaDZKCSMfLRKob/9peSvVpgWnlcTCI+cVo9lyHBQF+qOoMv5DOwXgM3OH7
	fLuBR+6GvRYNZHq2ZQf28M1hka0Vl6Ea8bsOhgcPvQk17vCa0O813i/WE8vdWynKB4VtC14WCBT
	mIKwfWQd5Np1rkxFf+8aaPBy0axcpt4lFklJ/yKhBBWrgFhu1DA/ZUkOtq6bBsbDFBe+ikHs11K
	5yUR6/lga109itBUfhLdkjLEZxc1qxiH0I4/2/Q1bIzPuk2RsZcmpoqMtM9m5H42hHSZsO3WNZA
	xOQ6DvHkAHWmPbDbiE0rlo+r5snwWb8QBhyJvMkDhOvrfC4vz74GXBit
X-Received: by 2002:a05:7023:a42:b0:16a:c6f2:60c2 with SMTP id a92af1059eb24-1ac5d88c626mr122263c88.12.1793305534108;
        Thu, 29 Oct 2026 13:25:34 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm916000c88.14.2026.10.29.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:25:33 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: akpm@linux-foundation.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] fat: fix parent link count when replacing a sibling directory
Date: Thu, 29 Oct 2026 20:23:52 +0000
Message-ID: <20261029202352.59890-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfat_rename() and do_msdos_rename() adjust parent link counts only when
updating the dotdot entry for a move between different parents. Replacing
an existing empty directory in the same parent also removes a
subdirectory, but leaves the parent's link count unchanged.

For example, renaming one of two sibling directories over the other
leaves the parent with four links instead of three. stat and ls report
the stale count, and find -links 3 does not match the parent.

Drop the parent's link count for this case after the source entry has
been removed successfully. Leave cross-parent renames, regular files
and the existing error paths unchanged.

As in rmdir, check that the parent's link count is at least three before
decrementing it. Report a filesystem error if corrupted directory entries
have left the count too low, rather than reducing it below two.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Check the parent link count before decrementing it and report low
  counts with fat_fs_error(), matching rmdir(), as noted by Sashiko.
- Retain Hirofumi's Acked-by from v1.

v1: https://lore.kernel.org/r/20261028211626.26103-1-dennylin0707@gmail.com
Review: https://sashiko.dev/#/patchset/20261028211626.26103-1-dennylin0707@gmail.com
 fs/fat/namei_msdos.c | 8 ++++++++
 fs/fat/namei_vfat.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index c7500c2859e0..97289c9d9261 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -565,6 +565,14 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 		(void)sync_inode_metadata(old_dir, 1);
 
 	if (new_inode) {
+		if (is_dir && old_dir == new_dir) {
+			if (old_dir->i_nlink >= 3)
+				drop_nlink(old_dir);
+			else
+				fat_fs_error(old_dir->i_sb,
+					     "parent dir link count too low (%u)",
+					     old_dir->i_nlink);
+		}
 		drop_nlink(new_inode);
 		if (is_dir)
 			drop_nlink(new_inode);
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index ff7652bf0410..c4d5628c05fa 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1011,6 +1011,14 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	vfat_update_dir_metadata(old_dir, &ts);
 
 	if (new_inode) {
+		if (is_dir && old_dir == new_dir) {
+			if (old_dir->i_nlink >= 3)
+				drop_nlink(old_dir);
+			else
+				fat_fs_error(old_dir->i_sb,
+					     "parent dir link count too low (%u)",
+					     old_dir->i_nlink);
+		}
 		drop_nlink(new_inode);
 		if (is_dir)
 			drop_nlink(new_inode);
-- 
2.43.0

