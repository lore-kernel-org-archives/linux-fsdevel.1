Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD8347FC4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915676; cv=none; b=VqqtNopqRBMVe+87jmi/avZdnlSu6OQ3Meuw8MVIMm3tiVa61MEEussChn4weqxAv6L2vT1BoDZBgvi4/sEK54DUUYGGHAvFvkgGtguPo8/GlCNHnNIBN1TcWV7PaZdv7ZiqvXDVufpu2f+sqsGxL7Cyf0xGJjtm/OxLaXyyoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915676; c=relaxed/simple;
	bh=9wUO5aBWCbEq79mGE8ncW3tICfB+vLnX81+Me4XzYzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYwPIkGt3eNdDtDYtul8L57VmjP7gMlaXqw37ulDdD7uYb6ybeS8COKKE/z2XIWYfh6CJhFq/ZWrJ7jFI9H6LBA9g7s+2Kekl2mG4rlHW4ZRDVO+2vCj5kh12UPAw/zmVtJs/jxE4czMfQRdk+2/VtAGk7DHk7lYDgjXs9yu58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHC/rs9F; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHC/rs9F"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37de961d1bfso440038a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782915673; x=1783520473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtqvUk1phGJrW5Wx54M3QXgxstphVj9+abGNzMb2sGA=;
        b=QHC/rs9FWoxtB1PRifUr+FiAmzk8HERqC/vN8uIbt9KDSYXcrTRvkR9ZpZmk/3FL1N
         B9xcqcNFvREOE1FDGHv8fl+J/+MA4bFD9xT4hUgUJz6L/714LKJPAS/rnFr2f6FmReiI
         ymeO42glAUUtUlv0oe6p9AeFnrxSpnLvSJiQwVfLN3aICC+qnHpxEnM0fLXKjMdtzgMU
         QoWHPOewTlgIo5HZRmYu63zgxqISOrzovcLZjUd9/INlfMNWGnVpRzlca5z+evB5HDvq
         vdOyqgzQisSj40Wzoi8wYO6Abtao3nMXxIGLkWGU1eeVr+cEuPE7A7+CXlWuzmeYYHun
         3LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915673; x=1783520473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EtqvUk1phGJrW5Wx54M3QXgxstphVj9+abGNzMb2sGA=;
        b=I6OhimeQp4eBCBXko0pq0oUxhSmElGKjAJQLC5iCzW5OllG2mfCeZjLz3gP4KzSlbi
         Rlksrn4eeh1u+P+saMAa1553GjHZukWtfaKiay4us6jN+PxXSU6vmv9HcCeTRpXpnSRS
         7gfKR6VIXfK+QIz03E74mZ0DmdINSdBo/IbUC+KcMIXrVLM4N5nvCmCF71+8B6voTg77
         9DnpgCeY2TEpVaDLhIz2w3cnbu8G/hGmI1UQbbq4dOBTxkkjT56s5thOkn55CKovhjMR
         tEIqEj/kgdRFFFmj6e6k5eKDi1ydhVOwxq5LZYBZoQeqq776yqhLIBi+MW4aGXbar0pU
         r8eQ==
X-Gm-Message-State: AOJu0YwCmQ9PWqYuTTxGzdr7MPGEm2BkYPpFd0U54SPtjyV+uhTQpS9f
	tC7zyVlp5myitlB6LXhM/cwo3rxnZk4xpxZ2H4vDnqFTah4Rt40uBKsB
X-Gm-Gg: AfdE7cl7ftezPu+9dQReHFfnXjh98u6hNbyvVq8MM8bqbxSLPSXP8YyE+/N3WuMX3ls
	fNcdOsLZKZowucrOkKf3W/zxvGvoIxZZQi+tCaf0PqOZ5aiYhMPqhlB4/jUjlLxEGTb7Xi5SOc3
	3HTpm9zBaZ40U/dKTCBrhwXJRqkW+rUZT1oec9DhulmQHHyV2DOpMKbM6zwC0jefpSz6D+oWu5C
	UgTCQ+ZyQneairXK9NejeUJqbJI96ulgrW5m4u07Ag3R+s13RsB2+ZRGwv2PwxUG+cYu6roE1ur
	5td7tXim9vVCmTAyizWK5D8hKDXgRXXIdYeepCn8mxpijOa8oE0hKAmUAuTBomhp4eEwffG070A
	oc/xGIcXI7x3xrg74oTPWBZFA2B+GmSU0iNWZI2vfPJxjChdDsdDWJ7iImvwKsQN1OngX7KGt1j
	qKZOqyz8knXsU/L00u0SbEIP8MqH6quk/U
X-Received: by 2002:a17:90b:4d05:b0:37f:c2a8:ce45 with SMTP id 98e67ed59e1d1-380ba84ba5bmr971883a91.4.1782915673456;
        Wed, 01 Jul 2026 07:21:13 -0700 (PDT)
Received: from DESKTOP-DK6PUT8.localdomain ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e32ef8e49sm383894a12.19.2026.07.01.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:21:12 -0700 (PDT)
From: yizhang089@gmail.com
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	chengzhihao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 4/6] ext4: zero out whole block for clean edges in WRITE_ZEROES
Date: Wed,  1 Jul 2026 22:20:07 +0800
Message-ID: <20260701142009.1510104-5-yizhang089@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701142009.1510104-1-yizhang089@gmail.com>
References: <20260701142009.1510104-1-yizhang089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

FALLOC_FL_WRITE_ZEROES requires that all blocks in the requested range
end up as written extents with zeroed content. For unaligned edges that
were already allocated, ext4_zero_partial_blocks() zeros them directly.
However, for unaligned edges whose underlying extent is a clean
unwritten extent or a hole, the extent type remains unwritten after
partial zeroing, which does not align with the semantics of
WRITE_ZEROES.

Therefore, when ext4_zero_partial_blocks() skips partial zeroing, it
indicates that the corresponding edges are clean unwritten extents or
holes. In this case, we need to expand the aligned allocation range
outward to cover such edges, so that ext4_alloc_file_blocks() can
correctly allocate blocks for the unaligned range. Edges that were
partial-zeroed (i.e., written or dirty) are left untouched.

Fixes: f4265b8d32c4 ("ext4: add FALLOC_FL_WRITE_ZEROES support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 7a8f9f188a29..c34505765521 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4760,6 +4760,21 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	/* Zero range excluding the unaligned edges */
 	align_start = round_up(offset, blocksize);
 	align_end = round_down(end, blocksize);
+
+	/*
+	 * In WRITE_ZEROES mode, edges that were not partial-zeroed (clean
+	 * unwritten or hole) must be allocated and zeroed as whole blocks.
+	 * Expand the aligned range outward to cover them.
+	 */
+	if (mode & FALLOC_FL_WRITE_ZEROES) {
+		if (!IS_ALIGNED(offset, blocksize) &&
+		    !(partial_zeroed & EXT4_PARTIAL_ZERO_START))
+			align_start = round_down(offset, blocksize);
+		if (!IS_ALIGNED(end, blocksize) &&
+		    !(partial_zeroed & EXT4_PARTIAL_ZERO_END))
+			align_end = round_up(end, blocksize);
+	}
+
 	if (align_end > align_start) {
 		if (mode & FALLOC_FL_WRITE_ZEROES)
 			flags = EXT4_GET_BLOCKS_CREATE_ZERO | EXT4_EX_NOCACHE;
-- 
2.53.0

