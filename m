Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624591;
	b=BALnOW24X4mfRacx8cUrggaoy3B1c0QTqT95cMl8yb8IPciN8TNS9DB6ncI3UUoBgKtg
	 PszU27fnT9/wlDjN+6rwmytVJV8CYPlaEXFHv0GhaYkGaGqGJlQ2be+NGfxP3qUKpYwm7
	 zJgvMpnDs/Qc8oD/Uw2VmAgAAQsT6+mfmqFlUEnZjRUULpaNBMGAGzxzCJRZSqyotoSoc
	 Bhle+UljkHTOrh5KUm+HlFjwm2I4Ez1XI0TF3Ws7kcYgU4bLeFZeX26jsJiaVs+UrhtAs
	 TNI7uXO4sE4COYmEOAQT1JXEC/cA2VOBvptD8/XjnouMp1P391Beu9umANsDJxOR+0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FD+pJUDv6zW82nWry+CbP4QIs08JghbicqZZNK2kgn4=;
	b=HfTyTsrDbcVSx84hnv3NQEreudyaD7i9CBr6HNqvkUW/gNSM7s67CU9bIpe0q6BlEWq5
	 A0Lbz+/clmOMob5mJLn7oWQ44nekeyIHWDcxeLw4TKcQ3EJ9RXrSgSIeNM0o4J4LQwT01
	 DZq/cNwLnME37K6GciDVsCBw0TpJfVDDK1alTZh8bDE5T1QeAbjZETd5j9TsxXvzbavb3
	 7KN/BaZhmNGB6aQZ/xZHLOB5cUuiPS1Mtt5oAA3vKUuPfSymxUCJukiXUXEdBvupcDsDK
	 mmaRe+ZUPni2SGssd6JaKZXCZXA/VxKZljSaLX46BIBPfiqhH9jVfWLwZv9oRZVJgrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=JZMk1Tkt;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF667606A680
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF667606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=JZMk1Tkt
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d427836e9so815719266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 08:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795624585; x=1796229385; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FD+pJUDv6zW82nWry+CbP4QIs08JghbicqZZNK2kgn4=;
        b=JZMk1TktYoJpssBTzRVVtlCaMOz8vCHGVMie8FuMb5srubK1z9XNxEhQvwi2as7r9U
         InJKBIASjPIpxEBIhWXeH051PzRYyLAhdBsJQQnNNnuZp78WLPt+6VNuZ6qqfz0uZlWw
         hLHpQlWH/N1MsupqnkCmXfC7hEt8+zamtHGx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624585; x=1796229385;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FD+pJUDv6zW82nWry+CbP4QIs08JghbicqZZNK2kgn4=;
        b=bPg08Zuz57Bwq1tjSkLt2rLg/V0uqhZ3Vdq7cYowQZKu1oJcuGAEuLVwsZkXAzSIjY
         YtPFLr3K8vziW4Tr6l11fPW0UtAtm+9frcHSRp5naFmbtK18VaN8juY/uQH/7t5JB0a1
         jggd+/6c7QxxrjzG3a5bBce+QPZDF80T865hEjfq2RDg1+AYSVqDNawNqma4Symjajiw
         S4mPgYg4ZrKqySRkyC7Nvb2R8lMHsQy9Lc8MrvgbOuJeUU+zhCdgzaPpHNkt25AvLxrZ
         aFLYsPEE+5fZ0IhXyo8XbYGth7BMjB8dd9LFsOwLt90jbBM+1UMu7H4HCUE9aUDxaT2Z
         wubg==
X-Forwarded-Encrypted: i=1; AL+hErFubv9cJRn91NzqB2udzrPWZ0Ukr8dfERKC/H9TzU3r2kXIeenX5TZcgHzpjY7jsOQ6H7Vy6ZdEThOm1K/v@vger.kernel.org
X-Gm-Message-State: APuU4Z/C36pJef49VaTlVet1hiwR/pzOODZiw7hfXnlKUEewaApOn6/Q
	LAEdU710SjABS8NOmgBCQzbTpykjb/7NXhL67bvivU1CYKOlvWGu9AP2b8mhNbEtvbfKBz5PPyl
	qms4WFL3aYg==
X-Gm-Gg: AZFdTZewrywbADHoij8pXUMihKfOgCsqx+2cWSJ5SDrmQBexQTbWeHREGgJesorNu2J
	N6T+Zkdk8Qn2lxm7CbWoJcMTNxlDJEn4MimVuf8+aOrWOsdHhTddO5yjPBT0lY1S1c4pskDxFxV
	51/Geuc4Vyw1OW4Un5DtgOPQpkn+erz5sezvKJSau24occv6B/dViHyIB9Z1meYhIaSMs8PIeID
	RgJN8I3BFtS1BtKLEED5X+wwsLpgMVtpFu8zTo0RMWqr37UdCbNA6Vf4GtfDScXdmNAYag+Ivlw
	lVbhXlnLHlWtnYwUxUjKpmVaoJyxeCQOsZrxl9zmaqytGypbivjVYcSCPdCAV3lhaQTAxoNEuBF
	/9eXkUtjm7UCT13rKfeAreNllOk8GUGBIhgBYl4WlGFT/KzQgOZ3OgWq0dNntjek726eW9oakhf
	QC2woz8uAuMn8Hd2yeTE1GlsYUHZlZVsg4/xLZZKxjO6vhCExXxD5sLDQeF95YASsGZ4Nuo8s3s
	kYi9KsqPlt2Klqy8/kgXW3dILtfnFqZVWa/N0hvm7VSexJ6e3mwOFZ26IaUQNza2GjgoZVKKRB6
	aJ+UybHDi4ABv8BF/VJAJQMNRamTmzthO9QVIyQvS//aG6OGcOb4FcFcDBghmZcU/ptqVcbw4Y2
	HG68=
X-Received: by 2002:a17:906:b296:b0:c40:4965:72c3 with SMTP id a640c23a62f3a-c513aac36eemr1057250366b.19.1795624585035;
        Wed, 25 Nov 2026 08:36:25 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afecbb5sm661922766b.71.2026.11.25.08.36.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 08:36:24 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d581da0aaso838604066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 08:36:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEHswfH/g9L69LkPTv3JMd8SO+5bC3dkYeEU1zt99y4F+RS5JgGtknHhKx1pYChn/O/uEhEghtBTe2jy5Jm@vger.kernel.org
X-Received: by 2002:a17:906:4fc8:b0:c51:ab6:1c73 with SMTP id
 a640c23a62f3a-c513aaff9c8mr1629652066b.23.1795624583581; Wed, 25 Nov 2026
 08:36:23 -0800 (PST)
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
 <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com> <awbJz9stwx_JzZFX@redhat.com>
In-Reply-To: <awbJz9stwx_JzZFX@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Nov 2026 08:36:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=winCVsBKy0mGZK3mazNoTO73MrnmFHXNBw0UNK30Di7Fg@mail.gmail.com>
X-Gm-Features: Aa3M54pPxr2VuJXWXHMKSQADyObX9AHM2KfGDGpOXz7rBKMCW5_j8OTDdxQ-wbE
Message-ID: <CAHk-=winCVsBKy0mGZK3mazNoTO73MrnmFHXNBw0UNK30Di7Fg@mail.gmail.com>
Subject: Re: [PATCH 2/7] sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user space waiters
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 03:43, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/24, Linus Torvalds wrote:
> >
> > +             if (flags & WQ_FLAG_POLL_EXCLUSIVE)
> > +                     poll_woken = nr_exclusive > 0;
> > +             else if ((flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
> >                       break;
>
> I obviously like this change, but note that wake_up_all*() helpers
> use nr_exclusive == 0, so
>
>                 poll_woken = nr_exclusive > 0;
>
> doesn't look correct.

No, I think it is correct. I agree that this logic is a bit messy, but
the intent was to keep the patch minimal and the code as close to the
old code as possible.

The logic in the new code is that WQ_FLAG_POLL_EXCLUSIVE should only
wakes up one of the entries that have it, *except* if it's a wake-all.

For wake_all, the poll_woken is never triggered.

And notice that "nr_exclusive goes negative" is exactly the *same* as
"nr_exclusive was originally zero".

So maybe it's a bit subtle, but "nr_exclusive" has never really had
"zero is wake-all". The logic has always actually been "zero or
negative is wake-all".

Only positive values (that then go *down* to zero) stop the walk.

The poll_woken logic is just an extension of that rule.

But maybe I'm missing something. That's always possible.

            Linus
