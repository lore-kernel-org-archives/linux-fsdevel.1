Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AAE372B37
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703176; cv=none; b=IkL5ix+QJPM/fjgGMpnXsq6PkRWxshZedEKpSC/2UG7+L5b9ltZ5d7Ua783BSq1KLMCpock7lmNWNh8xbFYbFliicqt5FydZ4I4erSEWVL8BwuWQAE4Uw4a+2okDXr8NMLevchEP8l3dxKfouWztxsxnHca5JDzmLnX2O/Zz2hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703176; c=relaxed/simple;
	bh=jOUZUx95LvrmEW0OcCljpXucgFDRGr4c4nbnmNCdqYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NO6jsc2mDuGFey5bo1VC0RvzcdEkFU6ZDh6XODeS5Eec6sg3LDoc0GUgVICGKVRj2HgSK1UbxhAo2ff0FrhsykaM29LH2HYFBY5bY8iar8AHrDw1oMHT4OlP0F5LeMfXvzfQLFjbvzQqiczxU5qXyiLp3u3UEpZtISnlSmenczQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSMs7/nF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSMs7/nF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so59989455e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773703173; x=1774307973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QlT1+cD5mH+crxcqsXp9NhmJtTE6cI+0w6HT55leUk=;
        b=XSMs7/nFUZv+2elh4izPL2FoCnAvM+LLU0BPV4y/2M7KC6mGVfSEvqlKZmSMwj+5g0
         bVDzesgQMnghXTEGD8pGVFYFlzNCU9h4CdPwrEj/xbLMcaVAb0RNY9s5xYjNJcIJ22qj
         rCWal1mPNUc8/o5uqIf3b0Y+fnL27d5sXdaAisYIhoRvT47VT32xdbXhHFllCgOPmV+W
         3HEtOsjfE7UEBqDhqA8IjHUp9n87INNerA+Acx7Ntgao321a11Bci8MzorDNsY1S88Q5
         1WRakiLw0B9AWvZt8QFCYkAEI7o0mE0mK3wF1oUOW1BVk6XV++iG2XVFLia23VcZmN9L
         Z4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703173; x=1774307973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0QlT1+cD5mH+crxcqsXp9NhmJtTE6cI+0w6HT55leUk=;
        b=IdkVVcm5keY8d4hfHGZkxduO+aqecmnRvJih719OHCpj4QHdzGfxEb5Hx6egga5lWN
         5VjgGCnr+KGYF+qh0Elz+hmhLYAfhuKRD8whFB2gLz2Yh0Ysc9+3s9CItsToyYTRVtck
         1u5kNgjh21bucsctMB8qPwkN+NL8A9HEplJ+21FmMUxPtyXa99I+FEiLanzbvhDHpt/v
         BVZkXiecqZAzZ5tKiofo8bUH7kwZqNkxlRYdAKR17cvN0EP1UvkMJ5yRV5rvA/bv9+nr
         kCBfXDmnHh9hGCnC5riI6TXiDfq8sLKauJlhSJk0fDGYhxz16HrK7lYuAQDQx42ZsZbG
         HBSw==
X-Forwarded-Encrypted: i=1; AJvYcCWzcNUZw5jpQLgcffuANiThx5QLUw1UEbpGEc76lqlAPAVq/5cCMUMOKAKvgYMI3qwLEmWu8WQZjTBaVAjO@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAS7ndewg6KFo6RNi/rbSuvHLlkslQ/FisWEfIySXW93cEKNN
	lNP0hgqdUQ0JLlis4C2TH+udQaRbsdKtm9tfoMfH+luGboRns1mq+eSY
X-Gm-Gg: ATEYQzyLH3tFitPC44qn64DhoK2kzzYAAc+B7DjJ7TfXyWMIpotPvN8E77aPUjvIauB
	qyyguP/5mNaAICp1PrL9J0CKcyxlE20n5XM4Qlyq9xxmomokllrF3XFDzkToQ2aN0T3CltQ+wmh
	5qNjmoMKS6bbOz5O+uXKsr6bJd2nvOv3cK2GE/hs7jl+/Ppmaxl79KeZDobs0IdFnJl1wCsaw5G
	xg0RBt+YfUXQEEhIJvAaBFdGnV7g2XtpGz0deR6ixMCOO0MJWiMLrF5yzwCz1ZPkeGAp7WpUP6Y
	N3VZiBvOHecKuw0gS2z2x2ZN27579VNpVRzqAk8fkeSdz7TU24iNZ8pRAvKUrMV2DxVvTV105RB
	OzYZx7B5Wai+JXR8PEKXFzOyuFL0sCLyhYWtTZ/+s/6CgFSgfrpm9uVBch7+zt5FXdeuQK/grtt
	ASRlxDeD9UwrT7Q35x+ZdAdB77ed70ZcL8kMXmoj3flPGoSxasUykeGXgYbZvKIKMz
X-Received: by 2002:a05:600c:8b45:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-485566cf8abmr257444255e9.4.1773703172772;
        Mon, 16 Mar 2026 16:19:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8e3cdsm26131835e9.2.2026.03.16.16.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:19:32 -0700 (PDT)
Date: Mon, 16 Mar 2026 23:19:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: Replace user_access_{begin/end} by scoped user
 access
Message-ID: <20260316231930.288e9bf4@pumpkin>
In-Reply-To: <CAHk-=whFS7D1M4=cMi9cR06Uoxr1QeM8HUtRB6V3cQth=QNoXg@mail.gmail.com>
References: <23f19c88e763beb852a4891b2a908890bdd01b66.1773651096.git.chleroy@kernel.org>
	<CAHk-=whFS7D1M4=cMi9cR06Uoxr1QeM8HUtRB6V3cQth=QNoXg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 10:12:23 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 16 Mar 2026 at 01:53, Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> > -       if (!user_write_access_begin(dirent,
> > -                       (unsigned long)(dirent->d_name + namlen + 1) -
> > -                               (unsigned long)dirent))
> > -               goto efault;  
> 
> This was already pretty unreadable (my bad), but..
> 
> > +       scoped_user_write_access_size(dirent, (unsigned long)(dirent->d_name + namlen + 1) -
> > +                                             (unsigned long)dirent, efault) {  
> 
> .. in my opinion, this is even worse. It's a 90+ character long line
> (or something), *and* it continues on the next line.
> 
> Yes, yes, the old code was disgusting too, but when changing it for
> something that is supposed to be easier to read, please let's make it
> *really* easier to read.
> 
> (And yes, there's another case of this same pattern a bit later).
> 
> Adding a helper inline function like dirent_size() might do it. And I
> think it might as well be cleaned up while at it, and make it be
> something like
> 
>     static inline size_t dirent_size(int namelen)
>     {
>         return offsetof(struct linux_dirent, d_name) + namelen + 1;
>     }

That definition would fit one one line (possibly as a continuation line).

> [ Making things doubly sad, the size shouldn't even be *used* in sane
> situations, because the user access validity is often checked by only
> checking the beginning,
> 
>   The x86-64 __access_ok() does actually do that optimization, but
> only if we can statically see that the thing is smaller than one page,
> which in this case it can't, because while namelen is range checked,
> it is allowed to be up to PATH_MAX in size, so even if the compiler
> does do the full value range analysis, we'd need to relax that
> __access_ok() check a bit more ]

Except is doesn't matter for x86-64 because this is the 'masked' case
where the accesses are required to be 'reasonably sequential'.

Although requiring a guard page on all architectures would make life
simpler overall.
I'm not even sure that some of the reasons that x86-64 has to have
a guard page (to stop speculative execution and system call return
to non-canonical addresses) don't have potential counterparts on x86-32
and other architectures. 

For x86-32 I believe that historically the user stack was right at the
top of the user address space (or the constant wouldn't be STACK_TOP).
So forcing a guard page would realign the stack.
But I've not got an x86-32 system setup (I've got plenty of hardware)
so see what actually happens or test any hacking.
I'm also not sure where the vdso ends up - I'd have thought it might
be right at the top?

	David

> 
> Hmm? Can you do at least that dirent_size() kind of cleanup?
> 
>               Linus

