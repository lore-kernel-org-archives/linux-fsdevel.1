Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009F45BD60
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459678; cv=none; b=YoLznTtkgTaFxafYrkQf7JmA5HPKOMlT7Qy0pcgxEFGjM6nrhNnWyhQMmU6EkP+2CdGFBYH2WoZ5Z2Psw5wesmN9LqzKi4pUINMP7FXdqVF8yZwpP3rfu6mcHkrmo5jseml0vXPK15ERwCLRtkEnQ5PaOJ9UgQFJ4v/1GJ3B9tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459678; c=relaxed/simple;
	bh=e/XQ6di4Qf/V7YJFDfeInjZPqQMrEo1MHXIHSm37VgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFIQsyHDsD3maAw8gFRRR+U6yzMyi+8OIgokNwQu37mvyM1GTUrWXc9SjBk1fa6akctyCNV6rx/h8lKTfIqh1T6Tq6lc7NLhb6k4SUAFz18vF+cUqyUyeO3A2U5PpHVvyU98NxuDrq3OvbkMkzFwAKrCJ5tzSg9/+xF8wLQeaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctrBJ9ef; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctrBJ9ef"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-369c4bb4baeso990030a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459653; x=1780064453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUYTSun9nFl805qwarsJbDtTWjRMthsch5tO/uUnULI=;
        b=ctrBJ9efkJPXFQ8HFkUslk0XtGvCI4Exlt9xYbt/gxbn6L/cA8RVx5KeZIhtiLFO9K
         oayzhhqrzfBF9EYflSM7dZgJApNxTeXtbsUVPtuI2zxbqfsKdYojQHn3p5kbwUX81rfe
         cZdtI0wdXQtmZEPOttgTjfucG2PKCmKXrquhC3SVigoYUuNuDog7fAX7Y12Ji24O27kr
         4cG/M8ukkYmwTjcVkQImH8e1BmUs1DgEkCwpFzPQ5kHV1OQv2Cq0Awt6addqgny/DWu0
         lLEvA+QCrduKe6uCFGJtiYicHwnc50nqwheS7x9dN+e46RFs2RhK/GuUWbeSLPeE28FK
         l4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459653; x=1780064453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUYTSun9nFl805qwarsJbDtTWjRMthsch5tO/uUnULI=;
        b=ZFPmOo7gpghAI26dsaS06Irb3Jn1mE49ZFFWeGlE3+AbZBlJkyZhrKhEG4En+pc2Si
         4EWsILbRi+EiqR5r2rc4IpETWGCCc+GAbt5iAki9kqIemF2IdDNMuGY08ZWWmixEWP1L
         ELRhHGea0N3dV9r/5MR3nC0Mpu2++6v64bGYhRF/BUq8k1xecez+4/fQQnBVSZtMgVqq
         w8eezyg8pGgKniVSJo/Sj0NPlr6f0etT3x+fdP0Sv/MJY+7FjYULlJ2lCEvtxckwjJvG
         YzUiv1GsmcIs2ylHQUznkeuy7acVrDsPNHLNX1lPyTnvw7nOm9OEjEagEcS9iOSAU57i
         Wrqg==
X-Gm-Message-State: AOJu0Yy4PCvqHqAcuNQ71tqns+iDW8BDxCkxayXXAU6AABJVhINOpL2q
	eWa26lEssDWKcygXR9igWk0eFpGjBRyCxXabIpR7i5e2mBvJLtm1ysBAA+x+Yg==
X-Gm-Gg: Acq92OFkAGcid3ODY8Ux0ha0alFBncCgoR4S9EYc/6qGR91e6Gr4xAzEqVHcQcuHaDP
	Qbgbw2Hb+3eXHjxLOPKJwliwDZfT4eLoeqCxRfjD9JK+64cnPaYc0Cqe2VR5fxz0k+6s94Db1h7
	9aCXv9JDvnU6GVfu1MlpcNCKimBfA/ALqSDP3t+qVKcaBq6iq0tyaymfnDT9HF5zrx/dpi9VO+g
	lUB9IHXXX6fF66y5ck6gh0zY++7YWtTn4t18lNwYFltcjlfIJFb+Y/BGVAQJhU5EjNh9OW6usy2
	Px2bLXM+XhbNc1MxOChYdyaom92VvTN7iUQV6DlA9k8mUTG3Q1SGxuPXycYlWp9HnPRiwCznbpO
	RfqjCDNSX4pJ0ApCWBMZS8KAGPKqXxIBkSuZi8OFAxim3tB3QfpzLUvNVXoRHCKEN7n4XNWn03K
	EoJOxP00L+Eyo/NPaMkVolEQgmgZw=
X-Received: by 2002:a17:90b:3bc6:b0:364:b4e7:6706 with SMTP id 98e67ed59e1d1-36a6741a7ffmr2544742a91.1.1779459652845;
        Fri, 22 May 2026 07:20:52 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852028ff19sm1735120a12.5.2026.05.22.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:20:52 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v4] ntfs: avoid heap allocation for free-cluster readahead state
Date: Fri, 22 May 2026 23:20:48 +0900
Message-ID: <20260522142048.1666937-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_nr_free_clusters() allocates a temporary file_ra_state before it
publishes the precomputed free cluster count, sets NVolFreeClusterKnown(),
and wakes vol->free_waitq. If that allocation fails, the worker returns
without setting the flag or waking waiters, so callers waiting for the free
count can block indefinitely.

The readahead state is only used synchronously while scanning the bitmap.
Keep it on the stack and pass it by address to the readahead helper. This
eliminates the early allocation failure path instead of adding a special
case that publishes a conservative count and wakes the waitqueue.
Zero-initialize the on-stack state because file_ra_state_init() only sets
ra_pages and prev_pos.

Apply the same treatment to __get_nr_free_mft_records(), which scans the
MFT bitmap with the same short-lived readahead state.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Changes in v4:
- Rebase onto ntfs-next.
- Convert __get_nr_free_mft_records() in the same way as
  get_nr_free_clusters().

 fs/ntfs/super.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 9ebd13d1613b..2a5ad7d56bc2 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1848,7 +1848,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
 	struct address_space *mapping = vol->lcnbmp_ino->i_mapping;
 	struct folio *folio;
 	pgoff_t index, max_index;
-	struct file_ra_state *ra;
+	struct file_ra_state ra = { 0 };
 
 	ntfs_debug("Entering.");
 	/* Serialize accesses to the cluster bitmap. */
@@ -1856,11 +1856,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
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
@@ -1879,7 +1875,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
 		 * Get folio from page cache, getting it from backing store
 		 * if necessary, and increment the use count.
 		 */
-		folio = ntfs_get_locked_folio(mapping, index, max_index, ra);
+		folio = ntfs_get_locked_folio(mapping, index, max_index, &ra);
 
 		/* Ignore pages which errored synchronously. */
 		if (IS_ERR(folio)) {
@@ -1918,7 +1914,6 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
 	else
 		atomic64_set(&vol->free_clusters, nr_free);
 
-	kfree(ra);
 	NVolSetFreeClusterKnown(vol);
 	wake_up_all(&vol->free_waitq);
 	ntfs_debug("Exiting.");
@@ -1973,15 +1968,11 @@ static unsigned long __get_nr_free_mft_records(struct ntfs_volume *vol,
 	struct address_space *mapping = vol->mftbmp_ino->i_mapping;
 	struct folio *folio;
 	pgoff_t index;
-	struct file_ra_state *ra;
+	struct file_ra_state ra = { 0 };
 
 	ntfs_debug("Entering.");
 
-	ra = kzalloc(sizeof(*ra), GFP_NOFS);
-	if (!ra)
-		return 0;
-
-	file_ra_state_init(ra, mapping);
+	file_ra_state_init(&ra, mapping);
 
 	/* Use multiples of 4 bytes, thus max_size is PAGE_SIZE / 4. */
 	ntfs_debug("Reading $MFT/$BITMAP, max_index = 0x%lx, max_size = 0x%lx.",
@@ -1993,7 +1984,7 @@ static unsigned long __get_nr_free_mft_records(struct ntfs_volume *vol,
 		 * Get folio from page cache, getting it from backing store
 		 * if necessary, and increment the use count.
 		 */
-		folio = ntfs_get_locked_folio(mapping, index, max_index, ra);
+		folio = ntfs_get_locked_folio(mapping, index, max_index, &ra);
 
 		/* Ignore pages which errored synchronously. */
 		if (IS_ERR(folio)) {
@@ -2025,7 +2016,6 @@ static unsigned long __get_nr_free_mft_records(struct ntfs_volume *vol,
 	else
 		atomic64_set(&vol->free_mft_records, nr_free);
 
-	kfree(ra);
 	ntfs_debug("Exiting.");
 	return nr_free;
 }

base-commit: 5a717e8c387c2a3ccd372a1b34005c1dcedee297
-- 
2.43.0
