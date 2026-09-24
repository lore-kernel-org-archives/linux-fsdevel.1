Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BD41E6A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233462; cv=none; b=rsaea3CrWGtSoeBQWKHbZ7X26SVSKvU8dwu48DbLVRnhZoCq7wuTxP3YG9tQHD2EhBKLpFxhFkdKXm5CuI7/0HsqS+EogmSuPg1lwTx+bEpXdRAewHDxMYY2K8i3pfyS3RD7h1bp3i2Kid5y3CgBl2GBHxAqxCDatGJFqaZb4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233462; c=relaxed/simple;
	bh=hSzjj5EWj93aJkVCLgJoqkSUV4JeHbR4WsKjyBSNkqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8tSFOEP/WLUmSANBxA9rOSXQv+9z+/IMSVMuwwpK3T1JjCwLJD/5kxT1T8X2FcERhIapgHHNU8U98pjbH10G921tfAL6M3ewKAYMhUy97ZptqG+znbsmLBUYWbIa7B8vTHmxalUl/o04yHpRcJq2xWS/BkBGuYPOagfUJFuuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AASOGoCP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AASOGoCP"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe459dso7356105ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233453; x=1790838253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y2LTg3vvPFgbzPTkmqn0IohkH/9PUn3rBZlX6gCR2Kg=;
        b=AASOGoCPmgpcvKwW6C5Pij6fWD8oWuFePAYlGNEP4mei+K+IJw9mF+JkIpQtNfBW3R
         stxNIIJwQPht3FDyHXjXhQp1geXi+E7nnhl4xbqWLJkDEYe5Z5v/Ty/fgaTrrjdf926c
         hTagZ9ZJ4z6ZiRBbabJnvcvRZUdXOZMnfMi3MfspG+oz3fs68Edx/NAzWoy6TcGZVh5I
         jEcnjwaswU01AsVQO0AmnRM0kzy+Eivj9n+s/OgKsyxbNY1qMzx5UuGMPzBIZjtu24XW
         T5PizlQ1hjSiixUYz/GUJ6/1IhYIk8kbnuW65IJ5IfRPt/SO/3ajhjlJTNGQYQyvuhdU
         0vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233453; x=1790838253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y2LTg3vvPFgbzPTkmqn0IohkH/9PUn3rBZlX6gCR2Kg=;
        b=vRSnzMUd+0ILUBcQyk57U39YWTGcj/9YF0LVYJlVHLT4RalDJAeqjCCvX/g//xIHzw
         pE2auKDlN5RVN7JkeQj8oL/8t7XwxA4hq5p1HeItHcvwyQg6rmycWOT4HtFBkvV09Bq+
         hZrwZUK/Hdk+IY8EW86KIYhI0f98Kq/dXMCdY2krmCXGQPiiwABmGdRavuR+C2dxFp4h
         w/8L4rSzTcEHWYjpXDzyo5Nf01iQwEI3dLZajnT91smr4Hjl1p3+zxo3uaVINzt4FqWA
         6Sfu4dSy0V8KneK6Ks+qcGL+LS1vkjdnBSt2JmBYwuPvHdB5Nn5mThAgnYDFV+9QFTtc
         KYng==
X-Gm-Message-State: AFuF++nFc5GAoaBFp5zRejyzfr/utYKw205puYpe2E0bi3NjTSe0CZqi
	9R8XMLW1XuIJf3AZ+rut9G40wQWZwKjPskBRKnZeY2piDlBxl65njBqyIgZMo9C3
X-Gm-Gg: AYBFou0Kh/6vUNu5eqeHJqsnRzmdVDSR/T634bULFcEq3yOuBCkSuG6CqEyczkLtEUn
	9Tl4ix6UNxwi62l4QNYlH3UNP7DtDqtx7mFJ5SpP40OC2jkSpNojN2UlL+7rJXXA3r7tRA63T2q
	vXbI0ByS1Hx+42d2Ued6GJrpPD4M1P/nL+ZkHUk9p1mpwbP2eYbPKohNegX6CcK+m2NEijGjMvR
	j9DAl5GiPNa3tkG6GY9cd8I0H8PRVoCe0cQS/bfeIiDiuL/8230LrvHFONiI5JtBEH6tRgCgxdD
	GbUfW4/sE3gXtfr7GqGG4jSFhf1UI2M1YyykkVdhuaol+d91zL6tGbpI2XSZrpVYdMZ5KatTjKE
	0sl6Bl2q98oAfn6hvKjiL2wGfxAfB1cdhjbM+EOt6kGDf+twmDhPZ9kD36oncin3zLGr99wpqiX
	uUs+3HS4rKAocxgqFYjT4HRdSJqA6S57bmV0q7o0+kEugt1Uc9tgtfWjfJnjAAKJ9qE8clORwHm
	CucMsUh9TmzacwEqHGnFVN74byaUbAvOsG8ghLAuukHZwGJUc4I4oIFG5CC+OV8XaiYLMMgbIc8
	MGAxiUxyCt7GwC8uI3xz
X-Received: by 2002:a17:903:b4e:b0:2dd:c100:4b75 with SMTP id d9443c01a7336-2df7dc5aa2emr13480375ad.44.1790233452740;
        Thu, 24 Sep 2026 00:04:12 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a60c4a8sm21543205ad.79.2026.09.24.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:04:12 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] hfs: validate allocation block parameters in hfs_mdb_get()
Date: Thu, 24 Sep 2026 07:04:10 +0000
Message-ID: <20260924070410.2629558-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hfs_mdb_get(), drNmAlBlks (fs_ablocks), drAlBlkSiz (alloc_blksz), and
drFreeBks (free_ablocks) are read from the on-disk Master Directory Block
without checking their mutual consistency against the partition size, and
failure to allocate HFS_SB(sb)->bitmap returns -ENOMEM without releasing
HFS_SB(sb)->mdb_bh, HFS_SB(sb)->mdb, HFS_SB(sb)->alt_mdb_bh, or
HFS_SB(sb)->alt_mdb.

Validate that fs_ablocks is non-zero, free_ablocks does not exceed
fs_ablocks, and drAlBlSt + fs_ablocks * (alloc_blksz >>
HFS_SECTOR_SIZE_BITS) fits within part_size, and clean up via
hfs_mdb_put(sb) on error.

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted HFS image
with drNmAlBlks = 10 and drFreeBks = 50: on the unfixed kernel
hfs_mdb_get() accepts the inconsistent MDB parameters, causing filesystem
corruption ("hfs: (loop2): extents (cnid 0x3) bitmap corrupted"); whereas
with the fix applied mount fails immediately with "hfs: inconsistent
allocation block parameters in MDB" (-EINVAL).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Validate consistency between drNmAlBlks, drAlBlkSiz, drFreeBks, and
  part_size in hfs_mdb_get(), as requested by Viacheslav Dubeyko.

 fs/hfs/mdb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 277de712f9d4..665753a2cba9 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -214,6 +214,14 @@ int hfs_mdb_get(struct super_block *sb)
 
 	/* These parameters are read from and written to the MDB */
 	HFS_SB(sb)->free_ablocks = be16_to_cpu(mdb->drFreeBks);
+	if (!HFS_SB(sb)->fs_ablocks ||
+	    HFS_SB(sb)->free_ablocks > HFS_SB(sb)->fs_ablocks ||
+	    (sector_t)be16_to_cpu(mdb->drAlBlSt) +
+	    (sector_t)HFS_SB(sb)->fs_ablocks *
+	    (HFS_SB(sb)->alloc_blksz >> HFS_SECTOR_SIZE_BITS) > part_size) {
+		pr_err("inconsistent allocation block parameters in MDB\n");
+		goto out_err;
+	}
 	atomic64_set(&HFS_SB(sb)->next_id, be32_to_cpu(mdb->drNxtCNID));
 	HFS_SB(sb)->root_files = be16_to_cpu(mdb->drNmFls);
 	HFS_SB(sb)->root_dirs = be16_to_cpu(mdb->drNmRtDirs);
@@ -305,6 +313,10 @@ int hfs_mdb_get(struct super_block *sb)
 	}
 
 	return 0;
+
+out_err:
+	hfs_mdb_put(sb);
+	return -EINVAL;
 }
 
 /*
-- 
2.55.0.1082.g2b9226bbc0-goog
