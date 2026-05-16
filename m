Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54114A4CC
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778897941; cv=none; b=gtERssSFIiuLyKTJ+ubMgmMzwq4xfVr8YGc1wE/Y8bb5+giyA/dVO1MRbeeDr+PZz0B7FheQINCb+3/FaUwKj55YgQl8HESvswmNKE9s5EHC7qx4Nk+lvHCvWSqvFqCAVbtcPgwd2CDMAxA6zgZtnqDsm2WXr8l/DZlyGXecNCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778897941; c=relaxed/simple;
	bh=ybSvkoj+dVKNc8iISeOY22ZwlFdVZXOQv9R4vg6wFHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doeGl/dZsgpoUCbJNelvAQhPw7vLphPNf0G1a+J1UpDq91q/6x65UxjazkTzQeTcN3/LgXz1XnAsdi8p2+/DseYG8OieBcN/vFqBTcQiw3p2SS+9iK9T1VZnqwM9iOpuQMy0FfT4qzh3vniqivTVue3s9iK3H76h0dILTIrwerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3/I9TDo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3/I9TDo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso2371745e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 19:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778897939; x=1779502739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oi0E59u2uw0wWK/TjTMUD71Hy6BBDUT7Z+bfsXFYn3g=;
        b=r3/I9TDo1HBUhvim1zidSV5f+vLMzIVB5SObK+iFtK5hsxsgv/ZC6r5DHQa124W841
         kNmhOhtJ9lGD7URHfmWLxXYtPaOpalpjiKD8OiTdpdZTV4oiqvgH9iFKlf3BdRCK4Oms
         jqUzkA/W12pwSl2/F8vetjx2IKmFHCEunUm3Pus5xIgb9yiZjxIVXdU6Yqckor1ULYTM
         p8xszBF7jJZR2U8v1+VLWwuSK7u1w8lMAJrpnSwgf76YZD42CmCdO8/0QKBpU8RDQWL9
         n8Uw+lYhrkpVudQWY8Sx6rw023eH8/dgPE/3v5ybcxZlmWfPqf1dueVkydz2DbuIp3UW
         9Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778897939; x=1779502739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi0E59u2uw0wWK/TjTMUD71Hy6BBDUT7Z+bfsXFYn3g=;
        b=lzazmw8SwoiQXdOvWaHvKKcq0y60vlFSY/qjXvxi3zS0XaMmFuV6BqUoJOCx53nBfN
         m3LX5KL5HrvSSR3nqm3EE6T3V5MqklK/Oi8cYnI2yztwDgosfX+cnqWyr2dQ5jR5Rk9K
         RrDeLhxzj8Heuqy71sgQtRNACbyCcCb1JbVxaMCjMU0XXKSovHbUVSK1HQ9DQcZFKUX8
         zurO3Rjm2unDVFiuZdjlQc971vmnLeqE+glBeokYEg0xaPxu/9EUgOL6nV83lX6kLroC
         1mhzxjanzdPAZYU6mQNbawYZwl7ze4nJ3LR/3d7fw87WJUwOCbr8dqBGEoh+hV1aT4iB
         DceQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JFJ1eTedgLJhDjX+HKOiN4livjb+oFDjWgdpRHNFjCqIMB8XnWaVuv97khUJB7nAuSlSqu8aCJGEDJbRA@vger.kernel.org
X-Gm-Message-State: AOJu0YyqptVRxguMJONg+BjPK5k1IWF4U+k3wdoPmr72n60dxyBaSQF+
	woCqEtKFxYeiQb/BiDYMVyfGyG6wgqkydBpbW4cVAZdhRzlfEWUNw1PXhycCfQ==
X-Gm-Gg: Acq92OEsgdndwsEhlrrfmu1TMUIVZIcwuHhtzgmZ2QwL6tme6sGNr8GV3Hv4JuLIa34
	b1t51egJJYkZTsAq71l3gyxGolLSZt90iX9ujbVYidH9YhVN9VjyKB60RsRYaX5FTDtFQzgH489
	y/YjdxjUkSAjJX3GvjWalMy8yKWfMwMxoKI4Cgxj0vdaPkeQOoJ5suOf1IkOh4mCaeIjqA2AW3W
	HWe7UCeiSnPhCMiydHlib816eAordhxUV+RxL7PAAAfORzkuZbKQGQPEn3fDGo7k4uoIvIxRwEf
	WKmDrmp7tx7ztl+NeKSgh+kp08iHdcE2k4Ec0jbtBjLdwU0KYdzUIY8aNRveU/g0o5ndddblc1+
	1xuaibAPcIOqBe0EfzhS1HK5QvzEPn44/xEA0i8a6nQ6nFXrh0TuTxRNbuCG3/VyM7cBdsFByVj
	kRwKyoR7cIrSQmKozqITZk/bXh7FCjfVIzE+r3lbtcHg+PINC3sHYQmJRi9Yat4yL5k1l5BGnyU
	Q==
X-Received: by 2002:a05:600c:8485:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-48fe5fcdec2mr94918695e9.4.1778897938597;
        Fri, 15 May 2026 19:18:58 -0700 (PDT)
Received: from f.. (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm18819419f8f.14.2026.05.15.19.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 19:18:58 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [MEH PATCH] fs/pipe: write to ->poll_usage only once
Date: Sat, 16 May 2026 04:18:52 +0200
Message-ID: <20260516021852.256932-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both GNU and BSD makes share a "token pipe" between their instances, as
a result a -j $BIGNUM invocation results in multicore perf problems in
the poll handler.

Avoiding the store will reduce it a little bit. However, the crux of the
problem is the locked queuing up in poll_wait().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

disclaimer: could not be bothered to bench this

 fs/pipe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9841648c9cf3..e37c79935ecb 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -664,7 +664,8 @@ pipe_poll(struct file *filp, poll_table *wait)
 	union pipe_index idx;
 
 	/* Epoll has some historical nasty semantics, this enables them */
-	WRITE_ONCE(pipe->poll_usage, true);
+	if (unlikely(!READ_ONCE(pipe->poll_usage)))
+		WRITE_ONCE(pipe->poll_usage, true);
 
 	/*
 	 * Reading pipe state only -- no need for acquiring the semaphore.
-- 
2.48.1

