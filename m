Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBEC360EF7
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783725577; cv=none; b=eFhDkoRqcUxCRcGGdHWvMpMx65GrbhqIY9EPsFq9ISqMhGnMMfWRwmQuM0w2Y3LdTUejVU8zeijtnaio7cIFnbD4DQBjIo4QscFvHfqEw5EqZ2tVcqGhV08VBFHJLxXuP5fRdzBomKv1yJVB2sD6wPoLF2RtHJq22ZcspY9f5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783725577; c=relaxed/simple;
	bh=K5NbgsnLq6kpVpRFrenkr3fQeQwDDFiPJF3r5GfgbmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JaoONmMM2G5bXvLieewItpZ2MY8OnIKA8Qv5gosiK+DB/bNcG8f4CN8W/pSbH0UhWaC40iIuPatSXoxvF+bsfkQuzI+e6OFXb7sEJDaoss6bou7lipU1bIFOuLgcz+34uYYGOgwNtwd+w3pAxFkgXGUx37PEDrvR0CcgQwqf7i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHIE4Hnl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHIE4Hnl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso12256555e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783725575; x=1784330375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mu6H5cxyF3N3ShBbole+6JVO+Fftq+/N3BhrSBcvHHk=;
        b=VHIE4HnlXecxydwyoxypRYkyPhHTGkgprzlgFd+d71SmYpEjsnlE5FDOei0VjYPH1E
         Df9tm086H6ZsQUy0+vfAJKVc1CuhF7qc9sxadUpAbjNMyBb8Ro+AjdYdz/+h6T4RZtAG
         ExO2bc3i2bE6kfLzFBOzCR/N7mno12zQCG8ig6aRyhTLDwPKjawqfEILAXN+B5ggJ60M
         ccibwKYGDwvR6ttLftzsUugn1lSFZqoeB2d95x+/hjsCeXGgZCPaPNo0Ud8tzJWRsmPM
         81MeCtTJp4j61xITaxQA77eZuGyNmwxhzWm3VMXy0iKUd9ltYecbdk4nKV+af3ANcheJ
         PQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783725575; x=1784330375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mu6H5cxyF3N3ShBbole+6JVO+Fftq+/N3BhrSBcvHHk=;
        b=VRUi+BimWQo5UdfbSC4Sl+S4y47HIYpUINW2oOD7sGeumr8blsdsX6B4FJi2TjNz40
         Vaid5/uJ4JWVM4+X6mmjdfyk7sYiiHfGjq/sQX8pY2/j0/JFc0G/hu745QSpb+3PC4MV
         60rxSgKjQSCbme7TLO3LpejeGsbF2Hnry4CSTaKktX30lCEaL1Q976XCaAAVoRzLx6ZL
         XVhSxYtcGLu17vUX7WsBdXhpgmEGoANHbvnqJJTLWN32hAdB5fILBsnsTiLrhduZ8qza
         Msz903t4YznhpC/3K4cOcqQ2yE5nADA+yTxCijG7lu+5Jz3nx0PrYOFOqgLFUw4rG4OV
         izHA==
X-Gm-Message-State: AOJu0Yz8DpztxF3ylif3CQr8y/4Vj8A3Z7UgDTygv0lE3CZZnhaiuCwA
	Ao+C7HbAlK6mEHXYN/aNmpnbUfqj3sHWUrOkPpHFSFQfPPQV3PgZYvDy
X-Gm-Gg: AfdE7cnwhzKaT/SoQG+QTL1xKxPQq9kE8ShWbUe3xiiiAlWCCVWiB8jBtuNS1lEmrPU
	O3ZPVWPeFt42sqVV2ANUKApXVBZj5pbIIz1KRtA7w0hJcvlOTL0za9fInnIYxcAGNFSOvgin9dv
	UmjEPAMOOnpuJ0/16pt2DKwqabSgalqbzvr0gv+vakzsLJ5A3maOgc79HoLyKd3jjXylcY5WY7X
	BBiYP7uOe5tkVvCTqOO3pDThd8SBuQjcuJVCAO3c+SH1Wx1t5O2dOPS00aMCqGgkik+FrxSNPAg
	FLHzz2s8x9MVKKArMcKpLPo/98DFmk4aPsKZDisqeY71Qv8q7R1q6BNYGmO+yJl3IIX47+ZcZ3j
	co1S/PUJ2Qz5iADtrm0yT5G/xYj1N20XJEHP9gjdpAB9MutIXJZba6UlvnPd/JMMMwWAXpMZCFY
	BHWycw0bU0PzI=
X-Received: by 2002:a05:600c:3b07:b0:493:f807:1a79 with SMTP id 5b1f17b1804b1-493f882b042mr6140015e9.27.1783725574653;
        Fri, 10 Jul 2026 16:19:34 -0700 (PDT)
Received: from user ([197.46.176.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm171727565e9.1.2026.07.10.16.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 16:19:34 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yahia ahmed <yahia.a.abdrabou@gmail.com>
Subject: [PATCH] mm: truncate: exit on empty batches in truncate_folio_batch_exceptionals()
Date: Sat, 11 Jul 2026 02:19:30 +0300
Message-ID: <20260710231930.93427-1-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yahia ahmed <yahia.a.abdrabou@gmail.com>

In truncate_folio_batch_exceptionals(), a loop scans for a shadow
entry via xa_is_value(), However, most batches sent contain valid
pages that don't require exceptional truncation.

When a batch is empty (nr <= 0), the loop and the following check
are redundant, adding an early check like if (nr <= 0) allows exiting
the function before executing any loop or redundant if.

In benchmarking, truncating 1000 files went from an initial 0.77
seconds to 0.76 seconds.

Signed-off-by: yahia ahmed <yahia.a.abdrabou@gmail.com>
---
 mm/truncate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/truncate.c b/mm/truncate.c
index b58ba940be47..c22803d59bf0 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -69,6 +69,9 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 	if (shmem_mapping(mapping))
 		return;
 
+	if (likely(nr <= 0))
+		return;
+
 	for (j = 0; j < nr; j++)
 		if (xa_is_value(fbatch->folios[j]))
 			break;
-- 
2.55.0

