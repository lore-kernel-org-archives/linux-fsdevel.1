Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A509475
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920337; cv=none; b=XePx0ko5wTHQALbrqTbmLYGD4ZabsaaBgdTuf5N7O7VX+opZjkJv3Viml7fFuxV7pQwAIoIxjrw/RaL8DEew64PlM6FJ+1x+EoIG/AptqG7xapVdBEmXy2BxCPIY+EJKStg62H9u60W3sK/kwTZl3QodRpG/fMP7Ug8aM7RqT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920337; c=relaxed/simple;
	bh=RC9ve88mLXnSmouMvk6p6ZQIoV10ehxQDLmv7e6C0vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiFh0o/qAzpLb3s6ZzzooJVpE5ZTc1cMwm9B2vIVZIv3M2NJeA2hllRb1R9ObDO4rdZ8VcqaIZ0kbWA5M3ut7HBPB6nlP93ArAbEVlA8Fj3lCQLtTF7NSlEPCoIz+m3Uk5AcI9oV5FLHPuPzKDANj0G8hKr1WWotBUJs3p2co3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q24cfckX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q24cfckX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso2493937f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775920334; x=1776525134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tdtenha4z2OiHm8HeH2S1Akton2Og6DEskpUOZMq1w=;
        b=q24cfckXQSBBv1eiZ60hE0bbR+wI6wE/llM+7vgXL8MJrCzcmD4VB0GslTxQKxaohn
         /lkJuiTgXONpPpvBdkuUpfOsCNztHbZLS7NvdT7oMxqG8G5hV/hzBcBDvryAwDWtaHDf
         CcQFfk2VU4DrCsOvK+rneM5XIYU+tUVID6brD9LAx2awf+GcIQ6hagMiBxJEO8IzHJ3b
         RyxnfDRHGhn+h+C4CD5NOFidzE4Rr1cJaka5KbvoJSzlJ6vza6jXPtb7RNPYA2nhe5K2
         8XVFzy9NRhhiRdEZEPcpbYbhsGrOKIkeJS/eJnZ5dywgwFyVIJYSZLr8yrYm3WJItZSV
         MI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775920334; x=1776525134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tdtenha4z2OiHm8HeH2S1Akton2Og6DEskpUOZMq1w=;
        b=rd7g4qh3rE5A4LLVm27sSoKJeLrVxEByNU/JaBX2tpk9Fm2ShMv77AthlPgfvDsxUo
         5kqg/PkL4V8I7E0eKqxdQF3dlYFu82rDR0r+ykBZGAXYp5q9ScjMv3F8OP24y42Ki91v
         TWA/HRsqKwbMacNOKub8YGPDI+rGut/L3JsHSY+Cq3NhLKSzlkfoaCBVeUAisFHnpsWM
         1diLPWisi97mkjn5O1VjMGRiGO5r2yhPqx9AlOIG3uioPPMq+6APWwXPj6YHbpvHI+SC
         6tBnEf3ZZaidXs8AjbYlyJbEFQ7B6uxqh+RkGjSoJo6dT9BqmYExw+CFjjP+LCeM2azu
         qltg==
X-Gm-Message-State: AOJu0YwsKUlPBuNl0/hKCicurUoATpvsBvjGyJR1hfnsW5nHB5DedS9Y
	0Grm36lxo+Tygz1hNg03dEt0f783qWHM+YtHHo32+HbBxtLiNNXSL8fCEU1ing==
X-Gm-Gg: AeBDieuOr2BxdROaIFPOH4fLqgeVH2KeoqHnwfV5lsW1Rmnx1x49QtJ2cXz6zhiMJgv
	x9xgpFJ+wKagDd9LCH51qn6kKKfjf1zLy4t+lPdHCcX1MjLDof2vt9XcYIiJq5gvIKd97hrubRO
	ruCwxTGV98cw7yh0zOA8b4pq0stQFKerzFv3gmMGyZ1IgSWR30lVQW/C4a53Ga+A6Lucm7rFhCG
	WF1wzjtSHKZ9pypidE2FsRvNEskXKQqD4amdzqzJSlEzgw7RTGHqCURszytxKqfLNQ71h5m/pjO
	H3cA6UbZr38gvfip5SBCo4WD3T/eduarmmqnMn60T6JjzN9SDpE8MZ7vTJ9oVH6OoQIGlBiLRw7
	ouW3y2VhWxjDyoVsnRNyjSGyrCw6M2GEzBZZ08Nh+GBC5sV4ikSJO8iiFf65TuhXE6byTj3fJnp
	sEQCmS3eX3UgXcpkJubfXXGCTdLnAi3UqtlIIrMagRpIybykFzKSDIcczUcZomVmvwR4u7taIzr
	s85AEMXjIwNbpIHGvh9/NYrh2J9ZSY=
X-Received: by 2002:adf:f707:0:b0:43d:68bd:f590 with SMTP id ffacd0b85a97d-43d68bdf5c4mr4378396f8f.6.1775920334157;
        Sat, 11 Apr 2026 08:12:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:37d6:c100:81d8:4e83:a60e:1a81])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm17167835f8f.33.2026.04.11.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:12:13 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: Linux FS development <linux-fsdevel@vger.kernel.org>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] Add vmufat header
Date: Sat, 11 Apr 2026 16:11:37 +0100
Message-ID: <20260411151155.321214-4-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
References: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmufat.h provides constants and common data structures to inode.c
and super.c as well as a wrapper around calls to sb_read.

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>

---
 fs/vmufat/vmufat.h | 126 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 fs/vmufat/vmufat.h

diff --git a/fs/vmufat/vmufat.h b/fs/vmufat/vmufat.h
new file mode 100644
index 000000000000..369ee59738ee
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
-- 
2.43.0

