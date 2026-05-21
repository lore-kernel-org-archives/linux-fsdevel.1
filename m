Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B23DB334
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368437; cv=none; b=RhoQAx1gczzCuvSwYyBMPjVv/BTwkOoPvBJmfOsGJdUhMuvu9s369GSf30zDpJw05XD3VuAle0wO5bwXP3Ql6afcFZLf7Uj8DB9Y+JDupYhHWIwWMFcYjgxGzgwcMSTJvdGvpLOmXjHYePrp0B5vcFKuVkdV/89ywQ3q5YBYjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368437; c=relaxed/simple;
	bh=x/2x0r0BsLDAdOTno6N4SEpYiLbcdWoIiiKinLXvW9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw0GhzrESatYUIUzy7vhxClcmcsTYy3hd1U850UKWvi8Pu56sltmn5EeARqnyvFsUtDw4ZcqqNdbWelSI/0dlAUBKSEYXQSSt4JaeRnPwLJZgO5JSGrb6jY7AK0mq+O6TS5AtOKci0yYasKTfIe/dytcYcT4t+aguzxN9qe8b8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy00ls3+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy00ls3+"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83bbc41c7b7so290458b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368435; x=1779973235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcTSmoZSiShVO6fj/a8g1RvNK8Nfba3FyLnR3wmldOM=;
        b=dy00ls3+HYQVcaB+rZ2HpNDC6ZezfqZ/lc1mjHjXhjT9mIqwSiAu7STCLU+FEbjrKz
         L52zPqsCMQEhMT68qy57rg3JqbExSM+KqaFTkLTEIgPljfy8xcoRRldQ4gG+zObemjHZ
         aBMBvSQWodTN5fBFAYbmom2UGoDgRd9Hr8gfGTdgu4Gr3Hayv+RXIT60gGPVD6RchTZ/
         sZhhzwOvvyoEBNHMcsa47XJew3rCYBSuW6i9zbdfCkzQGoCm+AuirB1Qd8tx4I4xRgj5
         F4n5/Yf2a0LmbKtd3APJp1OzoJff0urfcuRQ36cCuoyRqBndc/fLSd6ADvB7FS4cMdyR
         EJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368435; x=1779973235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bcTSmoZSiShVO6fj/a8g1RvNK8Nfba3FyLnR3wmldOM=;
        b=CPc6PDhP1YovS9oVOEXdWgMhcSQWv/ybLG7/u7G3uPjojXnETRB31EQZKvNTHaVs/m
         aVIbqHXUDuF+053Bpky2JrvyOplLFA/KICbqRhfcfepBO5ME/oRu6CSBqPuW3t3zb0yS
         1SFC/+3xHt0Q/qN5VkK7yRWYO83THXpCcJuiyZVXKZKRT7fzUTH4g9ZKDc5PfXtdSXTN
         2UbxKOdJr0tirL3DMEoJW9SHX6jdsrXjiFPm5wT6Arx/ZPkLp1lkXFAWLVJFyCkLwOs3
         /pQF42uOWZ0HY2l3kq6QiA77K7Ih2zkYmxNvNm0/Xx6cBvLJqoZceaY8iho3VYBHCkyQ
         gtzQ==
X-Gm-Message-State: AOJu0Yz+m5EUHctoOrAfrMB18KSltLxnO1ZXfKDeTVvt53vp5DZQt1w+
	L/J2BsOahwFi2sIZAWiAGpw1OAlCBL0/AuA1kw5YKcHWCTsy4feOP6b3YRCRfA==
X-Gm-Gg: Acq92OHisZTs8sx2n0ZgYMlpZk0GLgRynKOSAo1cTv7gbNn44TTRKbrP91E8STwVFrb
	gq3+Kuwh+ZUh71fvBytAv+NQJYOD/r/kqHxESsux2+m30goDritjou1G4vIVzKSd/SMpzkgwJqQ
	ilndIsajzN9+GBCNFJVCPwsVJBOdTXWSuS/KArP2VqpPIqdHO8NSul3Fz/1ktusqDvxnJCaAkEn
	L5pro2+6Inu6Fk2b79D6B8S3+com/HhQIlIgXGTGxwVMBJ0zNYChGQabqKZvKtl+1PmaM3R3ZQo
	w2JSkGDC6MIMjhZaSoyfqn/h+OwM+cUi7nXyZGamwsU9To0HUrVDgxTZ7IFz7egHyS5IsbM3UTW
	DpCMrDdfCGcnJF/Kq2//9Xc/EWqYZI7OVNOR0RJiK5l6UBkxq/6+1DE4LgIodv16xA662+VnIyL
	39nIch9LXdBT0aoTls
X-Received: by 2002:a05:6a20:c98d:b0:3b3:203b:3068 with SMTP id adf61e73a8af0-3b3203b386fmr246779637.7.1779368435382;
        Thu, 21 May 2026 06:00:35 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c851993d8a7sm284340a12.27.2026.05.21.06.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:00:35 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v3 2/3] ntfs: avoid heap allocation for free-cluster readahead state
Date: Thu, 21 May 2026 22:00:16 +0900
Message-ID: <20260521130017.713848-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521130017.713848-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
 <20260521130017.713848-1-charsyam@gmail.com>
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
index 7e3561265b47..d2c4fb6ea0d4 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1954,7 +1954,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
 	struct address_space *mapping = vol->lcnbmp_ino->i_mapping;
 	struct folio *folio;
 	pgoff_t index, max_index;
-	struct file_ra_state *ra;
+	struct file_ra_state ra = { 0 };
 
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

