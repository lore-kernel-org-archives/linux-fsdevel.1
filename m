Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306156;
	b=KQqGsMMVXPbQ8UeFShtJFvJqVLDqVHBSQrbfFJ6Ue8w4jxQ5uq50D5nvG3Tb0937i32L
	 9g4KL1OrWUFX270W/30LZlTjU3XN91HolSLssznU8zqsUwBxas/Hs+bB/uIOHdux+uL+7
	 aJiz8bUD5paQxhmJ+xpu6iogJs2Oh/geFynRH5MMh21Iy0z8vBmSUyU3dq/uaupKU9Gh9
	 iR2w9aYb+1hqmZh/XTx4vGVk2jyRCZlpZ//Bo/pvxUPs7WMPQC4iELUIwB2BVg5kg0Srw
	 l698LZ8Qn14ta4TFMoxSqSqchlUh/DSgXU8oXghSkD6r0N+8Z0ggK/VRQbIvwls0pRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I3/a3+7dsQvjvECUWVZ/SwOHlfbc32z4n2+Zae+M7DI=;
	b=k55B8eqigfxcW3rNp/CFjSfwQYdvLpBrIjmElbXUMBy6JYPgaDlje7o3kzSmPCzAiVQT
	 biZmwnITxP6Om7Li0Lz/1vKFKSvsc0NLK2UACLBSuVc3S5PU5My6eaBXAO9UAFxNDLNAp
	 yKpSIikh9ZeVys09SE7yWtVV4XFvfTbVjYjj8jWFTrllnWpskRybLL3nOkx+okq5UTGNe
	 ExBhzS6it40GIQzgDKqchjOZKlyUJKAW5DcZ8jv2Gm2ulq5Avci+hjlPCjEteXBfjXvjH
	 9mVAodTHSSGa687rZbvihpF5p9XnUcspRchimSsRCyonKFe8Wr66zKBZw2C9IsDxvMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pxx4MEVM;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93D606A691
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 00:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F93D606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pxx4MEVM
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2035309f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 16:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795306155; x=1795910955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I3/a3+7dsQvjvECUWVZ/SwOHlfbc32z4n2+Zae+M7DI=;
        b=pxx4MEVM3F9ewoA+cmrYZ5iJ7GG66cT5YEMw/9bSw+32AQdbNaeyaZM+3JoC/dwApz
         UTXTyt2hP1yxywMm4hNVJePOeGz0MGnOqeDT59BoZmGM0iHtv3qvQDqcKJ75ZctYftXA
         kPEmslanb0UMiXCiyaAj65FLQcg9cH55lzNF2rhCJTB0VVD4RlJR8bfx34szlVVEKDaC
         /SQf4GCr0GacL1gTvq3QehD9mb/pXaJT0DU0oIq9fiin+wEYVcS/rJt2xmbLSEz1RYGY
         zZWz6FecCb/clp9mCPrinCaau+nYvOhVOjDICs76X+KNwZWPsk1GaY5WrM54lZtPqKFa
         teuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795306155; x=1795910955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I3/a3+7dsQvjvECUWVZ/SwOHlfbc32z4n2+Zae+M7DI=;
        b=pcI1NzSt3Q5CErU/crbCzPs6YTCZMSLKMKfYnMj7Lx9anx9jwP7eTqb1ua59k2hL+j
         DlBg+qk0s+8d5YiPBsP4wrhbSluLiC8fc9TnjC3yec+3yb1GW/1iQzaDir4IjLbhqfRv
         vyEalsy2Z6vVWGziRGTGAqbi29IX7QupmVcaIlHPrF9EwBvMyjWysEMbr9VXsnnHc0Qe
         P26f0qO1Gzv8bkdhOPVqiNy01aXONoEiDyu16JS8+FpYiEpjAylPXnUXcXXAiMH6ctAs
         YWBKZCeBKpUIsW8vKtks4McUgwfA8x2QG0jjte0p7MpOVojTXVru2xi7AKX1Kn0a3Ggc
         MZFQ==
X-Forwarded-Encrypted: i=1; AL+hErFyXIyWbSHAjN/s0kuoT01qPmGUqDl2Tww5AWTxCAbYT7EhdKbI47hc3vpFkP0dnHRP0tFChit8ZPUtwqKM@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ucv6+gzMo4L1zN+vlyZQNbfpwShFwzcmEUlQM9IzSD7YAUHEg
	rSFYOKnP3j7lvNfpcKV0SMifLTEjLHqfckvGtgizWPkWsSRcdHX8aTCc
X-Gm-Gg: AZFdTZeUzuEi6fnHMOtp2u+56aMG/Y3yQkLxIy6XrmEbt7MgIcxeDzYlTWgx3+9Z6rD
	N1AHlm4KjJPXRA65Jb609hE8jCnohwV6kcoPb3ldGwF6460Xd1B7WbKQggjqsCf/AhG132XhP0D
	vL9R1kgVTvHcZTZyjMv+jH1DfZ8whwi0AP3PtEOo4xiBnV4LH6r1ELze1rpSqrwPQ5GG0gCkHI1
	I+LqZUwu632AprtoKKfVzCgcSL45kVtig+E1kFLlsB6Uj80DvXkxSH9xFK+qODVga43htwidp4Y
	nGnYxRIgDzuNNEjE+rOByOBw7gm5RR2doVYuPh2HQ0B4U0iTR/xNgHjO133ksYfVCPy4aWwjEjc
	HbQwYvK6qqkC0za8g9f/joSn1YZEMffuoWPQ1FT124F8ka2dL6yTt7YbaWsDibNTjlCQHFlVaJS
	2WE+H0J+3G3xywyLNSavG0sOXrRIzAD1U+Lvl3h6YcLk5W5dtRufXfMeP5/apYTzpqEXWkOgELK
	5uy7MLHUlxD9v48It1xrEy39utzGhOsx67NFSdL6/p/hXFYQLU8dFg3xXHpj/2/5b/c6dsonQiM
	La1NHGyRD7pV10/vj3Kxf7ZVAH5zz4UC/mo5rzFCqsXrbA==
X-Received: by 2002:a5d:5f4c:0:b0:48e:5d33:da5c with SMTP id ffacd0b85a97d-4abad5aca65mr14743143f8f.1.1795306154599;
        Sat, 21 Nov 2026 16:09:14 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab5ffcad11sm13461872f8f.0.2026.11.21.16.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:09:13 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lauri Gates <lauri.gates@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <dgc@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ntfs@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [PATCH 1/3] vfs: use goto out on error in vfs_fileattr_set()
Date: Sun, 22 Nov 2026 01:08:54 +0100
Message-ID: <20261122000856.536902-2-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122000856.536902-1-koray.fra@gmail.com>
References: <20261122000856.536902-1-koray.fra@gmail.com>
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

Switch from using if (!err) { ... } to the cleaner if (err) goto out;
in the main body of vfs_fileattr_set().

Signed-off-by: koraynilay <koray.fra@gmail.com>
---
 fs/file_attr.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 833e03810b24..40d6518f1d8e 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -285,30 +285,31 @@ int vfs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
 
 	inode_lock(inode);
 	err = vfs_fileattr_get(dentry, &old_ma);
-	if (!err) {
-		/* initialize missing bits from old_ma */
-		if (fa->flags_valid) {
-			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
-			fa->fsx_extsize = old_ma.fsx_extsize;
-			fa->fsx_nextents = old_ma.fsx_nextents;
-			fa->fsx_projid = old_ma.fsx_projid;
-			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
-		} else {
-			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
-		}
-
-		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (err)
-			goto out;
-		err = security_inode_file_setattr(dentry, fa);
-		if (err)
-			goto out;
-		err = inode->i_op->fileattr_set(idmap, dentry, fa);
-		if (err)
-			goto out;
-		fsnotify_xattr(dentry);
+	if (err)
+		goto out;
+
+	/* initialize missing bits from old_ma */
+	if (fa->flags_valid) {
+		fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
+		fa->fsx_extsize = old_ma.fsx_extsize;
+		fa->fsx_nextents = old_ma.fsx_nextents;
+		fa->fsx_projid = old_ma.fsx_projid;
+		fa->fsx_cowextsize = old_ma.fsx_cowextsize;
+	} else {
+		fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 	}
 
+	err = fileattr_set_prepare(inode, &old_ma, fa);
+	if (err)
+		goto out;
+	err = security_inode_file_setattr(dentry, fa);
+	if (err)
+		goto out;
+	err = inode->i_op->fileattr_set(idmap, dentry, fa);
+	if (err)
+		goto out;
+	fsnotify_xattr(dentry);
+
 out:
 	inode_unlock(inode);
 	return err;
-- 
2.56.0

