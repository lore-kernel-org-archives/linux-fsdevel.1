Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3792260580
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776533056; cv=pass; b=A3VRTkp1aNvmF7GKIyqTky0w6o6c3H31xRkasntdq/hWWj45BByJ992g0ZzM+QPjyHt6HzLjQhFLLf8Qt3UNy08Cj/CqpoXURsMCFgjKHUJprQoGv84U8j53BkhSrJqcztBeTieV//MFHsy/PWLjFeuqRe+Oa+LQUl3JzK4kAHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776533056; c=relaxed/simple;
	bh=j1dJaER/AevBUpdXY/F22Yx1qs77T3kaMjFTdoHufrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QReqqNluOh26KUQKfvQt8wmjXyCvcGnW4iUNh3Oox8yIWDHWgxmAxOUsQRdDOB+W/cdWb34QcS37mFpboxUjZnPTE5Pozic54d/317NQaqRJZm+xO1WcmN7dj5DUbOmj5hDMbpcjW7x4O0sz6OAfhqtDf5JyRNdT0CXEGYMnUeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhOVFR+d; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhOVFR+d"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66f8f556f39so2208249a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 10:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776533053; cv=none;
        d=google.com; s=arc-20240605;
        b=AOuMwbJlY/UFby5g/XaLQCuOWO99m/9H3AjPsy/lDwFYFhjHjMP3J8hhooVuUuCENW
         qpFmyH5BFPlhtoC8X7JGvBlLoa/SjvF+iNJc2EYw6MTNjHjd0RFRjjLrOmSkiLcSLx3x
         1ypyWi5Oty+QFEbviRK0DL1VQZSbSb4S+T0kMkYjaQY0U8Yvk1HiPJ0WjNjAOW2XgPYy
         Cf50gfgsSjRtKhlDqDptMSUPoO+7D5F1NfQrXJ3Udt+vntn6lKYZKydn41Tpu7NoaZvn
         lPtyBnOtAe6AWonLl9qkr8YjGbg6OMhiagKKfvktbAuoUk7lsvMyaNF1M/q49SDoCCj5
         wFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9AaJA6jZ/ERYEEgMQdL3A7cOGNAsUs+41pJjWBO6lA=;
        fh=Hzu8EcoHLDGviw4EjPF5+T8N4mFkmHcbtZ88I6D7OZA=;
        b=ZgCVW9gUVX5PbTg9kyT8jvhfeikKpcz6oYdDYECMg7ZF+d6qNJa9tbM0+2ry8MJ2+g
         PCVW/mSDqWZwPS1WisJExFirml9DIXxbCxLjR9/xvPYs2QsIp3MjIHIm69/LRvHFh2eU
         x6/0JLwuD528EC3n5zJzHiTbJNSydaTGo7qvy7pQFOJCJZfL47n0gsOHLa6BlNOgX0K9
         XjRIDdNFoNYps7RXQ5MVW7+/BfI8uqAQAHCY/3TdzrfaAL2Il38B2VpKs7MvJdZrm4DX
         hU9fVCt7DCWFwDx2/DeJvqoU9qCO6Tdsg1mFQGRsqehERK/lcBbPdzqvRKzwsxAeu+Q2
         L1Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776533053; x=1777137853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9AaJA6jZ/ERYEEgMQdL3A7cOGNAsUs+41pJjWBO6lA=;
        b=jhOVFR+dEieWtpvrQyFexy773HDK1CqADggP39xvk/SL6vU3i1qkAO6EGTSxi9fjRG
         virOfAV8/8bhkOIgwM4jk9SU/1tCDEUWTp/4mgbwbCWihm/KpmC19Dorp44wADEDsdlL
         SMrwhijXzZKdHAuQ4/2Z2IGtuykWqnSGOaE7HqrV5ZxIYU71oS1Sp0LpRYBGJjMykDjV
         8EhkeJVxoc9bl6egtUxIzYe6ofuJT47UQqDe6owfQhzD2JyYtpzccUfyX6LeHWvWpZOA
         5xrY445RH/0RQkEjADNGmHge5EwrWXrRh6X0Gtume8mmxMSFenrSgOJ77c7SCeUHAmN3
         H/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776533053; x=1777137853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9AaJA6jZ/ERYEEgMQdL3A7cOGNAsUs+41pJjWBO6lA=;
        b=afsyxFJE2o4Ud4sp6nOyeK/eMZEghlVc5QQQJrlclg7JOHHFo07TZe9WeRM4cKDGXC
         GzH5/cDl6Ol8msWY08gWxXS1iRl3I++1DQZgR1lIFANnVODMQvNv2dT9MtEHF0tuCcxz
         6ayxg4MH9HraXoYUs5GWN5LlfUl0zknERbRiBQWv+2e/uji6ZJ5iEmxmf5bRQ/+UTl0u
         KCdsjO0X1Zs7gBGK0/s7TeajVJl+wrW0pgxhlof/snEaX2Lb7lmJeNa4ov3rmegd1ddg
         3o1AE5g9P357P7sVf/jE+/42ABhtz1pD3+fc3Gcwsh7rVy99rlWAzK9liSWwqO7Mfpsr
         wGAw==
X-Forwarded-Encrypted: i=1; AFNElJ9yidxQZX1pGgUCiJsz5WfuECkKyXyW2NVjssmOelv5raaIjQAzDExCUnCv7OEvnpvYeQ2ICCxA4RlNqZdf@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxwlys3HxJL9de6WlYQCV8u5e1eRv0LZbSqYI01mFm1aBeimO
	GmQumxv/nUdxTiM0aBf5yPlJqz4g4nYUgNJ8iACL0Fd7U/nz6zm7soKYenmsUrexElkAGmjiV/z
	qUl5oZlZkKLMjKuDo22EC2wbOK7RYAq5bnhsydTs=
X-Gm-Gg: AeBDiessaGGvOft3P1DBeRAOFZchKD4PfHQMoD7dkX5/1FNWHegcjNc4u0j21zRpEnP
	FCrdWC6QuE3ACkkLlbyuVn5SrInDY+DaYPmF0nbG3Q5O6RU4yOneWY/OjDH0CCih5cdSlcgPNci
	HIFC+wF5JQxYanawzlIbja9oXpfa69HRzXpscf9FX49PxTuPN9zN8LLAUV4fBXnGXarwRgdnG11
	aoiyAK7pK9flSpdQxD5oKA0PH8X3IYdngLtguHJFpW9yOgVG6BYNb6dFjS/brTAqKvYdSkBCqco
	daBbB1zX+BxLWjssCwC+DhP6Am9GhZ2cGOZK+mMM52v3gzIY
X-Received: by 2002:a17:907:928e:b0:ba1:1181:b773 with SMTP id
 a640c23a62f3a-ba418981ae1mr426417566b.10.1776533052988; Sat, 18 Apr 2026
 10:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <aeJTecsykkHMSvNh@casper.infradead.org>
 <aeJr8Wq3qmpGk6m9@google.com>
In-Reply-To: <aeJr8Wq3qmpGk6m9@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 18 Apr 2026 19:24:01 +0200
X-Gm-Features: AQROBzAhZdlraxJlTHiL3xoVS9sd0ckTXQvisGkK74DV3s-KChV-UBKX8rmZHMQ
Message-ID: <CAOQ4uxhG0wgTAfn-XQz2Kkosh=upeE4x5r_PuYmc_H2X9snogQ@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 7:20=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 04/17, Matthew Wilcox wrote:
> >
...
> > I kind of want a section on "no weird ioctls".  Anything you want to
> > implement beyond ioctls already implemented by other filesystems,
> > you need to bring to linux-fsdevel as a separate proposal from "please
> > merge my filesystem".  Almost anything implemented by f2fs is a good
> > example here.
>
> I disagree to this. As a filesystem developer, I belive ioctl provides a =
way
> to tune the filesystem-specific features which are not supported by all t=
he
> other filesystems.
>

Jaegeuk,

Note that, despite Matthew's unhidden opinion about "weird ioctls",
the proposed clause does not say that they are not allowed.

The section refers to the way to submit a new filesystem for review
and requests that special ioctls will be clearly submitted separately.
Here is how I have added it in my work branch:

 - Structure the submission logically.  It is neither acceptable to send on=
e
   large patch containing the entire filesystem, nor is a replay of the ful=
l
   development history helpful to reviewers.  Instead, split the series by
   topic -- for example: superblock and mount handling, inode operations,
   directory operations, address space operations, and so on -- so that eac=
h
   patch is reviewable in isolation.

 - Separate any filesystem-specific ioctls into their own patches with
   dedicated justification.  Interfaces beyond those already common across
   other filesystems will receive additional scrutiny because they are hard
   to maintain and may conflict with future generic interfaces.

 - Expect thorough review.  Filesystem code interacts deeply with the VFS,
   memory management, and block layers, so reviewers will examine the code
   carefully.  Address all review feedback and be prepared for multiple
   revision cycles.

Thanks,
Amir.
