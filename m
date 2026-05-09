Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432F37B019
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307169; cv=none; b=BdFRZlvC+Sqp8n9MfhVuJ78kf0MLEemd0FJZzs+2qimVoU8IXQ2lCWU6ZM6zKYzp/jZRUCyIvL4bJ/jFlPS8cFdOUE51vkhmJoTjw+u2BnyQLkFcQjc7/mT4qG7TsHc35F+SLyvm+7+ijYSf6zKuPZgJKZeAd3SrrjieCd8gsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307169; c=relaxed/simple;
	bh=98bDbi8gLMuxwUsdSJ2c+yqEeFsDuc/6KFYVWS/lLS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Za9FAomAsQ1FKwMYyORjrrxTtO0QnoT5wKkNJqgqwf5I3iSF/G4yq8ssgKer1QVb1HEurZySwqm9PQ8TKHNSREOj2iAhlSD1wu/Kn/jHKzehuxn5Wew+1ObUW5y0mslNbUtBlM7okPPEmZavLkIsKV6AsBBTGj1wHdqgxBv0yAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D28R83+3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D28R83+3"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-835378dc7cdso296602b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778307167; x=1778911967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VwLei+49vjcaDmCdz/Gvz5zUPPQyRMdRX6okGXpvhQ=;
        b=D28R83+3NrvLJD27wNIiGq0LxzV0BH25nvHNcbyq5FILb78u1T3xVjQc8J6SBHstkd
         uiM/KUDAAaI1ziCWL8NfonIsud+ynMq3vUp5sbsmjdkDZ6u9cs9GPBcZPr3yCxmf/nAh
         5ItCJAiIg/PpLRFN6DpUky/rG0qzSASZPaURNasQS/laTpCQ5hl2yt1Vz+Qf4vyGT4Xq
         EY/K8XFf2DGnkmHyp5MJQYviN5M0N9CCuI90qxfk9beSQ+td/OYMzuFqQg6iMCBkkvtN
         amOQMsHlNE8E6RD8Ixxyx+irSqQBtVf53BFlym+wAkHDDO8bQ2KfO04Kn0CU0wSIna2M
         tirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778307167; x=1778911967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3VwLei+49vjcaDmCdz/Gvz5zUPPQyRMdRX6okGXpvhQ=;
        b=i4Yv4aPQIO75Us6zl5sl4BHCuAxHbkSYCYu+ceMxyQsW0qPhWZJGhR8J00tHwEtlm1
         QQMVfZxv+5BOyfuVeYNKfD40Cn3MHxSdiuFzsQmkvEpgpSoHPe7WyewUknU8GvDnufsg
         eiYvKM+pfVF6kJUeszBFb54veILG6toifU3Sx1IqJSrePKssQhdDaZnQMted3drXsU+r
         H3pTZW26bHEBMqXJq+vGp0pS3lSa9nsh5hWJAVQ24YhnsgabAaSZno+tstXTuGfVfuCr
         fcDQxOHnE/G/GYTYalY82Fqb3qoPfgQgbsaCFd2ALA/oSP6bXgRC95mC2Cx8UiErCaqQ
         k/oA==
X-Gm-Message-State: AOJu0YxUcfmN8jNKgfDf0yGVPZ8EHnaEAqChugzAeSXm08RjiN+nCTvU
	LuYFw8xPxEASx2/gYYcRGpcrwOyGU5EabriI41eSgOBva94rKxFuyRVn
X-Gm-Gg: Acq92OEEuf6XG8KOYtGhWbXNjfnIlOd+/aBijfPrMM/PcHSDgSLbR54NOwpMlgOp8F1
	bsHou90KP2QBtOZlVdXb8WoL+IPXTAmzocgYTP5bu2Eq+o+qaDzElNJO0YhMEnfSPJuC2KYVR4d
	UavsoyMcvcEDt3iyaxrlqPb+9wBnS49/Ca3RNdDuikBmaJhGyoWgl5+UxP06Vwtqhm0fwLuS6Xz
	jA6zvPlKEV7OAuo9ZLwt66Oce8kIKmp9sAhWR1ncRUEiwDOTM7fxGdrFwXVtl2WfsBwyDRJAQXY
	Yn9Ht7nAeI9zJy/zwxd68KBjoHgFIaOx9ji7M9qvAUU+UcJSJXmzRI8Jva3nvPIrzNvXvXIByHg
	TzJIMi60tH7RP2cHdAprd2a/pPpZXSi1XV5cbARZqzZ/Wf5wRrmZBwrZsLprR3DoZJ9lVc6IcTm
	RuSFcXkSMgq322NhVN
X-Received: by 2002:a05:6a00:a804:b0:82f:21ee:270d with SMTP id d2e1a72fcca58-83a5aaf7794mr7698597b3a.1.1778307167179;
        Fri, 08 May 2026 23:12:47 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659487afsm13380429b3a.18.2026.05.08.23.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 23:12:46 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 0/3] ntfs: harden MFT record and attribute parsing
Date: Sat,  9 May 2026 15:12:34 +0900
Message-ID: <20260509061237.3233714-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508153410.2624801-1-charsyam@gmail.com>
References: <20260508153410.2624801-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series tightens fs/ntfs against malformed on-disk metadata and
fixes one off-by-one in the MFT bitmap scan.

Patches 1/3 and 3/3 are complementary: 1/3 rejects MFT records whose
attrs_offset points past bytes_in_use at record entry, and 3/3 moves
the per-attribute name bounds check earlier so it covers the AT_UNUSED
enumeration path that hands the name pointer back to callers.  Without
3/3, two enumeration paths can read past an attribute record: one in
fs/ntfs/attrib.c passes the returned name pointer to ntfs_attr_iget(),
and another in fs/ntfs/inode.c copies the name while building an
attribute list.

Patch 2/3 is independent: ntfs_mft_record_layout() rejects
mft_no >= 2^32, but the bitmap scan in
ntfs_mft_bitmap_find_and_alloc_free_rec_nolock() used '>'.  Bring it in
line with the other 2^32 boundary checks in fs/ntfs/mft.c.

All three carry the same upstream Fixes tag (1da177e4c3f4) since the
issues date from the initial upstream import of fs/ntfs.

Changes since v1:
  - All patches: replaced the OOT Fixes tag d3ad708fecaa ("ntfs:
    Initial commit") with the upstream commit 1da177e4c3f4
    ("Linux-2.6.12-rc2"), since checkpatch flagged the v1 commit id
    as unknown to mainline and all three issues date from the initial
    fs/ntfs import.
  - 2/3: removed the OOT-only "#if LINUX_VERSION_CODE >= KERNEL_VERSION(
    6, 6, 0)" guard that surrounded the folio_unlock()/kunmap_local()/
    folio_put() block; mainline does not need it and it prevented the
    patch from applying.
  - 1/3, 3/3: no functional change.

v1: https://lore.kernel.org/linux-ntfs/20260508153410.2624801-1-charsyam@gmail.com/

DaeMyung Kang (3):
  ntfs: validate MFT attrs_offset against bytes_in_use
  ntfs: fix MFT bitmap scan 2^32 boundary check
  ntfs: validate attribute name bounds before returning it

 fs/ntfs/attrib.c | 25 +++++++++++++++++--------
 fs/ntfs/mft.c    | 15 +++++++++++++--
 2 files changed, 30 insertions(+), 10 deletions(-)


base-commit: 70390501d1944d4e5b8f7352be180fceb3a44132
-- 
2.43.0

