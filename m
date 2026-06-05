Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D7247291
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679548; cv=none; b=mzjPkHL2Sh3vE/fsQH2gFKFouGX+JUYO7Vbhq6eU9YzOErUwFY3hcVXytvS1Tfp4JIim/PHvScShR1PXzpRPWxS6QyOaOzM/DQDw4S6fifY2CGcFleCb+lW8zdLhCpqNE6ui4CKqHPFrGfcyv6jqIPe2FT1fpvIS/o4ldsT1A2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679548; c=relaxed/simple;
	bh=cx8Rkcij++nIhZcQtMX+8UhBOPSebFuHtinR8U8Auj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I68Y+wYqGd3jB2Pav7bzVrks8t2koriBXgGGvtU/RMvtI7WkuxiSqMJcW35Ftg291GWTMlvU4/8DpN7J/o2yHnhTODuKBPlrzHfaY+zhIhwTJUk0p/wS+aZdHWKNVbpf4V+giGNs2jI0rEmWg8jdr0Huww5J9q0a1nnLkEnPX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bb/55bTI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bb/55bTI"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bdb3fd39045so276465366b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780679545; x=1781284345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbDn0l7MCqGrATagRYR/CBho/Q+7UgNMgo5uDntFVrI=;
        b=bb/55bTIPKsJozqnOH6rSU3zRQGSsFJL9ZSzogsCiEyiXIiR3HqMdNQTWrNu4lOTns
         Q5+sVFJK6wzkLZrxvsZU+3ZXUXGMeOs+gT4qOdDH1z93iNtJ6YlaDhtr3KW8DgXLhiM6
         SjklRI7ucRPuwCgwKhDFA5f2N8vjqCbgiNDaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679545; x=1781284345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbDn0l7MCqGrATagRYR/CBho/Q+7UgNMgo5uDntFVrI=;
        b=Fzqn8e3kagZ1cWEAGRqplzUDwx9vnFxyBvZAEIcu6Wys79lEdgz4XWd4OBiLm5QDLQ
         hR3Nur1ejXPNz/tc5bGX5aSt50+UZr04bLiWGnhum7ELvQ+5EXza8acuSDjdZm5u0H7p
         vqU5LNY3hetA6bwoR3Af10jsELC4SSTWWv4VHDbnHg/U5aeM1X0CnBK/y0DD8pLqRwQC
         UlBCH4Au+deXty6BRAGlEwxqjxhYu51xqrahp7BgCqB13MHxtlS76YQl7hYCcIfomD3R
         xlCxorybn1jelCHS586Xvf6a2Wmex+3vm2Uf03NDCx088ntqkxSWV+txM09RhelMutbu
         TZpA==
X-Forwarded-Encrypted: i=1; AFNElJ+qw3kQKE/eaUtex3KOSk/Em80pQ+2IJH4NF0L/k9tbCjAh73VF4p016G0UflLd74WR9xwAiPTuV035WPxD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/IwBN1Osl9f3opcnXcPfGVPg14CSbOu8mXB5dkK84Hn6imYv
	/pY5aU0749ZqZRw2b/SQtKJ5NDWv0W7bnlnQ1X95u1seyf8zWiQq/HA9JPXQCaF9FG4CQyJmUar
	g1k4qivDY2A==
X-Gm-Gg: Acq92OGPXXwsWQA87yd4ps/smtKQRmmwlB55z3vTqbF+yjjoJRcxEKBlLy5lzGav2q3
	MmKTm/U73F88xxnhUa+KGesbGJtHd42QlFi+D+N75GU2+C9CV6iNgIOLbTF5/cOFH57fq4x6JC0
	nSAJwyMUHKfpCtrflbLhHjM1tzqim/lqcMjZ0el+OJivGbsf2e1ep1YvwOq/j8fSXCWOAQMBsq3
	mLPxZcIN28jeR+xvDFDsTDBvoi2/YEF0geko0ENdNjZiw7fbM4NCzsCX0WaibWiOJMOCQDezpmL
	WoyHpQ16XZ+gyY4NC5ncqoTQelhyJaPkdyNrLUeZEuW86lp9nKmMq5ltYpkXhfutfjvn18Hvg6g
	dXPstoyTw7cbUyzFiAm8DgmRqHY0z3Z+0+JyEs3SDoK3W/Ra4hXvzfZB8AZ6Ov1L3NQnflIsb5v
	PAD8tfuTWQu/1YBk9Q+wjKGqmJo3LYpkiW01tjyleiIDTwh+Xayfjlk/TtXQ5ZN59ZBNlHejBbC
	FExuPn+RKk=
X-Received: by 2002:a17:906:9c96:b0:bec:de7b:163c with SMTP id a640c23a62f3a-bf3729333c5mr227099666b.35.1780679545083;
        Fri, 05 Jun 2026 10:12:25 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051770994sm494084366b.13.2026.06.05.10.12.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 10:12:24 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bebc80100efso240959966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 10:12:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+EMFXKI0/yiBH31OHSPKIHOwf9uwZKN8eOgOpIPQP6cTiRcW/OOplpAZMNKtvgUZ8rZd+dox6b98J4e1Uw@vger.kernel.org
X-Received: by 2002:a17:907:2d92:b0:bf0:59a2:4ccc with SMTP id
 a640c23a62f3a-bf36fd9bc68mr283989066b.3.1780679543586; Fri, 05 Jun 2026
 10:12:23 -0700 (PDT)
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
 <87se71jps4.fsf@oldenburg.str.redhat.com> <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
 <87wlwdhrvr.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wlwdhrvr.fsf@oldenburg.str.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 10:12:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
X-Gm-Features: AVVi8CckZsnJXSGEqzilnfJFExIfoQ08Dq0LHvA2PxDFlkolpXQtrHtyU3UQHDE
Message-ID: <CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
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

On Fri, 5 Jun 2026 at 09:30, Florian Weimer <fweimer@redhat.com> wrote:
>
> > Uhhuh. But that is only specific to 'bool', right?
>
> Also char and short.

That sounds like a complete ABI violation as far as I can tell.

Scary. Because I would not be surprised if we have code that assumes otherwise.

Now, the kernel *seldom* uses char/short types, and since compilers
are typically at least self-consistent in those cases and we don't
interact directly with untrusted sources.

The system call interface is special, but we wrap that for other
reasons so deeply these days that we'd not be impacted.

But we also do have various assembler code, and I certainly wasn't
aware that apparently compilers have been walking away from the old
ABI rules.

I did find assembler code that clearly uses just 8-bit register
accesses and function calls, but it was all _entirely_ within
assembler. The low-level debug printing in

    arch/x86/kernel/relocate_kernel_64.S

puts the character values in %al and then calls pr_char_8250() or
pr_char_8250_mmio32() with it, but that is *all* in asm code.

I didn't find anything obvious that calls C code with that kind of
argument though (which makes sense - we typically call the other way:
C code calling into asm code, not the other way around).

So at a guess we're fine, but it's still somewhat unsettling.

And maybe others were aware of this, and it's just me that has old
32-bit x86 code in mind.

              Linus
