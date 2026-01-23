Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E51DB34C
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769127622; cv=none; b=PZPuQXzSzFbYd56rJ/HV+U3IJvRIvHoH8Fn3ov5WSTKWx4Ii8Tbxcqlw3P/mMF+e0LzqAaacZbkee1NjUhxS7MmGNAUaOXJwlyCTkk4eOAkSO3u2jG0R876dawCKKKpp3DpVprZap+Ii5u0p4NdBrAvFzdr6ziTay1hesllse9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769127622; c=relaxed/simple;
	bh=Vgc0+2ion6I1bbCK86hsPCak9Y2mSO1PbyZCPiu+cRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufW8Vvyxq1HOYruDZsK0j+4rT0eKQK6b4nvBpm4d2u/SgIBRT8REEr5XnVa664539uK2LrX7YpK/3A8LH3VXArJ3yJdXZoyBFxmsLNhPCiC+FSqFeYSCi7qRShUimLIrT9R4iYOR1BBcom3Q8eVH0PvN9uvcl86+EMGOPBVo8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LJzsOWTK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LJzsOWTK"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b885e8c679bso36146366b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 16:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769127614; x=1769732414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=APrUMeUPvbE+eGvFMIBZPlCHZPeWZcSaQIf/bjVNxDo=;
        b=LJzsOWTKeKd4Dv6OX4XcUcb6oyaTjtCq2Yl6QwKKqbTNFft6oK/DTRn2L/H0RhTGDi
         +rgqpj/Cigs9HjQm3zYq41d172ssU9GNzrSim9vbg5i/jJytzyFHNOd0u2r5/+WoCM1Z
         3CR1gxf6nWRg16BqVdItGRaoGB+81AGgUB+U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769127614; x=1769732414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APrUMeUPvbE+eGvFMIBZPlCHZPeWZcSaQIf/bjVNxDo=;
        b=IjJ8OVNpt/4h6CpvaF31g0EU8NndgfPqCYjSrYcElEGk0ezFav5RsMO+/CFXLdVWKT
         dixfji1nnpbQJxLqXvwKq1WghZSQjGiGNuIfOCaFbjIdw5eH6CZWuIqpaGJYs2a/RWPs
         S5iboJ5eKEc71b3IVFOMpN/AQx4Hb83HcVTo1n4lVm9t+TVc0/CobStzTUKzKL7Ko/uM
         COBr+8KvUCimlwswIeknRTgzFi/fK0KlpyEQLlp3bAfAZOa2Ncj29htJUJik1nuXm70v
         xET4lmtfFbY9hmq4tUVNI46b/zLllHsVq1A4RF1SwH1bBeApZibMpjXUf0RwkhKQLuMg
         kiNQ==
X-Gm-Message-State: AOJu0YwZip1sMPWeM/6vpmgRDWXymUq1pcZRT4NqDlLXAWpxYK/RVJxb
	ppjUPdq2MP72A2Nepc9n66d9VjidPXPiOXOI+CPFtPSqeGafnC6tAWKA8wPhfec1W++OrXMoiOp
	Tmy3aNuk=
X-Gm-Gg: AZuq6aJl4nIek+3LO0viygixrqO+Uqmd+xvG4OLKrsbK/Ck0WtwpsZcrxM8O9gir0uY
	86ejIClPwqkS0Q84NwGALX+G4h2qkM3qvHaDFm0jdCjot/jfP7H2qeeNrHkQK+RD9vUrJvR/jhL
	JkLUKQo4ZUisIzK4sBm4bPJESzGoLBowUjlNz+lzEhN1/E2Px0w0aRoGQ6thBtBMojTPUPTwKq+
	JHKNKjc7cp8AxBlxVjmiFxe4aDcefLkiIk4VRQgQjlUI4ONgyPsyok1pN82TZc2hRrPDQQPpJoh
	6Dlvb32KhntnKP/Kd7V5roVqzkrS+L5uITdUzSjl0Gd1fCiOMV3j8wntwDNDlLlwL1ndQkuk1ow
	IH5ENGkqspw1DKBI2wrIn2NM0oF/3pKx3/hAyFrIOGWh3uqp10fbqcrqr5CbufS8hrR3KYJE0tA
	pVdM9Xi9i2viPIpUTKhuLFYL/k/DGNRMyTEz+N73swATiCVULtoOVcB1oZTNDJ
X-Received: by 2002:a17:906:fe04:b0:b88:47b4:7626 with SMTP id a640c23a62f3a-b885ac7d666mr70321066b.27.1769127613659;
        Thu, 22 Jan 2026 16:20:13 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b419288sm38475666b.20.2026.01.22.16.20.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 16:20:13 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so2227305a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 16:20:13 -0800 (PST)
X-Received: by 2002:a05:6402:2755:b0:653:e85b:76de with SMTP id
 4fb4d7f45d1cf-658487b7fe8mr794159a12.26.1769127613011; Thu, 22 Jan 2026
 16:20:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV>
In-Reply-To: <20260122202025.GG3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Jan 2026 16:19:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
X-Gm-Features: AZwV_QjI5V_BUbeIy90uzBTLORjzbdBBuZtoU1a_Em-cSfKW2YC4QJ1KD12jctE
Message-ID: <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
Subject: Re: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 12:18, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +static inline void d_add_waiter(struct dentry *dentry, struct select_data *p)
> +{
> +       struct select_data *v = (void *)dentry->d_u.d_alias.next;
> +       init_completion(&p->completion);
> +       p->next = v;
> +       dentry->d_u.d_alias.next = (void *)p;
> +}

I tend to not love it when I see new users of completions - I've seen
too many mis-uses - but this does seem to be a good use-case for them.

That said, I absolutely abhor your cast. Christ - that 'd_u' is
*already* a union, exactly because that thing gets used for different
things - just add a new union member, instead of mis-using an existing
union member that then requires you to cast the data to a different
form.

Yes, you had an explanation for why you used d_alias.next, but please
make that explanation be in the union itself, not in the commit
message of something that mis-uses the union. Please?

That way there's no need for a cast, and you can name that new union
member something that also clarifies things on a source level
("eviction_completion" or whatever).

Or am I missing something?

              Linus
