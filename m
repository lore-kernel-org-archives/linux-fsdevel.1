Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17431376A00
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787409222; cv=none; b=G7aEFhFdxgHQGriUVPWXNERPpUgfqxq07giMfi6giGcTY5iOobglCyhXCFvFuPNyK7IFsBcd3sxyAvWYrPestP9pu6KNkeDWcT2hylOPxjxl1r229qBoxMHOhwzfrnwlarDhctCPihVuUJjibCPJ87qwqSIG3qkdWgJnt+9ShL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787409222; c=relaxed/simple;
	bh=YGXWoJ4LhhhkF7EWbP81eYh61/pNV08G4d7PwdAEWO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxgESgRGImoIMEdNSGKMBQDF/OKlsVVydPhsayQ3V9mLje2A8sTovZhPMA3X/AsqLrIKwUpMXSbO+WUMKMzjFbbuZzjRek1H1RNfAAUBLt6g5aTxKwzafTYOA1cFXanuIN5TnI9XGqNhlhJg0asTGXRT6AZOzQ8/yuG7Ptw+rOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbfRkvK6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbfRkvK6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso285511166b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787409218; x=1788014018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/FlxrXjQiw5bnwrdA7FzNpOb5hdE68uhQMeRmlYnIxQ=;
        b=SbfRkvK6GjbkzxcKu1MzCjYv/ng3EyqKSr4Iqn9crkFP+MynNlhjpI+6Zupsp/EXIV
         Y/S81JNvSimbru4VDwRnCE8Om6WEOLV2nwaGwI7Jak3lzJuIbwbmCW+HeBHnVlnqHlH0
         NgczhhZ5Ti+YsmHze6lVxOWkO1L3qls9iXJ6jT5fyz8u5DtLrEE2F2jiCZf23ZI0lMwM
         AefZsQK8NsUZLW4jT0degFgo05zy3UW8FuYG1O47l5m9n5fadOCvY5IPUqvi8GUCOAf6
         FgL5Dykm7z6qM4Idr44JuELES+M8Pjp+T5uUWqnhKENS5WErjDTeM22vatAagbjUJBcZ
         DGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787409218; x=1788014018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/FlxrXjQiw5bnwrdA7FzNpOb5hdE68uhQMeRmlYnIxQ=;
        b=bIhaLvdHYi+t4ha9gW6zaBWkeNPLZ7eSyWOO+ZqzPO0G/0PNHyNITt1VHR9/a21nGb
         9oF2YQHPD1PyEhr3VBX/xHFhaLKblWDZ40tZiD1LWGNvbIpbS/A/GpMuhI3VYBBjxWhj
         6UFD0cntKh0uQOH8ds1Qa68CFREb+jhMXxrT64Tmuwdun931p5Iwa/P8C1hPJoIvHo0L
         4ItTucKKp3rzYLQ7a8WpJeIZS+ngTH88mtCVy8AEcc9efDI1EYYgpjTYS+8ZwhuFqH/w
         1m03g9C9F1wgws38bBXuna+r8XgPpq0iq7nUxviFDPxrxVanKO6TUFE9NxdhWMGatj+f
         k9XQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFMTd4IPHZRz+AINX9/pXcixneL2cmIbzi/CnGWpXCargcGthtoDKjkXXUh6cLqNOWclfKeFQy6ZLASjVv@vger.kernel.org
X-Gm-Message-State: AFuF++kLgAFOzLkThZlIz3PJzWkG0IFqHS4DTFd4h3oZqqUDRppSHPrj
	vq6F4c3znpiW6E+3YyIQd5Ubj+BLDPeO2OyRGE43sF2g+w2u1k0okDNB
X-Gm-Gg: AR+sD10eW/vM5aj9pOimfq0NtZjRywDiiSGnk8HzBh5B9oNs3pwUBjRW+79Zt3g4NKT
	VohRuJy0nH49HVkHuUh7SzecUj0PDv/RrbAr13ySDEDHMBo7UpUj1O2VvHG1Mipeo2g3YqKce0H
	lhJqNsr/AeOmOb+Yr/XqJR6gsN3TZ39IV+L+Jshng0oZ3bMZ3jIH7giHioKilyk+xYxsF4fyqn6
	Zi6ldxH/r5pgNFp5tdroZEkwebkwqt/1KY4zdiM6OAnF48pSeyFuMzEWrow1h/s/tbBj7jsaezI
	xghSsvQv3umGedQRCrS2YfuzbY7tqVD9HxuEgEd3AeIYUReNikGmabPQVXywi01+ZQVpXk6gycM
	53KAhSj45TntGW+P4lKfP5VfXyNj8lTjBxyWUjPtKngGjfNhU1K7inJu9R5nJKYS9N3n1WJjFc3
	2vYP3mdbl0MhapRS3g9uL1IGUOzozgmXqAprk1irGYazrLXOP3DITnBgllpd52nvkcAT5H4ENjn
	3Tomfv2/EV5aMZup2CeeDuCwtkL1333jKXOrzjVHGXWYVm6we9i+8vclXuMNCRUucomexQEc8Ur
	p13NcF+zWWqWFPVTIpLPgvFnr2V7LGUCHBIIOCsMDqk2sbwii2P+pseZaHDeTlVQX2+FHqCMcSn
	AxBQ=
X-Received: by 2002:a17:907:9603:b0:c07:43ed:1b3e with SMTP id a640c23a62f3a-c2469f9a365mr1597208466b.0.1787409217798;
        Sat, 22 Aug 2026 07:33:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967459aesm326597666b.48.2026.08.22.07.33.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 07:33:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] squashfs: fix fragment index table sizing overflow on 32-bit
Date: Sat, 22 Aug 2026 16:33:27 +0200
Message-Id: <20260822143328.68867-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822143328.68867-1-kmehltretter@gmail.com>
References: <20260822143328.68867-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SQUASHFS_FRAGMENT_BYTES() multiplies the on-disk fragment count (an
unsigned int) by sizeof(struct squashfs_fragment_entry), a size_t. On
a 32-bit kernel that product is 32-bit and can wrap.

squashfs_read_fragment_index_table() sizes the fragment index table
from it, but squashfs_frag_lookup() bounds the fragment number against
msblk->fragments, the unwrapped superblock value. The two disagree: an
image declaring 0x10000001 fragments wraps the product to 16, so a
single index entry is allocated, yet the lookup still accepts fragment
0x0fffffff:

	if (fragment >= msblk->fragments)
		return -EIO;
	block = SQUASHFS_FRAGMENT_INDEX(fragment);
	...
	start_block = le64_to_cpu(msblk->fragment_index[block]);

block is then 524287 and the read lands ~4MB past an 8-byte
allocation. On a 32-bit build KASAN catches it when the crafted image
is mounted and the file is stat'd.

Cast to u64 in the macro so the multiplication is 64-bit on all
targets. After conversion to index-table entries,
SQUASHFS_FRAGMENT_INDEX_BYTES() is at most 64 MiB for any u32 count,
so it fits both the unsigned int local and the int argument it feeds.
64-bit builds are unchanged.

Fixes: ffae2cd73a9e ("Squashfs: header files")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/squashfs/squashfs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index a955d9369749f..93436c7d80c97 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -136,7 +136,7 @@ static inline int squashfs_block_size(__le32 raw)
 
 /* fragment and fragment table defines */
 #define SQUASHFS_FRAGMENT_BYTES(A)	\
-				((A) * sizeof(struct squashfs_fragment_entry))
+			((u64)(A) * sizeof(struct squashfs_fragment_entry))
 
 #define SQUASHFS_FRAGMENT_INDEX(A)	(SQUASHFS_FRAGMENT_BYTES(A) / \
 					SQUASHFS_METADATA_SIZE)
-- 
2.53.0
