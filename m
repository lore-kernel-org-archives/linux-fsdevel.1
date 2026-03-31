Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA03806A9
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986907; cv=none; b=js9SwskWEOtukQseOmXV0c67Jd+2XWSLO9Q8qIteLCyg8jJGfy18v5rEOWWh9g6BaAnyiNUf4GZvtp+u2I3NGn5hzkgTPZeqJ241WDMEZrS9317rY4B9zZMgTrq9xpw9EA/jD6Qxg1aLwr6hQVPNPsDx+NxjmpuIOKHIDcZVN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986907; c=relaxed/simple;
	bh=fhP0zt40UwKsUM2Fn9TY3nPTLsBThgp+8L02jrjFmUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2yxaDf1eaKCBL6vrNTWfDkge2UNUkIQHl4GRXWIAnzOZhC0KdGXzA8z2mTXWcCesXIV7SAa/7vXMgEDrCdhZCS+y9bBKHJhPACfSX/VYSdZdbCd2ewxrGEDEx5JxPLHIgJBYeGXzGrylZyG28vQyBmA0S9siNbUJFl5czsxNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLWVH8+N; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLWVH8+N"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50697d6a69cso32406881cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 12:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774986906; x=1775591706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kWz7WqMpgYvQODXw+vPBMXIXzOL9PxHt93CiGM1MVI=;
        b=nLWVH8+Np2MG+ga4e6EGp+tfMiQh+zVNxaCrLVhubtiYWPRpDwUI8rI5bpk/V+83cZ
         76A/vVXYy3FjTnoaJrM6sHTG21Fzwmy0Rvu04PNI1e1knFFus4jKBEaivvw4+P1WUwss
         jNFfxin8o0LCu7mYbQ2JhT1b3tBvNIYiqtqID8YcnDZF1Q10+l1nqvhRtnQy5bw2VW59
         1pPh2LikGGPQoq3d1WBopZOlgks3Yzk9LhIrTUzcV5XgvpEAJSVtxOgli5OQHDwXQeCC
         KVVTTrgfYC1zya8nEc38Og8Bzvp51zgJ0vEzBnFywwR2xLXjFDi1pkES2vUM9HJMI0Zw
         Td2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986906; x=1775591706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kWz7WqMpgYvQODXw+vPBMXIXzOL9PxHt93CiGM1MVI=;
        b=MaoJ65Te8cONXfBdghsbfZh4kmT1TCGXx42ursJW3Uj1ScKOs4WdssF7xvzsbBLgbX
         a3YnM8XlYiUOosefCr2agovNnec/gk/Xn8oXBw7VWE1zfsP7M8ShPfDLj5a1QcKfCfDD
         gZw0BPRS1PIa4/ilyInHN8RaGHFyfJfRyNoCKUq/RHcSSrRus7GaXhPCzsnF1RsRmJv7
         Haj8wY0uW153fG6suYZfUELQ3D0DFW1Lwx/SIsAgA1+tzWYRAqNQa0PsO5dlXHE0l0fB
         vP1qq874znv43w8ITkbZAspAjky8hYgxUofPiwFO779eCb+ZB8g8jvp9B+7XEiMTy6/e
         5xZg==
X-Gm-Message-State: AOJu0YxbrY3hz01vijPLdQXTxjaWkBtsrr+5T9w7S8v1FekxPM5ki64/
	VvyQVOeaFIseReCcdjber/H9jDK+rp/9gKnj1wSmpm+MAK7ovZfF8WoK
X-Gm-Gg: ATEYQzzsgNwvm+VFYUa7TzVzXrLInNc3xwHpU9+pZP9VFB5sRUNeMwD5hLhdHYnazWL
	Sz0Y2Stvymq4wafMulZFoLLxedEw0ypGLc/b0IIJsQj8+Fl/lpxW7uN/lmPGQpvnzQWMGwrPO4n
	cwAXA/9rNqbhJ9KDn/2SMRml3mxXNRDdm3jcKGpMk8ZpU/7o6oWllZqoHDok0dhX9MC08HoNgpq
	95LVlT3zU4o4CkBF+jDRE03Zu9Uwenti951jVrae2u/ZNQYLgWMOKJWmbFks0zRripVh8+dyWZ7
	7oi/y8Psw9Rb/oWyQ3FQHCM9OI4FAdmjWGoUnpVH199AEGAMf6tqozSIiFL10j+rtFIHRjUqIXL
	hAVJ3egP611QW1ZvyUdj6YPRb+yNqUWkfmO+zb8TW0sQdpVgvSUvV9r8w8w/x+rolMVfm5ekVGi
	ufwrsgPiKbzo739rhmq6LFmP4/IjVmQzY=
X-Received: by 2002:a05:622a:1f0b:b0:50b:3895:fac4 with SMTP id d75a77b69052e-50d3bd9e27emr11997101cf.62.1774986905582;
        Tue, 31 Mar 2026 12:55:05 -0700 (PDT)
Received: from MEROWN ([85.93.99.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2e16f78sm96678711cf.22.2026.03.31.12.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 12:55:05 -0700 (PDT)
From: Daniil Bulgar <bulgardaniil18@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Daniil Bulgar <bulgardaniil18@gmail.com>
Subject: [PATCH v2] fs/ufs: refactor ufs_set_de_type in util.h to use a table lookup
Date: Tue, 31 Mar 2026 21:52:58 +0200
Message-ID: <20260331195258.71494-1-bulgardaniil18@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the switch-case logic with a more efficient table lookup for
converting mode bits to directory entry types.
This addresses an explicit TODO in the code.
The change reduces code complexity and slightly decreases the
compiled size of the function by replacing
branching logic with a constant 16-byte array.

Signed-off-by: Daniil Bulgar <bulgardaniil18@gmail.com>
---
 Changes in v2: added missing [PATCH] prefix to the subject.
 fs/ufs/util.h | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 391bb4f11..8966c3ab5 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -152,34 +152,17 @@ ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
 	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
 		return;
 
-	/*
-	 * TODO turn this into a table lookup
-	 */
-	switch (mode & S_IFMT) {
-	case S_IFSOCK:
-		de->d_u.d_44.d_type = DT_SOCK;
-		break;
-	case S_IFLNK:
-		de->d_u.d_44.d_type = DT_LNK;
-		break;
-	case S_IFREG:
-		de->d_u.d_44.d_type = DT_REG;
-		break;
-	case S_IFBLK:
-		de->d_u.d_44.d_type = DT_BLK;
-		break;
-	case S_IFDIR:
-		de->d_u.d_44.d_type = DT_DIR;
-		break;
-	case S_IFCHR:
-		de->d_u.d_44.d_type = DT_CHR;
-		break;
-	case S_IFIFO:
-		de->d_u.d_44.d_type = DT_FIFO;
-		break;
-	default:
-		de->d_u.d_44.d_type = DT_UNKNOWN;
-	}
+	static const unsigned char type_table[16] = {
+		[S_IFSOCK >> 12]	= DT_SOCK,
+		[S_IFLNK >> 12]		= DT_LNK,
+		[S_IFREG >> 12]		= DT_REG,
+		[S_IFBLK >> 12]		= DT_BLK,
+		[S_IFDIR >> 12]		= DT_DIR,
+		[S_IFCHR >> 12]		= DT_CHR,
+		[S_IFIFO >> 12]		= DT_FIFO,
+	};
+
+	de->d_u.d_44.d_type = type_table[(mode & S_IFMT) >> 12];
 }
 
 static inline u32
-- 
2.53.0

