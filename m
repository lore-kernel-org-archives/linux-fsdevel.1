Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13F481235
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035608; cv=none; b=KMSDZIpdhvUB9elaWlNwPlkrQ6q1mB+MytEmPNxebEEF+qrQbV7scPSAAVxRWpn9wDB8G2ZOi0Cx/1JW1FTVE7eZdQPo2Sgkc5h6c6+nnZl5Cw2rp0b069Yr6DDbIE2CSt2l2HUdjO8oyIE9ZbtzflLI8yUDr9gg6t5fbRBiRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035608; c=relaxed/simple;
	bh=nwDfftK6tDKKFwsyIY1zmP/nNMRDmqL5O9HNMSOfLoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=karXQ5OpzfWHXG5dNTDdPUw454QptN1CYvJjUuac6/PsSMkFATwiOAeiv+B/ILfy3Bff2znyUd0xmVvKtn7HUz3HTLCxzUqqDFQUtER0Fhd12moKtxUEUI7yw+7oH+hxkvxic0AGBIyw3+tVo8z5Tfl48aFEBfJnwkJHLOF0Jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpJjo3Df; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpJjo3Df"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c38565e774so714141e0c.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035606; x=1786640406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOSQ52yeWBlRERTYkX4++c0c05H07NL60x8ILsT5aXA=;
        b=RpJjo3Df9WQveeK5T0fUBs9J7PtwKjP6ioFb1A9txPdlCDx0C30fHZz8SkCYXE9rXT
         vleecIQEGfHJtpZcIhsM7jqm+xVr0aCFNRX0/X7mSCfVkrSbunGL7BWRDx/0L6ovsFh/
         HFKnEh9dt5/H4ecILk9rfj+ElJQqahGBT9ILKccOnbElXJLsaHSwxQK7nH04BNmB3k2b
         GUQTrrMxcUEf5NSI1p9U3ogHsfCLme+6vl9l43I259uy7drmEHz+MromgdxrLR8PvIDK
         tlQY0/sUZa0iOnRQTEd/QScs8bSIGkMoHa3ICCftGpd1M2nEkyheJjM6zfH2Q2tfz1rO
         EZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035606; x=1786640406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOSQ52yeWBlRERTYkX4++c0c05H07NL60x8ILsT5aXA=;
        b=UtI2uTRinmSoSBFhkknyoAzYcOKU6wtOdKwyZNm7E9GCjDxMx9RHd3O1pYOTMcW6eG
         KZjw5ujPq0ik8toFTE/+gcFc0AIk4dvJwxfSMcEJ28eEVxHTJswBYZSdWjKsLga74K+d
         zRdlPmw/m9vJBSdsQQyrgtcvzw1zweftudlsjx8nO58aOMR4BL4obXxph4Lhi9GkE5CY
         imYf8CSmT1Jm7i/VnfruJjAD6HkU9zHaPV+XkNY+lR7Y9zdzpUoyRMNeEtP4TO7zmnoX
         Ont1il1v5p3uEC67CYHWlf6iMxx8Pd79Ru75oUwhsf2V7P+/rB2ZXWNC0HS7pRA+Spp6
         Yp1w==
X-Forwarded-Encrypted: i=1; AHgh+RrOqPhWVkyh7PIxvwkZzOiZVa1JbQY6E95FVUa0MF8YAsITnrB6F2UB5pjtNoCyd4egx15E1W9AZ9byNQjj@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBLBxFili5coqdYMRwweR7iBn+zG97ahaBw/x7dKdZG8fNdgJ
	VYHYiBfeRzBJWLzjhQ4w1s6RGn5Z9cuFXA1ahcx32Bvk+Z0ImoyJDPI2
X-Gm-Gg: AR+sD12vMmcFnDAD3mtdM7hCLAmm8D3jU2piygfZiXm79Qr5bsgNgK5QaMv3sCybnER
	PlRR5pdTo6j4NWKCA1pOqCjhFZmIiSB1QT5xrYlCfr0Lcg38R1QCQax6VM2aeE0Jjb1A1CK8AID
	lMneIIUeB+5jDafSepJblBhYEJBM24KKl5v0OqfGZsU0U8L3aHVXfllQH40yc2ONy2Jx7/vE7V5
	Kq8eSkcBt2+P2p76Xr8GEq9c6v4sF3I7QoBYgaJuVebMEzmEIK0Q7PS/2Y6XKzRAgXMcbfD+BDn
	Qvl98dx0nEqYKWIkbVEVE3NGC0N7DU6p8PpBID2zK4cNZbr2HqZR4DJLuXVgXEc/kzEZCNHJWI3
	x7z1oyRWEAtOgPe2+vXck/XLjOxQOCcGAL6+AjuUwEun9fnFDVkVtzbboIp/TPz1D/ERnJ4E5wK
	TEFPg7vFwsh2Chhf0eRT0KAlKk3FuZ3aLtMfgJ7rA/ADXIQYFF9lRGy5qiLF/lAb9ls9Te5OP3z
	h82EpE=
X-Received: by 2002:a05:6122:8f88:b0:5bf:b3a0:388c with SMTP id 71dfb90a1353d-5c3d91849cemr2185136e0c.6.1786035605840;
        Thu, 06 Aug 2026 10:00:05 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.10.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:00:05 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 18/21] jbd2: say what jbd2_freeze_jh_data()'s assertion is actually checking
Date: Thu,  6 Aug 2026 12:58:41 -0400
Message-ID: <713ffb9c0cdfe55499b3cdd2c06a59a2c152c46c.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assertion that the buffer about to be copied out is up to date is
correct and stays, but its message - "Possible IO failure" - describes what
a buffer that is not up to date used to mean rather than what is being
checked.

Once this series stops clearing BH_Uptodate on write error, that reading is
wrong twice over.  A failed write no longer makes a buffer not up to date,
and a buffer that does carry BH_Write_EIO is fine here: it still holds
valid data and the journal will write it again.  What the assertion is
really guarding is that there is something valid to copy at all.

Say that instead.

Suggested-by: Jan Kara <jack@suse.cz>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 5cc7d097b2ac..85d84d909f78 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -920,7 +920,7 @@ static void jbd2_freeze_jh_data(struct journal_head *jh)
 	char *source;
 	struct buffer_head *bh = jh2bh(jh);
 
-	J_EXPECT_JH(jh, buffer_uptodate(bh), "Possible IO failure.\n");
+	J_EXPECT_JH(jh, buffer_uptodate(bh), "Buffer not uptodate!\n");
 	source = kmap_local_folio(bh->b_folio, bh_offset(bh));
 	/* Fire data frozen trigger just before we copy the data */
 	jbd2_buffer_frozen_trigger(jh, source, jh->b_triggers);
-- 
2.43.0

