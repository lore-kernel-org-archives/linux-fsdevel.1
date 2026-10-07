Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1944CF44
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371662; cv=none; b=nQBsg2Wta6tFgkw2jZdyrgBOr4rA83FYgU+BaBqu1B9BwyxgHaZHOJ4f/Fp9GBLZxpQcOi36EmADDU3nPGTcD4OMtaLzb5h+8KDRAC0/eW+40STkhRlb2vsHw8KeNmLRDMAsW4VRBDHt82fm/RiWz+snwtauJrda/hAZVmj/Ung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371662; c=relaxed/simple;
	bh=HloGoohqo9+6qwLBupkuzMvPAMn3qCrX+PSht8NQWyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSY4FKmAJH54Xa8E65gIhZglqLW2pZ/fcQ/E2Y9T5gXWv6V0SiJAzLaLA0v8ZoAF9iTLfvogYG4VdxfO6u09B/6Yo3uuczOvbaqXuomNulLbrOgvPqchrTF+1scw2S+ncfHpmPwogssskW+ocjkQcGjKxorVHG6hd1jG2f/M/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZcYtFiU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZcYtFiU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so15091225e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791371644; x=1791976444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vxn570AQqBee7ldTTj5CXNnDnojlRV1rnmN7nN7a9vQ=;
        b=YZcYtFiUPXQCLSGH/nWXc9cyiAM8NX0omw9Zmwf/JkIdE9UOx9/oT6NI67v3/Tzi1y
         B1BnrzE0CC5GqIWX1k9JwqRq+A0WoifCOODfwmIdWFVChjiOLAuuFMInFub49GWz3ozR
         9fPXIyekCjSPxo3NW5reXQHZFFRA8DnuaCQjUtpKQA4AK92GwegPgaUAyi6cFtf3g3MB
         ZBEnM5AyApW5zgDFxMYzwWrMCfCV9tFC+ZDTuLgSqMx0PQz1kXmxou4xUNwDNN+XpD5m
         cqJVmXO50N1d7KlttvdUuLFyfzCsqbH3zbKTct5LMyARye4j/D5poBWZw8cayk4h9diZ
         WF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791371644; x=1791976444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vxn570AQqBee7ldTTj5CXNnDnojlRV1rnmN7nN7a9vQ=;
        b=0IQfqAszLrHOrZkQ3091he5yTsWdpCjhmScBUha/Sz+U5i/GgfX65ghSkVAOsAztP2
         3sxxte8Mw1RUbPDFXfjpcrQmkXVeB/b7KwtOU1EM2v0GgtVTgS37pYc/87mBWga03Cvw
         wKXAqgdbl3dLkWN5E+0UrvpJ2E7GFSyIyqJQ5/6iLvjUrfUNbV5L0UwMklfsE414nCSp
         QGcalkE4TiRofnWoeigHhMmQGaBkx8AOq2Tj6ECyJg6lTcaQaCH0hisaMTEU8QXyVVpr
         k3JXcygY0CJEMPSD8IrSTh+vnf9LA3GvUTHCaopjpLE6M+8sYq//di8qptLH3tCMHm8r
         EExw==
X-Gm-Message-State: AFuF++mHls5RWGViehl1ONAXHUDpWeTahK1/XrtrbM26UiiG1rWcdOys
	fNOCT0vGmZNIY4yQkRX+9H8axbJcp912LLMQBs+gW8f+8NfCsj3H8jvU
X-Gm-Gg: AYBFou2kVeQnGhcGfLQlAVa6W+vE67WdT4Je9W7CuT2Ihc1AfLYPkFWP+JuP+VP3AsL
	MGaPXbSCAuOGOxQOzWnPBh3pRl5eo/Aafz5Ou7BWNNUyjzxYJfhrCj9IlPmfw0y9KWpVajasPLp
	WYXIkyouE9lpjUxN1YSX/xKIeEsQfnabDWb/2S83BK0oKMPy+7C25bZd9PSevxR9tXGanIUzQ4a
	nO+jSY01VGQm3bAoG8OCl3l2DOV/RPPpGLVRGxOUMNMH0yLaLJXITI/IQF7Cy8Xwby93DE4zA4t
	zmoHH1SH0j8n/6WKtclLwv1tACDaHotJ/dj3ydiZy9t4aDPGLRcABD6LxQWtsMQrCGfrhoxjvdH
	BZBV2aq86mMQpiuowoueNCDqKz/0ix8Eok2HIq/TLWi9GFypBbYBHXv+mV2Xv2ski8HkkFw/y8c
	UyAWwsC6TexkUh9qS9+TxAhjZswB5xzVVW57ktm+MTo9qQtRptFAJ6hfYY6YPePS+l3SsFeyj+8
	AQUG4O+
X-Received: by 2002:a05:600c:3155:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a180310d43mr26689985e9.12.1791371644352;
        Wed, 07 Oct 2026 04:14:04 -0700 (PDT)
Received: from fedora.domain.name ([217.218.152.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71c0b7f4sm4958213f8f.17.2026.10.07.04.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:14:03 -0700 (PDT)
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Subject: [PATCH] fs/ufs: use flexible-array members in on-disk structs
Date: Wed,  7 Oct 2026 14:43:52 +0330
Message-ID: <20261007111352.81417-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace one-element arrays with flexible-array members in the UFS
on-disk structures ufs_cylinder_group, ufs_old_cylinder_group, and
ufs_super_block_third.

Zero-length and one-element arrays are deprecated; the preferred
mechanism for such trailing arrays is an empty square bracket array.

All three fields are the last member of their struct, so their
offset within the struct is unchanged. The accessor macros in
ufs_fs.h and the field layout on disk continue to work identically.
No functional change.

Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
 fs/ufs/ufs_fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
index b8dc354ae..6c0493d69 100644
--- a/fs/ufs/ufs_fs.h
+++ b/fs/ufs/ufs_fs.h
@@ -571,7 +571,7 @@ struct	ufs_cylinder_group {
 		} cg_u2;
 		__fs32	cg_sparecon[16];	/* reserved for future use */
 	} cg_u;
-	__u8	cg_space[1];		/* space for cylinder group maps */
+	__u8	cg_space[];		/* space for cylinder group maps */
 /* actually longer */
 };
 
@@ -593,7 +593,7 @@ struct ufs_old_cylinder_group {
 	__fs16	cg_b[32][8];		/* positions of free blocks */
 	__u8	cg_iused[256];		/* used inode map */
 	__fs32	cg_magic;		/* magic number */
-	__u8	cg_free[1];		/* free block map */
+	__u8	cg_free[];		/* free block map */
 /* actually longer */
 };
 
@@ -952,7 +952,7 @@ struct ufs_super_block_third {
 	__fs32	fs_postbloff;
 	__fs32	fs_rotbloff;
 	__fs32	fs_magic;
-	__u8	fs_space[1];
+	__u8	fs_space[];
 };
 
 #endif /* __LINUX_UFS_FS_H */
-- 
2.55.0

