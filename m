Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2283624C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095512; cv=none; b=paZE95s8SmjICTAtPSt/ZCwppE9jEiSZ1/Qh6HPp+NafmhUnc3VZpGNma9AYD4M0inGLYl8uLuTfhaIlQJ3o9xLmWSGdFpfvTd1FWZEVifKQ4AO1hr+x9woHgqOJ5kQ4EDsmiE7/VXXe4nFJQuMuzOrrJupWtQH9XI3AeHb+2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095512; c=relaxed/simple;
	bh=ptw36ihhOIzTsxqr1eMO0bzZoqrv11FTm8UZmCwLNM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNWykyQ60eaBUWzZxPLAGDLmkuBRHjlkNzJ44Xc2aQkNh9UdnDrCWSX6p/gu78VUMwHkyCU/Z/vf55yfSESDBEzLjX1dkJCMoz5vk4qPPibbxGQhqtX2gQTjMfuLR4Mw4wkUKtramewCuzprdjy55L3xzgF+qW3bx6M8GkgsGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0kTL+Z6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0kTL+Z6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490426d72f7so74542935e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 15:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780095510; x=1780700310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4iesyYDPlSTsntkLH8m0VqrZNjF44k6q6gTGsFUht8k=;
        b=o0kTL+Z6sqxqXFQG01iRrJV6mv14N7sBxVUKmybz/E//D4xrCEjaefhnVQxTCh4boz
         Lzd+vEQAcTbMeJuufCwKapHGGf9t16ZnbGGLkFHGdDeR7kssKb0FTQCVVSYzai+iLK5w
         YT4W3bp4bwf3dHrbKePwPHzY6k/Tl+69trIbqjwEzQeGhBpqynZz1dXdAtqElVEokO7/
         D9uqK954121Hzo+R04GJmzcIH8ogTd7vOeTOPG3sHCf8MDej2vXExmM6ym7EIQ6DfbXp
         GwHfUHeL8VQE01TQI9FtnLLa9VIAVijhUx6o1LfeFrJqw714ZqZwBifNT7AdI4wxpyp6
         0HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780095510; x=1780700310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iesyYDPlSTsntkLH8m0VqrZNjF44k6q6gTGsFUht8k=;
        b=hvEMqsNfmQOF7TBNyERGNO7wOVbwny7ayvfVcOOf1fhwQY2l6gY+j0n6YrfGGBPGYq
         eB+zSO1ZzQSrHvXhZxzYlK7xX51E0A5glTpEKH3ETYEJVBnSVUyOWY1JOs6+DHDpG/+p
         bhUvMzaN2qO8humFGp0mDp3cUWFVm/PmA2TGyVE3ySFxUBySibBfkQq4IkH0Kiu337Dd
         kB50VvzjucrgI0veNNHp0m+AL49eXW9sTDqU+m6KxOwWdNhlvVcKuO46xoO1oTaGsplv
         TXLeVGOFQHwTAB83y00wsTRllpSjOJWy0pVfUmthskSOWFsOa04Xw8p/ISUcQmkmhodB
         iAUg==
X-Gm-Message-State: AOJu0Yw99muLpwEGtUyrN5KBA3GAyERK5abzki//mYWgs2xvJxZuLULh
	ssgr/UePW1p9W3bawOXV0tN/YYDLJXp2dFluXaaU6iqUZsoOQtnRN8tzykiopw==
X-Gm-Gg: Acq92OG/mcSX5J18DomtLBMOwN7F15vjlfyv9l1qMtqV5b7w/eKn722pHVfK1yhpHOW
	xvHUTs0AnmPIr+EHkce92ZQSAPhA1dlkFnvPLhB8r4dcCt6vwuZExIWAMY5jMVSz+s4fjnrbmCw
	gRj5vnAuaaqtToNDXhslP0Kp8kYAqe/zwIaQLNU7RQWDmn6VjA2kZ9s+6NDPKlXvo9XrKlFbrbm
	HvSaEy6bK4T6kXV+09EH6/YHyQ4IR59B1dBISX6VOdPt9QzcbAW3xp+6I3LumoXIQBtmAHlAudf
	HYaEievU9Q/PQ0wKz2umPAXPglKRR4II7UP2aFV8DKOj5PNusY4nyejeCmtpDtB3OtXBBijcreB
	JffEtlUAN2eQsVzqRB9IKZBgfB1+t0x0A9PGsVVQzoZwESrUXxrI4z51EKS2kDFcyWCh+NAt/EM
	bltiPUP/gTvO96Jkb5B+d3g9TRkKnXQSmWdwkXGM5o
X-Received: by 2002:a05:600c:450d:b0:490:778:4fec with SMTP id 5b1f17b1804b1-490a2951a54mr22943045e9.33.1780095509756;
        Fri, 29 May 2026 15:58:29 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909cab7b00sm73451845e9.14.2026.05.29.15.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 15:58:29 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Cc: patches@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] include/linux/splice.h: trivial fix: declerations -> declarations
Date: Fri, 29 May 2026 22:58:13 +0000
Message-ID: <20260529225813.546405-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial fix: declerations -> declarations

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---

This patch is for VFS tree.

---
 include/linux/splice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/splice.h b/include/linux/splice.h
index 9dec4861d..8f6b17079 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Function declerations and data structures related to the splice
+ * Function declarations and data structures related to the splice
  * implementation.
  *
  * Copyright (C) 2007 Jens Axboe <jens.axboe@oracle.com>

base-commit: 9215e74f228f2b239f41271da9e5076ee3439d1b
-- 
2.47.3

