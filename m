Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026064349AD
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948104; cv=none; b=J9XAvyu9lmkKhD3rrc9xJWlMUxkuOUBXImQNYKn5iLKQOzvY5R0FcU0Uly9rp8JeEQNS4DRwD/iHl1Ri0jHVwDIxMJLmh/EsgHPomm+E8U2QvgUh8TAYZ6J6ygs0owKjeWNbneZplIs03KrI9ivWAXLgGaqJWbnCnr5N+Rn6qA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948104; c=relaxed/simple;
	bh=fr/14uzfnjifOkUIimLTDNDBT8O6btLUilsS+08g3YY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHA6YT1YDtLx8ob3G/EOD9tgmMtsyWj8G+BI+KgQF3azuK6iQMw0m/MCCokPXA7ueSX1rUkwCUNHDqJ12UOvz8846rcMHJTDvKthI9JosEZ+/rq3fsmGvHDhABUAAlO48Hs2g3dIyjTEX2o35n53dV3k5LfoJU4kdPoLqWXGkBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gP3M0CG7; arc=none smtp.client-ip=74.125.230.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP3M0CG7"
Received: by mail-lr2-f3.google.com with SMTP id 38308e7fff4ca-3a4f7261b56so1394281fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788948101; x=1789552901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+teM91VaABsA7Ow6jpFbUu2VedKMn5ZNdhX8m3+ru3M=;
        b=gP3M0CG7C99Ifbv9DHfqpl8SDIswvqSe5sihjYKiXkIXBamRTya/cWkLUneOkxXOAt
         2SnAhRjsA1vyE4cGgjGIyNbWCRNF7jqqFAzDwWjZwk8vDM54hA1wD2xikr3FS5dXeLI+
         xKVn+RmOZ9aHLUJ2OZ0EKQyg0IcIoO5LULK2evbR0h0SN8pNbjd5MyGIXYyKCqQCpM6e
         bx3pHDnGVhdwFKpx6jAOn8kQWSyCOll+W2r2O3VF6FzGuLXl9uhWxYqSPdzWUPJRzMSp
         W/CpiBGO2GQdfpGNCvPMD9Hk1yWwvuiKPlpFwDnchq65TUwg4Hsok4bmGlt9EZAnOCAz
         0q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948101; x=1789552901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+teM91VaABsA7Ow6jpFbUu2VedKMn5ZNdhX8m3+ru3M=;
        b=JjocuBW+fyh275tP0ucjWrS9ZNOj1viwIJ9vz0tToBbi/HUrgGIba1mc+znYmAwi3J
         9JYZe2SlXm9NJMcxDZy9lV9P+i4oTmdw5k9NsG4cT+qHfmXnzVbEpyEr0Sj+wbMSuGjd
         37B0pO+MnlKvtAMyFTFOUXbHzdR3AMfaPPURPT9xKC34hD1E1bhn6LYgufBFl6VdAxnN
         72HEnSx953zWDCpIqJF4hVaotg2eekHgQXBvkYs7fklAmwO8PlG6ieqruZgroQCsx7sQ
         sAVZSH6dfvoFMjGvSyUC6Agremf0flxPfHmYFecWIz8sUPvxulBkS7b9uKE0hOslLSq0
         v9jg==
X-Forwarded-Encrypted: i=1; AKwUvByJ+JXTf6SCba3POPisDI2+3P2TF2aScZAGAPZtZj3DzwS61TdbU2NJKhSSEI60nkXmWnFHEi/8CUL3ARbl@vger.kernel.org
X-Gm-Message-State: AFuF++nTFP1KslT1dEVwWKuMlExX0XHWo0Iec/5kAz7vtQuG9bkH/MpA
	bU0ahpV6Rj9geLmhF3/pp4XqvV4yEcpkPTQbVEo5AbnRYAPHOuQD1aWb
X-Gm-Gg: AYBFou2wwWc/ekG36diqC597PoMOX/v615wMXukIvXlB5s6skJ3tANSvXqDh0RmapdZ
	fCO7ThaBSZSKn18/H0JO4/h9zGrT5A80v8tkOwiwSiuwe4gtQueRbOB9z0WHAUn05uuE/7ycSLG
	EM24fTjXlT8r9hK+Ae5hiljwLyb+mr4YeCten5CGcZNj4aawKZbfIYZpvuqhBjyDjCFUK6cOLQa
	lpnQqfahzyJtbTpMjEHQk8IWtOYVz0x41wgdhPHXFDRTMBOvY4vxUEY+FKEVDRwkniJDNlTju4c
	5M+SHWYtA6mMce05o53Xo6RB0XNRPk2mI3QxqqSJ1p1APNc38iohvbeH6fENehlf2Hq9Ug8iuJY
	e+iw2c0l+/6ej8/lwBIskoNChVRUbdnRrArul2PXW0tY2f6RhSXVDxqYv0SzsGF0D0+rS9v8X6a
	TFzR4ZUZbj8AVZMABlrQvYPHqzT5TctMA6ro//rKxl+NskxgV1J0zpc+XQYf6/ae0i+zOh09HhF
	XAIg0GlWSBtYpEY
X-Received: by 2002:a05:6512:ba0:b0:5b6:962:4ed2 with SMTP id 2adb3069b0e04-5b616f34d3emr5897163e87.22.1788948100644;
        Wed, 09 Sep 2026 03:01:40 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b76ff836e2sm236292e87.39.2026.09.09.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:01:40 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hfs: fix slab-out-of-bounds in __hfs_ext_write_extent
Date: Wed,  9 Sep 2026 12:59:25 +0300
Message-ID: <20260909095930.19979-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function __hfs_ext_write_extent() writes extent data to the B-tree
node using the length fd->entrylength obtained from the on-disk HFS
record without validation. This length can be larger than the actual
source buffer HFS_I(inode)->cached_extents (which is only 12 bytes,
the size of hfs_extent_rec). An attacker can craft a malicious HFS
image and mount it locally, then trigger a writeback by truncating
a file, causing the kernel to read beyond the cached_extents buffer
and leak up to 84 bytes of kernel memory into the image.

Although CVE-2025-38715 addressed similar out-of-bounds issues in the
read path and added bounds checks in hfs_bnode_write(), those checks
only verify that the write stays within the B-tree node boundaries.
A 96-byte write still fits within a typical node, so the overflow
persists in the write path.

Fix this by adding a validation in __hfs_ext_write_extent() that rejects
any write where fd->entrylength does not equal sizeof(hfs_extent_rec).
This is consistent with the existing check in the read path.

Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
 fs/hfs/extent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 580c62981dbd..b588410f01c7 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -126,6 +126,8 @@ static int __hfs_ext_write_extent(struct inode *inode, struct hfs_find_data *fd)
 	} else {
 		if (res)
 			return res;
+		if (fd->entrylength != sizeof(hfs_extent_rec))
+			return -EIO;
 		hfs_bnode_write(fd->bnode, HFS_I(inode)->cached_extents, fd->entryoffset, fd->entrylength);
 		HFS_I(inode)->flags &= ~HFS_FLG_EXT_DIRTY;
 	}
-- 
2.53.0

