Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6B3FBED4
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254456; cv=none; b=bvnvBmrkqFL85kdpaKDkncrqpPJGsBvogMPdtKZMHafXKXf4qx/HrQHwwMPQxU8ARMTnDWL0pCfAvAeNNXAFckgpjnhnjPzWI/3q/0HhPLpNrkGpSJteL49Spi3ydFTFz7oDWEy2LR3Njl2SqvidEYlSo9gqJJd1LYJB22wFYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254456; c=relaxed/simple;
	bh=t8K7gf/SdY5lgBMtXy+Dl3HCLE0UZE9Ckhq0AbxW6kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Duc4mrztq8EqBJ6PEXfaJYFGMTC96tALdRwIzZPgEqrD8iTYeSsGFJV3v1lcW5UowO0tOiOj5E0K5Sn0zc2rC35SmGcLpKKcaAXfdr5rgix5w6tRgpvcrXnkPa2gviDlzg5y3ROa9sa/aesSjPVPIZlkdXr5Ju6hx/YQjT3HKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms7IJ8oq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms7IJ8oq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba7b208cd6so1450715ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778254455; x=1778859255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GEQuZu7m1VArIBC069EyXmSXyraygDC7mNMuy9iuhwE=;
        b=ms7IJ8oq2pB76UbfITh6tigcBMARY9ChyiLrh17l8hRbN3tnOM5i+nNt3ndZ6nU/jM
         u3oheNGmlV2H5sP7k54lTdWyBySdo1d5MKRy3GCfYO9einJR1Mne34w7XjBaXm8ayF4T
         lz5gBTS8iVKdZ/VJJy3bse7Ng74cZDL5lx6+QFOvJRYFbRyYLXMXYRAFrjKEfxKSWPoW
         Ru9SmdvF1D3J0poxvU5+TPH8nc5Prys50XN4JkQIi+s4dWhhnKptXmZzKk3AMjP1DFmZ
         wJY//o/H8nfcY6uqFN0MLAWvEuBj356NYB4cWhR/tHoUQ/XR9/LpbGMdYuY1+fFZ2uFa
         gaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778254455; x=1778859255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEQuZu7m1VArIBC069EyXmSXyraygDC7mNMuy9iuhwE=;
        b=WdzIi5Tnfuvi2JEJl/rkIsmwW5tieu08PkAvVyLcrnP6RR8qfGQYGEkPNHHfoyMbUc
         pfojCdcvlgUSvoPTjdI3rWQtxYevdYe5I4thCo+M4GgE/GrMIyXafh7sWHnji5/+1hY+
         E1f29yBQPFTRcrrnSTSjJRKiWPyU5SFYFYgzZvxJX44vyLiUuoCWM3sx2knatCKh5iWS
         +S5OPTp5ePLwxwRSQn4qR2hQcTjg7sO+lE5nMYJNv7abqnqc5ipsemFCCi8ZVsI0gLJw
         HanNerqhwmF+zeKKrEdU1HTaSOA/XEnbmAMHq+INNsM66rtsgybAf88jZM/4LCu5uDiy
         I8Bg==
X-Forwarded-Encrypted: i=1; AFNElJ8eVlHno+qoxZ6f2funQrfslCJEUyh8XpwI/M6hK+CjLPK/+HPKbI+LHSaKsp5jLBFsdExd+DGof9M23v7u@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5f2pAInqGg0QTqGq8zClXtGdDTOSp+q+r2XF4WgWlwLAqoM6H
	O4WLoloR/Pu7YKuhYdyS8XSFM925UyXRlMkOa5UqSm7xYNfWqu91U1o/
X-Gm-Gg: Acq92OG6aE8u9QpnKo/t3oja9pSDExXP6egju5BNC/dqruzVoiXEjK2ziP29VkPDu29
	a3VMBMZ0X2caxuLBaE0rEmP2g2RcMmSI79YE2s6ZfGFB1g6bPnlegd4n3Np6oYQEp/WV1V/pI2D
	MHzgaY71QEr9Tj6WPPGvl943LthPiCSl/30Nx85q8voIOl6lKDlwy+FLXKlrmzvkpe56Oinsnho
	9G2vGOLZOb2uEQfylDDvekhIuEKRTxUhXUf5LMn68l49dJdUOG04/FNMK7wyhibElmKsEhjy74G
	fYZR04cuHMIfcinQ+BSspOMMoTiFpAMl4gcMye8A6BypTosvFpW6v8aJbHFmXaaL8K5LWengC4S
	K/iYXdeQKPrgaupbNq6e4/5F5nKD3Yo/YT5ORNuiCnRCnVgHPmuhb1HV5rE4bv/KYIne32LIhMA
	1SgPvOhErevhw3OXIz
X-Received: by 2002:a17:903:32d0:b0:2b4:5a2e:98d6 with SMTP id d9443c01a7336-2ba7b344651mr65610595ad.5.1778254454668;
        Fri, 08 May 2026 08:34:14 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4094fsm26666365ad.19.2026.05.08.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:34:14 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ntfs: harden MFT record and attribute parsing
Date: Sat,  9 May 2026 00:34:07 +0900
Message-ID: <20260508153410.2624801-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

All three carry the same Fixes tag (d3ad708fecaa) since the issues
date from the initial fs/ntfs commit in this tree.

DaeMyung Kang (3):
  ntfs: validate MFT attrs_offset against bytes_in_use
  ntfs: fix MFT bitmap scan 2^32 boundary check
  ntfs: validate attribute name bounds before returning it

 fs/ntfs/attrib.c | 25 +++++++++++++++++--------
 fs/ntfs/mft.c    | 16 ++++++++++++++--
 2 files changed, 31 insertions(+), 10 deletions(-)

--
2.34.1
