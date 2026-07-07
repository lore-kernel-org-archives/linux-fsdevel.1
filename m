Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC739E178
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461922; cv=none; b=Fai+QN4HgLatWqp5JN87u7UyO7ToEJ8MGJaVgJiFXj0eGZWOPRZpcuVP1KvAD3Zh0/4nIj3OIF94ziPwYE8bsSP+poypgAe/QR0qaHMysrCdwarCY+Grjx55WkyCD4M3WQ1RTk197oTqLYN9DvW8hDLYSRJh4I3WY2D3rk1Ighg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461922; c=relaxed/simple;
	bh=lLknAOl66vqVMZMX95tlcaRrtzKncokUmfi+7mwz+W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwJmTylYQFWRGXXzvDoyzRq2A1zk/SJ+t2SByj347OI91oSXWAJtZ+Fw1swDeJjhsGkRgM9hT7/GnmlZad39/m5dmGHcxQDuojK8cNOy3R++PtMhXoojQyMDDwhBmXLJtKD2KcIE+Od52ulAm4LtVimyEryfxsSudJpcolIngFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdH185cz; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdH185cz"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso55224a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461920; x=1784066720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qBDzykVI1mMkUWW5G8//ew83MtDDt+WYhhmrBSD4JyA=;
        b=PdH185cz2ol7OKOuXLX5oGBdLU+YyHQCFZcOrubQaseVCdLj5ZKjIb7hXvYJwui8tf
         nvMfb68jFlAdZS5z1td4n7b/GJ7ddcJ1JMmCEIcHkYIiWD6hkP3eWqA2YQaKTu93Mx4Q
         CNCBxFthGMzMga8JhMvxbdY0AclS7wn4aiqkFpHxjk7YwG7DAbYCdU5XsnzZtCTr0CZ6
         8memU/KtL1jddyTCASudun3evaZ869K3Hi07LFsamKuq2ktSaIwSXUfxo7fwrH8S0tfE
         7TS7flnYICQCCj052maSoLS6sh9Lfsyoucr+MWIGhuTxFQkqnbnGmmU0VTNkbqUMQh0w
         p+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461920; x=1784066720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qBDzykVI1mMkUWW5G8//ew83MtDDt+WYhhmrBSD4JyA=;
        b=EwrcAG6AwFBBvK0T+mZYilHNOGXh4jfGYzfRYMiAAMCeYdNF43JbCXlVofrkrVX75x
         ZuVbbi+1cWo2a8tbolEDd6UxwdXwR+m+P5zjnI+lH/UpN5aN+AXofNY1TzJZyVcKEjAc
         UbM18IIffMTYkAUXk2UC4Dkcw5lFL1TBvmKRdnDR/ZpKTUdeucMBx/XMWsKTayQS3b0p
         jovClYlwT1hWByn22Mb/4b9PN3e7H+8lc0YU4J1jhu4XbvvjFTJGsYX7Ds3cWvGqQOIO
         y4eFr364FLIGAvA4hj5fiY8HZ/uR1XeT6mFczG3ocp3QLzRmEU2rK11NRO7Zc1iqKPn1
         8eAg==
X-Forwarded-Encrypted: i=1; AFNElJ9vWlvwvMbM0C+HWTwRLGtsXI6D2RNCjUNGQoUr+EGxNWwHISssg1cRRdiUx6aPEO2s5MOR9/kg9LBlVetC@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDPv0iKICtlliUCbdvqmVpAtxwTp+jUfUlwYpLOXbew/zjGZ5
	Jo/6WiPyx4I7hPRVaMQ95J9VXH6TU8lsD0FWPJo4Jl7ff8scyWByOb6n
X-Gm-Gg: AfdE7cmRh1HVRo4690PyUOzrjYw76p3WHCIMq94eki23QVu590RT9v72+Xc8PWbXp73
	R1bM2HevGME2/geXzeESn4jS9TKUQZ77UFM6fC+2IArcmtfp8PeHzU/3Ny0MJ8ydr+bDEa8mhHp
	G4MqO53ccdlj+2a97YnPmnjVuUH+Vuadu7EYYw7vYa6C2XQVM2tKHeK8dHRoxDuIBnwePu0qhOO
	Tg/cVIXNgreIrxWZf10hudZUicWhXobyrHsZBiIKNF0ID1hcfCvXRUtBojyAFp0robNSufm8Fay
	DrWKsG/PiCUepnyT5GyE9qgbSDcl47bNjBKhrnulYE52PhaGpxY9faSUo4Q/82jLjR/8ngjADu8
	SEKzgbVLls2NuOSQJhMS6L+B7uU9vCfFWb+FFn/VV8XTchvXeC6EZXuWVwUmPPnVuA6diSRd3Ox
	80YadhpztdXgY/09s4Y+8HwhB0yeSQULzESceYrOK7rhHg0sFQtJWDRvUqwGRi7mcJ
X-Received: by 2002:a05:6830:6082:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7ebb22064d0mr5512607a34.11.1783461920239;
        Tue, 07 Jul 2026 15:05:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae1dce3sm478310a34.3.2026.07.07.15.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:05:19 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@lst.de,
	miklos@szeredi.hu,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v3 2/3] iomap: add helper to mark folio uptodate
Date: Tue,  7 Jul 2026 15:04:49 -0700
Message-ID: <20260707220450.1200943-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260707220450.1200943-1-joannelkoong@gmail.com>
References: <20260707220450.1200943-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an exported helper iomap_folio_mark_uptodate() to mark a folio as
uptodate and update its uptodate bitmap if the folio has iomap state
data attached.

This is needed because there are some filesystems (eg fuse) that have
paths outside of conventional iomap calls that need to mark a folio as
uptodate (eg writing server-pushed data directly into the page cache)
and need the iomap-internal uptodate bitmap to be in sync with the
uptodate state of the folio.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 6 ++++++
 include/linux/iomap.h  | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 27bc2455a98d..f6040199d114 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -105,6 +105,12 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		folio_mark_uptodate(folio);
 }
 
+void iomap_folio_mark_uptodate(struct folio *folio)
+{
+	iomap_set_range_uptodate(folio, 0, folio_size(folio));
+}
+EXPORT_SYMBOL_GPL(iomap_folio_mark_uptodate);
+
 /*
  * Find the next dirty block in the folio. end_blk is inclusive.
  * If no dirty block is found, this will return end_blk + 1.
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3582ed1fe236..21e73cb9c51e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -365,6 +365,7 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
+void iomap_folio_mark_uptodate(struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops);
-- 
2.52.0

