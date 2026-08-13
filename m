Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67733E7145
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613698; cv=none; b=R6BsXV/j8xvEAznb0j3OlorQrQ9rUfvRinG+ykbKoLZltEA2FpuOjq5hPFrVqaI8WEcTvv/zPlXrqnZNl8PLHozXxui+IkN2R2GP3ro7WB1oqSApCBRWsNB63I/s6qfCH7HyHff+HymGyK/1CLzg1r2dMW0H9ZzhSzrm2T+XwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613698; c=relaxed/simple;
	bh=RpFq5bvNZ6Mp5VTPVmjCfwd9kSsxsorK8e4J70YeCq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZeCXK7JPFJp7p7gGNJ/yXIPhSsGM7Ro9B0zVv3hzGRRyXbTyBSm0stTq0X4fI00LBhs3hluPTUpZb5MuzW2SfGrcrC2OnZ58zZ+1hkXEu649JrB3RMSizREhEtNXQ6+DFE2jJcdwWlX74n4LK81JH31ENC5HZk3mZDYLctdEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh7vOKd1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh7vOKd1"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso524112a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 02:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613691; x=1787218491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j03Rr9Xj0KIFsiK1s3+GX5WIC975IyhGT0N0gGndb3A=;
        b=Fh7vOKd1x3EFp/pKGeh/eiaJW469bJl3MGRxOD+cUzT4FRYsjoUrgKYk/0UiEKPpGa
         uQF7703tpcJF+21Pstkg7Atr1X+k2+2OdORFgyNXgH0Dqrxs+SBD5+zmIn72AhCA7Nym
         apMU1OtmK/C8qZhhbtxHXStrs6iCwYCGLOCDID9xc2+6h7Y9VDEzM4JbXj/l37RJ3U8i
         kNwS6PDnKJjGuCu7D3QteSFRpLi0QccUO4Jbq0coB5kAJ8mGpswPLBTDg1zhJz+zkWgv
         MVZWd/tPdlzonq42U0uT3EGnLkvPqVZE6acGqydwHe6EeVAL8ZVX1qkg1VDNkFRo2+tO
         BTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613691; x=1787218491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j03Rr9Xj0KIFsiK1s3+GX5WIC975IyhGT0N0gGndb3A=;
        b=Iab36ipS4qENlYvQ8w0LbqOdswP95nDS6aoDOX+ATqCJUDgqPeDFMCpki1fNeT2c/G
         g6pVvuKlFOvYv1sOy+Mr2WYkVzjJT/2fZweu3IDPaj7kv+QRBm99opalqpNirrfxXsrI
         /3tMg7wpG9TF5E59awQKPE/dG/0tM7YGHa8Ua1VFrgf87vJz7/D5+teNsSbIpXJmFtBy
         +KzxZkG43EDmcLJq3uaOgtPcSk1152XQuv2/pdpgdO4+RG6Ponal6hu2ZW/PyyyS61v6
         A6Hq/+/+fETEpcMTy820GJ3bNp/XR0LunuXeWJ8a4HmWZdZPlD7eYYhxVkeRjDS4dMa1
         rwEw==
X-Forwarded-Encrypted: i=1; AHgh+RrOZT1N5NcWWZciDITueq7n4DVXSIyvrDDyp1zrjCNSTyQgFVISmCZDIU2JmDodvWrknVwoYVYQMi73DgeB@vger.kernel.org
X-Gm-Message-State: AOJu0YxdgvhR5auHysUCxJKPZxKTa/17rLXk4M1w3fp0ruwkT38h6oog
	TtaDrqt/P7iJYxy5Mt2lUofPiKNrKquSKa6rRItmLswMyjXC6vekYG/LFRlzqfLLf60=
X-Gm-Gg: AR+sD13I5tjHGaSFv/egEviXFOxMRFNPn5p6ymRZeXJ4DiXQ2yPeG+rD3ccabYpykfn
	LCmSDwL4AOlaqsTgJMtVzD3/Jj1VGuvTRZrTQQ71QMC0vGKs3zJyQoe0LWwE1iW1VNBEzOgmdyP
	pj5fXGzY0ya753/KzbpHvbrioKEMj24cTbjz9I9VJN3hfyrx2wfE6lMjB0xQugsD8nuf7REO6U3
	nG038FwCmNWM+c+XfGWtSm8aJzl2WCypVFhRBtPOOdEy+xro0dXaEPNFUkcOHE8xCTMriSTrr5Q
	lwYZ1sM2/N8kbjRwKHpctV62o4W6fLLOA+n52OUNY2ucgsX1Q6OEchyZzSdWxNKOEAXzlNlcTRS
	MjTq9zMnf9/jY5vjMO3P/no693sWVVTBAgatIxX78Fyda46oVWcSItWzGMvvZ40YG1EtvOYTLxI
	G4HCXekxBgPRbaHtjNFPXiCgjzF/zfvj0PZnIrpNXYb9iKjOHt0BTUWRELoQ8SlS3f+pEQzTFUx
	XQaUMY648J8tA1Qzo2XBYs0puvXuFldvlxcmmZdYWA1UgZwloBmg9vS2m7SgchU01SkRjfrqix4
	Vg==
X-Received: by 2002:a17:90b:1651:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-3931e2a0d67mr4135221a91.15.1786613690882;
        Thu, 13 Aug 2026 02:34:50 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec002e857sm6852846eec.23.2026.08.13.02.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 02:34:50 -0700 (PDT)
From: Manush Prajwal <manushprajwal555@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] fs: fix comment typo in fs-writeback.c
Date: Thu, 13 Aug 2026 15:04:30 +0530
Message-ID: <20260813093431.410-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix "paramters" -> "parameters" in the foreign-inode-detection
comment above wb_wait_for_completion(). No functional change.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index fdb8766d27..e19a588c07 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -233,7 +233,7 @@ void wb_wait_for_completion(struct wb_completion *done)
  * Parameters for foreign inode detection, see wbc_detach_inode() to see
  * how they're used.
  *
- * These paramters are inherently heuristical as the detection target
+ * These parameters are inherently heuristical as the detection target
  * itself is fuzzy.  All we want to do is detaching an inode from the
  * current owner if it's being written to by some other cgroups too much.
  *
-- 
2.46.2.windows.1

