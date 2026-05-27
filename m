Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB442B749
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895948; cv=none; b=Dq+iD3DkYjBT5+Ru/ibCfDgBJBgr2SdhWmLLZvEWyVq9NQzMkbO5KONYc/n7dbz7v3g3JGkGwhRI5bsRa2fOHdLIPrmTn8KzGT1x84KGihO6CS61Y2Fjm5r16Ah5UounpxBuAlqG/759iqDrViDTqm0Q8EU9hZttGTE7xMie2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895948; c=relaxed/simple;
	bh=gA/rmwlbX6BzWflQ7GBf040tg5982Oh53sFfiyKP5pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bshF0RI5N4t7b3Wv0N/QkM+cffmKRNxpS4t9Ej9KK4AQSiUC6kRZiJKiEjd7H7VSmr/HtRK5+V2073aVGNZvZVc98nupMYio13u4PaCpBikJ6iRQRLxTEcNqdkqtwW2i1dZFpbUnQfE61/GQNkwUGxm3AlAcnU47np/GpdUsNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVOMK8zg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVOMK8zg"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3698e34a567so10948616a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779895943; x=1780500743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URgNU/rT6ZHhxZb3K6pKics+UL8aQFhvSZmIlnCDbGA=;
        b=gVOMK8zgnjolL9J3WhyLzVTKuBp1HX3XsL2TsCNxaPx2qeZGtxI6d9BHiDiAEnf5Oq
         a0v8zA5raFrhYpqf4Mr2E+3jGgeBf8LtzsFgtuWzbZn3Wt/vf8tJ4hPaSFDfdO9smdFa
         jBA+dxfBC9JGeuL2EofNQn7ooCkjJtr2Ocu+wdkjF3ReRclvpFJO5yIzb6HNkZr74a47
         aP4mhNL5ON4/LsEmTRpybhYvKDfPYnbt807crRBVWfaxF6OI9Vn8cgkw/Td8+72FhpMC
         UncSdsMcpmqs3M8BxFOLnQrxKWJLEdpVr//ukmw7E5lQKJUm1lJ0RnFmzjzGgqWPyIEk
         q26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779895943; x=1780500743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URgNU/rT6ZHhxZb3K6pKics+UL8aQFhvSZmIlnCDbGA=;
        b=gk3BoUIT/0l6Aaql+MiP4TemQqNA17M1bHIT1iHFpveXPyyQ0nyZeRG/KQIDPT1xi5
         5CL696YuWykOr/eRSPRhmA4TRDLN1UDFyGxo485KsMx5Yc9hCYKq1L5RSKooGOECJ/6P
         i3gUC4KCAch+SJ2Tw8MOviLptv7K8ME8XWnYFb2tUtSvmyxvUdXKhkcDanDn/tS5QAvZ
         sNjv902Hwb68LMxPV0XTMB34xvEg4Wlj6l5vAD1TgGEPJSJSaAp8jRmvmcTlMZagQDxH
         Y/nxhvw2N7jNNXdEdSO1Kwz8zzyMX0/jAhVaXSW22XiC/RYnzetdubnBZUF411A7jTCd
         21cw==
X-Gm-Message-State: AOJu0Yy29aWN80PzQWhbKCTqFyTF5+4bRnLxuQ1E9cBVez1AK160YKgP
	HSA6i7bciDq1f1SW9xxE0nLXum+R8mt7nFtGrgSTqeJJDzcAr1/OyKscg6UFsN3llh48Iw==
X-Gm-Gg: Acq92OHOGKmy2EqbndL+k9c9u46ltSNLVK+pFGiXU1nkA425VqStHAd+HZCC/Gk+eO7
	FApF4ok0xxgQdf6eW4cCjO+/+iiB257LelWCCt9a0/gWOvpmU0zwVri/aeKVybwQM49aeQ+2Mv/
	jIz6KG84uiytI9w7KazxLProbOt8cKWavgP7aPwMpEJ8pNswYhBDgnCibDHfzucXmWSk1zIWfQP
	KZCTW3wYwQylc0VIzc4Bt765iYnY9oLoWiaSieDtLkCcMyTPu0R1jcgSR0IhIylSQ1G1V/e+JrK
	sq6Q5cGLqtZ+kK5y9dkOtp5YUFOjZ2XVX+aB2fcdy0YOGS9bohkd83QUul9CNxtqA1Bl1sKn6sK
	9OTQWHC2zj+nxPVpYFIIxmO/y3+LgPKhr4Uz/3hH0wBLh6djS5L4hXzL+pHTk6AoNXF3cnPY5Bb
	emGp08PT8lTBWaDquIftgKYF9uZmLlUSca07T98AEFokEOKA==
X-Received: by 2002:a17:90b:2e04:b0:369:b957:1d84 with SMTP id 98e67ed59e1d1-36a677c78famr22352920a91.14.1779895943532;
        Wed, 27 May 2026 08:32:23 -0700 (PDT)
Received: from gmail.com ([218.106.182.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b24d2feeasm1456247a91.1.2026.05.27.08.32.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 08:32:23 -0700 (PDT)
From: Yue Sun <samsun1006219@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yue Sun <samsun1006219@gmail.com>
Subject: [PATCH] hfs: reject volume bitmaps overlapping the MDB
Date: Wed, 27 May 2026 23:32:04 +0800
Message-ID: <20260527153206.85701-1-samsun1006219@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_mdb_commit() writes the volume bitmap while HFS_SB(sb)->mdb_bh is
locked. A crafted image can set drVBMSt so that the bitmap byte range
resolves to the same buffer_head as the MDB. When writeback later calls
lock_buffer() for that bitmap block, the task tries to lock mdb_bh again
and self-deadlocks in __lock_buffer().

Reject the image during mount if the bitmap byte range maps to mdb_bh.
This checks the aliasing condition that can deadlock writeback without
trying to validate unrelated HFS layout fields.

Reported-by: Yue Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/all/CAEkJfYMB47v1yOWHB8q2dc8kf=uj-rLO=+yMyudwPguJ8Kd3jA@mail.gmail.com/
Signed-off-by: Yue Sun <samsun1006219@gmail.com>
---
 fs/hfs/mdb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..abaa636db938 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -99,8 +99,10 @@ int hfs_mdb_get(struct super_block *sb)
 	char *ptr;
 	int off2, len, size, sect;
 	sector_t part_start, part_size;
-	loff_t off;
+	sector_t mdb_block, vbm_first, vbm_last;
+	loff_t off, vbm_off;
 	__be16 attrib;
+	u32 bitmap_size;
 
 	/* set the device driver to 512-byte blocks */
 	size = sb_min_blocksize(sb, HFS_SECTOR_SIZE);
@@ -185,6 +187,25 @@ int hfs_mdb_get(struct super_block *sb)
 		sb->s_flags |= SB_RDONLY;
 	}
 
+	/*
+	 * hfs_mdb_commit() writes the bitmap while holding mdb_bh. Reject
+	 * images whose bitmap range can resolve to the MDB buffer_head.
+	 */
+	bitmap_size = DIV_ROUND_UP(HFS_SB(sb)->fs_ablocks, BITS_PER_BYTE);
+	if (!bitmap_size) {
+		pr_err("bad volume bitmap size\n");
+		return -EIO;
+	}
+	vbm_off = (loff_t)(part_start + be16_to_cpu(mdb->drVBMSt)) <<
+		  HFS_SECTOR_SIZE_BITS;
+	vbm_first = vbm_off >> sb->s_blocksize_bits;
+	vbm_last = (vbm_off + bitmap_size - 1) >> sb->s_blocksize_bits;
+	mdb_block = HFS_SB(sb)->mdb_bh->b_blocknr;
+	if (vbm_first <= mdb_block && mdb_block <= vbm_last) {
+		pr_err("volume bitmap overlaps MDB\n");
+		return -EIO;
+	}
+
 	/* TRY to get the alternate (backup) MDB. */
 	sect = part_start + part_size - 2;
 	bh = sb_bread512(sb, sect, mdb2);
-- 
2.34.1
