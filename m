Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2737B000;
	Tue,  1 Sep 2026 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274244; cv=none; b=HjO1MVZRqyh8wIJ2ApCWJG0LuJZFw7GMzf4eMv/9lTEN7pK8qRXQQLcJFg+ycc3DidisA6S4luKoDyrXivg+qRokAKM3FT5HDYEQdciTWzqbVN+uJCWRW9Zqfmd+abZt6cqYMVQ5+xAYER/t8G9jtNxBso6RZovWfPvi8UdybMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274244; c=relaxed/simple;
	bh=Nn20mfYqSrEQ+j0CUSoYqr6xN7+NeLGRkhD5Oi1/Gqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eOG92YPQnZP0Mt+m46kUnK1LlHfsIWYJwVJufyM1dLqhHHRQa/POEP3UflmFW/hvORjMH9+B7yRs6YW5V6qx+Jm6meKyUlBfwB+FTSHLrXqGItwJvY7rAL1rSkbTbw6Kac8ZlDgZbbl0OuArKbRK28+yHyFcMl9ud3kI66LEgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp6Id2ek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp6Id2ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969561F000E9;
	Tue,  1 Sep 2026 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274243;
	bh=48z4Zn3y11CKh0cUVxT7sUV2cA21GxR/DgLrBaE8Xmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Kp6Id2eknGGRo+fq2I807tlODOLi9jfsO59dHQkrSCV4evO2917O7y4ZtJyqm0YAN
	 /w8I/T8xL/hnwjHgN6BPSB4LSBzhlUyjwCG0kotNPkpBtXRW3cKnZ6m0UxLDax31iU
	 dpsen3FAtZ5ctvL6uzFJdZz0768+aE7JfN9rpjBJP/vOVSiklvT5DH3R0hBbq71KfD
	 nXwbibGmAueMoKPa6qkT86WCTurIGcR5LOmdhDOZyNB4HYLvM1BVMbm4bwNjOCRedv
	 OH5Wv8DWDKE6/TDZe0knRC5/KL2W0QukFMgcfFVipy2A+81M1/ae4I8XoPT9IQ2BC5
	 WZxfVUZHgNXyQ==
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
In-Reply-To: <apXGzcA9BmrbrQZv@redhat.com>
References: <ao7Q8miiuLAPVnWv@v4bel> <ao7iQ_wOLghOvTsq@redhat.com>
 <875x0qclcx.ffs@fw13> <apXGzcA9BmrbrQZv@redhat.com>
Date: Tue, 01 Sep 2026 16:50:39 +0200
Message-ID: <87qzjdauv4.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 31 2026 at 20:24, Oleg Nesterov wrote:
> On 08/31, Thomas Gleixner wrote:
>>
>> On Wed, Aug 26 2026 at 14:55, Oleg Nesterov wrote:
>> > Can we move posix_cpu_timers_exit() or the whole CONFIG_POSIX_TIMERS
>> > sequence in begin_new_exec() up, right after de_thread() before the
>> > "if (retval)" check?
>>
>> Yes, but that does not buy us anything.
>
> I didn't mean this makes sense, I just tried to understand the Hyunwoo's
> fix, in particular the placement of additional posix_cpu_timers_exit().

Fair enough. But as I was staring at it some more, I thought more about
it. Yes, we can do:

     ret = de_thread()
     if (ret)
     	goto out;

     mop_up_posix_timers();

de_thread() only returns failure _before_ the TID swap, so that's safe
and spares sprinkling this extra invocation into de_thread().

What a mess.

