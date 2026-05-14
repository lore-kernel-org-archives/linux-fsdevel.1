Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB9212D86
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731832; cv=pass; b=dWU21FusYJblADIKLe/Lp3hIdP0F4M5BNAKFtKY0rME69ZTQDPYhlDdMABN66zJk7lTOjAsQunazPU9IKf/Ra+HefvIKOH49wwLHhJ8CjoprJLnP0mJHhcYm7ACiCYr5SsVlAd3vdiySYyv/TI19OdzO8bHgY0uTq36Uta2kIU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731832; c=relaxed/simple;
	bh=JVPabDDdvKrn7EBLPEmOyiSJdaBZOZuyzIIogirfsgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1hCnLBLbskgnQis2k9k0Kdy9ro7eh4YKdpHfJAQVP9KaL+L9joK/vC9PgDjq59PswWRZNlTkDRBZr4g4j2kTFPPAU7pxrrVyv/VhIkFOa0ZA1ZNmUsiRyF+hUG5iNVY70607wD+a7yICzIPmVHW2FDyGfqweJYadt/xsRYKB+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=N8yKqJuw; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="N8yKqJuw"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso7470440a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 21:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778731829; cv=none;
        d=google.com; s=arc-20240605;
        b=lEBPlHH8zm9G7HM/pooUumCrjVjTYOfCHjrOKaG7nuFQ9G84QuhTT4MB91sdHKQtFi
         7f98/Bhd+fmMaxWVe1TApVEu3sWMC/ceeGFh5H75Y2MpNEFB9AFKyZIUsAwiFT1/RghI
         V8iQndlgi2awP55O8Gcq3+qK87qT6e2TAhQsIp02+0wsETMhnJe4ceJUD/ohH+xObGca
         WhEaQbe/JvoWH9U7iWVp4QEBbeHCXsv2Cd/AMdmCrRRS/qlRrQfb9LNIhiEvYaYPt6iE
         c4ZdZ5ivDfYzs5QcCLbASosYj7RxXURiiW9pk9jMG21tMdaqqr42H+t8d+sESpxh10CC
         AfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IZyvinl3RBbw0wPTvpYB5i7OkQNZ8q30qzuT9enN60E=;
        fh=8p59U8hlsvDKbNks/zqRxsPO40Jqeofghk2Yopq22lg=;
        b=bSe9JsqANEA4o8dEEdRV6W1kop4yHzOlUNNmCFYFmuVFMWRclzDlgvX+QAe0XdNtkQ
         4aRGtlL1N2U7YUgj8AMbSeBaeQlKtfIietwzF4zwdaVbQ7um8CQbbqte1zBlJFR1Cex4
         dyr2wujXWTTK5tk6++EstpJiWyg9YleHOOpwvp+g9413+VrL5lVW3Cg0Mc4KcXjm8ZTw
         cNrp7XTaytRWkUYZ9lo2vMbe3wwku8cCiN9QbjUiWeGLEJe0U3fVSX5uauAaD0TWkBYc
         EwxalzzdKsY2YredavDl2xVN3+KmvOEvgLbxFGIV1mddLqBOCC+0LyYWAMxzxL2WLxgi
         JvAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1778731829; x=1779336629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IZyvinl3RBbw0wPTvpYB5i7OkQNZ8q30qzuT9enN60E=;
        b=N8yKqJuwc+apVk3ZudQGxuuzJNcQE5jpIwqysBpSdEOq3z4PrfB5BXVRm+0sqgFDqa
         d1jXYN02fJlOUax+CEFf+PdVZ5NSijSIv3rJDBcJkO/NDEYvcCrCYzzi2dvB25nje5hT
         jDPhDzY91i4EMda25Hlx9vRR5sfAuvX7mLr3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778731829; x=1779336629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZyvinl3RBbw0wPTvpYB5i7OkQNZ8q30qzuT9enN60E=;
        b=TPs1AbaLTU2Rh33V6q51hBx/sFY0wWvBt1ukijpw8+xsdoNInXN66Tk6sqzAk5xZdW
         XG8Y61PfRz8YKvywPqPYlzhyE092zTR6RPFMWFgfRpp3ZZC9lgnaoWZXGX9detAnlSDs
         xMvIUq2ufaQziRGfCFsKQmuhtZC9XJ8/MI1NV8KMSVahMA9v2wPOmSBQ4CFFx7tpEQ24
         unDji0JRteVSKZtk8rhbBNt0QK4t/TOONWnJ8AqEVUtwsa2yhsTVN5s98LX/ejeVHaez
         M/UaXEqoqm0kl8bL23+OXiJ7Uzr3qD7cAq/sYPzXv9Q49HkLLfG0yyHex2tdjXgJ4OM0
         C4OA==
X-Forwarded-Encrypted: i=1; AFNElJ9quZ/rGdr6M+zRJZj2LdqI+LLC0gO/YtUCL2RQUYLrcIHNXgb9DcX9oTdTMxBC/zwZPaqPDBmkRgcxBbu1@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZpnXW2+gdGakrVLTh5fzr+opxOSDFNTJvFpFtDsIatLMy6Iw
	J2nclDkHKVgwcWPPjBopAAOKfquaCf4A6eAMEvTOgt8fAbMkOiuk0STosL5bnOHVjJGYCek+nbJ
	3zQrcv3dTE/BJQ/aeklxPp3S/qg0CJOgarvjEVI3hug==
X-Gm-Gg: Acq92OFnbJUFzOpONUjIlUfN1+6+ioQCuqK+NtkqpczjtGyLFUWBghYJi7eRF6zKpJ6
	LhgQv/b/2ElJbr1BhLizKJk5bqUMYo9DNYHVuzcPBneaHoKS72co6LIXUqnh4uG5ueVgZZS8wL3
	T5ffe2lJIXe2axiBPA0qCGmGbJG6C7sDJndbCf11uys+PC+Z9dL0aWgw7WVSQjlvlfX9K/OSig0
	+OqG5tzv7tKqFh+Wjtso/ja9U42XM1n2C/zAs2hYuyJ/L3c/UoTcB1SahEyRPcZnU/uMjzFI8ra
	iYrlvZl6wncDEdvfZt186NqRiKo/cNverIy9ErCA
X-Received: by 2002:a05:6402:4284:b0:67c:2674:a57 with SMTP id
 4fb4d7f45d1cf-682a64e44ddmr3155758a12.0.1778731829214; Wed, 13 May 2026
 21:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501-rfc-memcg-dirty-v1-v1-1-9a8c80036ec1@uber.com> <pbwzmyglpz33d3k63aopi5vlghz4jmur2k2g4res6mhktuujhh@rmqooz6bqaao>
In-Reply-To: <pbwzmyglpz33d3k63aopi5vlghz4jmur2k2g4res6mhktuujhh@rmqooz6bqaao>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Wed, 13 May 2026 21:10:10 -0700
X-Gm-Features: AVHnY4J5GZ7JBzfRkA-sfCo1uEK-ixoCcB3uvVHBJUoZ4dZkaVGCZkTX2MJ_bAU
Message-ID: <CA+w=M=RkewNB0Fc=KNXTrOnt-YABFy+7ZALLmp1wQOP5k_=13Q@mail.gmail.com>
Subject: Re: [PATCH RFC] memcg: add per-cgroup dirty page controls
 (dirty_ratio, dirty_min)
To: Jan Kara <jack@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kshitij Doshi <kshitijd@uber.com>
Content-Type: text/plain; charset="UTF-8"

On Wed 06-05-26 16:21:00, Jan Kara wrote:
> Things like motivation actually belong to the changelog itself, measured
> results how the patch helps as well. On the other hand stuff like history
> is largely irrelevant here, frankly I don't have a bandwidth to carefully
> read the huge amount of text LLM has generated below so please try to make
> it more concise for next time.

Understood. Will trim for the non-RFC posting; apologies for the
volume.

> ... I quite don't see how a multisecond stalls you are describing would
> happen [...] If we are below freerun in the memcg, the task dirtying
> folios from that memcg shouldn't be throttled at all, once we get above
> freerun we throttle by maximum of throttling delay decided from global
> and memcg situation [...]

The stall is reachable even with the victim's memcg well below its
own freerun. The freerun shortcut in balance_dirty_pages() is an AND,
not OR:

  if (gdtc->freerun && (!mdtc || mdtc->freerun))
          goto free_running;

Once gdtc is over freerun (because the noisy neighbour pushed it
there) the shortcut does not fire, even when mdtc->freerun is true.
After the shortcut fails, the per-task pause is computed from the
dtc with the smaller pos_ratio:

  if (mdtc->pos_ratio < gdtc->pos_ratio)
          sdtc = mdtc;

When global is the worse domain, the victim sleeps against global
state, not memcg state.

> So can you perhaps share more details about the configuration where
> you observe these delays to innocent tasks due to another task
> dirtying a lot of memory? How many page cache in total and dirty
> pages are there in each memcg [...]? Is the delayed task really
> throttled in balance_dirty_pages()?

Yes. Re-ran the reproducer: stock 7.0-rc5, ext4 on virtio-blk
throttled to 256 KB/s, dirty_bytes=32M, dirty_background_bytes=16M
(freerun = 24 MB), noisy = single fio job doing unlimited buffered
randwrite, victim = single fio job doing 4 KiB sequential write
rate-limited to 500 KB/s.

Per-memcg snapshot during the contended phase, ~10 s into the run:

                       noisy memcg     victim memcg     global
  memory.current        47 MB            21 MB           --
  file (cache)          38 MB            14 MB           --
  file_dirty            26 MB           1.7 MB           27 MB
  file_writeback       1.5 MB           4.0 MB          5.3 MB

Victim memcg holds 1.7 MB dirty, far below any reasonable per-memcg
freerun. Global dirty (NR_FILE_DIRTY + NR_WRITEBACK ~ 32 MB) is over
the 24 MB freerun ceiling, driven entirely by noisy.

The victim writer (fio with psync) is in fact sleeping in
balance_dirty_pages(). One stack snapshot during a stall:

  [<0>] balance_dirty_pages+0x5c5/0xac0
  [<0>] balance_dirty_pages_ratelimited_flags+0x2a1/0x380
  [<0>] generic_perform_write+0x194/0x280
  [<0>] ext4_buffered_write_iter+0x63/0x110
  [<0>] vfs_write+0x28d/0x450
  [<0>] __x64_sys_pwrite64+0x8c/0xc0
  [<0>] do_syscall_64+0xfa/0x520
  [<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

Sampling /proc/<pid>/wchan at 100 Hz across the contended phase
yields the histogram:

  104  balance_dirty_pages
   88  hrtimer_nanosleep    (the fio rate-limit sleep between writes)
   12  RUNNING
    4  p9_client_rpc        (virtfs, host-guest filesystem RPC)
    3  d_alloc_parallel

The vast majority of non-rate-limit samples have the writer parked
in balance_dirty_pages(). Victim per-IO clat in this run reaches a
3 s tail (worst single 4 KiB pwrite blocked ~3.0 s) while its own
memcg holds < 2 MB dirty.

I'm happy to share the full traces and the reproducer if useful.

Thanks for the review,
Alireza
