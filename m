Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF53E5A14
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336602; cv=none; b=Gp34sN2uUMWzJqkD63bpkNC3ENjwf03XgCu0VIOKCse5WPlHJEOZwaeRuLDS5wUZBJPgf7acl0ae4ZhJrN/nWty6m7ZjDZbphTjwMlP+yGfoudsUvwtRDl4mhFSYX4aBsd9ud9g38Ge7X6YJp0aFSi0gsIBrSuAZoLfhWzBge3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336602; c=relaxed/simple;
	bh=+M3qnWWmidwsXgVgDN29tUkdj+H4zV8z61JIEEtw6vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsutikgA4LYORnE5jOIbnMM5AGazDfMQdqg6qhaTlBGUWyX0vBWc2xJ3f3+7CcAbYQ8gJh4LjwuMAY+qP0HoZCEiqHv49S9U+Dz8mDyNrDVaC70IB1Q3gC5bxzWQ/LKim8tLrcYMFtuZ0gGkFuPlq5n/IxR1PHg1Ff/QUTMfFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/kjljQN; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/kjljQN"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a0a38a013eso283579eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782336601; x=1782941401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUcXjO78YurIO5Ne7YTcUW1ZByWEpGaEG2epb8Eo1js=;
        b=l/kjljQNTlj8jDPuNIn3uVKotmF+LyHSndHGfB1k290I0yMR4on6BBVA42mYoKOAe0
         A+BM89I2+jK2bCcQAVOdP9iOEWzkyOXDQVW/FYDevmZBIN0T3x4ZJvC8cWc+Ito5s9Dv
         fsY3NVx1zHUO0+x1h/iTLKQiLaur5u1jYLCpGem3M9K+dFkEhbD1GgLlo8Zrnwb1TOfh
         lnK0QK3yV+JhZBxUQbXifz9UHL7mufW7Tp5T9dgyepz/37Qw+kERwhT8Qg0SsJhm0yBz
         y9FcrY9wMk0PIa2hZGyPcZwuPdmZDyCAKZN6wiFwCONWeQ69gOBjRrvDkLdS1/vOq9fX
         2wmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336601; x=1782941401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUcXjO78YurIO5Ne7YTcUW1ZByWEpGaEG2epb8Eo1js=;
        b=mNRrScnjdS/hr3AhFLXAA3KhfGmvPgV98ZfCFVcOyIsW2V480QkOumr82ZWr/U6tw9
         wNWxM3ho7jvjkmzt96/Henjnsl0W9lf8UaJYjlEEU+N31nWrAW4HHakvN7Hs/HNFWc6j
         YauipSoEntyegpIDF9eCrGYqtj6C90PEv68CruFldk2goNEU1Zbh4/wxYcXG61w5+23Q
         TizS+P/XAX7Io63pFbXHVkKZV8UjHxizjHKf3ic+h2mRbm/X0mIg1n0tgKjT2gXLx2wA
         JAF7CfOMc01+aZMhDnb0V7D9DWrbZ/1BmCeHRjX1EvhKTohaSThbLbfJY+vZGYh3BX72
         /QMw==
X-Forwarded-Encrypted: i=1; AFNElJ8O7M3j8CqGDJ6lc6js8ZyliryNLRwNurxJqZQbd+uv51HZmsBPmbBbi9HVo/Xu3gT7Kb0JDFJbvXlZLcsN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lO70i3WkHVMCBAMx0GbltDQEpBlQz4KcIMrkAKlFE/azVBnu
	Xz7HlcwJJg0kWkikFmo+XvptCor52P9ZLvIvZA+Ou0rb2kZKtoRvcC+4
X-Gm-Gg: AfdE7cmq6TVqngKfNerp5CUVO+j/k5vszG3JPbyUmIuvaqFscYen9D5SVUGPudKXkQ3
	QBy4/wG3/JfkX+XTqmfsvNabfuQ38IAXwiXMYg6qaz81CSKf+ebQaNnW04XeXwMqNVXCD3/CeMJ
	96nxN/kc1z//17mDDGEyxQgIG/CoBbnfaTPwT2aEnzSGgAj2PLS1mMV6nhRtgoZtCQihOdUDsaX
	DLvf/TTkXikkzOXr/HPm0YdsVUsY9goVkE+gxgcaJFSjuXQhydm+UMMEFPm4MNWsakOgiGABosI
	xVwpxnfu4rI2/lOvRUTFOGi4Rh+Uv1Mz1o2QPWcdE0egJGXlc6C0/oxJj9P6NdwIUbSt2PGJ7Bm
	bt4RDvVpK6s2ctmH9f9N1OVZB1GUg/KrgWFQUMyhqPj2BpsfTGUabmP3L80Pv/LVuOmsdR967N/
	nucAtzA3v2LRtfB+bndcKwmW2GJjJc4Z1mUfRa4Z1b6HwDJEQHjuyS0UFQjfU4Tbs=
X-Received: by 2002:a05:6820:6ac5:b0:696:711a:c1b8 with SMTP id 006d021491bc7-6a12d8245admr1242893eaf.15.1782336600506;
        Wed, 24 Jun 2026 14:30:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0ea1520e4sm9667061eaf.15.2026.06.24.14.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:30:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	hch@lst.de,
	djwong@kernel.org,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v2 1/2] iomap: add helper to mark folio uptodate
Date: Wed, 24 Jun 2026 14:29:24 -0700
Message-ID: <20260624212925.1668662-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260624212925.1668662-1-joannelkoong@gmail.com>
References: <20260624212925.1668662-1-joannelkoong@gmail.com>
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

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 6 ++++++
 include/linux/iomap.h  | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8d4806dc46d4..bc33c34800e8 100644
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

