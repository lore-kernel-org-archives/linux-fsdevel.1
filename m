Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B64D8D81
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527239; cv=none; b=uWtc+HpixtdWZ5i9oqE5AWMv3v8ghEFBc1dFpuY21N5q5KL6JAlo7iD47/KvR9nM3Ku2ZeeALbrSP+KudrBreM5AqnDJWjkqyj+zeSmCvMcm1mf6JcCF3x5N4LAwutmc5qDyG07CoIFd6u5S+1OwtEvgw01BtD3nomZq/Xtk+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527239; c=relaxed/simple;
	bh=R/zZG4ZyrvWUzuSIU5eJSLX1T5t0EJujPTyy2snq0VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d419+k1r6mc37ErMkudatDPN+sOZyyapYApkeGHJLRmxBH9DizcRiiDsuL+4keUylGC63PRp/W5XcE2gLlWA9FiIIEhR/U4IwEsfxWx9nQNeHVDnBmRe+3e15HO4U2L0gUrekom6pq7w4WOhaeAUEbe8hRTVpR+jX6yW7326Js0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dE+umDdb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dE+umDdb"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d5fd50d20so32404a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780527236; x=1781132036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d66PsLO70IOujHc9tD5MHey7l/21gIQRZ4eLyqG6j78=;
        b=dE+umDdbmLYSJP06t6FDre4rXB1MQi/ipNRAMF0gNP79dk+7Ep+xdrHGJjHtBnQPWz
         4qIcL/QR/oEhbTj9gZkM/vgrqepcTWNHjYl3s/0DvYujyIK1CiHLyXqYrNuwWHDlQTxW
         /qWd1eES/KmdJWsDu8Yiu6phCOMMITWFehz30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527236; x=1781132036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d66PsLO70IOujHc9tD5MHey7l/21gIQRZ4eLyqG6j78=;
        b=XuxJiukhQy6+PzOOjNARnxcQirWI0FUIo6VnRo0XjzkY/rH/9s08IyMi0casKWF88P
         XhIEfHxR+JKjhZM40t07UkxBjALhEX7Lm4ZuVDK+sWIXqlOJ7NmSb1cpPSxJEfcjWd1b
         djYQvWNMvKkPJjyWPYKScYIRsi9pOLcvwfQYtsBjO/3YLBEChwQNQ4GO0dZPNdcA6HHd
         dLCBxUraLhfEVsRDUVrPdSEb48xO9baZliWbW8baJam/C3gg+/KpqK++OqP+qEB0iD1M
         VGf+UNG7XZ9ikvA4HizCNv0qaC/pmzYywYuAHgGyhBjx2NZL2eaGTmjLBHP8w9HhWdb1
         rLZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/EIJqrACktxcuOJRBDfeY57vUs5orb19XpCYEeaNoqgPltMbVCuhmmNqeFZvSlYmzkTeZ+rrkDmFEzJoln@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMuNpQFMKVRzn19N6CiCWcfYh3D4QQFzaK2A5DoZ7lO7V69nr
	pJvNl950UASalOqCixNj1ZcaZJzhQDf8RnlWfLR2OOOFEOqgSESvQ6x9I3//SjlQi0CTwVsUEZw
	atU6zxhmb+Q==
X-Gm-Gg: Acq92OGIH00N18po6FRDOjLTCVoqG1mwGNz9Pz8I5icqC+m7qOiSnKfNYib5ANg4fvq
	9tMEC8Hf9whBEeh8GRCmLmSPJ5ZuTnp4JPLXeV0iU2EPkyFtvegCOnYSWNchH5EhUB7m0oHdeTl
	Aa1mfEC7C530A7lRfI9GRgfWLB2UkBcp9gnq4/GzJqMYs7l7T9Bc4RJJiUxLbu2JSF7SM6e+n7/
	1FTieLPvdT5IH4R3hJzUv5I7z0IyFT9Ec8fTR7/Sas9+niFWdZI8wDsZbPzHJD6YUeN270kpnOA
	A/zFtP9G47AgIuZV2ASAB4m9vIz/VjOaEDDFsuKmcNW++Ien5EsPS5A2UoFWZPxG/HDyIaxRe3g
	b5U+e95x/DPpoAPjOnItwycG3pRZH0zhM6/dWYoMJkuFDjJspCBLEJV50iIW0zUkk3RRbp3ZetM
	UjARO4JTcG8zOToe7e9EQ4xMA4hujDCLAhMUWp+9+j+Ws9VhX376jCcgVtSiVxHA8YBy+nYqc3U
	QhRPp6nRrY=
X-Received: by 2002:a17:90b:4ac7:b0:36b:8873:d96d with SMTP id 98e67ed59e1d1-36e32b3baefmr4916808a91.11.1780527235763;
        Wed, 03 Jun 2026 15:53:55 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f710ee4f3sm811349a91.13.2026.06.03.15.53.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 15:53:55 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d5fd50d20so32399a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 15:53:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8GvSevvw5NGDXkGzDW6/ZTHRalO6rtcMkKab/AGMxNS4oWpMtQGap6QWeULM9sOf/lRE5UTAYvAsb43kdZ@vger.kernel.org
X-Received: by 2002:a17:90b:4ac7:b0:36b:8873:d96d with SMTP id
 98e67ed59e1d1-36e32b3baefmr4916778a91.11.1780527234968; Wed, 03 Jun 2026
 15:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
 <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com> <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
In-Reply-To: <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 15:53:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
X-Gm-Features: AVHnY4JfTnadgKQknxIsZL_Ab3vCkRcYm3kghJCvdkf-q8nXBlQAzmvvhTEK5F8
Message-ID: <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 15:23, Andy Lutomirski <luto@amacapital.net> wrote:
>
> So I'm suspicious that you've possibly make bugs much (MUCH) harder to
> exploit, but the underlying awful code and opportunity for bugs is
> still there.  MSG_SPLICE_PAGES is still around, and there is still
> (AFAICS) no actual coherent description of what it means.

I don't disagree. I've only looked at the filesystem side.

The networking side does some odd stuff too (and I did look at some of
that, and had to be edumacated by Jakub on some of the subtler rules
for what skb data sharing is ok and when it's not - really not my
area).

But at least MSG_SPLICE_PAGES should be kernel-internal only
interface, and once you don't share page cache pages with networking
code I think that kneecaps a lot of the attacks.

So that's really the aim here for me - at least _attempting_ to go
"maybe we can just limit splice enough that it doesn't even *matter*
when networking does something odd and questionable".

And it's entirely possible that the current zero-copy "networking gets
direct access to the page cache folios" is a huge and insurmountable
performance requirement for some loads. So the vmsplice patch - and
_particularly_ my suggested "let's try always copying" patch - may
simply be doomed.

But I'd rather try to simplify the splice code by removing complexity
- and possibly then failing and having to revert it and rethink things
- than not even trying.

Because I think splice() is a *cool* feature. It was always *clever*.
I just don't think it's worth the pain it has cause.

And it's been around for a long long time, and after more than two
decades it's still most definitely not _widely_ used.

So that makes it a failure in my book. Sometimes "clever" just isn't
the right thing.

               Linus
