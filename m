Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0936C9F4
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588735; cv=none; b=TM4fiQg6oGB7gtGqbWwhVFY1hjUJvJo77sVOSV7YNEOHhKkUb94QpFPn95eDMl3ShVUiF2OVMrh8FhZRUTo3MqzMSbMoIv9EHsnrB7xnic6grHBIr5GtjV+SMqoVhjIP67qk9sco+cI9eA9aBuR4jngFdyrruCfqpSy6FgJV/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588735; c=relaxed/simple;
	bh=7s0rKR9scvgD84QvTOBiJiUg2JjvF9nGtFbIGJxaif4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGiu/GeH+4MM4kY4w8lW5BGg2ADb6XGw+r8aMVHbrWlHAuolwFg/otgBRzWCmIVuQjdoYq8uxuSfn2CR1oa67MNimjKtJN2bpz31AJQiYrDFKPuZd497VN85P+kri02yirWhFGJvH+RgQ2itnwDlewxBe9uVmz7sjAGwk006S8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hWe8WJq1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hWe8WJq1"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bebbc325000so116907166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780588732; x=1781193532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7+wqPGUkYgYLzLpNrBl5F+HLbRSqQcg4ZruoWvmFRPs=;
        b=hWe8WJq1ITv3CiTfgMetpWOif5CbLWNw4Jjb2TbX89V8juZQ7mA1rMUTgK6JGmOk/A
         ksedLLU8GrJCrATzoZTlt21dmkScrtjLgdQepEQMop/eUEFHO3NOn144Lq1wX+fxK4YQ
         uvcrXT30Xxg1u9j6n7FSdaKU937GCk/X3P5X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588732; x=1781193532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+wqPGUkYgYLzLpNrBl5F+HLbRSqQcg4ZruoWvmFRPs=;
        b=F+5LVuaj9CRkK0yPAlLZGTRhSbWEALtnY7+dusdG5cbcEopuAG9KIPRlmNb6yLbM/1
         CO8iIID0/PW92cafyQ2CRO/ojpcK2rjDHl9KajvKgoKqPkfMPul84ZSHJ3Cle7P0dKJb
         plMMWrAEVn7djzSAotfDmbWX/3Hwl3LCnBWAH6kgSH7z4wiViYBDR6yCf6lGs1rzabBM
         Mjj9rlg7VpSOU+EYSywROCYag4xB/4XyJK/7OkX18Jmp9RLI1+0KV8EO3NXlYhTno9WF
         kJ7piXecn5/ITfyZ0T0Gnwa8EeIDiymzIOUTze9WpxDywdBmT2RU1YiSaFVB16iCi5vE
         cDwQ==
X-Forwarded-Encrypted: i=1; AFNElJ849gvRtDsn56tVScVdVsyEgZrE+P/RYNKCBQq/6A8Ikq1ggdB5V5FU0I7kpIJVQ8YjNVCMxeAz8hVkNxuu@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjAolL5RUqaYT35kfkQyUX6KX1h7t1DCx452y3SFgbRJshaab
	sIGc0mtKYn5UgkdoUsra1JAbIYPdDxUGY2UHSyhnJzY0xFeiT48VwJygBhHL4OcohV9YtfS8dEm
	F1wzJf7Y9mQ==
X-Gm-Gg: Acq92OGJUgKyMNPSBrIWlyji4xAREyDUufmQmahGVnM1hjti7bfgL/Jpng2astO7rB6
	5axZZLM32eUwEUO6wKIIntYazPalsScQc4NIkvNy0lgh844JFtrX8JivXo7s1M95bhwhHQ7lOo0
	lfx6nMnM076APdkV2o+hj6PE1QCUg2n0hpggL2E6jCCBAZbi2TdMGVvEKfqWqcxg5QMpsaeRRpd
	ebY4hviJuf33rWhjDCYQbnlhR5C7Z0obU9s4uks15CNvBVs4TRpDvnPLV8jDo5VOnl+3/K0IFWR
	5h2iPRGapF8n3LlPNq+xr08LDrsqLm82VP1q/fxfGHQhRMpZEI1/mEetLunXlv7ObVcl2YjFtTQ
	d3tDFOVYZ9+hbME5AjFWYdpWn7lMF692Z/MmL2EBH2f3snDSywV67KxhurHaRtBk0N5M/R25ivc
	1BalPGeqF1wgidy0ECU05i2dVPQ3MZ8h3FSCVjjz6mXteizg6BU+1Q4IyeKgscuVyMb4/4z1f0x
	xYT+z86Qj4=
X-Received: by 2002:a17:907:2d9f:b0:bef:7481:8a4f with SMTP id a640c23a62f3a-bf0b2cc5151mr439272566b.25.1780588732405;
        Thu, 04 Jun 2026 08:58:52 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051d82a31sm335044266b.19.2026.06.04.08.58.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 08:58:51 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68be16c61d1so1767584a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 08:58:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Q99LkpMjTi+/IzLWxbqyOSekDKcj9TUUCVv+EaTzUYvyx8t1u2hzYNzrkxvwwh19M6dUfOduyQnJa7khO@vger.kernel.org
X-Received: by 2002:a05:6402:268d:b0:68d:235a:cdaf with SMTP id
 4fb4d7f45d1cf-68e6e447981mr4450863a12.5.1780588730255; Thu, 04 Jun 2026
 08:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org>
 <aiEb8CTM-ovMIq7-@1wt.eu> <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
 <aiGfgRch99l_5z11@1wt.eu>
In-Reply-To: <aiGfgRch99l_5z11@1wt.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 08:58:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0e8pP5haNW4qJP1=QwwUEctwjK5k07sv8bskitoMDgg@mail.gmail.com>
X-Gm-Features: AVVi8Cfm3XRgcYqAOfqktIkPjsqV4jnNlBPsed_wU8pvtWHjKA_FxUEOuJC1FXo
Message-ID: <CAHk-=wg0e8pP5haNW4qJP1=QwwUEctwjK5k07sv8bskitoMDgg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 08:53, Willy Tarreau <w@1wt.eu> wrote:
>
> > It looks like you're actually doing exactly the thing that I thought
> > was crazy and wouldn't even work reliably: you change the
> > common_response[] contents dynamically *after* the vmsplice, and
> > depend on the fact that changing it in user space changes the buffer
> > in the pipe too.
>
> No no, it's definitely not doing that (or it's a bug, but it's not
> supposed to happen). I'm perfectly aware that one must definitely not
> do that, and it's a guarantee the user of vmsplice() must provide.

Whew, good.

In that case, can you just try the vmsplice patch series (Christian
already found a bug, but I don't think it will necessarily matter in
practice - famous last words) and that test patch of mine, and see if
it all (a) works for you and (b) if you have any numbers for
performance that would be *great*.

There aren't many obvious splice users out there, and even if they
were to exist they are typically specialized enough that you have to
have a real use case to then tell if the patches make a difference in
real life or not.

So you testing that thing would seem to be a great first test of
whether any of this is realistic..

               Linus
