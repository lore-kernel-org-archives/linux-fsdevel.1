Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266453DC4B0
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246314; cv=none; b=EqwO27zbfUEQca70uyZEq932be55Ct1Ra5XtIJOZ7sPIgWIpner8wdwGBKPAh7Wad0lbwUjauGKTxkvE0S0dmCYnD30LQ3fhPXjbifXPIOqPcY4O6hp8G0Eid4yan3blHnlPTRQjsvjipdBfuVwx7UZYHxafQ4SRPqwq1RQZNlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246314; c=relaxed/simple;
	bh=d/G+fwzhuPdUSUUYXGYIiA5aTUFUQ/DIwdI15rtzyPw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRQ8V20JIgns2nvKZ+vYe89zTcwPRpxJlDwOlDxY8lAmLnZqM8FYx+fzh3R1BhKQYLtK+RyYID7tv0mqNNe24daVUH//THUzNiBnqaJzS2uRT08O7O8SgsterlkBLD5mrURQM67Hsti1EqxlNFA81b9hGjC5SZyc85ihuYi5Tcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhtPJD1q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhtPJD1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773246312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWBChcSlSczLC/Rd6tIrftiUHaTA66Y2sgLJ7FqkvPg=;
	b=bhtPJD1qiGtOSy//cqLFSTpKbPUeGKKKnysQCeKs7oT0RZERQBJVzn2lHqvit2CIsXJ3Rp
	JLdR1h7dghwJuqnxLxHmi8B00HjK7Q7ZGMIk2FFajj3sZdQGWPwrYQVWl59cNUK3LpcwgN
	2f3AtZoTYQbmI1lQ7g7ua7twqzSmrzY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-iiWt73SjPk-9GeuUBvNzug-1; Wed,
 11 Mar 2026 12:25:09 -0400
X-MC-Unique: iiWt73SjPk-9GeuUBvNzug-1
X-Mimecast-MFC-AGG-ID: iiWt73SjPk-9GeuUBvNzug_1773246308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C96619560B3;
	Wed, 11 Mar 2026 16:25:08 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.89.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 916691800351;
	Wed, 11 Mar 2026 16:25:07 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v4 6/8] xfs: only flush when COW fork blocks overlap data fork holes
Date: Wed, 11 Mar 2026 12:25:00 -0400
Message-ID: <20260311162502.192375-7-bfoster@redhat.com>
In-Reply-To: <20260311162502.192375-1-bfoster@redhat.com>
References: <20260311162502.192375-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The zero range hole mapping flush case has been lifted from iomap
into XFS. Now that we have more mapping context available from the
->iomap_begin() handler, we can isolate the flush further to when we
know a hole is fronted by COW blocks.

Rather than purely rely on pagecache dirty state, explicitly check
for the case where a range is a hole in both forks. Otherwise trim
to the range where there does happen to be overlap and use that for
the pagecache writeback check. This might prevent some spurious
zeroing, but more importantly makes it easier to remove the flush
entirely.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index df1eab646cae..6229a0bf793b 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1781,10 +1781,12 @@ xfs_buffered_write_iomap_begin(
 {
 	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
 						     iomap);
+	struct address_space	*mapping = inode->i_mapping;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
+	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
 	struct xfs_bmbt_irec	imap, cmap;
 	struct xfs_iext_cursor	icur, ccur;
 	xfs_fsblock_t		prealloc_blocks = 0;
@@ -1852,6 +1854,8 @@ xfs_buffered_write_iomap_begin(
 		}
 		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
 				&ccur, &cmap);
+		if (!cow_eof)
+			cow_fsb = cmap.br_startoff;
 	}
 
 	/* We never need to allocate blocks for unsharing a hole. */
@@ -1866,17 +1870,37 @@ xfs_buffered_write_iomap_begin(
 	 * writeback to remap pending blocks and restart the lookup.
 	 */
 	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
-		if (filemap_range_needs_writeback(inode->i_mapping, offset,
-				offset + count - 1)) {
+		loff_t	start, end;
+
+		imap.br_blockcount = imap.br_startoff - offset_fsb;
+		imap.br_startoff = offset_fsb;
+		imap.br_startblock = HOLESTARTBLOCK;
+		imap.br_state = XFS_EXT_NORM;
+
+		if (cow_fsb == NULLFILEOFF)
+			goto found_imap;
+		if (cow_fsb > offset_fsb) {
+			xfs_trim_extent(&imap, offset_fsb,
+					cow_fsb - offset_fsb);
+			goto found_imap;
+		}
+
+		/* COW fork blocks overlap the hole */
+		xfs_trim_extent(&imap, offset_fsb,
+			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
+		start = XFS_FSB_TO_B(mp, imap.br_startoff);
+		end = XFS_FSB_TO_B(mp,
+				   imap.br_startoff + imap.br_blockcount) - 1;
+		if (filemap_range_needs_writeback(mapping, start, end)) {
 			xfs_iunlock(ip, lockmode);
-			error = filemap_write_and_wait_range(inode->i_mapping,
-					offset, offset + count - 1);
+			error = filemap_write_and_wait_range(mapping, start,
+							     end);
 			if (error)
 				return error;
 			goto restart;
 		}
-		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
-		goto out_unlock;
+
+		goto found_imap;
 	}
 
 	/*
-- 
2.52.0

