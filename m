Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAE19E992
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843628; cv=none; b=NPyQM1MIpmuXZ6BSeuEJbCgjNS6xK0WzfqeRGXiI0thVmND7eAP7bjQ8h3y7QW7ykHEw/GWFwFxvvQNKdvbqVWItI0W0+YGez6+VqkF9aA/HcPViYMvp2xkWNyVIajlNzBjfThU2ovMz5CCMpiF7GfhM+DWSpkst51XLCZvb54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843628; c=relaxed/simple;
	bh=4tIasw7p02dvgNSnFCu03qpzu+DzNyyyf7pWrfv1+dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFd1HItqIYOUgnMgwnMJ8xSGswteenmwWjeXJ2pz5iVyzuSWwjuXkt/DOmY/QJDLDn6AskFEC93Q4P+EjB7P11k4vk0a5sensG2kSb16O1/Di1PazcFF1I+zBLjcgO3YUsE3CUzy/hTU6CKZchTFMbmzg7O1n77CP2bH4lLp7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fR5dGYAx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkM1x0Hn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fR5dGYAx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkM1x0Hn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776843626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=79DPcymvIV1nuLALBsp2se+zVALKkvVRe65n1/oy10w=;
	b=fR5dGYAxcge9vDylqrCu0zul1CLcSV1zj2l4mE0dW9vMnaPiGFhyc8sFsX9y3DL2TjDySa
	Di+MS53fUG6rM7rUe6JbvEbwyWQzos1pRN8aREfD6BDOS2yjGaEUDB2hzAlvJaw2YoEyLt
	V/wZBXlS7NBq+i1tSd6E6jwdVyXJEyA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-7u1srphaOQa1rXbuvpTe7w-1; Wed, 22 Apr 2026 03:40:24 -0400
X-MC-Unique: 7u1srphaOQa1rXbuvpTe7w-1
X-Mimecast-MFC-AGG-ID: 7u1srphaOQa1rXbuvpTe7w_1776843624
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fbc70cfbdso31094581cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776843624; x=1777448424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79DPcymvIV1nuLALBsp2se+zVALKkvVRe65n1/oy10w=;
        b=XkM1x0HnNjv8LwPSNFPjuqLhszchErOBAADYBlOArPSg1f1RJi+jCFLYwjBxbOJTn3
         6zfm6jH+On/B3vvPvYIB1mI31qU2kA0A+L3bngP1jwBrGE7jiwhbpWeiP1Tgijuh3evR
         3e5wkaQ6CaSDvI8UgKZYJtDLprcRbxOnTSQuNVg9PADpqgwxR+aw3larxFQOM7X4ezWP
         le4lTTRZmPJVCquX9dpNJuGroIIETPmddwXUoggDf6x/LJJn3101hnewfkE1EH1hex0C
         qNaSM3iDD/K3jk7lpA+LDkci0c1ddhi0cJkZnLqaaGOZwmFvNs7L+W7OXb3IsQ/4wCH4
         QYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843624; x=1777448424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79DPcymvIV1nuLALBsp2se+zVALKkvVRe65n1/oy10w=;
        b=dM327N0KwymNfABxmt3ELE682jbKky2OKLgAYhjDgLKe8kcmQzdYlykepnShjwPxrl
         Yc87j0a3vH4Xb8ajYXfm9NuxiMNjsjSQUGmSiIlCT+TJH3uqS40mjYT2PbZFpuX9LOsv
         CTWF4iDGq/uCJ6FRuZhuigiofd/yd+ZP2ZxebuDjjaCz3BRez0Qajn4Gh+ZTqEr/cxwX
         yAER525RHUzGuZx0Ar2f4pGIE3Mqel9Al01lzR7uDBDLTgnDyatpW5ck49aP7Rwgt2oD
         zI3jILOTnUd7+6+m0WQWW/y9fIi22zCxUhJ/cfhrXVOXUvIIzic+hfV+dT2bB+f5bN+c
         bUPA==
X-Forwarded-Encrypted: i=1; AFNElJ91iktE/FeZfoPvAEUGfkmi31Zah7mUjn9clBJ2SEx2jK6AyZ88GlaSa9zxQ/UgNzdOdOCt8Ue6BxPLxsdO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tQnCiYuLyTwNNgQaYNTT06mSmj+UzXgnIC9JgDcW0aELFOiA
	0rJJNQC3GYA2ZIVNtPvdys3PSG3IHS2UwtxOdTH7q6QCkWVa3QPomToAFhGC/qVEGn4AYa2L86Y
	V1rso6NWUKlGbv1qNKwWKKnq/eh4/xXqZvJjUp+4Jdxe2FwCcsq8JoG5RWhsXgoVMX1Q=
X-Gm-Gg: AeBDievMxG0ylzSVetnQsHwM8nlWlH3ke57MtNNvxMhWAT0cBov1XpRjsxiUQniOZc7
	aDd2o5egva5VyWhEN3HDnaI26SojU2KBizNfEefXjcB9+okz/iiVirKNoMMk9Yw5XwHgNZYzdxm
	drIsaEI/RnzKIlpVTPElw7NNI0RYXmx6fJzz27lkRpNKx0iUG5PBdhZWL+hvlMQh2L+5iy80cQu
	u91ocBb2bKyKyzIG69fI1Rw9yJm3tT9t9zsSMeB2PV34HIjMTGm0GDq7CLq0uA9qwT9mesC5Yyy
	0ywTOzhzRd+MeJMg1nJWKOxDRhzoiIzeutuiKhjPiULit9BH9bKOFW7CmCmGwpM8J2cI7+vqy4n
	w0XFLrN8UNjEn7lFg0p8p2fqyszJ3jWO1ct/A5WRrWN9oQQ==
X-Received: by 2002:ac8:5749:0:b0:50f:c36a:3828 with SMTP id d75a77b69052e-50fc36a3c77mr9318451cf.58.1776843624020;
        Wed, 22 Apr 2026 00:40:24 -0700 (PDT)
X-Received: by 2002:ac8:5749:0:b0:50f:c36a:3828 with SMTP id d75a77b69052e-50fc36a3c77mr9318201cf.58.1776843623561;
        Wed, 22 Apr 2026 00:40:23 -0700 (PDT)
Received: from fedora43-upstream-dev ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac78513sm124497726d6.19.2026.04.22.00.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 00:40:22 -0700 (PDT)
From: Ravi Singh <ravising@redhat.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	djwong@kernel.org,
	dchinner@redhat.com,
	esandeen@redhat.com,
	cem@kernel.org
Subject: [PATCH v3] xfs: flush delalloc blocks on ENOSPC in xfs_trans_alloc_icreate
Date: Wed, 22 Apr 2026 07:39:59 +0000
Message-ID: <20260422073959.10056-1-ravising@redhat.com>
X-Mailer: git-send-email 2.53.0
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

v3:
 - Moved comment to sit above the flush+retry code (Christoph)

v2:
 - Moved xfs_flush_inodes() retry into xfs_trans_alloc_icreate()
   instead of xfs_symlink() (Christoph)
 - Removed caller-level retry from xfs_create()
 - All callers now covered: xfs_create, xfs_symlink,
   xfs_create_tmpfile, xcrep_tempfile_create


 fs/xfs/xfs_inode.c |  6 ------
 fs/xfs/xfs_trans.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

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
index bcc470f56e46..148cc32449c1 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -1199,10 +1199,21 @@ xfs_trans_alloc_icreate(
 {
 	struct xfs_trans	*tp;
 	bool			retried = false;
+	bool			flushed = false;
 	int			error;
 
 retry:
 	error = xfs_trans_alloc(mp, resv, dblocks, 0, 0, &tp);
+	if (error == -ENOSPC && !flushed) {
+		/*
+		 * Flush all delalloc blocks to reclaim space from speculative
+		 * preallocation.  This is similar to the quota retry below
+		 * but targets FS-wide ENOSPC.
+		 */
+		xfs_flush_inodes(mp);
+		flushed = true;
+		goto retry;
+	}
 	if (error)
 		return error;
 
-- 
2.53.0

