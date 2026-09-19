Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55B37F011
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841404; cv=none; b=BsIZWLvIf4ak/beY1aKROKIf9GRhZ0WqsqasR/EdWQpV/wwGezRjAVc8QRUCJA9QYQjrpnR8VphbuvhyEfMkrnuNjHLcf9XYkTbXkJn07Gvh8uKDy1RkpolqoYQTHB1lY+jhHu9AGlI6bi/MDHARwO89UiYvPuaA72CuKoG5bEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841404; c=relaxed/simple;
	bh=9fga065swnGZFhkxLqcDw2eL9TSjYMuP6kGkdbXxN1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYDWZQX8kfdq+5Q7CxzjYL+E/gblgVQIhkzqZWKSWtzXUh+Fe8WIbHBUnDTkQ2oaOOYWvGIc31cWtG0Ef/Q3cKOnCF3QGI3PnsOpTB5iz8FVFKSAJ2djorh5Q2SQCYl7X7a99H71P1SEjJgmoJ+UFWtpzAoeOSsGSyjgprXIdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVJUp/G2; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVJUp/G2"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469a34907so1983082b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 11:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789841402; x=1790446202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEqihKQUEKRrqjsohNMETPXFyalbXU71edcLsvmgqxw=;
        b=FVJUp/G2g3dEpsJDInplThwjBYeDIuVHEWkIG5HG6SkvxQRGsZSrG+u6rvU9x51uBp
         ljp9o+RePArVBYqymg4vpldo8YvCRoE8mykk6N+wt1dspSowD6ONLIIG5IaxlO6tW+++
         Uwd543kHq1pWgTx4K9hwRX8mz58B5WhIdTd8ju8TV04/nQLDrC3lYynrXg8C9aQ5QhA4
         90opTG8EBZtxAygnqGGPJglYlk0MFWPG774/LHGBUjLik/kMKBcg0afNJQIVZfB0N/S7
         /UVcDyW2ql+j1JvpIV+kuck1iUpnTp/1dKM2qqtQx3qfHmrVPwYxGLvH+F2V5FFowTaY
         sjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841402; x=1790446202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEqihKQUEKRrqjsohNMETPXFyalbXU71edcLsvmgqxw=;
        b=B3lvf7njfajwCKiaGJJl/i6giMkOAI4yckcQS7Z9QZ6RMrFPJt0ncQqfdW33NUePzJ
         XMYr0fB1ZRl7cvDYBO0F9h8i+JQblozZ5RlX1D5kdjgSykJrbYtK1WLlRh3bQXwkCqzo
         EdFqvhwqwGdw3ZDwEGg1okX2Gpzl2H1lZqb0axhS86wjMryf0mkQxfhFQDAe28R4baoh
         3OXUer6tThV48uB547Pg3mMzhCYQVlnJZPYUVqwmEXUJ0XnCkddifUSQ1a3eK7PHb8mc
         19/Rw+QKBfwnH/Kwsj+/EZvk8E8hAMrwFxv4DMHKZ10bcXJoAmUPC/tjRdMYTvjgMgaW
         EwPQ==
X-Gm-Message-State: AFuF++m16nJJsVMo1slKbtlEzFKGOLhRk6c5pw9l1Km3BWKavACRb9f9
	62L4O3lcj7/FquuvOfsebTvmTh/9lr8gDElNX6sV9GLXP/LFXMggbl7b1QM5/lEc
X-Gm-Gg: AYBFou3b+FWpJEcAqiYClDPprhWWQWOFIZ49sWMt2aZTJNKMSus3JAo2Xeem+m6wy9F
	AU62xMv/ZyeDmyuXz5zeA3deLVOl82zxknwzc/EKCjm1oIhMwXRAR/aAZUAstu3AnyJdXek3swd
	6e7aOWTKRA+N05/IDxqi/jG4WP0IwrwOp3ZEMsTwKKsHBwtIz0cxsbEdcVvoN+kAuMmuimIB9Aa
	Nc5F6TI/qUcFmg+W+UHe90morClV7nzkUg/L0qFR6Qlx4GIwWyDN3P0m2lPEt01CWxxoXV4EuYE
	rPxbGZnpxw1kEErOeVyW3m3/K5WxvIVDc0jnWGts0ZyZ53mUgfMnr48AwGSKpmfIJiz+FISOhka
	53PDENV1dVVQjXnkqrDkfeW4saC3nTsfcaedXQOmsQxrqidK1O1THnTaPodUgLvo+ZGIrgliWV3
	JIbMG8Tyt5FIaatIn4V5ANboyI4lnw24ozwllbhmNTLvHCFPjnnHbQKTHhN4zhzRcwl/kxvr5r+
	RPTOGEX6UY/sm3U2sgYMR70JzfKsFCo9h62luA0tgWvUoZFEBDjNWFKHwK9gV72xSRogwGZ+2qK
	1PtVgSd8WhF3N2P7HNkb
X-Received: by 2002:a05:6a00:2e20:b0:857:7337:5db8 with SMTP id d2e1a72fcca58-874dd9f1d6cmr9505601b3a.22.1789841401814;
        Sat, 19 Sep 2026 11:10:01 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f8c39sm1190168b3a.28.2026.09.19.11.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 11:10:01 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] affs: check affs_bread() return value in affs_truncate()
Date: Sat, 19 Sep 2026 18:09:56 +0000
Message-ID: <20260919180958.1362943-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919180958.1362943-1-benquike@gmail.com>
References: <20260919180958.1362943-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extension block walk at the end of affs_truncate() does not check
the result of affs_bread():

	while (ext_key) {
		ext_bh = affs_bread(sb, ext_key);
		size = AFFS_SB(sb)->s_hashsize;
		...
			affs_free_block(sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, i)));
		affs_free_block(sb, ext_key);
		ext_key = be32_to_cpu(AFFS_TAIL(sb, ext_bh)->extension);

ext_key comes from the on-disk extension chain, and affs_bread() returns
NULL for any block outside [s_reserved, s_partition_size) as well as on
a read error. AFFS_BLOCK() and AFFS_TAIL() then dereference it, so a
crafted image with an out-of-range extension pointer gives a NULL
pointer dereference while truncating.

Every other affs_bread() caller in fs/affs/amigaffs.c already checks for
NULL; this loop is the outlier. Bail out of the walk on failure.

Breaking out rather than returning keeps the affs_free_prealloc() call
at the end of the function. The remaining extension blocks are leaked in
the on-disk bitmap, which is the correct trade-off against dereferencing
NULL - the image is already corrupt at that point, and the error is
reported.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
affs_validblock() was factored out of affs_bread() by commit d5de9fd594eb
("fs/affs: add validation block function") in v4.11, but the predicate it
replaced was inline in affs_bread() since the start of git history, so
the NULL return has always been possible here.

diff --git a/fs/affs/file.c b/fs/affs/file.c
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -971,6 +971,11 @@
 
 	while (ext_key) {
 		ext_bh = affs_bread(sb, ext_key);
+		if (!ext_bh) {
+			affs_error(sb, "truncate",
+				   "Cannot read extension block %u", ext_key);
+			break;
+		}
 		size = AFFS_SB(sb)->s_hashsize;
 		if (size > blkcnt - blk)
 			size = blkcnt - blk;
-- 
2.43.0
