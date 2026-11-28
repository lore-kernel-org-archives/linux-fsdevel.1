Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795858623;
	b=UQ+PR7QU/DPVHKmeVk8uc663hdCukIvkxY3wZ35e1RR1JnOdUWs9SrnVHJyH5FFLXRaD
	 YVgmwIfD6ygDuXZFfRuWK7zjiyss+JdpTH7+Zi88KtRx0vDIWPjlxu8/RpQfQD8WoMPtf
	 76bivg6nw1xTP91+2N0wZRtZG4CGKJV0Fhr5By8HSWLja50y5kX744XfE09qvdb8NQ57/
	 ZpJCux9L7bR2IlKXxBb0a98GkcRzfYV/Mnb9poo5zOHsdIM0BBeKNq+Ot3JWGoBpyTDnG
	 PQBl2Jkt3APR2kObrLoFzWCX+tLKh5+ZE2ACatWdqVnQJbwAr+yXhGhF7zjAFz1pamw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795858623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 In-Reply-To:References:From:Subject:To:Cc:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=BWjnfF9XDNa3hMHhMzLFnECwIvuoYJmNEMNUTfzqFtk=;
	b=JP9sCghgMDfPKu8A6qIx1wV7Qc+OOhmJ4bep8CgsMvaki0ire2QU5jajKHrRh3LomfTt
	 4vmGIGVZzxvl7M9FHfUoOtoLlnAaq9+NPa7KDS1j/GOAfn9LdIga5yIKpVGtNCaOwO8DK
	 a27clmHnwGZq/GUI3mC2xnvIlbTgU8ExS4rfJ2Idt62RPA4BUOGEIdtHhe5LKv1gZLZLz
	 j1CajfujSl3ZEe7PRxbPdMw6BpqT4/fEFKo/3oP5hp5npZRoKP5Lxj4eaMyMwwJlRWiNC
	 biIOTfcC175nOv0O6dekjpQ3pTTEAJ/5zZ9ERdJWAndeCrvW+3cRj8mJXhLKTj9xdQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=lQ+HWSjR;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3856606A31F
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 09:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3856606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=lQ+HWSjR
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b4cd576f2aso63969677b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795858622; x=1796463422; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BWjnfF9XDNa3hMHhMzLFnECwIvuoYJmNEMNUTfzqFtk=;
        b=lQ+HWSjRxdkbtAQECNMEYgbMHkueRa1Naw6JIJKoxq5GlU32jKSsORVfi1LY6atJTF
         DLYMwW4/fV1M6uJey20W/J5VzCsniHP9b8n3ZPWrIBhBF1cAt+HFdnpGBOZH+xz1cGC7
         GweFPn0brFz4rfVpMQU5XZuaKYVTxILr0vibE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795858622; x=1796463422;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWjnfF9XDNa3hMHhMzLFnECwIvuoYJmNEMNUTfzqFtk=;
        b=Tc6SLo13Jx1ZJP44Vja9orQ4IANVIHWwUgUdIWRNDnq4OnZz7ZukWm4KCSsRECGTAu
         /QYNieU5ArCBAVHZmnDxK/TjwM4hvIzK5jjFdvPCtGU0W+ZvR+pfS1Ni6fddHux2kFDz
         BEZ26HYN+N30rd8D2GNx2wf6Ey0IDok5xDN+ScUt1JzLwcisxWH2B8YjkuJtJBBwhLNQ
         UTBDk7mn8Vez4vgtyd13PUH+zg03gUDcbl2j/b1xQ1liDOahIt2rHJ843213xKyULeaZ
         sfUDsCWC9UzBROE8pLChnSDOpxMngan7zRYi/3oSuLRdDnSJ81yLOjI74GEngmENBYAY
         n/tg==
X-Gm-Message-State: APuU4Z8wzOqKCIcTzmcfYpBZhklGFPIGG/LFwbS7h1b+XA/miYW8pB2Q
	hMtWWbjnTXbyUKVJ+SN6aWP4K/H0CIWREpzwQZKCEjW0KQ4fB4Wfk8HQYw0gh7ZLBrpTSqnmALw
	F4lJI0RwmRBtZ2sY=
X-Gm-Gg: AZFdTZdLWLgEMvBGoeDu24/WjrgEs6y9T8oYDEjU5/NgGL7wHd6Gs6gnGTT+nNs3hi8
	zMhVjX6UitsRGOG7OJ1jaKWa9BX9fBR1EHboA21i5HvinlDabnTjl9F8RRVua99cF4Pn5trGyUL
	wige/GVxJVOKdBpX8xTFUlXLyhx1LOmgYI2/P76+BBZJ/rQiVNvA1L2w9O599G0vhOSyizOyFT7
	48D5u59u5eDWpzmIAYNZsuRRThkIRHo4vx00n9wuVjWBNc6g32FiortQ59uUuDqWm4mBTMSSbri
	0ihEHoF6PViQLP6wo6yyjdOuVx57HpiU4dCkWBHNn8pFEVkGeD724w/P/CVHPqu8b4Ubb+2fndy
	dMU0OmO4iWC++jNKNu4VUVGl2zrGFd38bHT9Pg/vawN5kUfqzJe7t1A1zziFa5/5aoQhYzcwaC2
	HDBIQ1YP0cU82dykp1lyHozBTXywW3pTRoECubXLshZShlYAyDyRLeSzaUjNORppOomwJ3euLh3
	VDEzRWXNx1RaQaOqYkXwjIEk3tuCwFdwzC4ah0ytemz6y6D3yGQmF5UAIb8Jx8Z07kE6Lmv2sjS
	MPUbwRgMx0HvQ7Z08z7BwcCFQhPIhWxjaFtdevaqfPcFKT80F0zxmGn4r/N84gt3SGaoYiaOqMj
	FNUokErdFHTgv8+/SnEFWwDnSfEak9Bq94POhr0kF7IDB+p1Ov1zHf4HfsjQol3P1cFIl837O1Q
	K6f0HciJH0tFQ00ZedB/pCoq1q0uDD0GaUquOQYsJOnRkYn0EWXNekshyUepCX4QIND0iqMRytG
	zLgKdXmDoYRxSx//8xBamw=
X-Received: by 2002:a05:690c:6d8a:b0:8b4:dba5:f101 with SMTP id 00721157ae682-8b5204f720cmr118184247b3.52.1795858621859;
        Sat, 28 Nov 2026 01:37:01 -0800 (PST)
Received: from [172.20.0.3] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52030df7bsm107006967b3.31.2026.11.28.01.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 01:37:00 -0800 (PST)
Date: Sat, 28 Nov 2026 01:36:59 -0800
Message-ID: <f7d42197b65bd98166440c75fff0d42d366fc377.1795855037.git.chris@chrisdown.name>
In-Reply-To: <cover.1795855037.git.chris@chrisdown.name>
References: <cover.1795855037.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v2 1/2] timerfd: Support CLOCK_TAI
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jan Kara <jack@suse.cz>,
    Anna-Maria Behnsen <anna-maria@linutronix.de>,
    Frederic Weisbecker <frederic@kernel.org>,
    Thomas Gleixner <tglx@kernel.org>,
    kernel-team@meta.com
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Despite hrtimer and POSIX timers both accepting CLOCK_TAI,
timerfd_create() rejects it. This usually corners userspace into one of
two bad options:

1. Convert TAI deadlines through CLOCK_REALTIME, which reintroduces the
   leap second exposure the application was trying to avoid in the first
   place.
2. Abandon timerfd entirely and use POSIX timers or busy wait approaches
   that do not compose well with epoll based event loops.

Avoid these bad outcomes by allowing timerfd to support CLOCK_TAI.
timerfd arms hrtimers directly and hrtimers already have a CLOCK_TAI
base, so nothing is needed to queue and expire the timers.

TFD_TIMER_CANCEL_ON_SET has to work for them as well. CLOCK_TAI moves
along when CLOCK_REALTIME is set, and it also moves when
adjtimex(ADJ_TAI) changes the TAI offset. timerfd_clock_was_set()
cancels a timer when the offset between CLOCK_MONOTONIC and
CLOCK_REALTIME differs from the one recorded for the timer. That is the
wrong offset for a CLOCK_TAI timer in two cases:

1. adjtimex(ADJ_TAI) moves CLOCK_TAI, but not CLOCK_REALTIME.
2. A leap second moves CLOCK_REALTIME, but not CLOCK_TAI.

Compare against the offset of the clock which the timer is on instead,
and put CLOCK_TAI timers on the cancel list. clock_was_set() already
notifies timerfd when the TAI offset changes, so the timekeeping side
needs no change.

With this, epoll based applications can arm TAI based file descriptor
timers natively, and can have them cancelled when CLOCK_TAI is set.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 fs/timerfd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index fe845af0b74e..26cf804d8d0f 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -55,6 +55,13 @@ static inline bool isalarm(struct timerfd_ctx *ctx)
 		ctx->clockid == CLOCK_BOOTTIME_ALARM;
 }
 
+static ktime_t timerfd_get_moffs(struct timerfd_ctx *ctx)
+{
+	if (ctx->clockid == CLOCK_TAI)
+		return ktime_mono_to_any(0, TK_OFFS_TAI);
+	return ktime_mono_to_real(0);
+}
+
 static void __timerfd_triggered(struct timerfd_ctx *ctx)
 {
 	lockdep_assert_held(&ctx->wqh.lock);
@@ -98,14 +105,17 @@ static void timerfd_alarmproc(struct alarm *alarm, ktime_t now)
  */
 void timerfd_clock_was_set(void)
 {
-	ktime_t moffs = ktime_mono_to_real(0);
+	ktime_t moffs_tai = ktime_mono_to_any(0, TK_OFFS_TAI);
+	ktime_t moffs_real = ktime_mono_to_real(0);
 	struct timerfd_ctx *ctx;
 	unsigned long flags;
+	ktime_t moffs;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(ctx, &cancel_list, clist) {
 		if (!ctx->might_cancel)
 			continue;
+		moffs = ctx->clockid == CLOCK_TAI ? moffs_tai : moffs_real;
 		spin_lock_irqsave(&ctx->wqh.lock, flags);
 		if (ctx->moffs != moffs) {
 			ctx->moffs = KTIME_MAX;
@@ -154,7 +164,7 @@ static bool timerfd_canceled(struct timerfd_ctx *ctx)
 {
 	if (!ctx->might_cancel || ctx->moffs != KTIME_MAX)
 		return false;
-	ctx->moffs = ktime_mono_to_real(0);
+	ctx->moffs = timerfd_get_moffs(ctx);
 	return true;
 }
 
@@ -162,7 +172,8 @@ static void timerfd_setup_cancel(struct timerfd_ctx *ctx, int flags)
 {
 	spin_lock(&ctx->cancel_lock);
 	if ((ctx->clockid == CLOCK_REALTIME ||
-	     ctx->clockid == CLOCK_REALTIME_ALARM) &&
+	     ctx->clockid == CLOCK_REALTIME_ALARM ||
+	     ctx->clockid == CLOCK_TAI) &&
 	    (flags & TFD_TIMER_ABSTIME) && (flags & TFD_TIMER_CANCEL_ON_SET)) {
 		if (!ctx->might_cancel) {
 			ctx->might_cancel = true;
@@ -434,6 +445,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 	    (clockid != CLOCK_MONOTONIC &&
 	     clockid != CLOCK_REALTIME &&
 	     clockid != CLOCK_REALTIME_ALARM &&
+	     clockid != CLOCK_TAI &&
 	     clockid != CLOCK_BOOTTIME &&
 	     clockid != CLOCK_BOOTTIME_ALARM))
 		return -EINVAL;
@@ -459,7 +471,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 	else
 		hrtimer_setup(&ctx->t.tmr, timerfd_tmrproc, clockid, HRTIMER_MODE_ABS);
 
-	ctx->moffs = ktime_mono_to_real(0);
+	ctx->moffs = timerfd_get_moffs(ctx);
 
 	ret = FD_ADD(flags & TFD_SHARED_FCNTL_FLAGS,
 		     anon_inode_getfile_fmode("[timerfd]", &timerfd_fops, ctx,
-- 
2.56.1

