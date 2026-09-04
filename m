Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2B46D541
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518315; cv=none; b=IQ+G32f78y69cjSTWJJsUOrUiB2lExAXhDIKZvJNR6aU3n2yFGiBZk2B4ldT9CXFGKYuBN/NlKqkI8HWTzce2orGStffxsiQ8pGAScrY4RmnNKzr8K/rPtlMUMZ8jNWQpmgKPqt58iPlc8vLv3k4fNUCggl3E0wKErjcqnnG8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518315; c=relaxed/simple;
	bh=SdRR4fcKxcRTFw9bfWJRp5SlS6dI7EoBJe2ABZ5ulMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASboay7ZZr/zPKWEvKFfLPuswMONRqToTkrMSEyyKDhJTRjJWdfNXKnYvmkuGJF4+IQ9uGgDlSw3HEIl601i4rDBT5GPOhLX0hqoS9IBaHGBquCajLC54n/jBt27lfw4hcCZ9j+H0y95MJvqe0jCrRpinBgvwbhehFGM+TD/H38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0Rj4d9A; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0Rj4d9A"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6efd73032so17037845ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518312; x=1789123112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1bp/UiAEsf0pmjXU3iYT4sNFD6WOY1SWoYTBFGtvNsk=;
        b=f0Rj4d9AVG/k3pJfxMZ8A5shyFt0rYzP0fcplpGcxxwFvgU8XWU+FDKvGCR+ZpsvjV
         GVzZriWdwnXkRr/oRDjXElamex0nPkYhJOy4q7iGtkLgwfhO44I5CM9nLAFpsXRNLWhL
         UCEWRizgCR18LdV8eArVKmfojPcQO+9IgeUngtBjvouMP3Z+l/7ORy8fU8szWKiWFa5j
         x9n9xE2si3BHSEnXsZTlVl9QXNnfZM22am/DAPaifsO2bbFAwpVqcT3N8coC+VO/bb2c
         99yJ4J7mU6ZMqgZWwEhQyQ++7IHZkzL4iGn9p+MIzYjAP/NpWNkpmz1xVH+Zz2T8djkb
         5Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518312; x=1789123112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1bp/UiAEsf0pmjXU3iYT4sNFD6WOY1SWoYTBFGtvNsk=;
        b=Lp8izFVe/+QaVTHKUjjIhqGZ2CHfvXLGxyyI2Dl2k6eTwr6Qt1s+dUEbnlJQzNEcx7
         eVLrP39onkYH9v/nKCWvI8fMvlBNhGun9Fgl0LpLHvWoKakWK5PgL64VzEPXwTRHa1Pv
         Sq0wIXbL3n6+HUrn5p9ZOONUDxSjRTrA9nEgtlPK+eIsNz7w4iC3sHuxOasVqGNgKeDT
         2FEbo8WG27bSHGrEM2rpcrpNHYFxq3MQRMI6d1nT0bvgYAbiQXzVgB10PfR9Q0HK2ZpF
         tUc9r8/VQ6XJ6QVZMoscU/h4rxDdZrBalSBWIWAfzwZg1ujcR0Pxryw/B5A8+v6SmbOH
         nFXA==
X-Forwarded-Encrypted: i=1; AKwUvBxaRgtlL2j06cEqko5Nmvl5vx3j7k05NTcsW8ZZaVU1RbD9YFcdpYR6jpaYl/K9ayBVr3C2vhlGk0+rw7td@vger.kernel.org
X-Gm-Message-State: AFuF++nD2nvr2hFIqWnk0gRQxxcZ7Xi60ykkZWM0q4y8+3ktzUdLjVbH
	RD0MelEU5j0IpOY658tQx3i58Dr4O5ek4GLtoA+6nLp6GhUAAC6xDdAh
X-Gm-Gg: AYBFou0igWHFzk25lVPQRK4vvvQ7FDtsW+YiunmR3rdCgL0+/2pLG1wt+EP9hOK2UUC
	bQUBREwrUtnzT+08Py6hvdhlT+vmiAs1xUuSWSnL/Wb0Jb6QvfszxiKyYnpRTuT6C/eOHtoglT6
	yitkmFzyhOIHjPtNKIhiFh3PxvmRx4UMTWgOAqn3BTprV5TXnudjGca1TxaLemDSnHnH1Ibd9CZ
	qIa0AQjlrOtgt9uz0ly0t5PPDXMItpjNUhQcSDBVVKdvhkB2/pybnBRxTYPZMQkonfPgDrh5k9/
	D3idqALw1C5XOsrWLaqR7oY5S+Ktm496KjdmK2jgVWel9/VqY56FivgjI5TLnOe4cG5wCwQt+rI
	DDrGiIA1GNmjMIQmHFVDCS5gqCvLgx2AuV9uD560rE0XdPsxsOGqQPngCZC1+fIMOgvjjX1UoPh
	yYDVaE6mzOnyV06m94VQcoyXDs0n0OYHAKKQAqi6pDm/Vvbch4bJvDWSVw18KVE3MyKKB+RRypM
	Dk25qskDr7fwaOhqswZwC52xVM=
X-Received: by 2002:a17:90a:7784:b0:39b:2b1f:4511 with SMTP id 98e67ed59e1d1-39b2b1f52c4mr2665889a91.26.1788518312101;
        Fri, 04 Sep 2026 03:38:32 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm6021835eec.12.2026.09.04.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:38:31 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] iomap: fix typo "metdata" in comment
Date: Fri,  4 Sep 2026 16:08:22 +0530
Message-ID: <20260904103825.8752-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904103825.8752-1-hemanth.selam@gmail.com>
References: <20260904103825.8752-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "metdata" to "metadata", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8b4039d16ce8..b70f86292049 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -505,7 +505,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		 * We can only do inline completion for pure overwrites that
 		 * don't require additional I/O at completion time.
 		 *
-		 * This rules out writes that need zeroing or metdata updates to
+		 * This rules out writes that need zeroing or metadata updates to
 		 * convert unwritten or shared extents.
 		 *
 		 * Writes that extend i_size are also not supported, but this is
-- 
2.48.1

