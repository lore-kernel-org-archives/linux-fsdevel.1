Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97555466B66
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756397; cv=none; b=BofcMkgbU0fVXEVkZrqB1IuDOHADb8wUGegtXVZOl7xm6iX9oEHfYzLAUvKHxBU4MmIFiXTT2Xq6j2+0YSDzZhFFtM+cnyaDaykd71qDiZ398sNOltyPlbnJiMy0C3a8/sVmBwrEp5C+RARQEGnFQYwXCzahxdL1j0Zd6DYO1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756397; c=relaxed/simple;
	bh=+y4xSMYmkh3bFalgboi6xyjy2Uegz5ftgAeqbMaePrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0GQ3sKBbMrWosiEL8Ej4UDvcXjWbayha0yfeOgEvj8YjRYcV53oVJbcQh8grsac2bsAzjbBE6vMFGxBzJqM3JjM4dnbAzYXXI5HybYupVm9YEMMsh0KiEFDM0TmHkCFGM201P6jOFGMwNUJr39nPBmF0EuI0Wdtwv9UMmxSiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gthhM9a5; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gthhM9a5"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0f64df6a6so1900004a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756391; x=1791361191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KtJOE7/gGMS3z1mCUhci+rV25ZYpqBSPOr5/pEn7pO4=;
        b=gthhM9a5ododqIOnLL2lCXP1x62HROLuzZliVC/3SbivvowTybghNJ9uz/QTiX4mEj
         ulc8yvJ8IkXxDJelDMGIFuKtxNZEWNoVSD+6TOKVS0pJuKoqLwyHHWMLsnkricZ4Mqup
         XP4UrHvBOVP0+oDIiTM8DITqh9evcvVd2tDgWiOp5Zt8mPhSsG4gmC00HjHvPCNgQP21
         S9Z1eLeS+is4asSaPkANL+RBpUIUA/Cj3DMhSr1uFjhI4i/uZOW3fPwCpgM+fwuxxBkV
         s2Jgqpr56voCG3V5/L3SHEkLSG/tLFvZg6c4vBUI17PmVtB7LXL+IajVFxvHsUZ4fD1t
         XsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756391; x=1791361191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KtJOE7/gGMS3z1mCUhci+rV25ZYpqBSPOr5/pEn7pO4=;
        b=x5ItSvmCAZ4gBzKfJt1gJiLGRQHJa+EY9RT1Qi8GGj7udz0v75Wqez/PPquRyAHyAt
         7hukgW9ELjjn8epddvjQmE6UigNh/5RwawvCJve7/bZbXv7Fp7g0xGQpQJJTBuq3ouDE
         yFuUSFiwiY4PHKWdgiJaWdCdjv/S/XVAG/F5A7xkM1M8SCBhSCsYFWvDds4UtcIgk3RY
         +ETiVOGEXylB2lvDoDS/gxGzgQGTqKc0/bpm0javjt0uZ9ZD+ZpNtNGDrXeOYNBQ23qr
         Ibc03QJjZQA5GrjKlzZxYBSBr/lHGaa47ApwY2Buk6QZmH9Y+IxYS0R7rNLuY8ObXSl1
         jlGw==
X-Gm-Message-State: AFq9FYJ0U/cUPp0eWylqET6hw4DVxc9HBT9QHykpe9+DqnJ44Fl2EA7i
	48aO/t9Q9gpBHkSFQLn4L2oB+7eJjCMjRRgevX+J64xRkntjbVokAjB/
X-Gm-Gg: AYBFou2cvJbPpU++W4WPM3B9xForIpGayJNoC29fmwCwb66NzFEmr/uj7tiSUa61cv/
	jyqWERxjWVJsRtAuFagGwIp3rcPBdtPzwetFJNQHG3dj7WjaJDQxU4dko9VxRmzzL3HjNHA1Tw0
	HJ0dpB/EyLa85qC3n8rGu+4Ifw9cC1+94/7UBt1xy9C7BNveBIgVcx78WziL4rVYRQUSH8GwFzH
	k9U1/MdqtvOsMOlEne46h7vZTpRXnpFfUyHHzZhebqMYQN+lgf36SeNPNSu1dJvPgKbHegXbNaI
	UJvI8P7AMlFcOPaIqcFZ4qC7mQvrKifV/n1A9uh/s3ARZdIk39fc2y5STzZ7Zr8w33a7CH3tOhG
	JgQSzK9Z/PfPxVUxkPd6vZE3WGU+1nuZwIEvuOOEHhGhu4khoP1xV1XZqqkfAm0JUMV7GCEwX+n
	lxw+ROftKybpxS5e7EdOxzpB0xqFhOxWf0LVMgnj8tU64dMypfZtUeTfRPQ5hS6/n6y3ZCKxgVr
	1PnaLGJXQ85iuYuBXycCQR8UR+DC90DIAr1q5OAvbwBPMh0irMPm33a+Hh1fF62RWF0u4fc9yVp
	1OnSB9a7ZnE=
X-Received: by 2002:a17:90b:3c47:b0:39e:6c6a:657e with SMTP id 98e67ed59e1d1-3a4d1984829mr624739a91.65.1790756391173;
        Wed, 30 Sep 2026 01:19:51 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:50 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 2/6] qnx6: release bh on error path in qnx6_block_map()
Date: Wed, 30 Sep 2026 08:19:43 +0000
Message-ID: <20260930081947.511613-3-benquike@gmail.com>
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

In qnx6_block_map(), when sb_bread() fails during indirect block tree
traversal, the function returns 0 without calling brelse(bh), leaking the
previously fetched buffer head bh.

Call brelse(bh) before returning 0 on error paths in qnx6_block_map().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 fs/qnx6/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index eb6b5dfbc599..3c880854c867 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -242,8 +242,10 @@ unsigned long qnx6_block_map(struct inode *inode, unsigned int iblock)
 
 		block = fs32_to_cpu(sbi, *ptr);
 		bh = sb_bread(inode->i_sb, block);
-		if (!bh)
+		if (!bh) {
+			brelse(bh);
 			return 0;
+		}
 	}
 
 	idx = (iblock >> (level * sbi->s_ptrbits)) & (sbi->s_ptrbits - 1);
-- 
2.47.3
