Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4F27B35B
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783899721; cv=none; b=M/e2VuNTUuegjF0krmRPr6VaGbD8l5N+d/fhpWqTZ6SHq4EuCIx7WqbXGYD6C5vatcL3ly/YxPi0A2ixws+lMbltIk4CCPkKFbtQrXbkVNZre6Gasp5Uoes0/YSlBQZ6bbXCU0BuyLVk5GGJY9QgpuhrSNeTar5UAwdnUn7UJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783899721; c=relaxed/simple;
	bh=Gus8jbYJkmsWK1Td00YMeQsUjHCsejAnbeRtFN2Wo1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6JGAjEZIImPgF2doLFhHtqlBVraaZpj9gj9nyhczWppJuMD2JdjkrwSMr1TiliaUWPDona+WOBmoKEl8s+FGfsshN6i+3ST2+i9iSySZcDpZpTZGd77mGYN1F43JK6YIyVtkB5htmGFm3nGOHPom02SlwyIAxARwrh1wIaKlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=as9PKvLV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="as9PKvLV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso215137a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783899719; x=1784504519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HEoxedDY+CxIxJPNu4gqzihdjaJt6oxwDBr+q3d3y1M=;
        b=as9PKvLV87yWxszqOIQyNlykg+ZkI9fdGTkQEDSRRJEPWm5zKAO5U2rJuiTnhBWwGz
         1tujJEw3yzF3ykUefIYfnbsn4l8jMPRitgH30nzNwN0f5whieKutI6r4hmZjeQrkKkQT
         ImtLvbZI77+f7Be6zdhKnuTGbqjIqdulF257gO3OJsO2tFBa6CQEgdK8/G3/81i1/oBo
         qiv3QOiyW2QTsCQPz6ifFYRUMloBdEi3uIvO8P5adM9BzT3ydCRCR2VRb6FGxkCe9fN4
         8W9fVT5ndIeBFf80n/YThWLLLYZun51OKOV8xINwSyY+uR67mxLP/7ZHM3ZXvVys8qNM
         jl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783899719; x=1784504519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEoxedDY+CxIxJPNu4gqzihdjaJt6oxwDBr+q3d3y1M=;
        b=HbXu3aqCNx213FYukBaGeSqJvO76MlW1+uQ7AztzDHgYmbmx8frjOrLePiDtRSmfk5
         S6E2oXUZIJvvbw7M2iUmYP/UJuodBFnXRQ9EzRLYdluDd+9m9RQd7XkmFGE3fNsgEXbp
         9Sdh9nGSjtIFTviwZDJKgIlzJRK4ST/oc0ck8e5dAQr8p7Dpo8UvkLapIqskDY/exIut
         NaO4V1loszzKHWTE+GPrTJn+vAnIfO5a7EeyBdxH4iM7f5iUrkK/QhZiO61nwCkB63pv
         END/VB3oKHfU5NyDQ3h3m7DWnD+gyDTgCaNrtHv7zMn92I1ZhK0eqXXlfenR3fANZ1VJ
         3NRg==
X-Gm-Message-State: AOJu0Yy+zcqyHEzLXRGVlPvUvR1Ky3MzSLOond2Bxj3nxmIQLoaj/Ng1
	SJ8yl86YVrWjNbtGroIgYSWq/wBaD6hGW5rakBCyV4zQ9sQiaVwlZJsK6iiPf1Kcwg==
X-Gm-Gg: AfdE7cn7Kx8moiAprb/YNidVvPYkA5eaeGbLtnGax5RYDloDNKjjVkTMONkUHlEVaKJ
	ounYRucvGzlCEz+ImKR0W41L/omXp/SRXGmcM8ac6vYMB/fKwr91X2qxXrY+HymkrfT8vYnArID
	nX/88kw5anqKeZfMArUWZHFl2p081s5f6g3nYc4nozbWKgI9/bWADj2B297JkVEBd93Ypjxm0yb
	o+D7pwRJ514nzE9hqCrsq9K6xL3vmRGyE9I7tpQjPZW6aKTsIYqrQtraIiBGOCP0eawDLDVNhj3
	7u8CjzZolIvBj9rHz8KvzRi7qngi0et1xnFkaNN/7j4l1MLcWoIxyrhInm7rDQQVEM6QUFLek6I
	aJtvJ6bGBKy1POfKR/rqeyWkOApxQIClnIyjkjhmw9c3I48LZNQiZELjmAZhN9FBWCOwXnc5yOj
	wxG70IZ1K8
X-Received: by 2002:a17:90a:e70f:b0:387:e0cb:7ee with SMTP id 98e67ed59e1d1-38dc781ce28mr5423917a91.34.1783899718788;
        Sun, 12 Jul 2026 16:41:58 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec82:d7be:f961:4fa0:51a9:cde5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506dee6sm5501100a91.4.2026.07.12.16.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 16:41:58 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] isofs: fix out-of-bounds page array access on empty zisofs block
Date: Sun, 12 Jul 2026 16:41:50 -0700
Message-ID: <20260712234150.3213467-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zisofs_uncompress_block()'s empty-block fast path returns
pcount << PAGE_SHIFT, ignoring the incoming poffset, unlike the
decompression path which returns bytes produced relative to poffset.
zisofs_fill_pages() uses that return to advance its page cursor, so when
the zisofs block size is below PAGE_SIZE and a sub-page block leaves
poffset partway into a page, a following empty block over-counts and
advances pages[] one element past its end, after which
"if (poffset && *pages)" reads pages[1] out of bounds.  rock.c only
rejects a block-size shift > 17, so a crafted "ZF" Rock Ridge record can
set it below PAGE_SHIFT; the bug is reached by an ordinary read() of a
compressed file on such a mounted ISO9660 image.

Return the byte count relative to poffset and zero only
[poffset, PAGE_SIZE) of the first page, matching the decompression path.
The page-aligned case (poffset == 0) is unaffected.

  BUG: KASAN: slab-out-of-bounds in zisofs_read_folio (fs/isofs/compress.c:290)
  Read of size 8 at addr ffff88800f5eac48 by task exploit/142
   zisofs_read_folio (fs/isofs/compress.c:290)
   read_pages (mm/readahead.c:184)
   ...
   filemap_read (mm/filemap.c:2814)
   vfs_read (fs/read_write.c:574)
   __x64_sys_pread64 (fs/read_write.c:769)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  The buggy address is located 0 bytes to the right of the
  allocated 8-byte region in the kmalloc-8 cache

Fixes: 59bc055211b8 ("zisofs: Implement reading of compressed files when PAGE_CACHE_SIZE > compress block size")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 fs/isofs/compress.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 397568b9c7e7..3fda92358e22 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -65,12 +65,14 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 	/* Empty block? */
 	if (block_size == 0) {
 		for ( i = 0 ; i < pcount ; i++ ) {
+			unsigned int off = i ? 0 : poffset;
+
 			if (!pages[i])
 				continue;
-			memzero_page(pages[i], 0, PAGE_SIZE);
+			memzero_page(pages[i], off, PAGE_SIZE - off);
 			SetPageUptodate(pages[i]);
 		}
-		return ((loff_t)pcount) << PAGE_SHIFT;
+		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
 	}
 
 	/* Because zlib is not thread-safe, do all the I/O at the top. */
-- 
2.43.0

