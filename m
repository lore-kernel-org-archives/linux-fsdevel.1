Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353778;
	b=ymXKibu3mrrPK+0bRZgxzL0NLojzZSDcm+owImYUbOWSK3GYV4WryX+37tijV2oEkLJB
	 2M489pjXEqSNr3TdBCWldBtq/0oF7/ulOTEqQwy3uXGXNRstAdVl+jT9mKGgIE7TLHmMr
	 W95e9InNyFxlHzVm3dy70UGdXNv2cza6vNCeJt0q/+wbsrOD1dnNb8azb2IFGgFEqnADq
	 ACb5TuJG+lWG7qE4fQ3cZbGhZUHwnmxQaJqBmMwjaM5l6FCox2oTd8OYGN1ly5qbqem6H
	 tyMJSjqKhTdsVqob0jyfDDFwAEldtTJM92CCmWLTDnDS4qOPFZkX6gkyVny+aas4LwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NdUGJbS39nDkhA46SqrE2gint9HNs+u12Kr6VpkgKT8=;
	b=ZYuGGdj4zKeeKM4rP539nwgFZbuz+9pqv3V84HkIX6YPYigDRZsbpW4aGsmW3DhqWBd+
	 IkIhomLMWQK8KKT5n24lbRnBkvn1nGDl823qTCWaiuezJjUFi2sK+xnq8lnjieXnY6RDm
	 p9yLw0KNhPkr00QlLOGdgU/RHhPEsjRXsA1R0l7Shbxh0+uo5dfOgZCDP+KiTZoJPTLm1
	 SN3w61JkWqswT32+S8cZyEsCAg2VXJv6ojZ/ISgj1Y6sNY2H03Gwm9lGQ7fuC+p2iKj2S
	 YJNkC1A02dActN/ko5vuf2hy0BcdNqTQ1LpPS+p94LRIuAXcVCScyOfllccfBsC0k0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kMj3tsu8;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D47606A32D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 23:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15D47606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kMj3tsu8
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b305312e4fso22686277b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794353777; x=1794958577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdUGJbS39nDkhA46SqrE2gint9HNs+u12Kr6VpkgKT8=;
        b=kMj3tsu8eSLGLEImMjNVkYYNWV2qyqkcGuSMqpR3GwMyTU77dtVytNKlvCyVV0+5jA
         4a158RkljBvOQgpJCUqo9RsOjO63b8gkx+etod+K41JxopvTezXZcvMyN8I2AAoZaNZW
         VA88jfs3kXqg4RCyPZ9qcLQQ41S3jd6RrAYyx3e03w40A2S85ByffZlauKqmTEHJ/Wbk
         IbUkfCSnw+U2qT19GZO3YptTbAgYSk8zVXIqLCHgYhjWzDg9w3DQMVagYVUwXeTYRKkn
         4Wgdipnj64b9wukcsXTtdzRpPGn0FHUwXYuWXYAusQ5u/tcdX5Op70JZV6aWKm7v6TrP
         LTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794353777; x=1794958577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdUGJbS39nDkhA46SqrE2gint9HNs+u12Kr6VpkgKT8=;
        b=d2InV6NCiOXeOilRmJYAKb3dB3GZ42csQHH2ZBGUdufMx8kbljd+OMxD7tKvFwH1tO
         li48/l8UfWNWOTb67Wco/4/6HmdyeUIfkXEthSZu/KHNdqXKOJtt0gL1KwrQgXOyY+TG
         f6UQek+wsnTaMVWW+ORPjXS8+UqEYWFFvoG6/CkUWoTwzceBLmuRXz4KmzJEHfT7jB1k
         6HcZHHhYyfFkaOSyar7tSShpjpZP9x8VglqGCa3P2Z5L+KNiUMwpChhYcbNcSjdXaEZa
         Xdiy8cOv1f7rHyGCuWK8mJl8mgRh7VPRPjO+KXM890fZv7dK6/X0uX5e7N/LIg1JNjnw
         j4FQ==
X-Gm-Message-State: APuU4Z9SmWdbi2VvZiFXzf61Z11rwVb4nXBGaFad+42jcdNCYe0oU3f5
	pLzaS2PjDNS6JjBeZmDdSz6CeW63GtkTPB71+2tGxZ54bz7QIM4aR2MC1LgDocqdlEU=
X-Gm-Gg: AYBFou1+Y8gIshhwI+TN8zxA3s1dzrhGkAtlIU004hM0u3tHPa3F+USSidTn8WB8lZV
	B8gQfzlLe4RThiK48ZL8NzwHaAtW2D6v3wJRGNyaYc8L6j1aRo6Es9VlzZddrOxwz5mQh7rP8/j
	Ed9bJV7MJghU3KW+Y+I72KqLe8hksJ9qfLmesHwHqetzfi6F1d0LrJkV6ZhlWIE76uYU8sDFxch
	+BcpT7VggXw8ZOEUmXlhnBMkql2bkXL5l9Z5J8U7SAtFceNBimN7lfVm6KQC5kbavenf/1+XLFk
	KPmChr4rp5c6QylW+aDEY5Nhlj1beodpIo4ZC+ZtRJ0QxLoBUkX9EzJW4DokCfJ9OR2NSrSr5N3
	g3beg61FWjy4cwCVN9qYDfT2wY0FUyxvZ8Z+OGRun+5S3jaWMAjwh/oVzmXJt2qmihpgAoO5Ysv
	kBjHFXetFsxutTgiu/j1yi1wOix0O05buA1X66KBpWFBz0wyrhPxJEEAaPpvav9WnkAKGou98x3
	q3tGF6k3chYp+eSwJ7x2d4EkSbxU+s6IdyH+Q6b4YBQZwBHa7ih7iU+4wQUW5JYeS6vVsJppffG
	DzlVqOe0GrDPyUPoa7Gr890rroVVMoW9wD+8ERJlK8giJX+j5lIyO7MXAdFW5OM8KyAz2STDpDK
	Ipx+k5Z6n/VMexxI7g5J64DML3/aplIXekYklZfXklDEtsbeKit5LYo/mKDkY3UxMvPG6uyw=
X-Received: by 2002:a05:690c:f96:b0:8b3:2af9:11f9 with SMTP id 00721157ae682-8b3a80629abmr5805407b3.26.1794353777055;
        Tue, 10 Nov 2026 15:36:17 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1541:987e:e160:f038])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933d1047sm31652577b3.19.2026.11.10.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:36:16 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/2] hfsplus: release preallocated blocks in hfsplus_file_truncate()
Date: Tue, 10 Nov 2026 15:36:08 -0800
Message-ID: <20261110233609.561557-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110233609.561557-1-slava@dubeyko.com>
References: <20261110233609.561557-1-slava@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_get_block() extends a fork through hfsplus_file_extend(),
which allocates whole clumps. Also, hfsplus_inode_read_fork()
initializes alloc_blocks from the on-disk total_blocks of the
fork, while i_size and phys_size are set to the logical size.
As a result, alloc_blocks can be ahead of the number of blocks
really needed to hold i_size, even when phys_size matches i_size.

hfsplus_file_truncate() returns early whenever i_size equals
phys_size, before it compares the required block count with
alloc_blocks. So, for example, a file whose size is aligned on
the block size keeps its clump preallocation after the last
close. Moreover, hfsplus_delete_cat() does not free the data
fork and relies on hfsplus_delete_inode() truncating the file
to zero size. If a file has zero logical size but allocated
blocks, the early return skips the truncation, and its blocks
remain marked as used in the allocation file after the file
has been deleted.

Compute the required block count first and return early only
when neither the size nor the allocation needs to be trimmed.
This keeps the intent of the original early return of not
dirtying an unchanged inode. The existing logic further down
already handles the case of blk_cnt being equal to alloc_blocks.

Fixes: f76d28d235cf ("[PATCH] hfs: don't dirty unchanged inode")
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/extents.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index eb7c11524d18..924941440066 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -570,12 +570,19 @@ void hfsplus_file_truncate(struct inode *inode)
 			return;
 		mark_inode_dirty(inode);
 		return;
-	} else if (inode->i_size == hip->phys_size)
-		return;
+	}
 
 	blk_cnt = (inode->i_size + HFSPLUS_SB(sb)->alloc_blksz - 1) >>
 			HFSPLUS_SB(sb)->alloc_blksz_shift;
 
+	/*
+	 * hfsplus_file_extend() allocates whole clumps, so alloc_blocks can
+	 * be ahead of phys_size even when phys_size matches i_size. Return
+	 * early only if neither the size nor the allocation needs trimming.
+	 */
+	if (inode->i_size == hip->phys_size && blk_cnt == hip->alloc_blocks)
+		return;
+
 	mutex_lock(&hip->extents_lock);
 
 	alloc_cnt = hip->alloc_blocks;
-- 
2.43.0

