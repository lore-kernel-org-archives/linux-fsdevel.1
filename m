Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649483;
	b=dlv4BTA9w/w5LEI6ArzpgG+PoVqYkbagHsI1F2COr6j4DJrgHl+kjlYEH4Q78F9tuuJp
	 oBYCwuMUw32QVvQXyafoOEAmfK2EIWyf+xnBidve7y1MYYm42UUvKHWVtIhzv7sQTo4vO
	 /o1Uk1bYflt5DMs4pD6sopsS0+AmuD8/cVvGHnwafikE/Igb5SmX2CawTQcfAq+p/z61X
	 oIkS4V2Cg1GD4RJ+mYs3qJbZ1bLBvnmZFCz5YC+JiMzGRsyJ6eWqTDaft4r9sT8Ghnr0J
	 zKY/qL+4FCzb5THyL4jYy99KuUP3meDFkSx7cijSn30U4xdS5hsS1CfSKNE4sTdgt6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/ZtgARPu379mLd6QbSu5w/3cZo17qHpWETtyZC6BRtE=;
	b=CalbNyRh8N8jZF4OztlVUBynpNljwvqVeZFltVXx2mkfYsdKiIvGCjuAH1G0UizNeAQt
	 FRWxXE6LY1bmsxOsRnhiOc+KLb6PKZ8At+WwqcD+LLP5LFJpFHdLoPEdnIIY7o8UfqFLx
	 N2wjiB42uw6bzcqKSp05ak6FSMkuNZfVKLpBkSFTHYAwu1pf4DIvQTiat0WkKQvdAqD6T
	 1Khm/4U5GbvdqhZvnAB3BnCp6Y/gN7Qfy3w3QmQbF6611WXs9M5mcFwzR2prUHTcwt3YC
	 g4lIy0dhTF6+WVoBqM3/9h5hamr39P9yKon4CKHb6Bjdt4E8ZA0et7owReLvHG/1fhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Etw1usMc;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1E606A326
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 23:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF1E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Etw1usMc
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so1328133266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795649481; x=1796254281; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZtgARPu379mLd6QbSu5w/3cZo17qHpWETtyZC6BRtE=;
        b=Etw1usMcblqCO3PinEaDwsNBIFfJ2R3bcanX/VT2bD6spbWXgs4VMDGUWXITmEzF6l
         4cKuhjSQww9QCE9PiuHa0LDpfymmbEJ+aGkTLBUteHROqzGGXddaiwL8Ae04N/ksy9Si
         +Mag1Nerdbq310xTftvr6cmB5ax480VS+WF8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649481; x=1796254281;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ZtgARPu379mLd6QbSu5w/3cZo17qHpWETtyZC6BRtE=;
        b=1oM7pc575WikEheaNCYlwT0qo8dE3kx4u6+SslDkKGpD4nkbLbqgHASyaGlHvAPZ/6
         gMgW9PeQBkT1PUky1OYllfTJGdAxZiqWUpehiGLO/yj+nsULdcuST7RnoSQbxKIu6Ruh
         3HMWhX+98l3sofRNSqbSvxCB4TVqEX8GIBGgLyzM66IWMfnAKtrg78aNtPvePzdJWLGT
         l2Rl7p0YmdCc4N2aBhSGMLv/bqJj2ux58eHzpvrw9eW0uVqcIc8ws0QBYYTMVVTKyDWf
         ehSI8AUGsS6v+Cq2Eu9A8z1bDop0Ou/NyUUnIoiSzh1ikmCSM7y0BYYwRi75fQUyJjYc
         LsPw==
X-Forwarded-Encrypted: i=1; AL+hErGaoLnPHOQO3UeRRikU89usYMyYOfJPr63MsqK5gJWrlvYRZr/mKzO+5plmIizYhEJiqxvZ6biKmZ9dlCpX@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ah2XIcRO7HcpE6giza3Py0FAfATCiVSl+9gWuuPxeKvceXTnv
	Sis2AoI/I4Yw01YLqI7RrSEnN3Gpzcvb3kxz6qSQ5smEDFIKtJYUZJF8A3Ls6pDm/RU/6F/imG5
	XR2XZbMjUZA==
X-Gm-Gg: AZFdTZfg8E6KVpWAdVIcGySAFqMFXEDo7uZehSW/u/cHbIgAKKhfZ3uZ9aIUeGhWXOf
	KIHDfePNrrdaFN20rjhwZLiE5gBULoIUz7CcAh63xbzQ92DUh76Bt12ZqfX1+QW1Yq1tKXKxPTu
	sd+16BKK68KB34J9i9pBOtQYghVXB5pHxR+UnGf9UDwXLbqFPVoje7otwlK6aEQi1H1H/hZ90Zt
	uEK5GChNi1OFxATyOML813Wer+4EvIJKc6bCpr7a0zn6a3FqzEewNtVWuJq5dN1N/Za50dZ6Q+H
	DO0OMt8nEzASr5Nc4T6z+zp1avFZuQD1gaLn2qx0O81GGHogZ1rnUQZdPs97wj9GT1glJb7MIdl
	Xs6n98iA3c0Iqo+7ZZfNz9Jv+I967wgrvav9mYcCXT2XfBRa1zeW1dyL+QoPEs8hzi958rS176Y
	Y9tNSCc/BEM1b5vneTdYgUuiDatn3GID6SgsfLKQ6XpH6d5iYciCaHe1GO8+ZwG/hzj1bGblTjK
	GRy8SBwcLL2NoerSuT4Km7dh6OZdBLsukdYtt2zPsDW7SN/SWqY1XZynlhY0M0BXUGZB6ooljVy
	nmKO7tckKKsnX7mrquWohTMs4+lNO/X8tnEr8koAoiBN470XeI97OUqHwEC3ljEij9xaocMEjlv
	oRG1RihPV+mCXJs7XoxqTXoLu
X-Received: by 2002:a17:907:3f9e:b0:c43:b0ba:485a with SMTP id a640c23a62f3a-c513191c4bdmr1703586666b.21.1795649481419;
        Wed, 25 Nov 2026 15:31:21 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afec177sm703978266b.72.2026.11.25.15.31.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 15:31:20 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso13177631a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 15:31:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHOq7NC4c2DWkplQLaXJr8mgb3NLClLmIheH9by7dgt2uFjBD0iDJYvit+Zfg26tJ3683bivh5IkOFQ/JP3@vger.kernel.org
X-Received: by 2002:a17:907:3e86:b0:c36:777f:824c with SMTP id
 a640c23a62f3a-c51315851d7mr1801088966b.4.1795649480354; Wed, 25 Nov 2026
 15:31:20 -0800 (PST)
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
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com> <awV66PQWrBOKcZCE@redhat.com>
In-Reply-To: <awV66PQWrBOKcZCE@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Nov 2026 15:31:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whanFATRSwcW9TCa+4zR=k_QnNFtgxnFCg1d_vr6Ye=OA@mail.gmail.com>
X-Gm-Features: Aa3M54q0sE_qX8UjHHTquK89Ec1CONb0zaQmq3jckN_Jm8WAOhqo827YNI7zBIg
Message-ID: <CAHk-=whanFATRSwcW9TCa+4zR=k_QnNFtgxnFCg1d_vr6Ye=OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/wait: Queue non-exclusive waiters at the
 head in do_wait_intr*()
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 03:54, Oleg Nesterov <oleg@redhat.com> wrote:
>
> This will change the current behaviour if ret < 0. Say wake_page_function() does
>
>         if (flags & WQ_FLAG_EXCLUSIVE) {
>                 if (test_bit(key->bit_nr, &key->folio->flags.f))
>                         return -1;

So I looked into this. We only have a couple of cases where waiters
return -1 to break out of the loop, and none of them have other
waiters.

In fact, I think that's pretty fundamental. The reason you'd return -1
is because you have made any other wakeups pointless.

The wake_page_function() is a good example of that: it returns -1 when
it has taken over the lock. That means that the page simply isn't
unlocked any more, and there is nothing else to wake up, because the
*reason* for the wakeup has fundamentally gone away.

But you're right that it's a differen tkind of case, so there's a
slightly expanded comment about it now in that "always queue new
waiters at the tail" commit.

And:

> Can't we at least cleanup __wake_up_common() ? See the patch below, I already
> sent it but it was ignored.

Yes. I've added that to the branch too. Maybe I should have added it
to the head, but I was lazy.

And I've updated some of the commits with reviewed-by and acked-by.
Maybe I should have added it to the head, but I was lazy.

               Linus
