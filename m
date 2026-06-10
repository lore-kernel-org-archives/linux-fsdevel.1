Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ECA3DA5B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098642; cv=none; b=qZfnpmB0Qf8voYFQl2TDC2r2sk3CbvGF4+dStg+tNobhG9VgeLJyg2l5ivKvlbpfCCFJDqwlKZfJd0BJMGoQrnnHEdU1Mk7zEeVD2v8q9rwaVQ8CDawoSvAuGzhan/GE/KBNmou6WIqmFKSDrhA4UgP7a7An+2cdHl6QNuJ60Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098642; c=relaxed/simple;
	bh=MZe7fVWYI52TMx64RXHXnMVqqQJFh0G4QoSu4aR/3Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BVPv3wqKasxtxrfsv3e7E7taEwIKilwEU2Rel2mL5qoEr0hs7Q4pR4LsQENk7Si4I5vXa6LtHrCh4ydhPFBulZA55mpoODaZ/4PTGSPvsBF0to0NUrV1Uwbr7I2ffkROeCjEGQum1nZzW/7HD2k8OphFHWgmCq3hYIJ1E2bzGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfP1v3zt; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfP1v3zt"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7315605a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781098637; x=1781703437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90h3yfMHqb42RZxN8blv91V7/w7mF3MH29nWpUNYRUA=;
        b=OfP1v3ztnWNSEQu5c3cx1bic82IELcbahhv1T6l+rBkOFTL4ylSr1P1x/treHaNxAM
         OjxPX5VbNovE2eER1UTHKDLdffcoBKdJ1j8rGaVorthJAOwaTUMpZZteZz1y3QxfONt4
         EcOV8uQADWnDzgmsxL806XC7cF67W4Xh88gXZ+O/00hlOszHfut6i9uyIugTUoUa1k0a
         oBkqsx5MqEscRzvpdE63o3mio/UlA4fGMap5FCVezC2BnaONV1Om2pBNGRgx14wr7YV5
         GyC1KwaeIKD6Zp5egYFrwtlTAHR4c3PmjxvZyWaF1lwwFDVYQcd77cNLr6DkHqWyHSXs
         OLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098637; x=1781703437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90h3yfMHqb42RZxN8blv91V7/w7mF3MH29nWpUNYRUA=;
        b=YYx7iOELFtiMuu6h7Ux5MJD0bJ3UDqc1dcr6x80vEF0YtBWSiVG9IGp0llCHYH6rxf
         nhXrp5nsJrt5ENmrr1l8aD9fHv2BmSEUCcPQJ0ooXlbAkxS6/cHblBJzlkgwMMRSwWOJ
         UeNry831dzbV0QQgyXw0upYQNvw66KOgstGCVaoGUSrqE46gUukQPEz/QOQ7FSUKdkf1
         QJDrJKhhVWJHeiq/jts2Qz9G1xuZhzp3NIH5+OJMPa75gRwOl2A+a7x9HrNpiT0Qdinl
         HL6akZ4n21R37++KFoXePGGa5ZkTOx2DN0MZZZekLvIN/H5gQFw73TRMTBQLz+35LOrs
         2xwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1Sl53rs43MZR+BC12hzrYQiDROjDIH9CNZ7VEgiCL3YWv8yrjmj3T8smY5F4izEQ6EShfER1BocyKry50@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHw4cBS+s2c9x2GnU4YlC+U5yyuyfVRV21UmC9jm8cE7hwEy6
	E3G7K7y6JlHan3YvvdkvGPjuAjQ1MT2/DEyry6+IuKvjkNdel9m9DBB3
X-Gm-Gg: Acq92OFhsqu6bDFyu0fZ9MaGubhbpFZv29fg5udo5h4ud4DWio6KjbUX0fqI8Osgr0A
	mrrM5xv1xXvof3x6mD42aeufAcDOfLesrYSwwugiFlEnu0HffP9yg0qOFEpzI9DeKXFtu37XsG6
	iuNEpPg/qPP7LuXgEUeJawmADDeL0gk39+vhMl5ZbE1GcZh36wFckACDhBDgPhUVGrNlgWY+L4b
	Bc88EeRLRkldA+7MlFW772iSb2YrG0AL54w8l5zOjyXN2xgrgxrCUvobhYR5VJq1KfFuMBpYjy+
	4P09wkEJ+IlDPoVf/KMJtAxeYvi6wx5p6yzo/vDva6qAYId1EevsoUf29VY4OIM39fVayYJuxFU
	kR5Dw0C/Q0kNavqvu0ewm5e1R52ejk5vpfX6fmrGnRoIQQWKYHgOOUra0N+4q1Bqbb29wf4pENA
	sxzTKy+fyeJFoiHKwZWv37ddhgC9BO2hw1b4tAiV6xAzBP5B7N4Dq1oHkILw==
X-Received: by 2002:a17:903:248:b0:2c1:564b:4f49 with SMTP id d9443c01a7336-2c1e7b35a10mr283910915ad.6.1781098636645;
        Wed, 10 Jun 2026 06:37:16 -0700 (PDT)
Received: from localhost.localdomain ([47.100.192.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm248130815ad.26.2026.06.10.06.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:37:16 -0700 (PDT)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH 0/2] reduce directory scans during file creation
Date: Wed, 10 Jun 2026 21:36:56 +0800
Message-Id: <20260610133658.196180-1-anmuxixixi@gmail.com>
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

First, a negative dentry obtained by an existence check is currently
invalidated for LOOKUP_CREATE.  The subsequent create operation therefore
looks up the same name again, even though exfat does not generate FAT-style
8.3 aliases.

Second, after an empty-entry hint is used successfully, the remaining
contiguous empty entries are not retained for the next create operation.
This can cause subsequent operations to rediscover available directory
space.

This series makes the following changes:

  1. Reuse a valid negative dentry for LOOKUP_CREATE when the parent
     directory version has not changed.
  2. Advance and preserve the empty-entry hint after directory entries
     have been allocated.

In a test creating 20,000 files with random names and sizes between 1 KiB
and 4 KiB in one directory, the elapsed time changed as follows:

  Before: 3879 seconds
  After:  3050 seconds

Yang Wen (2):
  exfat: reuse valid negative dentries for file creation
  preserve the next empty-entry hint after allocation

 fs/exfat/namei.c | 56 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 9 deletions(-)

-- 
2.34.1

