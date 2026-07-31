Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33845A2A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515183; cv=none; b=Sw3r8vea/BfSYoX0LTBfh1j+kODZ52EGM9uVz4v7s4F1zxcvPTD6mXE2fccs/Bx3g/VKDDUP+PflV4KHzLm/Pckl4zGmIwbd74jycX1CwrqNGDOWkJX9M/Qm+/PtuXkydSaFmv8p6WQHR1zhRp1byesm1yXDD52MSen74BQryt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515183; c=relaxed/simple;
	bh=8pT4GfINvG3duG6dP09F+hI4qE8C8BGPYMHMoX6nFho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyQgP3tYLfTrPpjGOjlXQiwM+cEfVhXwZPF+2N9LnEiK7i754pkEhvoc2KOIwsUHqtKJrutT9HDKltrCM/Q3gDmNylxJFlpOiHEE7vRyLNBjNDyhpfvY6F8O+ZI3/Go/EbzwBb1tfwZVPkIT45KFjmAqC9aDfHzL8tO+gcq8fxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JrJlQNqr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JrJlQNqr"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c169ae1cb26so395584666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785515177; x=1786119977; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZgnNTfFrNH5Ao2efM12gnUM2kdkogYLn1f6O6OwYWw=;
        b=JrJlQNqr9XimSAOAs7x8JS8p0LTbrCHnjzPto7Ts0+lX/UPYQ+GJ0XJg0REImXgWuv
         deXU0MeiTIMr6uPP/p7KD/8PIaOphlG9cgiHpjrEVgQ/6q/7Zw1tdpQqnzoxsi88wT/r
         LYtHBIBj7PXsYF0MDFQVvnkerYezTo4945LO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515177; x=1786119977;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NZgnNTfFrNH5Ao2efM12gnUM2kdkogYLn1f6O6OwYWw=;
        b=KbXLGZeL+U+HRkh/WnmLUMDDQvM4xi3SETKPDtpc4GT5iSCVEDeAdgiac1K7HVzszx
         Y750/y1/IvGtJbww19FlhznamqKLbR2xQmaTm8OOSF6rNgUV212AcgyMTT5Iq/GdL01b
         AcoPF8nO9pnYXsm5xzwtcL2HejBUzNWUwfYPCQJs7aUdgq6Yxv0UP1XCrR8rrsLOpnhd
         w/xN4kpdkgHcN24OGw0gmi5dJNWxrc7nItIFEYHvRso+6JiISUwo4OshpdUq4yuNJQWq
         TZfOWqV4pPhXvWqwuq2yswgH1D0biZHk73CGCONAe/64/2faSSRZswq72aN1cuMfkxIg
         ceNg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+cfyodsJMiIoTtkok/qYFsK9u1PvGRbkSJEixDp5KQGkoBi7VuIljjq7+hsoh9v3SPOtKMjRDG40ZACG4@vger.kernel.org
X-Gm-Message-State: AOJu0YyvDpbc4M7Lkul/y2ygtMdCBdJhvDzqzkQhgU9MKVRUyDgGFwms
	NsdsKt5frh1VUAbTxcZg9ldW2HpoEHM1ctPjaLWab9C1BgOIJk0w54ZUqoXS6o/omeB0DAEBgvN
	NRpAKyDo=
X-Gm-Gg: AR+sD13/gokAAtJsukDkMaaEzJSTkWL0ALWHI4JfhPmbhK6K8Oa/OF0BFfWneyfcLue
	H/Uu+HRy4dD+ngSHCDg6HawZa2TWF9ulItAIOwxM0BGN73EAqV2ba/N2j0wc1pfaqOrKvP0fAiU
	ouUDcsNEAidqIzOz1MJUCxiCCBEopdiIFifgMQqg4T5KqjNiXoh+t5hKxIosZcIMBKnr8HuhLcN
	sPXzTVS1XIHLPn7N2fmOslFl+wGguTkrEJSdgUdoWQLNGCfbvn3QM+VSJWOUFR8lzWpUQspvhtY
	pykvPFG/0B4b63KURr9FWGgIcs/OjmEZ7G8uKv3XtrfAdSP5Y1SonU2Q7m/wpoRK2ubLRcnRloC
	dcXC21M7JvPJ6BynPLRDjFtWhUKKOZpfsZCopYIehtdDBFYSP17oXwHeVYhL0ojxuq6jQPQrI95
	64v1BnuwWVTjYBYLC8TxF1bmSU6SSumY5yS3VZZVc7tnNqBJleN7TTyREzukdii3A5ViS1zOxOp
	vyvOi6TtRzQ/YsYMkG3HpV3xoVKhDnyfYcL5Q==
X-Received: by 2002:a17:907:9288:b0:c16:acff:51a8 with SMTP id a640c23a62f3a-c1fd35fc779mr177701966b.17.1785515176805;
        Fri, 31 Jul 2026 09:26:16 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c6566b3sm2072386a12.23.2026.07.31.09.26.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 09:26:15 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1600d040e4so167867066b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 09:26:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqhSYsUVsy/BnKWnRzyv8fr9+xVYvCqBJwrtIvPpUuog2PI7S0mx0npgftS1mfNnZTiORvOTLbsNJh6Mulk@vger.kernel.org
X-Received: by 2002:a17:906:99ce:b0:c1c:1fbf:5d18 with SMTP id
 a640c23a62f3a-c1fd316d100mr201595366b.3.1785515175103; Fri, 31 Jul 2026
 09:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amtbpwrhlNGJ9OK6@redhat.com> <CAHk-=wi7EccGaeo2Q5mdcvcQJ8VX7tcJWW2fHkg6vfmHGGX8AA@mail.gmail.com>
 <amueLRM-DrYbnjLn@redhat.com> <20260731-blechnapf-arten-blasorchester-4e05dd1b2c58@brauner>
 <amysHlZp6f6q498X@redhat.com>
In-Reply-To: <amysHlZp6f6q498X@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Jul 2026 09:25:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_PtU66p4iuvzCz13P_cDCfKg2OOuV-v6wq19ua8LyvQ@mail.gmail.com>
X-Gm-Features: AUfX_mxg27Kg07NK3K1byK9KwocM4glZNJ49A7mvHpifqZOMR1EOAwQNVrEvm6Y
Message-ID: <CAHk-=wg_PtU66p4iuvzCz13P_cDCfKg2OOuV-v6wq19ua8LyvQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jul 2026 at 07:07, Oleg Nesterov <oleg@redhat.com> wrote:
>
> It seems that Linus doesn't really like this patch "in general", lets wait
> for reply from him...

No, I like the patch, but I want the naming to be about the *reason* for it.

The problem it tries to solve is literally that some people think
"edge" means something completely %^@% different from reality. We had
legacy epoll users that used edge-triggered events but wanted
level-triggered semantics.

So it got literally hacked up the minimal way possible.

If we change this to be something that isn't the minimal way possible,
we should do that *right*. we should make it clear that it's a hack
for user space behavior where user space was simply asking for the
wrong thing entirely, and it happened to work because we would send
wakeups willy-nilly for everything, so even level things that didn't
change at all ended up getting those "something changed".

But "user space is doing crazy things" isn't an excuse for the kernel
breaking user space, so thus that "we'll just continue to do our extra
notifications if you use poll".

You are now changing it. And what I disagree is that "change it to be
something else than the minimal thing, but make the naming be bad and
the explanations for the non-minimal thing be bad".

My argument is that IF we change this area, we should damn well do it
right, and document it, and make it very very clear that the *ONLY*
reason this exists is a user space legacy bug that took advantage of
legacy kernel behavior, and that we are papering this over.

               Linus
