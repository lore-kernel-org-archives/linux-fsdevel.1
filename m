Received: from mail-pj2-f36.google.com (mail-pj2-f36.google.com [74.125.227.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D9397E64
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856766; cv=none; b=gJ7OAeHBXCtLNArwjvKZdLGaRRHAE4rtIeQm3A22U4CBEi8Zvn0F6Ups558EWbwV6+zMd2MXld4uy5s3UDZ89b5fjd/KY76/oYmQAIIk69v2AWwx2RjMUkATYcWjL2sewHkYkhN+cvbcUVv9uhjxiC65qqRyLxW6ck3wa51Moak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856766; c=relaxed/simple;
	bh=yHNl/4IJ6nsQQQ6EYtG6mC3w0FiqfioxVKbK8K5+I4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWJet+rlODG7H3fzg/9nIx3NfbN8p4MYxfHv6Hd0yNyG62Iiu1YkbmVoxxEXUUm0620OHS5gdEklEU/ZI2VlkrMTI4uTLgQWopETysW1siuQDCANDN6r2Yq6k0dGPAUUCkQUjD1io5gowrZ26ZLUMHtoZvoDk+Pe33jgDiv07DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmiD+Pko; arc=none smtp.client-ip=74.125.227.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmiD+Pko"
Received: by mail-pj2-f36.google.com with SMTP id d9443c01a7336-2d8fdc579daso21160845ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856763; x=1790461563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/UPIak5OxXuaG2Wg2AMNeWBx/Ry+CMtx76AWFxbuw+M=;
        b=OmiD+Pko/NbZKsS2KZf8M6/yjtXxZJPrgltDU/bJihwjM6wZuxi5E4Q9omuTWWCwL4
         FYv75LBSuvl2u3gL3JMevUpHUq0alXyws453j4V5dD4ykR5tJtpWR237GGQlOLKtbBNr
         o1G6l9/KTwYr+74C9FsY2hM4kxxz/uUWez61+UAWMFsIh10oPqQSr9JHQ/WAVBMun0bU
         BzoqE9JQuWza++EGpBsNQ5jAfoYR5KyOvFFlV1aXnp7iDBpFRcCtHYDJ+NF2gn/tUSAs
         K9d2asPOJ0ssh+HY+39paP9X4bbJqBI4+rkAcBcmoc5kyqltwgio42N4+BTsFLFJ1HmA
         fIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856763; x=1790461563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/UPIak5OxXuaG2Wg2AMNeWBx/Ry+CMtx76AWFxbuw+M=;
        b=fMh54FkpucV3GpzW/n1fEmwGWzrNIMRAc1fDa19Wym3izHe7lyqrqKh1PnCixlbxpj
         2i3n6tvquvpc5zWvpw2fkYc5JB4JmOFbZzIcJMFWpmFidR0t0WXD3fKtOTZ8i6Ia9REC
         AKi4J3VWRg3kjme6uJhUYS0XIZB/wkIRUO7H2IaoG5jbqeMU5+QnM+kxJYmplbo7rrh6
         VEgW+RbV6Bjle5hTKNNEttPVQTlKiqenaZ5+eQSOg8Db/EPhqfsgJtUNDp4RplDXqdwx
         Vo5VzSAwyi4ryA2TlLLxnSwfnkZuFTs5kFr3qIwrIv3tMp86dzJ6HVZmdGUckJcbJhEo
         hSiw==
X-Gm-Message-State: AFuF++lIMUfgrO8Jvb+GMeo8+QXqv6fDrUZictyI6w/U7t0l9HelKGaI
	QR/wuA1dRpfQHjBmOn+FzwE1Xlr5yD7v5DzlHnyqwjh/wR+79rJ0XkWD
X-Gm-Gg: AYBFou2o1Di3H7zACBYAwKrwuI1fV/nXbDJWKvQ2y181bqqPdsmszlnoebxYSO2Plq1
	/U7QiY3IR7r0oJd/BVlizLcu/ntj3hlu1E0LsADFaojDm4y8G6+DgCryOYqIiUobj8G4hI69U4E
	iQMuf2E6Lh2Cxrjta3jvIxE09Bzq6czhaInGkBh9XnhTBljXthNAT2Em/SD1v+dkxHFsg7mkEZt
	i+pYabeNki5uOqw6Stxe4ILIoT+ucBunq0Xt7fp/7rqlWOQpCX6upVDW0BNE0IdgsLlDRhZOmpu
	0MVXDH/NDgfmEdT3Y001gthFdF0GkSfwX2HTy5fUPrSDQ5HsWzxj2Tsp3pt+TpG0F23WVw7+uSE
	JNU1T+5HYZ0bSrHhqan6VD983q/VkOWzuasUb1VVn8jYIJlHGvjf5jfepU175d470Mh5iEP4GsA
	8lcTijj0Cjv83R+OCfpjMvgaEFzYhd6dQExJZTwt+w8xi6sPFDnr77ZyVXACpXFGVsEYEs0LXBc
	mCm7VZY0yZdzTmsB1W9x2Ij8hrrfrnkVQ3U6mdcvNUZimpG2OZPGBMFme3LwkrGCs421W7qTcO6
	NvokxWOeKw==
X-Received: by 2002:a17:903:2a8f:b0:2d9:1dee:43db with SMTP id d9443c01a7336-2ddb1b7ac15mr113040235ad.15.1789856762699;
        Sat, 19 Sep 2026 15:26:02 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc178701csm12946375ad.13.2026.09.19.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:02 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	kees@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] adfs: validate zone map parameters and clamp dm_endbit in adfs_map_layout()
Date: Sat, 19 Sep 2026 22:26:01 +0000
Message-ID: <20260919222601.3793825-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fs/adfs/map.c and fs/adfs/super.c, validate nzones and zone_spare on
mount to prevent divide-by-zero in adfs_map_lookup() and adfs_statfs(),
and clamp dm_endbit / map offsets to the underlying buffer_head block
size in adfs_map_layout(), lookup_zone(), and scan_free_map().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 9d535a2ca2d1..6ca7ebf22388 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -68,17 +68,25 @@ static DEFINE_RWLOCK(adfs_map_lock);
 static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
 		       const u32 frag_id, unsigned int *offset)
 {
-	const unsigned int endbit = dm->dm_endbit;
+	const unsigned int max_endbit = dm->dm_bh->b_size * 8;
+	const unsigned int endbit = min(dm->dm_endbit, max_endbit);
 	const u32 idmask = (1 << idlen) - 1;
 	unsigned char *map = dm->dm_bh->b_data;
 	unsigned int start = dm->dm_startbit;
-	unsigned int freelink, fragend;
-	u32 frag;
+	unsigned int freelink, fragend = 0;
+	u32 frag = 0;
+
+	if (8 + idlen >= endbit || (8 >> 3) + 4 > dm->dm_bh->b_size)
+		goto error;
 
 	frag = GET_FRAG_ID(map, 8, idmask & 0x7fff);
 	freelink = frag ? 8 + frag : 0;
 
 	do {
+		if (start + idlen >= endbit ||
+		    (start >> 3) + 4 > dm->dm_bh->b_size)
+			goto error;
+
 		frag = GET_FRAG_ID(map, start, idmask);
 
 		fragend = find_next_bit_le(map, endbit, start + idlen);
@@ -114,15 +122,19 @@ static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
 static unsigned int
 scan_free_map(struct adfs_sb_info *asb, struct adfs_discmap *dm)
 {
-	const unsigned int endbit = dm->dm_endbit;
+	const unsigned int max_endbit = dm->dm_bh->b_size * 8;
+	const unsigned int endbit = min(dm->dm_endbit, max_endbit);
 	const unsigned int idlen  = asb->s_idlen;
 	const unsigned int frag_idlen = idlen <= 15 ? idlen : 15;
 	const u32 idmask = (1 << frag_idlen) - 1;
 	unsigned char *map = dm->dm_bh->b_data;
-	unsigned int start = 8, fragend;
+	unsigned int start = 8, fragend = 0;
 	u32 frag;
 	unsigned long total = 0;
 
+	if (start + idlen >= endbit || (start >> 3) + 4 > dm->dm_bh->b_size)
+		goto error;
+
 	/*
 	 * get fragment id
 	 */
@@ -137,6 +149,9 @@ scan_free_map(struct adfs_sb_info *asb, struct adfs_discmap *dm)
 
 	do {
 		start += frag;
+		if (start + idlen >= endbit ||
+		    (start >> 3) + 4 > dm->dm_bh->b_size)
+			goto error;
 
 		frag = GET_FRAG_ID(map, start, idmask);
 
@@ -310,9 +325,12 @@ static void adfs_map_layout(struct adfs_discmap *dm, unsigned int nzones,
 			    struct adfs_discrecord *dr)
 {
 	unsigned int zone, zone_size;
+	unsigned int max_endbit = 8U << dr->log2secsize;
 	u64 size;
 
-	zone_size = (8 << dr->log2secsize) - le16_to_cpu(dr->zone_spare);
+	zone_size = max_endbit - le16_to_cpu(dr->zone_spare);
+	if (32 + zone_size > max_endbit)
+		zone_size = max_endbit - 32;
 
 	dm[0].dm_bh       = NULL;
 	dm[0].dm_startblk = 0;
@@ -327,7 +345,13 @@ static void adfs_map_layout(struct adfs_discmap *dm, unsigned int nzones,
 	}
 
 	size = adfs_disc_size(dr) >> dr->log2bpmb;
-	size -= (nzones - 1) * zone_size - ADFS_DR_SIZE_BITS;
+	size += ADFS_DR_SIZE_BITS;
+	if (size > (u64)(nzones - 1) * zone_size)
+		size -= (u64)(nzones - 1) * zone_size;
+	else
+		size = 0;
+	if (size > zone_size)
+		size = zone_size;
 	dm[nzones - 1].dm_endbit = 32 + size;
 }
 
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 888aa81a6b39..5b570a4769da 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -87,6 +87,16 @@ static int adfs_checkdiscrecord(struct adfs_discrecord *dr)
 		if (dr->unused52[i] != 0)
 			return 1;
 
+	/* At least one zone and one allocation ID per zone are required */
+	if (!dr->nzones && !dr->nzones_high)
+		return 1;
+	if (le16_to_cpu(dr->zone_spare) < 32 ||
+	    le16_to_cpu(dr->zone_spare) >= (8U << dr->log2secsize))
+		return 1;
+	if (((1U << dr->log2secsize) * 8 - le16_to_cpu(dr->zone_spare)) <
+	    (dr->idlen + 1))
+		return 1;
+
 	return 0;
 }
 
@@ -181,7 +191,8 @@ static int adfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_type    = ADFS_SUPER_MAGIC;
 	buf->f_namelen = sbi->s_namelen;
 	buf->f_bsize   = sb->s_blocksize;
-	buf->f_ffree   = (long)(buf->f_bfree * buf->f_files) / (long)buf->f_blocks;
+	buf->f_ffree   = buf->f_blocks ?
+			 (long)(buf->f_bfree * buf->f_files) / (long)buf->f_blocks : 0;
 	buf->f_fsid    = u64_to_fsid(id);
 
 	return 0;
