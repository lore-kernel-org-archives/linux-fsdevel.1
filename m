Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624796;
	b=cjLSkvM0Wthr0CrvzSqSVCblGZ44yj8fQX0CPLsh8rG8jA1MKN0NpB36pVp6fF7kcFHm
	 PMXDHO1iM/Nwj9XjD3MHhg1ge7ctDd2zmbWZRtjOOE+JP+P1ieWx4XfcSwpCBsTXPwDCi
	 HOtHOMZ5D3TwFJeFS2Zu/gXmjUB9cE3r9gqO4fN9fLgQceF+wbu3ffZn/HACgbWtLgJKM
	 2LUk1oaCnSjBFLJaKLXjz606NTHT/W3KKf5h7v7ce0YNKF0Bq2NOkbqtU3ZLAPJeQOmSw
	 UiQ3tHYpqoCsxy4vWqWFEq9KiCvvDL5C1QpdbaoFi5z473Id8KAkd6UY6VrN7cbf6mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JxExNuQaJd3Cwz7l+JHbWMh1g3amu769QhEVBhR2vvc=;
	b=fzYCOymXlamXgYiYlfN8ky8F63++J2RXgzmW6ZVk0GFoj5RC42z7jqZCaYd9ccxmpVtE
	 nXtPgyUqPaXlW98Tpui2qW0oGgqq66kdyaKh9iXs5LoICe1HVUBmCyhN7MAKIwWGG5K8W
	 +9iXuq93CfdwgyTIXEcainK83vHInIHoVA1WWlF+EhQgkPP8xyPFhFsI80EYRB87+EAKq
	 T2bXb+IJJuj2SltJcwblX2FTHTjnllV7uJic21RoKwADG2OFTn4eK8J2CIZRR20/CSUzm
	 g6RaoP5JZVe2Ei7WazLA5PewB7gzxhXFfQgb4ziABon4kKQTyigczfwkh6hfl/PH1dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=OSDkQj1T;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB68606A33C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EB68606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=OSDkQj1T
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6bb06dc1fffso2908636a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 08:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795624795; x=1796229595; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxExNuQaJd3Cwz7l+JHbWMh1g3amu769QhEVBhR2vvc=;
        b=OSDkQj1Ti0rYbrt+XplUWwAibe6OKpBozVfOioKe07INIwByGhPZk7VfEJExJR9pOx
         nDfhakDELK0CUMl1tWJLFPMtRJ/ksEHj/dh73akiu0hekPteZFuCQ7bSnhYoLtZW8DtO
         cAqE6puS+a0YtjqIDKfuaEDLlNbmYp9Gc7oyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624795; x=1796229595;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JxExNuQaJd3Cwz7l+JHbWMh1g3amu769QhEVBhR2vvc=;
        b=aKPjTfZazR5iYnuzeklgKaw9a+8VwqzPG6p9S7oIlFA0lpLsHTazvUFu7sTrZlUxfo
         /u/sQD3RvO4KUYhjWuMUIeDMdLQDOseG4Lp2TGPNsXR0WGgSrtutSJaESwI+q9fhNTCF
         p5EbBCamX3BNjRVvT25QG2njSI6iSfPfoKzRHCYuzTxit2l7bbliJOpI64UaU4Jz6/F9
         90BqDokkC+Zeikls7uHXea95FKFvnp7uAVWK8Or6WxcL9+MJQB7ftBqVr5QMBdIH3iuH
         QmooOnJFW5my5UfRh4xgCun583vGR5fCBHzVpL5p91CtAD7uYBQ0pJJ0gxpCD9Nw95jH
         jrbw==
X-Forwarded-Encrypted: i=1; AL+hErG+tBfzqGZ9iiUvCRvTj+4NBP0UTw9bVX+mMMAOJvo117KvuHfBzcG8gm7zeiKRXZv8lBfzy8Zk62LaUkPf@vger.kernel.org
X-Gm-Message-State: APuU4Z+NwuMP1OFHqO/j8Q/+sPSGKwwJYTCEsN1ofsnGy2XB+TUAmHEW
	t9+N5LZ/3dbaCRMq3cu17dYVudy5wQm1WBUoGkbUd2RVNwtZffXGAmI4qLzUlDRG/WKpqipdE+S
	xmrGX4fOcxw==
X-Gm-Gg: AZFdTZd6ZNpjGLbTGF+NMnq7nnwcw6UAZU+BGVFM/PadSOldWGnztBDsXBSgKpuOdiR
	vtJqUz4IJXub7IrDDaxD8fhLp+YUZR12Jt3/ijP/Vx5/SJbdStND+rCgfWGe3dCCHq0muC/f6Ui
	6Aw4N0LXY3LmgNTRY2nChVv2jacSUD8/nxNCax/vnWmO6lrqlCzO2TRkWyhIMIkIZEj2NH+KXzJ
	OdEPAOEkhD9PzXiz8uIQcCNvEg+JORr8FG2v2bekCXPq4N5pZw1B8FQDeCFOlnnPRXjOBPVLvXp
	veh+N3CZlbeXY9TIbcqCzNHLB3GZS+SCmmXb07ifh018l9ZpnutVaOEU0L7CeFZfCmHyPwgLP91
	IVYb1+FO5l6lTYBmhCmBCbN2E03YaZSUyGQ1562fsT47GCggP7KqYdXiD6etO21Ygv8s7Q3gOt9
	kxiVCvZmX8Evm27y0GPcwY6KlPxuyr7FYpltf1zptvIMkB1Idn4HCSuagGYdQLqeRfRB6JgPa6c
	caXYhaztBLmJCOn+YykosEm638FuUtqGHeCmrQ3eemjm7QM1/hNqgEYqVAIup5DGaN3hgNQts9T
	sVUeMzwuHt0FbbcNzSm8hmPx5DqLrn1mH64ld2lJC3bx+pBxw+pkugPs+51u3Bg3j+FPhcwoCSn
	ghXI=
X-Received: by 2002:a05:6402:1cc9:b0:6b8:8638:4e58 with SMTP id 4fb4d7f45d1cf-6ba37e977d4mr13835777a12.33.1795624794950;
        Wed, 25 Nov 2026 08:39:54 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3710601esm8511791a12.27.2026.11.25.08.39.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 08:39:54 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c50aaad19fbso663015266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 08:39:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEETk57N43BZpN2D1gBgAUcOjgfJT32lPbqWZYcZNKHnmGksEnxf+anAF5bGAczeTW020h+kOj8L5U6971p@vger.kernel.org
X-Received: by 2002:a17:907:da02:b0:c2d:c247:5400 with SMTP id
 a640c23a62f3a-c513a8493eemr1490131966b.27.1795624793689; Wed, 25 Nov 2026
 08:39:53 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wgFnKO_O0fR_-O+i5yUGaDcz8_HwpM5QiLM4jPFYZb41Q@mail.gmail.com> <awbMwBDP9TsJBmzV@redhat.com>
In-Reply-To: <awbMwBDP9TsJBmzV@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Nov 2026 08:39:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTUE9vfMvHeGz+dgex_+sMicSHnf6Nt2_w1-SkOmu8ng@mail.gmail.com>
X-Gm-Features: Aa3M54phjOT0um3z9odpNNELrhe-bLH1gtujI8-yceR8vi0wZ9OAzggOhpFehRM
Message-ID: <CAHk-=wiTUE9vfMvHeGz+dgex_+sMicSHnf6Nt2_w1-SkOmu8ng@mail.gmail.com>
Subject: Re: [PATCH 3/7] eventpoll: don't claim real exclusivity for EPOLLEXCLUSIVE
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 03:55, Oleg Nesterov <oleg@redhat.com> wrote:
>
> FYI, none of these patches can be applied, both patch and git-am complain
> "patch: **** malformed patch at line 34: *file, wait_queue_head_t *whead,"

Grr. I was so proud of having finally figured out how to make gmail
send uncorrupted patches so that I could do it in my normal workflow.

But apparently my clever hack was just hot garbage. Not the first time
that has happened...

Back to the drawing board,
             Linus
