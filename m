Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFA346A18
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786393200; cv=pass; b=NJmppN+MvfLnhnKODiBudh4sMsA9JsrtpDDd5FeZdGMUBOjxh0f4F4bp9I2vn8hHxeOBhzi9s0zdo/9xzYwuDcw9CwSfJuKxzXYktxyiVZBWRdemTntfbrQ65hit5HbIay77ejphxB9kMqBvN1HwD5LRdmp6vyMi47DJ+Ve6MqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786393200; c=relaxed/simple;
	bh=UgIF1kuc19iuRlP9zEQcOp7zPTO65a3duLKsT6ITH1s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXnNBBpnuET2TXwCDDBsM5JaBf9WjwUfdBo/f+UAR+Rvb3f793nRoTPfBzeLx66vUV1k8ZXbIUktRBWKrC/aoOaGnDXk84KQuUoJfLOFKfVYZo+PWCeQEtRvz4zs5w8X2Qi406S5IboDEadZyCLNt8vxhSVc5jZ5x7fhne1otoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhqzBwVy; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhqzBwVy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a8d251so3332918a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 13:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786393197; cv=none;
        d=google.com; s=arc-20260327;
        b=YS+vHc2m7X6bhUYDqhQaesu5TuCkUkwP5FFqyUDHHSVd9vOmXCC69TZeuhI4l+gCHG
         ybZesjv8tgZXS1LOAY1QJJVPowDBowoRuX1Mb0WERkBpiftR9DT40T9FVDgJwdJ1wgrh
         kvDaCVJfu/k6viIBf/vu6eW5agIDcpdZoEnqqZTDe6Z3j+sTpMRTRezw6BA/BoYG/1Hs
         LBKYCeNkqTU8L1xmR/2a8D6bokW3Wcrwhfg0hzfDbZYVNMUemZ+3x+xihj+qu/RAW7Gk
         KmjLAcfmYqV1XXYvRQLIWtHw34CIGIjJ9UKs8TG6yjBuv9s479GRKaBS8ncC6DsrQPUw
         L0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UgIF1kuc19iuRlP9zEQcOp7zPTO65a3duLKsT6ITH1s=;
        fh=wyD8p1qMz2kPbhGuJbtatLpW0tf2kTlZWVBqaOru26w=;
        b=rggioqYGPxv1UPJyPgmQupS6NgKFegxUvxQPcLfy1X29MGyXrXDaqaf7VXSzXa9Tak
         0P3F6k5izYIomYF5Z90iU8t9YzFpJTl6bX2evqmSDMjoDdYV1hYk3padJFXhykx82XL7
         j01Rc3nIIFt4BU054IOcIUkdYD88eAjR89FrFciunvZ+WFfxgEDb5RI0vaTQvd/Yw2ET
         UjSXWdhCMQ6IWxraWteQdT0J2Ytlma3WK/GAUZVDfb28qaBC3PRSU/75AI98r2VxapuC
         qylxkHn6ORbw3F6stfMf8bZsRzhQloDKPsK0BqKYw0SfoU76sUGdKwLerYqsrnqbOLDg
         9ccw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786393197; x=1786997997; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UgIF1kuc19iuRlP9zEQcOp7zPTO65a3duLKsT6ITH1s=;
        b=KhqzBwVywwypunCgj3sKVlD4NNvbGNKQ6WyNukHVM8S8gRmZIGsAaQISaCcQWxHx6y
         4O1QEgTCxcyYwhscvPPCfmoONCvrNVKxbIefsWSAvE90uTkS+LxR88/zOfCsBtG89EOi
         8SUE38vbSZpR9eGDztif4oYRNGP8MVseqK0EQ0ya3GEqKTS6yRkstFSBGSifWI1Y20Po
         17uWZgWznI+iYitkNi/dIzqysB45xM/u3u/VH8V7E1BJWgzjeL9xTa7E3oQc9RHho0i3
         GCD0e4OVYCpiWWkXEIFN+6sWDojc6HqpYgBdTEBV4eKHoZyxqcIERG0DlKx6bYrsDd+P
         z21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786393197; x=1786997997;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UgIF1kuc19iuRlP9zEQcOp7zPTO65a3duLKsT6ITH1s=;
        b=K+BSsN9Sy16Baw4exkiNKhBTM/Xn6vmPm1c0xT7qGOJY5voeR1tu4cnQ1IZ6lVPb32
         4zqUa0zuwY5c/gsH6xVMQfcx52S33x2A8KfQhJxDnLHoj/lnliW+D1BNqQn2Au4SsZ50
         YwW4YAAFIx5ALYN3vXPd6eQ015Nt5UPmlgkeRoZD0wgf8X+RCNfeiQ2TpygXarfQcdu0
         kRgdfuvBRT1+Oco2yH0/JohG8IBrT00PR9IF2JO/ybXVxjAa3r2XPghJSXlb3bbwlUXf
         WinytcNqYSnLVDo27IsmNb2YMeZB10XXmuPup71OjeulMy+w/sm7wzlQGMtu6wm9rzYw
         u06g==
X-Forwarded-Encrypted: i=1; AHgh+RoPqfaEzHx9tNq9Sr/zH/WXhO1DXcMyWXxNVgMQcBZ0H0gLY5GtBqnmg0RAMlYcqyV3wgG4ugG5KWqG8emc@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCSwPqY378/9hav0O2WCm6T3LC1+vk1xYous0z+kRN5/i5hRB
	2RVWy9ZH7smcFpkCkzzVFWaO3obaw2aYLKasw19rJpySrHbvSNJjedoEaohDwfC6TWEM57QVYUf
	XFpmbHuvCf6ISeyrHYKGwGte3quRzf9frOLlXJAg=
X-Gm-Gg: AR+sD13foI4c//T9oH8Dd/78o09zoBOzjkist7sA+9/cLKYPlD9mcmrxwy2DvCUX1v4
	tfsd75Kx0y/PG8JtuuxMngsVjHOweVSP1wNd7TP63Q3Y+qeGN3Asl4vFmKyQaPMJlkZpwBvcrk1
	7vlTeqQmwMP+II/yGfdUH7IOZtclYxCoLsYFxAwA/2BZm7WduX8Yzi9JUABcLBfTwVBWFSf3dVy
	Dv3pODYW2vw/SxillNXWialwbOpg0xXjCHXjQVYN1Y5C4gPsjtUn7eIyv4JvLcW010Q9SX/3JGu
	Ak2l5ok6MRTm2zCJF+vcZ2TW1d+yQOV9gCKY4NL//edK9w==
X-Received: by 2002:a05:6402:51d1:b0:6a0:d40e:9c0b with SMTP id
 4fb4d7f45d1cf-6a14f1448femr21365486a12.16.1786393197284; Mon, 10 Aug 2026
 13:19:57 -0700 (PDT)
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 20:19:56 +0000
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 20:19:56 +0000
From: Ayhan Aydin <nsd.project.dev@gmail.com>
In-Reply-To: <anlByPDZmvEhWeXI@casper.infradead.org>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com> <anlByPDZmvEhWeXI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 20:19:56 +0000
X-Gm-Features: AUfX_mwYOvXHj1CH5NXEpaVzNk72oIsQRcr9M8up0rWun7RadURAT4-q_8yOC5Y
Message-ID: <CAFLp9PEHKcdAgt3LX1m_0+H=foY+Va8gtSv6r7Gp1RVcKZ7YiA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache prefetcher
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,

Thanks for taking the time to look at this. Really appreciate the
detailed feedback. Adding Jan and linux-fsdevel to this reply per your
suggestion rather than waiting for the next round.

> Architecturally, we're only hooking into the read path and ignoring
> the page fault path. Was that a deliberate choice?

Yes, deliberate, though I'd frame it as a starting point rather than a
final position. The read path was attractive because hooking there let
NSD observe and build its access-pattern model without adding latency
to the caller's path. The benchmarks I mentioned (18-19% wall-time
reduction, +22.6% throughput) are from that observer-only design. The
page fault path is synchronous and latency-sensitive by nature, so I
was cautious about touching it before the read-path approach had
proven itself.

I don't think it needs to stay excluded, though. A lightweight, sampled
hook (rather than firing on every fault) could let NSD extend its model
to fault-driven access without sitting directly in the fault-critical
path. Happy to prototype that and bring overhead numbers before
proposing it as part of the series.

> It would be nice to replace the existing mechanism of marking folios
> with PG_readahead, if that's possible.

This is the part I want to be most careful about, and I'd like your
read on it. Right now NSD is purely an observer. It never touches
ra_state/file_ra_struct or the PG_readahead flag itself; all actual
page insertion is still delegated to the existing mechanism. That was
a deliberate safety choice: with CONFIG_NSD off, or even with the
module unloaded at runtime, the kernel's readahead behavior is
completely unaffected. There's no state that depends on NSD having
been loaded.

Moving to something that actually drives PG_readahead / the readahead
window would make NSD a lot more useful, but I want to preserve that
same guarantee: the kernel must always be able to fall back to its
native behavior instantly and safely if NSD is removed, even
mid-operation. Before I go down that path I'd like to talk through
where the safest integration point is, whether that's advising the
existing ondemand_readahead() logic rather than replacing it, or
something else you'd suggest.

> It'd be nice to be able to detect backward access patterns as well
> as forward access patterns.

Right now the predictor (Markov chain / frequency-recency based) is
forward-only. It assumes roughly monotonic access. Backward detection
is something I hadn't prioritized yet but agree it's a real gap. Happy
to look at extending the per-inode context tracking to catch reverse
sequential access as a next step.

Let me know which of these you'd want to see first. I could start
with a writeup of the sampled fault-path hook, or with a proposal for
how NSD could advise readahead decisions without owning the state.
Whichever is more useful for moving this forward.

Thanks again,
Ayhan
