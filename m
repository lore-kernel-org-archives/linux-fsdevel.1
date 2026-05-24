Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407E38C43A
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2026 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779601364; cv=none; b=eXf+dATpGYuES5bR6NskiVgGms62e/YWecucdw2j4XKz7mR2HDa9Mhrptkpr1uCBAx8+xMgWbKDLg+Vch7gWeKAKiRsXvpe7u8N/36GO32EdEKLeRyWDOG4r+75Oiw2JuNSutbzag3hMy03nDGlQHDLze99wCG+ANoZaQIcaDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779601364; c=relaxed/simple;
	bh=Ti5GvbkYwaAffhoeYiZD73NE7JcXjbytKkqymnbnNQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ommmiYH4jhPjcImytuF0f+B+iIViyWV5FETxLAUoBJ/rclkeyZg36Sz9Qibmo4jgGYIa96EQz/zoYGvFq1C4flC9ey01S96FZhK1plVyxX22UVIcXLKcAilG9NsMPmu1ol0FXXZuuxoka6fG4sYl0+j/wlVhMyvn/iAvVBE3qOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqh/Fwtd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqh/Fwtd"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83d53f307fdso275998b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 22:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779601363; x=1780206163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKOJKUVJqikD8CWHHN1/XXpyj4T5Xht33Le352Q8zWg=;
        b=gqh/FwtdZU/s05fMmIIjYYkWK6m+Cm1uiYsdrhWs8axqb4/nvsG6zZI4Qg0VRmKpmB
         49O7aZdHVA+B/qjTCTuqc6RT+s18GjaMnkReORInUCA+Mjg9Jy+k5CGSdaBz+l7jAZ4q
         qQrKuU0Xi606Xg5qxot9lBTrIKgzbbJ73c8ERYozLI8S0qEBkbMNr3A34umtkLSNyiH4
         2ArHvSOmIgYGTaFGFgtx/Nz8cncyqGqQSZ2Ngs9MdfPEoUs0yqYxWIFXq5h7ffOlDkbR
         hLHMWDw7WL9MMfeC2CYjmIEExrxf3VmkNxY5dOxa/J9WqABJo85fisSvXTKBxtg/PHfc
         hR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779601363; x=1780206163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKOJKUVJqikD8CWHHN1/XXpyj4T5Xht33Le352Q8zWg=;
        b=Nf1LA/iYcs1DxyAdlApoJmd4wxWvwOnd/hgEaccve5ORvRG1mTBgnsJMXEz+uTVI/e
         o7R16eVJBTV/AVVzect6FwwYI1uiv/I5porO+24rtBA/E9Eyxe2aWRfqwli9CDJOkyEu
         K56vzmy+n7Mis7PvgKAUxtg0jKre0NRbsa8G2jLW+mXgO83aF8b/6Fmw9wohU7/R3Wed
         QyK9AA1QnVGnXSzyGNTcta+bknEzJWbMv+Ff2Yg6Nz76PfCPy27dE8gdKtOB98XUaUNN
         ANRaAdzftMfd1bexTIQk9xMNLDpOj62WZII1QlXYpOvbPhxiCwz5RktADRGexoum3FDF
         1ukg==
X-Gm-Message-State: AOJu0YzaFGa8eHoJQVFvI0DuX02IY5zC8/BUkjj8RYCTPee2d2LNvFth
	X/qNFiOb8ceZWJuG7I6d0G5LUlRekUEGcApIFrWsSibKb+I4R7BYjyQK
X-Gm-Gg: Acq92OGgS00HHVvXHgy3VfxMwJuxtt2YJdrdehosSfXcNUu89kB67V2DSiC+IFIu5VP
	aBuOzlrcvo0jUEvVfjNbormy/I+vAAzpNIKycozYvyQOSHnVBISFst324CXfRssDBklczR0/ghV
	+Iqjf5bqaf6pai3WPN7mDX8pLJxMBab98DMyHOhh0n3sr8e8W7Y9mHWATaJ1D9e4BoQpxbSI9qL
	IsdczU3fYBmqKQOwM1InrX2lPT094fVHAo2kshyFuWww5lhpSgpSapUlSWViWgiir//Skrj3tIV
	dU6K9LhaXzTmRRrSfcLStwTGeh9NCxIgFavszQZI17mr8DYaWqWai8uSHnmdDo7KD7h+BDRFX9j
	mjKGE7/bfK/sqNNG6eDYzYnA+47HitpaY1/F596uvOb/cS8+0bL9Z8n1m/vIQVs1i6xvn9BcFPw
	WrzacPvWTbWPuskLNm
X-Received: by 2002:a05:6a00:2d07:b0:835:443e:4be5 with SMTP id d2e1a72fcca58-8415f40ccf0mr5094708b3a.1.1779601362790;
        Sat, 23 May 2026 22:42:42 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff7d80sm6726848b3a.56.2026.05.23.22.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 22:42:42 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 0/2] ntfs: fix link name free and $FILE_NAME validation
Date: Sun, 24 May 2026 14:42:36 +0900
Message-ID: <20260524054238.3129288-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two independent fixes for fs/ntfs.

Patch 1 corrects ntfs_link()'s release of the new link name.
ntfs_nlstoucs() returns a buffer allocated from ntfs_name_cache, and
every other namei.c caller releases it with kmem_cache_free(); only
ntfs_link() used kfree(). The conversion failure path is also adjusted
so the common out label is not reached with a NULL pointer that would
hit kmem_cache_free().

Patch 2 validates that a resident $FILE_NAME attribute can actually
hold the variable-length UTF-16 name implied by file_name_length.
A crafted image was reproduced under KASAN as a slab-out-of-bounds
read from a kmalloc-1k MFT record copy through ntfs_attr_name_get().
The validation is added before ntfs_attr_find() and
ntfs_external_attr_find() return the attribute, covering both the
AT_FILE_NAME and AT_UNUSED enumeration lookup paths.

The two patches are independent and can be applied in either order.

DaeMyung Kang (2):
  ntfs: free link name from ntfs_name_cache
  ntfs: validate resident file name attribute length

 fs/ntfs/attrib.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/namei.c  |  5 ++---
 2 files changed, 48 insertions(+), 3 deletions(-)

-- 
2.43.0

