Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542101;
	b=t22ucOLEWr9PH+Jgf1JIjgjk/nTPz9giMP7/o2SgWLoIzqqkZ8//FKk1C3OYnZiWe38U
	 Xl4EB4nRsnMCDpubO5QALrnCpiD7WXK/WGZCSluzxE07fMA0LwlWxWL512cRwKf5mOQ6C
	 F6bR09R8wEifqSpMhACmL5pa71z/RISWIMr+643DSC89v9qvNBTQEVeAWtFy8ldut2xWo
	 9jWgcwrjMvucpLi01bNOmMeI7sdfmIt0IWzJSbNBjvZ8N5Jzl3U1uoe7GQDsLE5UTdq77
	 xVwq92mD6AAzd9cIYon2o7F3DkivpIwL4QTU9JTBWWv6HIFXzY2YSjqEyvrBk7ZDt9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rdbIPLbNoSXfxt5E2JpRO3kuiR7QU2SVdk+WTPinAPI=;
	b=Ln3dj+nMcnGsho7vxGq560XcYAA6gI1s7ufY5/Yd7jqXU/Y2MZn9b82qqr5EaJkmFIfW
	 3TD1xYlpu8tMeebRUw8dPEV1XXNnXW6FDumlDGElODlKNb8gaIiZSnZzIT4FFhEMbpJNL
	 S3fxaF2goVoGScm9G7BwxlXjzDAY4J7kNEB59vd4Ex9F2X9UPzPj9zTONAIB/fPsXYMee
	 YQay0qnNuKvlWCmJ3NTuuIi4bR+hih6vTRhyuIxv78nQbS/iYjr3mwlzwct28Q21TCWZ3
	 y+HzNlEe6SMNCNYSZekafTAe2yzAO70oO9zb/6VpOVfGyqiIS0S6L0FkoieZhzMUKiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Rl5dKBiB;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C03606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 17:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C03606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Rl5dKBiB
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50aaad19fbso535302466b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542099; x=1796146899; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdbIPLbNoSXfxt5E2JpRO3kuiR7QU2SVdk+WTPinAPI=;
        b=Rl5dKBiBxA2Fdvv41BvNmLjgbq3noW7FUqPljB6NJSlZxA0iZ3FQo4b8JsynvqLkr4
         24UbubxDg2lGC3yGOVegs4cMHmp9Vq0C4FanDJweIXYKLRXrfAaVwL2vGuamIQnLEw4o
         pmGAIditiaG+7nnGE0UjIIUxcQ64PEOxPGc60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542099; x=1796146899;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rdbIPLbNoSXfxt5E2JpRO3kuiR7QU2SVdk+WTPinAPI=;
        b=IDOwM5lWeqCkT5goWlhAdwBLcvtNO7w2Kg5GBk70oZJ24WZidWl0/YbjxbwNnd/jXR
         THpp0YvbdYx88X6DmohzOdMMZdxMjtcyH3V1KIUJ0EH+cKhCXkMj/2CW4d6T0qjTCpkb
         h1hcQA7xou9wZEDmtvHeEJ45cZIE/wIZRqdEzDjd4Ua2Z3RbYoMybJUQUdqX6znabpdq
         fWoxo7A7ezgs4h4uHsQpuovJCRepzg0SMkuQoSdKWHHBV6bAXLKL3kG2eeUJuchU6joS
         +oNKtYNXH7Yz0ZfdiZdMt2YK7/tvZQoQetGjUaqDrbpq92+wM0CADhiVS5Mrz9K6anP4
         AsIg==
X-Forwarded-Encrypted: i=1; AL+hErE0CuZ6a+ZOm0KZ03LsnUuiCsYFczUPWRnXHOezTfIuHQQzxriSaj5OCnRhbKZFvGamNbk5tjrdk8V042hL@vger.kernel.org
X-Gm-Message-State: APuU4Z/RCi4GdFzt5SzsLPERzDUD4LfheVkOnSTxAoXAHJJhh401Hpgh
	MdTKY8MD5pPfO9Xu+m4XmgJpHQWwtKE6aeWNfbgW5fYZeg9Vp7s31jfC8z3f9L4izPhgNbFsVEe
	g7n61O4UWnQ==
X-Gm-Gg: AZFdTZcsVTtcx5c6bDUznvsvmdWXgVSD8GB/a9hKDG1XqdNX16xmva0K/8jEm5TDdYs
	XqVVnNa+jdDCX7AecE8YmHxjsB3lSqbRA/a4f0IXveJo37Mm6gO/9EoV7MfObYWMjQoxd7SX43w
	6/YODBihXz/fdIQ30IIOYj+GIv6+QLM2sZ3N6ukXQGrYZ5FBPVcAi2DEiD/KOz+imkse8aTb7Oo
	xUj+F+G1+1nP/Mlt953EesfDROy4ujrivoNPuM5ZPKtwihxPR7iKk8mF+RFnuzVKAf9d1U9exeN
	C6b4gBKs0QdJUk3niyuJWeeaVS1Uw35xyMBbzxLByiOlSlO9wpGu81imU++IH9LinL8aZ2TxndC
	3RmAARUrRJSh/KjLg6EuiGma15fejmTkwNBlHmOgHgjbLG5EtCCATMh3c5P58JHkBsQ+VG6MB8I
	G05xwg2lUOTb078OkYc029Foy8J/hWvRNooGjgQXADnXPekHY4VeH3psCXKhTPURyqZtvlxtwnz
	+kHrnl7ro+E7KAibqAWFxqP1rm8U3LwVZXfEibVk6E9Z7j3nqh2FN9qMFqz9g4UFcjWlQB5EBWG
	P1rrBXIC6dBKeuvQAJHVNwu8QX9J101e6wTOWAoTHE+85hMy1wfdxWM5XGo0/a7SaTxqSl10k4I
	HRNg=
X-Received: by 2002:a17:906:cb83:b0:c46:645f:cedc with SMTP id a640c23a62f3a-c513aada3bcmr1006543166b.46.1795542099527;
        Tue, 24 Nov 2026 09:41:39 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea8063sm542236166b.45.2026.11.24.09.41.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:41:38 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c50aaad19fbso535298766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:41:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGzdqJhET0l8G7hfMSHi6IRPIw2ZT99ohRIgW+fT3nPYwEY/w+ekqkjIEzNptX3BGjMJKQP/S+xvlJDwPKk@vger.kernel.org
X-Received: by 2002:a17:906:c104:b0:c2a:ad55:b3fa with SMTP id
 a640c23a62f3a-c513a434889mr1247420466b.7.1795542098082; Tue, 24 Nov 2026
 09:41:38 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
In-Reply-To: <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Nov 2026 09:41:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
X-Gm-Features: Aa3M54q3giT6wo2ga7GChn7kXWVMXAxnqCpSq2XjR2x6cUYwfDCbSn9Uo_kXYu4
Message-ID: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the
 head in do_wait_intr*()
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 08:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 24 Nov 2026 at 05:36, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Well. It is not that I like this idea (and I bet neither you ;) but
> > we can add WQ_FLAG_EPOLLEXCLUSIVE set by ep_ptable_queue_proc() and
> > __io_queue_proc(), and change __wake_up_common() to check it
>
> Yes. I called it WQ_FLAG_POLL_EXCLUSIVE. Let me send out a series
> after I've cleaned it up a bit.

Ok, let's see if this works. It's been "tested" in the sense that I'm
running a kernel with these in place right now, and it all *looks*
obvious and builds clean both on allmodconfig and on my local kernel
config.

I'll send out the seven patches as replies to this email, but for
people who prefer git, it's also in my repo as
'review/wait-tail-only'.

It doesn't *really* add all waiters to the tail like that branch names
implies, but it's a big step in that direction.

Please comment and review. The shortlog and total diffstat both look
very reasonable to me (but I'm obviously biased):

  sctp: don't let a blocked reader take write-space wakeups
  sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user space waiters
  eventpoll: don't claim real exclusivity for EPOLLEXCLUSIVE
  io_uring/poll: don't claim real exclusivity for EPOLLEXCLUSIVE
  sched/wait: always queue new waiters at the tail
  sched/wait: remove __add_wait_queue_entry_tail()
  sched/wait: remove the __add_wait_queue_*exclusive() helpers

 block/blk-iocost.c                   |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c |  2 +-
 fs/eventpoll.c                       | 12 +++++----
 fs/orangefs/orangefs-bufmap.c        |  9 ++++---
 fs/ubifs/journal.c                   |  4 ++-
 include/linux/wait.h                 | 31 +---------------------
 io_uring/poll.c                      |  8 +++---
 kernel/locking/percpu-rwsem.c        |  2 +-
 kernel/sched/wait.c                  | 51 +++++++++++++++++++++++-------------
 mm/filemap.c                         |  6 ++---
 net/sctp/socket.c                    | 11 +++++++-
 11 files changed, 69 insertions(+), 69 deletions(-)

and the core changes actually remove more lines than they add even if
the end result is a wash at equal number of lines added and deleted.

That net/sctp/socket.c thing really looks like a real bug-fix to me,
for example.

I dropped my rename patch because it's big and would distract from
this all, but I think it would be healthy to do eventually regardless.

NOTE! I obviously did *not* test the epoll or io_uring side, but I
really think those changes are also very real bug-fixes and the
current situation is just bad.

So I'd honestly rather do this series for back-porting than add even
more complexity to the waitqueues - and not even fix the fundamental
bugs.

But hey - feel free to tell me otherwise. Jens - I'd like you in
particular to look at the trivial io_uring changes - epoll can go DIAF
as far as I'm concerned, but io_uring really did have the same bug and
I guess we should care more.

                 Linus
