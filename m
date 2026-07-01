Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A61F875A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864724; cv=none; b=ICe3Ld2ryqLI4gEMEWthvyztuRMEPPJKd3SepGJm380g8MOIettS60EamHlzYRS7OSWurfojR9ylabbPfx7FWXcgUNtLp84VHcbgryiK3zJAkHRwwsONhJa4MQmiqsT8b9ye3Oer3ITjq/nmAAAKVjiBVDP4mQiuV9eKG2akIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864724; c=relaxed/simple;
	bh=YSSocn/9Lzgta+zrc1Y3ogzo5RcF7lik+7d4HrX9T98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lnzkut9sAgZRLLUlvNlInNi9d0L+/deA7Hhk/+BXh+BQoV7jWVFZdiHXVyCYu/ObCL8s1kGaUnfMNG+8QTdQUJlZ0NQT75sM/D4ns5hf8vpLVmSp2xJp6+h5/BKVAcKHBKhfKETQb0LlZOkh4Rgc5Wa37yFw9cGqIpgyn9q12ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qntiyfn8; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qntiyfn8"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a18e363d52so35933eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864722; x=1783469522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zAJp8kY6IFFjt3pxCIPIq/VsrqKUfgyaUYuo526e7E=;
        b=Qntiyfn8IlLtRXapjn6bK46H9g08Hn4srIkUys0unppmQiOq2ANMa+39y5eWMTyhgH
         /rBfx0k79iLaPFD6DSRMpHGT63dO5RKcCKnECaZd2Oj+KMFeEMXSVGureJcA6kkpo6tC
         kzJ98huK/4du3DQfk87TFr9xhwOAaLYXGap7mzjT8ivFlsidVWAJJOgvQhVwePEdGDyv
         00AgJ6KTbce8fmZoXx0HtarJrAC29BUkTNa80B7rbklCY5ujksYOtu22a/TtFgyyg0tG
         p7aqmt8+YNFfrLYB2Sca8m4jMQCAh4uxfMv1ViC7jVsKpwDor5CBB8dJMzZgA6M0Kbnp
         /RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864722; x=1783469522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zAJp8kY6IFFjt3pxCIPIq/VsrqKUfgyaUYuo526e7E=;
        b=YaywM+OH0coYshRDygUiNhCgdKG/sRQNnYcT+MoKu9XVvHu5FFzuG/JbDZGrBnrRQR
         G51cuMtc+mJWGhMMPWP0A8Cxe8MG+MCoHu3lZFVZUoh/AP2KMEN5bWQ0FxNuaF2S110p
         3Bw1OfpwxaAIDP7pPOTy29ktseKbzLDLTJDBdfn1EHf+OTJkfbAVc67i6mYRx5xIKE7W
         xmKkboXUENR6QlF1zKAN8pls5FFxcxwwet/wYsc1vcnGj7JONvytu49jIFg4sMBt4/Mf
         5ZDfS2sBtJQN+U5x0BLcOTCmxIAP7w50a2pxnl0qb+9/EL4gtFplEQZHrzguhhMqO+r8
         8B0Q==
X-Forwarded-Encrypted: i=1; AFNElJ91+HQI/Wnu8w6LKPVZSbXccIDUklfhHi/zRdMcluMgmhaJtOqBwXO+c/XUa5v66tPp5XRFxirXD+e6s7aQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcPNLzOuHh/1r4EvXLrJKvv4qdjNwuKkXhOIoyipf2tLPDOjB
	RR1S6X6wCPE3H7Sb85jBckTctr9F3qO5uYxjzLmhj/0gk5FY0c7C+Hih
X-Gm-Gg: AfdE7cksBRHYUan9/VRe57VFR1pcHFOY36N2HvHWQtq9DdLWhSTpppTMb6t+62vn8Ob
	BR3f+WV5/ZZPV6cyBRDlL7m9NIoxRgPIeK1VKwr+b8JrpdJGTFAO15aH9r6AasEm9hTbkUzCkbf
	6u5b9jUsPyLpkn9mQQjbvEI1c15xOPsVavMlP2g8Y49oyWHonwzVHazfR2Ue0/VYCN+axc4x0Zj
	jrjMjLkb5AfpRg+wMS17vLQJzGwWQnnpiR0jMwNroXyGwGKtOqyl9T0XeaMOaLKl1ovdEQMebNS
	JP9pQG/G0hAaoKvMpViGDRUozxyTk35CEKslLsVGjsEiHiA8leL3FfQU5p1FaBvDUzwgoGbbyIo
	HDMyBLTfnEhFeyLNQLtozDZrKObY5feNNRpLa0QtTV+sIbqsPRCut/lCqYF8VOOvsGybbqikVYe
	CtxjTMFlEEx/m+dRZlT0EP0N/JUD2uC2JKNejMfkiMcY8F6gm3tak0dvQxPtVHbLI=
X-Received: by 2002:a05:6820:1c88:b0:6a1:11fa:1b37 with SMTP id 006d021491bc7-6a1921d5a31mr1953624eaf.25.1782864721828;
        Tue, 30 Jun 2026 17:12:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a188f77891sm3095730eaf.0.2026.06.30.17.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:12:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev (open list:GFS2 FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 12/18] gfs2: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:27 -0700
Message-ID: <20260701000949.1666714-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert gfs2 iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/gfs2/bmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44f78..6cb1d4513882 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1200,9 +1200,15 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static int gfs2_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, gfs2_iomap_begin,
+			     gfs2_iomap_end);
+}
+
 const struct iomap_ops gfs2_iomap_ops = {
-	.iomap_begin = gfs2_iomap_begin,
-	.iomap_end = gfs2_iomap_end,
+	.iomap_next = gfs2_iomap_next,
 };
 
 /**
-- 
2.52.0

