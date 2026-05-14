Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4CE401A25
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767720; cv=none; b=UifB3S1bI4nuUVHXItvTma0s72w4jaB4feTJv3FyDvytgs9uannymYg840CFPJnZeR7Ez6pmrdfZRRwQzS8HzYFQtFlrQvWKiF8lvxTNlf3AYsAC69xwL3LFZwPclE5xDrJJZa5OYHYfS6nfzHakxXWmdUgcwS59ht9e8WPyK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767720; c=relaxed/simple;
	bh=h/TsxaRciBPPk4deTjUi8jarn4iJ1vrvL4w33rZhFms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kfdot8LyZNx8mX4FlhfQaIjQfG286dC23He7FwkvddUq4rLlPFWuRw2g5ACYfSdGj1cnWJJv+OYX1uVuHXjCsnzNMF24TME8ZKoYsvf5ucK0J9vr6hSr6tEDfP8zHyYKrpmPAssrkJiMmNjfd7/7af7iU8l12JbxsPuaF2ksbBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bEBAccvL; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bEBAccvL"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-479e6bc357eso3199696b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778767709; x=1779372509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0SY4JZ68JhcU3ovh1BQz4gQVwMMdNZDkWHAJkqOOaU=;
        b=bEBAccvLN+UB4FggB//S4FOxqNal+YrCCziW/plG5apK3B27OLjszVqRfQligOwbCT
         ttQJz/CDVWyi0vEm83C5KSYWgUx1zZZJ8FkxVYRAzYa/4M3S4f6vI7fveIVVUqcy6biG
         NvZ9QqSVfE0dKS4mMjiQ5J+sLZq8dv1FfJ98dgLVowEwtl1apaRVCwL+QjX+cr+Fnycq
         HatXpc90cNT/oU7aCC2pqMKTH8MlHMr6/XRgAyiXOcb0CZbD2INHcUXVnalvAXtuLg8M
         SyQfAXPjszIaPB7V8bzXb4VYSDTSkvccYdvUveLNsc5460qk33uwXG2zcQtl4FGxfsTN
         Y53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767709; x=1779372509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0SY4JZ68JhcU3ovh1BQz4gQVwMMdNZDkWHAJkqOOaU=;
        b=tYtX5zMNzZk4qv9dnhxSFGl8OrpkXi1K2eGUcebIcCk9jAzo9/7l1xNiOLEEr3oO40
         TmiM3ZngDbz0xapaWrAGuJoZJlC/Mtm2XbfjOz29WE+2PDeoCwi7DUcFTs0rZOrWavlV
         vkUabogGXsHdBgBdTnaSx0l9MrIVjy/in3YNhbm+8Yls9FOz/3fsgrXu74CoEz569NWp
         UYUomosqUe9Oer6ODDNO1/7DhNv9/79yHYnJ/KY02qb199U+HBea1F9kgR/6HVRnzEC9
         EOt1Hlx+gRhzkYMb3hyGGMarxlmcttT2ETJ7EXtkgxeozmrr8deFJGVOMFg1xLTL46SO
         6woA==
X-Gm-Message-State: AOJu0Yzuehk4HLD9yPhmrTrrVQ4j0Ddrh+uJkcHKw3YgiOfpg4ymYekG
	Woma2OAH91L7mNsisrQeWtlkZForWv4alTcTxC9URJUEMFLbfL5X+k6aK4HuTidDfx4=
X-Gm-Gg: Acq92OFbTbdq8MYU5GWzskGvwln49W2EpUxbDQBJMjw7m0bj0ElxncdoICSPfvy8ZY6
	eWsbf4ZC5utjcmVKgfHFykhCfL8EHcQ+F0K/i3wMC5C/my0WIaMFvdxuv+Ok1jSjVxKfAnrDf0t
	SRasZqY3eGY4npi1fxYfLG/h6A6mJ+07j6scpRdEKu/SIwf2jDxYAQjW65HqbbaskjbuUaHRO0x
	bTwsStc0h9sadq1koqYMzgjqsmmhfmeuBA0WXRmu/ji3VOPRNQlRSWKudK9bLALKcmyNL7KMnk0
	h7DYmOASjnImAvK5Ln+WpNRtFfbZgIjI6BleKpYrmvcg37WvJNOBmvScKsPQKiW9cL8NNYUZFQd
	rPRQVfFpEF7J3cgrNNzzEiLhxmWjFXwRdaT4I8igbsh0zjbI87+lEvN/V7b5TOjKCcWa2VVXtdC
	CT6GboVStCH+Zk2xEi2JS7wcbY8VKAWur94CvcY6EKXDHx4kEEXtADimfi9G1DnKnn7tA=
X-Received: by 2002:a05:6808:5386:b0:482:af14:8423 with SMTP id 5614622812f47-482b2d9525amr4889512b6e.39.1778767709333;
        Thu, 14 May 2026 07:08:29 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482d379f062sm1394956b6e.6.2026.05.14.07.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:08:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] io_uring/epoll: switch to using do_epoll_ctl_file() interface
Date: Thu, 14 May 2026 08:07:21 -0600
Message-ID: <20260514140817.623026-6-axboe@kernel.dk>
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

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/epoll.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 8d4610246ba0..b9db8bde27ec 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -51,10 +51,21 @@ int io_epoll_ctl_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_epoll *ie = io_kiocb_to_cmd(req, struct io_epoll);
-	int ret;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
+	struct epoll_key key;
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
+	key.file = fd_file(tf);
+	key.fd = ie->fd;
+	ret = do_epoll_ctl_file(fd_file(f), ie->op, &key, &ie->event, force_nonblock);
 	if (force_nonblock && ret == -EAGAIN)
 		return -EAGAIN;
 
-- 
2.53.0

