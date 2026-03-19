Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9D345CAA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962910; cv=none; b=CAg8WOynFB+IJYXz12V/YiZl77r8xeHL7ErQEBL2FoDWRCBt2ky1VHdz45aiSEDUOiSycs7pqKLC3bzUT4V/NffqdkllS5K21jFj9iU4BJc6Z7e/E2FrG/DLASRtHB3GN4lejxAdSluNU57nxKwv03DpRkMOn8coI2D4yOGHlbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962910; c=relaxed/simple;
	bh=RWPSrq0iveoOJKvr0MLwMT9ETGu0pPtPOzleo4aJxXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsWRgwvT7N3DwELT5DPLn5L9x0KKw4qzWmHvSDu77z7uVKxLj3UahW7KhIa3mfO1Sp86B65IkZAbqgLDwuwtgIhXpCLiXEJVHileCor7scZLqfp0J/PXa9MEWaWxNo5YMCC0g4bv8MYhkeP2HMEeDw1PiYdo8XhAFM9Y/L5Yeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUcruU+C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUcruU+C"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so1138775e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 16:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773962908; x=1774567708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ukH6iurOqmVqpAUSNgmGXdSqfeMmyiANM/nmwq1iOMo=;
        b=KUcruU+C4FWbNWVBm2aYgrHfDftRMTBpMFt2jFDoe8/o/6Z2reSuHuHnHlklFoGEBv
         vN2iMPOHeo/YFALHJrWBRasdg/A9Wu1t4BalUC5rCSLDicRxSLDGbOAuFN8panCbQRlz
         cqHNq4VLzeX7eeFimiac32EmGX147pIvrD6swnoZE9fzWxkbpjgbg/laRSsYzJOJmI2U
         egQl+CWQiH5ebAVOoyZODSY+PuC1itEREinL9iefdd3pQtdmBc9Kd3TaK/bUcqRg3NaH
         uHxoT2j2mZ/Eam4yKYmj8kMsJkUeo91mj/VJBnS5sad7N8PJiCw7FETXDRKjb1iU5tch
         /pzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962908; x=1774567708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukH6iurOqmVqpAUSNgmGXdSqfeMmyiANM/nmwq1iOMo=;
        b=a4wdUfEv/FSfGDiQPd3d7+FeztTjJvVUFp4uPBXrFykWVWSaYd73FxT4yjCJaYAP0x
         OzVquNXYniFtgOtPtGYeCZ3D7+hkiG11/VNsI6zoF6A3pSazPB4NUCoqeMWF6aUG+7qt
         O7AUPPYCoHfFY2ods5DHy+P5jlXfK+XeTTXL8olCthvbfk9EfIvb6uzRMNeFy9NHCa1z
         enJrh9GMYWhGC4UEKXSraoYSlfTF9ZwpLoAD9UoRnJ6sSMyF94SFqwNOU/y8ZalOqQA7
         FEy8yu3JbiPxQGAlgKceAB+crK6zJ47XxblsSIOIDe4eFkC77lOISwH3ds9xLPT9OhMb
         XsZw==
X-Forwarded-Encrypted: i=1; AJvYcCWRwjZWd8eVMPCHpvh70eJJa1GzqXtUv04AWIdJzpiNdNqjGUciC4WAn7qtE+WIA7Qlj+MHU1ktPIGOmd0J@vger.kernel.org
X-Gm-Message-State: AOJu0YzDv73qVYsXXhe+7JqGGEHOaTbDD+ZL5XrBmSAwRYLkMgnGqEhD
	lCD7jb5Y/ajFBhMaTELKgR4fBtXlfGVJxtbL9SJ9AVmIZJHE1cSCzFwW9VNrFQ==
X-Gm-Gg: ATEYQzyxnRL0GtFPl5ZaYknsra5RRdvQ7gepTEaYNYcXMDKfFk53Xh0Gu+J1MFlsWav
	xfn3hfXrRhhApx9VkolTQCfqCK8FTUUwfoFX/yZcYibVjJijvkCBnZxrZDJPAeZRG4gvQaB5dQ3
	nWCUCtJwVfzqYb3CKLjLjEgzAffe11iuBoDLcBlvhKjpbbYLl3TXZjvrKG6fwcrGeaq9CPmLYDB
	Uvz0IPDK6NMfRI50iyAw8nKx4JGMaarbDoGD7P7qxOpRS1J21vFRGPRHyiauZU7/ZPn27xUqXFp
	vw3fFYfblMWbJQDd6mNkVTkL3RwboEy/Gm5WTutO5wD1mUttEbK2EMJx3TlyPXMCIoo1ryoa/E6
	VmNJQ77PIAe5QKQTAyVgW2U/aK78bpeLBi9atUg24K73hnJBdHw2Mu6c54FFuz9OWOyFkNoTAAr
	3g7la7EjYdeXIHKgL1gfU=
X-Received: by 2002:a05:600c:524e:b0:485:3dfc:57a with SMTP id 5b1f17b1804b1-486ff020bc4mr14311315e9.32.1773962907672;
        Thu, 19 Mar 2026 16:28:27 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-486f8b1d03bsm83143705e9.4.2026.03.19.16.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 16:28:27 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: patches@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] init/initramfs.c: trivial fix: FSM -> Finite-state machine
Date: Thu, 19 Mar 2026 23:27:21 +0000
Message-ID: <20260319232721.452950-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FSM means "finite-state machine", but I think this is not obvious to
everyone.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 139baed06..d29fe0a5c 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -212,7 +212,7 @@ static void __init parse_header(char *s)
 	hdr_csum = parsed[12];
 }
 
-/* FSM */
+/* Finite-state machine */
 
 static __initdata enum state {
 	Start,

base-commit: a1d9d8e833781c44ab688708804ce35f20f3cbbd (mainline)
-- 
2.47.3

