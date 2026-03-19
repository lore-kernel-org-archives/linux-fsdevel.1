Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2A2356BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911159; cv=none; b=fWgOmgHXd4Oq+BzSts5YI2PyfBpeQtJdkI7lVPTm1IoCySA1IifM9vnxkiqM4Lb/ZSbZX8Y5iV5Ry1lcUfrgCqbALZFM5oufmzKX1GzyFhzkNbvSqJXbj2UsTEQE4iOxnznkDgDghzjiYwqQq/NeSuTPl8H1SYPtY/b5KFYktFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911159; c=relaxed/simple;
	bh=CxH4UtZPd5tl5TiiHdEXq1cunB+buWtpudAQKsZWn94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC1iPBQ9aZXLSarpOKHdlZpxhWmVORf4VlJjd8yAaX9CIQqOunImmnQM0Odzq4LToeMrCdBFuVuRA50fn/cPOapAlD4W7WUt9fvuicHNiC7jFoMw8Q9e5/vt9Kn7cd1yqcyiR8ac36QTzQHQsc2n+TTm1FxXPCnzJaGRLb3IWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=C3Gw6NI2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="C3Gw6NI2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82a62714fe6so364479b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1773911155; x=1774515955; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSjDs9gpdiQuavbnhp6WATUDdoIiFqyRgNYkkpsjTwA=;
        b=C3Gw6NI2YouXwrILu/7BMv/GJWmC2q5PY8Svv0iq4mnNVX8OT2uuBRt+ygd4Vu4tFn
         L4W5f9warjoUAP8p5VDglzT3fOdrJTRTAydeHoMvziMg3PeiUtfAOQ4qJMX8zT2tzg6A
         JKA0wFK0xvqNJ+cIgjMgNNQhIHahSsidPkgT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773911155; x=1774515955;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vSjDs9gpdiQuavbnhp6WATUDdoIiFqyRgNYkkpsjTwA=;
        b=YKWtqMdSf9r/KIkYB6+v1xWB2msCjdBHKY0cwdefjMPrm+yBE+1WArx6KMTZbggAW0
         L2WHIZGWAPWvRmDJs3YjGFBpb9ldobtTspkF5Ac4q0Gx7aYhP5Xnb3NrjrlXVBn1roEr
         ikMgMjpedfM0nOMPOC+DhmuyHHi1+iCoMld1j544mcJV0UNORO+lzW09iLgZBXJ2ituv
         siVX8qikhlClxUNzV0Ho3k9DTb8/QwKOY9hAqDs6JBU4MOn6wwv6d096Y1qQ+FTCiCzl
         sQaK9nlFpB2BQiCfHRPF4DgjK/zf77qwl6i2n1JoPdfNKz4mNY9/MygxwF+cn+1hMuZY
         jr1A==
X-Gm-Message-State: AOJu0Yx6TNvWU5dos7bHcp9fEhrFBMau/jACZUl5QzggyJf5Z6W9IVtK
	JA05hQYCcVbR3tJ+P3p/x83vsaGn3B7MurSSWbBO8SN6Thxa1CWvhw6xscFIIQ5RQsjsrHk2jW2
	LL9al9Ix3YQ==
X-Gm-Gg: ATEYQzyN9u1dwexYvwjjoPjkKgL0cOCXYcZ7nEADkgEtFhW7pTenW1b+i5mmTq0wKJf
	VZEblB969yiUKrmJPXxzh9iqVY6y19hGyD/U/1E7joHxf16uSDDnDSMc6WJN86Ils8o+1jPAH1T
	gi4HfTuNq8Wh6UEeRaQY+MTTMLZogvhBrwQ58fqx8i+j9vPGfMLB1djsLja6XO0R6yruzlZx/1F
	0NmlnRLXNQ7HlcwVgGHPqS1itb9HPZCwHd4z8HosxKcALWCTtTrG4ZNrknaQhfURIf7HFsriqvT
	XeOHOCx4at7kfXf8Ct3nNtIEILKnuB4mbZWi8jS46ZAy6I0VLYg6/FRj2bgXtKzB/32cqfql+du
	TauVhEMl95XTR9PQQoWA8GBl3ki3vGRGyk2xVqRZvkJ/t/ehGO75j+WMLntjjrnYH6JQ/wJjCZ4
	l9HANOj+iF85xGuESOJ1iZ
X-Received: by 2002:a05:6a00:2da9:b0:81c:5bca:8104 with SMTP id d2e1a72fcca58-82a7a93e27amr1897355b3a.24.1773911155066;
        Thu, 19 Mar 2026 02:05:55 -0700 (PDT)
Received: from localhost ([116.86.198.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb390csm5680432b3a.29.2026.03.19.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 02:05:54 -0700 (PDT)
Date: Thu, 19 Mar 2026 17:05:52 +0800
From: Chris Down <chris@chrisdown.name>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH] timerfd: Support CLOCK_TAI
Message-ID: <abu8cG7g11DP9nkn@chrisdown.name>
References: <abuTTv9FC__H_8RC@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abuTTv9FC__H_8RC@chrisdown.name>
User-Agent: Mutt/2.3 (50e3b1f3) (2026-01-25)

To proactively reply to what Sashiko said in 
https://sashiko.dev/#/patchset/abuTTv9FC__H_8RC%40chrisdown.name:

> If a user creates a CLOCK_TAI timer and later calls timerfd_settime with
> the TFD_TIMER_CANCEL_ON_SET flag, does the kernel silently ignore the flag?
>
> Looking at timerfd_setup_cancel in fs/timerfd.c, the cancellation logic
> appears to be explicitly restricted to CLOCK_REALTIME and
> CLOCK_REALTIME_ALARM:
>
> static void timerfd_setup_cancel(struct timerfd_ctx *ctx, int flags)
> {
>         ...
>         if ((ctx->clockid == CLOCK_REALTIME ||
>              ctx->clockid == CLOCK_REALTIME_ALARM) &&
>             (flags & TFD_TIMER_ABSTIME) && (flags & TFD_TIMER_CANCEL_ON_SET)) {
>                 ...
>         } else {
>                 __timerfd_remove_cancel(ctx);
>         }
> }
>
> Will this cause a silent API failure where the timer is never added to the
> cancel list for CLOCK_TAI, meaning the timer won't be canceled during
> administrative clock jumps?
>
> Additionally, if it were added, timerfd_clock_was_set and timerfd_canceled
> hardcode the jump-detection check to ktime_mono_to_real(0). Does this miss
> independent jumps in CLOCK_TAI caused by adjtimex(ADJ_TAI)?

So, timerfd_setup_cancel() is currently restricted to CLOCK_REALTIME and 
CLOCK_REALTIME_ALARM, so a CLOCK_TAI timerfd created by this patch will behave 
like the other non-REALTIME timerfds here. The behaviour is that the flag is 
accepted by timerfd_settime(), but no cancel on set tracking is armed and the 
timer will not report ECANCELED on clock changes.

So what Sashiko says does not block this patch, because the patch is only 
lifting the timerfd_create() allowlist restriction. The underlying 
hrtimer/k_clock paths already support basic CLOCK_TAI timerfds, which is what 
this patch is enabling.

If we wanted TFD_TIMER_CANCEL_ON_SET support for CLOCK_TAI, that would need 
separate work. As Sashiko also said, the current cancel detection is based on 
ktime_mono_to_real(0) (that is, REALTIME movement) and would not be sufficient 
for standalone TAI offset changes such as adjtimex(ADJ_TAI). So supporting 
cancel on set for CLOCK_TAI is not just a matter of adding CLOCK_TAI to 
timerfd_setup_cancel() and would require defining the desired semantics and 
adding distinct change detection for TAI. That's a much bigger change and 
discussion.

So let's leave this patch as is for now.
