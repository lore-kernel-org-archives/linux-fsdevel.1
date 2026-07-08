Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8943B6BEB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507601; cv=none; b=IBUSeAiCnaxtZfhHfv4iZM7W8iQnOBWeytM91jMEyG891LmoTiZajE68rSXgYzWtQcB5ZDjX7A9GYfc1JcHbCr7Qg501/3TqFMK/MM7q1J2pMYf8S+l4efwH0kLaeHPXFShFGAlzQcNDP8shJUpVU7A8NWswThtMgoybkaUKnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507601; c=relaxed/simple;
	bh=h50cwUuUs0f8FFaS1fOWW0Dv2ObWqswJ0qaMne+oqGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSt7tSIwsKFF0cl3lSy0ejMNQq0YA+Jt6Uw8wVKAO3wJ4NyMVEncivDgTBQbVM5WiJIlUdGJADaXdTgqmyHxISSnfCXeEKFvqYuU9GzOxm+wEPIaskV92T8WTchmzOh++EWO7IqHcwSq7gvPofunM9qgSubS/2FvykvgILp0VkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mphidyu2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mphidyu2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383cb94f742so428920a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783507591; x=1784112391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SeBRUUQT614U5Kyv0ejkXZ6Le7sVCUMlqVR5el6sHG8=;
        b=Mphidyu2NRTMnB8IlvyHK4S8pyvgHGmE/vdjjDTRlzyNiMtBdw4s3Ro03rUlehNx+S
         oWeapXfdSuaauJkYwFuK8oA+eaU2RJ655uYJG/wtHvnsWSgWuuCRGLydv3h2JnYMBalv
         rdWzhwkTPyZbGhtpq39M7+ozcZvFDFnUFqGMhy0Fygeq0VSjl0HjBI/s8i9R4Jbnv8sZ
         dp6x5H4+3PmVbSYimf3G+Gow3/sPAf8h2hgYimhaNwy0E69fCce+kRKSL1K8UzuCtyMk
         9vDGlA4EpSVI5Kj93PBKFvZBQZE/4puvcfdPx2LgFV/7Wwfw/lUQxPMPzYC056Ov/+lA
         F+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783507591; x=1784112391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SeBRUUQT614U5Kyv0ejkXZ6Le7sVCUMlqVR5el6sHG8=;
        b=e7Yx5lQ5IPWZoAtgX1DyzRt8Puh+9eq/yIsX+mbR9S463hevMefBU5QEj4Il2If7Pd
         6Wy0rguWdqo7cblC19uHnxJJJTTCCm6vYOXYKxXp5ha5Sxr+/Qm3jZYt57b/AYdtOOTA
         l5r9Mwlu98IdGE1Q2RIr+titV3mtP5gxe7DDTBz5st3fPlEY8VRt/Iz9Teb/liPM44Ha
         UEIVWFYgo6uLYGbU+N3DfZojjHhESNXIqVC7tASxsCAHR76wfDDxWBBn4lhEUeNLILjH
         ybWhFCTwRhunPhbbYrocIeFf+T9q6MTzCf+UzZxcXZU413wy2OZH09MMjiUB8sVEBPdg
         SsaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPuzvxbLYzlbobPWzld3E4D4ztaVvebbKWw/G6qKpegvuVlI2nhtT6sXbFwoecHxaLIU8j7lgpl0J86uB0@vger.kernel.org
X-Gm-Message-State: AOJu0YzDkhIh3P9s9m0KSM2NIe6f/YtJ7wgpxfDLVTubd9nmmHYPuFdA
	BBI3O93HCmDDruZDb0jnyK3wRbRPKr/SjTxb3T3ONUsB869IsISM71Es
X-Gm-Gg: AfdE7cn1nd8oeBgR1f9A2f90t952NohdlWoxva5uJJmTinxjcnH9LvdD6dcHS1BWQeB
	RTEHYEQRhNAuaLSn9rzuN3w7AtuvEJFFohNWwDhFpGaW6T/i/xn+tcXCn7csXd4F+3BV9OL2vU2
	b30D0XD+mCgL6ORbUnnGLL/pmEQRi9/TUseCR3GgWgHN6I8bBFmOPolnWj4kyplrjPSjDwiaN5O
	p3UJQ8HMXUGSDNJ/DXY0o81xaqRXU3LIGnSvYTqHrBebrUEssnl1FFOdUk39u3MD6b9oPqR8ThG
	Jl/eVjt0LJrex8qsIHMEwTpIvz6PyPUUgk9LUXETBYea4usrni/gsBaBdLsY0oSkDkJI2+Lmkc4
	GUPxJJKj3hcPQ6DcOrqpH2tqD1HPpdrDlMDkAtdIokJ1FL0/Bxk1G7A1LD8CO3lediv4Ho7HY30
	40PkM=
X-Received: by 2002:a17:90a:e705:b0:387:e0bb:57ff with SMTP id 98e67ed59e1d1-389426976f8mr2046961a91.38.1783507591065;
        Wed, 08 Jul 2026 03:46:31 -0700 (PDT)
Received: from lgs.. ([101.36.109.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-388fdaa34e0sm569703a91.1.2026.07.08.03.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:46:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] zonefs: check multiplication overflow in zonefs_fname_to_fno()
Date: Wed,  8 Jul 2026 18:46:17 +0800
Message-ID: <20260708104617.745781-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change referenced by the Fixes tag added overflow checking for the
addition used while converting a zone file name to a zone number.

However, the digit value and decimal shift are still computed with
unchecked signed long multiplications. For sufficiently long numeric
names, shift or digit can overflow before check_add_overflow() sees the
value, leaving the parser with an already corrupted intermediate result.

Check the digit and shift multiplications as well. Only advance the shift
when another digit remains, so valid boundary values are not rejected due
to an unused final shift update.

Fixes: 3a8389d42bdf ("zonefs: handle integer overflow in zonefs_fname_to_fno")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 fs/zonefs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ff43d6d1ea30..106cf304348b 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -615,10 +615,12 @@ static long zonefs_fname_to_fno(const struct qstr *fname)
 		c = *rname;
 		if (!isdigit(c))
 			return -ENOENT;
-		digit = (c - '0') * shift;
+		if (check_mul_overflow((long)(c - '0'), shift, &digit))
+			return -ENOENT;
 		if (check_add_overflow(fno, digit, &fno))
 			return -ENOENT;
-		shift *= 10;
+		if (i + 1 < len && check_mul_overflow(shift, 10L, &shift))
+			return -ENOENT;
 	}
 
 	return fno;
-- 
2.43.0

