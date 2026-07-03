Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DE30171C
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100011; cv=none; b=kZMpGxS0Jz1yD6ZS3GOhp+SH23dRmDs/vF0eln+gT/UUE/Yg/3GFpwkaXWoKG78AxBcLAlVuB15Tsci8t3lPF49/ozQRkyp9hYK7Mbnl2Sr9/wV6W0pt73wJZEbub4NCGKujQW9FfEbQGIC03LU/Qj+UUYA1apZ/XCRHRa1lbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100011; c=relaxed/simple;
	bh=4OaN38/+Ic68kJglERCsr+iFMu+H0uZi+FVKvPvEwcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxEbnZxgxzOSlA7nChqDyBaJxKiumSagkWT3Q5FLMDRsf2XQO/NAyu5ouAi51V+UfOHWLgOPIAwYw712m25c/XRRXlveQ911FnegTyNGTxPqzDhAvZCVRSnonuRpf5eQ9ixj9lKKgLmpmRVP3R96HgVAm8YGnVG0RiCLhYH/2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRHak4Qo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRHak4Qo"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cae134bdc8so3476375ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783100010; x=1783704810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6YIq9wieNEB248qZbJUVWSlhdHzHlBQDkP0JzLpC+s=;
        b=sRHak4Qo6LRNxw26HWbNjou0IZR2MZ6uOgN9/yAiDLUfSzPHPc/7qDCIbhcmc0Muaa
         /vkHqo19nwHCG+I0kCO4NKqbW8hAioDKxN39ftQy+Y3Jo0HodgDv2vbjdFHttRSdAl3T
         nGP6wczVIpwMx7JhsoUxLOoN6BniKRf0I6/NjWit2TIzNP7GyScg/sFRqckOkEFDGRIB
         iYDjF4VNfhf3iodx6p2lCoDX0X9O38NZS2w8Te5uEYYI8FGLHr+PPslEtR/FAvdD1QBu
         Yi3vvyD6b3x3ogcxfMpfU8Gk+1JX/+Xi2Yai18OfTQ6YN92dC+KeMwatSZhTK3JmX5yt
         mmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783100010; x=1783704810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6YIq9wieNEB248qZbJUVWSlhdHzHlBQDkP0JzLpC+s=;
        b=lnwPO6SVRw60mhCBUph3k9y+u01ju2uX8BWxzFXGdBH2cnBrIdSm4blzp8TmgCFkF1
         u0uy1OI5GixMgTn84/XhuiNuQu5szWP8WckH/aTwoUTlP11pVebS2AYHDwqyhptC5+Pk
         U8B34lS24k2lAmDn0LUskQSnJBP5FNSRRHNKon9Xq8E6f61n+e7gQB0iMATD/KBbMnQY
         8BcvgUQI4TEhkKiXgtZf2r1tmxxA6hoWszVD3qSlXMafDXvGdceKu9+NCQxE7q/+4VQa
         JBQxOM3taZ5weXPAvICgnMk7cMa5mLQ8EEkYkUiZh88aFol5p9Fu4hBp/+QE8HOZ73GN
         qUfQ==
X-Gm-Message-State: AOJu0YxSE49gI01s37ousSFwM+xsR3V+8K9dg3A8AoM0b9cfrAzeIJwZ
	JAvpJbtIqKMrMz+I4f3l9U2d93JDfc9uCeBtih3V3Vr5gZp7mvjKoxxB
X-Gm-Gg: AfdE7cmf6YITVQdmrql9p34akjKwj9NFD5iCMsyyHsBizBHmkPL47ZVqcFr4I24gv75
	6YYAMOtH0TYcGg8Kz4N8/9jpKdhA0frIoT58IF/cpN1k6IDAFUrJIGUz2vJJK5AuwYT5Fu9FEO7
	pYnxVXBIbQS9QNGmnG3SD8E0TGnDLAD0G/VcTkX/7Pi+iFdBxuYhXPuRw4JxfmoYZXJmwu2jbsG
	g+Dxtmq7BEBrqVVdOSSUb5IUSep1g7waUQPQhdP1Pb4LIo8CdS9jkriNA56p1NCnd/fdj65S4Jb
	RpFmWpwGaJu1XgA5tEDWn/L2mTSQtaODo4vU5pMM/vVK3tLv5bZ9uHeYNbo3OvHbmL2tcq5GMbQ
	qADBVzyMRofNP9zwc1hyKkPwIcMWXkTs7vBtbIKD2bs43xPSAOz/yQJL/JGF0TEHLizW1HO5tED
	0wVqHlgqc0TA==
X-Received: by 2002:a17:903:28e:b0:2c9:b8b7:5d1c with SMTP id d9443c01a7336-2cbb9e254c3mr2131065ad.16.1783100009626;
        Fri, 03 Jul 2026 10:33:29 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:4288:f1d2:acae:80f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85bde6sm36353799c88.9.2026.07.03.10.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:33:29 -0700 (PDT)
From: mdshahid03@gmail.com
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] ntfs: reparse: remove redundant NULL checks before kvfree()
Date: Fri,  3 Jul 2026 23:03:01 +0530
Message-ID: <20260703173301.89289-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

kvfree() safely handles NULL pointers, so the explicit NULL checks
before calling kvfree() are unnecessary.

This issue was reported by ifnullfree.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 fs/ntfs/reparse.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index fa523dc3691e..ced4c675d91f 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -317,8 +317,7 @@ unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
 	} else
 		ni->flags &= ~FILE_ATTR_REPARSE_POINT;
 
-	if (reparse_attr)
-		kvfree(reparse_attr);
+	kvfree(reparse_attr);
 
 	return mode;
 }
@@ -358,8 +357,7 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mr
 		}
 	}
 
-	if (reparse_attr)
-		kvfree(reparse_attr);
+	kvfree(reparse_attr);
 
 	iput(vi);
 	return dt_type;
-- 
2.43.0

