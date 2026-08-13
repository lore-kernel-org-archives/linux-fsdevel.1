Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B442C4ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613790; cv=none; b=pFW/bghiPRwWi8T7pyDMSg4A/5QkisAKlmg6GEIb9T6+ZvvfKBvYHgpcHU8AKhLNJxDzT6g+tdKAZqUWT07a0BOWwevxZexpBCjMySDSlnLDkrx2atqdWUbV2PFCaI1zoHvHf2eBPfqwrsr3wxtAXvj7VyZD9kctVBe6/w+xDwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613790; c=relaxed/simple;
	bh=YZkfDDQ7GSzvo9WaYxhwLi7D152wP2Vsm4HaJoy5DWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCw1sDMcwfVx72Yql8sNXJpNjVoZTpKBtMhJ0TIioHuv61VMwIIBd4KP6myMVyPG/84V0g3QfySopEWABoZRm1f4nZKpdIkUsarqBtUWFe/oqtPr8qOpmLmb9lwvTXUOFnkuJ5wt7pxEvQWiey2mmfXXRJ0FUJSQFOSaOfxhAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhVtQ9Lj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhVtQ9Lj"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1956077a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613781; x=1787218581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FtJwtn3hLgnODQpBTJQ+GbiEFxaIYYGH/EfeHB2QvWk=;
        b=RhVtQ9LjFikYn+QOS+92UIVcK7sB/clf0KSdHGRKmeMDuHYUaw8T3SAyXWyDpF6Qhu
         Y1ppKwO8XMFbzVKzJYo+0iS2NMMmODrtCmJqhAN5wsnOiykv5yoO3liI9VOkj9PCs5Rh
         fdZy/eQafCv15Ovt66u6Yra5zL+vwztHP52ZOLp+mFkyXSyARwvzp5mwjJEjAK7GPdfi
         jjSAGXn892/6wKpzDSTa3DqIpArKFXccV2U+vX1xPKrnBKDj2ju9qGRnzYp6Aj2DQ35F
         +4OnntQOoqoo/qFIeKgQKkYcqONpBl8hhCFyHS97CL4T7bXFBrrCzK73/TcG5aQrgnMb
         T/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613781; x=1787218581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FtJwtn3hLgnODQpBTJQ+GbiEFxaIYYGH/EfeHB2QvWk=;
        b=nE/GODoFkPZ0NsjPcWQmCKzEPnptJEffufJeQg3ET4r3eKM0I9xQ7CHlcXB3/Nm2xw
         ohlpAT1aliXPrhS0akQUwwrhODu7HhiC3276/FZbagWhXPZubcO0glZ2Hlw3kNky3z7I
         XW1i0fD9bXX8vAFzSPRd9MTUg0IBUWw1L3kaOdC3QW3rLHi2eYRkKx7bilaAe93/3ROf
         NSpq9KrtKANRlTSI2EuiUcxulVsyHmyLf5ybRdQKAO2ZBN9Bu+Z6h/k2A0y+OwAnpAYA
         O0B2TqB5/diSKnToBfPM9JltBVrm1daP2DNSfC2ckv1SrYmY29hVJ5ZMZuNAwJ9z9tOK
         Z6CA==
X-Forwarded-Encrypted: i=1; AHgh+RqBPU0WR0yAvORBjOczAMTe5fKtD85aBldmgBGdGC7Bvx42A5XJtygvn7SxNsTvpkKOgkdQwpDuKy+T3BUb@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMRg1QjFWuO1VrkNECcdz1J5lTgzaZG6wtkn3aP5yhKlJ8GdD
	0huPEv657UoifHuajA+tem4jV6Gz4xJT0ph+4W2J1/spdcdyx2/GlUlu
X-Gm-Gg: AR+sD12MKWljqH2bupvKQ9oilf2fllnCWNuSUANDPHYQD5GIHELFzlnVftc+gH1WvjM
	3spP7c6Ccu4dTm6htEBrOXeAyn4NWWsp8g3nMvO9DtoFkHEkx9Aw4XqIDTtnS3XMtOBj74rlAhD
	s23GQr+nKlwjiAUppuCwrzyMSv0epAgRJfYxuzoO6rxeHU3sRl1VTLSRLoDTf+Q/mKCHRq0W5co
	0Undyd5MkTJssHZsPOhBW/PgW6xkmSIKibKnaPKpVrtxVRQY4M42Gb3jInR9b4JiD+TZAt8zcSL
	wrc6m9LRGjeUaP/Z5rmt+5jbIMjCdF2LHeTW9TDGS9lHNZFcWHpYNwlhegynSboP9uplfj9mGmd
	C3+Pxt5GBYQeluo2T2mDt5cd9ZzNGEV/SvsjuHD00kfkuf3i7881PoNgralqjG7LQjmITHPLQdZ
	KgVEpSSBNxzXC+N1UvoOGsyXtWYQ/bMBh3ruV5piCKecG4RB4s925z5gNAif6oYex7c3n9jHW5z
	JzuX66rs907KyvO7tNOecchp+bph1/xQK/90jjpMYfVz5L8y+xNQRSrupjvf/REdm4UkrJR0rz1
	ag==
X-Received: by 2002:a17:90b:268c:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-3931e27b831mr5511629a91.19.1786613781048;
        Thu, 13 Aug 2026 02:36:21 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebf7321adsm6755991eec.16.2026.08.13.02.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 02:36:20 -0700 (PDT)
From: Manush Prajwal <manushprajwal555@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] fs: fix comment typo in inode.c
Date: Thu, 13 Aug 2026 15:06:03 +0530
Message-ID: <20260813093603.1971-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix "funtion" -> "function" in find_inode_nowait()'s comment. No
functional change.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 31c5b9ee3a..059094e40a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1775,7 +1775,7 @@ EXPORT_SYMBOL(ilookup);
  * function must never block --- find_inode() can block in
  * __wait_on_freeing_inode() --- or when the caller can not increment
  * the reference count because the resulting iput() might cause an
- * inode eviction.  The tradeoff is that the @match funtion must be
+ * inode eviction.  The tradeoff is that the @match function must be
  * very carefully implemented.
  */
 struct inode *find_inode_nowait(struct super_block *sb,
-- 
2.46.2.windows.1

