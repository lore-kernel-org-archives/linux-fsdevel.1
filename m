Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80911EEE6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864707; cv=none; b=neijdVAK4xOzgq867XHtK2xlFZnCxc8S4lXCU0e1Ze4GAZTKppNjtMtA2makAC3Iz7Mc6kV7BqEXFCYWf6ujpjEvfKcpZjY/PdOIU3apTli2q3r6xQow/T5ldrxHEfiNDKGrJ4Ho/lkHGbKn8GmQRE+xGbt4di2MCmGfmzUJmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864707; c=relaxed/simple;
	bh=B0Sh1ggTorqRsvxtr7y8/kgsmh9XzrpKAa81LdQ1q54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cof4864JTkEqCHWxgKyOA3ipLLH3vtqlR//y1rTmoMMjNzAxuEO1/KxC+13QEa39hOqmYjV/vHT7XO4qAj1L3UGDcFstpH2Vi8oFveuVGIhNTGGLYID9ycbVrrrgSvLqXClRC1Lk4SW/veC0i9cVYkrbC5kWJSwqLRkmVZhkbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNa/DiTi; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNa/DiTi"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44aeefa1c00so37454fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864705; x=1783469505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErwUIUAFnJvR8Yr1JXbNUfRvAxBJYDZo6TwpYEonw24=;
        b=WNa/DiTiFoc5fHarfnRL9ABIu616R24nEYICfQ2rf0j8QkSN222MyPlnSgmgTs7miC
         MaFQ9WGt+zHyEBe1FjUox6LffnouNpwLOrvemBhx+cfWNunhlW3x5mT8pASPQfroXmTg
         tlyv3UHc9FnyI9D+J6+UFN81volVwoaffjnQQ4am4Pm6IBPfvze/xipXgbGEkmLLewlg
         54f71XDrb6bpXcfoMVL2w4hePosDZt/082ixZsbAMynfpV0OtwyexGfFZxjN+QO+hojm
         BuZ2w5o/x2o3SUKhtKxTUVW/qj5wfXEMkOce089/Amg9xjXcH120vgWRTLzsQtectQwv
         SpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864705; x=1783469505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ErwUIUAFnJvR8Yr1JXbNUfRvAxBJYDZo6TwpYEonw24=;
        b=TyTCTazRcT7cbG2b+vgMnhZOp29e64FZiHlEZWt8mJ2c47cW9uB43usebnkQ6OzguV
         oAKTFaAGsiHQY239+gyrsN5Cd0cyFT4MSBVfXabm9oLp90oFKick/c5Pq1x+09DMhxhc
         oP6Utr7NV7wqcL1duo2m/QmZjDdeZBcdxuZJjdJP1U5hw1gZqOrBdRGkvh+cIxjBNExy
         Qo4kuagE7ver2lk4a0z2z6cpIaH2yUg3bJrtBKP8g9b0vwMjhezRwGVfQ0wT3iMe6ndF
         uVccRfkutWrslcYOt91K/BjoqkD1deGoyXGYNuzX8gbXqgKNN6wbuXi2iQXtVX+Q5fkL
         //MQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvCFWUc/P1V3L8qaeeXDnDK4j9ZVRuf0840b6OKercee9VJMl6bTcZnJzbTZZ2ceuvlZYcrJu+WeYAk6D0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3QKnyp4RezdJAjIp72YQRa1Am1y6s+ZHYpxtRMtDZX7a2268m
	VRLZ3HA8AOnrZYJi9r9QPlwz1IFHdCwkPBI7m5kYDrNKNT+LnX8QUmCJ0lK5DA==
X-Gm-Gg: AfdE7cko7WC3rUc/U+TN8ODcW+k/M0iO3vSeZkt+xsqJFsoqhZJD0/vY9ssDCrjg/uc
	6LrA/MmyTX9s1uPtzhp7xudDMN3eFkOWGlGmm3kcsgBcXMXrwppAb+rRu4gpA/ktqhja5xoyh2f
	U4gMrMDRET6Jj3wovHlaM84MG0SdHYXChah2ch+6zynGoV4TmjNd6Fd4a+OGoJ+/fVMTr8a3+8i
	0xfKWkqKnyE+zE+eTPgdaT9yDpLTbXcA1bPBat8qCklwzZee08VGTIvSlcyURy2vfFMoibqRuts
	10MfRl0sh0XAdO41LgDwww63dKbzJ7XJYXbzIJjYQKV3k/qUwCodwTQyeSH16MMuJAAemLnRXBo
	Fmkvqag+76MKXWdgKSiKec6fBKjBVOf6fRYj4gbg9RqfURpM2IwWQtxK7Bref/ZN+6gtXEWcNj1
	ES0AiY7E3+L7BluhvgFBNK7yUaWFCt0z8CqPEnGdQ+ksYpbJdwDP/ie+22OPYjBpo1wQ+hg81/s
	uc=
X-Received: by 2002:a05:6871:228c:b0:423:1cc1:f878 with SMTP id 586e51a60fabf-44ae322e0e2mr2197943fac.29.1782864704979;
        Tue, 30 Jun 2026 17:11:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c62027e5esm314905fac.9.2026.06.30.17.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:44 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 08/18] zonefs: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:23 -0700
Message-ID: <20260701000949.1666714-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert zonefs iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/zonefs/file.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 5ada33f70bb4..a29a8756d660 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -57,8 +57,15 @@ static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static int zonefs_read_iomap_next(const struct iomap_iter *iter,
+				  struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, zonefs_read_iomap_begin,
+			     NULL);
+}
+
 static const struct iomap_ops zonefs_read_iomap_ops = {
-	.iomap_begin	= zonefs_read_iomap_begin,
+	.iomap_next	= zonefs_read_iomap_next,
 };
 
 static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
@@ -106,8 +113,15 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static int zonefs_write_iomap_next(const struct iomap_iter *iter,
+				   struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, zonefs_write_iomap_begin,
+			     NULL);
+}
+
 static const struct iomap_ops zonefs_write_iomap_ops = {
-	.iomap_begin	= zonefs_write_iomap_begin,
+	.iomap_next	= zonefs_write_iomap_next,
 };
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
-- 
2.52.0

