Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259102236F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202567; cv=none; b=CcrddrqCYZdUpcBhHI9kxicrgt9FOYdIBpl5S0gBdTtcpm31q2V6gcJOnluiLD5ZxfwxM/yUVQmFHKL6HTyI3IABX7uB74KvUGaX00wLNy3AQIntpyhPezL1e9h8tvBr/ZxoBYS+Wz+19q00Hi6jyt4adXTxurld2Oce8/L40mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202567; c=relaxed/simple;
	bh=0TMK6TPj2I/wDCZC3TKkkZR0vWPLJmtivYg0Oosnwbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uORsqckDZD56wT6zIrS0hOqcJZU4QYa8E2h2uoJSM4LezDoRrLEciGYjClWWEq6IBxPXXIjWx6vHks8sUW3d6OnHCjPqMrZuXJvCbFZtBz40R85k5lJ+Z+D07U0FoVa7IJ3r84c236YvxNREvkXLjN4EWrgiwOSgjJtR8AiclOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKD8hswe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKD8hswe"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f97c626aaso929834366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 14:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776202563; x=1776807363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVfeBwiYFSjucW7g9phomZssZLdfk3en30hBBiRPj+E=;
        b=CKD8hswejFyJ6d0NueXf5SrY2Yru5vKmq1YraCdrqWMGZ5QF9ZBSbEc279u+bQiLnc
         kGxpfO9QKdOMSHYcToyrJPtArAGDMKUl4Jo7tsW0PnZMofNm+l6YFrsdugfd6zYx8ssK
         wb7/b2h6z1kV4DZ/x/TIlQvF1xTsZ0lwXm2blP9MZN4vKJPt2f2aNFylSI0bmuocRudm
         i1+LXDCBFrMENaozlHJ8G4mSNIwyLscbHRPsUkPzG1xqeY7k9UoKq/KkpdrWF4ZelLMd
         x+pDvgFcyMF2ACMHFQsVRH8/BU2Ke4C475Fm+7hv97Z6Nxj26rseVMTqCedYMWKGLXjN
         S4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202563; x=1776807363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVfeBwiYFSjucW7g9phomZssZLdfk3en30hBBiRPj+E=;
        b=Qp79lejsc0G3V0RnPs8w51ZrrpxBhQYhBQ8JpqYO5gGLHOnjfvqX/AtasbRAbGq3qm
         EYL2xzoatRWumcv88kwLH46vNqi5gtvYS+XZxy0pc0i2YB019DGaX1dWx4CD6PsOc1kl
         5K1Y1wzm3r1cc64x4C8ja7bnDjp6ymY9Fg4lvohipokxmRdXKu2rq4ychns6SJEHL41G
         rs3lkPq6ufMZ+SkBYRztD8Qc+2PtqKl3uXO+hEjezVAR1iGddnxdtVCXrZXOT0z1Z8Da
         n52vvbq9xfV/oG7nlg5TakdMjQyeWqIb9Y0qqn3jcxdf6iytIQsoyH8Vl/C52FkcJynf
         8B2A==
X-Forwarded-Encrypted: i=1; AFNElJ+7oxIsvW/470qeaUkBym2Ljr9hq5eh4mBPQ8JwLU4Wb5EttIJlMSgen6jX3VKWhrC6my4HD6WpX3ldGJiR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9r89/3M+xerF94820n9wIp9uQ28rukTYpZQs0LXEbmuwjrFQ
	7VUZxfyTbFDkCgbKe0hJ7YIRidpbTx1I3h1vi5i7YBH0TgS9S9ZczPJn
X-Gm-Gg: AeBDieua6urxXG+OoM3B1b7C6zb82xwLM6lrX1tov6VQtp/JzTc6UXhhS7YV6oJeIvF
	yW/M++pSZXT41u1q9sT1I/99zhgVe/bfTZH1mnz9t5QtJZA9YpHcWEqqK83KTCVkuCUT7mE627n
	WiKPYPRxmhrCuXGwb55VtCKcjEWKOR2SUdzs60/5GOQ6oQT3ryHZPvZF1EardN3j4rZPHa50wsC
	gTWD82jrPh5OhHzmnEX/Av1z50IASQqV42wofJTWY5kChvGpK1qk2T0XPt6eb41nt4uxAVcBiNp
	Ri+Ma5wM3viGnqB6NzKHP1wbTk86AzgZ/AkVigK3jGRdBamFG58tC7HM2DJawXz+bACEY7jR1yQ
	3BcpOGQ2cFPDkRBez7MBYS9eGBYmGeIuBGnF2foJE3qWL+yl2j2xWCzjzqHn3drwtVWUbJT4e11
	mQV57FZDClPqPjzoVWa7Px9BDhy7DbbUADbXRqqppAkKQ=
X-Received: by 2002:a17:906:6a03:b0:b98:48b1:b129 with SMTP id a640c23a62f3a-b9d727969e8mr1203629666b.47.1776202563125;
        Tue, 14 Apr 2026 14:36:03 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6de8d709sm449315266b.8.2026.04.14.14.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 14:36:01 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <e6d3dc64-1714-4105-8a38-3942c62d159a@gmail.com>
Date: Tue, 14 Apr 2026 21:35:59 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: The "clockevents: Prevent timer interrupt starvation" patch
 causes lockups
To: Thomas Gleixner <tglx@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Eric Naim <dnaim@cachyos.org>,
 LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20260407083219.478203185@kernel.org>
 <20260407083247.562657657@kernel.org>
 <68d1e9ac-2780-4be3-8ee3-0788062dd3a4@gmail.com>
 <aeb848aa-404a-40fb-bd41-329644623b1d@cachyos.org>
 <ad6BtKRj1GyreNCS@localhost.localdomain>
 <a3ac856c-914c-4b39-949f-634bed501e7c@gmail.com> <87340xfeje.ffs@tglx>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <87340xfeje.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/04/2026 20:55, Thomas Gleixner wrote:
> The one below should cover all possible holes.
> 
> Thanks,
> 
>          tglx
> ---
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index b4d730604972..5e22697b098d 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -94,6 +94,9 @@ static int __clockevents_switch_state(struct clock_event_device *dev,
>   	if (dev->features & CLOCK_EVT_FEAT_DUMMY)
>   		return 0;
>   
> +	/* On state transitions clear the forced flag unconditionally */
> +	dev->next_event_forced = 0;
> +
>   	/* Transition with new state-specific callbacks */
>   	switch (state) {
>   	case CLOCK_EVT_STATE_DETACHED:
> @@ -366,8 +369,10 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires, b
>   	if (delta > (int64_t)dev->min_delta_ns) {
>   		delta = min(delta, (int64_t) dev->max_delta_ns);
>   		cycles = ((u64)delta * dev->mult) >> dev->shift;
> -		if (!dev->set_next_event((unsigned long) cycles, dev))
> +		if (!dev->set_next_event((unsigned long) cycles, dev)) {
> +			dev->next_event_forced = 0;
>   			return 0;
> +		}
>   	}
>   
>   	if (dev->next_event_forced)
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 7e57fa31ee26..115e0bf01276 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -108,6 +108,7 @@ static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
>   
>   static void tick_oneshot_wakeup_handler(struct clock_event_device *wd)
>   {
> +	wd->next_event_forced = 0;
>   	/*
>   	 * If we woke up early and the tick was reprogrammed in the
>   	 * meantime then this may be spurious but harmless.

Ok, it does fix the problem! Thank you.
The patch itself does not apply cleanly for 7.0 though and I had to adapt it a bit.

