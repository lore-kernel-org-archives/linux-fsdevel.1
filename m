Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F592EBDE9
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207585; cv=none; b=hqSZBsaX2h3OPqtktDn9UGV7Abf5AlP7n1MV/NlVpQloQrrXO6hN/SuGv/9X9qNxvU9LkuhmBHuO5fA/fvpgqpPGnVh5q4YZn0JzpsVVUuYHoswU4Hi1Sj5ibfsg9byl+T/zS/5BE5ioOGwnzCqETmmO8phU3fVuGJ1IZuZpDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207585; c=relaxed/simple;
	bh=USlhX9g8ltOaIgUeRBTzFSUq/mAvwDRXc+gGEGn611k=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=K5nIOPmV2blH2gaR4yqTt2kr7EJVQ4DgMqCrtS8Ty/yAhmAXqX5IrA7Y4ZLYNI2f/DZUWlLCXRrUvDssjeIJzzSMbJDfKLEePPCzH/MhlQfUPXi5rlQgALBNz+IvbxF02SpxtP3M16Ji+Pzdm30YHnZQmWf1dgNBvXIrLU8ucz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmYJLDhX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmYJLDhX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d560775ca2so14254045ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 23:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787207583; x=1787812383; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lFqWzKAPw9BnDuKrcJ2deig/zofyqA4nB0pnofhUsgs=;
        b=ZmYJLDhXmaE2fwo/xEB+bonrj4mLqNx0XUPi5BOB2Q0yldlAJuqdegIYq00o08YgKl
         auK5nLQVFmqbcjTR61e7ODkPjiHRogTbu7xE8nP2vGhcYsE4PIg9fQVdjUNYsJ51ST3Q
         KDHCf9skNyUoJvAFIjjpmYLEmV167w3bf/E9RotEn0g6oURqyalFMAs/spKSAJdQMyxM
         Ip1EV9rxwSUpUgCwlZUHXNvFznX5c12LCXe7mcWz5BQZ5HY73jKxA2eNZMSUwqsBJSYI
         OcU1l9WkQRBUIW4rhYZcBqQrwW8LTLQJsz0nJsWO4b5fDXgfFxWU4lzSGyUXpTEz2Qv0
         +lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787207583; x=1787812383;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lFqWzKAPw9BnDuKrcJ2deig/zofyqA4nB0pnofhUsgs=;
        b=HX2zxB0nqRRgblxZDibfL0WWKQROO9zTu6QZcIKCDXLwTsUKEcr7K6EOOdatzYB3JG
         whKHEOQptLCw581L1phhAq6idK0o4UhGBMeDxkKB+ZlgDasRdHtdffFHDv703K648d0q
         Rl+ar/A2h25rWD49mFyEju4HzHTPkefFwkt5+c5V+aredubKECRKHwyKerKTau01I53o
         645MVYXFPBzsdsd0hdROCjVkYtGHyiFRrK7pYoqdfX4whnT/owMVhKX8GK8AxyS0Gf1Z
         ttwlRu0vDE55SLCIrXn/P3MTZ1iNsizWcZTJe2K6iJesevGCCy6eUMCt7IgiFEPnCRZR
         LRVw==
X-Gm-Message-State: AFuF++nMljJdbTGgOrqELdy80KX/9emQgAxsZwoN2vo3Psuc6hBX1TYV
	fRhgt4r0IG6Y7fAPY/ipQsZ6XJEG/ZiYRJOeO4w+Mf/UoiPveuepm7Vp49garYg5TFo=
X-Gm-Gg: AR+sD11XcBHxIiqNH3K0jdQq1DQo1Ws0TmQjq82SqSn3TjBjYeQeCMiVI7RxJkIfWzW
	ip5cl/q0swoX3kHLYvWNRLKCHYkAuIFwmKM2JL0HpfRlWt+jxK9k2O88PNA8jhthNvQju9H6trm
	e24nG8ry6eJG1v4h8wGfiTticy/I/E+YIjgAXs5V34/Ucc8N6mWAlFVPVYrN1xmCLoNe9EDpiYh
	JMKjwdA7vCpYIrjX/uc+q8+qSX+Mn8o/er7BY2EyCdYzoHDExcIQ0xhgKM/xF2wR1AURKhC+Vrn
	4yYqQwpYS0aRtA69SHOAeTXydgiUdNSVJTiW+izn2l6RxQrw6ono8Uv9rDdcRhgkmAAWYqsR8eA
	TA+s/lhCTbrcKw5qWvEFocyLvOzONOaqolrLYKkdwvucpyun5ZZSp5QdPfvGBd6chfz32ZSnV1D
	XaVlh1sDr6AQJPwD3z2JEOjg3+a1rqmgPhMWogpkKGNexl7NZ25QUUhHC3vRsOjdqRwHvzrL8aj
	A0gFgTvgC7ibmh1bc5/w/oc359AP6P0ccP3+FIIbEo9uQ==
X-Received: by 2002:a17:903:3b84:b0:2d5:2f49:b3de with SMTP id d9443c01a7336-2d5fd3e78f6mr207097945ad.0.1787207583176;
        Wed, 19 Aug 2026 23:33:03 -0700 (PDT)
Received: from localhost (75-172-9-230.tukw.qwest.net. [75.172.9.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327cbb46ff8sm7081965eec.23.2026.08.19.23.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 23:33:02 -0700 (PDT)
Message-ID: <6a869f9e.c86fb4cb.55bb8.d1d7@mx.google.com>
X-Google-Original-Message-ID: <aoafml9PsP7ITlvy@DESKTOP-HH660AU.>
Date: Wed, 19 Aug 2026 23:32:58 -0700
From: Dennis Tighe <dennis.tighe@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ntfs: fix off-by-one page overflow in ntfs_decompress()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The per-token range check in ntfs_decompress() uses

	if (cb >= cb_sb_end || dp_addr > dp_sb_end)
		break;

so dp_addr == dp_sb_end falls through to the symbol copy
`*dp_addr++ = *cb++`, writing one byte past the destination page.  Since
NTFS_SB_SIZE == PAGE_SIZE the destination is a single page, so the byte
lands in the adjacent page, and *dest_ofs is left one past the sub-block
end (the later `*dest_ofs &= ~PAGE_MASK` then yields 1, not 0, so the page
is never finalized and later sub-blocks keep writing further past it).  A
corrupted compressed $DATA attribute thus produces a bounded run of
out-of-bounds writes when the file is read.

Break as soon as dp_addr reaches dp_sb_end; a full sub-block still
completes, as its final copy advances dp_addr to exactly dp_sb_end.

Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
---
fixing blankspace, no functional change

 fs/ntfs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 76bd806..dc5ad95 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -352,7 +352,7 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 		u8 *dp_back_addr;
 
 		/* Check if we are done / still in range. */
-		if (cb >= cb_sb_end || dp_addr > dp_sb_end)
+		if (cb >= cb_sb_end || dp_addr >= dp_sb_end)
 			break;
 
 		/* Determine token type and parse appropriately.*/
-- 
2.47.3

