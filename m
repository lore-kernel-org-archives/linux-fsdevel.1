Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489648AE0D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594714; cv=none; b=qXlqxEINiWhsJQf8YGg6X7dv9UpvA9tRcmn+TNPVyUiYTm4ZxpsXXyaDcR817MVnqNymt1QMomT7GvUKP0YTkD9dEJ0N8MlcoAdl/HIwucmjAgLw0NV0YRXmgL2QbNZtofa/7aygUd7YBOSgezqulzta9GTQPl71GAOwLtMXKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594714; c=relaxed/simple;
	bh=v2KH0A+T/5unV0mAelk5zB+47zjGgz9MT7jM30vb1s0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWU9M70b7mEQBDT4xPiK/iHzHOdvscj+B9mYzLimHbWff5jxj1t7DMr6JrQTiTfoOFB1cAw2p65feNSdwn2etpCoW66rlqGC+HI4ibFmC3vQXJ5u9rE/gdz+xH+RH2Ua/2hiXoZNsYHmbbNVRfwuic5K6O/7JNy1xK5gdmfkg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhkiLgO0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhkiLgO0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so11579985e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780594711; x=1781199511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDxRgk4KLva6cv7jp07s/JuZGm0Suw+6/YbYX6FRPfQ=;
        b=jhkiLgO02xJY3jbGkLqf6yEze1IG/Ox2jCJZ1yITJxLGtM9U5+0C/k10tCut54S7kg
         CsAVN3snOFl9+cvyUyIBHJ8hDzhqYT3BOWKrygE95ThTXkwdNctJq9RjXSbVzN30eJ8o
         dHEB170KdTBrrqCpS1ehtBEXFNsGBvlFKB9RF6iU07j1Rwv/wvmygCq2COzvErF/p5Br
         mx6Sqt3WLy3dfZ7T61M+uMici202aefJ8L8GLQtOJHoTBem3cAWNWIvlDRwmKtlFP+2A
         0U5Zfi75t3LFjnLBh0BeDqWKOygVVWoQo8UGHWy6rg7/oXkTm2E+QN5eJqrjJ0Ep58Nl
         39WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594711; x=1781199511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDxRgk4KLva6cv7jp07s/JuZGm0Suw+6/YbYX6FRPfQ=;
        b=JxEweEdoIsKujVJswzetm59LwMkzMfxvb8CrTY6fz495VFKC70D0JeEdfcSLRHdTrN
         BjSKU1Y4UVyO2hB9GqgZn0ydb+xg2ybkInjV7leiGjmDBHdhJ66Jz27DvgAQEKX5KH3R
         HUQpLa7fwWSglXftbyF4ptZ5YqldwWwfgFuEE6sM/lgwUM7VRwjJB2x4dtgpghlTHYi3
         m49vScE2WiimpCI8i7fO3MjlOU0VSwbmTak3Rvz02vvYAu8TxQIIzOoC0JQd3BUoIBuX
         t5JU4cXf1XfjgRA6yNPm0TPo/adgWnKSCDraPAT3fPpotMKR0581QUxhyZ6sjCQ8345m
         rl+A==
X-Forwarded-Encrypted: i=1; AFNElJ/7Z5B2GWxSjc3RdiOr98cVQmXU4XxgjnRIv4fayxaroto+mKRwIxoOUb8M7zxcd3gKtKNQvqn3O0tnM7BA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25BaLYQQcvS/TiqLhzpsZa9SVAL7OhGtnx16k/D4ebQKC2T3u
	mRQwI3ThWfgxTm62jmMzHvyyjXj5++qstRTY4VDK2vm7oOG3VXTvGzgz
X-Gm-Gg: Acq92OE7CV0I7mEFFbXMiO+vP7CFi5JluhnP329StUgYf6GT6MVu+eW7/H8SHvHcTA4
	O3oCvpnaeNrPwg5ZJUCbnp0Eo0jC3FBCZM0Off3FMZDmNn3eYjsm+zi4FRoiGM4MTg63Zc6noZ6
	s/GwUpvNFRhCNuRju7z/xiqdGy2kBaRaKuc5n8EbGMinQilr2hWBNxjCvBaB9gSgiJDUIOSasUt
	gzTsi9Vh3Dyvtmrl7gpf4TCfQrZtv5NSEyG3BcCq489sHwXOgIlkYeRlNZUxJJgGlnlEROxRBCD
	o6/PROQ4LpONJ3AirBtjR1nzxepn15yd8R354HBw6XmZ4UZPbHr4LqAPkH1qKAUFylnNDhxewYb
	NlMZ7w02XnMmm2t9QGuDMb4++4RacO0YPOZ3AWWA1NpeqOl04Y2MYBVO480lFWfXiM4KZHjmOLX
	buviQHmXZSucPrfpoe+WYyKe+HeMLnZTm1yaD35WY7cbCYRJv3IwKzMgkIyOTR88UkXMsUYVQ=
X-Received: by 2002:a05:600c:1c13:b0:490:b642:ce29 with SMTP id 5b1f17b1804b1-490b642cea1mr153777325e9.8.1780594710934;
        Thu, 04 Jun 2026 10:38:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm105657875e9.9.2026.06.04.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:38:30 -0700 (PDT)
Date: Thu, 4 Jun 2026 18:38:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org,
 akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
 david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260604183829.63c35fd9@pumpkin>
In-Reply-To: <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 07:17:10 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 4 Jun 2026 at 02:06, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Something needs to ensure that the high 32bits of the fd get masked off
> > on 64bit systems.  
> 
> That something already exists: CLASS(fd, f)(fd);
> 
> It ignores the top bits, because 'fdget()' takes an 'unsigned int'.
> 
> We have been a bit random in how we declare the system calls in
> general, and we mix 'unsigned int' and 'int' and 'unsigned long'
> pretty much randomly when it comes to file descriptor arguments to
> system calls.
> 
> fs/read_write.c in particular uses all three cases with no real logic to it all:
> 
>   SYSCALL_DEFINE3(lseek, unsigned int, fd, ..
>   SYSCALL_DEFINE3(readv, unsigned long, fd, ..
>   SYSCALL_DEFINE4(sendfile, int, out_fd, ..
> 
> but then anything that uses fdget() (through one of the helper classes
> or not) will simply not care.
> 
> Does it make sense? Is it pretty? Nope. Does it matter? Also nope.

I know it has mattered elsewhere, and is easy to get wrong because
'mostly it works'.

At least u32/u64 is reasonably sane - the called function has to ignore
the high bits (at least on x86).

Bool is another matter entirely, (IIRC from a couple of weeks ago)
gcc will assume that the low 8 bits of the parameter register are
either 0 or 1 and clang assumes that the low 32 bits are 0 or 1.
You can't even check with 'if ((u32)bool_param > 1) error()' because
the compiler 'knows' it can't be false.
It all dumps you down one of the UB 'rabbit holes'.

-- David

> 
>                   Linus

