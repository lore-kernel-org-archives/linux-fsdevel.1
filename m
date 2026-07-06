Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD573E5A0E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335297; cv=none; b=alhkzu8Fg5cuv8mxsL5OdNv8SB22r4fLWGi4mf4kSj0pVWrCZzzmMeZfcuc58lejc9EaE1Lc8x2Bk44gXFZjX3Au2GzpHSvW7pILOTs+H4E8nU7sHDKBrjP+yd7SFqdohmTFMEbwPrtK0uXGSbG0wB3cOvtDKf02XAUoXZ3DAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335297; c=relaxed/simple;
	bh=dDjR7pT6XcXDzRtGZcdknJWkk0qUN4v99CgayOWu5xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AA2Sz6L/LjarwCS4DyrZ10sYGS/gyNGvw9B072JHdBVgQBCLkBmXpvFC6izbet+cUzrSTq0uQmWEt+lEcZh6qXAyYoPwUMluMKOBXqyDVhOuIuGyP0lBeTDQJCLMqOD34+kKfk3ue7FMv3SoPdfVaoMhfyH7l0zL8xrz3NkTgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TTgkeBY8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TTgkeBY8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b779003fso14146375e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 03:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783335292; x=1783940092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hAeVgBKJVpOnWdN8Nym7j38exJlr/z7nkGtaW+r3kY=;
        b=TTgkeBY8ToNCKxWrf4tTcSdaO7+i995aeGIv8zMTbxY+AnvUW9wJ8dXhKQeMXynJXq
         dOXFYuf0SffE9V6Tm1OqzysGTg26hfVbQrsrDUM+DALIMLQEa+opawuxozmRD569cl44
         vO7188/oZkx4srN70YWaMx+p1IGO7FgBQGKSYqJbyeCKuGwkNoXVCw3X59wEdJnFhgb/
         B7PAHfAJ2GvufvDGe2WcLcI2kb/S2o8hh3evSspRF/NSlc+t+9juoeqlAHr6fGuiafu2
         otaQpT3pQCoRiilTQiTsce9VXP47/OAyv4/Zkblq4c3219mPzfV/4NSSyeulmyW6KP4M
         sgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783335292; x=1783940092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7hAeVgBKJVpOnWdN8Nym7j38exJlr/z7nkGtaW+r3kY=;
        b=HD+UOcw2CfOOj1HwPH4TNBg60NZqzpKTrTroGZluf3iXtSKYCn7IC6gXsbA1XahJr7
         Mlg68CrJVDPKYKCB4IZ1XeWix9cM9JJF4NAUrOFsq4yyCynAdGRMVjspjmkT406vLulm
         8BX+rD0j3Z4D5BfPNR4cF7jHRtdWGSKqEol5K7/m7XOO7DwXU2aR3RVB0ZjJEWsuA7Ya
         Sc65Sa+PijnzypFydEWfirkT2sJSG6Xzio5sC/mkGUv6BJ83PySwC3Q6ivjHs+GqE6k0
         zEBuGXN4jh0pyrBv98t4XYsCa5trg1zVg/rMTSZGOmD7zRnwrVl/Jw7YkEV6s1W055rP
         9XDg==
X-Forwarded-Encrypted: i=1; AHgh+RoAX5jk/pBFDvMv99so5fIVp8jDhLAhWYhtLHZFHrL7qOlcTwAxWGGLUu8gq0M34UzG0udQvHZ+Sbll75VV@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWyOHeIqZm3/Xq4lbfX+VOO5COd4tFsIbM+VfuBx3QfIUm7Mq
	4gNjDbs2cbt8CmfuZtO8OpjYC+weHMdoVNy3gyKTC14tzZH376lbd0ko7Evq89W/Fjc=
X-Gm-Gg: AfdE7claMrLFQCLJrAKx9xa3D4ZhhAjp6BLg+mAJxZ0vlZVqyNF+FcdpthtcxXDAyAj
	J48UJ4J1cjY9jKsKljl3nNldDFMQrBdexwNN+08DsskP95kOirAQrA7o7CmH1rk1szEyTdz8uRg
	a3m3VAUjjUthkm17TD/YF0OPgcRQX4meuQpSj7kj7MD8TUWqJ/PTvdJtl7p/xq8WhXMPJZbY1mH
	ZdKDWnfhM98Ny1BDFWyoyVJHawho8gKHu1UHiHWE2VGNCn7cL8av7Q93H+/BS+QyjNy1JNqwOuA
	vRqsbrXNiNqoS3zjEwLLWMDSfRBowm6EbObj3nEBZR0fG5KyJ+yRIn8Y1ZsSt48vpbjdZyLlRha
	Oimk5b0Ewd5f0lvLKP88k8oy3IxUsDRD6f3L9nmv6h8pyuMNLxiHEyckg5BrCqsV/0Z4AAjceqj
	fwAEc/CphBmjL4pUziZXRSf/8lLRtxZowvGpTXWZooR9MTA24=
X-Received: by 2002:a05:600c:820b:b0:493:b56b:c45c with SMTP id 5b1f17b1804b1-493dd5b0f94mr16134995e9.30.1783335292563;
        Mon, 06 Jul 2026 03:54:52 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm21607506f8f.31.2026.07.06.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:54:52 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/5] hfsplus: Move long delayed work on system_dfl_long_wq
Date: Mon,  6 Jul 2026 12:54:35 +0200
Message-ID: <20260706105443.173697-4-marco.crivellari@suse.com>
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
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 5777e31de45a..ff7d6b3336a6 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -312,7 +312,7 @@ void hfsplus_mark_mdb_dirty(struct super_block *sb)
 	spin_lock(&sbi->work_lock);
 	if (!sbi->work_queued) {
 		delay = msecs_to_jiffies(dirty_writeback_interval * 10);
-		queue_delayed_work(system_long_wq, &sbi->sync_work, delay);
+		queue_delayed_work(system_dfl_long_wq, &sbi->sync_work, delay);
 		sbi->work_queued = 1;
 	}
 	spin_unlock(&sbi->work_lock);
-- 
2.54.0

