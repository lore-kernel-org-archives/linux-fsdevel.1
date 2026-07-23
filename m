Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450147255D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807346; cv=none; b=ZsGIr0P0YHEYAnmAAhpVsykUZuOyQnJ4iAcgStgiyah2VaMbWhBwi4MycZEMQuquR3zwrZ6SXrfjEyHDQAItsUu+Xop3wARHJ1Xky4sKxuUtFYRRJ5kz0pSASm1FRCdSlI/KC7g4Qg2uH6/D8RdVSyKFuQs+Rmo1cBy19uGt2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807346; c=relaxed/simple;
	bh=rTDsSCOxbYmUkjcuwTKnRndv5Rs4BV8Vd4OBDKh1pVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uGYTILGGLWWn9LhW2i1YJS7W4q0vIaa+Voq7ivsRBy6iHOEOVShyL1ZtBhKVwfFcgrvwwm5QkYVDhX9/xHyS03/CtaA0NX4N9unjBwwH/KWsRmY0omwTcdjTytD/LMFf+ZDe67xv2XHNgbNp0zEE2ybspxgX1Zbut5Nbwcmsk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZRZ5w0W; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZRZ5w0W"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c197eaaab00so97960466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784807330; x=1785412130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nfVwVKXLmD8/vzuRd7sH9V9P1HrMq7AUTPnYha57qbA=;
        b=CZRZ5w0WpVy/8wfkZdeHF79kspD3b4HlkV28HMVMTloR9jJyNi9Www5cPR3XKgGVXs
         yiTEBWdbpPDFRtPar3b+sjAcpQHolPDpB1me1mmzLevqD64OgXRxYEF91c22TPJESmP2
         XNs2Ao7rET977MNOxMR6obaMXlFAS7rtEkrMLIyc7Ws81d7rPsWFTHp7QzysX4p1cpn8
         eP52p1S6KVEHGglxTtpJmVRHN/ZvrOpHD1SLmdj1ZcJWTbwD6txiNZo+FlC2Pz5O/qwP
         coMa3gtakaiTTmwJsIlMsOloOe3bofIpJ843PDFN7epvgnCiXwJ3NIHhbMxkq5MIVoMA
         QuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784807330; x=1785412130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nfVwVKXLmD8/vzuRd7sH9V9P1HrMq7AUTPnYha57qbA=;
        b=RyOmlvnB9N3As+usBF2s8SG4csa7AVghMVeMmN009YdPbzhjQ3GNXhgLp2RWoJTRZk
         4pUhVMjF1StMHBZAHyPbgJpZW5uaXNE5Asge/63dJHpra6TbajnoOEqDPNTV4csxLqDe
         /sRduvnaP6iFlu2QZhzT6mT7ZCCr8+stuyOhMzM8nYeaWkdiXw2GboKPebnoVwRRa87t
         R+Oc1M9mSLQzWagrI/Lw1pg9EWITa40fJI6BrYKtXdEVTc2b6RuM0A+24uGotdCMO9AO
         7bVt2zTsHsC2IcN393uQgFtpU25rxD4LeBpchqJAzYNgRMqfQmnLk3bBmSmZloikK1DW
         0Xlg==
X-Forwarded-Encrypted: i=1; AHgh+RrTfeXuaNFXtoQRSq+O+DxV6fXZc2qxZQeSTNew4oLsr/Cbts2Yiv4+iBGqHPzmTjwPIpJDIgRhHWdPyxoO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0b45VypvV/SZy21ILKUgXNB43XyGOxRJmIzNK1OKBEZh57Y40
	iK/FdN0pvsVJEpKKYwRBkhqZln69NeT/5dpcvt8Cz5jRJCX9vwjl3PgO
X-Gm-Gg: AR+sD10wSgxjU6TUK6xwl8Gb+uxu67UAAsY61SSOtwRf8+jW7hG62SXBwbTX5SdE/as
	GPVmKtbAzw8oVmTZACQ6TGZQPUkxxLATd7lW/y/xxqncB+IWLmt0qIBUCvYWZ9rGYs8pFDzJdmQ
	eUeVGplk8lq69RmJWS5FQm06++Obli39B+d8yYK1j6Wg/pEkexgrNtprZA/Y3pqNohZ89MZKNj3
	cVH9W9cWguuEG5U8FuQrK3Tm3XwlUsRKjiDkpn34LVPG/tH6CDZnsDhm6Mp7b9ht9uFuphQvrrh
	4sgQdekmOn2qjWNPEPRdiqA4jZhfH4FtBKbNjlf2filMH2YMt5r0T/SdwkPiR655kg5FWfiwmUj
	qQfmalNFbi1fK84wNnltztaiGPQc0v7tnCjWDuKg3NA3QSJcDpNeCfFaHhkvE8Q7VILpXbVkTca
	L9JrcT3r2vVGsiiB1oMx/0mNhk2rvxPEQcQn+5kg==
X-Received: by 2002:a17:907:a4d:b0:c16:2dc0:e1ed with SMTP id a640c23a62f3a-c1c5092a1e9mr143998366b.4.1784807329712;
        Thu, 23 Jul 2026 04:48:49 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a798a5sm223093066b.9.2026.07.23.04.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:48:49 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 0/5] Proposal for Cross-fs copy_file_range()
Date: Thu, 23 Jul 2026 13:48:43 +0200
Message-ID: <20260723114848.1212429-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Daan De Meyer requested a way to do copy_file_range() from overlayfs
to/from another fs, where if that fs is the base fs of overlayfs layer
the copy could be an efficient clone.

TBH, he also requested support also for cross-fs clone_file_range(),
but I am not happy about providing that.

copy_file_range() already supports cross-sb efficient copy (e.g. with
NFS/SMB server-side copy).

The current limitation of staying on the same fstype is mainly an
internal technical limitation (choosing the right f_op), which is
something that this RFC is trying to address.

The overlayfs implementation itself is pretty trivial.

Thanks,
Amir.


Amir Goldstein (5):
  fs: clarify cross-sb copy_file_range() code
  fs: add support for copy file range from another fs
  fs: add support for copy file range to another fs
  ovl: add support for copy file range from another fs
  ovl: add support for copy file range to another fs

 fs/overlayfs/file.c      |  35 ++++++++++++
 fs/overlayfs/ovl_entry.h |   7 ++-
 fs/read_write.c          | 119 ++++++++++++++++++++++++++++-----------
 include/linux/fs.h       |   2 +
 4 files changed, 130 insertions(+), 33 deletions(-)

-- 
2.54.0

