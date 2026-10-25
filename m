Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792931206;
	b=5AWecEoJGcnuqEyxQUPq6s/XypM9f2ekcdexP8sDJPC0lESKAlUMEc+gdx5BesJpZWrE
	 HuK8kbDpxpiofp/aO2pll+N0JkYu/gEdKqAjRvZdrXs7z9PkR5vcbs1Uj30o1qFvDidlF
	 aeawoRKEGeM4TWPnSRRLfA1ixmgboZbOYwJuh0ZWUQgr5lCKmr8cTop9a4MttztGevb6+
	 jXjgraFRp4vRGMd4CNLZ/4BN1xmLIyUKBsYJ9az9e+NMoMLqBGBxXlb+By40JA2gGM2WP
	 9iXmr7iR8CdEDJ3NabuF/UdMbt07XY8bM3WbJf3r0Xf/qGWpQRZjh1HDHx5/QG06yLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792931206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bJHM7BaL1qbpdXNxhWlZ4r8HgQW68d95SLx6NWeVvUc=;
	b=we1v10JxAPz8jRpLib5Uvan48lM7uORNRubntmq5vu2lhrji+Z+Yk9Y6OMTNY73VzpN/
	 aAOiG7nfJKQino5BLnue6bHo9zs4S3OFDqhVSP9hos5GQMcii8g6bjd9YmwC/GIrDJa4p
	 ERmGLpTCUOOgvrFdnO0P9pHka/P6anQA/hkefXE8Zh/576J7XgGSuTCoVnzBD7Z/2IqgY
	 qZA0jme0mq0xJ2dUu8Ox1zf0HaCxnEIalVouh0Twav0msX699zfqkokmtsV5Ad+Oe1l0H
	 1CetrqZ/6KiZhQMiN1JiHwqKBf8eAjz3FFBS2Ot3/T02nhhSNdBmjH/+3bJjBLFE1Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DRU1BRlJ;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837E606A31B
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 12:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0837E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DRU1BRlJ
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9907ab5b65dso52229241.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792931205; x=1793536005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJHM7BaL1qbpdXNxhWlZ4r8HgQW68d95SLx6NWeVvUc=;
        b=DRU1BRlJD7yIjrLohRUi541MlsFW5Lri6kvwcCMgGONGnrf+LHAkLrgZ+BxXdTrcGZ
         oDzY44gcxqw/lJY3zP1uob+CeudjQgrbbpFpgrOdr1KDctU2ShloQr3/FsQr/2eR7MVh
         Td5D8xqcqKNvad9zfgIX4KLLeY1pSc57Kbe7pWILm2JsZfV0zVcH7WrWri1a5jwlyAKX
         ta8RxRdFxilJlHzUCOqBrcfSm+dyet5yTfCB2a1EzIZ4Fy+D+H7JGq1O7tz21L9z/qn0
         OTyPjJLIG/CtrSFV13yr7YcfyUwqMdm8KnhMP2JK0+K8FoLGiFMnWw7jhzwsdP86wauz
         ulow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792931205; x=1793536005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJHM7BaL1qbpdXNxhWlZ4r8HgQW68d95SLx6NWeVvUc=;
        b=m5C/fYdlqyq6NG9DLaUoE4bs84ym9Y02xzBzWpe+jStIYmP9dlGIHEYglI7smEx0J2
         xJ0NFRMYVqQ7htVIcEfb2Y9nCFwOhgSaGK2vSMVos1r4xh40yLgSGywiiOXkV0HNI0n9
         4nb6PHr6NK4lfGt38IpourIVEm/CQLm2mbfBPVOsicdNHXWnfI0MJaF0Zn5lvYanK6Jh
         kWmLhsivwrWtksDLWfQRZ8ECTjcDyPQTa0usCw+3PaUVqv9otYBgCqrWgepYfgEiJih5
         ji+p8BiBMpo4e3hd7Vp41gSCbfjfM4dbWxL0aOOcegRAqsHtnBotHJ5zVbplht6/TIAl
         OoEw==
X-Forwarded-Encrypted: i=1; AKwUvBwYXIITnbAcRnsAHAS0yyU+TxyC25ZbTQSau+ThTKkeJmOM2x9Xz8jIIzvIaw8D3Hzlp2pxGp8t2vagtcx7@vger.kernel.org
X-Gm-Message-State: AFq9FYKQ7gOkpYUqo5OJyodwlSSW0UeXcnIeKW7O2wNp7BDUzpDvxjce
	kEtnsL0BeeR77kCESsbcWyLCW8ACrQ5MhyQbt5WEmXnNNlX05ZS+3MlY
X-Gm-Gg: AYBFou2mklVqh8P+ZRv/Jlyd9a6Ta1d6lywujYPC9+UboGykBKTWDB42tG/bsmgv7aP
	DlldrLvF5xGLlKEJGksD1pRmY71kc1shugvK78+BgfIM1Ru38+TFFPYZRz1fGA0MjjEy2KnxUTl
	h/KOoDySZnhFPEy4w6vA25WYxs70UMeZSaOpbg2wA0+YQ5ZfXqjOC8RpHogjQ0X0UNsLTOYhFQg
	pgBvb8KlAXkJ0zHZzEDTzJKnFRVgPm9XYI3llaGljYdxsP2stDxS0Xz4XumYs0qAMzy8Meqyi+v
	IKaqPwbx9hss/Gh0V6hkzScB3u2d34OaG7D9ENnLBCooaZg9MG+KFpy5Kb7opgW+BpMmopALehG
	pBWthj7v099kJZWA6AbxGRQ7GnPs+FK6eYqZma1hzgLhjX0W0NqUBa37IIVi3o9kQnmGWoC4ih7
	1cJCKJIL3N/+Scneu6lCebDtzZUyry5+39DvDuYluADDKYpgbHLwzWgZV/sNfaAHdf5lTstp5M1
	XVN7HZsTl82e+UA0gsrGvCUBiR5m46w64fKYSNj+vpa4ZheFxX1f/9/ya0PwVhJJSto+9DjIL38
	jKTmjy+Uql6/RA==
X-Received: by 2002:a05:6102:1458:b0:7ae:545d:f97c with SMTP id ada2fe7eead31-7ce5ccddcb1mr755537137.3.1792931204840;
        Sun, 25 Oct 2026 05:26:44 -0700 (PDT)
Received: from tacolabs ([2a02:6ea0:cc02:5480::14])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ce5df708e3sm4694536137.2.2026.10.25.05.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 05:26:44 -0700 (PDT)
From: Reid Downing <skibletz@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Reid Downing <skibletz@gmail.com>
Subject: [PATCH] exfat: fix upcase table validation to require all entries consumed
Date: Sun, 25 Oct 2026 08:26:39 -0400
Message-ID: <20261025122639.1173247-1-skibletz@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

exfat_load_upcase_table() and exfat_load_default_upcase_table()
accept the table when index >= 0xFFFF, but a correct table must
process all 0x10000 entries, leaving index at 0x10000.

a crafted filesystem image can use the compressed skip encoding
to advance index to exactly 0xFFFF without filling the remaining
entries. the checksum covers only the on-disk bytes so it can be
made to match. the kernel accepts the table while the unfilled
entries silently remain zero, causing incorrect uppercase mappings
for the affected codepoints and breaking case-insensitive filename
comparison for non-ascii characters.

fix both checks to require index >= UTBL_COUNT.

Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Reid Downing <skibletz@gmail.com>
---
 fs/exfat/nls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 055447edc..7afc86ea2 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -691,7 +691,7 @@ static int exfat_load_upcase_table(struct super_block *sb,
 		brelse(bh);
 	}
 
-	if (index >= 0xFFFF && utbl_checksum == chksum)
+	if (index >= UTBL_COUNT && utbl_checksum == chksum)
 		return 0;
 
 	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
@@ -728,7 +728,7 @@ static int exfat_load_default_upcase_table(struct super_block *sb)
 		}
 	}
 
-	if (index >= 0xFFFF)
+	if (index >= UTBL_COUNT)
 		return 0;
 
 	/* FATAL error: default upcase table has error */
-- 
2.53.0

