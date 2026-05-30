Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2218C1F5437
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780105069; cv=none; b=I4pY87xqSNWZje+1Xf8M7ZH+hQGO3xHNHeBhz0q1LzK2Gl46bxP/WcBZPijb03pFZTyOlSgIGB8yid8LEEvLYNSoU8g2rSj15Q/xl8N2c/y1bMJjMdA17qjw35b56rQa3TBxURgfq4j/5ZTFwcT8Gk+d3VY4748V+fYQt7M9pIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780105069; c=relaxed/simple;
	bh=LHyB+JnY3kd4bb6QzQwMUTL6CC6B386HnI7zURYW23k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYcyb1FPXEMbFdr/SZhtHnTmdAnAGmRcFvkn1NmhfNro0rUivJ2q55p8SyKBAaNPfGgtNbtdLnoRP6uro9Uogj4Ex1NiNBxBsfLrpUlFQd9ge5XjwZEmXyhwNMn8jvJYwdUH2YfhZlvoT5zU65rSdbk9p5v60JgV1ay3n44m5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrxerMGg; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrxerMGg"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-304545f5206so11758792eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 18:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780105066; x=1780709866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nEddm1iPZoYFl6fvCyhLcBAQ8Jfqvmn8ZxI1n9Q+nVM=;
        b=CrxerMGgS/xl3Mrz9ts21jXH47Y5ZRfAK2eLXXrw0EpF4PDeko5P+VLto5bEmjg1Vz
         apFKu/t9v4FF+S7+MDPyoJDQXzlOFUAM4OFEshSdmecjissgTcsOZ8qEUh2Njo2UaHjM
         frbVWlWNu4pyW8+x7CztvbRzSNHU8hx/qxiZv2NKsT9sR4gFPyr3lsHZSxQ51Of8vVhq
         x9kqfGYr6+L5+rjHLzNS/pREdTP8yswHHW82keS1dGe+iIvRHoee3Bu+hfPS1VN5QEwL
         He/HRjL1znnYtKwGkad8lmZ+WK2j6SgsRE0J441qvzebcZ57I5IY7N0lfz8Xl2teNapd
         JWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780105066; x=1780709866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEddm1iPZoYFl6fvCyhLcBAQ8Jfqvmn8ZxI1n9Q+nVM=;
        b=RYCDxoP2PDf3WMdAflG97wYJm4ggxRla1aW9lcpty1mMivzy0DgK9Y85How1+8Q3On
         a+EcCnoDE6rZcoiB6faUQm1bm6Z/d4ViBJIGD3740QlOLjMy4ZaGFHOm91gaTpUVFXM0
         lq/9aPnduUXuBLAHo0W+4EjDOaRkP74XMCTmfx0/YZeqDtpzjK23ZH2i99M98YRNMNhK
         xaW629XUuluYn8fBHjts1qXhaZACtK23u6CPjHN5xVuy1/BMNK0GZdoIicoM1tJZFvm3
         f8sa69U+LaVFRJbdLhsAuV5y9Logfz0LI26tSKjw3nfuEpwSRFJUB7y/o5cFRAIdAQtt
         9/DA==
X-Forwarded-Encrypted: i=1; AFNElJ/F/+3gHR5/dm25vWWCuBCqC7YMfXy7emO2SnKwWVqxlyk+PC61hqV416fvl2epmPo9bJRRuWCtXiVh/hh8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QvVECKGYfme+oFQFjgoFizUgR49Iyqv1uK4cgVM9uNS73B6i
	+BW3qRyP4G3fxnlrNV8IlzL2Gv/XcssREeRyTFhSypT7Z18CKwi60dIQ
X-Gm-Gg: Acq92OF3JDYEXJLAdDO8g4/W1tO4Dfj/2AEbibEY2w8DbugHFsLfhtQjO3pXctv7rP8
	shpHRyXt6a6AwekJIIQDY86w+8eykKfpCiF/USR9QGkFrvG2v/WdC2sqhT/y/3Rn8l7N+Vz1ErR
	aLmVl1Du9GAeaHiVVH6oVxxGMRThP4pCLyHnyNgMWoFFNnt8cclkHBPqz9VlGRGiRBkIypx7cJc
	F/h+kSDNdR8Nyz+AQo71p/a91KWfp3SP4qiEukisEbdsKVrckR4aGgb+GV5YeKtbpQYsk4AVD+W
	Vxh7I1mhn095WlPfevpqLjBTxd52wcBWrMT9aBLfs9HLTyVHY9Cumb1RkGPUQdCXaQe/vs/bGpi
	P8JGX6Im4Hwh9j+ChIdvT0XhgDODy47q4tJzqT71bBSaYqaWu/Htyej9sx9fzhF148lrVAOwsFY
	e878bkUcRZ6Od6mDF9pWY+9WMJad8s9w==
X-Received: by 2002:a05:7300:2313:b0:2ea:c085:44b1 with SMTP id 5a478bee46e88-304fa5a7a4fmr1183998eec.19.1780105066164;
        Fri, 29 May 2026 18:37:46 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a114dsm2881199eec.24.2026.05.29.18.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 18:37:45 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: amir73il@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	repnop@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v3 0/2] fanotify: lift pidfd reporting restrictions
Date: Sat, 30 May 2026 09:37:30 +0800
Message-ID: <20260530013732.50811-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pidfd API now supports pidfds for tasks that are not thread group leaders,
but fanotify has not caught up yet. This patch set lifts that restriction and
allows fanotify to report pidfds referring the event-generating thread.

Additionally, this patch set drops the pid_has_task() check before the
pidfd_prepare() call, allowing fanotify to hand out pidfds for reaped tasks,
as suggested by Christian.

Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/

changes since v2:
 - Split the two independent changes into separate patches.

v2: https://lore.kernel.org/lkml/20260529020035.17477-1-anonymemeow@gmail.com/

AnonymeMeow (2):
  fanotify: report thread pidfds for FAN_REPORT_TID
  fanotify: allow reporting pidfds for reaped tasks

 fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

-- 
2.54.0

