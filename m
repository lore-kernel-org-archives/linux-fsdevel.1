Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98329322C77
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781811023; cv=none; b=Uy5FcoO7PnYnKBXexFQf+o9OoceEORKALHGbD/9B+Ir8Dcys7HsfERXYGukOP47LoBFKzPS3d/Q/d3xD1ZdlWk37oVbZUQ/UVTd/XqabnLuXgvf/gKTFmMnoSB0nEwp9JYAmXzMK7McDWbW1sVlTnu57Yqt8yXoD/BHm9nyFy/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781811023; c=relaxed/simple;
	bh=6062KEYXG9Ua8ywfCsTvp5Rnx5jILh4QwpuyrMCkUzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RwUsWblTqD9tvMG7dDMtHwZ2V9XxaHnhXGa+sUT/vt8BqkJHzKdBh2z4RfNckcH8NpMYr7s6Q2aUMtWYTkcH+FD75a3wPLKDw9kDEWanez4gQImY5f3SgGEfgVUlWycEYP2I38Z1nlvz70MQqiUojDlEocXhzv5D4FAznzPh5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpO2RsV2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpO2RsV2"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37cae11ba85so1082359a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781811022; x=1782415822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSpakCMQqWha0zG0lRbxbxTI9L4OMyCd7rP275e0rXs=;
        b=kpO2RsV2sc1qlQoHvrNvbbgTNeypDLJwBMmnliQzrDwhS4uCDflbCjsuz03PrueKxn
         ydDySHRqekhJ3ZsfpIeF5rd/DJuAEaUoaIMaCGlJWTcc5mtHj5THpM3sdWETDfGZzOlC
         za2SHQfJGth/l1CFXWmNmRKJBgbhWg0W5S8cxgimtn6/f9U2UCajTaEbVyS9XGBKgfA2
         k0S7SABiZ3u/edKgceCm3cKBoJPUFxqe6WksBjcphJ/DiNeTg/Ux8OdPT2VDW8CS49Zz
         MFfCZ3sj336N9twad22UQo9FIaba0Qf1DEN0hXI4iKTvcl4pICYyntEHsVvLRPh3g/ex
         +10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781811022; x=1782415822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSpakCMQqWha0zG0lRbxbxTI9L4OMyCd7rP275e0rXs=;
        b=Pb4rUS5xfM25UDvKeKM+/+mgdI4tXpY/9Lorv7EgDnvMt+UAAC4iSKf6WaeTbTSyk+
         6bjy9WwNuR18+VmRVGKnOV4J8xo+j86OV5VhYGBB//pAUdznKIWz6ypmsjc5IL5YvMwN
         t+08TEFIUSugC4xnuX36/d6zyPltEQmojcJeEoECUhS1OPeaIPZLmV/AWr9LHCtpz0ga
         MTLkfTjJdWfSy1F8QnS+/w+/+xonK0lfQ1bptHCLxnctz83lvOuN4qveqtJb75pw+Vvp
         /MY05UCDr7Qv4ueBzvPjrcbZb5XLfFNf28REImr5f/Hbeig46qnpxus6GcfQlo22KBml
         nEEA==
X-Forwarded-Encrypted: i=1; AFNElJ9X15alXY/ODuw3mTD9YU0cd7MrnQP9Jh3IdFq8/yTijDKbspo7j+meh6dPgyBQ9wbJCQvfCJPjwfq7bxL4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxms2PxSMQtFlZMu14c4Pt5wQCV1m6msCG8K9dnI56Lbs225jvE
	uHBLCoor/mQSbeVmuHRvaqNfj9B6wGTLU2K0ydjJ4RUoia0KjFqO5BcJ
X-Gm-Gg: AfdE7cnkyBIWI2JeuiOkgxSUWFCTkXUEZzm5Br6cleNlFLggistl/CvNNQNRPPfeA3S
	41Foe5GP4mEGyjnxPwB/Op4AmPIXtYDKqsy9On7H27N9X3YPvvReS8KaR8LJvKYoeuSe6llKeAZ
	yf/VebTzprb6tgNC5g6XkNycA5FcWgdI7IJM+5Eu7peXPq/uSKvKOdini5qzjsMBmXo/PK6VqnH
	BXzMeRoiu328nVXjbnvVYTdpmZeL70WhTC0g9NWVu9UDfwxWpsiUtRaXlehX8Y1ChAmMRshPwwn
	xUILdS+nc+hhJAPA4IY5sj3nYao1hYnb9ayBe2++lRC4BudHNTjIQq+8cQ+JuUs7rTEZYnxK0mp
	QhPLGzwg1PdvAkXdmUO8nTv8vp/jal7KmzebtNQ6wpVjn1Kd0AiZMsIGEcoa27r4+zLdcxv4gVU
	+ifGbnS8r3SJROVT4ehqGw39JcITDx2ym0XA==
X-Received: by 2002:a17:90b:4a90:b0:36b:a0fa:ff96 with SMTP id 98e67ed59e1d1-37d160a0211mr682536a91.12.1781811022012;
        Thu, 18 Jun 2026 12:30:22 -0700 (PDT)
Received: from LAPTOP-TMVMP5FD.localdomain ([106.222.251.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1600975asm234774a91.0.2026.06.18.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:30:21 -0700 (PDT)
From: Keshav Verma <iganschel@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Keshav Verma <iganschel@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efs: fix direct extent lookup for indirect extents
Date: Fri, 19 Jun 2026 01:00:05 +0530
Message-Id: <20260618193005.3162-1-iganschel@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop that finds the direct extent containing an indirect extent used
cur < ibase as its condition. Since ibase starts at zero, the loop never
advances for normal non-negative cur values, so only the first direct
extent is considered.

Iterate over the direct extents and stop when cur falls within the range
covered by the current direct extent.

Signed-off-by: Keshav Verma <iganschel@gmail.com>
---
 fs/efs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 4b132729e638..16b5ee10e323 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -254,9 +254,14 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 		 *
 		 */
 		ibase = 0;
-		for(dirext = 0; cur < ibase && dirext < direxts; dirext++) {
-			ibase += in->extents[dirext].cooked.ex_length *
+		for (dirext = 0; dirext < direxts; dirext++) {
+			int entries = in->extents[dirext].cooked.ex_length *
 				(EFS_BLOCKSIZE / sizeof(efs_extent));
+
+			if (cur < ibase + entries)
+				break;
+
+			ibase += entries;
 		}
 
 		if (dirext == direxts) {
-- 
2.39.5

