Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BC1419A4
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675182; cv=none; b=ki+1Sp1dsWENTEpcPKcOfCMlLqk5mmlcN5Q6zBiEGviVdsDrh99mVOPSicT3Ft28IYxZl7Brwh2RmCnMThcV1Yj/fVdrfW77lzij02Dm5oKhoaZl+hzxNTD5HG/Czp0ZKTo4IQY+/273/ld0cFf2rDeA6MrlLiQs+rJUT+kI7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675182; c=relaxed/simple;
	bh=Fj3s5frbyB6TsqrxQjPY0GZVgFWhmiPiWsC9BqFUZ+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2QzuktACUPu/vNUfEhyx3HQK1VTLRCY+EZ+ckJ/h671PmsRXLmMt7kpsV52Be/c70hGF/p0WJXYk7kqGPnjftcKERX88+Q+IB2XVZ3v2lN/RJW1jhL+sdYC4Cc1CWgZ4Td4ofyWQ9ysWdXBzF/W+vsAKVSh4b2OPn9yHBvO4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=avmKjiGk; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="avmKjiGk"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39669bcaadfso16877571fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780675179; x=1781279979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hPSWEkREGIx4yoYWkytVFmLCkNUDGfpLW+35vC71FY=;
        b=avmKjiGkMMBaYDJNq5OO4TdBUgv5AZJ25qKQVSvAc9a8BYWb/DKIGbPGEmYebFtHKy
         O69uHHiWwraVfz6HHSFCpA7LbqFUBH4aWLDbIV/9e0FBMYs9ZEc96ZAwcEbn7vK0Lp6X
         71Xp8Cw4NJW1QTTmDGhSrqqf1TVWhsWIvMoas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675179; x=1781279979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hPSWEkREGIx4yoYWkytVFmLCkNUDGfpLW+35vC71FY=;
        b=Cm1UyuhcDR2YbasyVwQ6fbo8NnYglypaVBMwMqTxdHWCSRNoidn7rfZZozLkkwWJw0
         QjEmUkCN35ICjnD34qHBOXcA78+LdXf96rnEd6toEGuq4cVEzV2/sGHupWkQ5+9pWvUB
         M4LYgtxYB4Ubwpc6GFO2oXLaJHXsxorpUZ1XaAxLak0WsubQaCsZfxgzoFRMuyp1FmTP
         lsYOjr7q++etnJhciPK1PIYWt1x7zmaAeob2UMss9WpwQa5lcXJH9zWJwEtj8jhmuZF+
         RrmWL4y5dTashI4PURRkCtLiKBdA7UjiPzotGpKexLgeSfB8BI0T+VfyrT2Xp/RLL12B
         gA1w==
X-Forwarded-Encrypted: i=1; AFNElJ/77hhCb0VOsT6XPVmwssByYMhzYI5lD17zz8NiiuRa6dg9I3k2HG7wuCNNdUcfbQFelsIC1Ickfw2YlvYO@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8ltJERAmSCotF1V8vVjcQar3B2EX9VZBw6uKYw4uw83wkd3a
	uQtVzUJzkkoBu+RA5a/qpzYgoxhn6T2svnkWa5ravUpf+mS9F+jdLBl0EsG2YsP614Jzy/9cZ/C
	WHC0J+TYXCA==
X-Gm-Gg: Acq92OH+nSx+P/ahprx0i7zarlGAoKAVJ55W4B96WXzRinMIrRuOzRycOz/CbAynHB0
	M0zfOAF8M/VCLQe56u7xDjDN067ZcpZ2qe7sADcvlDYBGFj4WwpfEYWi2yJz/hQffN8/UA2BEwH
	BjoklokFojmtxK9loB0s3pItFtCq+JZU42IgJxN03bwBKkP8XlaBdhR1emD239ItZKo8mEbuWiw
	ANUaIwjPaNoyvWiW3NkcAa/YOHGSHaJRdQ9UgivahefNhbr5wXh0n8q5v8xs6VvBlgZvK+Z1yNi
	95550WfT8fJ3lz5FlrW39WzS/aFZRioxOiqS0fZYHn68r8m/fZj5cfzSUNRiV2StbjJjXzR4JUi
	hd3Vx4IwQ6Oi6q0bzg1MfwU6ZVerJDyaKbRbYidV7aCK1Dhi2tZiMlAgHUcN3ipLMoSJCpox0ki
	5KiRmZGpXHyYf6872uRDeltQe4VT/nZC3KGBtvjknCdA37DRB6qynZubjPwhubtyMXsjScpHUbX
	fvro8K6Pw4=
X-Received: by 2002:a05:6512:a93:b0:5a4:496:5bac with SMTP id 2adb3069b0e04-5aa87bd5171mr1280079e87.36.1780675179078;
        Fri, 05 Jun 2026 08:59:39 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b99c11csm1915003e87.78.2026.06.05.08.59.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:59:38 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa6863327fso1869361e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 08:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ95ffxNC+WecN8zYhwlB+aTvaJK33rWqppcqA/nv9E05dyneNg+sCgv+mgOGNzneV+6f/qFRQ9G/TFKbPb8@vger.kernel.org
X-Received: by 2002:a17:907:741:b0:bef:d760:93ea with SMTP id
 a640c23a62f3a-bf37234c965mr227182666b.30.1780674864895; Fri, 05 Jun 2026
 08:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
 <20260604183829.63c35fd9@pumpkin> <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
 <20260604223216.73468830@pumpkin> <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
 <87se71jps4.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87se71jps4.fsf@oldenburg.str.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 08:54:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
X-Gm-Features: AVVi8CdvqDsmiM-EYrTUflKR5aYKg4JuQO6h_hoIzVtXJtUhEM3tfPOlti75Shw
Message-ID: <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Florian Weimer <fweimer@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Askar Safin <safinaskar@gmail.com>, metze@samba.org, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 02:33, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Linus Torvalds:
>
> > x86 really doesn't *care*. If the caller zero-extends or leaves high
> > bits set randomly, according to the x86 ABI that's perfectly fine: the
> > callee will only care about the low 32 bits. So the high bits are
> > simply not relevant for the ABI.
>
> Please note that Clang does not implement the x86-64 ABI and requires
> zero extension.  We see increasing problems from that, now that we have
> more C code calling Rust code.

Uhhuh. But that is only specific to 'bool', right?

If it were to have the same issue that powerpc(*) had - that 'unsigned
int' has to be passed to functions with well-defined high bits - that
would be bad.

And I'm pretty sure that clang doesn't do that.

Anyway, for the kernel, this shouldn't be an issue simply because we
typically avoid 'bool' in arguments or structures that are exposed to
outside.

(I say 'typically' because I'm sure it happens in some broken UAPI
thing anyway).

                  Linus

(*) I may mis-remember. Maybe it was s390, not powerpc. The s390
compat layer independently had a similar issue wrt pointers, where bit
31 had to be cleared. s390 dropped the 31-bit code entirely fairly
recently, but it caused some "interesting" code in the already
disgusting syscall argument handling wrapper macros.
