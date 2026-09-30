Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6627463B64
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756399; cv=none; b=KdkgAcROdA2vMN63Sc2leSmn/x0FyzEfkZI+hDmwRDsoEMeKslP3G7dqpiwHNOLkjYApWNE79LDH0v9eEHFETb0FoRY+KdN40fMmq/EaKFNDap6gf65QnZ5EIfwjdmsLw9FY4NXIEjtVzFMOi3hgpsUKdnH7kc3ZYHx1Mnaet+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756399; c=relaxed/simple;
	bh=enU0N7uRFm+CiPQQfCZQiNG6I6dn5+gaY0icBM12JG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb1P6ACtmT5ufB90jllCc5fzns4eFFio9zxdERklTOKz9WmrUPaaCWhweQXtcwVUJFDBZw9OxKjCZAJXEp7o1yXKDkSVX7eRAifhydTmTauA+H/5QCn8ukine8yDSZTLQG66QUw/7Z5OcndlmLkKWUTXY/LDBqZbkWS5D9JaVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asMr0gWv; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asMr0gWv"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cc70890fso664677a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756392; x=1791361192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5r+yyKKy88D8/jouNE3+ZYHc7zwXUtNu9IJ40uPJuDQ=;
        b=asMr0gWvrTjdxI39gvU63MGsVsS8zzt/NXQAe5Ggx7HuJn8hMSIhI18zUm0fJlb8R5
         eTHYWOPiACH+SoRFUG6qwnl3biyF50pCxWsKoHGzf5YOr5wztF0K2Xu1ABJuSaBdtQwO
         e6fU0sPfju0cSxXMhqAhggK4yKc3CDE2TTOLNeHxM4Q0xtW1DRxWxPUio5BB6bCxJhbQ
         SEtDXM4oKizoPjao9i3Eam5S1/bkXEAgv6iGIaRfNf/B9oLkdzF2WfxfKmKlCd6nshej
         53okj1UGRonxBFk9p8xT+FYm+iy0RuZc/wRp9K8qciHNo/+0Czp6vLHfB1kQWN0E26Rh
         Biqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756392; x=1791361192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5r+yyKKy88D8/jouNE3+ZYHc7zwXUtNu9IJ40uPJuDQ=;
        b=dmIkqde9RmTxLwTYUxFBQxN+TUVqsGpamze2WG90j6hkrx+yvG2p6Oyu4kI5dNlQtS
         vili0F4MC5mk/UH/wsbXOl9O6v7zhZn0CNdi6JXAB2/Ql5wELltXxhlDwmbi7jlGDr0z
         shme2vJtP6cyJOzPnGckt0muF205auzQfdTnjF0OU6zeUimCF2UJ97pvXo2+6BELLgey
         K4hevpjjOODBtYaqW6/1QNlflI56V47yQHeidAVyMomXnqYg11+xf4rSJmraSWebMh6P
         Cd88cvCZFB++ZLjJev6I6j/xWNhXgnMM778lka5iGwK5k561HjASlkuz4n5OkuU5ZKJU
         sufg==
X-Gm-Message-State: AFuF++kqFqAFrmCDAse7FBXVDkJOtojRcBxGHz71kculmb74nWfuzlrx
	+9MLSbe0HJXyPLYw/6f361Sh+dBlx5ycMK91tILO0FZPG+vAGQYm06+Y
X-Gm-Gg: AYBFou2YHXRlQIm6Ebvgq1PKcd1BMW0NU5NFe5gYA31mENs1jWjK7RR/5ChdzgQYtMi
	R6EoeSCXR7iCJ7eoG6FVOFYrAvXj2oK1Nnh/2mZyWRro0PjxwmMeWsyU1hIID4uDMIpDEau4QyD
	iNnBvj06tBeu3bqBoV6dii/Sk2xfiSkZ0CVyseMJaIlWq+NKe+cQag2MOel1naqKNmbN4laNiLU
	A1T+u2MP5BB8og0pwME7Mx5qSSwZm0k36s9O5Q1q8pF0Us9vji6+L6cMx+fgBUNhSUv1VDo/ey+
	2Vous4nMxnHV9ZczDwIYyalFI1QvEo+ULbh65QWwXXEik4rewfjEDTMmSNZKRJ/ikjymtYqzZTM
	8rY4TawQQ1inBbsetkLAo2YFSnc0ToBu9QqVw+W7oIJZffdksCktmIU19FZ7nXvPt8zMPCEdVKf
	izttKoD2KQX4u5rcZUmdI0Nj0ziBkraYcBgVrYs3EIA/DHzhC7e4QncZJdbUIQz1gQ+S/hrlE+f
	2DiiIi/SP99LgDC92wOg/TCiegGgXG84TgGaGN04HrW50lEBTrsVm+pzacGOXrccy4pTyo762Zm
	lZypj/FbxQ==
X-Received: by 2002:a05:6a20:d791:b0:3de:2d39:b5fa with SMTP id adf61e73a8af0-3de9e6e5c96mr587085637.14.1790756392513;
        Wed, 30 Sep 2026 01:19:52 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:52 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 4/6] qnx6: clear sb_buf after brelse in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 08:19:45 +0000
Message-ID: <20260930081947.511613-5-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930081947.511613-1-benquike@gmail.com>
References: <20260930081947.511613-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), when superblock verification fails, brelse() is
called on unselected candidate superblocks, but their buffer pointers are
left set in local variables.

Defensively clear sb_buf pointers after calling brelse() in
qnx6_mmi_fill_super().

Fixes: 3377755f1064 ("qnx6: add support for MMI (MME) media filesystem variant")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v5:
- Updated commit description to clarify that clearing sb_buf pointers after
  brelse() is a defensive cleanup measure per Matthias Goergens.

 fs/qnx6/super_mmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index a8b512c09890..19f123d45678 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -102,9 +102,12 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	if (fs64_to_cpu(sbi, sb1->sb_serial) >=
 					fs64_to_cpu(sbi, sb2->sb_serial)) {
 		/* superblock #1 active */
 		sbi->sb_buf = bh1;
 		sbi->sb = sb1;
 		brelse(bh2);
+		bh2 = NULL;
 	} else {
 		/* superblock #2 active */
 		sbi->sb_buf = bh2;
 		sbi->sb = sb2;
 		brelse(bh1);
+		bh1 = NULL;
 	}
-- 
2.47.3
