Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD433EBF33
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247960; cv=none; b=XFA30LhU/kzDk+MxjQP33OJvgsomW4R49osdy0Srd81SFrD2D1KNYatqZBkdQoMFuvS0xDNQQ0A4FJVh0EIIvRrRZsGltW2L9qJxAYZ3CmFuh4KJAiITvxdWx8JOR5eWfEQTKdVg+t3Wu+YxcVHK4RRxCX2dG3E5rHuaaQBZtzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247960; c=relaxed/simple;
	bh=HbOMvrveZ7GrPJvW/6bKtTuYOy45fOlbCFun/XxRkGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sI5krJv3X4JeCX6o2+t/Mu1TaIokaOylcq21ebk7VqX8cpW3h4q75MOsQ4DVmjjXchu/STiNIR8GZvoWLkLVsHauhz8oHm1EeIbm5Ubv1+urcQc917t1gaoZSbq7VL563bkVMROVHlC5IhPRfL+qP40KOsbPcEIJDicWpuJIvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B7XK3MVx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B7XK3MVx"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso19113595e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778247956; x=1778852756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6ZLFvL+lKydXpO4WILavVeDHicN0myZST2IZFNTkj0=;
        b=B7XK3MVx5C1MpciTIGMtCkRgLh+3KgzrNq0uKYjhUbj21r7to0uizFvQl8cuu4XnTH
         fIEz03UluZIwJ8i8oMgYPlzYRmEdv0hdEIY2OC4r4qF2PcyqmYUIx6iZk2n62XmExcpT
         Ac/S8qVdoTXufkggtRZRULSMlWDsG0sNbkZqs8j9L0SxmkWZTGhNsx980HhSYm7rwdFl
         TStkp7oNuDaZW4cppp+cPDXG/zzi6cRFqyH9Bjn3f+ccMOT9GJEuokaBOHWo22xNrani
         WpmQsdTSe+ZkE7I/v4zt99ADrAeNw6E076f93CYkBj41kY283Vc9UvqOlBC9RnpjLhnt
         Cbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247956; x=1778852756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6ZLFvL+lKydXpO4WILavVeDHicN0myZST2IZFNTkj0=;
        b=NS0aMFKmpq/9Puram97kV34TZ54ZQR5NI+u1qrGA2TVmFi2si/EIbmgHLj2639UT3m
         wh11BQeI2la3VIciEvJIympDfu7u+dQLQiT8cnBtEVkNnTulgXkH16Gd00wpmPVGYIxu
         LuQK7OiW4j2+IetAG3q548vQ9Gc6fLUkwv0mYkBPj/DcoESDxWBwyFEJXOBgLrvwl8L6
         xAsHY6vgzmI8lXRTS987ST4Q6kXgdvVDnqX9wRopRjmgRi26fA+aTObrVP0Pba90faty
         3QrRah6TT699192T7NbKBUKuYEKsS2WbiS7jpQzgXvpaXW+/0EgoJMudDLZRPuqn5iPU
         6NPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uwFp1BmOGS3xvuXkSxhvd4CdsHVWTE/l6CskNWD9ky6GIJlu+NHbYdpiitkiER3vLeBXZMCmpncIAoubX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7PMGyYLZ4TqDzuuTqHXTlra1B4ZNQahbr2d/SAmyiQVcvR+Zt
	plfuOVCWG3thNbf586EpGviJVBnb8WYHw3ip7lieFbXYT9VjBLHzitS2z8kWQRJnDiM=
X-Gm-Gg: AeBDieu1w9XuXOJbepmTU3gECuPUi/yV3zflM6M9M2eOHnhSUnpariY6GxS3MsFJTqw
	YeFwaVSRSv54itLno/I9snWJcCtk0DoNpSI+t43NwWEtXyu0ucz5mWah0Udwst5wgm1avrVDgmr
	0KoRfmoKJkE5EZh0bA0ZVcCnjId9GXSzLT6VoaTNP3N3O2jmLYlAxEdu3Yz3fp6S+Ij8Rcxs9Wp
	w++rhML+RNfo/M9G9H4ET/NS7/mj59pqlR/oc1l8cBdwNFB9upfRwM/fYkMQCIBoemxI6N18w4g
	lYYyMb8x22ISHHTG3hB37OcG/rcrabdzS43Aryci/rIpVr8gI1SiM6v5ecy1QPIm8eHVpysk8+N
	N69QZtrvqy5AuYI0FVcVuNOQ1XN+3CsZfng9Zswf1Ri83iUi1PK+0BZpgl+lGmXgR0Egr15xlCb
	nUlPXnFn5ub0N89DjgYnmz02v34hz2rdWHMy9LAedrAbGOuChj451PZMU2mg==
X-Received: by 2002:a05:600c:a118:b0:489:a4:e578 with SMTP id 5b1f17b1804b1-48e51f32870mr151383775e9.14.1778247956168;
        Fri, 08 May 2026 06:45:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1413csm178475e9.29.2026.05.08.06.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:45:55 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 5/6] fuse: dax: Move long delayed work on system_dfl_long_wq
Date: Fri,  8 May 2026 15:45:33 +0200
Message-ID: <20260508134541.282073-6-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508134541.282073-1-marco.crivellari@suse.com>
References: <20260508134541.282073-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/fuse/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index f6cf00a8938c..8b53625ac7ab 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -113,7 +113,7 @@ __kick_dmap_free_worker(struct fuse_conn_dax *fcd, unsigned long delay_ms)
 	free_threshold = max_t(unsigned long, fcd->nr_ranges * FUSE_DAX_RECLAIM_THRESHOLD / 100,
 			     1);
 	if (fcd->nr_free_ranges < free_threshold)
-		queue_delayed_work(system_long_wq, &fcd->free_work,
+		queue_delayed_work(system_dfl_long_wq, &fcd->free_work,
 				   msecs_to_jiffies(delay_ms));
 }
 
-- 
2.53.0

