Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616321;
	b=jpEPxvlbWuH7l9U6lzdgusz2aypeSUsUu/UZfCRChbjAoZnOVudfjG8tsHd8xKKWBHAh
	 MFlEMSis8yPE9cExklNlNZMJMaSbIhUTAPGN6rUNIqx4VAZAV+l3y85CTegRaxzAOWBgh
	 ApopjLyM7xD+72XPB3Ca5iVaOfAV0iWphBJ8BnVUuPtFhz/Kz8Bn1qzJuNkpNH9FX2DlR
	 BXHeiSm7n6KuKCDB7BPvxuOXW5EZ0zuOS5yYIou58KaAk6GE36udZ+zObEjBvDMHs6DoI
	 GW5pL/5xnYnKtIM6SkyqhBYrkfQcBqKUWUN5j/D/07MQ1YFrNLUZPbH+jxBHJ9Z7Ffw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616321;
	h=DMARC-Filter:Received:From:Date:To:Cc:Subject:Message-ID;
	bh=d+Fe56rO9Y8xjvaMg3TO/RXpFnmt/k5+69VkIh7gtzg=;
	b=ZXJc+fxMplIXVfGGRHKWnSgiYsZg/qNKmXnfPPPsa8sJxypqfiASRoXHY/Q1x1NDOg0z
	 2jL1Nvv/3vX/i+8doCfVaFFwTNTLcpaWZwjHLnJY3f2BUgN+dPFQ9I1bpGG+V1seeryLQ
	 jry2teyGYirbjvCLqpl3mOljEu9DZRLBk7lw4yVjQkOxeBmwRb/a8BEYUz54OLds1qxSw
	 b7yGYxDYG6MMPHKVSZS9cnBMOsxaOebbODiwEAOOsfBUH4iqsGJVC/FYJv93hxYFNh2R0
	 X0ShiSZbzWipr9rah4iT9Iy3dUDaFaJC06NkHhbMGfGWvGhR6+/c3yDddB7FFeXO/cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C465606A321;
	Wed, 25 Nov 2026 14:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C465606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id B0E5DC9300; Wed, 25 Nov 2026 23:18:38 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Wed, 25 Nov 2026 23:18:20 +0900
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH] fs/ntfs3: drop the mapping pairs when a file loses all its clusters
Message-ID: <20261125-ntfs3-03-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

When a non-resident attribute is truncated to nothing,
attr_set_size_ex() sets evcn to -1 and leaves the old mapping pairs in
the record.  chkdsk on Windows reports such a record as corrupt:

  Attribute record (80, "") from file record segment AD is corrupt.

Leave only the zero byte that ends the mapping pairs, and shrink the
attribute to it.  mi_pack_runs() cannot be used for this, it returns
-ENOSPC when there is nothing to pack.

I tried it on two volumes, one where files were written and some of them
truncated to nothing, and one after fsstress (-n 4000 -p 4).  Without
the patch all 16 empty files of the first and 3 of the 90 of the second
still had mapping pairs, and chkdsk exited 3 on both.  With it there
were none, and chkdsk exited 0 on both.  File contents were the same
after a remount.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 fs/ntfs3/attrib.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index d0f8c48..fbda12b 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -818,6 +818,21 @@ pack_runs:
 
 			le = (struct ATTR_LIST_ENTRY *)((u8 *)le - le_sz);
 		} else {
+			u32 asize = le32_to_cpu(attr->size);
+			u32 roff = le16_to_cpu(attr->nres.run_off);
+			u32 nsize = ALIGN(roff + 1, 8);
+
+			/*
+			 * Every cluster goes.  Setting evcn alone left the old
+			 * mapping pairs behind it, and chkdsk on Windows
+			 * reports such an attribute record as corrupt.  Leave
+			 * only the zero byte which ends the mapping pairs.
+			 * mi_pack_runs() does not take an empty range.
+			 */
+			if (nsize <= asize) {
+				memset(Add2Ptr(attr, roff), 0, nsize - roff);
+				mi_resize_attr(mi, attr, (int)nsize - (int)asize);
+			}
 			attr->nres.evcn = cpu_to_le64((u64)vcn - 1);
 			mi->dirty = true;
 		}
-- 
2.54.0 (Apple Git-157)

