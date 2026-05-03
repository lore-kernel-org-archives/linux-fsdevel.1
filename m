Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6606F1A0728
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798273; cv=none; b=CDh1qUF9GXmBWV2uFORCRWCc8qs6pUO+Zqaz/DpcNID7c2PCNWtikRbqe95Udp3f8G+DS/0aiIUR4wYsTf5DIWgXkao62DxOHoes0zAgPIyP4exKAhyeYlFwK0n9RA6BsNtWeQ9DX3DtMi7A0mXDD966kzvfF7HqrwetTXLu/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798273; c=relaxed/simple;
	bh=fPHKQYNdZo00tTrxT+9rg/5OaWyWo2NnrgtAoUea1IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tC5zcW433MiqfNEZytrxw9HbCsg7yn7Q53TE8WC0DMG696cCJzdkmw+e74NUOzzfJ5Q9BFc3R7eR2bQjZk6YqtpmDDxp2z/JiKf7hY72TOnj9rTIG670ASx7tFeU/+XzmYaQ8b/c1Av1R+xdUFCJ9Kgwe64F7Z9Wm/8Iof03I1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vAb5So3Q; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vAb5So3Q"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67b7c71c165so3268745a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777798268; x=1778403068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+S1K9D2mcBINOkojfaHJOsrVSLjVbIvJht7zvxYQyY=;
        b=vAb5So3QJfv/c9Xx8YkT9vGb1C0ExPR7T9y7B7T5yxiIlTIIDmpeW9QieMhnENlHUx
         +XFMgcLa9rAPVthiDPg+k7H1KrmMJOixvA1xE19mlMCyIrwB+Z3/5tYxn88Ti0Hq1ePC
         ZX+KhqRpmMQS2BKBUQvP/IXjg1g739l3uj03QJbVDkoV3mjzaOn+qTa/w0HRA9K4r2h0
         t2K+VFAyP6WTaUL5trXilRhCiorqg18hUg6SC45ukNCg6oDxOYFj7LNJcadGNexvT0CZ
         pYM+7tBqVKj8NM/bQ4Y//GUB6Xrk1oukhUuLhxUbK2WGlS3w9hUtvkC/Za/7qSFbSu5v
         f35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798268; x=1778403068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+S1K9D2mcBINOkojfaHJOsrVSLjVbIvJht7zvxYQyY=;
        b=SJcSVkR5P0t2CNZ4bxad3UxjodRc1QVZm8V++vnGsSaQF96Jqq0DD/Ez8lfGvcA7f5
         sLVMVL6gR+Od9gj8jYrKz4ZVVUa0z69zLA8bsSyKLYYIKAX/XFZWol93wrxkyCEh9X5Q
         Vj8HboA5aNx+iRgkRb33xb4Arb5lb9lB1N4brFrItdeacf45wU2AhNdaNHxwN2YV6/H+
         gadsZQLmOyBr4J6uZT5hdtYTQVvEGkvGtR0mkpeS8jIKjAMqeUlaZTE7of9z6qxAT+uW
         jv99LpUEN60dfibzJ4i9oz16XXr4qxJ4Q1R+mPyWAjUAtqyvBDooebsUat2EZVz7Tikg
         nm4g==
X-Gm-Message-State: AOJu0Yx5EEK9kVc09vg1+UazLpCmrpvO8gYa5/9jrZicT4N0NC73obos
	66FiZxUFVgGn7KrwqHSFg0hFZPK+XrTNSHw91JSXu1e28bORTs9H6nc6N2xXWOXZouxVnUSUk1N
	30Zz/jd0LHw==
X-Gm-Gg: AeBDietUlbBLAcAf1l6uJVBD5llQqzJ3QP0Tbco3Vp79xI9YsqSvvrV6h8OYzTjGpID
	HtDUON4JSI+eYKUk2QuPekEAAcm8cjkKd2CVl2cLftxEtFdzjjt1dX7tssWg5xo354xifkrWYhl
	I2UoCbOv6KrjOkAyNnUImiKQLz2OUita0IF498k6sfLAZQ4WrvabPZE6G1/Ok+4sjFJqhoZkj/W
	OV2J+ZIrgpq8vkcdvppYY7v9QsHpW8vgEPxlz/X1K2liLpyot8OPQjp3i6pql2SJm9OeleXhDLj
	KmUaIwvYb5V7AnyM1pokaVBvrCRcPYF+5g13hweW0kIWdI7qvOmp0TFUYDwAy/QeI2dbZHp7yEV
	rFAxfEkqoBPavLv4cCxHtp5nIYHuNvAcmzoB4xWiuYKofR+lXLbWozw58tKNPNEqrtgOMXtuoDF
	y9o7OhgB76HEIf4tKzzGmC2Y1wKE/QHowbgkSs4sKvPQ/DY19hOjchSomdAURdzE4qYL8TPVx77
	katg5pq9g==
X-Received: by 2002:aa7:c60e:0:b0:679:1f4f:9d1a with SMTP id 4fb4d7f45d1cf-67c17e267afmr1798999a12.3.1777798268034;
        Sun, 03 May 2026 01:51:08 -0700 (PDT)
Received: from m2max ([77.241.229.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e292c2sm2368936a12.1.2026.05.03.01.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:51:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCHSET 0/5] io_uring related epoll cleanups
Date: Sun,  3 May 2026 02:49:11 -0600
Message-ID: <20260503085101.112698-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

One of the nastier things about epoll is how it allows nesting contexts
inside each other, leading to the necessity of loop detection and the
issues that have come with that.

I don't believe there's any reason to support nesting on the io_uring
side, in fact IORING_OP_EPOLL_CTL is a historical mistake, imho. But
let's at least try and contain the damage and disallow nested contexts
from our side.

 fs/eventpoll.c            | 86 +++++++++++++++++++--------------------
 include/linux/eventpoll.h |  8 ++++
 io_uring/epoll.c          | 18 +++++++-
 3 files changed, 65 insertions(+), 47 deletions(-)

-- 
Jens Axboe

