Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F03A874C
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756396; cv=none; b=pgg7TvUAOFm0w9PPsGJtQExI6rHJ0tp/C+iXvp14eEcNfl6JGI7Nbo7dioy07o5kcLbrpuUGfUIHhUaR6jfEhvQ1DkMsAdp7wk8aT88lZ8oareZ/ETlVtXSv9+Kin8aJuSzFR8mSJz/Cl1MgY4CjhMyBMHEm23/q4ayi+Um/PAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756396; c=relaxed/simple;
	bh=5hD9XVqI+4PXRTEiMFVCtYvnNEvjFeZDmjYsnp//hD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owLi0qYP9Vvbj1hfOd36mUut/8r5g9rW7HeVxuG3OqhcGcssqqCmqRY6enBBYhVgTi8utZRoleYM3UGKBNoPSoVtbvN1y8AePBcuG9pxsUDZ+Y+G++zs9NeMxHAj3YkQjuaRTfV+TEcFunr8ant0J/KfSlJi+6Yqjir0/Qh998c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2hpvbJ2; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2hpvbJ2"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so2152277a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756391; x=1791361191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9jUtxKLRNZI7zQbmKekUxqQuRuxiBkqKsZtXk7alpZM=;
        b=n2hpvbJ2UHi9Wzw07T/GafyKlZ3x2/NYzkd8msvSgubsu1U+eYDvWDMtFQC8nNQlWe
         qZJoQ6+MTOBaqWcA51XICQJisb1c/5siyZ+KgbK7v79lvokLXMTPtTXtTbIJIV2vGP6R
         5IKvmIwNIXQkZGRtOSKrK8q9ppCHBnBVxpPeAJnCuMABz2oFBO8jgAkUSW6iF9kY8OY2
         bgT98g7PnCIeWdcT8IWa1nle1YTfVzBo1auaSd5y7j+ZOPgK9kTEuCxu9VRXQQhtNsAl
         6FKqdbFv8RZXozrNjuAds4EAX1kjxPpdlxiuPTDG62MV/dWbBDnseeE40t5UK5mMu0Tt
         emOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756391; x=1791361191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9jUtxKLRNZI7zQbmKekUxqQuRuxiBkqKsZtXk7alpZM=;
        b=GCC2+xv4S7+g0u0ICbg8gPHO9b5JAopUtEr/h9XZlDeA2mJLUZdAWvR9SCATZg6kAa
         JqizEUGE94Lziwj1dv9V0fLG84uboaU7M0pypdoJ3FD3M6pjTVdcG8sQnsisUYgRLYeT
         8oeHJDjcCzfRWGnJUhwmFae0uT80SJpIXDXTkJ8cnbSvPh+9Y2Uf5S7P2aoZ16Z/Ram2
         zIGG/W4WpKMdRUf5kcjOlQmh7FaYDlyayPb2Tm0Gbes+/5tdazBzCiUoa9zsGMUz75GR
         Eww6xJ+A3qPVfXZ1ztpvzL/cvX3d5TRgBFw5v4t3JEy6a05unE6dUZGstiYCf4KVOdXH
         1RUA==
X-Gm-Message-State: AFuF++l1xghk8uNqwGMyPcN8yIK4h1MtqmntvkKKD9ZYKY7xc+omgck+
	HzSOf6NNCD1ocHbHcLN3RQdKDKP/1eUYNc1P9onh4QE8m/Zrq52xAf0f
X-Gm-Gg: AYBFou2UV9cxwWjZG4Sz/cYrCDdGtSqBgbHzXQDynzp/n447AinbXOdmPu2uRJmdXgy
	hReNMMt7fe/mGka9/FiNlgsmn/tK8XZueR7RDR+y1DNFpay9+JCcqSTJl32ZK4Yoi9Rkr8uhQNG
	DEggy8o0SJr/AONedKaky0YWmEvcsYPExqsxBjdQO3Ko1IDGrlt10igsO0ih6olg7VuSahaclsF
	ESQFDGF0hStDT0R9Zh56OpvgvytA3A1NKtXSvilGvXyI5bvu56Qw5bMAtuzzaALwzmqpfrplTa8
	b7Y+txTDkGDZwfTt+ImIMQt0HCNcU3XsTvLl/f0uZ2ewr1dpxIfkztFQvvqTMTcVdqz8HYo5BJ3
	+T2QUITvnY5p8FTdC6ifkrhQO0Eqtqko8QCyWCUfh9iAL1MyGywDrsJ+pk77ndch8WUacUdF6yN
	BE/LrOo8VmWVe3PLfTnsbEOcbHYnXgvv1CIOMlBVc+RtoMuCa7rpPTDt1ySssTa3Q7MpA9TUjC1
	MA7u7imKoK2MaMI2hCim6tbYIZWItUVMyn0uchXa4QKfxtyHEg3OJy1AcQL45cZoGJYBw8hBS3j
	vR19+HhWIQ==
X-Received: by 2002:a05:6a21:918f:b0:3d3:adbf:7780 with SMTP id adf61e73a8af0-3de9e844522mr717549637.21.1790756390740;
        Wed, 30 Sep 2026 01:19:50 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:50 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 1/6] qnx6: validate di_filelevels in qnx6_iget() before accessing level pointers
Date: Wed, 30 Sep 2026 08:19:42 +0000
Message-ID: <20260930081947.511613-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930081947.511613-1-benquike@gmail.com>
References: <20260930081947.511613-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_iget(), raw_inode->di_filelevels is loaded directly from disk
without checking if it exceeds QNX6_PTR_MAX_LEVELS (3). When di_filelevels
exceeds 3 (for example, 6 or 255), qnx6_block_map() triggers UBSAN
shift-out-of-bounds reports at both shifts during indirect block tree
traversal.

Validate raw_inode->di_filelevels <= QNX6_PTR_MAX_LEVELS in qnx6_iget()
and return -EIO on invalid values.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v5:
- Restored commit description to accurately specify UBSAN
  shift-out-of-bounds reports at both shifts in qnx6_block_map() per
  Matthias Goergens.
- Added Tested-by: Matthias Goergens.

 fs/qnx6/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index a350280f2d47..eb6b5dfbc599 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -543,6 +543,11 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned int ino)
 
 	raw_inode = qnx6_raw_inode(sb, ino, bh);
 	inode->i_mode = fs16_to_cpu(sbi, raw_inode->di_mode);
+	if (raw_inode->di_filelevels > QNX6_PTR_MAX_LEVELS) {
+		pr_err("invalid inode levels %d (max %d)\n",
+		       raw_inode->di_filelevels, QNX6_PTR_MAX_LEVELS);
+		goto bad_inode;
+	}
 	i_uid_write(inode, fs32_to_cpu(sbi, raw_inode->di_uid));
 	i_gid_write(inode, fs32_to_cpu(sbi, raw_inode->di_gid));
 	set_nlink(inode, fs32_to_cpu(sbi, raw_inode->di_nlink));
-- 
2.47.3
