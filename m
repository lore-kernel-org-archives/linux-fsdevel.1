Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C63D1A0728
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798287; cv=none; b=bz5h8bGItCT56qwhcIUlZ5gJUcQiRT2IL6EXUGxC4NYeEVGovc00PaFVJ9vGteyGur7vjsCTN9/UPq8fdIMKSHcHR82Zeo06HDblK5PxNWfcuP/yD8lCRIcM93oFUfeT9rXeSqLwe0f3Xi1IzMLu1tRDzBCFVxU5M20J2gcNBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798287; c=relaxed/simple;
	bh=wtbl+ixVRxR+AU4WuUKWwBgg4ITg6WDjpgJQf0rWEhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6T4OS5npPZEXAxwQuMf+b2xL8PkWLjyOaqzcMl6GEWZqLn3FDjozdfQhE7BlhqhVgObwEZV2oDlmeBtqL6m9TE2mcsrKk9I16m9T8YdJy3rLnKKZPtCXS1XV1BHz94jQ+5Ua3Z1rpeh45UdU/RsA3QHV7SdMuc9VHBCEWNMR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=YC7v/NT4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="YC7v/NT4"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so4666802a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777798285; x=1778403085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6FlnQddOFsW56J1QVBKnB0QJtZtOojgEvtskF1QOQA=;
        b=YC7v/NT4MhCgD9KiF3GpdqQSTEH3HRm5XgllpV1te5aqLCX4GEuc64/JvlYwgbGkEZ
         HuAmpiliWyejNzSjZEsIfA72rWNtAYcueRByPGgT/E46+LvbIswTdgRNP9g4FpioZ0Hg
         b8jS5B6RvD0JW21+kmLbL0fMwwlyHxjrUm2lZmkyoweD6zgt5a8Fr4tTkk4+pha4kLdD
         ZxLg0Y7Ylem3Ov+Yoq2AGB4eiH8Qkfy1q7NE5ZL3+YpOzWNGRZZAqMAr69mjrpJhPsKs
         ftkKlnvCtupUFLTddWGrFqaWPd/KnoIJG/J/J4HM12LfseJgbxIpYqEhRHY8bVV1gfsd
         96Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798285; x=1778403085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6FlnQddOFsW56J1QVBKnB0QJtZtOojgEvtskF1QOQA=;
        b=MS6S1rkdRdRDNrPBZ8bHPnNZqxQLu0KdJj+d4yRKjnbb8eNZ7Bt5TYYroyNS5LW4lx
         8w8opFiCb+AJ5FtmK7Cu4bcvWrhn3iMi1elPkoPpw+G03jDSKvDDDHqHpkNCK9rfjVU1
         MoDavMBqxSPeWZFRwsfqUu6jmCIx1XGMetuosBMeRsaKT8ZCWPN57higBQaCv6uqRQ1g
         Uaq72NxXwbnuFePrL4twmGAgSGhRM410P9JYzs+jLdmAyX5w+4nYqFBwZTvkr2CBhApf
         0h6HxpGbOwDWbcbvxUlY3kC+oe98UcabH+mSra2flOB1y6rVqKEWfbQFxBVnet0Z6mso
         8JwA==
X-Gm-Message-State: AOJu0Yzy8ZKnXqlgIBqKPJjFifSvb/tuuWLJAu0jtqxz9tMFBBvhNkf3
	+ewfbKw+5kZ54xYG3qcOOuCFoANbfrVHPG7lkZxoXDi/Nu9M4KdD8Y5TRX7SJC9Yac1bDvJRgtz
	LIKoB1zos9w==
X-Gm-Gg: AeBDiesWEw3IahNe1L4Vh89CUayy6QZYOVchG1lwysp6VRAjL+q4ZCZj0V5HJt915c8
	9eXOREG/tFz6AdS8DX6mvVetiH63WSE5x8sAlcQI4n67LyNpT5NTtvCq3B5G0rmqnCV+oe0YCs+
	dGJDfwgpWDHdJhwv/Q8CVo9dbHNvZfFobamtQvu6uToD30o8/rL5cpJYYvcXlpcVb0lyCNN73eN
	utcG/BDWKnJgMIMdUwfH3acZemeSBROT/Nds1rzDCES54W2Xqv8Sk/uCo3+sr6B7XKzlUT6E79i
	QduAugxSL/TL6a6/5p8+5dWEYojkWiH7JUSqUJqJwst7afkR7DBLmnLQEKlyQYVbsYpR22g6ggj
	UulkfkQlsSxRu7KwXetEsVrvGn1y8+R8sqbzcKUWdGm8470DciGALsEEPeOPatnoYUKOyrVcXKf
	yg6B9W5ARGBf3WOFGOlgxihJhPMiYGKRL/fka5ktsYLYkfYlOKTkJkr96Sa/O6J336YC6H1nFIt
	LU8ufANrw==
X-Received: by 2002:a05:6402:5043:b0:67b:7e67:7f5f with SMTP id 4fb4d7f45d1cf-67c1380e252mr1631880a12.9.1777798284672;
        Sun, 03 May 2026 01:51:24 -0700 (PDT)
Received: from m2max ([77.241.229.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e292c2sm2368936a12.1.2026.05.03.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:51:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/5] io_uring/epoll: disallow adding an epoll file to an epoll context
Date: Sun,  3 May 2026 02:49:16 -0600
Message-ID: <20260503085101.112698-6-axboe@kernel.dk>
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

One of the nastier things about epoll is how it allows adding epoll
files to epoll contexts. This leads to all sorts of loop detection
code, and has been a source of issues in the past.

Arguably adding IORING_EPOLL_CTL is a historical mistake on the
io_uring side, but we're kind of stuck with it now as it does seem
to be in use according to code searches. But we can at least minimize
the damage a bit and just disallow this part of epoll, where nesting
issues can arise.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/epoll.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 59cd4f009648..42057aab9124 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -62,6 +62,9 @@ int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags)
 	CLASS(fd, tf)(ie->fd);
 	if (fd_empty(tf))
 		return -EBADF;
+	/* disallow adding an epoll context to another epoll context */
+	if (ie->op == EPOLL_CTL_ADD && is_file_epoll(fd_file(tf)))
+		return -EINVAL;
 
 	efd.file = fd_file(tf);
 	efd.fd = ie->fd;
-- 
2.53.0

