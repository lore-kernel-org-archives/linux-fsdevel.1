Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E98313293
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863288; cv=none; b=KnTeXchkdDdUvx0fnyGjOKzLJnjD+vqLIznMnu925M31gsd+QWRpQ0Mtdbg3/JOkXb8TsbwBK5q4DEA1mstYd+zJbNDXR/HefZwGMaq+ZTjrCVdVJXNCdh4/BlhI+QiAZLuQ5zATcc1sF8OfOrMWX/F+66UGZ/LPWNe3bwhzXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863288; c=relaxed/simple;
	bh=SRX9mHeiwzKQkz+Dne4S1XGxWnRHLWPmixGyWmOgWHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gEPsx3mRZ/iipR/PzPgO7zY6mFaFnXx3Jytc0bsHEMD0ricq2bbpyxOp2SZtXFtJ+rDt759+SEUygvpcXlEe5P6vlSAOQWYeNGwWDX0AKptUrtxj/DbSTe/i8+0QpQXGZgk+g3WyBE9STfyIZad7FhEIhmCQkoUEppLxjTlmqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5BLVyLp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5BLVyLp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso3048522a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783863286; x=1784468086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tonu3RNgJXI3ufg6NmZZ2X740hE2BOXsOBfoXwm3l2o=;
        b=Y5BLVyLpCe3FWU+m5Puu2d4wZnCN88Bg4qxy/xe4Jt+TiN/FfuH/18v19cprU6oeD+
         4QLamw7gls/3RQ2vh6J8pdbQm88bci4KVRk7t0Q6AgW8ANfFqjfqiCWJwK8WGT2Ed7YR
         9hsqeYeZRDjZTUKBAIVGFQwPFaGolvLHifQOdyqRpkkphaJvg20g8bB3ZDFhh6FZ2qNG
         1McjxYLTiHp0Hbie6t20votvTek5iQjLC444GDBSooaUDQBOWxEyM90S4d+8cbfaSDLY
         lHIX8Bv8Ti9WgUqoIZdHnj4+2qv9PnOvwacLGVzIXEPBHV/k7ImePShgZKY2WUzken+k
         +3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783863286; x=1784468086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tonu3RNgJXI3ufg6NmZZ2X740hE2BOXsOBfoXwm3l2o=;
        b=K+GSJ7T83iyamS714CUV3AxBsvilTu6lwXn9fyK/tg1Mkd53LCkm9hqcuQE9731rEg
         R1nZw1TIUnsQwDAsatusXP8aCOQKa85QlP6jtlyjvD4pMxzcmatvnr0c1FmUgK2fFF5v
         K+UAlR84/ofB8zU2g5x74PeBU7TH8ACP+/kEVC5ljaNk3/4es035UMgKhYs4QLSqxHwG
         48lPyroLbIOaNZvRAZeGD6g0JS4XVAWrF1hDg89rkkkpxqhuTYSD2M4cWwW3KUjdpYLh
         +eMISXrXowhMO34/pTQSv8OnXG26EhnfOSBpKE66yiPdbT9/d7Us6/h536UBii0ZpJEz
         PA0g==
X-Forwarded-Encrypted: i=1; AHgh+RpOuKtruhoYGlqYPo44tTKBENq9RSPKS2Yd3LnpPefgOuw9O2AGo4eWnFn+7zmNV+9p3Y7Gs3l16idhCi/N@vger.kernel.org
X-Gm-Message-State: AOJu0YwzVQtFRrNK45QNVJEJYEgzJKnMVMUSdb+LwyoKH2UBXWMhIgRa
	COzB/at56IL5xV88Zoofjpph6aZnnNcyHyjskWenGrQop1Vkhar93ylVZBNM+rlH
X-Gm-Gg: AfdE7cmufVg9tT+omkuYTNOJZwBJpec6nWg7cTYnFREzDbiYCmm4aLhr7PWCrWS3vKr
	Tlq7r6hxTj4tzikYFmvY4nnsTrUnpofYrnu3IxB/K3vY47AKHitjsrOkYVCq4bHrE0q2+RVvGoC
	4exaJ6C67nQlXGNRQiPoUAvusCc46TdotzEh5rIgQMFyWWnySKVM3goPlcQ7Y/qKGyy94lEY14W
	4vudcFnmHYrQmF7qXmI/Tyr2sf9hgGEot242BWBQhzMQvdraGSd5pL2/f2MI/p5fHctsZwxnHtB
	ZYVgfYweB6NX9FrXHW6tfPSw22eOrzXzsq8ANPbS3suyHCVqji2OZrz5OjDNZi1xB8RnGPAZwyB
	9WCusyNUb0g/so1OyeWt3lG88pQhhyGyLHM2xP5zt12fjV+yvB06UVandbE+hIfX4izXq6kUFx5
	ApicKJ2c8wzLhSTGn9l+WaV/NT7pRyj5CO3F0HHNZ9JnNFK02VtF9z4bwXz5d9i2+lfh8g
X-Received: by 2002:a17:90b:2641:b0:387:e0db:3fab with SMTP id 98e67ed59e1d1-38dc7776ec1mr5836853a91.36.1783863286514;
        Sun, 12 Jul 2026 06:34:46 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b9ca880fsm19813101eec.23.2026.07.12.06.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 06:34:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] fs/ntfs3: do not mark frame pages uptodate on read error
Date: Sun, 12 Jul 2026 06:34:26 -0700
Message-ID: <20260712133427.435377-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ni_read_frame() ends with a loop that marks every page of a compressed
frame uptodate regardless of whether the read succeeded:

	out:
		for (i = 0; i < pages_per_frame; i++) {
			pg = pages[i];
			SetPageUptodate(pg);
		}

Non-critical frame pages come from __filemap_get_folio(FGP_CREAT) and are
not zeroed. On an error path that reaches out: before frame_mem is
written, these pages keep uninitialized page-allocator contents but are
still marked uptodate. A later read() is then served from the page cache
and returns that stale kernel memory to user space.

For an unprivileged user mounting a crafted NTFS image this is a
repeatable kernel memory disclosure.

Mark the pages uptodate only on success; on error leave them !uptodate so
the read path re-reads them or reports the error.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 fs/ntfs3/frecord.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 2d2644d80017..862baafb80e3 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2467,7 +2467,8 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 out:
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
-		SetPageUptodate(pg);
+		if (!err)
+			SetPageUptodate(pg);
 	}
 
 	return err;
-- 
2.43.0

