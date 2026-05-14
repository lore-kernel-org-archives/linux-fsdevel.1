Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88883FF8B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767715; cv=none; b=Q2Z+nBgGZLQADKrjcwUxGWfiom/BgxbC/uxhifczgDYGOJ1k1/BBjRP76dd+BU9Dpsoy2B+mLVS489qQnRuO9UlqPrJtzRHOalmhAW0Cqw5mlZ1+mhovNj8kTMJZqtMLJrvltCb4K5BP58FrWWDfQrH3XOp6kX2WVk/EALKNW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767715; c=relaxed/simple;
	bh=klxxVnyGRED1q317T7p7fYo0Zj/3oMSRfd75h/qMGIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alInd2z8ofEIPvAqMtL1Imvu24kFnpeS5lleFokJ5gbVh85pq3YTK3hqRgWnzh7DnWx5EaRQ15oyDP5AIWdzFCxskALeQ2EV0ktcDQq0dBYzmt5qYCmZ0a9crxTPvw9rBpj8th6/9gg2no+L/m8LvwBTbI6LtMwBIvMy2zwS7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=lrHlo7Lc; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="lrHlo7Lc"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479f7e75a6bso3338286b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778767705; x=1779372505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zFTck5W930pgUh3AWU46ER/xD6QLi7A/3R3iLUIHZI=;
        b=lrHlo7LcT8I9P/48q0SJatj1nEyw3NBKJSL7b1LOSysoQ05uY2O3co0d9igjeU4LYH
         PefDlWuzCM8eL+1VJEwPL47Faom0bDS6KQYoaOc1Lo6CSMUrf7ksX1jCQVFHdFHKAswh
         yJDSR8ntQFWctGvgrh+yfdqsKCi5rsm9PKW24HwRsXaZY7rti8luCMd8W9UennESnsY0
         4uS1wgUT0x3M/NWOyb+duQkwb5ptZYvqxgg+N1xOVxp1au/APQ7dCEezGCpu9+/K9vsM
         x682VGefEsJ5AWIia/7TW7Hq8HelayNl3IuiCGVp5CKf7VUtNXqEUF/lh3SIFy/X+cBD
         zdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767705; x=1779372505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zFTck5W930pgUh3AWU46ER/xD6QLi7A/3R3iLUIHZI=;
        b=GivPVnr7CQSJ7K+dlrtPNop1tmSuEqLTYH9JqHPamBf4Wbt+Rh9E2qH3E7+KgVBjWG
         r0lrVUAUjJUpyeLQFLO3wwBSe38HbR0tnnvMjHCTYDCvzaStNhGloSNJZaPqNsrIcIAj
         1wdJp2RDALFBcGMo3A9E/b3fFF9781nFOWaEOqqlK3YmV4bVdhG7RHh+IeTOOvcCfX66
         bjM4KnelljdQ0GYO1YGcI6iD+vVAOR9AAjvavbzGIb6mA+hCfj72s7f3GfQqN6vgM6DU
         nD4DFzMdo/0CN8efllZOhHP1DuLzzndVG4WCjGrEYtui+xhp1Ogg1UzN5ZTLIVhlkI2V
         bAIA==
X-Gm-Message-State: AOJu0Yz5+GBZ9CCdcx/1yt/6xrVIcNpY70OPl6Ec7TDZ09JZxX5bef8/
	+v6J6vI55GFdH+WWX7wt8ujoEEq0NcIU88OaF3for0SPx4zNS4Q5bPhRWUQ089Nzjy0=
X-Gm-Gg: Acq92OEZxwrLMt1uebU08JdWX5cFZwbwMY9dt6BltSa94lnuZIOigcq3oOiKxPdCzlw
	WgtI/3054veSmyY+/eaRskfcrndiuyhYJPNJXsrMwF+pzNpC2T6BM6prr+4JKhw7RRQAcVZUK8b
	zfNgo2gnZYFUTFSEjCF4PrD/MSU1NQzyN9VPv8z/I5fbsXgIq+PBA1tBYwNekOkhislWkneYP8B
	yJG4EJHlWKclG9OZ/eGYRxzM1Yyxbj4uLbst8yuata5vqYPzS87DCsp8lRrEEzWss3r+5G4GrSj
	lG0lWc/cxVW302Eh/MXSX78LYhz4z6/xPEeUmOLySgmvehO00f/F466ou3ytuLV+chKPsmjPRCr
	Hn6p0SSDuIWCtbmdjXydcon+yxPQlIbAnu7ytNZX/lkfR5cxm9eo+nyxdsccBA01J0ZKciSO412
	cihDt/9vKcSd3ujzHb9WiDGEfB7jpUbde2320wdnQGctDYslTHT+/yoNu74SX4dXq9Azo=
X-Received: by 2002:a05:6808:1783:b0:479:ed26:fbca with SMTP id 5614622812f47-482b2db4b30mr4552026b6e.37.1778767705357;
        Thu, 14 May 2026 07:08:25 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482d379f062sm1394956b6e.6.2026.05.14.07.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:08:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] eventpoll: export is_file_epoll()
Date: Thu, 14 May 2026 08:07:18 -0600
Message-ID: <20260514140817.623026-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514140817.623026-1-axboe@kernel.dk>
References: <20260514140817.623026-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make is_file_epoll() available outside of epoll. This is in preparation
from using it from io_uring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c            | 2 +-
 include/linux/eventpoll.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f464f2f39e0e..9ea6a2bd3d87 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -334,7 +334,7 @@ static void __init epoll_sysctls_init(void)
 
 static const struct file_operations eventpoll_fops;
 
-static inline int is_file_epoll(struct file *f)
+int is_file_epoll(struct file *f)
 {
 	return f->f_op == &eventpoll_fops;
 }
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 728fb5dee5ed..7bf30e9f90d7 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -63,6 +63,7 @@ static inline void eventpoll_release(struct file *file)
 
 int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		 bool nonblock);
+int is_file_epoll(struct file *f);
 
 /* Tells if the epoll_ctl(2) operation needs an event copy from userspace */
 static inline int ep_op_has_event(int op)
-- 
2.53.0

