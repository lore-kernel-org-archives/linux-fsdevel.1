Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045333B47FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765602; cv=none; b=TcPz5uaNi/ComSvTKWg5G4xhrh3a2/9y4HYRGoz0OeiZQlFM+jYV0o74j8B46+3vA/zw7HgCOBvbaJ/QLGJ4zN9Ut8HZL+iD/ifVShN6mxz1BKjxB9J0F00dHDCmQWfRCj8gkPWBTkXsp3EB92KHjE8GRRq/FNhT6zfj0Md1PAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765602; c=relaxed/simple;
	bh=Nex3Wzzunb7UXMzbR7xgZt88xAYhrk1zgVSz4g82Hj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dWeGIhVXLsyAYUZVlTCuCKUym9iT2CmKxn4E0CtgG5e+nZSnAHEdWcm7Bxj+DLdrqQX4WBK0RetAZxkEiCSyW9dhkTHJdy2U0Zgf+UmaL2yofEcQYcnc27xggt2KU+bQ3y4ppRc8K1309tx1snq3jL6XGDcQXk9XS6CuX8UN6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f69a286dbso3167872b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 03:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765600; x=1777370400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85cXzQytwFHmpSCqAs3VMCmr28zB/NcpYs8dAHfANdg=;
        b=R7Z4oKjOhP9SR2j0LKtDtPGOomxnvpdykBD9XtsrljxB8eawMKenyFSwzA6RnhfpVU
         rCxHWqXTxZCEU5AgYjDcn2RVak3s9c5rkywI31C3RTm34AhsnWQMcmmm+Rcbg+n/AN88
         1lHcYx8Cf09vRfI0hsDTsDZpGa3SlXDtTdZpwDpJ85H8luYq0bUNuM5zr1pwyIa4gO6C
         /6nEADaAfXxyems8PZeKWVHghgvGG6uPiIjdCHgzIR0WNKFG5ab2PDNuYaNRKyemjrpk
         AK83/4c9fHhRzXUUWT2XWGyNgZ6ClK4oHtfZ0K5XAS7I7+pg4XQNQCDs778w3VfSiW5S
         j49w==
X-Gm-Message-State: AOJu0Yyp4aLsaAElAyn2r6yEbBu2m+Lc6bnbzrt6tGLiRC1v5T+03+c2
	DWkNoCgaN9HYEoe9TvSYvQL3GmHn3VIHooWqisOGTOAxjTBL7/VFi+6T
X-Gm-Gg: AeBDiev4Y9FSSTmqZjfIOzA+zAnw94Mjd2Ed15bVWjBpLD5We4duuGq63lms+Pgh4Sb
	42XvVphcxATXQ5bHc3aEdVPAFB63n83Z1dGFeFF44FbOQHAAoJOG8VKMjTeWAYNuYC/aOygh8cs
	oow6m0wXnGewrAiF7Q/+M4wuytUnW0E38YMHaTQH9FHxrA7b9Clc1T9pmd1sS01t+kjrXBUyrtU
	NX88IHHOf2uLvDLHXUxpto5dK2vU/Ky7Zng/ZrgMfASmK6GNyGy6dkptw1edDpcRieNrvdhQgho
	L8G9kn/aRLMV7z/prLOsL8peureD7jMv5jPnaxN9+fAMCpUE3314bJ1gMBa7iLTefAdr3pVuj1v
	DVFFzzl0+IVi6yM1cyMoKnKbBPKwmFPCaWWNbYoEC6EAnhByzAggputT1qXECAg0pVXzjtORIDm
	1wpU4xK3iU4AkpOR6TgoiEnxhDMATifQOWigPlYyx3DZS/FKe6
X-Received: by 2002:a05:6a00:1f09:b0:82f:3828:a009 with SMTP id d2e1a72fcca58-82f8c7dd504mr16999144b3a.3.1776765600223;
        Tue, 21 Apr 2026 03:00:00 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3f31sm16276662b3a.37.2026.04.21.02.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:59:59 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] ntfs: fix mmap_prepare writable check for shared mappings
Date: Tue, 21 Apr 2026 18:59:16 +0900
Message-Id: <20260421095916.6496-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus pointed out that checking only VMA_WRITE_BIT is incorrect.
Private writable mappings (MAP_PRIVATE) set VM_WRITE but do not
write back to the filesystem. Also, mappings that can become
writable via mprotect() (VM_MAYWRITE) must be handled.

Use vma_desc_test_all(VMA_SHARED_BIT, VMA_MAYWRITE_BIT) instead,
which matches what other filesystems do.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index f55f55d4ca9a..e0265a8825f2 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -650,7 +650,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	if (NInoCompressed(NTFS_I(inode)))
 		return -EOPNOTSUPP;
 
-	if (vma_desc_test(desc, VMA_WRITE_BIT)) {
+	if (vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT)) {
 		struct inode *inode = file_inode(file);
 		loff_t from, to;
 		int err;
-- 
2.25.1

