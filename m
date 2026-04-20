Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB154392838
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679609; cv=none; b=GKMPNg+t3FiUmWARQcr9w02hh9OtDd0DInZZrazpv+etSGngXKFJocwXv20TpIQe7wHqmbRDbxKoWaTzDRgcCx5XBkJFMVjbKH0IsSfV6zSFUsIVu8hli/ZAnz1JzO67YpXidGwl5wRvMUjX9sjT7cGzXbrD+QSSI8G88gyOfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679609; c=relaxed/simple;
	bh=qJIM3jxOWQuyl4KxyZW5vyAnvUOthNi6voO6ikcpLqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NullQzuut4VIGszGTv8aV9Pl8lp6XKvBow6q1vu7vnYzUV+xjAzq8xG3fWUKEm7GCMYQkBboY0W0nWTF0tjn23oaL3OMJBf7ANw5jW5ldCFY6hIwVDCudSyXRmnUTDmREciet+v800HFtNrha7r0Ftv5XIvi5Kpqw0hW64jbQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2nXAp7m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6TIXHe7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2nXAp7m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6TIXHe7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776679606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEGLFj4ClIrjd7MZC91OS4EkTEnUoAhP7Kztkq+Ge68=;
	b=O2nXAp7mqUABuUFKQu2UQS6VkDlqxaxn/cWY3uAj7cq6Xo+AQkg2qOOp6/wvDqNn1W+P1h
	/zP/tfo/pu76F8zF17dMiQOE2Hfqceyg1HK5ZfjYqwg701dNM9AL2sG2p/PJWPGmxKMJty
	hEw+vObT6DPSUXQAkgKLni2FVFw5nak=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-3mNZBEQrPMqq-G7Y2yU1Gw-1; Mon, 20 Apr 2026 06:06:45 -0400
X-MC-Unique: 3mNZBEQrPMqq-G7Y2yU1Gw-1
X-Mimecast-MFC-AGG-ID: 3mNZBEQrPMqq-G7Y2yU1Gw_1776679605
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8eacc2008b2so130598985a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776679605; x=1777284405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEGLFj4ClIrjd7MZC91OS4EkTEnUoAhP7Kztkq+Ge68=;
        b=i6TIXHe7qdX/nXBIJQoWThlr15RoKL0CdjCfrjHLSTu6DrqX8GBdV6oVNBuQJ0StwH
         sJzWX0GM2kf6jQoFt2n/TgDTQkt3pFgwHHzgLPWxXRwCAJTzWaf1U/U9zDipdAQEzRhq
         dIlvNhP3nj4XY71ciqdGMCfZD/cZ+3zLKURqQ28OsnPDwWRkLFPFmfvk9rcANMaShKR8
         VHUHcViNU4TjCwP4skzOgvSdhepN5v9xInksml+w+tgVk7h2pwW6tPi09JKO0ZdQBlgQ
         RNJTv/l5tp7IepduK31lnd5GW8oMg06AJxE/XAmccd1aKVbnPY4P92MasM+B38lDtkCN
         LAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679605; x=1777284405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEGLFj4ClIrjd7MZC91OS4EkTEnUoAhP7Kztkq+Ge68=;
        b=QcZuaj3EMNxxUMkz32IwrYpajJhmLVfi/wD2+19gBQURPqHPFfWq/9A0VYsCLLcycC
         b3p2CJXWrLqEY8dI+CU1dmF1qrS1r0+zbdw/WAhhRedHTp207xG1UxAa86rrXgDRElUC
         yG+kCZqPz1O32HupMrafBywlqufp6PokJ26jhKTc7tksD3QPD2mubPDRoDZrmKay7ALM
         hM6JzZ0otGUN11K/zB+wfVKDl1SL85VNSgpM8YrQR/2Fd1LUkwxoP+J/lqAcdAH60z6z
         JuL0U37gTsyOjS9fcwmj1QltmUqrVKl69bc1hf201OxVBMJtl1GjhqB3H8Tcyok4US9n
         k9sw==
X-Forwarded-Encrypted: i=1; AFNElJ8hk7NSMXHnFh9EvAxApn+Vh5LyCIi1G2PkQFZT/OCiQ57yBEbo6LEjkV85UyY0VeKag3D+B6roe7YjrQjG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0hnIumlQ3XDaj81j9nV7wWb0Saku9/oQO8vEzPSJ4MfMqMCc
	VWCXhaSI6I7PgRQ+QykuVc5Lc7uJ6APTAX0qJj6bz9oRLdOqfT76hSlJmDSUsGFQfPWzaopY/Dx
	3vecTY8UMwsX5+pvLQgVZ44LdcwfckkRq0mjdAP2oZc0qC2I8aXY+LZkCb6xCsjtkTn8=
X-Gm-Gg: AeBDies+5ZHbmPSd4shbZZ887qiHc+DQDQQ1D0jMMMn6THqCL3e8r0dpjF5cJ18l35R
	EbF1/h0fh3QBWdatPoVQDLvQSBr8AfweOVu4qrofjl7cLVygc7JI/Uffg1AOxTBDwZOeVaUqHG0
	jKYy+h2b4bX3sc77DYe+hi8ujDiHjPfBMEgJv8x8CP4PnpN9nQaaDurC5Mdoki4x2oEpDWJg9BW
	vD4cxZFx6705lb0HH0n6oSg1fax6splaciombEV1jkvZvzZ49T+ExyYM2VLnjRf8seS02sIZvW1
	o2qv6SkeDpbgENKyDGfJvFyIjTcBoUg1+m6c/ZQNSmiIlpaQYa1blqgO6oZw9ZYNtj2mGwB3idU
	1eJ6xU8YVsHiP1BrBiLi93N5c2lzOzpMzqwVIk4894M5Gig==
X-Received: by 2002:a05:620a:27c1:b0:8ea:aa10:7b3f with SMTP id af79cd13be357-8eaaa107d0amr556256085a.1.1776679605033;
        Mon, 20 Apr 2026 03:06:45 -0700 (PDT)
X-Received: by 2002:a05:620a:27c1:b0:8ea:aa10:7b3f with SMTP id af79cd13be357-8eaaa107d0amr556252385a.1.1776679604523;
        Mon, 20 Apr 2026 03:06:44 -0700 (PDT)
Received: from fedora43-upstream-dev ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb19632130sm247061485a.41.2026.04.20.03.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:06:44 -0700 (PDT)
From: Ravi Singh <ravising@redhat.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org,
	dchinner@redhat.com,
	esandeen@redhat.com,
	cem@kernel.org
Subject: [PATCH v2] xfs: flush delalloc blocks on ENOSPC in xfs_trans_alloc_icreate
Date: Mon, 20 Apr 2026 10:06:37 +0000
Message-ID: <20260420100637.3584-1-ravising@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aeBv_xvDTmuzEhV1@infradead.org>
References: <aeBv_xvDTmuzEhV1@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs_trans_alloc_icreate() can fail with ENOSPC when delalloc
reservations have consumed most of the available block count
(fdblocks).  xfs_trans_alloc() already retries internally with
xfs_blockgc_flush_all(), but that only trims post-EOF speculative
preallocation and may not free enough space for the transaction
reservation.

Add a retry with xfs_flush_inodes() when xfs_trans_alloc() returns
ENOSPC.  This forces writeback of all dirty inodes via
sync_inodes_sb(), converting delalloc reservations to real
allocations and freeing the over-reserved portion back to fdblocks.

This fixes all callers of xfs_trans_alloc_icreate() and removes
the existing caller-level retry from xfs_create(), which is now
handled centrally.

Signed-off-by: Ravi Singh <ravising@redhat.com>
---

v2:
 - Moved xfs_flush_inodes() retry into xfs_trans_alloc_icreate()
   instead of xfs_symlink() (Christoph)
 - Removed caller-level retry from xfs_create()
 - All callers now covered: xfs_create, xfs_symlink,
   xfs_create_tmpfile, xcrep_tempfile_create

 fs/xfs/xfs_inode.c | 6 ------
 fs/xfs/xfs_trans.c | 9 +++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index beaa26ec62da..9978ac1422fc 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -699,12 +699,6 @@ xfs_create(
 	 */
 	error = xfs_trans_alloc_icreate(mp, tres, udqp, gdqp, pdqp, resblks,
 			&tp);
-	if (error == -ENOSPC) {
-		/* flush outstanding delalloc blocks and retry */
-		xfs_flush_inodes(mp);
-		error = xfs_trans_alloc_icreate(mp, tres, udqp, gdqp, pdqp,
-				resblks, &tp);
-	}
 	if (error)
 		goto out_parent;
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index bcc470f56e46..2796634b7d2b 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -1186,6 +1186,9 @@ xfs_trans_reserve_more_inode(
 /*
  * Allocate an transaction in preparation for inode creation by reserving quota
  * against the given dquots.  Callers are not required to hold any inode locks.
+ * If the block reservation fails with ENOSPC, flush all delalloc blocks to
+ * reclaim space from speculative preallocation and retry.  This is similar to
+ * the quota retry but targets FS-wide ENOSPC.
  */
 int
 xfs_trans_alloc_icreate(
@@ -1199,10 +1202,16 @@ xfs_trans_alloc_icreate(
 {
 	struct xfs_trans	*tp;
 	bool			retried = false;
+	bool			flushed = false;
 	int			error;
 
 retry:
 	error = xfs_trans_alloc(mp, resv, dblocks, 0, 0, &tp);
+	if (error == -ENOSPC && !flushed) {
+		xfs_flush_inodes(mp);
+		flushed = true;
+		goto retry;
+	}
 	if (error)
 		return error;
 
-- 
2.53.0

