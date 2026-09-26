Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956838657D
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790397523; cv=none; b=rkBrtB1mQ8vmi1nrG6nDZQNVquR8C87gdTgBYTnMBXkbaC3iM+S7Hore8havQXXt/GhPO3e2Tt5k2iyo7SuVcTvg6rYAridvcwcV3g4Vvp5ubLFAr6a3SwAbDRHg5cFTXypLOx7KMULrZlrTF4CgY9nJXjq0UxtQ/AtSnuLypwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790397523; c=relaxed/simple;
	bh=o96/nTPgLaU3nU2R7/joPhaB9h1p4PmJ1veyXH4bPkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYT84IATCWnrQlsQ0x78YJAc4iEgVya1BfFBOAHR57rmdbtmnZTe1JZo6V2ztUm4jHP3w3NoedPwTc9U1uFX90S70PWodrkT2cvENY+qWgnCwS8BtasygmKddJs5GO1lCk0ew9L5ENc4fcbhtFeXc2yrhyBUciYSYVaXFvA4Xd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX2fISSk; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX2fISSk"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so2026633eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 21:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790397521; x=1791002321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iH2mnKMaWDn5GtGVfUjR2kRVjPqFYOwfwYCMea7YYrs=;
        b=SX2fISSkl6VGjbp7UmGhjvtkz2LO244XoAlujkyc1So9hHXdnoA8X38tYAjUwPvvRV
         rCko4nWQJEVwprKmR5o3iN6vJuaWKI6S2SVfsFuEJFKR+ru1T0PJvciI/p+4nl1pxWl6
         F0nFKaEZaTOozI6c8TZru75Z3ZPms352LHK3/paTg+sehUlAQ5nCmUPZ3R3hcjHdZDCh
         EKlBGcjDDP2tgJE2xBQHA9NrBQi193eZ81xX9G1TeIzXS9F7aDuv9mRwLQrKLaWW9Jna
         H+g1uv63zxslkrL9rmYjlkcKZGecR+7HUBW+PE9tVItvaxjdDYE5/FekcQMJxXm+jNE4
         HhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790397521; x=1791002321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iH2mnKMaWDn5GtGVfUjR2kRVjPqFYOwfwYCMea7YYrs=;
        b=uxm2Fm3VVW6e4VIA7UBiLPUhTml6FEK+mn5rTKW+Ng0L1gz8wXxjhm+uBEIPXPkHzi
         C3ekYDCfwA5TegoydoX4ElhamGAW+3z0Hv/cWsTKhOh2gR3lSKlTgcE0Vy3ToD7K4wEU
         F7h+hVLa+lawDR5kBDcYNgTmvIMo2F68h93synmLzGzx8jiR96nRJl1twjLvfPXUZ4m2
         MTandPEJmrxWu/lccuKY7kWmvI70QeapwbbI+g8gZ2hYCqh/m9pvhde1buVxPp5z53w7
         bxC3yQkcmowkanSXtZOQV9YZ+IZEkG/KIEg5yx3C49zO0pGPDBt1U6MO1huK/CKTs0hJ
         jppw==
X-Gm-Message-State: AFuF++net9MyICZ+0aadEC1xVM5Sa1bEjCuBTvPysXXm8K56IrlT7KBL
	6qR7cZwNX0NAzp1xsikc6FuyKulT0olSNr4ldANNv80t3jZhUW30oEmUQ+psQfmNqt0BVpEH
X-Gm-Gg: AYBFou3G8CuBw5SR9YIeMgJXehDsMxfjFkVt2vhQUUX/tAGpMYoAKpYLMO/FVYgHQQr
	wDH8MnSy0yUB/F1CkIYwenKjVSMSLQK15TCt2JhlPZvNqq49iOcbpv7FqUgZy+oyvGWHAuKIxMq
	ftkB947MsOCXKXQNNbkm1aKLapxWNKh0j3S/JrDqK3i3xc1CNzF2+GE4J2i+X4abt7GJOxSoV/2
	CeHVDCelgIxV6lMjkrMYZaMYE+DXM+0bCYRFFUA09L+EQtnsWH9q+YF7lE7fqe4iSj3zZHHTLum
	IRp6WPoulhrtRu/BoJcFpqaTPFXb6Ss5ybfecxws14kfulhozVzeDPSPNqLdkDyGH1TY8+WtWkg
	38wKfMKbL0cxKLUrPA1BgdVNx/tZYJa+P3WXxgHpnMRrxNfcctVVXojfMDoBiePGpArSht0qdY1
	y7ZIhtx2mfalcRKRmfqnJnxScGSbKzr5AT62298u31xy/LBVojWJFtVed62p0BabZjmPjy4cFbB
	Q6lmcJ/CSQ2jtbWmd5M6SuooTMsJwYTsBFkbB5imodiI+8k+TORwZKi9m6msHBpDIwTZlWQ6gRN
	Bi/f6kDw+HUSK0TcMLlXGQkxE6WtV8wO5gYx5K1bgwdrR2o2LZEfejPY5Vc=
X-Received: by 2002:a05:7300:ff42:b0:33e:bbcc:eb99 with SMTP id 5a478bee46e88-34270ab2d32mr2087923eec.18.1790397520853;
        Fri, 25 Sep 2026 21:38:40 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343025a591csm2171406eec.12.2026.09.25.21.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:38:40 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	ansgar.loesser@kom.tu-darmstadt.de,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH v5 0/2] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to FIDEDUPERANGE
Date: Sat, 26 Sep 2026 12:38:34 +0800
Message-ID: <20260926043836.3301898-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dedupe tools advance their file offsets by bytes_deduped, but when the
kernel shortens a request to a block boundary it still reports the
requested length. Patch 2 adds a flag under which bytes_deduped is what
the filesystem actually deduplicated. Patch 1 fixes the DAX comparator,
whose return value would otherwise surface through the flag.

Amir, thanks for the review; both points are taken in v5.

Changes since v4
(https://lore.kernel.org/linux-fsdevel/cover.1789653814.git.matthias.goergens@gmail.com/):
- flags is a plain rename of reserved2, without the union (Amir).
- Dropped the paragraph about old callers and old kernels (Amir).
- Documented the flag's effect on bytes_deduped in the UAPI header.
- Patch 1 unchanged.

The fstests test follows as generic/806 v3 in reply to its v2 on the
fstests list.

Matthias Goergens (2):
  dax: return the comparison error from dax_dedupe_file_range_compare()
  vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to FIDEDUPERANGE

 fs/dax.c                |  2 +-
 fs/remap_range.c        |  4 +++-
 include/uapi/linux/fs.h | 11 ++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.55.0

