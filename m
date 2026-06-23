Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5A39EF01
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246594; cv=none; b=byyTdf0CLP/ImpyetwTJ5zFvAlZNOhrq9TOkhv/pCxbAY3GISSjPFH4kopkuoTOC0iD/cyOtkvKRCSoW44hsb1NuMUiURU//tF1TnYfrKqyP3QDqziFr2kRlwdRvEg0n77SYbRWdT7oo2wMOPms/lQHHfr6RsYJQ6WsRCykyROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246594; c=relaxed/simple;
	bh=2+8tVOfwDf68vCe+d/s/szzPyeBRmHiP+I1lxly2LGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNUuUngPvaJQNcGk4AA5H66t+aUos7vQAVLMppJnE5d0UtboxImBpnv9cH8T1wHCtXNKFQ5t3OXTlCEdhPTX9yFfLXD5TYEQAHdrETQ9F0iYBeainp6pKpe5WKx5++0sDO/yvGm9xDDtXig9XTdC286zQ2z3w3sTlQ10HMFUNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZMVkLSo; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZMVkLSo"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-487167d083bso246746b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782246592; x=1782851392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgIgVWeSZgvZlkItF0V2KO2lUaYqyK8pwWNqLatBa8s=;
        b=OZMVkLSojr95+XpVCg2+/aVDD/iqUGst8zDd8XPgQs/kEh1kADo2yQ20rw/mNgx46A
         /NDP3WKLPMVPoLe5KiOb7ODY+jG/6vXzA50Tc/O+oNRvJHp2f9Ds2DKaPecCllXVR+6W
         WPy35yu2MGUz0Piw9vPd9ArflpHCkJ2FrsOEHxtNQgyh7O4TBatTkDeEpdyvjAcNJG4W
         9qrhY2vvpZTsxVJrLU1ESqrvDGd+H1CSbcB8uuy1D1cY8LPKzKV3DG0Np05Nn+HoDJMB
         v0DFwEMCKRWOwSccesTg2DcU0nrKbpbMEOzwZbvkMeCsJvIZQW+v0AW5Pd+ZH9kGvwud
         9ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246592; x=1782851392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AgIgVWeSZgvZlkItF0V2KO2lUaYqyK8pwWNqLatBa8s=;
        b=OCrkP2wiiawXd8HMtqx9W7AfZV+90SZh1R7si+EEOircpaepuBWp9WWcpO+0DP6hQW
         cO6l2bdkGvcF03lV95ffNW8V2S+gR+okj3Aqt0hI5ugTthPVRaiC4DmzqXh5arKk+Gt+
         e0C3SdkyI+/3T8vTf95Tz8NH6w0DW6c1rvx1+FojVoDB5m0cGjAI8ZpaM7Ozsj1c7R+u
         ZSXXS8alkD4lgxWRKU2JNAdAvOr0H/u8qmTUFNst7EQFNm559bwIF/xkAf/j4eESAaXy
         9q5/6YcUoHltFHfuiA0O0RLwVsIwrn54+v3H9Txw0i+aljsmKWKrdyPCGc8qRLkaWTdP
         X2Kg==
X-Gm-Message-State: AOJu0YytdXG7S6irOwgbrtOOdbxB4TFgyZKqgkUUvErovwVa8uf80mua
	9XqCtoftQsO2QIvWBuyDLmtdvN/Jufk0RyCCThw5Q8datTYIsKtlJPLsnzCL5A==
X-Gm-Gg: AfdE7cloZvEnO/XDq2lpWcvK+1jCXvdHI1QUhpDEf676uX2CzMloedQEaGxR84pijis
	MooXk6heTxhrMYpBGfH1hnoZ2CfspGEpkn5K0BAwA5rqEqDzc/UxZKy9dC7D1vt1aauLpZhnyN+
	bsPxPmWjD9eVoMhcP2gJ+XaJz14I1pW1bALwtDJjPcobaHJai/5O9ODS8DlXjCipPSKdNsRZEpl
	8g2EYcmANWY2wm/VPuRNWuLdsmrppzfSB4dkv2yPle+kMT1v6hlLjvuiX3orj5HVAoDnd83hwi8
	IRp86q5se9ntvJkpV2iufn43w3hqPckAz5ZuKTRpTlc2gjFyfiGIeQf46PrjLmF/adE8SrCjxsO
	rN2a3rDDvy0YYoucIUDw2GpDVWl8Ibu4AH46zF9jXn86IlEOCzRKpYxLbEZhJ4vsd5Z9AwrVITo
	QOz3o6LktDjxcIQUtc3jWuRKDM3nhx0c0aUWpZB8ssBmC4+1Mo/j+gsUq7PZUl5cE9
X-Received: by 2002:a05:6808:221a:b0:48c:9bf:de7c with SMTP id 5614622812f47-4907a0836f2mr261171b6e.43.1782246591845;
        Tue, 23 Jun 2026 13:29:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0dd2bbsm7197107b6e.6.2026.06.23.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:29:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de,
	djwong@kernel.org,
	miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v1 1/2] iomap: add helpers to mark and clear folio uptodate state
Date: Tue, 23 Jun 2026 13:28:41 -0700
Message-ID: <20260623202843.2064992-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260623202843.2064992-1-joannelkoong@gmail.com>
References: <20260623202843.2064992-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two exported helpers, iomap_folio_mark_uptodate() and
iomap_folio_clear_uptodate(). These set or clear the uptodate state of a
folio and adjust the uptodate bitmap if there is iomap state attached to
the folio.

This is needed because there are some filesystems (eg fuse) that have
paths outside of conventional iomap calls that need to mark or clear a
folio as uptodate (eg writing server-pushed data directly into the page
cache) and need the iomap-internal uptodate bitmap to be in sync with
the uptodate state of the folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 27 +++++++++++++++++++++++++++
 include/linux/iomap.h  |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8d4806dc46d4..317fa7af98bd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -105,6 +105,33 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		folio_mark_uptodate(folio);
 }
 
+void iomap_folio_mark_uptodate(struct folio *folio)
+{
+	iomap_set_range_uptodate(folio, 0, folio_size(folio));
+}
+EXPORT_SYMBOL_GPL(iomap_folio_mark_uptodate);
+
+void iomap_folio_clear_uptodate(struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	unsigned long flags;
+
+	if (!folio_test_uptodate(folio))
+		return;
+
+	if (ifs) {
+		struct inode *inode = folio->mapping->host;
+		unsigned int nr_blks = i_blocks_per_folio(inode, folio);
+
+		spin_lock_irqsave(&ifs->state_lock, flags);
+		bitmap_clear(ifs->state, 0, nr_blks);
+		spin_unlock_irqrestore(&ifs->state_lock, flags);
+	}
+
+	folio_clear_uptodate(folio);
+}
+EXPORT_SYMBOL_GPL(iomap_folio_clear_uptodate);
+
 /*
  * Find the next dirty block in the folio. end_blk is inclusive.
  * If no dirty block is found, this will return end_blk + 1.
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3582ed1fe236..f13ae425f552 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -365,6 +365,8 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
+void iomap_folio_mark_uptodate(struct folio *folio);
+void iomap_folio_clear_uptodate(struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops);
-- 
2.52.0

