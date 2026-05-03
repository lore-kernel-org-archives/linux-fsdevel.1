Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1162F6904
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798284; cv=none; b=Kpx+5JZ+6I4dOhHoqchpQ84LSE3KLPKTQFE+azgvshpBJSPVVGCtrCjnyHD8OKHKO4JveWe4r9KWznQYoG6v3HZ+tVAd1+mbKMXGlwA8k17qI5BcxqfB/tVBk+E41Ch75iCrW9uZ0h0vJjRHvZfhDgiTqKKEYLOLpjrjbjECYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798284; c=relaxed/simple;
	bh=Wiq9lP0tzpEoE5QlEr4KHNnVpar4vwyHcnLPSe9Qvwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPJtNlnQ9sU6EeS1l6wKi7JPJg/iGPLUFJFUlQNAHhJBOMcgutAQwnR8Wry11MgYaMhuIvCes4qz3migNE3dyPCnK26sWJ3pfNdFSRIRqI9Ciq9BTZ8LQcsVvQEz/GiPaGetRaBN9dHNuimZ/MQWnYfhnL1YiOmxhvc5A31nn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=S1l7tejD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="S1l7tejD"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so5315501a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777798281; x=1778403081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPStkFVZLm+jjZLU/tsX8K/9LVqR7jsD8fjKsI4ziHo=;
        b=S1l7tejDCqZy7hPtvyPTAL1gWR5pelGn1vasG8wA6ASGGSlLlFFU7SPKFkNN88gkqd
         xzaSupf0igx3EOsi9yfTjZW9wA+NeDKJtbYlsKj6doUA6CVBQrbqBl30nUji0O/Wz9Hc
         kEnRHZZL2vHmh8JDG7uzueveTJOwEugY1Oqjp2PAJ9aFCBc9Goex0Wdgw7SMOWjCYZum
         Urt9VzabQpSB7uQXIdTY/jw+uK4m2tO2fe3nXXkGHjpOyWq+3tL2omsJm0n7LnLx/xdm
         KefLT7ornsp0TeNG/W/09RV8/pUVNozF/8jabgBaopoSU4Xxi6gPvJhYDD8Hd/5rjUTn
         rWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798281; x=1778403081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NPStkFVZLm+jjZLU/tsX8K/9LVqR7jsD8fjKsI4ziHo=;
        b=sH61bTe4xAlLiBkhP1kZmoA2zFksbnSWaRf46VqMZpEwWnCmRlI3QCErj58o9qVU0A
         Oap83dZBTXVcjyxjr0UvkR88N1U1VLW36GIiRPt1DyN1HujhxLENU/Us54o523HoXr8z
         VWbsMGNMsly1nVCjg6zsh3uG+IjfJEA5gNs7RO7jLg0KV732Y1+s7x8TIUiNm/+UAN+/
         /udBKFGE4vbslthjy02T2OezDptgdBqbrmAGX1EvQP+a9Z7yHNl3UZUGSxJIiC/d0Rst
         I8j7jVBd6ndVj30WbUt/RP/N4TGXr5h5fdNDzoUFHw+ZI0vP9KbRYhkfQccCrJQnAfyi
         OJ5A==
X-Gm-Message-State: AOJu0YyRaZtKt7kaMUNz1+x0YSQalS8IeO1PG/jflgBJR//duoW3nwSC
	46snRwMtOsJhZo0UyoAYIywNDTety3MjIT9M/aPIM5iofkBlMg/KNSxDrKlQ6bAY2M4=
X-Gm-Gg: AeBDietl+jlwyp7PtGV599bSj2hQiGQil5DmKIXJI/MXB29ONufF4/C27HxRRd69RM+
	7OYosqF4LY5nEWJ4gRf+xv1fdSMA7v+RqF7ePD7rTAAKBLbYMWKJfW7AhPh+9i/YoAB2b6r7I0Z
	Vmfc6uLt3idi7plhUr2wIdqFz4H3pQQC+bifm1nU+fUFo5p7j1g2qvV6fKb9XGj4T1lli1yraoa
	flYB7eCE22w5uhHnDnuxeTiFF88urwLn69Co5ywZpxjneu327pUwyWICTZwf7JNboUMUHw5066a
	+qV/SQX0A1nRvIHO/rXKN9LXAPQkJqCZsV0i7b/P5hXt1YuJqZbPhpiqf5D5elfgnAbjDN/QYF0
	hPaK0EH+qbpRB3DJIwpVMiF1hfvlIPjmnoIaZBrTi7JwkrJXlv4VPonXUTOzSxC4mNZvShJl5fc
	AawfCcPvsit+yED0OYBAA3YFYuKtJeZxnHd+6MqIMq0L65cWSvz/uwD3FKlZwxMREP5uJf13QNi
	tgvyDWD3A==
X-Received: by 2002:a05:6402:1515:b0:670:b72b:4044 with SMTP id 4fb4d7f45d1cf-67c1ada377bmr1570637a12.15.1777798280726;
        Sun, 03 May 2026 01:51:20 -0700 (PDT)
Received: from m2max ([77.241.229.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e292c2sm2368936a12.1.2026.05.03.01.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:51:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] io_uring/epoll: switch to using do_epoll_ctl_file() interface
Date: Sun,  3 May 2026 02:49:15 -0600
Message-ID: <20260503085101.112698-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503085101.112698-1-axboe@kernel.dk>
References: <20260503085101.112698-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/epoll.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 8d4610246ba0..59cd4f009648 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -51,10 +51,21 @@ int io_epoll_ctl_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_epoll *ie = io_kiocb_to_cmd(req, struct io_epoll);
-	int ret;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
+	struct epoll_filefd efd;
+	int ret;
+
+	CLASS(fd, f)(ie->epfd);
+	if (fd_empty(f))
+		return -EBADF;
+
+	CLASS(fd, tf)(ie->fd);
+	if (fd_empty(tf))
+		return -EBADF;
 
-	ret = do_epoll_ctl(ie->epfd, ie->op, ie->fd, &ie->event, force_nonblock);
+	efd.file = fd_file(tf);
+	efd.fd = ie->fd;
+	ret = do_epoll_ctl_file(fd_file(f), ie->op, &efd, &ie->event, force_nonblock);
 	if (force_nonblock && ret == -EAGAIN)
 		return -EAGAIN;
 
-- 
2.53.0

