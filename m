Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50F253359
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376549; cv=none; b=UP98qMBUcQbomE3atKLDqvECI1Ya8pdhCJ3lFDvxQPoXaRK20zHPz1UryZpc57kZZeifgVeMwQfZT/Aj6LrUF8v4uFyX/UIusqM8lbdC2kDm7cvv7Z5t6F7Jh5d/HdpcJ5COpt8zxnezuOBe+8ZdEqEWX//7svL81yvixYCxM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376549; c=relaxed/simple;
	bh=yAjVVZuAyRsQZlKb5hMbFcbK3UilnxkoGX/35o4A5PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIU8biebl1X6isRtMNS/pAQ2B/sr9amI8i+yQcnu/+XqxrHRiY2g5dStXuttmwNiw3zMqzbu76ze9viM6l+pv0We8uCyS25+pG77otOQmCyQ4gF0kc2pRTjIX9JvHJK53YKjtwBlyKVWxTesiX1zwb0Avn0cwUIDDFUxYsH222E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8Uhr/yL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8Uhr/yL"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso479a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 22:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376548; x=1780981348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8H8TCXoHLu7ANrKx4BAu8mWND3bbfOmise9It2lU8U0=;
        b=A8Uhr/yLof7Z4UjbEcxhAUJxPOjlFrQ4A54Ux5prHg70gU6N7Z3qoQIaW2pC1NY0pZ
         T0o71Gf27SzJxBSU7pd+EA5/xUBs48JxHwiJ1QuC0i3y8uojLCB7B6PJq7d4fHrXFTuP
         wPmM7VcMjHEcWSJvlJT6Yr2JGCuKZf+HPnkyP4kOE68jOshpKWZ5RYiio+drxEysEFO4
         q2l+m6Z/RuWETovh9mlGoWKtE2mg7tcAcQ2aLcuWPLs8dGA7wVDk5DcOVqNgjoFN+Ybd
         EdSydOVzCxT8NR2dkBGoHbmjbDGIMf9K7/YbB9fLQ7k+LuWeClF9ZhDuYqhR7qol3Tb7
         o72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376548; x=1780981348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H8TCXoHLu7ANrKx4BAu8mWND3bbfOmise9It2lU8U0=;
        b=j9vBy7sqme65Sqi8sLEGKUgVJPnoa/lBDGqcNHHNrZYUnIHHk4Pv+z8OzciLHafjek
         LE/vM/to3ZADbvB7/vdKuskQg72V6g41TU+uHrRb8RWoofSOJ9HcD/y6+xKdLq/FmUHb
         QNCDY/AwPHIhfElxnHeGe0lAu8J66VdYSIei//ihRSOe1LCfsAnJL7L0JC6Ffr3Z2y7h
         uAWsfGwAphHiiETAdLlN2P7Mhj+MZoI05K5sl6roKCxCTsvT/k4NVbYOXuDJ5wAWl2ey
         q6CXer+X/IH4iNFzJUSZqm/b1IzGFbqth4Gp89QS5AP2g0O7MA67Vwxkz9no5gfRstng
         GhiQ==
X-Gm-Message-State: AOJu0YwHpKRJEcHK2pdyvqAhdOOVvnEt1LYiEDP8JvTmZ9iQKo8PkOV3
	oeIAOFHJ4Lm3fQSYEWrti0y0vaNSDsqbcLVT+Uyr8/8+fCTAoeY/jk4G
X-Gm-Gg: Acq92OEKuZLm2qadxoCUD/eHlJsSALBABpmieQTkKCgWnpU5wCRUdr5zNjpdadqmo6q
	akJxyG0HMLD47MJEVTYgDqkwgk/sXx63uxy47Hy+ANZpzHOWNKZ0HhzarXXTPNdffVqrzyx3xmw
	uHWRuZ9CGAntQXtl1vg+sgNBTQ/rF6R0tHqatqgo6cZS5eIybG/plQDKomlXMzUBsNfMkS9Up7G
	P5TQBMDl9x7A2w0sA5i1wJctUQBsQKSeWZiCN42s9QzaoNIy98GcvQmQv+3P9f6ag3GMEU4GFHv
	Kov6lYLhO1XdljIKFkbbUwz97Wh3b3gRdthyKH+IlxnucHGpOtGpm6VGj04L7wNQSZbh7P/h6Gl
	ujcGl8EdETVbgm1i0I0y3k0o0AVaRufph11ebh3L3sRrWssVJQ8W4i5jwviqXkJEB2wak1SaXmR
	oqi0fU4Uf8PtUX7VXBV0BJPMRzhhamL6VTodCmKCoiX6cArnHBEI7ELYa40ssuNfbPuNRglhmU0
	m0=
X-Received: by 2002:a05:6a21:62c4:b0:3a3:240d:4fcb with SMTP id adf61e73a8af0-3b427c504aemr15470177637.13.1780376547726;
        Mon, 01 Jun 2026 22:02:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:807f:1ae0:8f3:fb0b:7137:87e8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84238f1ce65sm7768086b3a.5.2026.06.01.22.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:02:27 -0700 (PDT)
From: Hem Parekh <hemparekh1596@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Hem Parekh <hemparekh1596@gmail.com>
Subject: [PATCH] ntfs: validate index root entries_offset in ntfs_readdir()
Date: Mon,  1 Jun 2026 22:02:19 -0700
Message-ID: <20260602050219.10227-1-hemparekh1596@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_readdir() computes the first index-root entry directly from the
on-disk entries_offset and dereferences next->flags without any bounds
check. At inode-read time only index_length is validated against the
attribute value; entries_offset is left unchecked. A crafted directory
with a valid index_length but an out-of-range entries_offset therefore
causes an out-of-bounds read, reachable via getdents64() on a mounted
image (a read-only mount is sufficient), and can feed a bogus pointer
into ntfs_index_walk_down().

The sibling read paths already guard this: ntfs_lookup() bounds-checks
each entry before dereferencing, and ntfs_index_block_inconsistent()
rejects entries_offset < sizeof(index_header) for index blocks. Apply
the equivalent check to the index-root path in ntfs_readdir().

Found by code inspection; not yet reproduced at runtime under KASAN.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Signed-off-by: Hem Parekh <hemparekh1596@gmail.com>
---
 fs/ntfs/dir.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 20f5c7074b..496e7e5966 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -759,6 +759,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 	u8 *name;
 	struct index_root *ir;
 	struct index_entry *next = NULL;
+	u8 *index_end;
 	struct ntfs_file_private *private = NULL;
 	int err = 0;
 	loff_t ie_pos = 2; /* initialize it with dot and dotdot size */
@@ -893,9 +894,22 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 	else
 		ictx->vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
 
-	/* The first index entry. */
+	/*
+	 * entries_offset comes straight from the on-disk index root and is
+	 * not otherwise validated on this path (only index_length is checked
+	 * at inode-read time).  Bound the first entry before dereferencing it,
+	 * mirroring ntfs_lookup() and ntfs_index_block_inconsistent().
+	 */
+	index_end = (u8 *)&ir->index + le32_to_cpu(ir->index.index_length);
 	next = (struct index_entry *)((u8 *)&ir->index +
 			le32_to_cpu(ir->index.entries_offset));
+	if (le32_to_cpu(ir->index.entries_offset) < sizeof(struct index_header) ||
+	    (u8 *)next + sizeof(struct index_entry_header) > index_end) {
+		ntfs_error(sb, "Corrupt index root entries_offset in inode %llu",
+				ndir->mft_no);
+		err = -EIO;
+		goto out;
+	}
 
 	if (next->flags & INDEX_ENTRY_NODE) {
 		ictx->ia_ni = ntfs_ia_open(ictx, ictx->idx_ni);
-- 
2.34.1

