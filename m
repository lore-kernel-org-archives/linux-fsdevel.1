Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816930;
	b=FdPpPhHRnnDYi3TJ8AQ741fSeNf7zEIBrrbMXJ8/cYTDeljIiGcmrjOs9YbsfUcnnfrg
	 OjpKa9vd5QysPapeKVuyYehAyHW9RT3VpVEiGZgNlDsHYpoS2xhu3rhTQlwBANAl/atc0
	 bzdwhXShXW/Po971VyVTKKba4GOpvEPP6zfTK5pvZcMTJk0X0f8zoJtQrm1jreiXQB3Uu
	 Z48OOy8FSUHBJ/GCYQtVJYefgMemYA7l+LD3doDgGY5dF5pZuKZPoz1yZNtAx0m2shJxI
	 eHnWO5LkdRoPoLdyLpWz+K0ccDnjdgkcHVJdFBQCWZ6KwECCN+G+QpRv23MH0hIWLow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZfV/MIPNusOwxGNpLw6806W5l7124cFpZSpiDn2muzo=;
	b=mX0hKYxmeLDP+j+SuUSd/yGLZ3N5lGlWQI5k/iYIG1ywlzV+M0Q2erFAkvo/onop+gWt
	 3oHe2P+b2SjoT1KHxKMpmmYI3pvdO6nTRKTrZr3W0k9kPfbq6T2MpiFnnULInxg8hhXnu
	 ec7gJ6v5Z37r7i7sdQVH2OWTaQrKCTbOZc94OCFqn6QWhQwGAe85cuUi4BSPiKBVhfjKq
	 bHdqs+0BWT8I0grBWvAzZ48kl3UY3AHFW5Z2GD53lkeJ0C/WoUPhgh2ZrY0pI8nzzb+RZ
	 d09b++BWmEo8qn2uYFtY6fXTDCpQ2evy+BnmYu1XyH12pu8bVyKdxcXqfbcCrQPY/kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKijh+zr;
	arc=none smtp.remote-ip=74.125.224.136
Received: from mail-yx2-f8.google.com (mail-yx2-f8.google.com [74.125.224.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1DE606A8D1
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 18:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB1DE606A8D1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKijh+zr
Received: by mail-yx2-f8.google.com with SMTP id 00721157ae682-8ae660ffc4fso3682557b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 10:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816929; x=1794421729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZfV/MIPNusOwxGNpLw6806W5l7124cFpZSpiDn2muzo=;
        b=LKijh+zrxR0KzT3Pe3wS3BowJWj1KgLj1Jlrj+30oyYQ9jT1KGrjNromsNrgcSmVSj
         9UFypbc7r5t2JPM6byoH7E0yC3plnVagYffApOuCITZ7O5ewBrIxfgusuP7Ew6FiBXls
         YT7v6aCHXThL0OH5hTa0VoKfs+e9GJM5kLUYgwSgDp+MyR4azScvffbSXz+8ECVfuwdc
         PZ0t9qVL3e5J2WYKqGUmowb5656ZbDERDcV6GF2741KeeK7XHt3s3bCuJybO2Kkd9/TN
         9Mk7pcRg3h5aREBYU7MuOmFXdw1zj/aV9XBdPy3T4mogxUupwxFalplpTrIxz1MfYKq3
         c4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816929; x=1794421729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZfV/MIPNusOwxGNpLw6806W5l7124cFpZSpiDn2muzo=;
        b=jNPslAVbAvv/WJl8ZPiqWQF5IcAxUY5NuQvm4dSl6x5lGQv2vbrk/f1//kmS5coYN0
         nhAFaMPJFpuVqH6XWdLaWWL6YHlqpHLRSej7fvvKeqH7EHSk09IvD79y7tbC1Sb32a4B
         O0Kdj3S3pcNtOUmHR8a9koOgLekD++Rlzrbdv9hGcjs60Yk7gw4+GjIOE/02mvj8b4YU
         vyULZA7Zd3mE/p5v6AuWFaJ0ELoQWoXRDUDIsilWkgfen+AfKfB7yrt5tNWClNynCT9S
         R7tnnmsnDhm9J2e04BkPzU2SJIIa8kH7aRGDdEWc7LfPnTko997/EIuwcNQPBJBLK/zU
         AAig==
X-Forwarded-Encrypted: i=1; AKwUvBwGK2KQP2YVJD5biLxhdniuO0A2QQNLknBqFlgkiK50LEF//cKMtbcD/mFz9SnGm+2LzywK2x32DGAXvot7@vger.kernel.org
X-Gm-Message-State: APuU4Z9RKdpzqJh2T+pOhphTVB5vlaEMF59bNAB+8LrKE3svrlsOG+bg
	aHxKOwd8gPlYEUB9IrUC8NJRgtW7FD8/NhPt77DPYdQuFvZmvKtuoPUV
X-Gm-Gg: AYBFou3NcTHyS9WpZLei2t9JaQUwXmfe7vHXajXfpty7CZu4TwRzDciYvYeN/tU6Cbz
	mRPLbLHdGeWGakWdkVvbVOOpvJ5W+uVy7dPH2X1VygAQuhujJIC/2iQx5QrZMb4cnM0S2M8frK1
	2cFGthdm/PhqMnMSbWsj0A7P2n+XcpeaykDlAEIsfKD/kB6EKjXmE4xmOHZbVpKljWXeXk6AZUj
	b+Tpnq2HLYqoljZKq3pZP2J5tQ2hzmXfDrPTiL0eOj2lNsg6QIquqFRrvxX1p42VZowAVvgdIH9
	Lr2s/dof4x5WtJl5vlzi5oNeg9Wr/40SXXsSo9FcQeig3NKFUA1skB6oGO00EMsrdzxfhzuLfTz
	MS0FJWShSzb++W/6dZgBvUydFoZ80nnYHMeNNFz4GJyF34XBKW9ehTvG7cS3+hf6CgC6OWAT+tj
	+8gKBNBT35JU2184peQWOAiTN77jAN45NI0WvbaqTZd7R60hNgjobooaKwNIsfSwAaxruDnBwev
	CSyS/hl76xUZI4//z0HDoFaN5WTX0XbziBR6fzaqQ+J5Cx35/9RaKB0k8Ab3xPvbFqP8HeL6K21
	reuef+uX6qZherVXWuMEP/Kr15gSlZz7mlQJHCQ9F7YeG8UsZrjeASxqTQQuueiXAoKuND8KC9r
	eTiZmCmvQGJxnecaxQaCoR1PxkMEz9Fe4CkuDDbq0aZuCsln47U25lbNrn7s=
X-Received: by 2002:a05:690c:8f:b0:8b0:acc6:8e89 with SMTP id 00721157ae682-8b2b66ce839mr104568597b3.11.1793816928629;
        Wed, 04 Nov 2026 10:28:48 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3099291d7sm24336017b3.16.2026.11.04.10.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:28:47 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: willy@infradead.org
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	lczerner@redhat.com,
	tytso@mit.edu,
	hughd@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] mm: skip empty finite ranges in truncate_pagecache_range
Date: Wed,  4 Nov 2026 18:27:00 +0000
Message-ID: <20261104182700.88789-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027211505.22044-1-dennylin0707@gmail.com>
References: <20261027211505.22044-1-dennylin0707@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a finite range ending before the first page boundary,
truncate_pagecache_range() calculates unmap_end as -1. The unsigned
comparison then treats the empty full-page interval as nonempty.

For example, lstart == 0 and lend == 0 cause unmap_mapping_range() to be
called with a zero length, meaning unmap to EOF. Punching one byte at
offset zero in a mapped FUSE file can therefore remove mappings outside
the hole, causing unnecessary page-table work and subsequent faults.

Set unmap_end to zero for these small finite ranges so that the existing
unsigned comparison skips the empty interval. Explicitly handle lend ==
-1 and lend == LLONG_MAX with LLONG_MAX, preserving EOF handling and
avoiding wrapping in the endpoint calculation at the largest inclusive
end.

Suggested-by: Jan Kara <jack@suse.cz>
Fixes: 5a7203947a1d ("mm: teach truncate_inode_pages_range() to handle non page aligned ranges")
Link: https://lore.kernel.org/r/20261027211505.22044-1-dennylin0707@gmail.com
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Compute unmap_end directly as suggested by Jan Kara, keeping the
  original condition for calling unmap_mapping_range().
- Handle the EOF sentinel and LLONG_MAX explicitly.

 mm/truncate.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 733d2713a87..2c1f4a6c336 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -945,7 +945,15 @@ void truncate_pagecache_range(struct inode *inode, loff_t lstart, loff_t lend)
 {
 	struct address_space *mapping = inode->i_mapping;
 	loff_t unmap_start = round_up(lstart, PAGE_SIZE);
-	loff_t unmap_end = round_down(1 + lend, PAGE_SIZE) - 1;
+	loff_t unmap_end;
+
+	if (lend == -1 || lend == LLONG_MAX)
+		unmap_end = LLONG_MAX;
+	else if (lend < PAGE_SIZE - 1)
+		unmap_end = 0;
+	else
+		unmap_end = round_down(1 + lend, PAGE_SIZE) - 1;
+
 	/*
 	 * This rounding is currently just for example: unmap_mapping_range
 	 * expands its hole outwards, whereas we want it to contract the hole

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.50.1 (Apple Git-155)

