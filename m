Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C733D506
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247960; cv=none; b=sQPf9BAvGrRceVtvVZqfIVA38PRYyhFgLIDqNItN71Xhh8/m9Ag2IcLM+rIbnBur0UQ+q2URJVGKj/6FKI8LGMzmb/pBbPTtqV5blK6y+fKUF15jc9VCXL0XLUrnQLIp3JarbS+yY9I2MpzNbMh8C5ks+y9KqFcx5aDSq1WMZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247960; c=relaxed/simple;
	bh=e07i2YK+wbCvnsqjMsY+gV2EkbscFGBLAuO1j2g14YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwKcOeMIbgNET2Wuri8JiVUG8l+sQVxVJZb2I1fUpqdH2LN5uB4BwxT+LYiQcSJULo7+dnI5M4BM8yBagrm/7kAByZDjDhU9egzj2pHyrkEz6N04twseQkWY3i1m5Qhi1UdHh87OWFkYEIVGUB42PVDA//VtfGXMkoOrTwvs13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KrkjfKdh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KrkjfKdh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so18162805e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778247955; x=1778852755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFoAeBaNo/DLG3eJWZHalYi3P9xH8JB229vRyRrtX+0=;
        b=KrkjfKdhjRuQ+QH+1nu8lYzO1s+XyIJevDxpjnrDyuySJQzqxEixtlhG7AtMLkzLwg
         CXyV+so40lHhr10yIQIRWlEXYboMlRvqtMVWyQgI6sAb4RurBjLQ6mh48Cfs3GsvFH54
         9hl7Hp/A8eNTJ7ZBjtdmG4ySpmIAMFwTwM46AabDpaA3NxFZwUFaK882VhbQgcloP0Jv
         QZN+/JAmhHztwcs5DVnHIrgZXjFG1KEs1J29ln5SClzVDGw7ApzlX6JcCvXpNNPKmemG
         +sIcmt91guNafO70Z7y0DwMUdnLrecwHkCn7qC1Ebm5RF/HvtuCJH1GWSJOUX5dgBy4o
         OzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247955; x=1778852755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFoAeBaNo/DLG3eJWZHalYi3P9xH8JB229vRyRrtX+0=;
        b=cY4lSeKR0iRmmeo6Ri7kVrTr2HviZw33b7XSc0VdMIwgRlej0i6Il7rsf4B8G/VnCw
         F+H0f0X5LJeJVCvLtn2b2/qwya4I/QHMqg7l3tMqWKPKOugHE33ax/NVfSmovW+cyCKW
         2X54RF1z/WlwgGeIGT+WYsFYPTXLZCmFKF8ZRqHkUXNBsjLjU+kSg44Ys64ZepmGvoYl
         /Oja3HaknSKA+Wso2KbYn4FNU8TOalrUvFkhyHYpeyCBTwJclZXehs0qqz/poOK+o77f
         zKMnDZrZTj2s97UYtmnJ1tUeyVN0rjtA9BwLULzqx5hw+VVgor9EDqSn9pBX5Se63m2g
         CqrA==
X-Forwarded-Encrypted: i=1; AFNElJ8Vidg62b3FJ5Y3mzMohmz8ey/54QiPWxzcGVM8F06QeeKBLNWYM9uPCsipCQ3fSM/8V8cX2uUtu/eB4xEH@vger.kernel.org
X-Gm-Message-State: AOJu0YxhxJZQA+VStdhGcZpSTVozn0xoNQgSdj4wqSmLwDExmZMewvQb
	eHQ8TdeSxYtZwX/2NN5wI6LLdb56I1jB7H2KNCzagkazS6p+nwQ8irh6EY4LLq/pxcU=
X-Gm-Gg: AeBDies1Zt6esR9XaD0izLUlcYWF82/aBL8rotvm3H8iLJBwfOxHO9iMSv+x2DcgrkB
	PPvM6LG+uLRoGPdRAs7QWY4ZbJlBvtG9wEBb3ZC0X05kBOKWNjxQxBgyXQbffuJlMIaPvhlEmn1
	nKiLHY+yAbFfSdj4DIPOEDzIssrPqxflI4okotYfGTR0eluA1Rv6lMzkLyI7JadjXXyaUZpTF5R
	Nu4SpDptbqUhqNznOejBkKOjhi4LSNVbhenQmQfFNTsXEjmkcvDM+RTeIZ9gg1tVRwi+P3hEkh/
	LccFHgqaEnA/ukxdgvblWl8wzO+28LrMgUijE3ZHb78vvFiA9yEAuCGA2cOlyxQsFuHUWvKNERl
	EYvnRJMUvk6LlrOtHEAxualK2CbBsJbWNoGjLRAhmNwxTtP4nJNBcKrzVJ6VhaB+lGXHwEwYm+d
	/ye9Nj/LXj9Sw8cLX5MUN0vO8MxqCFR+xLRYLifcPk6TKLhzANhBXx3OXTeg==
X-Received: by 2002:a05:600c:8011:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-48e51e1a545mr196601095e9.10.1778247955127;
        Fri, 08 May 2026 06:45:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1413csm178475e9.29.2026.05.08.06.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:45:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 4/6] hfs: Move long delayed work on system_dfl_long_wq
Date: Fri,  8 May 2026 15:45:32 +0200
Message-ID: <20260508134541.282073-5-marco.crivellari@suse.com>
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

Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz
Cc: Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a4f2a2bfa6d3..cf4e7a6112e7 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -82,7 +82,7 @@ void hfs_mark_mdb_dirty(struct super_block *sb)
 	spin_lock(&sbi->work_lock);
 	if (!sbi->work_queued) {
 		delay = msecs_to_jiffies(dirty_writeback_interval * 10);
-		queue_delayed_work(system_long_wq, &sbi->mdb_work, delay);
+		queue_delayed_work(system_dfl_long_wq, &sbi->mdb_work, delay);
 		sbi->work_queued = 1;
 	}
 	spin_unlock(&sbi->work_lock);
-- 
2.53.0

