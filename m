Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE091F4181
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833628; cv=none; b=kMMUc9zXqVfUXGytm8X5u7JWg1rNb2mpcRY73HW//ScLAlorgXJ1bD4NGgD/r2NrBrXu1VbQdoTkqqV+zdJtx5SaZ2q0JKVQAb+SDk+Xa8PlMZSeSDa9CvTcfw+3UXK3k8CtPcrWHaXgxlpAdLGQUP1mZDKPeeRlmvlKS3cnaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833628; c=relaxed/simple;
	bh=IwMVusI3iVqOcsu9zsxmYcL3ZVH51sOYCj+SfVFVzOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ykfq18jpQkfQJjZC3WTvFaprdrbFiDbh/0tQky/qLzpnpvyXq1a2jYzRpkFQeDT4qlsN2O8WlPhgPHCZCe//6Pm8UAMaMEE95j47X2VACVioVl5Z7aHDlLVsLYcHhyQVJBDaiSzDyK1uabBoYXicc7FNZK4iAKb0UymFuHFhTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb40+q/Z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb40+q/Z"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-482f454be5bso23318025e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833625; x=1776438425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/Dn3weYqW/mAs0aO61ucSWpXPQ2xQU21uyBf/oql60=;
        b=hb40+q/ZvE/kXjo/Bp6LQHfM6kPGAfNb0wUo3Abjuxd6srXTMSopk/Fs2lRKdBBDC6
         bbNmSAZVG1aEb+Xaf/XITXTvzKhjpP9zNPsvK3oZjuE1SY2JNGBC6w9b4om0AQRj9GAw
         SVmvdxyd0UvW1MczTYjYWMTWGnqlhxDCb63Q/XYiC7CGaNY28wEhyRxuH1Tz3j/+83RP
         +5rOZSuiyWt01f5fpUox04YjHfPEVHq0o/2/qJpos+islatnyxRYB7icn2pkcwHU7QuO
         YeUK6iM4F3kMjUGsSAmFIlbQtd8eTyYpTzciXIu0cn99CRST8FWXzPGFLO8juxzmPbfw
         33DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833625; x=1776438425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/Dn3weYqW/mAs0aO61ucSWpXPQ2xQU21uyBf/oql60=;
        b=ElkuuHAzlbcrB28nVGW5a6SFlq21OED9ZGNft4dhdY79j2T+M5vHiEayIzlHXjNi+F
         F74QWxFnkjfu13DjV6YVlks7DBm4464zCYG0gX9Rsfw8rzJpNLKssaxJavs3fZ95PtTx
         zbocWwvueF2yTXkR+YeBbqMXa1SEdvNf5gYdkTjygI8pGqHN+1vvs9H/Bfg1lfoz0l64
         ECiKMMWxvCbFMigKDuhbnM0C3up6uSp77oB9n3ze1c98/YTbAt9lGtFe1z7jDNi0Ju47
         BJHQAeVdECjNyssjHp1rhiuAG6X5/teUImLNDEFKvf9+rgZFIgKAX/NRnAoT3ZgA3MBG
         UbXw==
X-Gm-Message-State: AOJu0Yyij3HSKn5zcKjclbHl7nxSWYF+Amkjk+WRIcu1qZEpPTNtimkz
	hTbHrfiDgl6+0+OBtoPg0JkG31cGS7gfu3NmOunJ0eIv47ZcB2IfEkN1caSpvQ==
X-Gm-Gg: AeBDies4IldTwrg+795SyL5326TiqtSJjTBL3MpdUBdGWueA2d4JrDjr/jwOo19B+kn
	qNKXeoqKZbDEZ4BPUNjocNccRODjAaBBb+gLrZnBJiCwHx1pvzS0erf/Zc8CBAGXedg2+/fl/K2
	KIxCXSZ4CBr8iACJl+E/4k6YCNwXaarHPcbUI6m3J0P4amFFlslwTrozJxax+v/jAdO4S51kYcW
	E3XFbgI+NHwDGg9rv2EKHBUMPBjPHWJqJKB43IRYlGNd/ElHrUoYdBHd8EzBkV4N05e4QZudHF+
	PyDXUSdHqj6XxwO+2IBOvXz9fCpUaD0OM0rMrFPjSOBywj6eMUS3RWcksIlrh2vNY6pqYRbJ9dR
	Re+WJWXHRY+DxvkfiHHuIxbLlrC/mhr5wAtqJLsJCJNSKBxVbbrdGYF9JUnGwhkoOPSciY98tB4
	1zXuaAyHUNognqHXgrSMjJ2DLVAILwShVWpoTp6GsWX5t+SRRRqxlkB7CyIeEeYdMnTtop+8oDs
	w0GaiZru1o=
X-Received: by 2002:a05:600d:8496:10b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-488db8d16aamr8909665e9.10.1775833625129;
        Fri, 10 Apr 2026 08:07:05 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm28331225e9.5.2026.04.10.08.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:07:04 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 09/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 16:02:57 +0100
Message-ID: <20260410150256.308947-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmufat.h provides constants and common data structures to inode.c and super.c as well as a wrapper around calls to sb_read

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>

fs/vmufat/vmufat.h                   |  126 ++++

---


--- /dev/null
+++ b/fs/vmufat/vmufat.h
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Header file for VMUFAT filesystem */
+#ifndef _VMUFAT_H_
+#define _VMUFAT_H_
+
+/* maximum length of file name */
+#define VMUFAT_NAMELEN			12
+
+/* Some GNU utils might not list files with inode num 0 */
+#define VMUFAT_ZEROBLOCK		0x10000
+#define VMU_BLK_SZ			0x200
+#define	VMU_BLK_SZ16			0x100
+#define VMU_PHYS_SZ			0x100
+
+/* file allocation table markers */
+#define VMUFAT_FILE_END			0xFFFA
+#define VMUFAT_UNALLOCATED		0xFFFC
+#define VMUFAT_ERROR			0xFFFF
+
+/* parameters for possible VMU volume sizes */
+#define VMUFAT_MIN_BLK			0x04
+#define VMUFAT_MAX_BLK			0x10000
+
+/* specifcations for directory entries */
+#define VMU_DIR_RECORD_LEN		0x20
+#define VMU_DIR_RECORD_LEN16		0x10
+#define VMU_DIR_ENTRIES_PER_BLOCK	0x10
+#define VMUFAT_NAME_OFFSET		0x04
+#define VMUFAT_FIRSTBLOCK_OFFSET16	0x01
+#define VMUFAT_START_OFFSET16		0x01
+#define VMUFAT_SIZE_OFFSET16		0x0C
+#define VMUFAT_HEADER_OFFSET16		0x0D
+
+/* File types used in directory */
+#define VMU_GAME			0xCC
+#define VMU_DATA			0x33
+
+/* filesystem locations marked in the root block */
+#define VMU_LOCATION_FAT		0x23
+#define VMU_LOCATION_FATLEN		0x24
+#define VMU_LOCATION_DIR		0x25
+#define VMU_LOCATION_DIRLEN		0x26
+#define VMU_LOCATION_USRLEN		0x28 /* set to 200 by real hardware */
+
+/* date offsets */
+#define VMUFAT_SB_DATEOFFSET	0x30
+#define VMUFAT_FILE_DATEOFFSET	0x10
+
+#define EXEC				0111
+#define NOCOPY				0xFF
+#define CANCOPY				0x00
+
+u16 vmufat_get_fat(struct super_block *sb, long block);
+void vmufat_save_bcd(struct inode *in, char *bh, int index_to_dir);
+struct inode *vmufat_get_inode(struct super_block *sb, long ino);
+int vmufat_list_blocks(struct inode *in);
+
+enum vmufat_date {
+	VMUFAT_DIR_CENT	=		0x10,
+	VMUFAT_DIR_YEAR,
+	VMUFAT_DIR_MONTH,
+	VMUFAT_DIR_DAY,
+	VMUFAT_DIR_HOUR,
+	VMUFAT_DIR_MIN,
+	VMUFAT_DIR_SEC,
+	VMUFAT_DIR_DOW
+};
+
+/* constants for BCD conversion */
+#define SECONDS_PER_DAY			86400
+#define DAYS_PER_YEAR			365
+#define SECONDS_PER_HOUR		3600
+#define HOURS_PER_DAY			24
+#define SIXTY_MINS_OR_SECS		60
+#define FEB28				59
+#define DAYS_PER_WEEK			7
+#define START_OF_EPOCH			70
+#define CENTURY21			30
+#define CENTURY22			130
+
+struct memcard {
+	unsigned int sb_bnum;
+	unsigned int fat_bnum;
+	unsigned int fat_len;
+	unsigned int dir_bnum;
+	unsigned int dir_len;
+	unsigned int numblocks;
+	struct mutex mutex;
+};
+
+struct vmufat_block {
+	struct list_head b_list;
+	int bno;
+};
+
+struct vmufat_inode {
+	struct list_head blocks;
+	unsigned int nblcks;
+	enum vmufat_file_type {
+		GAME = 1,
+		DATA = 2
+	} ft;
+	struct inode vfs_inode;
+};
+
+static inline struct vmufat_inode *VMUFAT_I(struct inode *in)
+{
+	return container_of(in, struct vmufat_inode, vfs_inode);
+}
+
+struct vmufat_file_info {
+	u8 ftype;
+	int fblk;
+	char fname[VMUFAT_NAMELEN];
+};
+
+static struct buffer_head *vmufat_sb_bread(struct super_block *sb,
+	sector_t block)
+{
+	if (!sb)
+		return NULL;
+	return sb_bread(sb, block);
+}
+
+int vmufat_count_files(struct super_block *sb);
+#endif
