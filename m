Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918F3E7BD5
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395354; cv=none; b=BhueApGvJf2W7FWkqzahJOhhNBJl3DpzOgIGzCmBDKT+T1jGuxxZMrsCWYUfJ8q9C4/xFz2lIjIrs4107RSA18JK2mgoxpsdLUmPgn6poiCJWRJ7/LfwaoZZ+fP3LOSmpDKNd7V56K+NF1MnkSEJ7FyQHUR7gOJmlO4Hx5aKVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395354; c=relaxed/simple;
	bh=Ot+JttkXEMn9ntfD8PPddagGEyHdcXxGuWIo2KvS43c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TOrQjH3WFoD1JHjD4Ol+juY6J5s8d/cVlHq/lc93hFWMCx+1FV3Nt0Xof6TJC0aygOdjuz+y4qp+rzWMuTwrXWVqO+h8EBfc6ST6u/n3eTQUKn4rFKyGTtBKAUkL1kg6feKDKZQaPAIGz9UMudcZdIDvyYwtRAFyOeHbPIkrxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=LNqt9BLP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="LNqt9BLP"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3096652a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1791395350; x=1792000150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBM/xTPgPNVkXMLpWmbcVvy7h5tjvt2S2rOkYcHy1i8=;
        b=LNqt9BLPRTFOYpoLtUjCBQpSIyZ0mEX4rACP/vArx908M2VJOcJnGHmIPfNkKTI9e7
         N/XrRQGXtiy//rutDX+P1+XjviKIpGiDG7G9bAooVzneGCt5n6or5wqGhC2qQBMBb4hF
         2QhsKkKfAWIPNooJgBW81lNbDkuNIDgvO8l28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791395350; x=1792000150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBM/xTPgPNVkXMLpWmbcVvy7h5tjvt2S2rOkYcHy1i8=;
        b=anQhlH+8sbGnqcPzKnSWiEeelldPCJGwcZ/M+2PDUMv2z6XOhjJlPgTSHQ7pPDzvSo
         XyFjEUAtYCl+Prk/UmEgTQg0JG9/TLemyeFdIq7t9vyyZLPTo+BMRB9uMEnc7fqI92Cu
         ahcJHY/fzMJyonJV+qTuM6/z9LrdQ75rDDCaqJVu3CmwkWP08jvInA/aPpJcmDxJeJbr
         Aa2palZUPobXGdMOi15iudLQTo47y3DHym3vWakOjGM1s8tFGDWXH13YADnEs3VB0Wpy
         7mbEgE9vvPY9qd01VM5DeMNY85wq92ypL6rpA8XXLCKKcDRWkiabLXgZwC3Ez0kYjCYk
         Dsbw==
X-Gm-Message-State: AFq9FYL8CgIT6wJApQckzbv0yuFI2YsiBPaBD8La229zgK5dpp1BZr4f
	FbMw88mZlAUw3q8wAEcqn/lq1LdToN4SD+ZoO0NvmKN3YSmJ50QNAT10Nc+s6leUcnfmGF+tOv1
	SgLG+
X-Gm-Gg: AYBFou0Pv/UGEM8R+Y4EjU3y0dWOvsxiUNovrzjVtxCj5whvUMtFI4FKQAh/TuGUQ2g
	BE6f17+a2F9DeiZsrDo7xLM4/7iAfhYlHcJFvZrIn36II33uvVUp6T8QaX9FBm6gJvFpq4ojQ0s
	Qi9P+ZuFxTgOyp8hBrrowhhcvzTXfZVVPS6lSpFY1AqUgMRuwRNZRSSLpoHHRkyQaN/4A03KDjd
	lCS7BCF8p+9lTT82jEd0DPyiHMgRJmvAzPQdpQNnRPwRYHqbB0aEG8xysqL4osA03vEihpJ/VXc
	Lz5lkahjmi2/fSOLiu+Ggxe6/yeUaPYEEkkH43wr0BVD2mhJaIDLndYR/9DeHeTO1oQ9wcXgqa4
	w3Hz+IdeTrGpDT35KZVnoQCStWSqwJP8o3BbJ3Q4wNfO45LCxAucGfxjGvo57wHwwh/AelN8Cve
	ISPbyTcA/nC2jLmr3YkjY05F28nMIZxITu/5h2kDwvK4qu9CdvwvYmP+TZUlXyKl3nVAwrByE86
	6V3jNNvYQojMJl9BEg=
X-Received: by 2002:a17:90b:3d4b:b0:3a8:4b7:e8c9 with SMTP id 98e67ed59e1d1-3a8a1bd6d70mr2578183a91.59.1791395350211;
        Wed, 07 Oct 2026 10:49:10 -0700 (PDT)
Received: from kinako (softbank126208129055.bbtec.net. [126.208.129.55])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3aa0cbccea3sm430296a91.15.2026.10.07.10.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:49:08 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	thehajime@gmail.com,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] proc: nommu: Reduce useless includes
Date: Thu,  8 Oct 2026 02:48:45 +0900
Message-ID: <20261007174845.1320996-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file seems to have undergone refactoring without cleaning up
the unneeded includes so now includes a number of headers that
are no longer needed.

Clean up the includes to cover just what is needed.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
Spotted this while trying to work out something else.
Build + boot tested on m68k (68000) nommu.


 fs/proc/nommu.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/proc/nommu.c b/fs/proc/nommu.c
index c6e7ebc63756..b173c8e3887d 100644
--- a/fs/proc/nommu.c
+++ b/fs/proc/nommu.c
@@ -6,24 +6,10 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/time.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/mman.h>
-#include <linux/proc_fs.h>
 #include <linux/mm.h>
-#include <linux/mmzone.h>
-#include <linux/pagemap.h>
-#include <linux/swap.h>
-#include <linux/smp.h>
+#include <linux/proc_fs.h>
+#include <linux/rbtree.h>
 #include <linux/seq_file.h>
-#include <linux/hugetlb.h>
-#include <linux/vmalloc.h>
-#include <asm/tlb.h>
-#include <asm/div64.h>
-#include "internal.h"
 
 /*
  * display a single region to a sequenced file
-- 
2.53.0

