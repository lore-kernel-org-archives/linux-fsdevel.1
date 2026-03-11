Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AB3E0226
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246313; cv=none; b=qVh58KJ0BAKAOTQgVSoeylxKmnFFWJ6s7dXfhQsrI+GlBUR8sI6I+ZawTwHaSBAzJ8fKnw2CsRkR3ZJLXFB3c0wDwAiMyczAq5JhZAXlws7I8skr4gwK02+dUX3aocddNznEoMH1SjoTR67Txr5KqmNSan4o5I9iADR91xZ2hyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246313; c=relaxed/simple;
	bh=5oQvTAUPnp/oII/IIELSx2bpbJwudXSo1Elad+vFcDg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDk7IfkVFC0oROqAETbkXP+ijylbigTpt42oDJPfE14+fBN8O2KyclDg5ooxlwvvPaXdEAYSeYEo6k3U6rSWn+5rEIJ67f40e1vdgLgY78y0oFCs1VWfmhdbPolLAywcN4YU2mpVkbeMCrIS7zP48MsVnPExe+xLwEMts9NK6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaVTMPL3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaVTMPL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773246308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9Wl/dpNEwyn3kcNawFqa0sfgfYLxmXfFxfCZfo4rvo=;
	b=GaVTMPL3vODCj9mmEgNBB/I3T8TpWB2Hi64JIWYf/lt4v+BF+4EZKVEH6b/Ywa4WmRtirX
	TG+AfjCMcduDU4sdHeZHrzQSCC9OMmYDJofIFyUR3eg15wJZlW2hp/fUT5ktp+zTps7K3Y
	8gBGWv7eKZodw+nynMl0nog9F6dhLKw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-iY2f_sSAPPezavOiVFhkZA-1; Wed,
 11 Mar 2026 12:25:05 -0400
X-MC-Unique: iY2f_sSAPPezavOiVFhkZA-1
X-Mimecast-MFC-AGG-ID: iY2f_sSAPPezavOiVFhkZA_1773246304
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65AE81956052;
	Wed, 11 Mar 2026 16:25:04 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.89.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC2F11800351;
	Wed, 11 Mar 2026 16:25:03 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v4 1/8] xfs: fix iomap hole map reporting for zoned zero range
Date: Wed, 11 Mar 2026 12:24:55 -0400
Message-ID: <20260311162502.192375-2-bfoster@redhat.com>
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

The hole mapping logic for zero range in zoned mode is not quite
correct. It currently reports a hole whenever one exists in the data
fork. If the first write to a sparse range has completed and not yet
written back, the blocks exist in the COW fork as delalloc until
writeback completes, at which point they are allocated and mapped
into the data fork. If a zero range occurs on a range that has not
yet populated the data fork, we will incorrectly report it as a
hole.

Note that this currently functions correctly because we are bailed
out by the pagecache flush in iomap_zero_range(). If a hole or
unwritten mapping is reported with dirty pagecache, it assumes there
is pending data, flushes to induce any pending block
allocations/remaps, and retries the lookup. We want to remove this
hack from iomap, however, so update iomap_begin() to only report a
hole for zeroing when one exists in both forks.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index be86d43044df..8c3469d2c73e 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1651,14 +1651,6 @@ xfs_zoned_buffered_write_iomap_begin(
 				&smap))
 			smap.br_startoff = end_fsb; /* fake hole until EOF */
 		if (smap.br_startoff > offset_fsb) {
-			/*
-			 * We never need to allocate blocks for zeroing a hole.
-			 */
-			if (flags & IOMAP_ZERO) {
-				xfs_hole_to_iomap(ip, iomap, offset_fsb,
-						smap.br_startoff);
-				goto out_unlock;
-			}
 			end_fsb = min(end_fsb, smap.br_startoff);
 		} else {
 			end_fsb = min(end_fsb,
@@ -1690,6 +1682,16 @@ xfs_zoned_buffered_write_iomap_begin(
 	count_fsb = min3(end_fsb - offset_fsb, XFS_MAX_BMBT_EXTLEN,
 			 XFS_B_TO_FSB(mp, 1024 * PAGE_SIZE));
 
+	/*
+	 * When zeroing, don't allocate blocks for holes as they are already
+	 * zeroes, but we need to ensure that no extents exist in both the data
+	 * and COW fork to ensure this really is a hole.
+	 */
+	if ((flags & IOMAP_ZERO) && srcmap->type == IOMAP_HOLE) {
+		xfs_hole_to_iomap(ip, iomap, offset_fsb, end_fsb);
+		goto out_unlock;
+	}
+
 	/*
 	 * The block reservation is supposed to cover all blocks that the
 	 * operation could possible write, but there is a nasty corner case
-- 
2.52.0

