Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7923D7F4
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778379199; cv=none; b=kkjSLTc+x3KroO0++kd330Ni0fcSSFGe4KLUQwsMA75YcPwwQihma2wuCIEMUvy8zCvOgkTxLAKg0bJsdrX8dMU4SICztwg1gWEqqYkrI/DZM8pe1Fn+qAglwpl65TfwRFgAt9Bkx4xYGR1UWLp1vlWPyKvoKPyDbzelTCog170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778379199; c=relaxed/simple;
	bh=yXheuGFy2qbjBy2ZCssglZXPh1JICTl/KL9JvoD65vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQAtEPbsF6TTSOtAdtC31BY3VpxlJT16usjV7UcYQJHQBFNMIRLobGT0mQiNbszu/3nRa+7MqqEYk0qRhzqJimUOnTwK3nnfHUaPl1VWWgzWPNO3q5J+YNiG7e85lyhnftDTVrmuKJI9QjX6M5yb3P6Y2StR6zBIrQEgT4uJEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn4dYpi6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn4dYpi6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b95a78a11dso5483925ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2026 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778379198; x=1778983998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orcsdW0I4eD4Fzyp6eZiaAfyMuG71YnoyR/PNIS2A3o=;
        b=Xn4dYpi6kHhDAqcty0unKFvaSDraH/hk0y5vi5F7GEzxc63PXjr6UezfLk3tGeSYW6
         bl32g+XeF2KLQTu8bV+mfH4t2yA+BlxKNOdrjAmwyh2dizyuSs0dZxUbc5xsum3E+hNd
         fp3Rj1w07mujxpYzPcR4JObctN2Micyac/3EKgvzTtZXobupQWlp5QPo9vUn98l7AV+a
         TPo58i8UseuF8leYsNwYSh9SgZLNywipxXJDQDlbWc6kM76ioRlLtzqCu07tELcor6s6
         Lm+RaD6jziyyVuV3H8YtEm6b7YnW37ecSR3V/Jux9fuLJ6ElTdpQkKnbrV41GcRy1Cqn
         G2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778379198; x=1778983998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orcsdW0I4eD4Fzyp6eZiaAfyMuG71YnoyR/PNIS2A3o=;
        b=FZx91Y3djGICohESF8npmiXpUcmMX+pjoiOpn6hPCssaOlLzqokCGLlKP17YLd0spw
         X5lOw2Y8D0NdUBD5TDSB7itrJWcGhwbf4rgW//FbqYMvzd3al+T2fcN7m2/JouEavtw4
         lq1nd7agh8K6xhA8qi9IjTYJJrvJgONNrBymDcY1CMvO6cTMSs1f+XUfQMZLd/ZLooTU
         kK+OlrzAViq46TDAovLdYUdZOzZ3bW6AM6XZZjAMcOn7ccRNk3B8YDKqutL+kl4YPoWK
         YCg457cStWo4ER/Y8N25QqSJM/U0wcozIGecWdnCQ3N1+SIbAm1Jix05bH6JRNzpjYf6
         Ydcw==
X-Forwarded-Encrypted: i=1; AFNElJ/onnbGNm3Dq4nsF+EvJWDXkPkRZ1FQSNAiXbbHSTl4pp+j+7Sea/8SZZG353UVqAfBdwV5jZze6/n+ACdK@vger.kernel.org
X-Gm-Message-State: AOJu0YzxInSP5pzATVF7bHj7RfV46JcHXMEe8NyYdjOIBBIzspinTi9S
	4SOq1A2JgDJZ3R+0F8FRdbi1S5/Hc12LTFOYCqP9zQ9whsXM4KCBghls
X-Gm-Gg: Acq92OEFxSKR74XWREOgrszcXcIYR7ETwNHaE4D5V5rzmdMEpjnTNM1BP1CI6vA+5Ud
	ZTEoQ+Jf4hWv2Kno78UaxEoaBGM8SpK4VpwheXnrKA1x6saFMNDWtNUrKgEhV/iPoAh6tnQVJah
	RGcblS3m1TOAXb9jBd0Imx5FKWi5/JEjeRXFpG1eKt2rgV/BYbkZZdp4T9hqkugIeiazsM3unMe
	CIX/3y0A9ID51EPsp008tw4PVG67UWRlqFrODDbWaJFkCAlMjyDCTMxfLv2bDLvz62Dfia4/s8c
	Ty8Q8dc1/ls2wU2zpiwMkXHr0uKFslDxddqgDxg4tRueYjRoGzcHBN2ZSGT4VEZrVXosevgb7hR
	vxw4iF7fqGyQY6HWbX0jUUefQM0MeWdjaymaCKHCo6IkxdP7ZtNXPZnbtQFHPtfQh0eZzkEKsO7
	fDtEhN2OdjIFM4uaBzA44u6jXfpS8=
X-Received: by 2002:a17:90b:48c4:b0:367:e244:4c43 with SMTP id 98e67ed59e1d1-367e24450b3mr1964505a91.5.1778379197657;
        Sat, 09 May 2026 19:13:17 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d65ed459sm4121295a91.14.2026.05.09.19.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 19:13:17 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] ntfs: fix empty_buf and ra lifetime bugs in ntfs_empty_logfile()
Date: Sun, 10 May 2026 11:13:11 +0900
Message-ID: <20260510021311.3995015-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_empty_logfile() has three related allocator bugs around the
@empty_buf and @ra buffers it uses inside the per-cluster loop.

When the loop encounters a runlist entry with LCN_RL_NOT_MAPPED, the
function kvfrees @empty_buf and goes to map_vcn to remap.  @empty_buf
is not cleared.  If ntfs_map_runlist_nolock() fails on re-entry,
control jumps to the err label which kvfrees @empty_buf a second time.

In the same branch, @ra is left allocated.  When the remap succeeds
the function falls through the @empty_buf re-allocation and the @ra
re-allocation, overwriting the previous @ra pointer and leaking it.

The success path frees @empty_buf with kfree() instead of kvfree().
kvzalloc() may fall back to vmalloc(), in which case kfree() does not
correctly release the memory.

A KASAN-enabled QEMU harness mirroring this control flow reports
"BUG: KASAN: double-free" when the second ntfs_map_runlist_nolock()
fails.

Clear both @empty_buf and @ra after the in-loop releases so the err
path is a no-op when the buffers have already been freed and so the
remap-success path does not leak the previous @ra.  Switch the success
path to kvfree() to match the @empty_buf allocator.

Fixes: 5218cd102aec ("ntfs: update misc operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/logfile.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index 2f960b8f8cde..5a09f2b05df5 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -768,6 +768,9 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 		if (unlikely(lcn == LCN_RL_NOT_MAPPED)) {
 			vcn = rl->vcn;
 			kvfree(empty_buf);
+			empty_buf = NULL;
+			kfree(ra);
+			ra = NULL;
 			goto map_vcn;
 		}
 		/* If this run is not valid abort with an error. */
@@ -821,7 +824,7 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 		} while (start < end);
 	} while ((++rl)->vcn < end_vcn);
 	up_write(&log_ni->runlist.lock);
-	kfree(empty_buf);
+	kvfree(empty_buf);
 	kfree(ra);
 	truncate_inode_pages(log_vi->i_mapping, 0);
 	/* Set the flag so we do not have to do it again on remount. */
--
2.34.1
