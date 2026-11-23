Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477981;
	b=W+qVgBvilz7jD28x9LpurXlSabcxzj8thS1brg+MujOj3l4oBiZvwzDazHKoiTC+ZsUn
	 gHNQtMmf+QK7rN5nxi6DuO5akVgvT/GFGTWvklPYafzAMAgWoCEJVlxYZQRq1ahFWNYTW
	 6P8Bm3xUKkCiTORW1B0BhahaZde3ul2c8OnUyyn7Acq88nxFa3xwTe2q/gRz3crRfBCC1
	 NRPVkuAwNjiZ3rilfDnaXaYEr9CR8IRz7MxbZ+ZRhuTalJSDo2M7/QnS5dC59YaI22pEt
	 /VlmJFbbUv4HVFQMSYrBVyvEYXmGifRmfvCGnajQCKUbGs6MJGGEkO+hZmOmuGBHRRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=t9R+ZhJLVRQZ6TU9eO+IUsJlMED8zPj1Twrn9PsgD0A=;
	b=Sj1hZei5GVCWmWzBDCJAFhrnylztGleaAzgaXI31aqOyXXLx7Cu9cUAE/V2G9prlvWlL
	 aP8SxvJR+EYy6BcHIAkk33oBo5j0ndtJC0VR/+U7vw3vxq+ZWYOzJydSpCVMUF/LzpdXu
	 YN0VIvpreirT+O1x0wQQoNW3JBpJsjMCXsLUVN+3p1ttn/1ZkzPFxxcOZfz4GCt6Mt5Im
	 utabxFvbVQhO2LxmDs22Y43tB528ZDIje3hRgHloYwQOrQ1rHQUcOTeec5WCGCweNxWKl
	 4Cv/p8CLQbsMwy/d08ath068ByQq+cd7sPOB3MPhMyJzSbcbBeptxlJZhjBjxSo0LPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ESePs0Zz;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E786606A31E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 23:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E786606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ESePs0Zz
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d427836e9so537733366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 15:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795477973; x=1796082773; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9R+ZhJLVRQZ6TU9eO+IUsJlMED8zPj1Twrn9PsgD0A=;
        b=ESePs0ZzSggI+VzMWqelC4Yx0zHIrVU87QR1fMX4XPfmdG5ClB1PY3Ip3Of0c5//5Y
         HglffGog0hkfe7vnaak2YbVQpddDyL2dVK5d4ZZ8QlSgVFHiJeAnKJvjBtiMGXVJYNKb
         yzV2wrPglrHFGI9j3ghtnsEACh6foF73mbzjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477973; x=1796082773;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9R+ZhJLVRQZ6TU9eO+IUsJlMED8zPj1Twrn9PsgD0A=;
        b=HKqoDw/AVuQfxftveCOJJJ4uQ+dHsPRuJlJIkImk/fR/Jy+/LoibFSkEJLFupLTA4u
         E3+RBDmb3aywnrIUWUNMrEiPaJzR2liZFbh/y21O21aaawK/L+ZTVEzZU+2jjybPPrwR
         k44madqKJs/dphbg4d26eTrA8o/VWmnP3CjusFIsVwJtqSlm073azTKXBy+cJIETRWqN
         W1DVLWgTixFswE8AGNceY+kFc2cM8MRv9pKCTuG3j1ukTWc7KATD/aF1l2EyTha1qgQ2
         eG1sFkRP7dZeh+KyyN6vC8I7LEJlk9AmVEc2zGcGfTClGvBZcZNSllhSaA3DqTC+fD5E
         iEyQ==
X-Forwarded-Encrypted: i=1; AL+hErFWSep6hkVEkK2cQwhmrnCCZPMO5YnfURhPTWfeKkLdUWa/y9YEyAd1B90mXQGRvEpBYdaiT2doNo5ty2pY@vger.kernel.org
X-Gm-Message-State: APuU4Z/cApH5+Uh07lhCQJv7YPL0gVVYMUe8I3yCE0lc6MeQP4wwRi0F
	ogFEf2niiPnv7Ewsku3LXEhLrkKk0WzKk1IwUs9nbaIDW3dHde05kLiPdfQpey/azH9XtVZsdvq
	ZDNIca3Y=
X-Gm-Gg: AZFdTZcZGYqZd6IjM2B698E+iIw9jl26WYCwXMA76BGoWfLHgf2Ex4l83ciWjmp6xvC
	rvh/2gMmfADO9PF/hEY2jdl9FAl/3Qe+tCJA4TZ7AE6ighhrnWUSm4D9fwdgfyp7n79zH9epSH0
	IEx8LfESGvW8ddwFwoT/De74RnFYkFIG04whCLHum7FPVaiFgsmwRzw+gYt7b3BInIrXBX4CcPi
	2Pvlx2PO1PYccNx5pwVGyIX2CDU0y+grsLTQ5Uh1yjNQfAWNYWcFuxUmSgz4xo7B5VPo9j9rsmb
	dALL10kBrZ3JKdZk/R9P6fJLjSl+HfxNtr50KV/6AmMEqnnn+lWNRY+CTvhgfgT/L864y5fEIq7
	XUxym6XWE+eoPHTj31jccb3KWMXpanbxpGMXlfBt5MqIVgm8B/nmUH5dJlQm8qkZQCpHTrSViH9
	tcz/TrP+3knVSDB6AQrz3H6a6HVHUc74sWVA3EjEm5Dd4oue8DVBSxwCAbm1CKkjwOKjnA8RhUg
	paisyioQUej2CRjedfVszo6X5kPi9Rm+991XT/yaeefgPGb5mlpwZDi0nHIHBv8CmYEftBxiPwE
	m2+dFQKM8ikPmoFZvb3zLkmH1lQqM950R9ZTpdPhMWMvMT5V4nX0fpLQi9BwPrTWta8qzkcko3E
	RqH8=
X-Received: by 2002:a17:906:e24c:b0:c2b:f3d5:2090 with SMTP id a640c23a62f3a-c513ab1dca1mr709653566b.27.1795477973125;
        Mon, 23 Nov 2026 15:52:53 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afeca8dsm457239766b.75.2026.11.23.15.52.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 15:52:52 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d427836e9so537732266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 15:52:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGKM8S/LO6adHu4hm9ehvbICWxjR2bo2UUKyt/xJ+n60s3dV9E7lIE99fqdZNZPYXvTKvdKiRbNqJjyMZLV@vger.kernel.org
X-Received: by 2002:a17:907:934c:b0:c51:282b:5489 with SMTP id
 a640c23a62f3a-c513a4aea3bmr1033595066b.3.1795477972186; Mon, 23 Nov 2026
 15:52:52 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 15:52:51 -0800
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu> <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 15:52:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
X-Gm-Features: Aa3M54pEsdOqyFc5KVu7dlQgkogc1dFe3WsuMPH19Iy8jaujyc-mlv_689cT_78
Message-ID: <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the
 head in do_wait_intr*()
To: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Nov 2026 at 16:35, Mani Tofigh via B4 Relay
<devnull+mt4022.columbia.edu@kernel.org> wrote:
>
> A task blocked in read() on an eventfd or timerfd can sleep forever
> while the file is readable, if an epoll(EPOLLEXCLUSIVE) watcher of the
> same file was added before it.

Honestly, I don't think this is the right approach.

We need to fix the disaster area that is epoll, rather than work around
more epoll bugs elsewhere and make other places more fragile and
complex.

I think we should stop playing games with wait-queue ordering entirely.

The problem WQ_EXCLUSIVE tries to fix is the thundering herd issue, and
I think we could afford to just always walk the whole wait-queue list -
just not wake up multiple exclusive waiters.

The wait-queue traversal itself was never the problem, and stopping
early was a premature optimization that causes these kinds of problems.

For example, right now that ordering means not only that we have that
subtle __add_wait_queue_entry_tail() vs __add_wait_queue() thing - we
also have that disgusting WQ_FLAG_PRIORITY thing.

I think the (single) user of add_wait_queue_priority_exclusive() should
just walk the queue itself, and not mess up the global wait queue logic
with its braindamage.

It's literally just kvm eventfd that is being special - and it's the "my
mom told me I'm special" kind of special, not the "it's really important
and fundamental" kind of special.

The whole hypervisor WQ_FLAG_EXCLUSIVE | WQ_FLAG_PRIORITY games should
be removed from the core entirely and the those eventfd things should
move to their own helpers that nobody else needs to care about.

And I think we should always add new waiters to the end of the queue,
and stop any other games. Just walk the whole queue at wakeup time.

Finally, I think we should make the return value from the wakeup
function be a bitmask, and count "exclusive" as only "we haven't seen
this bit returned yet". And then *real* exclusive users that actually
guarantee that they react to the wakeup return all bits set, but the
sh*t-for-brains garbage that is "epoll" only returns its own bit set -
so we only wake up *one* epoll user, but we wake up other users anyway,
because epoll clearl yis lying about its "exclusivity".

Because trying to fix the mess that epoll has caused is not worth it. We
need to just accept the fact that epoll is garbage, but we also need to
fundamentally make that garbage not mess with the rest of the kernel.

Anyway, because I wanted to see who plays games with the wake-up
function, and because that thing is horribly named ('func' - not exactly
unambiguous), I did the attached patch. It makes it a bit more obvious
who actually uses anything but the normal wakeup functions.

It incidentally also made it obvious that very few people knew about out
'init_wait_func()' helper. We had a couple of users. But we had more
users that did

        init_wait(wait);
        wait->func = im_so_special_wake_fn;

by hand instead. And memcontrol-v1 - that everybody loves - didn't do
even that, but seemed to write things out by hand entirely.

And the i915 driver did its own thing entirely and re-implemented the
whole wakeup side. Christ. nilfss is doing something odd too.

No, this patch has not been tested. It seems to compile, at least on
x86-64 allmodconfig.

Comments? Would anybody be willing to do a deep dive into the whole
wakeup situation? I'd also love to make the wakeup functions return void
instead of the number of things woken - because of that whole "exclusive
would be better off not entirely exclusive" issue, but it looks like the
sbitmap code actually uses it. Nobody else seems to.

Added Jens because he's the sbitmap person.

               Linus

--- untested patch just because I couldn't tell who played games ---

 drivers/gpu/drm/i915/display/intel_display_rps.c |  2 +-
 drivers/gpu/drm/i915/i915_active.c               |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c             | 10 +++++-----
 drivers/gpu/drm/radeon/radeon_fence.c            |  2 +-
 fs/dax.c                                         |  9 +++------
 fs/eventpoll.c                                   |  3 +--
 fs/gfs2/glock.c                                  |  3 +--
 fs/nfs/nfs4proc.c                                |  3 +--
 fs/nilfs2/segment.c                              |  2 +-
 include/linux/sbitmap.h                          |  2 +-
 include/linux/wait.h                             | 12 ++++++------
 include/linux/wait_bit.h                         |  2 +-
 io_uring/io-wq.c                                 |  2 +-
 io_uring/rw.c                                    |  2 +-
 kernel/sched/wait.c                              |  4 ++--
 kernel/sched/wait_bit.c                          |  8 ++++----
 mm/filemap.c                                     |  6 ++----
 mm/memcontrol-v1.c                               |  5 +----
 18 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_rps.c
b/drivers/gpu/drm/i915/display/intel_display_rps.c
index 2f8248458826..fa707a144d5b 100644
--- a/drivers/gpu/drm/i915/display/intel_display_rps.c
+++ b/drivers/gpu/drm/i915/display/intel_display_rps.c
@@ -68,7 +68,7 @@ void intel_display_rps_boost_after_vblank(struct
drm_crtc *crtc,
 	wait->fence = dma_fence_get(fence);
 	wait->crtc = crtc;

-	wait->wait.func = do_rps_boost;
+	wait->wait.wake_up_fn = do_rps_boost;
 	wait->wait.flags = 0;

 	add_wait_queue(drm_crtc_vblank_waitqueue(crtc), &wait->wait);
diff --git a/drivers/gpu/drm/i915/i915_active.c
b/drivers/gpu/drm/i915/i915_active.c
index b2442f05825e..1c207ddab5ba 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -666,7 +666,7 @@ static int __await_barrier(struct i915_active
*ref, struct i915_sw_fence *fence)
 	}

 	wb->base.flags = 0;
-	wb->base.func = barrier_wake;
+	wb->base.wake_up_fn = barrier_wake;
 	wb->base.private = fence;
 	wb->ref = ref;

diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c
b/drivers/gpu/drm/i915/i915_sw_fence.c
index f24f616e23ee..156a65f009eb 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -161,7 +161,7 @@ static void __i915_sw_fence_wake_up_all(struct
i915_sw_fence *fence,
 			if (pos->flags & I915_SW_FENCE_FLAG_FENCE)
 				list_move_tail(&pos->entry, continuation);
 			else
-				pos->func(pos, TASK_NORMAL, 0, continuation);
+				pos->wake_up_fn(pos, TASK_NORMAL, 0, continuation);
 		}
 	} else {
 		LIST_HEAD(extra);
@@ -174,7 +174,7 @@ static void __i915_sw_fence_wake_up_all(struct
i915_sw_fence *fence,
 				if (pos->flags & I915_SW_FENCE_FLAG_FENCE)
 					wake_flags = fence->error;

-				pos->func(pos, TASK_NORMAL, wake_flags, &extra);
+				pos->wake_up_fn(pos, TASK_NORMAL, wake_flags, &extra);
 			}

 			if (list_empty(&extra))
@@ -291,7 +291,7 @@ static bool __i915_sw_fence_check_if_after(struct
i915_sw_fence *fence,
 		return true;

 	list_for_each_entry(wq, &fence->wait.head, entry) {
-		if (wq->func != i915_sw_fence_wake)
+		if (wq->wake_up_fn != i915_sw_fence_wake)
 			continue;

 		if (__i915_sw_fence_check_if_after(wq->private, signaler))
@@ -309,7 +309,7 @@ static void
__i915_sw_fence_clear_checked_bit(struct i915_sw_fence *fence)
 		return;

 	list_for_each_entry(wq, &fence->wait.head, entry) {
-		if (wq->func != i915_sw_fence_wake)
+		if (wq->wake_up_fn != i915_sw_fence_wake)
 			continue;

 		__i915_sw_fence_clear_checked_bit(wq->private);
@@ -375,7 +375,7 @@ static int __i915_sw_fence_await_sw_fence(struct
i915_sw_fence *fence,

 	INIT_LIST_HEAD(&wq->entry);
 	wq->flags = pending;
-	wq->func = i915_sw_fence_wake;
+	wq->wake_up_fn = i915_sw_fence_wake;
 	wq->private = fence;

 	i915_sw_fence_await(fence);
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c
b/drivers/gpu/drm/radeon/radeon_fence.c
index 8e9402b8811b..d254278d0cb5 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -409,7 +409,7 @@ static bool radeon_fence_enable_signaling(struct
dma_fence *f)

 	fence->fence_wake.flags = 0;
 	fence->fence_wake.private = NULL;
-	fence->fence_wake.func = radeon_fence_check_signaled;
+	fence->fence_wake.wake_up_fn = radeon_fence_check_signaled;
 	__add_wait_queue(&rdev->fence_queue, &fence->fence_wake);
 	dma_fence_get(f);
 	return true;
diff --git a/fs/dax.c b/fs/dax.c
index 9d161d7ef3ef..4e8cad4dcb95 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -215,8 +215,7 @@ static void *get_next_unlocked_entry(struct
xa_state *xas, unsigned int order)
 	struct wait_exceptional_entry_queue ewait;
 	wait_queue_head_t *wq;

-	init_wait(&ewait.wait);
-	ewait.wait.func = wake_exceptional_entry_func;
+	init_wait_func(&ewait.wait, wake_exceptional_entry_func);

 	for (;;) {
 		entry = xas_find_conflict(xas);
@@ -248,8 +247,7 @@ static void *wait_entry_unlocked_exclusive(struct
xa_state *xas, void *entry)
 	struct wait_exceptional_entry_queue ewait;
 	wait_queue_head_t *wq;

-	init_wait(&ewait.wait);
-	ewait.wait.func = wake_exceptional_entry_func;
+	init_wait_func(&ewait.wait, wake_exceptional_entry_func);

 	while (unlikely(dax_is_locked(entry))) {
 		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
@@ -279,8 +277,7 @@ static void wait_entry_unlocked(struct xa_state
*xas, void *entry)
 	struct wait_exceptional_entry_queue ewait;
 	wait_queue_head_t *wq;

-	init_wait(&ewait.wait);
-	ewait.wait.func = wake_exceptional_entry_func;
+	init_wait_func(&ewait.wait, wake_exceptional_entry_func);

 	wq = dax_entry_waitqueue(xas, entry, &ewait.key);
 	/*
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index b959af04772c..0e13477f8be5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2333,8 +2333,7 @@ static int ep_poll(struct eventpoll *ep, struct
epoll_event __user *events,
 		 * performance issue if a process is killed, causing all of its
 		 * threads to wake up without being removed normally.
 		 */
-		init_wait(&wait);
-		wait.func = ep_autoremove_wake_function;
+		init_wait_func(&wait, ep_autoremove_wake_function);

 		spin_lock_irq(&ep->lock);
 		/*
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d22a088c66cd..cd3ad3cb91a8 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1009,8 +1009,7 @@ static struct gfs2_glock
*find_insert_glock(struct lm_lockname *name,
 	struct gfs2_glock *gl;

 	wait.name = name;
-	init_wait(&wait.wait);
-	wait.wait.func = glock_wake_function;
+	init_wait_func(&wait.wait, glock_wake_function);

 again:
 	prepare_to_wait(wq, &wait.wait, TASK_UNINTERRUPTIBLE);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6759fa61b9b4..d817d12249da 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7757,8 +7757,7 @@ nfs4_retry_setlk(struct nfs4_state *state, int
cmd, struct file_lock *request)
 	if (!test_bit(NFS_STATE_MAY_NOTIFY_LOCK, &state->flags))
 		return nfs4_retry_setlk_simple(state, cmd, request);

-	init_wait(&waiter.wait);
-	waiter.wait.func = nfs4_wake_lock_waiter;
+	init_wait_func(&waiter.wait, nfs4_wake_lock_waiter);
 	add_wait_queue(q, &waiter.wait);

 	do {
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index af0c3560444f..ec14365762c2 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2297,7 +2297,7 @@ static void nilfs_segctor_wakeup(struct
nilfs_sc_info *sci, int err, bool force)
 			atomic_set(&wrq->done, 1);
 		}
 		if (atomic_read(&wrq->done)) {
-			wrq->wq.func(&wrq->wq,
+			wrq->wq.wake_up_fn(&wrq->wq,
 				     TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
 				     0, NULL);
 		}
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index cc7ad189caa5..6317a60d8df2 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -595,7 +595,7 @@ struct sbq_wait {
 		.sbq = NULL,							\
 		.wait = {							\
 			.private	= current,				\
-			.func		= autoremove_wake_function,		\
+			.wake_up_fn	= autoremove_wake_function,		\
 			.entry		= LIST_HEAD_INIT((name).wait.entry),	\
 		}								\
 	}
diff --git a/include/linux/wait.h b/include/linux/wait.h
index b3e94c71cd3e..0252fc690b26 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -28,7 +28,7 @@ int default_wake_function(struct wait_queue_entry
*wq_entry, unsigned mode, int
 struct wait_queue_entry {
 	unsigned int		flags;
 	void			*private;
-	wait_queue_func_t	func;
+	wait_queue_func_t	wake_up_fn;
 	struct list_head	entry;
 };

@@ -46,7 +46,7 @@ struct task_struct;

 #define __WAITQUEUE_INITIALIZER(name, tsk) {					\
 	.private	= tsk,							\
-	.func		= default_wake_function,				\
+	.wake_up_fn	= default_wake_function,				\
 	.entry		= { NULL, NULL } }

 #define DECLARE_WAITQUEUE(name, tsk)						\
@@ -81,7 +81,7 @@ static inline void init_waitqueue_entry(struct
wait_queue_entry *wq_entry, struc
 {
 	wq_entry->flags		= 0;
 	wq_entry->private	= p;
-	wq_entry->func		= default_wake_function;
+	wq_entry->wake_up_fn	= default_wake_function;
 }

 static inline void
@@ -89,7 +89,7 @@ init_waitqueue_func_entry(struct wait_queue_entry
*wq_entry, wait_queue_func_t f
 {
 	wq_entry->flags		= 0;
 	wq_entry->private	= NULL;
-	wq_entry->func		= func;
+	wq_entry->wake_up_fn	= func;
 }

 /**
@@ -1228,7 +1228,7 @@ int autoremove_wake_function(struct
wait_queue_entry *wq_entry, unsigned mode, i
 #define DEFINE_WAIT_FUNC(name, function)					\
 	struct wait_queue_entry name = {					\
 		.private	= current,					\
-		.func		= function,					\
+		.wake_up_fn	= function,					\
 		.entry		= LIST_HEAD_INIT((name).entry),			\
 	}

@@ -1237,7 +1237,7 @@ int autoremove_wake_function(struct
wait_queue_entry *wq_entry, unsigned mode, i
 #define init_wait_func(wait, function)						\
 	do {									\
 		(wait)->private = current;					\
-		(wait)->func = function;					\
+		(wait)->wake_up_fn = function;					\
 		INIT_LIST_HEAD(&(wait)->entry);					\
 		(wait)->flags = 0;						\
 	} while (0)
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index af077ed4caf6..0bec1e7ea485 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -41,7 +41,7 @@ int wake_bit_function(struct wait_queue_entry
*wq_entry, unsigned mode, int sync
 		.key = __WAIT_BIT_KEY_INITIALIZER(word, bit),			\
 		.wq_entry = {							\
 			.private	= current,				\
-			.func		= wake_bit_function,			\
+			.wake_up_fn	= wake_bit_function,			\
 			.entry		=					\
 				LIST_HEAD_INIT((name).wq_entry.entry),		\
 		},								\
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 9609ae50dbd7..faf159d37026 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1409,7 +1409,7 @@ struct io_wq *io_wq_create(unsigned bounded,
struct io_wq_data *data)
 	wq->acct[IO_WQ_ACCT_UNBOUND].max_workers =
 				task_rlimit(current, RLIMIT_NPROC);
 	INIT_LIST_HEAD(&wq->wait.entry);
-	wq->wait.func = io_wq_hash_wake;
+	wq->wait.wake_up_fn = io_wq_hash_wake;
 	for (i = 0; i < IO_WQ_ACCT_NR; i++) {
 		struct io_wq_acct *acct = &wq->acct[i];

diff --git a/io_uring/rw.c b/io_uring/rw.c
index cf20597ba6a8..3e29bf8a1e57 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -804,7 +804,7 @@ static bool io_rw_should_retry(struct io_kiocb *req)
 	    !(req->file->f_op->fop_flags & FOP_BUFFER_RASYNC))
 		return false;

-	wait->wait.func = io_async_buf_func;
+	wait->wait.wake_up_fn = io_async_buf_func;
 	wait->wait.private = req;
 	wait->wait.flags = 0;
 	INIT_LIST_HEAD(&wait->wait.entry);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index f8d6d8b9d03e..5339faf2c84d 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -105,7 +105,7 @@ static int __wake_up_common(struct wait_queue_head
*wq_head, unsigned int mode,
 		unsigned flags = curr->flags;
 		int ret;

-		ret = curr->func(curr, mode, wake_flags, key);
+		ret = curr->wake_up_fn(curr, mode, wake_flags, key);
 		if (ret < 0)
 			break;
 		if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
@@ -269,7 +269,7 @@ void init_wait_entry(struct wait_queue_entry
*wq_entry, int flags)
 {
 	wq_entry->flags = flags;
 	wq_entry->private = current;
-	wq_entry->func = autoremove_wake_function;
+	wq_entry->wake_up_fn = autoremove_wake_function;
 	INIT_LIST_HEAD(&wq_entry->entry);
 }
 EXPORT_SYMBOL(init_wait_entry);
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 348f7211b4aa..2936887fad6f 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -198,10 +198,10 @@ void init_wait_var_entry(struct
wait_bit_queue_entry *wbq_entry, void *var, int
 			.bit_nr = -1,
 		},
 		.wq_entry = {
-			.flags	 = flags,
-			.private = current,
-			.func	 = var_wake_function,
-			.entry	 = LIST_HEAD_INIT(wbq_entry->wq_entry.entry),
+			.flags	    = flags,
+			.private    = current,
+			.wake_up_fn = var_wake_function,
+			.entry	    = LIST_HEAD_INIT(wbq_entry->wq_entry.entry),
 		},
 	};
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index a1b2ca5b933c..931de8fedc36 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1263,8 +1263,7 @@ static inline int folio_wait_bit_common(struct
folio *folio, int bit_nr,
 		thrashing = true;
 	}

-	init_wait(wait);
-	wait->func = wake_page_function;
+	init_wait_func(wait, wake_page_function);
 	wait_page.folio = folio;
 	wait_page.bit_nr = bit_nr;

@@ -1430,8 +1429,7 @@ void softleaf_entry_wait_on_locked(softleaf_t
entry, spinlock_t *ptl)
 		thrashing = true;
 	}

-	init_wait(wait);
-	wait->func = wake_page_function;
+	init_wait_func(wait, wake_page_function);
 	wait_page.folio = folio;
 	wait_page.bit_nr = PG_locked;
 	wait->flags = 0;
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index b7f286888507..cc5c64cbdfff 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1053,10 +1053,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
 		goto cleanup;

 	owait.memcg = memcg;
-	owait.wait.flags = 0;
-	owait.wait.func = memcg_oom_wake_function;
-	owait.wait.private = current;
-	INIT_LIST_HEAD(&owait.wait.entry);
+	init_wait_func(&owait.wait, memcg_oom_wake_function);

 	prepare_to_wait(&memcg_oom_waitq, &owait.wait, TASK_KILLABLE);
 	mem_cgroup_mark_under_oom(memcg);
