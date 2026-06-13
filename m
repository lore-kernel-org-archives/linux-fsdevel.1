Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29482DA76A
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781357958; cv=none; b=NTRjiLLaxeqKRwsKn7/1bQFCiBM3ed5vR6V4sPWOQ37JC7mnwYodDUzUMU5ghkyNKUJtS9T8/ThFXsJsKzdaiB5dZaRRNPDGobjNwbU7za+LqxJg1fU19HXgtfjqSLqpv/8tJA52OIA32g58nRaZmgMdpIcPyWKLhTwbY2V6/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781357958; c=relaxed/simple;
	bh=45f2aYykaZtRFf3Yi6Mzl9GWxjlfftlOZmdcBhmlkmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFDxmnG8zskbw4Y3CBmc8B0cEHDJBAvClKc50oWRWf/B54aFt5lt+is8Z15tt6k3G1XhIb55Pg0JoZGdnEPR5vCY/wk3DsXTufnL6/6dqA8k9wLRKZn65GxRdNOI5HTyrKNMlbNV4yDoztPdmGTFvpSMJ/N10h/nXj/B2rGMcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0FJV1P0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0FJV1P0"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso1303049a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781357955; x=1781962755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z2iww8sRzZ9iwSa8F1tzoGIT1WxXrjehKzFUA5XyvmA=;
        b=E0FJV1P0DvOewx7d7hSOpmUIw1DXYf+8yNqCM41bjJ0da6OA+7dJtejtHcxgOuLdhQ
         Y8vFJXMRtium4CdCdvxWnpqjBJMsp7Tijs0EbdwTrXXCN9pq5DAsaT/S8a+rztm0IPH4
         H6+jOImoQRROWRYWhzMRnKmrouPsjKV8vIW2oyFNSpSabG2HVgCwu/EEpuwnnLP72xWa
         xorsaqbcYJgUsZ88tljgxFfAcWd1QHQWr9dbVu75b6FFVF4uEecZjEwFqH6V/f/PjOSr
         nJ0m+nbVuuXkc7gZhxYL46Cc78dlZg8Ntv3rIXPavwMeyvpSs2MxQ9GGZpr5nxz9dB+X
         sihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781357955; x=1781962755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2iww8sRzZ9iwSa8F1tzoGIT1WxXrjehKzFUA5XyvmA=;
        b=F9cycVvUHJC/z8E2crknMfRKAQ0B8IWz3RgUE9Qrmru3TClZKUABu5mSHbJuUytBet
         Q2BuQNUDJf+5PYK3POeg5NHQfR67Mi2F3QMigFH/YwTB0csB5hLp0yaFOA0pqfxjTc6i
         rK9+lHKTxhmNt8kbjy6Cq1jBWrrja8yd+LC/GxGSrxeK1HgWEWrNc7+UKrhqP996G8St
         wlZ0AEBod3cCdcsaRVjkt5E+041hA0TSSCntQXzOkBSRmiZeDoLYfxhs4DHKCp8YNfb7
         Z731RTCWJZY7JATMJbfLU9UWc95xR6kLqhBdWMR5QRhIsP2mpCssrC6zctMl1tw10JIg
         Pwxg==
X-Forwarded-Encrypted: i=1; AFNElJ9K0aRMOfB50Bql03zSFWtETcSqs4YlbHkZxw10QX9xF1wb5F9aJVPDGGbRlewjXGNtO5nKV6iOnrA9rS62@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0zAoHlfpuywslPCumRewX1AGDS6TzoGvcE1lFQ1qSI0y4EJr
	cwsAxmIAvJlX1eqdKBWYbMPf+49cD+FMeLZdmBpU2dsi0xy0cG/jcIW2
X-Gm-Gg: Acq92OE2yVy8JWcfBhuIAoBVgMeAp7h5kiV9BIOkE7fKBFydV3Uuf5b5WKWoyB5p1Yd
	ABSab7aUn/q38scRiHzqQjed9DVDWinHJrvHh9YFitnrO3672ZcxFHInTunD+Di4CoytqVAlo4s
	kOi+PKGiCTbEMh/RvdJ+7M5RcB4OrzCGsPl4q1KSIr8m0eVcMwM2oBfeYDOGkjRTqeBMblX1aup
	oEifrBvYuDySTKiNr6eRxR3FSdYpKt5FEe2i/9bQKW4Jr2e8HPo9bsNE6FuWXTNvBSXS93Ninzq
	tZf1ZgAFodusII1yKBMm/JkO7ylwESCbMzDJeToFDwtO0a+2SckWpdLJg54F4V+2+ydVUX/9hgh
	ZwLR2+2IsPULZ6f5K80NMQR0yLecyFb12cItht3C6yxS3Z8HqysNbWV3mh+Z6LDNv+8FEvBtmhg
	FaXrny0wltHF32kXkDvHF75hSpYZyQJ5JM2tNq
X-Received: by 2002:a17:903:2bcb:b0:2bc:8f9a:3642 with SMTP id d9443c01a7336-2c4114a22d3mr82149245ad.16.1781357955070;
        Sat, 13 Jun 2026 06:39:15 -0700 (PDT)
Received: from localhost.localdomain ([47.100.192.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a44e4sm53471515ad.48.2026.06.13.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:39:14 -0700 (PDT)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH v2 0/1] exfat: reduce directory scans during file creation
Date: Sat, 13 Jun 2026 21:38:56 +0800
Message-Id: <20260613133856.238740-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating files in a large exfat directory may require repeated linear
directory scans.

After an empty-entry hint is used successfully, the remaining
contiguous empty entries are not retained for the next create operation.
This can cause subsequent operations to rediscover available directory
space.

In a test creating 20,000 files with random names and sizes between 1 KiB
and 4 KiB in one directory, the elapsed time changed as follows:

  Before: 3879 seconds
  After:  3050 seconds

---

Changes since v1:
- Drop the LOOKUP_CREATE negative dentry change.
- Make exfat_cache_next_empty_entry() return void and skip caching if
  exfat_chain_advance() fails.

Yang Wen (1):
  exfat: preserve the next empty-entry hint after allocation

 fs/exfat/namei.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

-- 
2.34.1

