Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795207638;
	b=kRrK9VZS6qFiHyqp8bKvSO4yo2GelnLEnLJcvhHKB9xzdzxI6Igme7SANIEBP3+FC5UN
	 4MGoY9GeA3Wz661HYjUEl5fvQvwgRONV6gceTaKF13sbi9Gk/KB9OgNvEvvDuYXXGcts5
	 uXWrz5RFP+S6BCgAb7PvsxFyJgDgnNOeO6yfLRxaK5ahL3Pevp4momc6B9nXR35JFXFMJ
	 /xFNYWBR7NuoMYxu6hub+Bwne6mOpMolWIwz9s+MsNOgvQ2KRt328v8zlpTb21FC0eLJ7
	 AEQXk/t0e7W11oqTK2qj6huR8pq8ZB5VumURasoOc8/qRayv6RzeH5xtvVcC4iFqN+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=llVEsGyf8yGSEqiwg3JqL+nGjFux4pEvwSi5fD2JB/g=;
	b=YE57vstB+1t2Mbw95PWcXC+2CaKbMDyINfXuT2e5g1yG1+Kdd05NrOpa8o41plEbRY8N
	 7OJp4zDv0noEgYSNQaGjkFz6mHLOE7C8SvFpCAOZjtskN/MwMa05MQ8adfLfVI8ByaIjV
	 fb10iiKN0afZ8ClSkucY+fgzLPvwWxVGst1t9YyZz9VZtBQYFoPmdq5zbly+2vYC80D/p
	 HahfVbZusmiTtbbj1AM/UF+9q+2C6vUsADX6f+/4UPhNT2hAYTHKRsM7/478a6cf0dnYf
	 JMXsZvlc99K62PzPBURXfxWZZvBpi4bP3DjP1eYmwV8skqLctRjnIwsDQ71ftNwW8tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mDAOssts;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE7606A6D6
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 20:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBE7606A6D6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mDAOssts
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so2161436a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 12:47:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795207635; cv=none;
        d=google.com; s=arc-20260327;
        b=PDibtoCgH6jty9x3Vw7QinZB4fIBN38VdZ29T4FVTz4dZoOjNpOzW5b4URecz+ko74
         gCuSRR0aTHlurVL8mEI2Ce1JYyYanslHIPJmka+WDjwHe/IwmqjrGSwY6OpaBkFxDvhB
         d86PatA2mWREMcFWejLWdv6xAFH8RZq1vxS799Yw+fqjqxk9VoGKo/qpqnTXb0kLg2pS
         e21W7BIeG1jVWaewUjV9syWHh9x/Ggdz29EVGSMfcx4gD78RIRJkNPU3XWbQeYry8edl
         LqcLCS7UvGJVjqTxKsqhi6i4GhNr3gLhNAJ17u3DBlWkse/ZJVxw7tA6vQt45ihRdkvg
         T3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=llVEsGyf8yGSEqiwg3JqL+nGjFux4pEvwSi5fD2JB/g=;
        fh=WYgpe/SCU9H6/bv5xNgO7JRskryFK8IRXhC8JSQQ+60=;
        b=FVBT2/kCG1KApdEKtDcQyP8Z+/z3EQ+EBw0Y6zmfXDGtUBGHJePYaCSXNr8kpG93AY
         wVPy4nxbH/DC1k6wV1mQilJ5yAMKtSxh9D/x5FB5P7jd7JITQVJs0Zqu0Urn9hQNvahw
         K56HHWTwtj/h4SOzi+RK+XZUc9qBrvp8x74e2BjEuzCKvt5NQokeYAj0rCEnZu++wFrj
         DpUskve3E5MD0UGWE/Rm/Y5Lzo8TvH98gfKkGV2rM/nGZX4yzhHgFP1T1hQ67ajCuzHO
         IVref8La73FuLn5KExS+FI/wl3IGeFIx7b0chIK679Bcwjlucm3dj7WBTZiYRBdny8lz
         ZndQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207635; x=1795812435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=llVEsGyf8yGSEqiwg3JqL+nGjFux4pEvwSi5fD2JB/g=;
        b=mDAOsstsayaGpVN5mrt0WHqYfJMxVl4xNjlphbORMQuqB4zPnUbAH8YaL5zKoIC4Eu
         F9LqIsRSKgJhEV5v03T+Ql0DWyROGQUMSOMG9rXiKslwSVX+DZGe95zlEpbsvPZ12/Oe
         /1Lg9q5g9eiw4avDt19dm+doGHj/TFoidHrkLUVkXu0NzjOf7FppJD0z5wgyVLDT0o42
         scAWYbqIDKZbrzNtxRz2nSVGye/JKaL+ET7lrUtqhawwd240uLRGeYfjniCwwZ0qBqw2
         Dq3r649QkfCvJq+cnC0iuLmcHbOL56jN1SyeI49SzjDaOGrK6m96yCsK6VRP7oVSXgeL
         mnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207635; x=1795812435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=llVEsGyf8yGSEqiwg3JqL+nGjFux4pEvwSi5fD2JB/g=;
        b=rnU1hHd9frQywmHgAKjbrcEE0FMTCPV0LURRjMuBj8qMloG64q6W6/mLHe/MjLnYIv
         ZXrevmV+bpdqJnz5N93rw2jCneaxT1qKEaPXDrJrEWdqDcbQvud5nW0Xgs4N+0lPuQ7e
         uGjWxzxPF16dmde25C9Sp/ROS/S4fhxksaY029Q1wBHlks2KXJEBvSuEcRK90eBBn1S9
         Xi2cCuuTD3c3M1B4SpS7G0KXKVe54nzANVKlYDZUxHhNB6LrDoR2l7ZQG8TA6HjZQmkB
         l+gwf/17wZuD8cO8+n81n5IrsnXi/GI5MHGL9G/Uqv0UDdUINoB66yZDXYSmH2KvLt6+
         lvfg==
X-Forwarded-Encrypted: i=1; AL+hErF3QS71K6YjysGig1kj1DjBWM7k/kIV8v5cmu6HSjmDLxdWxHf3bOXdVDSzqq1Kg9l6KcpeAADH9GqqH1pj@vger.kernel.org
X-Gm-Message-State: APuU4Z+sodrz0JxMy9HUS1B54cxkacSn5NJ2xgxHA8tJmsHzXTMZpKOB
	c67F3KuG7eyZVguZ1bn8qnRei1v77tybwyVxFs6BLcjNurOVeJWEjzn2zVlfqegvET+SxDXj+HD
	J5p4WQd1kasuD3t2B+rzyXEyA50hE2/k=
X-Gm-Gg: AZFdTZcJ7rR2BxwoCxXbJZZB3V3jFBwHkZuDdmDC8jd7e97zxPl+Dpxvx7u9wANK+/H
	MNwjPCVwMUU5LCYuJKeugUdcCyTmutJ8PRwISgpRA/inQVcPx72cCOGbhfZKupGlIyB0taaztVP
	fIPQuCe0S/7hrt+vX2/RhZDFVguqFISyrS8WfK3xBfP9+0LKuSwsWoRFH1aw3Fgj83tTI/uDdXA
	uWzNlgQWVN/QgASr0UdgP9s09rM2ml7fWDDm9BPo/IQ1+4bluDGzQWAFTKKZHfFeCcpWXNCEoQd
	5Ne7XJOe0Mpz6Xu1yN9Fip36UCxRCPJVKv9S3nkNT14JdvGrjGgXqm8/3nTJ87/7+5JFdq9Co8f
	WEeuYNt7hp/+4IgHqTRICkDkVVz5/qMZfK6VUaBmyi7QglPmI6j3MaRCK/5Ec
X-Received: by 2002:a05:6402:a507:10b0:6b8:f674:e089 with SMTP id
 4fb4d7f45d1cf-6ba37e876f1mr2474697a12.36.1795207635126; Fri, 20 Nov 2026
 12:47:15 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120184225.257554-1-technoboy85@gmail.com> <9cabfb96-21d5-46a7-a0e5-df0908fa67c5@cs.ucla.edu>
In-Reply-To: <9cabfb96-21d5-46a7-a0e5-df0908fa67c5@cs.ucla.edu>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 20 Nov 2026 21:46:38 +0100
X-Gm-Features: Aa3M54rNdpAi_ZPAGzdrjgQEZILfET328P0IFMfa2C4FAQfNHEVsWA64zuH6c6A
Message-ID: <CAFnufp1ec4hDOoXCy_NdCEhkYgZzQktvN5RizyEkMQQ9MneRbA@mail.gmail.com>
Subject: Re: [PATCH] fs: shorten I/O that would extend past the maximum file offset
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Ding Feng <dingf3ng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno ven 20 nov 2026 alle ore 21:03 Paul Eggert
<eggert@cs.ucla.edu> ha scritto:
>
> On 2026-11-20 10:42, Matteo Croce wrote:
> > +     if (file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)
> > +             return count;
>
> This means there's still a problem when reading past the maximum file off=
set of /dev/mem and other files with FOP_UNSIGNED_OFFSET, right? If FOP_UNS=
IGNED_OFFSET is set, are the file's own read/write methods expected to shor=
ten I/O requests in this situation?
>
> Thanks for looking into this, by the way.

Right. For files with FOP_UNSIGNED_OFFSET the limit is the unsigned
one, 2^64 - 1, and crossing LLONG_MAX is already allowed for them.
At that limit rw_verify_area() still returns -EOVERFLOW instead of
shortening the request, and this patch deliberately leaves them
untouched.

As things stand the VFS only guarantees that pos + count doesn't wrap
past 2^64, and everything else is up to the file's own methods. They
don't behave consistently: /dev/mem returns -EFAULT for a range that
goes past the end of RAM, while /proc/pid/mem returns a short count
at the first page it can't access.

I can extend rw_clamp_count() to shorten the count so the range ends
at 2^64 - 1 for these files too, so that the behaviour is the same at
both limits. In practice none of these files has data near 2^64, so it
would only be for consistency. I'll do it in v2 if you think it's
worth it.

Thanks for the review.

One correction to the commit message. The second reproducer is wrong
as written: with "dd ... | cat" it is dd itself that does the read at
LLONG_MAX and fails, not cat. The intended example has dd only move
the shared file offset of stdin, so that cat then reads from
LLONG_MAX:

  $ (dd bs=3D1 skip=3D$((2**63 - 1)) count=3D0 status=3Dnone; cat) < hugefi=
le
  cat: -: Invalid argument

The code is not affected. If you apply this version, could you please
replace that example while applying? Otherwise I'll fix it in v2.

Regards,
--=20
per aspera ad upstream
