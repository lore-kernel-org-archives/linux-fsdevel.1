Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542332;
	b=Oqc+XSRdP/Y9Z2Qc77cjPL7ypVLjiTm/caep5tMU2etPaPkWqD/QVa3L12Fyj4Y0lecd
	 k/Nf5WOXZlN0T2dBiYEuU9fQmDe5nsiKfWYX9ZdRt5u/jJHQ9DUgsGg4vfH72YuEoFvC2
	 dINF4qisVVfXW7j9EFpfwUEgBOieY+O7HKXBp5Jf4C+fOyoSEJi0oLK05KgK6YKKn533F
	 mkiqvHcplYL+CzEedlQAL7THvoEK1vkEJ2XDQxDWMOZfAl+6a5CiYfMxOBLWpemBKJdQs
	 5z0/Qv8aEkxXVh3qcwXNAK2zJNV+wG/ig3BnbfUD39Z1TC2XeZ0KMlqRSpF1YQxLh8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=7sFNtdXtUVrhtQGHwvVnwDY+EIdv3UfxXRXkR9SVa5w=;
	b=RfmVlbjZKjaz7zrnwhJDoebt5HS+9GVoiDLQ9J5COOGFuVF+naaqc6BkVLmmfiHH42Si
	 w0yzG3iWH1KSgrGnUjreaVKqksdO3NmCImg67CbzwnQ52R+/y7GUKpQKDzjZLXjGsII66
	 qdQCbxl9MGFLYzboc+oxt0a60WmHM1J7QfarxRT9sIYaSJ1qo+tsgE+ovZnxCWLjVfWsl
	 te+ccX+AVsOKWDEIHXnSB3QEXBCUxm0/JLrU0/bRvnPWIdzjXMCwRZldDiPrXuu33wW6d
	 AO1I8eRPxLWch2puOQ8ulTIzCeOPiNgCYovyc8AhXPdPo3XI40lmkIoTzEceO+9NcFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=IhfsLKPy;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50975606A327
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 17:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50975606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=IhfsLKPy
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso800239066b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542330; x=1796147130; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7sFNtdXtUVrhtQGHwvVnwDY+EIdv3UfxXRXkR9SVa5w=;
        b=IhfsLKPyLfWFSpe1MZWNzuAcFb8ep2OZ6MYTNZnitSMBzM80Pk53GLhonK12/JZai0
         z3/rcVzZ1ybVKdRnjE+dDg4zSLbmavwCGTLLLyCwbn5xWUtRMIVvTG2MmsO73mAivb1L
         sGa16hogFOyNybrilpzWo5uHOetciX9hGQ4ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542330; x=1796147130;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7sFNtdXtUVrhtQGHwvVnwDY+EIdv3UfxXRXkR9SVa5w=;
        b=iSPPIks+kwJAM5DoS1pqCjl04FvlSmrCrX40d3bcZpUAF4QMKilDPfIz3CySygfQzt
         ORA097hQyrojfPTG1IfNkzhLcAE5s/OZ43Qz39e4yjFups2pwSHDcLgAxqjkp5IPqeb2
         Hh+v85XNtP4qk+dtPug83/oirper16V1xiiFYezdlGuBEPIWWEXralG30FX/byQ/XjPe
         /ShBFz+3w9FhOrqx7Q/egJIY/gQaZoZqcglXqBRBvJUkGDwEZ6h66m0w2bFeuG9g2qvS
         rkjGt/wgWO03l87D0CsrCO1fnw30Axdcdtb+d9hfF5T8W/Ebx6LHSd5zyf1eZ3AIeDFV
         x3eA==
X-Forwarded-Encrypted: i=1; AL+hErGuZUhd1UIKVCQ3K58Vx/cZ97ogNLy2mAJabvyiLH2IUZr1bOI9zpM13SVT4NZPSlZamKD0aznwMl9f4bZg@vger.kernel.org
X-Gm-Message-State: APuU4Z8BRKKTBcTnCtv5CqCEQxS9/uosXOci8vSs5ZpapVNpRrn1O1sS
	xzhqkvefIHGHQ4wbksBnURPZm7J+SJwbe4yc5/DAKfWX3gHvpY2Gveu6qO6BZNcMv5mhtmFD5pK
	4vdCHCbd8Og==
X-Gm-Gg: AZFdTZfuKn8Wh1VgiQdb1JbgoTSxSNpWNeWgnO6M8hiFbE2XmIBEuoRQZ/2VL5sTXAg
	pEmJQcaJNOfDl0ThvF5VbqAnvEJjLHh+zWHMKvDfWqKaEEomqdbRC+2Yq/VmDWVakPaaMsFLFJZ
	mSfln/CSBYClaTZ1jqLa1EgiPXPf7QPKfbPY0AjFY5E0ZjfsMFZz58sld7ZhQWXMj5IOuEuVDoU
	qVGxO3H/vnTrmAFrND2pokEY0g96K1lozmI20Col07e+oM+kCKJgtmiEQiRWmTIbTwKcH+sSaYn
	FBv1OI1J9L0nHhnHquZWkESrbh4/JCBCfpKtaiQsDl6SQIrXqyRh3ppJAYM1UhxfL5q5dCTQxs5
	hZheVJpwV8RwgIYN6fh17Y2mrRZWQkLVRtX34n2scLKYM22iupI7JRZ4SogIb3o0v6UO/sFc/vX
	4e2ViO+khU4bj0HHhM+Z29Rb7uxIGIxTdTSghC2iP0dbCe4ycJvItvsSVJ1mlH/RlbjrEK7KJHT
	pM4qzCnPcIsfs794N6mfdYUT1LiaspeihqhMOZ2D1fOJXf22vcunldv6uC502NJMiGQGx0zHb6Y
	y1cDxEGJVBOptSiGI1P5hMHdXCufnscCU++JrWc4jBe88mu+sohNy+PZWK0a2sXjRfpfqNUzt3j
	C36KUQAhlJlaKMFFsif9QdHG7
X-Received: by 2002:a17:907:f488:b0:c4d:28c7:eb21 with SMTP id a640c23a62f3a-c513a8845b9mr1210026566b.29.1795542330549;
        Tue, 24 Nov 2026 09:45:30 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm564578966b.3.2026.11.24.09.45.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:45:30 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so6578029a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:45:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHB2mjIcfajY1XZBwkP5cNtb34JO+NjqP0nY+jHsa9I20v5s4L/4OH7H9mXqZ5ZRsUJp4yaKbSN7SdtOQ8/@vger.kernel.org
X-Received: by 2002:a17:906:9c84:b0:c44:16ad:c31d with SMTP id
 a640c23a62f3a-c513a3a720fmr1358605566b.4.1795542329456; Tue, 24 Nov 2026
 09:45:29 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:45:28 -0800
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
Date: Tue, 24 Nov 2026 09:45:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjX0gjwbjbaRcyBciMoBW+EcfR+WVFDcc8GohhoCEhsg@mail.gmail.com>
X-Gm-Features: Aa3M54onNu843dCz-7VgQMSf3tc5HuV22MlsVxwl3bnIWp1HcMu2BRrmba8qoGU
Message-ID: <CAHk-=wjjX0gjwbjbaRcyBciMoBW+EcfR+WVFDcc8GohhoCEhsg@mail.gmail.com>
Subject: [PATCH 4/7] io_uring/poll: don't claim real exclusivity for EPOLLEXCLUSIVE
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:47:49 -0800
Subject: [PATCH 4/7] io_uring/poll: don't claim real exclusivity for
 EPOLLEXCLUSIVE

Same problem as epoll: an EPOLLEXCLUSIVE poll request returns 1 from
io_poll_wake() (even when it lost the ownership race and does nothing),
which stops the wakeup walk, but posting a CQE doesn't consume the
event.

Waiters queued behind it can sleep with the event pending.

Use WQ_FLAG_POLL_EXCLUSIVE, so only one io_uring entry is woken but real
waiters are not skipped.

Reported-by: Mani Tofigh <mt4022@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 io_uring/poll.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index fc1800c7097b..67bf39575238 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -533,11 +533,9 @@ static void __io_queue_proc(struct io_poll *poll,
struct io_poll_table *pt,
 	poll->head = head;
 	poll->wait.private = (void *) wqe_private;

-	if (poll->events & EPOLLEXCLUSIVE) {
-		add_wait_queue_exclusive(head, &poll->wait);
-	} else {
-		add_wait_queue(head, &poll->wait);
-	}
+	if (poll->events & EPOLLEXCLUSIVE)
+		poll->wait.flags |= WQ_FLAG_POLL_EXCLUSIVE;
+	add_wait_queue(head, &poll->wait);
 }

 static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
-- 
2.56.0.313.g975a75ca90
