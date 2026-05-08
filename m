Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC693ECBD9
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247958; cv=none; b=hXhans3Vv8Ys+RcoVHECM3u85KhXI/MI2783EG2FlPhBSApfq4AwnwAmLvTc3UYDnfaoaYYXrrpanM5GI7vxomR9P8vrfYGwNIg6zJO2bMbXrUoPYxoXGbrZA7Tij1zER0y3vpBFhqfBSBuzj1Q4YU7Ck1ddEZgHFiXf7aIGqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247958; c=relaxed/simple;
	bh=vVpE+sk92WLPbTkS8UwRksrlO+TCUZy5fra6+QJlA3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp8DyszyYOvZlbki19XuYa+KWrLMVTV5a9G0UYkWwgzoFczFzNVjAd0O9u1svCdIvQEMjoqSC6aCdsRpiR/X80iPbzYNOIkTdNFMnZhvJ5+SAhOtzflbtjH6+qrQu7DrNyoUavsSy8zsFXu253/jfuPZ2tCQxMYOGZqYIKLAvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ED8G/+9v; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ED8G/+9v"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so22409475e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778247954; x=1778852754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78phUcQ5Rif/EmDwGcADRoP9ZKpZ/G8QAJtY0ciIHXg=;
        b=ED8G/+9vg8Z0Dc9aGmDOEy5dyWhyjXJCWLRgNOBxq4vedj0zsiFQeLrTUbQDhSOIaR
         y5bTlqcdjzYGA9rBOt/BYo0k8fOF94t+ap8NsGudc0shGa6DsltktjkVZRcNw08p6C6x
         x9wE3/SqG0POERKZcrVTI+V68l/lpTquJBViLz+WujlHYqnttchPrvMe9GXeQdNAKjoM
         NkjF59Dw2prbMp36hSahIU5x4Nr4pU2q/PusUDEbhhhlolp1Yowa2vXW431StO0H767O
         eBolmtrUcb5vs1C/vwC8qcVcpq6R3rmlMyoSXyufP+ugJj8BsaAt/Yls55m1/r7cU6Wk
         RMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247954; x=1778852754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=78phUcQ5Rif/EmDwGcADRoP9ZKpZ/G8QAJtY0ciIHXg=;
        b=c5rNIQUWgWHzD9pM1Z9naZ6Y42J/rjKn/CMQayYH3+Cjo+X6dnwd2rnBtTXB23Yzbu
         gNLQsXRXnxuLHDoCrgRN+lCDQCA2l8YPeeCBTnMCWvt4X+H+Q8oau+H1ErBVVDdjKSbG
         f1lYtjfG6Mhpmp76bgI5+BfY2jUlhpWuMJ41GRm0nr23NNiZgDX0B9WPAc4Z+gBQE55a
         LAXtrg8jSAzIwqQAcgUd8yr7J6Bneb7vOLQtnGlXj2lKxB1Gv2NQaYz4YYOZghFtJQxm
         8y/gK3uI0QTMiigr+653lB51b73vVkzE2HFkRGNPkCk7JwZbmLpSz+rxAPjAn3gxhKhX
         ZHtA==
X-Forwarded-Encrypted: i=1; AFNElJ9/cMaOUD3hGfUKthqQTmtvRdS7RR08+s4jze44xAH7nh7c7evTIi9gbV35WW0j8zVZ8j90ONVfr5QCyGEj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+7VnkQFsVNEdS5rUECqL4Vt983r5+mikcVhDUOuP7oj25Gkv
	COn5VG1fPCgl3BLt+LRBYTgnl/jdK94BKcO3bmKB7XD41WwSzBgsNw/KmmTsfSYKUHc=
X-Gm-Gg: AeBDieu/3lXoNqokFLlKIBAy5B93cByauTQhUtWbo+RMbyLY0JxjAwz/eZrKwz/pTpp
	/ckKXYdjjBSLEeWMLkfg7c36eiTWT26nOoHT0b7f0QzXfIqfQmeNcV4Hd9xia/M+BXJsZvzkkfj
	l5VMpevwR++8c4w8mXeUacxhwjVnygKTL9/Z+6+DZboAhRtxG5l/NLdmVhU59UgkIRkLhX655x1
	Wc9hJ67aRqRgQWhP8ors4Wp+1DrgWCWzbTVvt3LF7dyj2sxWxlptXmRGMRQzVztSc3Yu7ygQ8Oi
	B8nEjFaKwrRDQyQgoxwtQaQX+hXBna/h0hFrKf0BfiDWYkgSis9lGBkDPYwq0P6u0l+PrU94bII
	6EP/XfEmOHrdABUPQIl3qeBdU0XLnum2brBE7P2jXj+rYmdu8RA4vKUazc3FQtd5rk6Qt831rgv
	4HKJU8hakC5pXWlCgBRQOjc3N8WVFD0/EexCk2ABhHu+CpW4g=
X-Received: by 2002:a05:600c:811a:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-48e51f369c3mr203601785e9.15.1778247954175;
        Fri, 08 May 2026 06:45:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1413csm178475e9.29.2026.05.08.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:45:53 -0700 (PDT)
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
Subject: [RFC PATCH 3/6] hfsplus: Move long delayed work on system_dfl_long_wq
Date: Fri,  8 May 2026 15:45:31 +0200
Message-ID: <20260508134541.282073-4-marco.crivellari@suse.com>
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
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/hfsplus/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 40a0feda716b..12ba672e13bc 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -314,7 +314,7 @@ void hfsplus_mark_mdb_dirty(struct super_block *sb)
 	spin_lock(&sbi->work_lock);
 	if (!sbi->work_queued) {
 		delay = msecs_to_jiffies(dirty_writeback_interval * 10);
-		queue_delayed_work(system_long_wq, &sbi->sync_work, delay);
+		queue_delayed_work(system_dfl_long_wq, &sbi->sync_work, delay);
 		sbi->work_queued = 1;
 	}
 	spin_unlock(&sbi->work_lock);
-- 
2.53.0

