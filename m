Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD889345751
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915693; cv=none; b=meDyxalqPkoNeLag31+D9uCwk8tNc4K5tAmGIQvDDouaeqJiUa1z1JhQdhhxGeu0y/q13g51brFRbchGI+yYUqxCaRX96DRp0Fz5VdE4ZFTMnLqVXV1ju+NjNHn4d9Ghh3+8eUL7Ly2nTk5RBALDlPoM6tw2CghEOfgNHP9TJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915693; c=relaxed/simple;
	bh=iRWnmB3n4mXDtaTJezBVflP8PXOZYbOZtUjv4DLQQZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNF8hBcwth5e4/UnnBX+g+L4KUxES3aZPl5UCV7QTTG6x2O2vx1U+Z6nBPxZEGSleADovZi02Vnd3TzbGoUkuK0KY16Axwjp27/VE4UwOjtqJJOrXoCLjXxXIXpH/w0HK6SVpOHmmldnzRi+d69sfxfjF/AyuLlcreb8UlHbkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d69ypUh8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d69ypUh8"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so268170a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782915692; x=1783520492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xalwgHUXq8zbjTwGJ1t/+Gt6kZFOt5YBAHy7z8R+4IY=;
        b=d69ypUh8OKMIEV5R8dqhA+feBctLFB2isFJ7zN37DvVQ6Is5yz1qaHXscj0Efo2A/W
         Lkkp79sD8+HvhIGBPTF9aiUga1SD3Y/MnbiQtCy4nQJ/nLI4oLKWY1Pw2Xqo9fgawOhw
         22FD/vkpn30dyGyInJZ1avHPGZm53kslcnz2SG8v1ZgVKRKuK6Hf6gMf7+MEezXUvp30
         yUvreaCrRLrpYguqYzHkVLoyIP3ALGfeKo8IC5PxZjcJefd1koKYwJ8Fz18NPcutnQ9s
         iCG/m10k/jCx8ShcQZwvQWKVZycdb5vwmnuTqmtxlOqblZ/waDoQlsQELp9YzyvexXeU
         x7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915692; x=1783520492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xalwgHUXq8zbjTwGJ1t/+Gt6kZFOt5YBAHy7z8R+4IY=;
        b=TXVonhH212gQmlvF8FZNVtDGveOvFvYNNtgxDzGAexmviMUD2sD9CFyIkrOfWqF5vL
         yDm0ANuuPr+3IcKVKuAWFJE0WYLu0IWOZiQ5TADfrotBN06DZtBB4FQFBU20YxkvWtD6
         htL05xmLT6o1Q6ymCOIgtqlRM+EG+Y9C5zvfNAy/LGTyaVA8+v/dvmcrpKZ1SoDVOe3R
         F+zdD1kR2VOGH3ppn/4Z/qeTp5+rH3ISGKyV+ToYGACXN850R/bskOk0XYDocqEkDnNg
         6y9U5hT61s3AKXILhg6DqvKltDtkHCLHQts+OaVv/Q3L6vm8K4Dowz+ms84oJCZQJDRL
         0tQg==
X-Gm-Message-State: AOJu0YyDgmE2HMpHHQ/R5Bf8M22A/9NrM3RFqmuvtd9xK1vkWOeaBqGC
	yHN9J6pK1JU2zYVVoXLoFwaNZyp6VE1ir8gIHTw4XOD0rtCaRFVOqSDb
X-Gm-Gg: AfdE7cm+uLZuhU1Oqz0KaHoGBFlh7a6mj+8UPOjr/Pi68N2VDir2noXnNUY2LITuVCP
	zwR6J/MydbPIAuX1E+zg1dZUaoxmSWntqZpGBTuWJBz6e+Alu1KiPPJOk/NSb5k5WT5ikwFYRkP
	5tP1hQJ0ev6Wcw5qkVB2JJotWM5FaLz1lYIjD1mQQinO8qnd8VtBg2oGRGLcVVNQfKPjk79ZqZi
	OleBEMS4VJrwpIasbRfIXN/x0NZMXYtpMwaifYOD4ScUBVbfs1S37ckC++y5yamOidACSlZioGO
	kkU1ndYhsRIbgvqLLt2tUe2ueOVZ/ohOaSF5tDlJrxLsScs636zGETZIBIZAjK3ic0Zys1wcIsr
	WUzRRcK/jtIcir8RTYtaiLc+tL9MsnMyf7ykWMfvf3sxKDUlhtkKjSd0B2lqB52tGT447HApz6J
	F2/H9p09m1oZ+9q121Yk5cSOARZkUVlUi1
X-Received: by 2002:a05:6a21:b89:b0:3bf:a941:8932 with SMTP id adf61e73a8af0-3bfed2112bcmr1882908637.19.1782915691998;
        Wed, 01 Jul 2026 07:21:31 -0700 (PDT)
Received: from DESKTOP-DK6PUT8.localdomain ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e32ef8e49sm383894a12.19.2026.07.01.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:21:31 -0700 (PDT)
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
Subject: [PATCH 6/6] ext4: skip ext4_update_disksize_before_punch() in WRITE_ZEROES
Date: Wed,  1 Jul 2026 22:20:09 +0800
Message-ID: <20260701142009.1510104-7-yizhang089@gmail.com>
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

FALLOC_FL_WRITE_ZEROES is mutually exclusive with FALLOC_FL_KEEP_SIZE.
In ext4_zero_range(), when end > i_disksize, new_size is always set to
end for WRITE_ZEROES, so the i_disksize update should not be lost.

The ext4_update_disksize_before_punch() call is only needed for the
ZERO_RANGE path in ext4_zero_range(), as it handles the case where
KEEP_SIZE may preserve the original disk size. Skip it for WRITE_ZEROES
to avoid unnecessary work and potential confusion.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c083703bf704..38753c2ef910 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4748,9 +4748,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			return ret;
 	}
 
-	ret = ext4_update_disksize_before_punch(inode, offset, len);
-	if (ret)
-		return ret;
+	if (mode & FALLOC_FL_ZERO_RANGE) {
+		ret = ext4_update_disksize_before_punch(inode, offset, len);
+		if (ret)
+			return ret;
+	}
 
 	/* Now release the pages and zero block aligned part of pages */
 	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
-- 
2.53.0

