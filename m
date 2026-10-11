Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2C363C43
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791710601; cv=pass; b=Va3nHNUbEZ+brRK95PUBDKwFW/H2MhikGqFU2ENm3oVE+ISQN6hY6BqViomaPIxWvgULlPzVwrbdXyu2upM+bCmh2VM7r4u3ydJ4685g928ZKZrGDph2GqyJuUuLnizwX6ECu9OX22ASYLJfrUqSZ9TZYtZ2yIjgsqqRnt9aaCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791710601; c=relaxed/simple;
	bh=cYQ50HopHsteNMAqeFteBt+xPXAUZSKtz95dPIh3ijs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpZW/TjObygAUWp8Lzj1q4mt3QzI8AabMH3CaoVI5Lhld46Mu1FM4ZTQPhkN/fqZQx7fdi2/A8WyzM/VQ2C1WjFTy8u6yMlLelDMVIQRGHQ2I2PkAoe+0mHH2Pi3E+mKezjKkFr+rTv3DtchM+wT8zSLEpdq10CEUW+sIlVk/jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltV//FNV; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltV//FNV"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso281369a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 02:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791710598; cv=none;
        d=google.com; s=arc-20260327;
        b=aw7ptkwODP3BVq3yU4lNU5CAXp/NBQYflnN278zgb5LvbzLK5F+yBbWqesEntmCRpo
         isAUbnoTGio/tdTOJog7IeReH+gzmZWkTOTZHLsvADZar4hQ+WSI9cC5yrLCGbN2tfrH
         mgYRzUYHuGKDQRMgYHLEICL8H/4U9Jr3wcUkvFDhqS+IE7z/58PI3hzTFdNx47udkG+9
         KtuNy3mvEz8WWArgOK9XFOQKBeQv3TMWZYPnhjZuVDAetTYXs996Iqyum8nNSrpgn4aX
         bsRbd+CTGgwdh6CZ2Nj7OOKHAGtDortilMGApt80zQbWxRnM+BQP37lGa9QrJv6o+l0I
         3+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=cYQ50HopHsteNMAqeFteBt+xPXAUZSKtz95dPIh3ijs=;
        fh=p6Yxj7KbRgZAQWC4TdHaRm2nq4kZT51UIT2b3xOqAO4=;
        b=sBsMVsiyZlH5apRADT6El0lfPH53KzWTcdk0fvO1ytzcG0Jatt9XcY/CKRZkFdSUCF
         BSeoz8IYU+z5FIZUtJdnKICxhQ2y00Q/HMKRk6JQXXpqlDY6k4Sc/sufS2OekGcBKS0y
         xnsawL2EdplsqWPqDeaeS6hWYWR3zCXp+BBvyXNVZ5ShqT5qqNld6HqnoZIdwzBr0XtP
         fhBU8ynGX6reZaUWgEZvIXY6hbYtBmFsXTYYnt1uLzJ6wF+2eWQ1OpCiVHFKY3xDmUND
         RR3uvANaMOqxcqvBqMnbrYOBYjSCiSu3E50HibRGEXqdZtCtAN8KJpUDgemsYtEbTaY2
         Gwww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791710598; x=1792315398; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cYQ50HopHsteNMAqeFteBt+xPXAUZSKtz95dPIh3ijs=;
        b=ltV//FNVQyU1cNv6MqdqMeMJ9+iHF2ot/EgetJ1PhYvP3botgAca8w8AQGSvvuGom7
         +Etq2j8IjAziLTNmgif8Kf2rckT3ISb3NmyyvyAMVmPydwPkZTc0WgzDWaBpnUI/OTW5
         7X/g1ES9YyXdCJxTJWw7sCFlmAHc88nE6txkyOqRzgM1E27N+PUpzjkt21jE/5vwBP/l
         TeFrGLICWnghHvwxUc8CJyONXMpSz4OQ2szrXBucOQKi9IvTjqek0g5OVIOyTuhuHMGJ
         Cd7CfWCd/W00crPJMXCyROzKsm5n2WjAPbRXeh1jHiEvSzD4RodxK3Sf5Ff5Z7Rn14GD
         0M4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791710598; x=1792315398;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cYQ50HopHsteNMAqeFteBt+xPXAUZSKtz95dPIh3ijs=;
        b=cqWIF5l1s/pds7+g7D0E8UbIa/4EgZNzZSNEiCLGnQGjFJpQ2DcfndgIfEMdrT3Hnp
         wp9YyufFH08Ng7ND2guhNfPBEJAXeKlWgGKs8AH9nxqoeBzULAfDIXfiH2Zp3h3ZqCmB
         zjMUiQ67UEuWakLUrFjkvIXEgVxiR0okw7FZjIKVdgTs8PGmC2FFOuEfItew27HOyA/c
         UE8UAe9uETrma0ui66qTHSCI+s2g2QVa113AxFMMa9DooZqvJC+RGMnP7M6F8n5cF6Mh
         PhCjBQrvRxkrrtUavfCfJAWgFScHgK0BJUIfGYmhJ9HoVXAjKiatXpCagUOWDdeWDNTP
         1ApA==
X-Forwarded-Encrypted: i=1; AKwUvBzgECMbq1RQ+z2LKjSuixBBeG/ZyA8Rn17fK6NJRWKKDxuiTPb0Jzxa3HhtXthanAv4jGUwa/BLHAvodaaX@vger.kernel.org
X-Gm-Message-State: AFq9FYKXmT2WrmqTDVFgeaah/LVrh4BlKiqDr2YosLj/q3XrK/c9SaS6
	3vjdy4lKCosqTNlNnskVw26OOoNCLIQyGfwYUuyyTrTunHwj02yyPW6mHbuuDLN4TJLfJR0dT/m
	1HlPJiK6BqEmnQ9sfWQrhkzxlyYoY6xWnnwmy
X-Gm-Gg: AYBFou2Jk3ivWYYfRl/LHLiGmF2d4AxjF/eyEIbw/1bWydU0JtBjjs/nYxjhmeLIgVe
	Ke0BlNU63Cvw5sXonWdN/50y8/gFkY5c3faJnECfHntFx4cIa1XtISAr/D7A8pwh61mnqKcu4iE
	HqVHj0wbb6Jtc42z9rSKvH7Bk154bFov/iueMI9EF2cwbDvaDni37U94kN754pJi3+MFdo7pwp7
	GvcRj5D1BT3xVUxug8EdJqNbfCe1I5yRrnkOeIBP0Bo1Avz33C6SZpsSazE8HS67A76x6z16Fv3
	OUZk7Sr3V277mNsGdt3p9DL3wQXRjOKgtSPV3snhUIDuQkdCniP8meri6Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6402:21cc:b0:6aa:e589:87d7 with SMTP id
 4fb4d7f45d1cf-6b17c1decf7mr5274283a12.6.1791710597818; Sun, 11 Oct 2026
 02:23:17 -0700 (PDT)
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 11 Oct 2026 09:23:17 +0000
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 11 Oct 2026 09:23:17 +0000
In-Reply-To: <CAFLp9PGgfLJtqeSaTqrG0jcFAu4stP0og4Txy=ewCw0ZxFdCMQ@mail.gmail.com>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>
 <anlByPDZmvEhWeXI@casper.infradead.org> <ffcij36vnozf3rginqd2opd2dwqyki7xhtdo4veuty734hhgba@utjav2k263o6>
 <nsd.1787001235.35928@mail.gmail.com> <w7vte4itudtkw2yf4vbmuofiumfffmp2y52dpu2bqvqtdgjvpd@5femyiozss3e>
 <CAFLp9PGkVYZcQT5qAx-RKFOF-urZ92m417zpAeF7ZQempbS1HQ@mail.gmail.com>
 <arEkgM15qewERAOJ@pedro-suse.tail5790ac.ts.net> <CAFLp9PGgfLJtqeSaTqrG0jcFAu4stP0og4Txy=ewCw0ZxFdCMQ@mail.gmail.com>
From: =?UTF-8?B?YXloYW4gYXlkxLFu?= <nsd.project.dev@gmail.com>
Date: Sun, 11 Oct 2026 09:23:17 +0000
X-Gm-Features: AclHuK-By11gbr9MaNoXIL2Mt8RpYeOZM3ccWee1GrqxzZ8ofTrOrPUSY7ZUhu8
Message-ID: <CAFLp9PE8hUCa7ia0tuewytGUacGL5azUeUSSf69a0PwhbmOW+g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache prefetcher
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Honza, Willy,

Just checking if the Sep 20 note got buried. No new numbers
from my side, same tree.

The two things I am unsure about:

1. Is the capped shape OK - ra_pages bounded, overhangs
trimmed/dropped and counted, only measured willneed up to
io_pages and that off by default (Mod A strict)?

2. Do you want the small ra_state bit (2 slots + stride,
read path only, all windows bounded) posted separately
for direction before I test it further?

Thanks,
Ayhan
Assisted-by: LLM (English draft help)
