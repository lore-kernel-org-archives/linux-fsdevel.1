Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0C3A0E94
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358688; cv=none; b=YNCkz+y/0RwupyTZVFI8IVS5msCPlrTfosCgfqIn5Z5A5PDpS7/Gws8MHmJrscJcouFCxdw866UILLNV50+MwqTLQtpfsKw7y+oFYYaQPTJnYIUqMeqwwqFmoaKBpS60YGbIJWZdkBue5Q4axQywF2PA5ikQFWxw0sxu2WfVmlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358688; c=relaxed/simple;
	bh=9Pe8+ZjrYRQJiOIU8K7FPoyUGDQ+DlBlLp/jlo74mZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QspsTagbHzNzstw+8BwDk6kho1BttHgbPrgub6wAxof7IDAGiIwz0uAfCapdyKF+PnmSqrkkLRBNSzAWGj0luHKJhQc7vmJG0CxxJUydMMSI0bDkdG/I35IDqCRLsXgj7o+0h48EkpTCRZvOenn19FjOBfZzyQcBPqP8k9SnFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn5AIKGC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn5AIKGC"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c822d72b20cso471858a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779358685; x=1779963485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bN7pEF/YCMte4OiPfGkGfT7emXc7eO02yqJ1xiQvVVg=;
        b=cn5AIKGCnmgM0s8SyGdeicPRNc+09cNXplKa5TsNPAK2LhDa6F22nJKaFGcAHCsbNR
         ncuVlPtAD7F2V4B++I5vxKBtHv6iqNkYATqPdGwnPfFVVETs3JBM/U+VPkIJCjR5hWIZ
         LrkDCYlkT1idv7EJ6ErmOPizALx9S2IPOLJ3iTVSZNC26YZ7FN/LvWaRYC+XRfkHgHe+
         2LwP2J5ksMo+DpOB2VULDuq4bp+lyXShUsC1J0cGWsYV1H4yzCW5vryJWjTRFhW9e0QL
         gSixvLkUMB0yvZHjP4JsrjFYshOiVk7k4xtUdHwgCMoYVAylqibWW7U7520U3avv7RWx
         uq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358685; x=1779963485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bN7pEF/YCMte4OiPfGkGfT7emXc7eO02yqJ1xiQvVVg=;
        b=HIGkFTjGGzfMBLpzpbUzhH9cy5ebJZjsV7U8/5B18ExIikir7KzkufctwjQeC3iUGB
         Zs6EwcBb3RSOvh4zkAakzZuH/XY6NYt/nR0DgwqLmpS9fdQDoVUEIj+jzjl5Lif+ZJHC
         VczV9kdWZsmhq67uga8US4bOZwo3SkoAbAZb60va2LaERbGaAl3Wt6lYRB+H3p50uGGz
         LfCWIaR+QUjq7eItxweuunueHWcSPUXiIQvxejBM1JCMgn0qtVrZa0VFWBZCylN6EVHj
         3Jnyp6qIs9N5+VfSUPUV82VEvZ/ihOK3NQoWLdS5W1POyxgIj9E4i/EoAwbaucjAl7bA
         4G0Q==
X-Gm-Message-State: AOJu0Yx6Vl45UcysePRy8qas/FFbJa7/SamalVt5rJPCspzd9lrmAgDZ
	6/NeFYon5FX/f0NVKPyuB7QMl+PJ6GSxpNuBt4IqmbIQLXT7QmQ7DjVG
X-Gm-Gg: Acq92OHlK4xxW0pWCxdPOnN1fNPj0nvyxm1Jlw5aQTvWiJ9oLmSXRBX3f83tjnzW4VV
	HlZJqG857c13ND5Tj5Fy56N2HTq/vgJblPaVhEvzCLHkBWHLUnYoUn5O9Xh3rLqvsInx1NKXXyi
	m0yELNDwyZPYOBsucEWY9Hq1J8jvpOvwJZ8MNuQECYuJPLWXi9Mgl2s8Go8N8ukh31+HYPLwGDC
	4k7Xh8Vxr9kOVbsqGadzsvKf/PO2gGAkRQZ2O5cFbKHqy8hOscumg6ssVxYW0Z1io6r/hocyOjb
	X5MHls7HUn8TV5TTX25vmm5EmRmCUFM4y+Ov6XMdKjyuH20vg4R/UbBIgfUENuf+jfMeNfUCADs
	RtqITsCc0Ny7/5exqSt0rQrH5kP0Kz5qA636tK5qs9WNLPsJUiXXEyOpIWLNBjcFEf9B3vl7Awv
	kMFkq67mUSkfsbdPJjOYoct1bEgxQ=
X-Received: by 2002:a05:6a00:997:b0:82f:6a82:4231 with SMTP id d2e1a72fcca58-8414ac846bfmr1346412b3a.1.1779358685366;
        Thu, 21 May 2026 03:18:05 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e1fc86sm1197799b3a.44.2026.05.21.03.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:18:04 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 2/3] ntfs: avoid heap allocation for free-cluster readahead state
Date: Thu, 21 May 2026 19:17:50 +0900
Message-ID: <20260521101751.591345-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521101751.591345-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
 <20260521101751.591345-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_nr_free_clusters() is run from the precalc_free_clusters() worker
queued at the end of ntfs_fill_super().  It is also the only place that
publishes the result by atomic64_set(&vol->free_clusters, ...), sets
NVolSetFreeClusterKnown(), and wakes vol->free_waitq.

The function currently allocates a temporary file_ra_state with
kzalloc() before that publication happens.  If the allocation fails,
get_nr_free_clusters() returns 0 without setting NVolFreeClusterKnown()
or waking vol->free_waitq, so callers that wait for the free count can
block forever.

The readahead state is only used synchronously while scanning the bitmap
and struct file_ra_state is small.  Keep it on the stack and pass it to
the readahead helper by address, eliminating the early allocation
failure path.  Zero-initialize the on-stack state because
file_ra_state_init() only sets ra_pages and prev_pos.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 7e3561265b47..14fd244f29fe 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1954,7 +1954,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
 	struct address_space *mapping = vol->lcnbmp_ino->i_mapping;
 	struct folio *folio;
 	pgoff_t index, max_index;
-	struct file_ra_state *ra;
+	struct file_ra_state ra = {};
 
 	ntfs_debug("Entering.");
 	/* Serialize accesses to the cluster bitmap. */
@@ -1962,11 +1962,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
 	if (NVolFreeClusterKnown(vol))
 		return atomic64_read(&vol->free_clusters);
 
-	ra = kzalloc(sizeof(*ra), GFP_NOFS);
-	if (!ra)
-		return 0;
-
-	file_ra_state_init(ra, mapping);
+	file_ra_state_init(&ra, mapping);
 
 	/*
 	 * Convert the number of bits into bytes rounded up, then convert into
@@ -1985,7 +1981,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
 		 * Get folio from page cache, getting it from backing store
 		 * if necessary, and increment the use count.
 		 */
-		folio = ntfs_get_locked_folio(mapping, index, max_index, ra);
+		folio = ntfs_get_locked_folio(mapping, index, max_index, &ra);
 
 		/* Ignore pages which errored synchronously. */
 		if (IS_ERR(folio)) {
@@ -2024,7 +2020,6 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
 	else
 		atomic64_set(&vol->free_clusters, nr_free);
 
-	kfree(ra);
 	NVolSetFreeClusterKnown(vol);
 	wake_up_all(&vol->free_waitq);
 	ntfs_debug("Exiting.");
-- 
2.43.0

