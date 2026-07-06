Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D63ED3A5
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335296; cv=none; b=oRuJfB0zQqK6ivibPvZFgrgYMb19Ny1A+KXJ5aGe+7xSHawfD7gmkg4G1RcK0ytH5N+UYamcDd+zPv/7+NKL0PjJVIEFZZVR5RFl74c/96jdZfhrTjSvMg3BivNFXkCOQsdkoCWe0HB3WM6EPtWUDgV8mSSNjJHOltAoByB2PnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335296; c=relaxed/simple;
	bh=4mEww5okuCvSmjlurzwb+AvoibiIf22OwVb1zAhU61w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuWBQTHC8gEiRiduJEHA8MoEWQDYUetjq3GArv/Xn/32jvB7CjrSAQnexdaxQamNFBzC2lUes3K2OBQBuF2L3qgIAcRFrwIF+Z+lhkfin42Th6ox4TI2p+YlA+NL0DA/m5fqi78NQpT+NUqs/cvB2OqixADp5QTia9IuvOO0oTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gs6LbVCu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gs6LbVCu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-474560436c3so2825737f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783335294; x=1783940094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkJx0ttxa2RfPVVyAUgxFCq6ryMvYDS2TUHuMo4D9ow=;
        b=Gs6LbVCuakQSnasLmwCY9jhpk7u5+EKKJdWDGAcYyj4ost6ojaJbW8Kik/BGvBfzuj
         9ZuOFEEo2c44NgE50h3N0TLcHBZH6/5QwRu0Qlp7yvI1hmYnZ/DxUG3xufwFzm+NiRSo
         vnzr7rhBxxsRwK5nlApbCNVBfMJUP8FCAEf12SiB/Hggx/sUKcrZOkC2xMY4BgYU2Eyq
         iP9AfbCAakcTWd262cw+8BTjfeM26agVt+AqbUtLxxvqTRyq563FspIPy86F9XQR1IVp
         17ZVfNa7aH3dqMXR9mlEKw7ngPF3vpoegcC+DR/0oJDQe9HW5dGqYRhpUtBsBWRhkI+J
         7b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783335294; x=1783940094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tkJx0ttxa2RfPVVyAUgxFCq6ryMvYDS2TUHuMo4D9ow=;
        b=bvEwlOp2EfByB9bs4tBsZpV2/ijgoltwdV/kwCLYZR1OSdNatvn4QVJmg1Ri9J9fK/
         6fbLMcG9lVWGNV/fbKdQJsqM4o/q05//CDF2AVcQ/XX76I20w/x9wClpfCS9dDBs0jUR
         ccjyUDC6+UnNx5IrVr7UfI9O8LSOG3rNP4zLFkMvgm97E+9T5oLd4eTfH9d9FYNxhxD7
         dqe2JHnOMhZC6Yb7CAGpVAa1v49mXXedHWMBpcW2t1LISb6ctB/rz9P4lNimSJ6SE/JG
         +5/f8FATpzUoJTmfrkd8QAdliD8Fj3QDL5ZhHvEXCj8aWmVa8ZUh9DfA611rMec7Hk+6
         RPcA==
X-Forwarded-Encrypted: i=1; AHgh+RpI7wV0tSxvlOkIfClkcx/3xC0JLkbrS+ZLgfPW5pfTRvkgwOk08GGmuWSK7d9gVd0Y2abBV56Oflb/sRfo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/K98DjeWWChn152FBvLbbk5kH70TdU6dVViC4kl4Q2B0RMMhs
	uLHI8Hl4iop/PrOv3jmV6Y9BRFcojY5BrlnUgVQlsyOF1DHnlQV3HMAo2v5izfIY1Pk=
X-Gm-Gg: AfdE7ckgPQNZCZxi7xihkN10jcbSpfDliB6KTbBC9hvBxwZlth4NoDkGad5L2MFySQ8
	u3s3tjm0/rYgye7euPk+Rr9g4+D+W7kKuYq8XVghEcEqdPIjQegDTAtVh4ebx+xhA8895eF3Tvn
	D0rppbpJx8NCJ1VUK5etPPoRI7le5aEU7uIC1XYWsx+9eryFvQl88d63WQ8ZAa7EM5yiv7D6MoD
	I+SuitkjfqwowobFb8jBKNl/+Jig/Mjf1UavdM1+ow1XxZmZG/RSnbtgbd1/p6YATQQzJHGnkp0
	J5Z2EJnQvyeTHi0yplhI7i8MLUHd2xcG16OMBTzLkdmqOPog5rGAFPGu0Asl8Z9rl2n5UAhTi1h
	nrV6pwWqaeG/9PD1ufcUS5YYGl270I9YfFcT2hCN/ZqpJosw4zaT2sB3P9xGyu2mWNu3GPatOO0
	g0bpwvDcdGrcj5WBZb8BnhwqsmjzGQ+Qv2WAb8
X-Received: by 2002:adf:f605:0:b0:46d:d5da:f0a8 with SMTP id ffacd0b85a97d-47aac9bf759mr8660708f8f.47.1783335293794;
        Mon, 06 Jul 2026 03:54:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm21607506f8f.31.2026.07.06.03.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:54:53 -0700 (PDT)
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
Subject: [PATCH v2 4/5] hfs: Move long delayed work on system_dfl_long_wq
Date: Mon,  6 Jul 2026 12:54:36 +0200
Message-ID: <20260706105443.173697-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706105443.173697-1-marco.crivellari@suse.com>
References: <20260706105443.173697-1-marco.crivellari@suse.com>
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
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a466c401f6bb..ecdafc658928 100644
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
2.54.0

