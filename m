Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BA284883
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049162; cv=none; b=nTpV+2CVAT4G+C482Fg463q/9mSNS3ooRYM/m3byreO2wNWq+WzSXjddRJNEyv4PlZKwAniZmHIJPZcyRAbzjVpUJjQIk0Ss3ssZAZyCJRF0Af4OUon8R4S94DDSlAf0vaGsfesLLsFDbnI/t+NdsptqNCfgV9jg9v5mvz7xBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049162; c=relaxed/simple;
	bh=RRRF7vUdRVX3It/87SWufeaBi4pGcXK0reUgYghnh00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSlEe3PF+//q0+ON+17Ka9Mnf2wtnaiwzZEShHSnYb93+g2Tw/9GOWRNl7GBeaixF0m6IFTFPYJNTzhxblpRZ6iX4Z9Wmf9F3kdxyOAdJgv4jXjDdFu4o8mzPLlSBttUAjnoFNfr82/75bF8jpngncRWTBm4Kj29WlpqqXNrVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa8CqWcz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa8CqWcz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so84673325e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775049159; x=1775653959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKC20RkzVp/F3KKKbFD0g5AfRNscmoGwdUm1uE6/jTA=;
        b=Aa8CqWcz30y6QMRCWs0JqL2+zsFv3RRGvQq4mkR9HsXPbZNL4np4oHRyQqzm/vRTGm
         ycMmUAEI3brJZA/ISRtaj6AGxX/zC36Lu+ZCdlq1vmUwy/Y3gpnGGZzzhbvfEiGDfdci
         X1xAZ18dFVUFGDpWyfezeQkbrgeheB0pGUZs078n1QNTOjeH2A0NOau80zqc6d61wTV1
         XtOsr+Rwac9EeAzUcKzkhs3hNVaazBDbNYb2ZcHVEYLph+dSN72J4772scC8grYttkR5
         p/G7Dr2l/yiyuFylTIVQMl2g1ZOUlzq/snK6KN7hjO8OunwnJ2vR0wASgCeXR7tV1tWb
         yR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775049159; x=1775653959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKC20RkzVp/F3KKKbFD0g5AfRNscmoGwdUm1uE6/jTA=;
        b=D6pxFLYOV7zYNTmyKevtipNN1yu6APiyaT4D7ZcSevhcIDtRRqf+60U+2zLaS+T3Qz
         tWylG8yxDA6xSNJGmT6ZxqO/rcXFFtiOphpGWWd1El1g14WmCb1JOkdhgXyD7rzDKfht
         iTMlEwL2DhOt7Y0H/JM71r4LDklrWDPAOn8W2duPOhpLZ1XP8phM/HAXG/5cnYCiQUdM
         qrAVCqxsYS9HLHqoRno+rG0EuzfgLqN2luLVZb11tQFAcXN9MPhjiQHRAYYWq9pUcay+
         0F/G80Pc+88ATQkrpXw43l+f5wDY0nH1iV3r3QGiyXZLVqXgsmQnxqskJbFqxwPKv8m7
         NHfw==
X-Forwarded-Encrypted: i=1; AJvYcCXC6m2pI0U0fUCYsgdOKUH0okGs/ih6cYclMAGRoQqNdU1fGPZy1xl39ybeMgfxnxZxMYFOjPuI4WRzxcvJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ZMqBX0Wplb9FWBNgM1EWdLo+12nVjy+Lq17kekAk6EcHtLjA
	cpm3E0YLYI08R7Fmy+QQpd/tC/5z/tRlWa2EvN0mEYfcC+e4OgSNlpn1
X-Gm-Gg: ATEYQzypX1FO30gRg12Beo5NwMOuOEpFKShX1IsJAnrp0dDoMZKyOea6urpLsA5mR+8
	PGYrqjMkOzDH+Gj2Hgdkidb2Njei5FM+0z4dJye6ya2KqtdJd9BVpfwtKJ/6TnThHHQ/HUs7whs
	B+Uk6Lv0Ua17lPtOtVdvB7tXQiuFAQwNwb1pEzbnW6Y/Rmeta9pgHW01EeBJYoKqW6Uah56Eidr
	KzMiSbab8eCSzCyyrbLqFBRA+NdVAM0Ma0L5Uvt87TwqBwFyEopLGNET+j1WqZ1dcr9ViEephL3
	BeN4QTMefA7fOltB3gyKcXv/w4Bj7Nv+8OqSwyykqj3/cdRlBkysnBIJWDC3HIGho2aJ2ZHpF8K
	0PWW2Nv6p4n9hbzd1W9xfQo74m5NurK3mv1NPSnaiL6ufV/XBeAjf1TaUhvZZDvX1GBdwGnw2qW
	8qSZhb2Dz/4nmg9XUVnOyAsdEjz1ZRzOa04DxXDYQTgmt8DpeG3PsjePzT1zYPqhZ8dPlxAYP3z
	aPSiRTW5olQ
X-Received: by 2002:a05:600c:1d1f:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-4888359ade9mr63672705e9.30.1775049159247;
        Wed, 01 Apr 2026 06:12:39 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80140esm113201665e9.4.2026.04.01.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:12:38 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] execve: block Emacs binaries
Date: Wed,  1 Apr 2026 15:12:26 +0200
Message-ID: <20260401131226.4011156-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No justification needed.

A new errno is introduced to indicate what happened.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/exec.c                        | 16 ++++++++++++++++
 include/uapi/asm-generic/errno.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 9ea3a775d51e..2e954b31e3a2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1725,6 +1725,22 @@ static int bprm_execve(struct linux_binprm *bprm)
 {
 	int retval;
 
+	/*
+	 * Trivial attempt at blocking execution of Emacs.
+	 *
+	 * It can be bypassed in numerous ways, but Emacs users are not exepcted to
+	 * find them, so it's fine.
+	 *
+	 * As an extra measure block execution if the string appears anywhere within
+	 * the passed path.
+	 */
+	if (strstr(bprm->filename, "emacs")) {
+		/*
+		 * Disgusting!
+		 */
+		return -EMACS;
+	}
+
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
 		return retval;
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..1a8fda40cd8a 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define EMACS		134	/* Editor too big */
+
 #endif
-- 
2.48.1

