Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D083E832C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335297; cv=none; b=FIAYoTvsH5n+wuORjrwVw88f2AFglBiBGafY6Ux6HjMobCoAigLf+UU8s5oaEk+fSAVndxNABgJYfXy7eOWUirG2cFBiJmQi2ooRFC6K2Y+6A70VkDg7LC5k4RPGZEHFRQ7PC+kBv57CG1QS1TA0/a1ZzpWd4t5CAypmgNtn2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335297; c=relaxed/simple;
	bh=XqCqpSZS98NyRn13H2la06YTHqXp341yaZoaSW48bYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsaSCPBD8yReBhgtXa0bRbu4ZwgJkYMoFhOVWItxeO3D0/yljbZx6W1Q7xRk9PA0fF10LbAfJB9PZZAUe5e1DL9gQ+V8C2sYegBoA+Hg+DPn5AeyExr7LxKN8t1TXvcjXGcVOV1/NBcbW9bsggxVQOjzr7IvRetdgr7ysp1EDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqnYvEUO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqnYvEUO"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1906230f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783335294; x=1783940094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWF1/Saj/bM6aomyyXupOgtj5nhmQ0EIDabewEY3qyk=;
        b=gqnYvEUOL0D1sp2mxeFDSvSO3YGP+NUNPHFRNto3D9nFfv5+maLFUgyYv02ifr6suL
         AjF+UioJFl/8gTb7PJgomlhlm6rp5bHaufC/a32vY5noUQCIXjfSh6hhNk9pd2ugkoJD
         yqLh5BJNxi01pxjsxPmBNJSCEyNOz46M+jHlh8xoaX3aGAaLODOfwYFmQCQDhG4AA9yD
         fTPzFNkmtTvXrEsb5Ai2LKMvfTDP6LEpmW/U2krrSBRtLnLGyzyMJ35XBXinz6lysHdV
         XAgBeda1hr/FmFzGfF84SHwe1O/EzdEq/f7gtDKZ8kMWe7wQ1oGXR7hGByXQcYfGKu/W
         dDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783335294; x=1783940094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dWF1/Saj/bM6aomyyXupOgtj5nhmQ0EIDabewEY3qyk=;
        b=fcU+t6tJPiIDUdquHspTgh8udkIUcAK5qJGMFC1BaiGBy8ilE1HF4fYG5OkmYs30gE
         GLty95mF9wgOdHc2WRjo1lsRx2JRUK4ssHn2wGffLq+K5byN8IZZRUj1YtvYDsoWUjaw
         IgrD2WrdzQa6PrjM2TZzrFsKa2TzM8ezk/K33CjADbu6KYCB5HF2vVjQEBJLAUqwzJ1L
         dn199rwmIT8cgMZCimSQanNYNCOm+bBLqJEoYvmOjM8k5zBYtiRrszMtg7WNoBkkBBs7
         BUEsxwT5tsfZx9jQVLmFphfkB3LShB9kFL+sZMsUUSOGvlLiZwtT7torlNTvlSHXu55V
         PBAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpip/adumGdzxgZq/rMH6Uy6r00g+A+6HOT45O1xveB898aGdQbxq+RB4SDGGzZHMm9fyFbWY6jKTfflmag@vger.kernel.org
X-Gm-Message-State: AOJu0Ywox2ImPE0nzjjTBh1jhSEpyucvgvXtWwJqXvgQ1INBVRgUR2RM
	4mrYiQDw3qgjbYOOoHWK9T6G+IhXEORnPUaAEkoTt3sOYoKMM7rHO5ewWSHHnZFU8JY=
X-Gm-Gg: AfdE7cmKmZJXwDhIK6E3Ya12FJX3KMhZhkAL7b6knGYTYROz/S96MXt+SGG6EgUvex3
	JELzU0Vyc7PvdhVigypp9fvl1WdtuoIyfEVvuqMxK8w4rXn+7AEkK2TN1LIl9SiPFMlLPZqKUlW
	0jTQ4tIm1LOP5zfswaLoJE4Et+BsX2OstS5iw7QrQX2DdsN0lbqq806NZ47OGzS8FZC1YaZcwN4
	nuOwHk/DKfypkoNjpTc/LmjGoCMlTc/tR3J6s3LxBdMgBqzTWBT2pJAhXC1K9m1bgKaR7FG5lB1
	LjJ72YzLK+MhvUb6LNDDI6DNyQCgZ/BqQrr/IIdj5lOGfKdI0WTQHkaBLKaus8WhiMmc/KunFxC
	4sTNOtdxd/I6IoIrqH4BUP1Gjt9Tc9Wcsgll0zxuPe4NkHIkvB+7iOyAwiouWN1m8UgS0lHBpVG
	dZHGsVIKyusulEArRBguSyl3iIs2Ek/eHC1Zl7
X-Received: by 2002:adf:e348:0:b0:475:f0c2:75af with SMTP id ffacd0b85a97d-47de61b7f5dmr129663f8f.26.1783335294621;
        Mon, 06 Jul 2026 03:54:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm21607506f8f.31.2026.07.06.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:54:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/5] affs: Move long delayed work on system_dfl_long_wq
Date: Mon,  6 Jul 2026 12:54:37 +0200
Message-ID: <20260706105443.173697-6-marco.crivellari@suse.com>
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

Cc: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/affs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index b232251aa7bb..4f331f784db2 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -88,7 +88,7 @@ void affs_mark_sb_dirty(struct super_block *sb)
 	spin_lock(&sbi->work_lock);
 	if (!sbi->work_queued) {
 	       delay = msecs_to_jiffies(dirty_writeback_interval * 10);
-	       queue_delayed_work(system_long_wq, &sbi->sb_work, delay);
+	       queue_delayed_work(system_dfl_long_wq, &sbi->sb_work, delay);
 	       sbi->work_queued = 1;
 	}
 	spin_unlock(&sbi->work_lock);
-- 
2.54.0

