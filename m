Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538318;
	b=o4mSGp9mZHJr0Gmr5wQ+uAkjp61fdTEd8VYXpVvz4h4SY0SxaW+3ly3qxeaVkOhcggOp
	 gyXnxZbNldS6NLNZI08ik4od2IIcoPPs+iP4UzWwSZy9pVzEIckK1tYuuVQJ5eGPwVJhx
	 rKDz02NwzB49a2O/ZOE8Ve+3NvC6zdtswHmo1Yj4DTKCb/qfbwhCLRFdptrmreWzHsRDm
	 lwG5SgpCO0rApZ9zBeIQd4XxKctcou2E1maQSWFsm9ksJlpnvfUAcokU1RbGyMRpwKghI
	 w07SH5N6yJqSnnGp5/E9iOU+qn8WqaiFh8tFA1JEe3Wxz9Fqft273TLwgvOsOHw/IYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/EJeu8eqnYrieEoQuogN5jN7oNvPxu+IBN2eMIBR7Us=;
	b=4nfYUcBsHGer98nEb7WEq6V9Ntj3uiqO1K9Bcrd7kLNd1xSYgiz36C/ibhZvj9WhyA8N
	 P7bfxAzN+QdGNuiNzW3pWy3NzyTdcfDzsaDSaAgkH99ZMMCaTsOuu54Hi7xEmtUXo729I
	 qS/gBCV3aRBZXvc8bJIi+IOCRy1rmzMTLGCBw4FJKyQz7X8wmfWEfYkj+LhZz20zrTqdP
	 OxZJZj/WxV+8IxOlkE2iHSPnDr0o7koN0JaSnaYqR3lrF9YI1fgoKC3onW+IHZLlRyrJl
	 rhHWtKVTTf4iqis4bbk23m7vhXpqDVqhUPmx86th3o3BpeDUv/d6DWnpniLMReCD2LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SmXRxnky;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947B606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 16:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D947B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SmXRxnky
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50933bdf4bso939399966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 08:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795538316; x=1796143116; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/EJeu8eqnYrieEoQuogN5jN7oNvPxu+IBN2eMIBR7Us=;
        b=SmXRxnkyJOLfjP32m9hhuB7ThQS51Qqg4E8pnGZT731XzZv9AmeQPYedNc4kvhkkg9
         QgNtGVEqszVIACPOtKfyriOR/kb0aSARrq0rqH1Nt2PNgVjyHCS9An+G7RtbRXF3JiiI
         1LJN/DPgC0zS5NXRHTnDlSOh6GIFmg3ThLESg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538316; x=1796143116;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/EJeu8eqnYrieEoQuogN5jN7oNvPxu+IBN2eMIBR7Us=;
        b=MClK0iTQmgfdGyb6cpA7VYzgVGqv/Vh99CJdeRor/bhlTzgH11Orouwwz09fmJ/l/B
         FC/ZndytWqPBQUFFTq/JcL6gECdvDUOvMXgVwbdpPutOae/dIHntnNoV5sHqlaqb6l6j
         xFWLe5AvfU9Pw97vUrZcQsXD93wxKAzZPDEp9iL4ALPpbj6wnKy4EhxAA6EuXprNuivK
         2TZ/swMvXlseCUp1FqISMh1/rOeF3aaLDWhqoBTqL9WI0ETv8ujt/Z/n+gnMvNXwTJbN
         y0/+CFJi3kqY5VQzCzbD66XB0hOBctr6/B8U+Qy2zvr3NVavzA2XVRb8WlaFOHM2mXiw
         /gtQ==
X-Forwarded-Encrypted: i=1; AL+hErGchZVtahbockrDC2/jg2CDvMf6tS8m84WeEWP2QKUejpgreirXO21WhHurPo0TIIvr/abPT6P3rFJIolMl@vger.kernel.org
X-Gm-Message-State: APuU4Z9G8R9MK0pddKmEVJScJukf+vz7hSWBdILqLIIuem1rzaiIChoo
	PGmRi6jJROwk/fcLAUOwqrdi/m3jTctlNIZ2JS2APtErHQysAIXB5Qxedqez/M6K4VpGBDtLHXl
	h9ZXMU6g=
X-Gm-Gg: AZFdTZePZVMSNGTyofqGq8W5UwLnx4ERyGiQ5GUGCqi5DzArod/wXkT5k6XRDXBqKRe
	tdttiARBIRUeRyMThVdkeRpxRAcGSNFWgdDmatvMeIoPTI18ddTwZMZTYFsALHcaVcZ4z7fEGwY
	Ykk7FNWGQWfetLKk33VCWY9bDclB4fmOabT2oF/URO816hogbhLPuH7txd96/oe9vY0Itcw8NjT
	6BYJF+368n8ThLouLlZCg4t85TWY3njOfrMDp44sq1onNMQFzKe5LHcw3wYTi9WprmBEdmwFiwH
	55zVLS59Qy9sRHDlpMFH0U/MAb7KrQgtzLT4sFvtmTwnUXgyDYMP5bRGgRC/IKx66nI9XgG+9N5
	rBIFtcusu/XYmKsEkcMXI72fJdWQAV9UX1ofjIuhEN+oyR+XwOW2SbDM/1bnihiOl1N8Bd3wmV6
	iZ675RbtTTlQsPuw5a0YNNy9xSeziys8g7kgeWJFrJO8jZeVZZqn/Yk/cZUsTMQGd8dCWU5skuD
	utnBK4FJF1Wnx2lKybu/JxH9/k7UBB2gj6GqvQoylkXaULc66KAPg5In/woBtjxjBc64Utoux7o
	UslJCLiuBGM6pAq5Es0rqspUdfYTGg07tDpy0FqAmeFOOTKDz8kuWZD4PLSH0DPmMOa8KhCWxqc
	TIIM=
X-Received: by 2002:a17:906:4fc4:b0:c2e:62af:b6fe with SMTP id a640c23a62f3a-c513a5e62e7mr1023186866b.8.1795538316243;
        Tue, 24 Nov 2026 08:38:36 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc42bbsm532414566b.61.2026.11.24.08.38.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 08:38:35 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so1091163266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 08:38:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE3Q5hA2FsDxXzFUmgM6sKO/AjcfCPr7JXTsdTkeFY0QB9v3JkJs1pY2LZ3JuDDObiosWoBU0jm7b3PJfQ1@vger.kernel.org
X-Received: by 2002:a17:906:99c9:b0:c48:a838:c17e with SMTP id
 a640c23a62f3a-c5131848f19mr1340338866b.14.1795538314950; Tue, 24 Nov 2026
 08:38:34 -0800 (PST)
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
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com> <awWSwmvaTwBxfU-r@redhat.com>
In-Reply-To: <awWSwmvaTwBxfU-r@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Nov 2026 08:38:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
X-Gm-Features: Aa3M54rSVXLeJrh34QUL8f4_MzvjAY0ztkaZZD6rbZrwl4RoBJ3r5dHQUBjwBMQ
Message-ID: <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the
 head in do_wait_intr*()
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 05:36, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Well. It is not that I like this idea (and I bet neither you ;) but
> we can add WQ_FLAG_EPOLLEXCLUSIVE set by ep_ptable_queue_proc() and
> __io_queue_proc(), and change __wake_up_common() to check it

Yes. I called it WQ_FLAG_POLL_EXCLUSIVE. Let me send out a series
after I've cleaned it up a bit.

                 Linus
