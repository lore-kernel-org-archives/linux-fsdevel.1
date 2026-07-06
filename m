Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6483955D7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376276; cv=none; b=nNK3JjKkl/gexwnPT6B/zguhvPuve6bpSUsp4VyzDHVr7isJ8O6liRi0UXCRM0z9rurxJh9+q7rY1Dyro58kbV61bVnvWn2MCR2NQlE0H+TTLRduonaCJqoILCXD/z9quU5mvM+CQXVKRQrN6xLBl7SOKHs0npbIGoKI3ecwEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376276; c=relaxed/simple;
	bh=V5NH9kQ7fLZj/BAFGQy9vW3pnLVjShqWn6KWzcKAxh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OucP4eqCxnKxSEAoZI29yNKGNN2IbkHuFfMKgeF2BuAS/Axx83rlxiC6ginqGUfGI8bqBIg7Iis93T0PtI8EY7yJtblWYHsFJXuzzyFgVqYdihbthpTawbZUWX12RMMgY57wtKqa1HvWh3SPPibQCPaSKyl7L7k3FEpX5B+dhs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=zTgxdch/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="zTgxdch/"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8143daf89c7so33051317b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783376274; x=1783981074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYu197rgwP+qERFJvSPlFQquNeD8TuB+n5Qa36zU6LY=;
        b=zTgxdch/UEIm9M6kmN/QvGknYewzlg9x1iMgKSQYiCP4Vf+sKZTD6YNc5e4NSKDN6s
         G5PNLYqqdsYPQBrb/FVFWb85H6741szYCnjeHPXoWkuoGWCxyDYtvXWEn8sWD8uRCHiG
         zEkw71fFA9AVyvUsQYNXHx5xCvP45z/WDhHLFIxB34UOPtYoTf7yYnLJol/eb6i9zZbW
         zFV0qtjAa9BI/ZDPON1tcCbZpWIF5PRt+PflcI1wiuOQoIuA/2f+EFCPv1o0E/Xucayj
         yoQzma7g/0tqA1v88XOT79gqwsFgoeDaY/LQKaogGzdPAPimgyyCLUBRVUwdiczWkvil
         /WXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376274; x=1783981074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYu197rgwP+qERFJvSPlFQquNeD8TuB+n5Qa36zU6LY=;
        b=pzavaxQDw2vu4WCEhbMI1+JKbqKSXYnB+UPeG4twxzGiDFdpkvaRzBFD47WcKvJrgn
         qlJeiKFg4IYSuKpqyntikNhLD5h1u45/ckevrtBC0rGM4RkzLNEOiYCWWu3iDGr2H7+v
         KQI3YJnCxl6qmGF+OaSM4gipfrVOsx2jBNbRS8S5zy7Q6BDKYfH+J4XLyvYKHBYBApfQ
         t7WZoqOVkuUkBDNnBahNrgJrAIjnJdWdZdQ6iDvEn+mKz/pHp0UXGZiqrHRYV7BlmEUI
         9rQpKqFqIH+gtsvVJE1IqdmAZhAsEWPXpg71HMDZrIDFJ2TgwmQSxy43Mz3+L9hqXRfo
         0JqA==
X-Forwarded-Encrypted: i=1; AHgh+RqjjZi9MCt5nhce5SbydLkn5ufcdHBI6uF5xm4yg7rXvx3haBkOPhPexXuSwAzJCc1ijKFYyQS1Jrl9Sajp@vger.kernel.org
X-Gm-Message-State: AOJu0YwxufzBeNKslMMZ3nMvego7ayf5rpbYrVEiwdELSLSrZo9xJSVr
	KBXOB8M9sqS+RWj5jGzge+mTAeDCSAvKP9Yy7Ikf9+QxIstZwCguEIPJnWsi99zN5ao=
X-Gm-Gg: AfdE7cmkyWdmIzXk8XHAW/l67Vq79BUfssXW3WW14jOxtn1G/mHkFwKp2xsPdaRir6C
	H5mvpQHyYt+vSUPTjoGz1rGcPpHQq3bKZ5pPIz+G9NlL3RKFqQ3wFw+BKVMiXgfIqjf1VJf5BOm
	9uUhR7h4GP//KOnwA7qBODKYU4hjG0R5zrgxd136NuIWCrYPyErvVKHRv/PmBefkOUHSPL7V0ii
	PM2tE8lzpFHJer+D5faEKQ0Arhr+CTB8qJQLjoxEZcp1rZA78yFnWn21YONHn59fmzGrY7E/E9U
	86I/+m1Mme+kV3jjCrLyrB8hbGMcv4ugFtvxzMOLZebMQ/BiCpzxT2YvujFvQuqm0wRQNOggrlb
	VAYCgpoFuoym02r4TJt0ot1gz8M3eZSWR6MT5dWKj6Uhyroh4LJz5LpEEWi6hqNbpq9STBmdBQc
	hhmNy7N+0LAWjehGhN1qeBdhZT6Eo/Fb8GS05I+cNLb1IvaQ9FKI3XOmONASv7+9lCH3D/3KY9T
	+uOB5rX40kKBRLuGC9WELJ39OAsn7I2KaKav74Z1+l7TInjcDmQ
X-Received: by 2002:a05:690c:2784:b0:814:5f6c:5ba with SMTP id 00721157ae682-81be06393d8mr19124817b3.15.1783376273736;
        Mon, 06 Jul 2026 15:17:53 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:fc23:ea94:e881:d8a4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81c424b024esm1644927b3.31.2026.07.06.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:17:53 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix error code when writing beyond volume capacity
Date: Mon,  6 Jul 2026 15:17:39 -0700
Message-ID: <20260706221738.140271-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/564 fails for
the case of HFS+ file system. Test-case expects that
file system driver reports -EFBIG error code in the case
if there is the effort to write beyond 8TiB. However, HFS+
file system driver returns -ENOSPC instead.

The root cause is that hfsplus_fill_super() sets s_maxbytes
as MAX_LFS_FILESIZE. VFS therefore considers the write
position valid and calls into the filesystem. Because HFS+
does not support holes, cont_write_begin() zero-fills
the entire intermediate range from the current end-of-file
to the target offset. On a small test volume this exhausts
free space long before any block-number overflow is detected,
producing -ENOSPC instead of -EFBIG.

This patch fixes the issue by adding a bounds check at
the top of hfsplus_write_begin(). If the requested write
position is at or beyond the actual capacity of the volume
in bytes, return -EFBIG immediately before cont_write_begin()
is entered and before any zero-fill I/O is attempted.

sudo ./check generic/564
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.2.0-rc1-dirty #50 SMP PREEMPT_DYNAMIC Fri Jul  3 16:22:27 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/564  13s ...  43s
Ran: generic/564
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 1c57c873f05d..2ce6de574fa6 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -43,11 +43,19 @@ int hfsplus_write_begin(const struct kiocb *iocb,
 			unsigned len, struct folio **foliop,
 			void **fsdata)
 {
+	struct inode *inode = mapping->host;
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	loff_t total_capacity;
 	int ret;
 
+	total_capacity = (loff_t)sbi->total_blocks << sbi->alloc_blksz_shift;
+
+	if (pos >= total_capacity)
+		return -EFBIG;
+
 	ret = cont_write_begin(iocb, mapping, pos, len, foliop, fsdata,
 				hfsplus_get_block,
-				&HFSPLUS_I(mapping->host)->phys_size);
+				&HFSPLUS_I(inode)->phys_size);
 	if (unlikely(ret))
 		hfsplus_write_failed(mapping, pos + len);
 
-- 
2.43.0

