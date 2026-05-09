Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5934D90C
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307173; cv=none; b=rVs3+lcShEaw2OfVKF+cnu+K+uDneQv27lxiJMw28SNvFYF2uHRZZHIsQAaiwXeklw2AjtNodgCchB5BLdbRHx9gCAQR98BEj1kOvUl2cw6P74LUOyDnziiolLZLYPbDLbh+YV9ykt+AingeqzC4lVXq7y3GhKKUb22P2LlOe6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307173; c=relaxed/simple;
	bh=PC48TOzHQt37hxOiP5Otjl5IcN76jFKPVasccqNSwhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECUDRYklBMm5hTzNhJjj43MWIoIosHmRvN+nr16WMwGJ/MTHtRkMrcUrIW7irg1vsECjVK17MrBPS8qpQG10k79n8N+zvERP/l9pROP3TtYD1nBiPmEbAMXiMN/fpF+8VGdOrhdWtR2mlbTTN64h2xKxG9/WWOHeivkpyFUUQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFef0OA9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFef0OA9"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c802196bd32so63563a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 23:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778307172; x=1778911972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frhKSscvsRYHqC+0u0Rin3XoCzEpPDvCVExPTGXmYG8=;
        b=lFef0OA9Ccp+7j7EgLp5O99GuVymhqRrAK72fmjD38o3GXdYQIEeMoa27cmaBURHev
         emdJ/h6vEa17TnJc7epO8kib8/0IogbY4xU6regim3c1uTa3PDPpnwD+w5uZe/q/2z+v
         kTVDDN9zqueyGnrItjCHMslw4aC4oDd+TNPV/uUi515cHtE81GkDvCFsoW+ko+ixkU2B
         OeKLLLE6BEWMy1iMMbh2O9e2T73hllKVmbPxbKcEPRFabJo08Ke5SFe1NKZE03hBWGVN
         MMcKUEMwm9tgHZpcfNPJUjglfoXAwPIs7mXSqum17C9OWVpTdCFQY/tV62okhyjhrpG4
         BRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778307172; x=1778911972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frhKSscvsRYHqC+0u0Rin3XoCzEpPDvCVExPTGXmYG8=;
        b=m0u/GT30QJrSzrE0Vv/s3VrdlONc3IbmjndGzzgo9Nt2aKoIfgipVAMA8XgZWKvrn2
         f4JLycQzbY8/dX736djSaWnUjUThX2VyBTjm+RbYRodpxEG/MZFBipFPATGhNaZ5g6v+
         jWsNLC4TlEhn/4q/Bw1hOsqTKrzp46k5gDlJbml+kdlWS+HBMYFjIyJ33vQ4nM33G/wi
         Qijm4LFwEXdbnJ1HWVc8I6/isfJ3GgObV0FwSMHtL+2Yvqb6Y5fvO67qQRiPuLewcPp5
         xtLnGrEawara4eAc94HudDjDQPYjZTE36eiaJHWTXfL/dRwOSXFwxNliQU6ZaRR8lmGn
         Icww==
X-Gm-Message-State: AOJu0YyW9ZIOcY/HE6ve74YIGnQyv9q4aK7oPzSFzfdjvTCGTyTxoFGc
	B6h4s9uun5y30Xeo1JifyU4KeWquoCXOSU4vTQ6TrJwTfFIbDbaxE9tz
X-Gm-Gg: AeBDies4SFCMbY5KLA0p50D/CIyyFmeX/hNsCMbTACeXDpnDsv/F4/ZIl2p061vrTCF
	YaBrFuMFO9z3QwFSLpuNYNzoA4y7K6hp3doHJaIIJDSvmZE1lpIUcknCMCxuQmvoxvpdmvqk2qd
	+efE8vY3OX7UolUBzh1/AvMq38E7XPTp3VAbOHQifVTB7i2uwMmclsDSNBXFB0M3Lk6tGXfXP7Y
	cjF/Uq1a14c5y6Kry93dwTp1d0w60fGmB/V7XnBlMyYJYI0UAUBFB3xZujYiL2+mj+qHVW9/SAD
	JuT596Z5ZbceXRVGjIeSqOQX0saTOoqyE8QrvSi9Ha7UCk/gQF8EjC/vyep5Gw+P25gfH0Stxqh
	gIbvdhczjndIIYo10VXFInoTmiNhEzMV9KZML+snm+guSbuTNlXE8CKxqGuZiWD22EyyeL4SUHU
	UpvJE5SK3QXI2Eyjg0
X-Received: by 2002:a05:6a00:3c8a:b0:835:3730:5731 with SMTP id d2e1a72fcca58-83a5b5bebb0mr9438002b3a.2.1778307172051;
        Fri, 08 May 2026 23:12:52 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659487afsm13380429b3a.18.2026.05.08.23.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 23:12:51 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 2/3] ntfs: fix MFT bitmap scan 2^32 boundary check
Date: Sat,  9 May 2026 15:12:36 +0900
Message-ID: <20260509061237.3233714-3-charsyam@gmail.com>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/mft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 827b99f4597a..b056c9bbdf5f 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1045,7 +1045,7 @@ static s64 ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(struct ntfs_volume *vo
 				b = ffz((unsigned long)*byte);
 				if (b < 8 && b >= (bit & 7)) {
 					ll = data_pos + (bit & ~7ull) + b;
-					if (unlikely(ll > (1ll << 32))) {
+					if (unlikely(ll >= (1ll << 32))) {
 						folio_unlock(folio);
 						kunmap_local(buf);
 						folio_put(folio);
-- 
2.43.0

