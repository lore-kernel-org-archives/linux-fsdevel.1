Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294D26F2A0
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841403; cv=none; b=NjnvrE+RXW9E1oGgbbf8XIqiKQdLnUNLFWmR+QO6xco4/S3pnoTadrns3IuVJ1+xWfDxy8QAUhzW1X8JkNk680MdeR+UJnkzNV70Muflg5+7omgvHfBZq/VSvgb6UrD65DSQJcZgWaLhkOil2Q75WfUha2HYmIGRs5HylMokwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841403; c=relaxed/simple;
	bh=aAVSFY76lgQO01OrSs7ssic/mi+/CMLDEcviR6+3myo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWQ3Vo58C6twok1ruYaH1MP7GjvUC+Fh3GhbsCdqsXCbrOmvyI7xbLucH9QWK7rJWu/e4AQZ01JsT5lKPrNmyqG/I/ATH8STy9mGpNG+kVJe1sTv4ctE6Z2DUvw9CTAHTcsH+d7sLWy9WVyMcv9EYwSYpXoPvYzMnD615IAYznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raE5cUlQ; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raE5cUlQ"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a856865so1692654b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789841401; x=1790446201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGaU0pxyX4HFuiN75gQbxqPfhwQhSeDU8rlnsi/9iUE=;
        b=raE5cUlQwsuD61WNt03zs4CAbcF/CCnSxuCtzmfkp5LqT9WPC4Avw0iWxdctigd8rt
         VZWbutg//Vc9Qga2KZxUAuE25zPfHf6WPdAiABHr+nFDqohieY/LNDEeaJo0xXNFydt7
         fNzBSsDd+kEeCp2jNnWuqYgTYlUvtZpIOrJ2sCHmw4JabzU7MuMcSX0l8PaOkw9zTucH
         Sered+IS549czDWPXr6Q4jRfGXslDDkYs/icNxlppjlsvpaCpI21HzADlOT953WFXs8o
         +l/Mj4cWWJt/hdrcVnvKcL59N4Gntg8dc8c/B7uJGxAwQITSLAVhki9fahpVPdDwQCiD
         KMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841401; x=1790446201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lGaU0pxyX4HFuiN75gQbxqPfhwQhSeDU8rlnsi/9iUE=;
        b=To7SzU4+25XaE6udXrfymhvG1gWgcgru7pTiYHkYiCSRmokWilGS0x+00kFCXc0x+4
         m/KOKsnvbB2LE5iUtgay6WRzZPX+D0r+YsFyLQkBrMLSDJ605tLSZnLz7d8t/PxXgpYU
         4c9KnKasGmNcKFUCRU6nNVvQfMJDDsTZSL6Wb9hXvqZNdTFXvAEB04fK4Fhi8jgnR1xM
         gmS+CekpnY9uywKfumVTAvQB9/HFwbPw30nARZozQbLZqXait1phHtIiRyRG0IYW0t7Y
         ZNDnNZiFgcB+FKdG6UDTC7/Y15nDQ17sByq/IWjUwMrs3DLcP41swDFIjXqR4fc19c4Y
         Wy8A==
X-Gm-Message-State: AFuF++mQgJppeUO5/sEYqbsTgsiHMMo0WpGZU6Jnkv49H7FV9qZ0dR0R
	YTcOKTO41DLYkZ4dC+JL0khvT0ojOdetVdwmNlUxONE+dDUV5Wfq4GyImWk7XNIY
X-Gm-Gg: AYBFou2NnyNiRq74EYa8e7Cy4nkAjh9uNRYS2w6aHingi8leIluvsF6en0UMakUl0Iy
	SlXsD6gWirWvETUWxiTtqtN2GChdpEDnbVVdZqBM5TRbkBlwAepkBpqKQjogaInHiKkiA8tE0Z/
	FmpLvFOtVkk9G3JZXb/OluRwPcvq18bzd34t0ctMi1pVpQmsWGcDD4Te1rGe1NBkaszhm95rtkZ
	Bi5vkXEFWLCq4xFOtbG0Z8zWiiqP+Ph1i9YOPxSWYF5AHSLM+Cu1NCi1kNckMkmwjupVfGQi1j+
	DS+5VMpAT23kScLkq8kOaSKyMqTsO1zMJOxqm9IE0Yim1+mlJRYg12Hie4q1k5DUemm6PqYOlIf
	voXstSVuBkNIQRNrZeY3t13sZITkG43cH9U/EXVftFelVUi13fzVofPRDk88o7ECZ2iSExTCmti
	enEXeeSjl6C4WO6nU7PPTTsHo05JUP4VGgdpA2vSveuHZg0QOOAPka6JmUFyncrm3v6k4TZaALS
	s9AQFA2xV7t3raPO4DIqAD5FvBi42WWUxNY6QzW1BjN8xAnjEn2KK2vrUae6UGDJO1mRxj5aZ85
	q1Ml6MIigQ==
X-Received: by 2002:a05:6a00:1d8c:b0:874:705d:f657 with SMTP id d2e1a72fcca58-874deced87fmr8895022b3a.37.1789841401037;
        Sat, 19 Sep 2026 11:10:01 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f8c39sm1190168b3a.28.2026.09.19.11.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 11:10:00 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] affs: reject out-of-range blocks in affs_free_block()
Date: Sat, 19 Sep 2026 18:09:55 +0000
Message-ID: <20260919180958.1362943-2-benquike@gmail.com>
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

affs_free_block() accepts any block number below or equal to
s_partition_size, then subtracts s_reserved from it:

	if (block > sbi->s_partition_size)
		goto err_range;

	blk     = block - sbi->s_reserved;
	bmap    = blk / sbi->s_bmap_bits;
	bit     = blk % sbi->s_bmap_bits;
	bm      = &sbi->s_bitmap[bmap];

Both bounds are wrong.

block is a u32 taken straight from the on-disk file header or extension
block, and nothing rejects a value below s_reserved. For block = 1 with
s_reserved = 2 the subtraction underflows to 0xffffffff, so with a 512
byte block size (s_bmap_bits = 512 * 8 - 32 = 4064) the index becomes
0xffffffff / 4064 = 1056832. sizeof(struct affs_bm_info) is 8, so
&sbi->s_bitmap[bmap] lands roughly 8.45 MB past an allocation that is
only a handful of entries long.

The upper bound is also off by one: s_partition_size is a block count,
so the last valid block is s_partition_size - 1, and a block equal to
s_partition_size is accepted today. Because s_bmap_count is
ceil((s_partition_size - s_reserved) / s_bmap_bits), that block yields
bmap == s_bmap_count exactly whenever the partition divides evenly into
bitmap blocks - a one element overrun of the same array.

Mounting a crafted AFFS image whose file header references a block below
s_reserved and truncating the file reproduces the underflow variant:

 ==================================================================
 BUG: KASAN: slab-use-after-free in affs_free_block+0x5d4/0x670
 Read of size 4 at addr ffff8881068d4c00 by task init/172

 CPU: 2 UID: 0 PID: 172 Comm: init Not tainted 7.3.0-rc3 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 Call Trace:
  <TASK>
  dump_stack_lvl+0x70/0xa0
  print_report+0x153/0x4c6
  kasan_report+0xf1/0x120
  affs_free_block+0x5d4/0x670
  affs_truncate+0x635/0x1520
  affs_setattr+0x367/0x470
  notify_change+0x941/0x1050
  do_truncate+0x1ba/0x210
  vfs_truncate+0x305/0x490
  ksys_truncate+0xd9/0x160
  __x64_sys_truncate+0x59/0x80
  do_syscall_64+0xda/0x4b0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>
 ==================================================================

KASAN calls it a use-after-free only because the wild address happened
to land inside an unrelated slab object that had already been freed;
the allocation and free stacks in the full report belong to a boot time
kobject_uevent_env() allocation. It is an out-of-bounds read, not a
temporal bug, and where it lands depends on the heap layout.

AFFS already has a helper that encodes the valid range, and it has done
so since the beginning of git history:

	static inline bool affs_validblock(struct super_block *sb, int block)
	{
		return(block >= AFFS_SB(sb)->s_reserved &&
		       block < AFFS_SB(sb)->s_partition_size);
	}

affs_bread(), affs_getblk(), affs_getzeroblk() and affs_getemptyblk()
all gate on it, so a block that affs_free_block() accepts today is one
that AFFS has always refused to read. Use the same helper here rather
than open coding a third variant of the test.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
The last valid block is still freeable: affs_init_bitmap() explicitly
marks every bit mapping to a block >= s_partition_size as allocated in
the final bitmap block, so s_partition_size - 1 is the highest block the
allocator can hand out and affs_validblock() accepts it.

I have left out two further checks that I had initially written, because
both are unreachable once this patch is applied and I did not want to
mix speculative hardening into a fix with a reproducer:

  - a `bmap >= sbi->s_bmap_count` test after the division. Given
    s_reserved <= block < s_partition_size we have blk <= N-1 where
    N = s_partition_size - s_reserved, and s_bmap_count = ceil(N /
    s_bmap_bits) = floor((N-1) / s_bmap_bits) + 1, so bmap is always
    <= s_bmap_count - 1.

  - an early return when sbi->s_bitmap is NULL or sbi->s_bmap_bits is 0,
    guarding the division. affs_init_bitmap() only leaves those unset on
    paths that force SB_RDONLY (including the ro->rw reconfigure path),
    and a read-only superblock cannot reach affs_truncate().

Happy to add either if you would prefer the belt and braces.

Not Cc'd to stable and posted in the open: per
Documentation/process/threat-model.rst, "bugs triggered by mounting a
corrupted or maliciously crafted file system image" are regular bugs
rather than vulnerabilities, because mounting is privileged. Say the
word if you would like it tagged for stable anyway.

Found with a QEMU/KASAN reproducer built around a crafted 4 KB AFFS
image; reproduced in six independent runs.

diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
--- a/fs/affs/bitmap.c
+++ b/fs/affs/bitmap.c
@@ -46,7 +46,7 @@
 
 	pr_debug("%s(%u)\n", __func__, block);
 
-	if (block > sbi->s_partition_size)
+	if (!affs_validblock(sb, block))
 		goto err_range;
 
 	blk     = block - sbi->s_reserved;
-- 
2.43.0
