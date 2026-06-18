Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0EC27FD4B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793600; cv=none; b=N/nRlgrxVylD3ek66YHl/Ky0qoiSydJJPCGa3OR+1TbGu/8WDT19g0OSkonsPKrSGjNEADKHgfOGlxrYw2GkrT2T+kggBrv3GPgKiJQNHJGZbC/XuRGwM7qSdPA7g6x9cE4I6oRqDIdiTVsbzh3c3DnL88/k31qi6Hxlyn9ZzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793600; c=relaxed/simple;
	bh=sbdvRPxKDfv1P6rJnOTo9A2UU81GYJXeblwc4YMDp+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEWWkUvrI7MPAgxtJV7z8+5Af/YgFNQ/97kkih5X1TxfcNSyJw96VF+TEzZnCU6jyB0pw3jXowqVboWSwqZ/v5j5OtnROcPiuEZ1Px/ZQRRF4SZgwazxHsv7/15/PDE/pc8agpF4ENE56N5pBmmhKuK3xJnR4RPtpi/BUQa6Y8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6YVIetf; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6YVIetf"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso14480906d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781793599; x=1782398399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sabPnr39N7SPR6wN2SkPUoVEyYO5+VT2qK/AvfpNMc=;
        b=V6YVIetfxo6S2M8JgzCWJSeyCAAfT8rIgGGhc6cKPkEqEUGcz8VCmpTq2PxFZcAf77
         TGDOTNmOPyzQhPXw2Wihtoa8AvB4ZdG9Yw3KBeERu5PsamFqI5sd1VAXC16b8IlUkbIS
         OxJBOiKsCcKaHLOgxgpY7+dec73gELFENbdFz6t7/b2lC+bWRyFdDGLNa9kvb9P5Kmi3
         w5amw+uwNSk28aoh4Y1Qblm+EfjBLoD6kMqBOq99ZSPE5SIrrgTmg3SMlignV7qauTiJ
         GkFsGvosVRE7zxJv5Pto077gzBM5mUBCNNjiBXDsYimS9DkyNL6M2I/1cFe9NWG1naRU
         +UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781793599; x=1782398399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sabPnr39N7SPR6wN2SkPUoVEyYO5+VT2qK/AvfpNMc=;
        b=S8DSuaCKOc4TYsNc2bANX8OQsqYFmVduSrovMr7lUqTqqdhPKAIJvq2j8Rsk78dSs/
         k1QYW55UrSAdExYBKeWzn01mBQDBDmmnyrbESECC7MfWuYkOJRfvoel62GwGNcS5J45I
         5E2DN/JFo7bQgK3e9jOiyPKaSWqkuoVh2Tz/hH4n7Sqz6wDtfz8EXNwmfw5zGLLHmBT9
         Drsaw0KEITHKWsNjGOESsKncxWOpIlRWH06ziEgHcj9xyZH14OkJEwn/Nj0F0Clkx1sU
         FHWv3FU+3XjxycEQBGW8zcSZdkvrxnN5nDlfkJZBR65O6omcNHyOivPyatZ07vftXxhp
         oEvg==
X-Gm-Message-State: AOJu0YyTozMBhUp3Ho34WquRROPGeBMVcWF5+E7NNspKG1LSJUQOGHla
	uWenynMnYi4qABKKc8l5n+Ij1JhWr5KWeFl4iRvse3XbQoTGDXIb1Cq79XM9Ibj3+4Q=
X-Gm-Gg: AfdE7clB0NTnZZiTMMiRX/4j5Vcm0dABZNxqSzp1OfKap92j2/Zbauq9UHGG6UJ73vo
	AJgUUnCw4DAD5DuUpgmuZV6XLIz+/cRjPQFGkNn0K6n/9FLldjLvj/eYY79SCtOlk7j/wLpYf4u
	ykymdQA6n1EWQpuY5PIkplcdqMv0eKj6qA38iG30myMyuFV9YSYG1D0SmYGrskSYhgPK6sO2bzf
	WcpukYfTL4cG1IE4gkxG/qA7V04Of09iOBZ2DI9T6533RPjUXZt4UKCqPuhxJRGW+B3O7VCbFQ+
	2SCUY61hzs4TSZzOUOQQAre2BNgE8gznBx94GWGwsapNw9KJbLK9wje+8OQc0YFa21tNZ2NXltY
	FX4ej/UaEWyzvOwpxO9kRwItMQzhvFH82fMr2Xda3D6bJv3PVVwJIV58yxuw/7g62NwxHHFYvOi
	1FGLaCcweNBX7llyuSdYKjkLqin/AboJZBBtulLQDYfdYAEbFCOBaifNgZ9AOUFeCBiYlVKL8sp
	WBJPgbV0zCfJnZ+wpVuYfnviQObqukz
X-Received: by 2002:a05:620a:2b45:b0:915:745a:70fe with SMTP id af79cd13be357-91f2cbf2813mr637843385a.28.1781793598474;
        Thu, 18 Jun 2026 07:39:58 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f1c851sm2091591885a.16.2026.06.18.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:39:57 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] minix: avoid overflow in bitmap block count calculation
Date: Thu, 18 Jun 2026 10:39:22 -0400
Message-ID: <20260618143922.3066874-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

minix_check_superblock() uses minix_blocks_needed() to verify that the
on-disk imap and zmap block counts are large enough for the advertised
inode and zone counts.

The helper currently performs DIV_ROUND_UP() in unsigned int arithmetic.
A Minix v3 image can set s_ninodes or s_zones near UINT_MAX so the
addition inside DIV_ROUND_UP() wraps to zero. That makes a zero imap/zmap
block count look valid, after which minix_fill_super() can dereference
s_imap[0] or s_zmap[0] even though no bitmap buffers were allocated.

Impact: mounting a crafted Minix v3 image whose s_ninodes or s_zones is
near UINT_MAX makes minix_check_superblock() accept a zero bitmap-block
count and minix_fill_super() dereference s_imap[0]/s_zmap[0], panicking
the kernel.

The divisor is the bitmap capacity in bits, blocksize * 8, which is
always a power of two: minix_fill_super() obtains the block size through
sb_set_blocksize(), and blk_validate_block_size() rejects any size that
is not a power of two. Use DIV_ROUND_UP_POW2(), which divides before
adding the round-up term and so cannot overflow for a power-of-two
divisor.

Fixes: 8c97a6ddc956 ("minix: Add required sanity checking to minix_check_superblock()")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Changes in v2:
- Use DIV_ROUND_UP_POW2() instead of widening the helper to 64-bit
  arithmetic (DIV_ROUND_UP_ULL, v1). The divisor blocksize * 8 is always
  a power of two, so this is the more obvious fix and keeps the helper's
  original types, per Jan Kara's review.

Link to v1: https://lore.kernel.org/all/20260617215740.1116778-1-michael.bommarito@gmail.com/

Testing: integer overflow (no sanitizer); the oracle is the downstream
NULL/ZERO_SIZE_PTR dereference crash.

Reproduction (UML mount, same crafted image, before/after): a Minix v3
image is crafted with s_ninodes near UINT_MAX so DIV_ROUND_UP(s_ninodes,
blocksize * 8) wraps to zero, then mounted from /dev/ubda by a one-line
init.
  stock:   RIP: minix_fill_super+0x3f6/0x5c3 ; Kernel panic - not syncing:
           Kernel mode fault at addr 0x10 (ZERO_SIZE_PTR deref of
           s_imap[0]); UML exit code 134.
  patched: "MINIX-fs: file system does not have enough imap blocks
           allocated. Refusing to mount." / "bad superblock"; mount
           fails cleanly, no crash.

Conditions: CONFIG_MINIX_FS=y and an attacker-supplied Minix image is
mounted (CAP_SYS_ADMIN in the mounting namespace, or a removable-media
automount path). v3 only: s_ninodes/s_zones are 32-bit; the v1/v2 16-bit
fields cannot reach the wrap.

Mitigations: do not mount untrusted Minix images; most distributions do
not enable CONFIG_MINIX_FS. No sysctl toggle.

Harness (init script, crafted image, KUnit) available on request.

 fs/minix/minix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index f2025c9b58252..9e52d4302f0d2 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -97,7 +97,7 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
 
 static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
 {
-	return DIV_ROUND_UP(bits, blocksize * 8);
+	return DIV_ROUND_UP_POW2(bits, blocksize * 8);
 }
 
 #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
-- 
2.53.0

