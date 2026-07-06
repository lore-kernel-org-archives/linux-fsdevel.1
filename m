Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05663955D7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376300; cv=none; b=WP+F/i8wX8cuz07EmbwNSCcS/hRJIpS7i9sJf+LReeT6K0x8Tq8+NSJMCHZ8AMkkmOH6OfLSlhqiBxcqRGoklW9dgg2KL+1VY9rI/yf53BZnCNBj4boGOc9KrT8AUNArNEVV6INxvdffAVzFxtonHJ2m2mM3yj15zSzLiWpNaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376300; c=relaxed/simple;
	bh=vVu1/ZfusyWyUlXSHFbQ33ZMYcoaMsuREt0pDNgM/Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvIV0eDjhAZhC+ghsfWkNSYP73Z8Apc6xGmdepmO4TyIf7nSDxwbVljnk7dkeYez9AKfb9szL6jc117j2NX6E/pKm0eVBoOhBhSlMiwu/C0ZQPa3GclAmTK946Q/1m5mi+rEs1ijta9BTFY3Ahjza4P3fjwhrlKJKeq9RgV6t0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=dkyqEz79; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="dkyqEz79"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80e46c00f3bso42562267b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783376298; x=1783981098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8kit//p+j7fVOKhkkd89j29XfkkpMx1ayw70tlBpbA=;
        b=dkyqEz79md2PPAaHVCeF0b1xteyeuSXkuYIm31R8pW+1ySTwM7grRVyhnTtl8F9P4d
         wMYEH23CiLNaZxr+sGLQXiTB/KSia9YaLl9Ssr68J2YUt3ZOj4JE8ANjr5E6J0i9w2MG
         SYkwchVroPyAQVGaVVxnzpPMxU7OFneAoHi1w8lD66gU5ySY/ailV4sGZesv95EiIIyY
         U5MIvU9oe20p68jevaitMVUTW+6ek9Hcy3rqwAcq98WmwjCC3//wa/qrmFZbw5puN9qL
         jYlW/RKsrh4Iybc4s8EmPngSiA6o1IbaNnhKMHNE3tLqxiYOQjQI/96CKu3BHCcFghiv
         kaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376298; x=1783981098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8kit//p+j7fVOKhkkd89j29XfkkpMx1ayw70tlBpbA=;
        b=LMtjLl3gQCqCRO3a5zWtTm9X9hvpaYOIjF9cx8IaIjVmyhle3UENUp5vajCCIDUVno
         bIN3el2nZ60lynn/tkB6Dae4jIPOPXYj/6qwL00s1TZOftsD/e+dp4pDL/enSDrNStst
         Q3cmqpzwYUpIcgOXK+5A/+M4nr39Ez0Ki28EDwKfw7ol9PDrvEQj8RSOLkVncPr8dC4T
         QDdUBcslQc1U1BBG7szXkykd7uPT3rDE3MOei0XgsJlFGwOa7a3hene1lRwpGjXZ6GJ0
         W7AP0S2OAOmk0SDuMtn33DiZv91wrs9DqW45yTI7AQMfa5hwpK0Dz3GMGg4LZlu5CVmI
         M1tQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcSUlS4a7ewPbtsWKANrFArqdZ8Cww4IqeYSMQvoWk257+IsEhmiTkszL0taVpSE8qexEZETmqDe5s//6U@vger.kernel.org
X-Gm-Message-State: AOJu0YzTB/OUyABNwvdcd5BcIX5Wrw3Yd/9TUVpGLJEA9N4rMeeEC6lD
	jUTZ0Ad3HFhhfzcHk8M6xz+aZ5qIlVZQUVyDNw860Gw1KubeCI32gVhnlA7A2c304a83veGcVEe
	22HlfixA=
X-Gm-Gg: AfdE7cmGDkMZE9c/EMzG03AbzPtiqL7O5FTjf3hyR22h17y7+0RTBu15aiLbEUgz3Di
	zZ9DevkrLMFfYwIDXBork0H+9hHlm9nzxc3SWk5lkAedtza49KCa+dn5S5mtsUVeWVZ82E7hJeh
	Fbh5kWOD8Eka5n84gkVKi0J5pVqbZ95AVUi2ubKOYHBIkAHGjYi8JGpXDqy0ghZknwmWjFn4QiI
	yiMc/f6bImVTF1SGhXxYFvM0ZRxDfpsEgYGbmtDVygtaHHQ8QnaDymTNGRnUjQBVS8X8G6LaFqN
	V2hfAmF8gw+iR9MP7uylEOI8KepS+9N+RkpmpB3yXbJSFPSnRtcN5jbpvaZ1fPHUc8B5daw1Uja
	OJ1NLXp+qYCbI2xQ3+7WNk8z8+1g6GbLaboowIlfx+7ha7h98j6vNkKLqaWTOfqOkllEhOUnN12
	UsW/MhMPjnWYHWylynmJWH1noAqsLKNKEX2vbAAffNcaVCXiaboPto2I6xl95FEpco9uiQsXarm
	eJI4U1SO/2TWu/en5/1nwML9tbxw8SwH563AZtVJ7k6S5Hz8K/V+lsPKb0vE/w=
X-Received: by 2002:a05:690c:6a10:b0:812:a784:9989 with SMTP id 00721157ae682-81be2668beemr18102757b3.43.1783376297609;
        Mon, 06 Jul 2026 15:18:17 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:fc23:ea94:e881:d8a4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144af52027sm63692437b3.25.2026.07.06.15.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:18:16 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: fix error code when writing beyond volume capacity
Date: Mon,  6 Jul 2026 15:18:05 -0700
Message-ID: <20260706221804.140295-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Likewise HFS+, HFS has the same issue of returning
the -ENOSPC error code instead of -EFBIG in the case
if there is the effort to write beyond 8TiB.

The root cause is that hfs_fill_super() sets s_maxbytes
as MAX_LFS_FILESIZE. VFS therefore considers the write
position valid and calls into the filesystem. Because HFS
does not support holes, cont_write_begin() zero-fills
the entire intermediate range from the current end-of-file
to the target offset. On a small test volume this exhausts
free space long before any block-number overflow is detected,
producing -ENOSPC instead of -EFBIG.

This patch fixes the issue by adding a bounds check
at the top of hfs_write_begin(). If the requested write
position is at or beyond the actual capacity of the volume
in bytes, return -EFBIG immediately before cont_write_begin()
is entered and before any zero-fill I/O is attempted.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index ac4a9055c5c0..a630a6c14ee9 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -49,11 +49,19 @@ int hfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 		    loff_t pos, unsigned int len, struct folio **foliop,
 		    void **fsdata)
 {
+	struct inode *inode = mapping->host;
+	struct hfs_sb_info *sbi = HFS_SB(inode->i_sb);
+	loff_t total_capacity;
 	int ret;
 
+	total_capacity = (loff_t)sbi->fs_ablocks * sbi->alloc_blksz;
+
+	if (pos >= total_capacity)
+		return -EFBIG;
+
 	ret = cont_write_begin(iocb, mapping, pos, len, foliop, fsdata,
 				hfs_get_block,
-				&HFS_I(mapping->host)->phys_size);
+				&HFS_I(inode)->phys_size);
 	if (unlikely(ret))
 		hfs_write_failed(mapping, pos + len);
 
-- 
2.43.0

