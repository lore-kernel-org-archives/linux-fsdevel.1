Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA993FFAA7
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254465; cv=none; b=Lc8BZ5sYyEzu7goW3FnsFvf9DH01riizW+DoBijOreCOzoeO2IOfF30C8KwmBUgvP4JvCCtFpDwvU6jIdE75J+Yq4UfapMyQw5Ap4pilEkXh2SAQqVCvHNcLSn+8sB0jmHCihsF6kjgEJ+pQww3HwiBqwnOA4laLBQKDL4r+4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254465; c=relaxed/simple;
	bh=X5irLmEg3FC1ByiJtD3Pn+cYS+C0zl1YcFztWaTN51I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUiIqbI0A3FdS3rh4sCeQ+YIcVyBtUdz6QfYLGhk5LedAnWxBJNa5JL/QslNwy566ejEJx/wHSZ3OnF5mFcHPqnC+8VO1GZKLSmJDyyONWkthG3/GVyqEVM3WiBzQGbnR7PJVJ7xUg5mJaO4mOsg426qPUYd97GgkvMDoFSFJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTAfK9qi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTAfK9qi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba25c9bb9fso3952365ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778254464; x=1778859264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgRGSq5ggnVuTI7qHhDapadJXv16hq/gjrg/fvfy45w=;
        b=hTAfK9qi7RqC9LMk9nZm4lHpls9XBRnrZSmNzbEjnCEKbCuyTB6Vj2mO93OJJbOPKO
         3GqPYhuKYcKdsxiN9zJTStd3ra/bjDFJUhGKsEjhC0gqpOEODZRPPR21jPSpj2Kqdknc
         yV4SM4C9jGcUo6pyM/hz3d/3i4+b7eAxuICi9XHpVkPaC6UJzEOOykQr52qNOjnVhE2v
         F7Hqq5KitP/6i3U5ztKnRKKSsm7DrMl02VlUJvZ3apLE7kEjD+xh4jeGZul7X8QPG0Jf
         SMMhn0GzYn+JWxLr9j3OEazWSdRRJ+tgiA5qSUK4boYUwwjjt4e+HQrfaQ/E2Cf00vy5
         rPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778254464; x=1778859264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgRGSq5ggnVuTI7qHhDapadJXv16hq/gjrg/fvfy45w=;
        b=cig1ZygFAV7eo8IwyDyhJCUYOdK8HmCBfzvnTAW32UuttzQ4VDgWR9Xj54+oNdyNdg
         eBqrrtOBFMtF3jMCamLAJ1pcEVkjCHJWXy2v8vPMk8saiilzBQTVEjg1FlCEw7YS1gSM
         QWl//8Bn39KdtzFb1PaGS/OmUDzdxHWXqAKSz2OuHCO0pEUFmx8EpWrB64gOqSoZlHSe
         XrAipKzlrolEK7PunJ3VxqlojYeXjjr+s/s2EIXFiGMqsW1YRaYnpXQCYlXtQQNO3V6X
         Q+TZlCu5t1oYHlyl6ozGkdIsqjcIN0Qera8TA+hIg/qfcGPNISrl0VabRoxtq4f8zbPg
         /F2A==
X-Forwarded-Encrypted: i=1; AFNElJ8vVdH/SLabeQqKD+QEO0lwblnHJgdI7+KYgAhXRGQrnz3Gy96tGRrZXjXS9OAn0n8sFQj91NNbp27bVb9c@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcBlXKa/4klZuUPYnemYvNk9sFZjYL0Bk8XVJVxJxnSXYDH0/
	AKy4SuBVxZxNenaBTJIyTc1bIowqMwiJPXjQAx4AR9+QU/LTMxAVF+gQ
X-Gm-Gg: Acq92OFsBSKWqUofEGHdHwirwy6Rk8jEylvKpefmjJoVaEMgn65ORFKzuiB9b76jCpL
	HuYYsJenr+aQxr/hQTqmB6uIqL2YRnP+xQ8UnOC3OtBovnYPVLAZzQ0+ha4/+P8RvZlaZ2BsUW1
	YFDQAF021geqyOTuaWqPKhqrn663ZahaGf7DoyCMeuWcDHSn7fEBHw78nc9fvlpoao3GRtvw1Q+
	mn5xu9BRaYigzAwJu3e4VxOUPyvm9jUf9poOso3XPR1hP91uyUDS45foKsgLw+0F/h7B7eI/QEs
	zB4Pje7jeB5vL+sqyUERMmZlhq1jaqga7KTD9Zn+VLxTX/Ls8sUaevtLxsVvyM8hYjbWad+N55c
	v0a8SRZMlx9J3Uimqmzv9c6+/MNGNvPEij2ikj5r8m65atbZ7CUFWnb1R3nyr99n/6Y8tNWcHZA
	SVgbPvnJfFKqKGrVO5UCYj4PPuFnQ=
X-Received: by 2002:a17:903:3c2c:b0:2ae:7edc:9234 with SMTP id d9443c01a7336-2ba7ec651f3mr66040085ad.1.1778254463628;
        Fri, 08 May 2026 08:34:23 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4094fsm26666365ad.19.2026.05.08.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:34:23 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ntfs: fix MFT bitmap scan 2^32 boundary check
Date: Sat,  9 May 2026 00:34:09 +0900
Message-ID: <20260508153410.2624801-3-charsyam@gmail.com>
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

NTFS MFT record numbers are limited to the 32-bit range, and
ntfs_mft_record_layout() rejects mft_no >= 2^32.  The free-MFT-record
bitmap scan in ntfs_mft_bitmap_find_and_alloc_free_rec_nolock() also
guards against this overflow but uses a strict greater than comparison,
allowing record number 2^32 itself through this earlier check.

Every other 2^32 boundary check in fs/ntfs/mft.c uses '>=', so the
strict greater than here is both a real off-by-one and an internal
inconsistency.  A model with ll == 2^32 confirms the current check
accepts the value while the corrected check rejects it.

Use '>=' so the boundary matches the layout-time rejection and the
surrounding bitmap-scan checks.

Fixes: d3ad708fecaa ("ntfs: Initial commit")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/mft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 70c1aa76181b..f8f2e481c5dc 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1279,7 +1279,7 @@ static s64 ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(struct ntfs_volume *vo
 				b = ffz((unsigned long)*byte);
 				if (b < 8 && b >= (bit & 7)) {
 					ll = data_pos + (bit & ~7ull) + b;
-					if (unlikely(ll > (1ll << 32))) {
+					if (unlikely(ll >= (1ll << 32))) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 6, 0)
 						folio_unlock(folio);
 						kunmap_local(buf);
--
2.34.1

