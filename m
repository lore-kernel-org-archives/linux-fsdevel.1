Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15A2EACF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787720980; cv=none; b=XYeNAEaDL4ajqNcsHCkx+AjVB6aLXTmRgPRqP62I1fbu2cPUXbQWnzMsmvSVlA5fXikd6rODDfh1Wnlsl+JWoh6qJ/VH7kXa9ttYmcf/qwGLfSMbNWMoIur4cF9sy/MJX4c+D7TzQtP0eD+yj8P9WIS1qJGQJqFMUod3ll5w6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787720980; c=relaxed/simple;
	bh=UxZbuizH0HeiOPp8+t3h6jM8AIqH03vW6UKn1VICBYo=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=fqeLmcJcbhvJiZ5+ore8jfqOC+oLuHUfXArpRn8V53b244Lvx6eRCajsVbKX+QW+v4FMILNDKlO7DM2Gr/U6vnGhDbgImvA94ejsX5hU3zKeqWScb4GoHjAi9+vrUMBRveIssJ6vfeXEQ9zKCY0qRrTleRCVNMsEdTFQ1k9Bucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evcnExV4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evcnExV4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d01663d816so5358485ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 22:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787720978; x=1788325778; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0tfmhvTOsxdSxw8g7YExrn/7pyH78KUdAhaRwKC1CMg=;
        b=evcnExV48EDciJJmxwOIbVKcZVVQkcX1F4ycjRCGN4GOG1QrGr5O0o0ywgasCmTHxj
         glgMtEkzQ/vlhFjT2GeCsUBH6GoEBKQktGI8Ay7ffTIbNRgCypJpokLUCgecv0d0Fk8o
         k9wRRF7+/90YQ6oTLE7ax/5Ni1f0C784jPa2c6QmtpBJmZ025nkrakDKnyzS3n4F7Vth
         h9t4rwYfJMvvYKVLffhm1l0/TjeNGJ8F2vq9ZHCNzXdvXCOH3V70VZ8vGrqFIEEyFenD
         p65FdMCKU8rDH8EBjut/cgQ86pi2uBen68HlqNlhWR17sWNzMaQkBcvH+8TWVE81VaTc
         PJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787720978; x=1788325778;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tfmhvTOsxdSxw8g7YExrn/7pyH78KUdAhaRwKC1CMg=;
        b=WFqLgVvkG94TAehvNp/iURXsKEB5kJjv/qTGKy+V9c4yRSM66+Eae3ddUEV5Hxs4HJ
         NTSXsqOl3X2XNAcZ5+gcuUtr81MM6IfAupwb8153CJMa8TODRJPTHkOHOG+gbibL/ln6
         ZFvK+Lcyw8xPWGbiKdW/u3cXT4N6au/bEf/9jteP8S7/yLYAjuYcIWq2HpBKTTrWgu+F
         B+IbI32rrq3noZe6wohRzfru6aasF9majVykg3qH+PnAxwTBuM7fC6bYOs8+0OLVvvGi
         8mYsY2YwXeqNQRmDdb+D+Czq7yJn7pC+03rkJZUmgsVcxGLhG4nkhCQg31nCL6iERLrn
         3fhQ==
X-Gm-Message-State: AFuF++lSM//ME8yYWRieKEe9AkMkJYNE/57axIAK27mhk7SUbOVGEDbt
	ZmVjJh2n5Wu40jW8/nAyXdYZ8KWKvXCY2eBvtRD4nfpBlDwbqK3XbUoyOMdBrA==
X-Gm-Gg: AR+sD125S1X3h2iemxM4RuI2zdomT6mo4vkc8dJIC3eV146dzt3N5eAjWGdaJ4nutzU
	4BlFCSqWvdOzY/MupUvImXv2oobJbUUH4D3NL8BzXCk3E2JOL8VFCL2aBnMOp1Snj43fafv9Arg
	7mc8bKbXrpRx7cDkkrymfWpB8u5pqtE1AH8fvjHkbylU4+HJhO6aSlIqWonCYt68NJViltpFF0a
	lLUUkJ57lXjihJf/rDvl7y4gWRbqASm/3VZpCj71B88grgqlj7pEVL4fhOZ3t851hQQB9u7FdXb
	lmhrkpAISFvyoXrRNCvTglEgfr7V/VGp6iV8zCN3DXTFAllsvJ2ToQ6UZ1MEOhB1mGDKZHMtX23
	unNSJV2Uy81Hc5f/jnHBp7kQr6pgl2R0UH8ue3UMmVCAd6S7HfvW6iZkDdIWr9xDxsU62Fau+k2
	JlnpWtbDj90aEn4nO4bEm32XhnjziiqbYZSRgl9G/PjExzjtwcrh1M5Bnt4vhDaYgqe1LJID83D
	M4ZInJUN4ucWsWkM6QhhRkbxd9EEeQu3X46ZtjO6beY+Q==
X-Received: by 2002:a17:903:3d06:b0:2d6:e4ff:9cad with SMTP id d9443c01a7336-2d707a5d171mr67324455ad.3.1787720978472;
        Tue, 25 Aug 2026 22:09:38 -0700 (PDT)
Received: from localhost (75-172-73-38.tukw.qwest.net. [75.172.73.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7049b953dsm4174855ad.37.2026.08.25.22.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 22:09:37 -0700 (PDT)
Message-ID: <6a8e7511.9e2d85f8.1d4e3b.c404@mx.google.com>
X-Google-Original-Message-ID: <ao51DgJnzbKc4voE@DESKTOP-HH660AU.>
Date: Tue, 25 Aug 2026 22:09:34 -0700
From: Dennis Tighe <dennis.tighe@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ntfs: reject invalid sectors_per_cluster in the boot
 sector
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

is_boot_sector_ntfs() checks the boot sector's sectors_per_cluster field
with a range test that rejects 0x81..0xf3 but accepts 0 and other
non-power-of-two counts. A zero value reaches parse_ntfs_boot_sector():

	sectors_per_cluster_bits = ffs(sectors_per_cluster) - 1;
	...
	vol->cluster_size = vol->sector_size << sectors_per_cluster_bits;

ffs(0) is 0, so sectors_per_cluster_bits becomes (unsigned)-1 and the
shift is undefined:

  UBSAN: shift-out-of-bounds in fs/ntfs/super.c:673:39
  shift exponent 4294967295 is too large for 32-bit type 'int'

This change rejects any non-power-of-two value, since it feeds the 
aforementioned shift via ffs() - 1, which only yields the correct shift for a
power of two.

Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
---
Changes in v2:
 - Check that sectors_per_cluster is a power of two rather than only
   rejecting zero, per Hyunchul Lee's review. 

is_boot_sector_ntfs() is where the driver decides an image is NTFS, so
rejecting a bad geometry there stops it before parse_ntfs_boot_sector()
computes ffs() - 1. Reached by mounting the image.

Built ntfs-next with KASAN+UBSAN and tested: sectors_per_cluster = 0 and a
non-power-of-two value (e.g. 3) are both rejected with no UBSAN, and a valid
volume still mounts (create/write/mkdir/rename/unlink smoke passes).

A reproducer is available on request.

 fs/ntfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 2fd7db672..76f62dac2 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -557,8 +557,8 @@ static bool is_boot_sector_ntfs(const struct super_block *sb,
 	 * Check sectors per cluster value is valid and the cluster size
 	 * is not above the maximum (2MB).
 	 */
-	if (b->bpb.sectors_per_cluster > 0x80 &&
-	    b->bpb.sectors_per_cluster < 0xf4)
+	if (b->bpb.sectors_per_cluster < 0xf4 &&
+	    !is_power_of_2(b->bpb.sectors_per_cluster))
 		goto not_ntfs;
 
 	/* Check reserved/unused fields are really zero. */
