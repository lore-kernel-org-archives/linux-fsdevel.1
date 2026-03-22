Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEA3126CD
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774193554; cv=none; b=GvFvrCQ8yiNV6cijtBtAQRcWQ3JbiiCJbNTxN3hOTqKYP1CrmXs0pIKcNczbEbonXNiL/MykD42mXBvBfPAw3vkFVEyvqC+xcTOMeeZrzSipLMnvsHQ5ZmiXQTceBsRflZcDPqB5Y8cS9HDR5l6wn0Ic9+iLli3KDFBVuuQzguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774193554; c=relaxed/simple;
	bh=gv9oyNx6pyeqvDwgTzjxiCBkAz5mlYpU8WJBcJcZjeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6DVhWs8F2PmernY6j0GxzIss7VlT8t0XNxPrwZffJJSoCEmhAkyOfh3iBEdbH5Mle0C4XJ5DSkeCQIc2hMpH75AUwhB/6nYFtew/s2q+AjycxlJfRV67o/5oSH631flXYZkTs4Kb83lJERlpzL7sUI3y6UNrA0b5yPjrPIB1P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOEhPHU/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOEhPHU/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b07069e2efso19974105ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774193549; x=1774798349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcdM2Y6LD9+gjVSoi6TUi43KlgwqJueFrj2+qWM94jY=;
        b=WOEhPHU/x16Na0iM6koqpSg2QCmVXwSXyqYKEPoCA9X2H7RqFBuaQuJqZw5qVRowRE
         VJFFxOo5JusPlrEQCTFQX90cvMbsNGk3Ryq0ydPexpy86Lr9p+0G2piUX2NPSpLNnqbU
         tp5SpoAQEiFQsGr2jFMgtSLuNbgSX33acDo/+omFe7Y/Tix52PQtzb0vN3pJTw9y8lCy
         /9ZZA9VOng3aZGYmNu5/7jxlAJLCV0VAzDoJhYZb0B2nBpb6DLG/UFfKPfb/XehH7WEz
         C9SBzjNbDJKIsJGlV67jmS/z2OVkbXBV8Q+K9BtudyhpULY/B5wV83+41AwmvBk4AB7b
         WRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774193549; x=1774798349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcdM2Y6LD9+gjVSoi6TUi43KlgwqJueFrj2+qWM94jY=;
        b=Qk3yf+CgAGSqeGVaz4IaYia2dH+/y1TOhjT1+83VkL66Yr8s4fhGbiHTM6jLOtSqiP
         UZcfEXsxkRC1avEsygTphMGXTwgx1HDlE/ObHc+O7smF/OGQibfXlYdd5H3mQrFmpgd9
         CDH4uM4Ni+qTHKpeWBW+OVEK7ew+R98Nj8jt3gxTV7ldShhp7h2wYIKYy/LbwWHNBSfx
         KSY89T1KZ4ESybKNTJHrXH9cPzvHFB4Tn/8LSlBbAln8/CgwnGHDuUJYh4A3V6lC+fV6
         R+GBtXNDqV9ZN6kHii9pFjW7cIYXi3Y4L5nSzLEWdrhTc4Qh1tKdaShFFBz8i0kCny/g
         bWtA==
X-Forwarded-Encrypted: i=1; AJvYcCUCN8S+zQcPFm8lkiMLZWz7gtxvRi+1xkkwBpfhIVVcwalDg9e5uauEne4YeLNivGwD7duC1VJZha0fBbss@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Yl4+GyKwSs1+ANRE3nvs7jH+zgTiQmqD6G5nruwNFO92DSaj
	/82aDS8ZfNQCUwNXWKOSilMxaXvgyeHbh6p5M0kefDLeoQGy8RHv7dxj
X-Gm-Gg: ATEYQzwGwXXB9eqMf57sHxG1GpScJ3HqjuNzGzM9lU6cWOCmXrnNQeiApDUFf6tSgmw
	Aith1/V7byRPvBHXbpbWIXMWG5JKV0jrffytsyhF2pGDdpXs/m/xAo4MfcIm76Ffw3mGmewb0Zu
	MEjVoaSmT1/7G8i8wuobOY/06U61bR2l24mnm/+B+E/lkaOwlh1BcH/qvRyQb/5LKr8dyPL46qg
	9OVMHNQvqka5RUEzpG0XaeaMHpSM9HB2VMIU9TPuNpjeuR27GHIj+CwBjVX65LVneAJuFzpTw/Z
	6Pe20tt6HuxEW5ULfXctGosMMjUIWVXzqHJZTclvRc5l4YovMhQnVOGmbXI4+EXb7IEee4RihtS
	zb1CLnggI/P2gTa9U+pTPupgFTGz5hFGv1vnicEfC57kSmN0Wle4SAfG1ttc6mEuR9JEhSY5kW3
	kIogIiyILXtGQe9mg4498racc2Q+XY0e8qfg==
X-Received: by 2002:a17:902:e885:b0:2ae:5776:45f8 with SMTP id d9443c01a7336-2b0826d73dcmr98538385ad.3.1774193548680;
        Sun, 22 Mar 2026 08:32:28 -0700 (PDT)
Received: from yangwen.localdomain ([117.88.209.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b6dc8sm85302605ad.82.2026.03.22.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 08:32:28 -0700 (PDT)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH] exfat: fix passing zero to ERR_PTR() in exfat_mkdir()
Date: Sun, 22 Mar 2026 23:32:06 +0800
Message-ID: <20260322153206.218-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detected by Smatch.

namei.c:890 exfat_mkdir() warn:
	passing zero to 'ERR_PTR'

Signed-off-by: Yang Wen <anmuxixixi@gmail.com>
---
 fs/exfat/namei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 670116ae9ec8..2bfdece79b17 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -873,9 +873,10 @@ static struct dentry *exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	i_pos = exfat_make_i_pos(&info);
 	inode = exfat_build_inode(sb, &info, i_pos);
-	err = PTR_ERR_OR_ZERO(inode);
-	if (err)
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
 		goto unlock;
+	}
 
 	inode_inc_iversion(inode);
 	EXFAT_I(inode)->i_crtime = simple_inode_init_ts(inode);
@@ -886,7 +887,7 @@ static struct dentry *exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 unlock:
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
-	return ERR_PTR(err);
+	return err ? ERR_PTR(err) : NULL;
 }
 
 static int exfat_check_dir_empty(struct super_block *sb,
-- 
2.43.0

