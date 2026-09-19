Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362F397925
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856788; cv=none; b=Kv6bMn/IN4XRn/R669mOu2j+vds9Q6Gs/nGogmxpic1U7VnZbD0iW14G7jvWSAkwhJN+BP1bCPkOWA5glu6io/33RR5n+SibycqEJ6v52sz7QeInLcstRzRTv/wP3hOkNUCdkiTmcS/J3QXXlOPxZXEkRYlVSRnxYjkqnOH5Uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856788; c=relaxed/simple;
	bh=zR4t99CYAsLI0djHo2z8cz0yCPrSn67PlOAYDuXCYpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXpgBEHftEqxS3m3a870TAzeRA5sGb9YN6r8LJH0QFI+EimLeq7eeJSAgu1Bu69KGuUyqhwTWpnqwRqwg9waTLpx+29LZl4jnLI9MYpLWEUWKFGAopI46aEcwFALUsLo3kYJT1lS0FnaaiHNZbmMZV7KJhTZw7nHODbzlcqvw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1EbJvpA; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1EbJvpA"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ee1f38so18232825ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856782; x=1790461582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZibClg4eBO/Uuu2Z7cDjM1jfMqw59kTdM9Cu8D3vcV4=;
        b=K1EbJvpA7w5hrzmglx5fXfPq4VdGntEkuMY4f8huxZY1D+juB/ChQBBWTGOwh4BqrV
         v8JZylslDC/VppGKsdt9o1xkHYy3YhYXydteQ+b6iyUL1rs4m/ntaeS+gWj4xb+a6OcK
         /3UjIKU50Un0dSHUILymKtAXEIH42ce5B6ygbZ3OiSZDr9ImTqGa/CCwF9KpF4M0+tOb
         EufNbcnyTNxFaamWegwy4+p955B901zthH/jxvRvXHaNLE8HoI8K1bOwiBEHBUvmlLJt
         D7mvzAm1So3O/YtoUfKFQ2i/TJTsK+wcvKhctdyhTJmys9X2RTOfDX7nvxqgwatMbxUV
         EazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856782; x=1790461582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZibClg4eBO/Uuu2Z7cDjM1jfMqw59kTdM9Cu8D3vcV4=;
        b=0sOokP1tIy/zO3ZE9/lToUk9K1sAMlYNSRcdmTA+59ByZLaXsITTeiY8nbLtbU6UUv
         yQiemm3uvFXa6PUEA3ub/6b7bvangE6f6yvgzBpZMt2fkyJcUIQz1nZCAbAyRIprFNLV
         JA5bgOzK9UNFqAeMI8GFDzhv/giSLj6LmZGNtOg2G6gcOiIBNC124rhDZTcFWritOTO9
         CcLUWranAwNvgq2SZkj2p1+sqYI/8YAYAt2n1pvXYAokBJ9wfISDK+lun7dJUomMej0X
         PxrddPKdg9OZ+ORYB4nUq8CqtUdZwwkXaBR4oHuUEBeHRuegAhMxP/XjnxuYUK6w4gXn
         YU4Q==
X-Gm-Message-State: AFuF++kmx476m5NUuPji3EfzDjpOcjrnWHXu8UrZsNnsvc2dVztaqyWf
	BUOegppBOw1G+vzbUEHLvzSMQgCHWS3YRgu0JUL6kvybc7aiH1YpaPMn
X-Gm-Gg: AYBFou1gvO5SSf1c6Gqm+Tjb02gow/HwUggUVfhemA5cJbDHD3IV6MA+DSHXcql1/8l
	T2kPfHp/oLSMfM1CGad0REm6p5M3xgbkGGbP1Sb/fcIXUVOqDsL6apEDuSghvoETQpaorj30/Tl
	x3jndL/1ujvjUHD9O6Js2Z/mj1oLGr19uXWr8dIDUckAwQXY5eLjuTd8X6yZwe4mZ3O5e+LnzXH
	JsvbBuWXVALtpSwVGRgLb8HXBCw/GkTYu7J38iTqSzAX+2NFxqaZUfrzUdiZf/RWMtX8Kbo3IPa
	w0TzCNy4w86c/HJrXnO4KYMioBLVnxm4Ot0HMEwgSiqghOnonNeVdncetf8QbMEYwFfCIZdEK1y
	yL4M2mMEV4JNxHR/NWa04UILcBvJvx43jwDn+vyaj5yEsVV2srt9d9lHW2JQOc59tTDR4eVJQpO
	zdPHhvSvoWSRhiAhgAQKO6b1bRQHY51w6VDzRZrQwHwSbCMrIv8uc+2aFOALh9bJ5XTypMQ9CGZ
	TYUBJnA8sKEL5kPlniG+y6PQW4LrYnZUf56MxNGWxMhW/d1nLA2IXtpgW/etFzmt1N6yfcmmb5r
	f0zvHgodQQ==
X-Received: by 2002:a17:903:3def:b0:2dd:c053:e663 with SMTP id d9443c01a7336-2ddc053e67emr36745395ad.41.1789856782175;
        Sat, 19 Sep 2026 15:26:22 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17d7120sm13436875ad.63.2026.09.19.15.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:21 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] minix: validate s_imap_blocks and s_zmap_blocks in minix_check_superblock()
Date: Sat, 19 Sep 2026 22:26:21 +0000
Message-ID: <20260919222621.3796976-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In minix_check_superblock() and minix_fill_super() (fs/minix/inode.c),
verify that s_imap_blocks and s_zmap_blocks are large enough to cover
s_ninodes + 1 and s_zones, and check the return value of
sb_set_blocksize() to prevent out-of-bounds bitmap array reads in
minix_count_free_inodes() and minix_new_inode().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index daf83e4ff25c..b0857dfc1b46 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -185,15 +185,15 @@ static bool minix_check_superblock(struct super_block *sb)
 		return false;
 	}
 
-	if (sbi->s_ninodes < 1 || sbi->s_firstdatazone <= 4 ||
-	    sbi->s_firstdatazone >= sbi->s_nzones)
+	if (sbi->s_ninodes == 0 || sbi->s_ninodes == UINT_MAX ||
+	    sbi->s_firstdatazone <= 4 || sbi->s_firstdatazone >= sbi->s_nzones)
 		return false;
 
 	/* Apparently minix can create filesystems that allocate more blocks for
 	 * the bitmaps than needed.  We simply ignore that, but verify it didn't
 	 * create one with not enough blocks and bail out if so.
 	 */
-	block = minix_blocks_needed(sbi->s_ninodes, sb->s_blocksize);
+	block = minix_blocks_needed((u64)sbi->s_ninodes + 1, sb->s_blocksize);
 	if (sbi->s_imap_blocks < block) {
 		printk("MINIX-fs: file system does not have enough "
 		       "imap blocks allocated. Refusing to mount.\n");
@@ -201,7 +201,7 @@ static bool minix_check_superblock(struct super_block *sb)
 	}
 
 	block = minix_blocks_needed(
-			(sbi->s_nzones - sbi->s_firstdatazone + 1),
+			(u64)sbi->s_nzones - sbi->s_firstdatazone + 1,
 			sb->s_blocksize);
 	if (sbi->s_zmap_blocks < block) {
 		printk("MINIX-fs: file system does not have enough "
