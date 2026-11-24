Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542292;
	b=IAZTbMVzAEOYMdbbWkpPYkm4HY34+/rWxzcHg5stL/b3fXwsKGgp89sxAxqWoz6KtTZ/
	 inw0e6wxauN6VakOgBw0OTdheMERHjf33HVUG4ZEbOtx8OZbFcvVrQIvUETENXVDxV3cO
	 9duw6NDGehrV8fhDTsSgEE/EWsbdMnh4MJXWDB/u+4uR57B53jV9D8r35hkyhYGgW2G0h
	 yfKbBMa7fyBWFtvi/ZE6719FTXavmjHQy+OVqtOotgnyJ2Mjs6o3dQukTwlDfU+88LLpC
	 FxrLRaNHtQz+BeFd4iLBdtNh3nkeIACRFTay4gmvG0Fm9DJLQ4BTxw8RWkaxeAcvG6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=2HCzERZkMAa0F+phOseLjeAuQPdJvhT7TUINZgfRKgs=;
	b=X3X1al7uoVMl6zuya/h9V7qa/7t0so198tAYiktV/nvR/cr7ck5yfRHh82L8zDQKqoRx
	 rHjF16ed16mtvgHeuUPjGkHZjnkvteaAUgOfn87z52fm8tQXRd+Rb4SjlQ6yBghzSuYst
	 EqFyw9k0ESx12WbzQXQCxrOVYNCQ1HPs4MqFXVXZsky+6BYMfBTXJvJ1KJ6lpUDtSw0XZ
	 QUcgJbNn6r05K/cqn8vnz81lcppNOeZX/CySoUItiv6KtkmyTIoH7AM/QilFCXEE+/C03
	 rVfuAGsw7LUUvbPprZdXx9ZYCeDEBerqfREh5fZt8p7FTinnhrhm9Db88qhC/XeyBkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Bgz+0sd2;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DD606A33B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 17:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867DD606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Bgz+0sd2
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b8786bb305so5860234a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542290; x=1796147090; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HCzERZkMAa0F+phOseLjeAuQPdJvhT7TUINZgfRKgs=;
        b=Bgz+0sd2vCUqVizue/ouHx4JMKiFdZv30bav0IKAncU/QBGpCC6+bCt6f9cXYoX9Xj
         Ix9dXZHKZme8bheAlSFODXp8vuaXxS3XFMbZnCQcZUWY3aSrn6vCOSGuaztbqTpMxLsW
         JUWPCeYLSM0CzjrhzPRSCf9mwj52+xA/jy00E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542290; x=1796147090;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HCzERZkMAa0F+phOseLjeAuQPdJvhT7TUINZgfRKgs=;
        b=Mf8wzvC8kFDaoTK5B8qGuW4jvL1VX8Lt5zpfgF0IxgYvTXWABipY2LjzNWhZEiJAnV
         NrBWwvpWFTIXYW+RQTkRXbANAxlfM4C2E3CjUBTcsOzl3wks1kCspddTHKBI3XczeSwq
         enrBcZg5gWATCEwoXCsCQnxR0DhlBKbLVM0yep4ZPjBO6iWUx12WDS3OpMeyWfikwe7m
         FcJ+dDv/Gj7z16Ip7Xsam0mPcsnv9FMQb1AWosHNMHaILkYJe6H8ltFJgKHPV9mOwfnX
         eh/NKIBLbJzrCniPvROvPOC9Xq39BnCCklrUqJ0b5si+qs3hNpenVdZJjs1ueyGlbTUC
         vRIQ==
X-Forwarded-Encrypted: i=1; AL+hErGbx6nYvu8QzV3GuGv0P5nxi5wXlvmspSiAdCtTFX+sGWOzAyGmadzNTvfPkmSrrurUI0Vrl9o0+buT99bY@vger.kernel.org
X-Gm-Message-State: APuU4Z8MnsK80yxX/LNqcO7mj63giAZNlkH/MQsmQCvbV8JQF48r14u5
	eSDiaP/fOvFQzA84H+3psvVOSQ5GxMqd/iAU2Iilh3+vsALb4+CBvjDsHN8jfDf1QbR27NjnBw+
	fBQqpmz7bXw==
X-Gm-Gg: AZFdTZcdUZZyfqEENts1uy/2IPCW+JOs12xx8pOtF4viZMej+4B5JbvyANkWsBkweNu
	TSVsP9M+NYxfkYrpR8YLBbKWeybiVRnn/DVE75NmkqzJ2OgBkMwJFDYsiE1eU2kqDgMlUsXyTdS
	H0wcnU2RHr03tclE4HbhBPU7u4FGwpih2t51TvrL2F3ABZT3KCmDN5iOFCbUZ6ttrJ1/1cudfB7
	SYjtH+bCf7SkjZqFr4DBS91ALglYrNHZJxT3OKwUG20TTqvPNGLSmXV29/Bfbk98dExQ2eeRfVw
	I113KZhhrIrSLTCZ0qTPOGS4UhfiIPY7L8+zmi0tWqEYIozTlRoVDVxzw3OqzkUBPcH4fHnsFgo
	VRuAk4ddy+kD7sfdi9prmqUChVfnPlG6Abz9wMJZraLjWfKDjJ+1UXJDNhOTCtk3oizr3T/7Qru
	SZHVpI1CEWTMSdbRclkRHHzMu+BnGPlJ2ynTs1FNO46l7xWTJuhTHqD0JbUVfMphqZ8YUMPtwzC
	EVy6Zms56cfurjdqWAmJVm1qWQodrMf/68tqclK3eWot5Y1x9m/OD5/3UiK8bY59ysL5nT1H6Xe
	QFCMneOffS/QfHBKJVJg4OhY0rYnDoyrxdJ9nHEN+gGwP4OKsX0IsFRHUsUeGoNPTbn4XfdM5a4
	HckBBXER2m8atyCo6qG3faxDU
X-Received: by 2002:a05:6402:1ed4:b0:6ba:7e42:d88b with SMTP id 4fb4d7f45d1cf-6ba7e42da5dmr7382485a12.12.1795542289887;
        Tue, 24 Nov 2026 09:44:49 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3710601esm7110180a12.27.2026.11.24.09.44.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:44:49 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4322d310e7so247674866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:44:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEB6karcpPFeVGq/a4ZfSVDBUFMwPO+PVcc7QjkEHzuJjsKCMPHScxhrCcfc9jJPJv6yRwNP04O7xL1Lhyu@vger.kernel.org
X-Received: by 2002:a17:907:1b1a:b0:c50:52b4:eb04 with SMTP id
 a640c23a62f3a-c513a99a675mr1260566266b.16.1795542289327; Tue, 24 Nov 2026
 09:44:49 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:44:47 -0800
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 09:44:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgFnKO_O0fR_-O+i5yUGaDcz8_HwpM5QiLM4jPFYZb41Q@mail.gmail.com>
X-Gm-Features: Aa3M54rd4YHKjjCXWO7x8sJ23KYai1r8AxY-MCEz3hLxMYxQyxvdzJ6olX7Oaf4
Message-ID: <CAHk-=wgFnKO_O0fR_-O+i5yUGaDcz8_HwpM5QiLM4jPFYZb41Q@mail.gmail.com>
Subject: [PATCH 3/7] eventpoll: don't claim real exclusivity for EPOLLEXCLUSIVE
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:47:42 -0800
Subject: [PATCH 3/7] eventpoll: don't claim real exclusivity for
 EPOLLEXCLUSIVE

An EPOLLEXCLUSIVE entry that wakes an epoll_wait()er returns 1, and
because it was queued as an exclusive waiter that stops the wakeup walk.

But nothing makes the epoll user consume the event: it may be killed,
time out, pick another ready fd, or just not read.  Anything queued
behind the entry - a blocked pipe reader, an accept()er, a recv()er -
then sleeps with the event pending.

Queue it with WQ_FLAG_POLL_EXCLUSIVE instead: still only one epoll
instance is woken per wakeup, but real waiters are not skipped.

Reported-by: Mani Tofigh <mt4022@columbia.edu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/eventpoll.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index b959af04772c..58c0cb845dc7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1626,9 +1626,8 @@ static void ep_ptable_queue_proc(struct file
*file, wait_queue_head_t *whead,
 	pwq->whead = whead;
 	pwq->base = epi;
 	if (epi->event.events & EPOLLEXCLUSIVE)
-		add_wait_queue_exclusive(whead, &pwq->wait);
-	else
-		add_wait_queue(whead, &pwq->wait);
+		pwq->wait.flags |= WQ_FLAG_POLL_EXCLUSIVE;
+	add_wait_queue(whead, &pwq->wait);
 	pwq->next = epi->pwqlist;
 	epi->pwqlist = pwq;
 }
-- 
2.56.0.313.g975a75ca90
