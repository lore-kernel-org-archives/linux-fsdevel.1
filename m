Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906276;
	b=UJsQdsTfYzUSte1eJPzHpBF04Cu4BLpuYVsGp+SnoqQ2ZSiyv/UkwGbuucYf10Y1EYBI
	 ue3Ns/qwBAX0+JQXb4t8i3IUCDIsQuo2+byX5qLZOHMr8Iq9amcBnzdsJoJr4QGYhubY8
	 3IG3D7z7SZma2r6O11oQ2VrbOjKpSN6DkCVTjXmJ2Ol2p+H+ASBFbE8nfHlZ9BrYE8kPB
	 waRuT4i99PzBa65rdqzV1Yk4804shwbI4JFCepySLlRvyOuN45nvcdChbxXS+NhlSLm7P
	 riLBNDin4qDWm25QPPSDelLdiAm5nR7zANQY7T/XMXIKFyHJ4GI5eeZ7lNpM9CYgxOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=Yafz3sEgHSbB0dihgrPP4811kZo9wiNYZxbrPM44ojs=;
	b=yJeDObXY/WVMFGdINTHcLp/JSTbzvkC1jftaUEivM16mt7C5Z5kkAqFjGXqchZdgmsYk
	 mh6Sg1HR06Z6zbP985jlrr+mQj8CpP3JIyqACURu3rjv9CR2wQ8PLuPwJlg4yVtvmuTsB
	 P/ni0sqc8QdZ315nMmp7w1NMYQi1cSMcPoC26iEe8+H+UH4B4tMzQqjP/h/T/CMMDB9fV
	 tWtRl7cDWXYVa6gHxAlzj58KIFxKUaJ6YFEOoNKZvrsfGxQbnrGpz5xNOeIXWkGkKNTyu
	 BHbkMRBrybXLSZw8XeDLHB0qHPpF0Xd1y45F64op6qZ0EKtfo26Rb0kQ88l8iZoud7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Df6fFrOr;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A840606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A840606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Df6fFrOr
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso2442411a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 01:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794906276; x=1795511076; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yafz3sEgHSbB0dihgrPP4811kZo9wiNYZxbrPM44ojs=;
        b=Df6fFrOrS33woqipjuxMbtgP7Mb38cga8ynzt4dnwXgr3NWyVSrac4XRUinfbr3fLw
         ZVQFQHOVaZhwzqO9wK3QHesW8cBGX1Yir2qudEdLZW+BOY852fUftVTZY4lKH1Gctl09
         OJTywxiLvJaQfloOQmtSK384TfG4wao7WnxHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794906276; x=1795511076;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yafz3sEgHSbB0dihgrPP4811kZo9wiNYZxbrPM44ojs=;
        b=fLbdjf3JL4b889t7lrnYAwc6CtJT/WlOYHemK1RsBLNkKgYQuPXJkz6CDanTJtIiKN
         Jujqq7pQF7WQ2QWu39MAzItV/kP/RJmFwrurY4h2QTw3ORGrZhj9VETsh8+d1s1jWxfL
         6k1s0asPq8vg/+1aCWGdaH94UiYEeL0se00sFVOiFqDe508WIVfSPzu45wWC3uSo9TTQ
         TSgoeOAFSp9+BGieB1s89NHp7mK1hUhoqT2gjywAUpN23NRXUsTdNBNVN35vw8pGls1B
         6SDhCeHHAMLGfd9X1Utu1w2GbcWrzlI6nBMro5mW2nWFuGmv75yzUsBkvYGl+85p0vxp
         69tQ==
X-Forwarded-Encrypted: i=1; AL+hErHmP/iVxknSEqs0TXiEgdo9Tr0QlNgXWIkaX0S5uLreyag1TLPwiFaKPOASayNRhM9UJjEF1cdKOxNIP/6F@vger.kernel.org
X-Gm-Message-State: APuU4Z8lWWPOwj2EEyRSK8dYw47ZYpmiEuQDhbZf8r90rSF5Q2CBPiOP
	DXkQDE+6+vDq7b9HqZIpiY04S2f55mr4FwIMCuQkg0isXAckhJ/uiWVOmJhqr9f7bOgrIRzRVJ5
	L3ZbJny8=
X-Gm-Gg: AZFdTZedHonhhokZVKaNa7bVQgk5BhhIOc5OpKJDI5nkA5HodxUqiLWnrPurr1PTTwn
	pmTHQCUY9z6Hmuyla1ZE35zjQ/HOaLQVkNU9gExc0gRpVpDpdoc4e0OSYkmcScjuNWcKLwUQUQo
	La5OyQRzjjkW9ADBVws+4KtMC6biSWYPUmf7Nu7GxjAF7KPl0VgkZPg2sYQXPfowM9ScifBRpMB
	ocYtShuujmomyf9AMvG1gtjqz9qRcQqRs+zQhx5MefH9KH5oP/v6ZaTxSMDtA92yjGaCmYrIRqP
	fxEmiTrUv682328YlYUhslMDwtYxhXL5fZFmnMwIpZuN/8EdyT8+E8i1tnrJ0pfbogcpSNmRw90
	qS8dif4XxnT2QZIx3lMdTp0OPnT7P39COAr5CX/XHqIYoB9ywaJE028fZwD2aehqot0NCE51QQs
	+RdFUWYkbKCelRvq3BNd4b0COKiEO8VR2660HlGLFpuhaJvac3pnkp9SqpOPBa6KanQAT/kUaQC
	WCp4b9+VAk7JcQC4uYbBNrmn2l1x9EzdBYDfmwB9vk9d3wEosqxoqYIEyxu8OKIzRHrPBCiUKw9
	XfVm9jcVH8NaWsxekgdg+2+HCUaZEuFTpnN7YsFct0Fn45M2uejFTPg4oi8mToVffxalzxcFEbr
	4ANRXZQXQJxb3ot3+AhmB43ehwG+U8chvM9OcQrvRFjIygaOAnbOTum81ex4H6Vd2H2R5N3AJVj
	3ntzzaWLAUsMmDuuSoXRWqgvT5KvsMwo8GcRqW3s+RxhCxmcbOMgI8MDWYUZIVOwM8w/RCUXKrW
	vo4k9+/92dWoxI=
X-Received: by 2002:a17:90b:17c7:b0:3ab:884b:65ab with SMTP id 98e67ed59e1d1-3b1b0ba4fd8mr13948715a91.55.1794906275627;
        Tue, 17 Nov 2026 01:04:35 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abd068e2sm3204091a91.6.2026.11.17.01.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:04:34 -0800 (PST)
Date: Tue, 17 Nov 2026 01:04:31 -0800
From: Chris Down <chris@chrisdown.name>
To: Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	kernel-team@meta.com, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH RFC 3/3] fs/pipe: copy a run of anonymous buffers in one
	user access section
In-Reply-To: <20261113-pipe-pool-regression-smap-v1-3-b0dc69558ab3@debian.org>
References: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
	<20261113-pipe-pool-regression-smap-v1-3-b0dc69558ab3@debian.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avwYn2KugKhjYxNh@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Breno,

Breno Leitao writes:
>The numbers below come from an earlier version of this patch, which did
>the copies in fs/pipe.c and left runs of a single buffer to the old
>loop. Throughput change, median of 2 boots x 5 runs, SMAP on:

I timed a single read() from a pipe that was already full of anonymous
buffers, on an i9-14900HX in a 2 CPU KVM guest:

     read size  base     this     base, nosmap  this, nosmap
     4 KiB      175ns    181ns    152ns         155ns
     64 KiB     2123ns   2061ns   1971ns        2070ns
     1 MiB      49.6us   49.0us   46.4us        48.3us

(nosmap here being clearcpuid=smap.)

So on this CPU the 16 STAC/CLAC pairs in a 64 KiB read cost about 150ns,
and this patch gets back about 60ns of that. But with SMAP off this patch
is about 100ns slower for the same read. So the batched path seems to
cost more than the old loop, and only comes out ahead where STAC/CLAC
are expensive. I haven't looked into where that comes from.
On CPUs where they're cheap, like the later Zen parts Linus mentioned in
[1], this may well be a loss.

It would be good for the changelog to have numbers with some
clearcpuid=smap runs to compare with, and preferably on a few machine
types.

[1] https://lore.kernel.org/all/CAHk-=wiTN=1Sm5DVnXDtQ-tSiPuz-7QVpgP2vt6LgaEnhbubfw@mail.gmail.com/

Thanks!

Chris
