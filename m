Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8438E120
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486614; cv=none; b=Hge+tQHuF0OAvtDlUlA+/peeCsYl+ADeJ/e/XYtWdbJOQYzAwG8aTqr6gEb68JtN9uLJknMj2oxdUx1oT9aYVzxargNKCR/mfUTh+rIR5ta9frlGsUDk6HZviGBNxNtMPUCRs1SysCBBUjWZB9gbeCBV7YiCOCI7EjtDsTWxE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486614; c=relaxed/simple;
	bh=lvZWB11ofjrwbUFjuuwrcrfWZAMQs+8xuKNooMMBuWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVJgoVjVy/UNEOO6UrH5cc2uSdrb3fgcJ7tfpoBTdHMiCyx3gR1NJi46y9hyYcn5vfTvNM2RxwAsbzsUsaGuxUXBYrm9YAO9wPP1598gkywNjqwzHQJ5s0QQpLfFX2/VqW71OfC2Go9m9topCzA/ICWnuxLu4S/uj7G19IVRS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GDiQvv4T; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GDiQvv4T"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-687e7edaafeso1108653a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779486611; x=1780091411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IK/LbqWxIpqrOMdgLASbTWPmmkxO6B4/99jlCNN7VsQ=;
        b=GDiQvv4TuByAM49Lvh5TLApexz/8Dpg2PFjhnKWlMZum6rrAZxQopYC6M1WR/xjpQU
         4F1YjpcpBhE9juCDfnF5Ep5XtmXx+GnOiQr1QI/efBdi71g7FLqCnW7e4B5Gc4xUyvK/
         7qEZiN7YhmWNlBlCTwZ6ZyIQswTGWEaKg6ffg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779486611; x=1780091411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK/LbqWxIpqrOMdgLASbTWPmmkxO6B4/99jlCNN7VsQ=;
        b=nNqRKYwqO7qt8qJf+fcyz/6mfNvvOCaJQ61VVKFAmOexDTxarZLAfgJmXATC6OLoiA
         BSPTl/51ePtloC5qH24weFbaeq0LGGAYd68j0LHMwAUt1iMkaoK26v+8CbSF5a76e33k
         8JNUiY12v7OhfuWR2Juyt4GMzhCYZFntF1h1o9DYDvio/w2ybm7xz+t0WVsXDeVARBsl
         R55i84+DvkRt+uuJD/BbohJ0TwDHhwCVmSQBZaYo9K6RIloyIys02s83TGtRRqGXqVkf
         8IQ04PTEgSgQROs5xJsjfIkE2a9Bs1ccuAj1r3YKx1Yx1vpRctrGj80Ne42yJ7nS4USB
         /Ojw==
X-Forwarded-Encrypted: i=1; AFNElJ+8eplmnukZ45hhq6s6ONUMN5oZRHqZzqffaWkkjdXXeBY0D05qeggciAnMqEOrk2ayvGxIWNjzItK+l6pw@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIHi1upf8rOYeHdyP9CsdYmx258UwfouhhFs585Ode26ehZUo
	opvNSVqD4vpeKEkJ1mbd0GEiJ7H3PrWlxdoSjsl/CvCKlX95o6u4/Vb16MSENhXZugbJv9jl2x9
	PL5RBI7Y=
X-Gm-Gg: Acq92OH03gfxwaBllZ4dvm/4DK/HmOGBpIczYNsYj31o7khnpintdvPJt53iVQhjsiK
	S9YGKGx0GABb57jtYhrXg8g9cKAu1bQwjDsEFdbSGllLe+HxywmyXpXlZUe1hDidfQ9Y7YRG7nQ
	NmYY16VTXE6H2ncBvL2aYO+YDOU0muMJLVuna0n7jRX9PigbVXQ1eKYs2a3woPSRDHelYdq9g6j
	ULgyc68f4a0NmQtDCR+sWPs07Q55mOAMPDm72f/E4neLEWRKWL+zGQMsHWAwzhBVmTti312oec3
	7PJ1nKcWfEKab4p7lIZyutKZ/vyzKEAdwcFBfbh9OD4hRJEAc1Ysee1swIIOWL2p89DoLo1YgGh
	wRELHHS5eCDdE5qTijGBz+P5DjmkCl/+DAIK6ZDPb3eaqWUzPxuMNGOTdqgOT4Su8LGewvbSCt5
	97vWNFWEEFTAnbu+TAI4QXb4nKLJDsqEB3/UFM1lnJfiA3XIBAszoYe2h54OLDmeh/nUlKmvJu
X-Received: by 2002:a17:907:a647:b0:bd5:d06:52a0 with SMTP id a640c23a62f3a-bdd278c9516mr369006666b.43.1779486610974;
        Fri, 22 May 2026 14:50:10 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5ed2d38sm94353766b.34.2026.05.22.14.50.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 14:50:10 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so1339842266b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 14:50:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Y5y/qvJQnjEM1wZHWXSmgVuJ+Ubi70LxaE/EvfA8ZF11F6LaeLCDw2/2KPf9MgygGnUvjvE7Y97igUTAw@vger.kernel.org
X-Received: by 2002:a17:907:928c:b0:bd9:a95f:961e with SMTP id
 a640c23a62f3a-bdd23df2e7cmr385157066b.3.1779486610031; Fri, 22 May 2026
 14:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-work-exit_mm-v1-1-bd32d5a560bb@kernel.org>
 <CAHk-=wgJRmdjDQExRP67GprmG7VLopuuaWMyZr4YNp2NvdNbKw@mail.gmail.com> <20260522-bezog-kupfer-gruppe-e2ba3adfa44a@brauner>
In-Reply-To: <20260522-bezog-kupfer-gruppe-e2ba3adfa44a@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 May 2026 14:49:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXphXLqC5GxT54M8pA16q43QWexDMLB2=CzwmU_QXB3g@mail.gmail.com>
X-Gm-Features: AVHnY4IC0enEsiRFdURtw_2VmgkH8vd2k8UXTsNWEjFZDiGZ7ypaDkMe6MNZnlc
Message-ID: <CAHk-=whXphXLqC5GxT54M8pA16q43QWexDMLB2=CzwmU_QXB3g@mail.gmail.com>
Subject: Re: [PATCH] exec: free the old mm outside the exec locks
To: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 14:10, Christian Brauner <brauner@kernel.org> wrote:
>
> Moving it to free_bprm() has the consequence that we pin it across a
> whole bunch of work. For example, for binfmt_elf:
>
> * setup_arg_pages()
> * mmaping the elf image
> * the whole elf table setup

Fair enough, I guess releasing early might be worth it just to not
keep memory around.

          Linus
