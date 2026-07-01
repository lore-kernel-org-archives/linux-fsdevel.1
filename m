Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184DA332EA7
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915647; cv=none; b=oMmPZPyzlKaT00o7jaWwkLG0nBgqYnAj8jPckNXEMncK++rwTAnE2yS2AGB2RSDUTdD+CORfaPDShSThdKndjmyS5SYUh46ixA3FqhxiAayQZd8S9kzB8celW8W29R89req0M2iKuaCWtAIQzOTGfw8vRYIxutqp0dgLuR5aX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915647; c=relaxed/simple;
	bh=yc2Hyz7KSu0+lW1gLaiBvQG/wcF0zCCeP501YXvzp7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZBSjgW7gI6kgPFxExjHmsT2vh+Zc0eg5BXlTc0Bw1jSakFQkfUXn1YfIe+JMOk6Bm/JOJeof/PaVhSLO0JO60yqv4KXMz1/Xwtufz335fKL4Xn3/KG1XjL+jhn8mEJKU+aryoRsuI+z/4RI5VgtEA9lR6WIdF5H281M3+19VxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+95Gfxp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+95Gfxp"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so296036a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782915645; x=1783520445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VAnbx+5aUJivupEEG6uiMWkDGEOXRc8YwNCEsizzxjY=;
        b=B+95GfxpI75Hayaf7iavht28QvcPoX9NJu9ScGGN5sIAaESEYY/C9/lOzl7GySY5iP
         zOAbpwpJmbMtD5IwIxq7zQ/sqsUOS6aRTPn9sMVqL4/htkjG4A7NrVEvbUMJAnbVEjBD
         9JfFypAYCtFobqGJisnS46No9kWOPYe5JsmsMrxA+acgTiJVm1RfzPcayM3d7xFDdjaj
         WcezlxfBWDVaIxizcHsiAyNFxWiPn4kyepgy1b3bHuHGNUv722I3/gG0wD3Ha4RDG1/L
         EkJWsbeaNVlHKVqqYN1HpLhCtfQY0cpvkHURzFANsV+93zYfySzfxVJeBZYAwvz3uatf
         4vKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915645; x=1783520445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VAnbx+5aUJivupEEG6uiMWkDGEOXRc8YwNCEsizzxjY=;
        b=O2CN+8xtAiXZtDxQN2mtezkJanB96uHyCF2ustt9bCuNBBIeCLJDNxEGsUoZMWoJAK
         F5/CwRWGvc4xDtGgWB9Yrhebd8ootpUVqFsRicjP5aU6OS2GCuU30oRqPCDIAgdsH4oL
         bIhYCpNO4lvNgvNV3tNaeIB1Lor7X+M9aRcdhgHjFRp6gnOcrV1mN6vFI96dktmsdFwu
         BskJKbfbeJdUvSBcrjyw1PiK0+46ZdyLOEzD9B0So2HBvMt0Fxol5C8JnZhvwrGcwMEq
         tPArfAizMY8H7/FjsFlW5oolhUDlKa4cbkUfhn1qdJIkNv+RayjBG+a11774c+ps4mnh
         PBKA==
X-Gm-Message-State: AOJu0YwZZ3vGkeM7ObGSZGqRysHlvuLxoDJaciZjSVpK855DyXIu40iw
	tHTmTS/DFeWlq/tj/N+3HbP9ARqmfpA+7i6tG+EDkTt/4PTd1xu4TV3S
X-Gm-Gg: AfdE7cn+ljpiddQwI0eT8WGb3lniA9ylHfm5Ckz7chFCKWuOvmNaNvNH96/99QebY2M
	vFSVjfmAsMYjHt6+Vvb1pgAXCoJbja4fCVUjkkVUrpRIJ7LmbI9uL4rAjTCspFQtPoeGjyRS3UR
	ilN9P0onnF329G2fqYjFpEO3J4OcTl5HRDiCXRcYJbpEJIMUwfAe2oNAu0FLo0tafnvOgIfgZ6o
	jCanfvtAP5tL/nz0/JYa9krZ4lxyl3+xPmP2zQERG/n0/LPeMUaL77v6LQ4XhvBvaZ3P2TXZ8NC
	2XuPV7h8oSRC+Mjo/Jbvb7ja8jdKRNnRYA1Xw3ywP89Ecn0TxZCPoVuFOneW07z8un1nww7x06z
	vYEC8g7d0L1L+vKKXxC1enNtXt1Z6DLJZ5s3jhxmV8IO35AnsfnxAMfpgm9DXix4N7uvOtya+6Q
	VuVkHF8XeJFDotaKp1EuSUBGMZ7Lhi6y4swXQQZ0P3btA=
X-Received: by 2002:a05:6300:6715:b0:3bf:b0b8:58b5 with SMTP id adf61e73a8af0-3bff422d1d6mr1010582637.36.1782915645158;
        Wed, 01 Jul 2026 07:20:45 -0700 (PDT)
Received: from DESKTOP-DK6PUT8.localdomain ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e32ef8e49sm383894a12.19.2026.07.01.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:20:44 -0700 (PDT)
From: yizhang089@gmail.com
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	chengzhihao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/6] ext4: move partial block zeroing earlier in ext4_zero_range()
Date: Wed,  1 Jul 2026 22:20:04 +0800
Message-ID: <20260701142009.1510104-2-yizhang089@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701142009.1510104-1-yizhang089@gmail.com>
References: <20260701142009.1510104-1-yizhang089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

In ext4_zero_range(), move the ext4_zero_partial_blocks() call, which
handles unaligned edges, into the same branch where the unaligned range
is preallocated, immediately after ext4_alloc_file_blocks(). This is
safe because there is no dependency between partial block handling and
the subsequent full block handling.

This change will be used by later patches that handle unaligned
FALLOC_FL_WRITE_ZEROES operations, which will need to check the partial
zeroed result.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 125f628e738a..27ca641e701b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4734,10 +4734,16 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	}
 
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-	/* Preallocate the range including the unaligned edges */
+	/*
+	 * Preallocate the range including the unaligned edges, and zero
+	 * out partial blocks if they already contain data.
+	 */
 	if (!IS_ALIGNED(offset | end, blocksize)) {
 		ret = ext4_alloc_file_blocks(file, offset, len, new_size,
 					     flags);
+		if (!ret)
+			ret = ext4_zero_partial_blocks(inode, offset, len,
+						       &partial_zeroed);
 		if (ret)
 			return ret;
 	}
@@ -4770,10 +4776,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ALIGNED(offset | end, blocksize))
 		return ret;
 
-	/* Zero out partial block at the edges of the range */
-	ret = ext4_zero_partial_blocks(inode, offset, len, &partial_zeroed);
-	if (ret)
-		return ret;
 	if (((file->f_flags & O_SYNC) || IS_SYNC(inode)) && partial_zeroed) {
 		ret = filemap_write_and_wait_range(inode->i_mapping, offset,
 						   end - 1);
-- 
2.53.0

