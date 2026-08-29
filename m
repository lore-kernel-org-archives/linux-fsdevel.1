Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE920E023;
	Sat, 29 Aug 2026 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965839; cv=none; b=mEAmkmu25PnxhAIqJAdbHYBPIFaB6/Y8TjBEzg3B4KviMWFYSb4Hvzx6mwfy4EWvRG6bOqoiOOH+i/D2ZFQmBCu8DMHmgxbUO1zLOGMateRgO30Zewa3MrqJF4x9PQDwNGavEyCN1E/5sFli+484HC2tXAdzrIp6aXbJOw6eZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965839; c=relaxed/simple;
	bh=BupOGK9+QOpwSryuht8rxbz+vV3pbsF2UGZ3/fwuyVw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RrlkK+yqTdoWKQ4utEvNVV+uPiw8yPT4DSyhDPQ5ciQ5HFU/TTrBS/IoHx85LXUBXfsLYvbD6RF5kUW09Y8taAghcMmI+j5j5TQxkWm6WVBriaxmXGU5Mlpmy83LO7HFWh+4bdc+YIvhAqwXhjH/tToZ/zKDpRBIMkVZ027xZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B8E/sx0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B8E/sx0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73E31F000E9;
	Sat, 29 Aug 2026 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787965836;
	bh=O81DWSElEdPe9SxBy2pFNHAg83+44YOp6jW+Y/wLfUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B8E/sx0QdZDERSseGfwloHK3EaU9ArsAkSsTdjuCrjUQJzvzf3fKgT3y6lyHSCJwY
	 IliF8AaxY5b9HRN7StKjWYIlzN90SFpsZi6cMSvfj4aTO0Kyg75LfuybwlbFfHyoEn
	 9tKVarnSkWIhi0gbNndJSFawV8J/QZdHLPISL+B0=
Date: Fri, 28 Aug 2026 18:10:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org, Wenjie
 Qi <qiwenjie@xiaomi.com>
Subject: Re: [PATCH] mm: filemap: tighten dropbehind completion context
 check
Message-Id: <20260828181035.ce6e23970d37e38b64818f10@linux-foundation.org>
In-Reply-To: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 22:29:56 +0800 Wenjie Qi <qwjhust@gmail.com> wrote:

> folio_end_dropbehind() uses in_task() to keep folio invalidation out of
> interrupt context. Task context alone is not sufficient: preemption can
> still be disabled, or the task can be in a preemptible RCU read-side
> critical section, while filemap_end_dropbehind() may reach
> folio_unmap_invalidate() and sleep.
> 
> Use the established conservative three-part atomic-context test: reject
> preemptible RCU read-side sections, reject configurations without
> PREEMPT_COUNT, and otherwise require a preemptible context. Unsafe
> completions retain the existing best-effort behavior and skip invalidation.
> 
> ...
>
> +static bool folio_dropbehind_in_atomic(void)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
> +		return true;
> +	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> +		return true;
> +	return !preemptible();
> +}

Cripes.

There's nothing mm-specific about this function.  If we have a use-case
for such a thing then surely the function should be kernel-wide, it
should live at the sched/rcu/etc layer and it should be elaborately
documented?
