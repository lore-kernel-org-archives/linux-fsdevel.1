Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003C2DCBFA
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856763; cv=none; b=SnEomi9BFzXfYw+ariXobT/DEN2paMXsrsx3BOq1MilLVDoI1O895mF6kZif7U5jZhXvKAKCt3mhQTjsNBmFm8DrzucZduMkcrnRqJe6z2keVTtXLcvIxX/dF0zjYAIDAy/5HikpnHaqtW3Tu8S8zqIcXcttlP+yCYQNNW6eno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856763; c=relaxed/simple;
	bh=60mSr7VmLncSpBLK0V49HhhYVT+MiALOWI330LNHscA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpjneoyosvpKfA6v698HwejAe75aHnrqqdrkXj7t655eg/Cm67vTG+Y9CCN/cU3kaJLuzB4aEmGCGf7LyuYoACmCltcKoO8U4SyjDXmTdzyZCpkPKukydCHCsTASkWCRmF9kW3M01GcMajj5vohWK1Odr8Ja42V8eAo2nGrcNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHPHE1yF; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHPHE1yF"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so645305b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856759; x=1790461559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cFtD2Fqt5nkn8b39jheUImgKcDaYIWTzHGAKFQwaEGE=;
        b=RHPHE1yFP1wo/rAUf3rCMOtmb02CgbFjC2Do+fVDuQiTIdaCPxEZ9OG30o5Ykzr+jG
         lar/jHUZOcoViCoVwvwkZcJX9OE+4rmcDnJlarxolXDz7GNKmv14EUJmqvrJkdXlGbAJ
         4RaRVJ4ZMnwdkpuTSlKNGH+6PtFGxTh4SBwOjzymy4ACEfnROuFmCnm5b/AiJ6kNCJN4
         8df5wv8255EPwRABMz+hmR5ubGjTCGD9qKpoX6S+GJaz6sfeJBbTNxinzudYO+5O3iYq
         x/M7e5zY5XHtds6lWFd7HrmCyynbup9poupldFG+qZUB1hkZXuF6SjmOwyXRpMgBR6pv
         BHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856759; x=1790461559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFtD2Fqt5nkn8b39jheUImgKcDaYIWTzHGAKFQwaEGE=;
        b=e3KwfuS3TFJMbFSHfOV0JXrvyRB5VJ8cGUegsxcB8Dxj2Va7gO8S3ij5L8xYoqBBla
         kttlDtv4kqy0/AWlWJHm1Yt/HuAe1GrhF+4yVT5fX7tB8blzU5YKMP5spv9nlYqBI+5L
         c9UPRcAsF9taew3xCeTkO9wvRvmrfjowFKvTrg1Z+Q5TZZvm15rwRdAaVzb9UZ5JR8Ta
         eRqJb6s+a7s/WEZk8PDmedHPHQCLG6jab0t8VgcDMgosyBI70P3U86kl5aa9swtoB7bI
         nAeSv48tGzhsRey3WqkrxcOSMKaPApSNBHceuZBattMTdXDSlfVfpkYDhZfxwZGnrymI
         Idng==
X-Gm-Message-State: AFuF++nsohiZQVSzHoSLjt/2DH2CeGwGkDcKN9Ad8aNXjdHQCtC77khO
	GmRSmep5HKD3Ipp7ZXpm4DTcS1gUixCnvktRfak2QPVl+09KnTFjiiaK
X-Gm-Gg: AYBFou0euldsSTlY/oSLVUGXonXRsOA1Bdk4wyrSxGTv/rY2iYgWVaCsWYy2mVpsoRe
	P6vtw9H8w5iJw514hPzaHDhWJTI8R4XlZTVJGrxmNC7zLbReHzv5yZa/RYVnTW0CHAiA5/DvhfS
	bU43tR9/ORM0DhYp09b7V2y4GS6YTcef5VgEioNINxKZln8kBZqqFdJk//6apptJsbxdzxjiiGD
	kT5InViUyUjAKO55lrkpRmRmSPS3qs+R01g7V+WS4XbPMvFnfoH0vfwrYbSpRp3+uBLnWNkDhrr
	Nl35j5EVfIJsucw2sPTWyFzOHW1B6enGf0s8vJ2aZwZTp+E9J4zcJ5B1nIQjWwDyhnxxqntAFn/
	sPQIeQfAy++xwF5cA5MEp7Tx+uvPvFeqZ0QIExGG3Ptz7m1ilMvlULBSKYCF0a7qhDmw1VYYUbw
	JRjNXBezJSbaeupzCWaZUOAzyvMXasNCP41u5A1QQXFs1sR5OSSguM7nmmHC8m82gme/ORDiA85
	J9wOM02OIc/0Yu83N83v1/Wk0BXygsGJrQ4ygs0pOneuC5NcbZ1P00AjjqXxGDUnwUX4yBUc9TU
	J1L83lao6w==
X-Received: by 2002:a05:6a21:9086:b0:3dd:a196:ffd1 with SMTP id adf61e73a8af0-3dda1970073mr3971679637.33.1789856759099;
        Sat, 19 Sep 2026 15:25:59 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aefc0a6sm1360139a12.28.2026.09.19.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:25:58 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: fix cylinder structures slab-OOB write, div-by-zero, and error cleanup
Date: Sat, 19 Sep 2026 22:25:57 +0000
Message-ID: <20260919222558.3792924-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three superblock validation bugs in fs/ufs/super.c:

1. In ufs_read_cylinder_structures(), allocate u_space according to the
   actual cylinder group summary size and bounds-check s_ncg and
   s_cssize to prevent a 1024..4096-byte memcpy into a kmalloc-16
   buffer.
2. In ufs_fill_super(), validate uspi->s_inopf, uspi->s_ipg, and
   uspi->s_fpg against zero to prevent hardware divide-by-zero (#DE)
   traps.
3. On the ufs_fill_super() failure path after d_make_root(), clear or
   avoid leaving sb->s_root populated when sbi is freed so
   ufs_put_super() does not dereference NULL sb->s_fs_info.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b065..7d2eb3cbdcf0 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -455,7 +455,7 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 {
 	struct ufs_sb_info *sbi = UFS_SB(sb);
 	struct ufs_sb_private_info *uspi = sbi->s_uspi;
-	unsigned char * base, * space;
+	unsigned char *base = NULL, *space;
 	unsigned size, blks, i;
 
 	UFSD("ENTER\n");
@@ -465,17 +465,21 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 	 * on the device. 
 	 */
 	size = uspi->s_cssize;
+	if (!size || size < (size_t)uspi->s_ncg * sizeof(struct ufs_csum))
+		goto failed;
 	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
 	base = space = kmalloc(size, GFP_NOFS);
 	if (!base)
 		goto failed; 
 	sbi->s_csp = (struct ufs_csum *)space;
 	for (i = 0; i < blks; i++) {
+		size_t copy_len = min_t(size_t, size - (space - base),
+					uspi->s_fsize);
 		struct buffer_head *bh = sb_bread(sb, uspi->s_csaddr + i);
 		if (!bh)
 			goto failed;
-		memcpy(space, bh->b_data, uspi->s_fsize);
-		space += uspi->s_fsize;
+		memcpy(space, bh->b_data, copy_len);
+		space += copy_len;
 		brelse (bh);
 	}
 
@@ -595,15 +599,19 @@ static void ufs_put_super_internal(struct super_block *sb)
 	size = uspi->s_cssize;
 	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
 	base = space = (char*) sbi->s_csp;
-	for (i = 0; i < blks; i++, space += uspi->s_fsize) {
+	for (i = 0; i < blks; i++) {
+		size_t copy_len = min_t(size_t, size - (space - base),
+					uspi->s_fsize);
 		struct buffer_head *bh = sb_bread(sb, uspi->s_csaddr + i);
 
 		if (unlikely(!bh)) { // better than an oops...
 			ufs_panic(sb, __func__,
 				"can't write part of cylinder group summary");
+			space += copy_len;
 			continue;
 		}
-		memcpy(bh->b_data, space, uspi->s_fsize);
+		memcpy(bh->b_data, space, copy_len);
+		space += copy_len;
 		mark_buffer_dirty(bh);
 		brelse(bh);
 	}
@@ -1179,6 +1187,11 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	uspi->s_nspfshift = uspi->s_fshift - UFS_SECTOR_BITS;
 	uspi->s_nspb = uspi->s_nspf << uspi->s_fpbshift;
 	uspi->s_inopf = uspi->s_inopb >> uspi->s_fpbshift;
+	if (!uspi->s_inopf || !uspi->s_ipg) {
+		ufs_error(sb, __func__, "invalid fs_inopb (%u) or fs_ipg (%u)\n",
+			  uspi->s_inopb, uspi->s_ipg);
+		goto failed;
+	}
 	uspi->s_bpf = uspi->s_fsize << 3;
 	uspi->s_bpfshift = uspi->s_fshift + 3;
 	uspi->s_bpfmask = uspi->s_bpf - 1;
@@ -1211,18 +1224,23 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ufs_iget(sb, UFS_ROOTINO);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-		goto failed;
+		goto failed_put_cyl;
 	}
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root) {
 		ret = -ENOMEM;
-		goto failed;
+		goto failed_put_cyl;
 	}
 
 	UFSD("EXIT\n");
 	return 0;
 
+failed_put_cyl:
+	if (!sb_rdonly(sb))
+		ufs_put_super_internal(sb);
 failed:
+	dput(sb->s_root);
+	sb->s_root = NULL;
 	if (ubh)
 		ubh_brelse_uspi (uspi);
 	kfree (uspi);
