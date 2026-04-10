Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774233E377
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815895; cv=none; b=Ht6zrTgFb2o37SYUztxIRVERGLdR32TyjDGigvFP72uY+LaKkJh0g4oP/iqVmQsgvNDKXZvXFDZeH+G1EdSjV7ZbDiFa13bqn7eStqHRmHiYXRoq4WefDyNAC5gToIRuJ83BnZgy9U56mgMPBtS+BfhAc17dHWwXfsOf8A0WxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815895; c=relaxed/simple;
	bh=VnZIxKmaUTXGoKo6wGhU2EVsNOdIX+vEPHKn0bXhH7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=biFXsMm/saUi8hlSvpCX5oPh+wHo3wyuv1FUd41fqqE3STHF3LG9wbff0rVY/ICnatzxSpp2UFs9zpUUKHCZXXMapUKbkcgON0UCpyH5Sqgg825pYRIxsDqo42hS4YAGaWWyijz6evOtnkcYZ5AULTj7EXl9pACqOLz7UNRsk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSK86CZh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSK86CZh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488d2079582so15373375e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815892; x=1776420692; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lqo9R/XWBFDRhtrRCH5LCTBN7UeMvzrHk4D6qdLAmws=;
        b=pSK86CZhZ1Z85iBA0at+18JUCHvZrQ0fxnUuG4NwxxY70lRXxIoWQJbvOnuYnNwnBt
         Ej4/Q81ePtvy6wOVCyJbXFbF4fNat9QuAoocYlvfsLTKjt/TuSDUZywJ8atJ07y4Hvrk
         BE/TgceJ3Mj01saagMtnAvkugvQU1Jy7AC7H6oZI9ha1OtORJb0+0lXJDKQFTPceAqFw
         uABr7RNOozof0gz2gOE3rwfMmqXKX8u8mQS7GmXRmgg6ckMX3dh9KgrbZW/1Y472nav3
         5fgZp6eaJQgZz6n8EXfU92gDE/EbKQGHox1bErco6Na0PvTrW06SpxccFzyz+ku1w958
         ifjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815892; x=1776420692;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lqo9R/XWBFDRhtrRCH5LCTBN7UeMvzrHk4D6qdLAmws=;
        b=aYsCdtGSCvo7UzlwB4qMpwzt8QaxeGTtVk+FUI+Yk5bLh1PLpNZlvYZa+F1e5NhMLE
         E8NrOVvU+DhYfMuGvfhRjjh8W8rYHXIWMGUkvUgHbKZ/6xbJrDoeKJ8SvYVAO0c6eMnK
         ytKIczeYGnsRb1S/TQwkqngpGVoiMHzURCLVHJz9c6/9rkFOOJBMBy5YOCVqPszV4rTM
         ke8WTsQD7NfgCsDcj8TDLJQKNv9BGB70/ckWo8yINiNthYO9C46caU1ag+nSLCiFTrX+
         tum8USrOtC28RtvgmV85G6WSBznDJ9z21V1OP66fKN5Trv+FeRqkwpWbah6HwSkj6Goc
         2Cjg==
X-Gm-Message-State: AOJu0YxrJUDsChOMVHjFj9dvLzv0SzZU7R/s8zb7YN44lVWv20E/H40d
	bQVbQh0VRcZiLy25he8tMEcI7rIDrd9qxVoDj0kGvV46Kw8v9hp8ivhJ
X-Gm-Gg: AeBDievROceFv4ZVghS9bLjV0hDcgGMxLD3xqF5G4GbaYvDDTWss4Y5V8GPc1PrRZ2f
	u0FB1smTwrjhqLtLuxW+IKsIrc66vO4ipvB8XnhuK5Y++kRZ/PJpO2Z1xcKBUg7YTOVunhVT6QZ
	uOVQrdwh1nJBSYwKaJFgL3H7iF9KPbpwSQrqkZNCA7thFO9ib6CueIhCKfPLRnaoLo4CRPdELED
	AqFL8dikpbQZuUYby0b9KAXxNVMjzEGmVvZbQKY8i8xeOTfgq/lBlvx6WajrSQtSUP7gXEhUMO4
	4m1OrBqCoXbsQQ9puPniy4svradFOs4viQXjfWxvS/nxsTp3SRBdP7XJ6qh6m3Ru8qI8HW/9bOh
	HvKpwnY9stEM8VueJjGu+U2Vd+HkaiSaHwHzUvG0PsqOJ8tfJaei88+z37FKYwvy5wojUyOBe/z
	IDlvDqXYb7UxzxqpspYLI=
X-Received: by 2002:a05:600c:3f0d:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-488d68769f9mr27640345e9.26.1775815892151;
        Fri, 10 Apr 2026 03:11:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f229sm88612795e9.3.2026.04.10.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:11:31 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:11:28 +0300
From: Dan Carpenter <error27@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] ntfs: update attrib operations
Message-ID: <adjM0PIEaYLUe5NS@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Namjae Jeon,

Commit 495e90fa3348 ("ntfs: update attrib operations") from Feb 13,
2026 (linux-next), leads to the following Smatch static checker
warning:

	fs/ntfs/compress.c:1377 ntfs_write_cb()
	warn: should bitwise negate be 'llong'?

fs/ntfs/compress.c
    1274 static int ntfs_write_cb(struct ntfs_inode *ni, loff_t pos, struct page **pages,
    1275                 int pages_per_cb)
    1276 {

[ snip ]

    1363         if (!fail && !allzeroes) {
    1364                 outbuf[compsz++] = 0;
    1365                 outbuf[compsz++] = 0;
    1366                 rounded = ((compsz - 1) | (vol->cluster_size - 1)) + 1;
    1367                 memset(&outbuf[compsz], 0, rounded - compsz);
    1368                 bio_size = rounded;
    1369                 pages = pages_disk;
    1370         } else if (allzeroes) {
    1371                 err = 0;
    1372                 goto out;
    1373         } else {
    1374                 bio_size = insz;
    1375         }
    1376 
--> 1377         new_vcn = ntfs_bytes_to_cluster(vol, pos & ~(ni->itype.compressed.block_size - 1));

This should be ~(loff_t)(ni->itype.compressed.block_size - 1).  Otherwise
it zeroes out everything higher than 32 bits.

    1378         new_length = ntfs_bytes_to_cluster(vol, round_up(bio_size, vol->cluster_size));
    1379 
    1380         err = ntfs_non_resident_attr_punch_hole(ni, new_vcn, ni->itype.compressed.block_clusters);
    1381         if (err < 0)
    1382                 goto out;
    1383 
    1384         rlc = ntfs_cluster_alloc(vol, new_vcn, new_length, -1, DATA_ZONE,
    1385                         false, true, true);
    1386         if (IS_ERR(rlc)) {
    1387                 err = PTR_ERR(rlc);
    1388                 goto out;
    1389         }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
