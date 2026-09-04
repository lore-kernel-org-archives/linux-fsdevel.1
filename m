Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B2481672
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525561; cv=none; b=GHsasK6KVXC2jRyIz2ad+SqhRuWpSUZFyFASRVxz7x9XJuHVN7+Dp8lJeYZPmev+R3P15soNt4feD5bDN/rz7YCicxizB0VXiuWiXw6VqcLuqtbesrjeo/ffsLkUb7rFtUdIkaPZ3ZWunI2hXYVvKPiSmHDRbuUlX6B81ucGdtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525561; c=relaxed/simple;
	bh=a6xYloLLdYX0cAtqYS7RsAg6FM06w16G8wdbVf2OzwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2ExnwcjkOGYJkE1bOg2MmISnLPQcvCQIfnnR/UUq8QFDCc+ADKttFPD+ba/UPYQdNzlvVt9jD4poJO4gMxsatCdOqIfQf/k05agIZYm+a2kPD0rfm7zjA3c97DfVxIBReBueQmqga/xe/zsuHS/L/e/h1sgUCMmBg3LW5KQ48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAyw3+eA; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAyw3+eA"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ee37dc91f5so596990a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525558; x=1789130358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pdL21V6dT/0CedcIDLqVQ9Tv8x5UXBkXWpfky8wqTYA=;
        b=mAyw3+eALOe5FAwp7M4PLfUk4HRG7NsPU1XjSIorw9Crocb3lQRC+bTutwEDrte87c
         oggufXbSsrO86skKZPycGCXjwZp/WeidPeIHtrgjQT69LztFB5/sNwsdbLt8ZvHwlRni
         3Ig1rEyChizMZcjOqsGPP+rJ7UX2ZfDrkW2eGim5LkAbDM/egFiom+4aUK1XMHoW3wak
         2ElGEaCas9L5X9aP5l04O2K71klamNeYQsFFoqWLiVdIt6vz3Nx0AMtRdTjWWjqsNsAi
         9vpmAcPX7wAHCH5eFuABXol4WdmKOjiQW28mxOXkPbx7dLPTF1JLjN9aB9CVVZcR0kmP
         PEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525558; x=1789130358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pdL21V6dT/0CedcIDLqVQ9Tv8x5UXBkXWpfky8wqTYA=;
        b=m3XmjucAXURfeN+gMJ0LofPfPmNCmdT/336M+cg2kZCzgjQrmA89gb2NQ4cuoM6XQZ
         rVCm+NRCYGZvA8mfHSTQAeLTIZZiT994HFlo0MYMwWmjZsaz2PXpjkHwf4aFX4wKopj2
         nRrNq53+kDTMP2AQeCWVOoSqAXZKebAySP4VPK1R3F2FbnSauHApN8BIMXXDch8P3qKG
         0IjfVfRB/KURW2KNo32ASb9+xmTXt3w5nrbo6HbSELoDIpO6C3rGGLnnFJJgW3QYr7ww
         XSELIupT645Mw2RrHk+S/toQjmvoqJ4SEJJXB8Tdo5hw39IF1bkJ7+vXIkiTnB5tbjb+
         Ne2w==
X-Forwarded-Encrypted: i=1; AKwUvBxneBHDXAQhsX/6zB+XM113PPtp1bFQDu+jzMwuOAJ1wvCN46iird58TH4ueANH82v3Zf446Qzhr2G1U/QZ@vger.kernel.org
X-Gm-Message-State: AFuF++kyaHE799t6iRCpF3QSLnmws+KXrrraXwfG/eWpPRbOjZEPyQy1
	C1ZIWyCX2fBSqyIqpiXI2+TUeF7ZAP+ywt2U5dJt/J+6Zw28hAeSCA3v
X-Gm-Gg: AYBFou2XHL3/nOdvIOnt467cNMnoyKk/EHAujlUCRIXrpNo3aM3T5B4DYDDFudOCZ6V
	oe1Zmo3mrxez9zDV9X4lusQNdzfgaw39SLhA+Fv8JX5URJBWPSsyqLlDD/Jldm9RTP9DYhBRtJ/
	+5kYo+PnExlOG0rKcseV90bE0pZDrYHUVULDDA2GMf68QCcqfcwcBmi6zLGWjcuDcpkACPP3tmU
	uqzEoyAkSydG08DA6Of42mcONNwp/UOYkHB1hGsD6Oh8kz+5oGtBjQAC80L1zaWD92PFfXvXOlr
	EsTmHlQ/8emnq0uUwG+6NYM1W6gKTVAoyT4EY2ycus0eajb1q+4XPgXOcFGzhC6uhoVjSkRf3Yi
	YEINwRnykjXVkXmxmsgSKqWjiOmtAkjsFqIgL/6c3PVhN71yte2g5IcxEfwIGv0LJM9FpVx0tVU
	kd4RG8b44+x336RHENKSAbaaq5GUvi70fs60DDA0PyA9iuRUQAtexj6qYkNj+zOzVgZ546NLQld
	SnoXGepEZwEl5w=
X-Received: by 2002:a05:6820:991:b0:6b6:d425:53eb with SMTP id 006d021491bc7-6b6fd1cac0bmr3521457eaf.25.1788525558344;
        Fri, 04 Sep 2026 05:39:18 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm9867944eec.15.2026.09.04.05.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:39:18 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] isofs: fix repeated word 'in' in comment
Date: Fri,  4 Sep 2026 18:09:13 +0530
Message-ID: <20260904123914.583-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'in', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 fs/isofs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index f9869d62b850..9efd7a9082e3 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -90,7 +90,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 	/*
 	 * First block is special since it may be fractional.  We also wait for
 	 * it before grabbing the zlib mutex; odds are that the subsequent
-	 * blocks are going to come in in short order so we don't hold the zlib
+	 * blocks are going to come in short order so we don't hold the zlib
 	 * mutex longer than necessary.
 	 */
 
-- 
2.48.1

