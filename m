Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778736402E
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655023; cv=none; b=A9w++IRFb4eFjoVTSc97wDc9EZojcuk20nVL6pH/e8tBDn5fTs3YKJka+ER+uv4OYm3IRCMMYLpa1oaTXB2h74rqV9vOMLZDa/gu3KVgM3kFPHxqh1ti9q6hzTEGnl+OWM8zh8cKNTE400YZQ9wEi+SfvfyZ/lnseDbevKNBjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655023; c=relaxed/simple;
	bh=MpnALZG1g9ffSEIKd4Yh2uqvfW31Aa9s3G1+6rk6JIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gka9Bbu9YHb12PF9pL1K8lyXyFo9ifqEK2Jn0CFG0/ZDw9ohP1wcsg8hy6EeTOIwbNpxbJlJkBSFvDX8Nvk9ZXP5r0RMl97jGY+G6QIAcE3Q9YkgOmmforAC2JOOxjyS1BoBQ+xMD11gbXlDpp4IsDqJrOgA8Ku7ECOGbK+qfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=DDl4+pw0; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="DDl4+pw0"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53396adbc53so9341261cf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2026 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791655020; x=1792259820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3+ihWzjyeVbz1fS/BASYfQ2t4vA4knncZR4QXyo1so=;
        b=DDl4+pw0XhjDwWOunAKn9s4OP9x6b3RifMCZ0ayFXJpxFwM1Yif8r0gxs0RnO1agei
         rgJnfxxNcxTvFlZIAFx1xZ9+P2km/NEs2kQ0/i1bm4KUS/RpoUVPlIhPR7rM5NwIod3b
         aHYKDNzHSFskaWeHg7KjisT04oOBk2+OXt4Dohx0I97wUZFP1YC/lHUgMDvHLx8hU93H
         T46XCCNXP/Cc1XKWohKT7U2XKVqgdXTr7zQZpXMcCCH0qiUji5pqqFDYIPUue4iZwjNn
         rujzMFtkmJfVM0RUFT1qskmSpdiHqOOBbh+in8I26qLGSQmjbRCasAR27zAoFTsFdANy
         HZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791655020; x=1792259820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3+ihWzjyeVbz1fS/BASYfQ2t4vA4knncZR4QXyo1so=;
        b=caGPhippmsNoQcDBRd6p3ibBcZNdtfY3Vjm3aIYd+NcNOhMjKJaAvm6N437j18Qp+J
         1HCriscvl0+I9tahX/3i5bgVwb3LXzZcqh05h9RT/CpTVtN5XdSANEkHfYLe0G2BnPk3
         9iuuGpNR32/t4hqzckgxnvQXci041MnDJ8QFhJMxgQfjpCtVMI5npAVI8/G8U5zsRYFz
         YGiCeW//VIdmn5pDGSSmNzYklOIrAaAMN1KabXnZq8Eb1NeOr+2wG0yy5M/Cjit9udrS
         GSN/O7wppzDqwVo21No6Qe5X8tBWRIzthvFNCAm5heTH9kNsI9aqj1uIgsJFjZv1e0+n
         I7bg==
X-Forwarded-Encrypted: i=1; AKwUvBwsjylAonNze5/Bvv3zCSCJC6IkohLVGV2KyNmI7XpfliU/otgBB+IEF0PrenxVxac3gD9R+xntPjB72VCp@vger.kernel.org
X-Gm-Message-State: AFq9FYIsRCs7kFYN7yP/G8z9z/xXHCNS8vXdsu9hnMAX+2QcY6ExQv6l
	Vjf18BSJgYcAFI3bQW9WbcBPNYpkzYAnx/kxEgPKgo0lhIMEw/CUN6PnyrEtnk9rmA==
X-Gm-Gg: AYBFou39Zee1FNaVCaXTnKcSaP/UsA2XJeCUJi1kVPu9Okv6gmPuAQKKiUCIznrIGjK
	cE7/wqsP4DR+DrTHZo588MVWX4sI71q9pXmYH+x1sUNKtrbZuWAKvLXPJ+YowfbhVEUueR1ZPRC
	96yg47kpdOqscQ20mD5QJ1Ie6TOTwX/OdCzlDyyUICTCJuJ4rRsS5+Ol4kuZ5+Svx3bdc8JTEVQ
	qMB7h4RKV8bS9Au9vpbueecKDU1XSEnRlq06mJE1F8mMN+Id/jx8+73FeDwLuRafvxvLWNDkwVU
	Y2G8xLUBLStXyrLPXycgGcTfjxUhVGEB/rl9HlE4YlBxx4ohF1fDDfqR7Q+onDC6x1sGxNEQrNF
	P39OCnAXzZXu5/PGMIx8yzCnbUsm0T7S0PFDg9eTLTmNkgH4t755e3lF6w1HSKVb49RteQdumZg
	z2pJl7aOA+UrhCfogYblzCYeYU/1e+aMz/j/PO2SX6QZpy2jL21x+IyLRRzU5qUVRPpHv6QhCFd
	YUOmghFJ8ftsF9b6iWhEuA=
X-Received: by 2002:a05:620a:7110:b0:939:feee:630 with SMTP id af79cd13be357-93ebd24474bmr897615685a.30.1791655020077;
        Sat, 10 Oct 2026 10:57:00 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98861bdsm476732285a.24.2026.10.10.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 10:56:59 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Thomas Schmitt <scdbackup@gmx.net>,
	Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] isofs: Fix handling of directories with small logical blocks
Date: Sat, 10 Oct 2026 13:56:49 -0400
Message-ID: <20261010175649.700233-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b2eb2e288604 ("isofs: Drop support of directory entries
straddling blocks") made do_isofs_readdir() and isofs_find_entry()
reject a directory record that does not end in the block it begins in.

However, the block is the logical block of the volume, which can be 512
or 1024 bytes. ECMA-119 only requires a record to end in the 2048-byte
logical sector in which it begins, so a record can cross a logical
block. As of now, ls stops at the first such record and the files after
it cannot be opened.

The issue can be reproduced with an image that has 1024-byte logical
blocks and 40 files in its root directory:

    mount -t iso9660 -o loop,ro lbs1024.iso /mnt
    ls /mnt | wc -l

Before commit b2eb2e288604 ("isofs: Drop support of directory entries
straddling blocks"), the result is 40.

After that commit, the result is 19, and the kernel logs:

    iso9660: Corrupted directory entry in block 0 of inode 1152

This patch will put such a record together from its two blocks again,
but only when it ends in the logical sector in which it begins.

Fixes: b2eb2e288604 ("isofs: Drop support of directory entries straddling blocks")
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 fs/isofs/dir.c   | 22 +++++++++++++++++++++-
 fs/isofs/namei.c | 22 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 28741251d56e..c72cfb08707c 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -95,7 +95,9 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 	int map;
 	int first_de = 1;
 	char *p = NULL;		/* Quiet GCC */
+	u8 record[256];
 	struct iso_directory_record *de;
+	struct iso_directory_record *tmpde = (void *)record;
 	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
 
 	offset = ctx->pos & (bufsize - 1);
@@ -129,7 +131,25 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 		offset_saved = offset;
 		offset += de_len;
 
-		if (!isofs_dir_record_valid(de, offset_saved, bufsize)) {
+		/* A record may span blocks within a logical sector. */
+		if (offset > bufsize &&
+		    de_len <= ISOFS_BLOCK_SIZE -
+			      (ctx->pos & (ISOFS_BLOCK_SIZE - 1))) {
+			unsigned int slop = bufsize - offset_saved;
+
+			memcpy(tmpde, de, slop);
+			offset &= bufsize - 1;
+			block++;
+			brelse(bh);
+			bh = isofs_bread(inode, block);
+			if (!bh)
+				return -EIO;
+			memcpy((char *)tmpde + slop, bh->b_data, offset);
+			de = tmpde;
+		}
+
+		if (!isofs_dir_record_valid(de, de == tmpde ? 0 : offset_saved,
+					    de == tmpde ? de_len : bufsize)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %llu\n", block,
 			       inode->i_ino);
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 4fba1bf7f016..289efa60f3bf 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -54,6 +54,8 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 	unsigned char bufbits = ISOFS_BUFFER_BITS(dir);
 	unsigned long block, f_pos, offset, block_saved, offset_saved;
 	struct buffer_head *bh = NULL;
+	u8 record[256];
+	struct iso_directory_record *tmpde = (void *)record;
 	struct isofs_sb_info *sbi = ISOFS_SB(dir->i_sb);
 
 	if (!ISOFS_I(dir)->i_first_extent)
@@ -93,7 +95,25 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 		offset += de_len;
 		f_pos += de_len;
 
-		if (!isofs_dir_record_valid(de, offset_saved, bufsize)) {
+		/* A record may span blocks within a logical sector. */
+		if (offset > bufsize &&
+		    de_len <= ISOFS_BLOCK_SIZE -
+			      ((f_pos - de_len) & (ISOFS_BLOCK_SIZE - 1))) {
+			unsigned int slop = bufsize - offset_saved;
+
+			memcpy(tmpde, de, slop);
+			offset &= bufsize - 1;
+			block++;
+			brelse(bh);
+			bh = isofs_bread(dir, block);
+			if (!bh)
+				return 0;
+			memcpy((char *)tmpde + slop, bh->b_data, offset);
+			de = tmpde;
+		}
+
+		if (!isofs_dir_record_valid(de, de == tmpde ? 0 : offset_saved,
+					    de == tmpde ? de_len : bufsize)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %llu\n", block,
 			       dir->i_ino);
-- 
2.53.0

