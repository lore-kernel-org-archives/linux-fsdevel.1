Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C966415F07;
	Tue,  1 Sep 2026 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275509; cv=none; b=Gvy/VHWVVh1hz+p2JhCnmLE8XQ+8kmt7tbMumRSY4nMai8G/u9bkWb6PfUD2gkYwpz1koGPShhPvcnT6xT2aFFzOvGsYiyUfNfSRcEY7P8/xYHOaQYJx7XdcD2HXIrSZP/rDONJq6OSbjlpMlZ5IXruiu5ytYU5Ebb/EhiA4DeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275509; c=relaxed/simple;
	bh=Ro9V/fWNYLcxJrZD7vLc2P7yaGXm/ZFQmbQxl0g8Zf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZSMOhNR4j75JRzXxH3H2R9n7XdYvT6+wa5mF1tJ5NToGkNTktAtONp2VYWPtaDNcT1eGatII2W5KwXeNY/qrFcandHndNkLCTCBvNdsoDT2XhoGWEw/t19bUnyZNgo849cka2ZvrDdpJUFqc2kG5SjrVjRiMoM0jByn/QUZmtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl2gPj8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl2gPj8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716491F000E9;
	Tue,  1 Sep 2026 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788275508;
	bh=22jciHchDzUkZuvJuLeEwCgemxKYmaE2eCs6YcRWQ4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gl2gPj8d218u8GLK01j4chCTENJTXDKp/fS1CPlD6C8C3pM/OQUiSoSO+kU1iFVWN
	 ZoAPupts9dEHBHmcENCWSl0My+R5Znd/6QR9BmjMUvwAwdZAT9FYMST8JaOgrIZEfT
	 P/YrMuEwEZ1UumcG/s6dQHtbo5+RPS2BMingPcoxOgoAjpIHzvU/QbX+4i1oH1ok++
	 51kh8hSI+C77nnUAFyhq3sowBJqCA57wY7T2Ub2AHf5w9nos/bZeaKVyquETMOfoI2
	 vX3MvfaLzuw5Xq5Hi0b0UUplAWARDkuM3wc0LSuvVvwJ/vriE20RiEAKFI2PPP+MQU
	 aoYIWO9nLR7EA==
From: Thomas Gleixner <tglx@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Kees
 Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>, Ingo
 Molnar <mingo@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] posix-cpu-timers: Dequeue per-thread timers before
 exchange_tids()
In-Reply-To: <87qzjdauv4.ffs@fw13>
References: <ao7Q8miiuLAPVnWv@v4bel> <ao7iQ_wOLghOvTsq@redhat.com>
 <875x0qclcx.ffs@fw13> <apXGzcA9BmrbrQZv@redhat.com> <87qzjdauv4.ffs@fw13>
Date: Tue, 01 Sep 2026 17:11:45 +0200
Message-ID: <87o6ehatvy.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 01 2026 at 16:50, Thomas Gleixner wrote:
> On Mon, Aug 31 2026 at 20:24, Oleg Nesterov wrote:
>> On 08/31, Thomas Gleixner wrote:
>>>
>>> On Wed, Aug 26 2026 at 14:55, Oleg Nesterov wrote:
>>> > Can we move posix_cpu_timers_exit() or the whole CONFIG_POSIX_TIMERS
>>> > sequence in begin_new_exec() up, right after de_thread() before the
>>> > "if (retval)" check?
>>>
>>> Yes, but that does not buy us anything.
>>
>> I didn't mean this makes sense, I just tried to understand the Hyunwoo's
>> fix, in particular the placement of additional posix_cpu_timers_exit().
>
> Fair enough. But as I was staring at it some more, I thought more about
> it. Yes, we can do:
>
>      ret = de_thread()
>      if (ret)
>      	goto out;
>
>      mop_up_posix_timers();
>
> de_thread() only returns failure _before_ the TID swap, so that's safe
> and spares sprinkling this extra invocation into de_thread().
>
> What a mess.

I'm still thinking that an indicator for a task doing exec(), which is
set _before_ de_thread() and removed afterwards would be more sensible
than relying on subtle ordering constraints.

Along with the nonsense to keep timers queued on a task until
release_task(). There is no real benefit from keeping them around at
after PF_EXITING is set. Sure someone might argue that the precious CPU
cycles consumed in do_exit() afterwards won't be accounted, but
seriously?

Thanks,

        tglx



