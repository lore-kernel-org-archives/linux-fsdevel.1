Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932584;
	b=GKzeK2GP2PckD6oGCkKmE/DXBY3W63yUwvIji3ejZeDA9yow++FqzQQklDlVE3BrEfTJ
	 grAEuFTm4Nr2sPsUVTmildrv+5/t5+QkIr8RGb/fvOUmRCpHnOMgM3GPM3Ztn4pZ0qpt1
	 kPNb3uLgCfA6G9+Mgmbw7VzLfBW6ruhyRHa1yvWFUkWGtF2H8RoSjjSA2aGdOKgJhRhu5
	 8Bf663M541sgEVySpiue7tRwAmheIcuM+mA6aPoS6hh2XLKpRseoGwNbC1IOYca9Pl9gk
	 /I/G+5wXS88oMq5IrLKDLUrZUJ9+yI33sXyFAjvknRYqGnoTuu2ThnigMBSemYL3pfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=grJoK+18+h3lRgJDxuY0z4u1arzCjZYyT36BXVitrDQ=;
	b=D6x0N47TLAEuKgpRVHX7ZBTpWoq8DVrF+RZ3r81TAMzq/jn9b/ruCul+3LTtpYLKUMN/
	 XYQF+mKlP55aX3QgNTKLcCMdmVoZOzlsZXkMPk1uycn9FZDXjFBUIwl92Uf2sSMzKJoMl
	 VAvIZ10Uhl/EpGebwOg58Y5LlaE+svPvVM47ZaeDoRCEwd5wSxCyyejQ7cyFJUI5kXbq5
	 JeYDpgfGx4WLor6EOWARKtGn4W4qv1OoiAUvaX2IXGNaks4xX2KpI3dOBh5IzCb7LLB8A
	 GdHRwqJvPPY1ZoyC3Ov3lTEQwNvFxoM44SAQY0utPyFxeFBGG8QKjsA1rpjPnHQapmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=PzmReocA;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D70606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 16:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65D70606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=PzmReocA
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d21051042so328596966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794932583; x=1795537383; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grJoK+18+h3lRgJDxuY0z4u1arzCjZYyT36BXVitrDQ=;
        b=PzmReocAwFNWsG668DdIue72MYy6gauaYtGllJ9JBc8ynV2wfsIlnMYpoFkIdi857X
         XwJGmPquXLPMJHd1vt8bplzpHYXzvJ4xkAfy+L1XF4AyfdVD0ZzXqX/3HqBrtrmx/tAf
         wNkKduG/KwgKy4aMWSbArAL4l7ZqlUQ3nfroE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932583; x=1795537383;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=grJoK+18+h3lRgJDxuY0z4u1arzCjZYyT36BXVitrDQ=;
        b=B3LsJ9pHrd6ExQFOs41u3ffLGG4E813gxXf/PAj4qJ76pof7lTI+DfP8Hi1d8rMDyK
         LkmRsrf05hHuQ7d6I+oKkssx0MtllR6LG+opPrm9JrjZ2xj8CaX0gTWN1Np3TqL5l0do
         raY3gnOpBlbmsDjxfGM4epCJVcx6j8aXNZxSoI6axmeDYHZrAk9aGA+vMA+Xjf9UzKf1
         DbMcVJHhB408vvhLHzbCKybCgT3u/O3M7gn93KnWBspDsEH6JPxp7KvZ9dRVcAN76V7R
         8xjLtZ6L3QJNJBSXE6O/kl2yx3HRIQyhKGnn7xBe2wFymZuMXdd2Uyz7kOlN0d13SOLX
         E+Dw==
X-Forwarded-Encrypted: i=1; AL+hErG9JuFjIWFJlCYOsqeWank6ZbPydejRQa+Wq0XiM7HOnHeK0bv/I+U36skVn9koEeTbPXh1thAJUSMH+UoW@vger.kernel.org
X-Gm-Message-State: APuU4Z9Wvpyzt6/z4xTXgE8o1NMtNyNYA9mt0OaKJLSmvvKYrIlSSlQI
	6skVo0fLtdyjHfgZgNoDPBPEfnwHAxBVXWZRaH+9qjJDYBLgfFEDL5KpdSBJrauri4qAaXpBV7p
	i5PT6zg5diw==
X-Gm-Gg: AYBFou37sDjK8Jn2BACu7xi7LYb4qS1tNMIzsUOsgL/FH93aud6ffrTHyFWqr3FqmlB
	u9ZEl6tm66bUZDuHqnNQYJQlLS/lqAb2MmRIkm7Eo4cIXULLYw9OX6+cYJ0MfyNg673F95NhzNK
	iQ7c+/6cTT1Kvzl71GW6dbJmnVJRfo6Zs/rCU0XcwpQkL83piF3xSrZANDvVULR+7BBF19otQHe
	ui65jgU0UE6+T8D/J/b/ktve7f/OFbtvRps3QFEj0KViLNAqmnWoZVjcy8LKP2+k7UPzKNZUja1
	12t6XTWVZ1SK7lbb5W0z6EZIbIWGhEi1Z1ObmeGOXrTCv49/y2wi/zZdQ9+BSFIxp/XNR6a/rNK
	J4TDvBJh8mM0o34rkjnqbH+eUDtQhOVMyNEcHTIrqeHWOwtTEB5f8tBKRJ0qc4+nh+36Qw9buJK
	0Gqtu478IXSmeSa4Q5JZGejanXR1cnAjfpOz/wB9WOR3MazFDvGqAkBqD63V/Zhbe74QxDH4WI2
	OVeaYKtP1BOmTNhLgkssFQVeth1UYUKf6rHILcqRBzT1bHibqp6QhMYh3cGA9Z1HtpXBl0Kxiy2
	FpyqqLhqOHVWz4F0KLOhOLosgr3Zuu/+HQdcVvb+218sNDdY+HQ9i8PkbWe6KRdcTSs1VV1eCNx
	oeCc=
X-Received: by 2002:a17:907:608f:b0:c50:6718:67ff with SMTP id a640c23a62f3a-c50963980edmr1136865566b.35.1794932582689;
        Tue, 17 Nov 2026 08:23:02 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510ca0ef28sm1803266b.22.2026.11.17.08.22.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:22:54 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so9208a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:22:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGsEXuuH84602TUoKcfguwl1tarGRnUa/f47xnnwclRB/nJNpACzWbbWdS4nrRiIa9VEaNlKgjDtyYOneV0@vger.kernel.org
X-Received: by 2002:a17:906:7955:b0:c46:7ec3:fdfe with SMTP id
 a640c23a62f3a-c5096369c4dmr1218639066b.19.1794932573142; Tue, 17 Nov 2026
 08:22:53 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com>
In-Reply-To: <avxWKI795DthE8Sb@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Nov 2026 08:22:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
X-Gm-Features: AclHuK88r0MdvPyPBWEFngj9XAj85-331AH_Da3bLeV6HCZQzC7nMHyp9Qr3R6o
Message-ID: <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 05:27, Oleg Nesterov <oleg@redhat.com> wrote:
>
> However, EPOLLEXCLUSIVE breaks this logic. ep_ptable_queue_proc() does
> add_wait_queue_exclusive() if EPOLLEXCLUSIVE is set.

Christ, how I hate epoll. It's a pile of stinking shit.

This literally violates THE WHOLE AND ONLY POINT of exclusive waits.

The rule for an exclusive wait is that it *will* act on the wakeup -
either by consuming the data, or - if it can't consume it all - by
waking up the next waiter itself.

So it's not that "EPOLLEXCLUSIVE breaks this logic".

The logic is fine. EPOLLEXCLUSIVE is broken beyond words.

I really think we need to just actively de-emphasize epoll. Starting
with saying "you can't add EPOLLEXCLUSIVE, because you don't honor
it".

               Linus
