Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438D3EDE54
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591901; cv=pass; b=Pf11i5pbEmXxAdKE9EEIvuUwMwXKToO/cftgudY0zWL04OLe3NKuJOHM92LdBBCBy/w/kkKj0mu91jExHJUIkuk/6q/QEa3cdfWgLmzG9IhPajCxN5OTJoFCkmAjFzuqpcosGLUXEqF38moew+wgF+iH9POtBcYgOupYCAWaTes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591901; c=relaxed/simple;
	bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPpB+hQLe2n+Y/JMVnnrWnSUySj+jKkrTdDfo1Ys8AJMBDD4iRZRhazmySX8KFbs3uFHvfMBW5yq6PJHDCjs1NZkh7KGdtxRJGGleaJV302cpyb6YAwMuMJ7XDGsxbpfnLZTM26S6V7qzwuRNryI/gf7VJMu6vnr9RgxEGkmK7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCdyfq/c; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCdyfq/c"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef1198766so2185095f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 23:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781591898; cv=none;
        d=google.com; s=arc-20240605;
        b=PKzTKxExcaDQkhIH7SkzcU88SsYnrOFY/cECjf8PZ1+r6GmKeWjQCT6QgQaNKnOlDl
         /rRC23XRt5qjKfIHjqTylD0kWVcV8bGKA305g4rKOfVfPM/nE7ZkvbsUwYbPdsce2lIN
         ZVTNT329bYChZCwUWUGccDDm8dQnsJ5b08k9eFC+N9ge+y41gSvj/c1aZr1xacEcUN3x
         TSBXbERQTkqokvONvtp2TdpHf6b+22WudpvwbAr/3KPdH+Ee86a2J++BO8uuuufJSy0d
         LLOpBgtjpaQm+rsyAHZv8lW5HIer/10C3xCsOmCyYO9kwe1Rp28kA0tVxh3Cb8j0+teY
         s8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
        fh=+qFN/WOSIvCru4JpGSWuhfoVa3p7iP7H+xWnXgAEKAQ=;
        b=HoJNppeoQy63SRfcNN9boOV6Q7b2CO/z55lvyHa6dN7Df7hzRzjD2NWwxxAFj1Tw5G
         12YdQbOSF40M+Vx1EDxkAoCLHVqwOx3JDfOL8UHzsYsXdJFnyEqfsKAgwNVQMLHipkoC
         VN7W8e6WIY8Wujtcta1ib5jgumzlQwU2aKmR2NtEL6SjieIbi887y6xa3FCeAfotUB9E
         s0u3M6/maO9gS8eHvCSWzeygUV8MsOLDd3FC+bymNsiv/cj17RxTAAUsBJHFw8UwKdeb
         VjB9kaTXSoduP2XajPEKjtYIuzba7G/OdYJJxuggpQEcumZMACxrvclSuOQp81BgKTCV
         yJ+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781591898; x=1782196698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
        b=TCdyfq/csbwNTDXoi0an5Gyt2xnpYlXssRzAw7yl/QEXZK9cE9pdxwEc0QL26TL4z6
         A2gG862fFBUtL0pim6vgby3kjkGNb29nJTCgTRNEP0QI6MKUA2YNCJaRExhsFwQ0hzr4
         ZivENrblWimzl5P7+92X7IvsD9yMi1umN1g61OaObNghB50ddmvw2TNeBUHa4WtS4iL2
         tSLByc52ayqAAkfEXAf8k7l7kB0591ppCMH0DThaSunxQ6R4m9O79zFq3g3JddhQVTRs
         I9xObag+6bPi0MWr8QHTYGpw8/XXW2NUcr58eFgRL4mbdXNaWIqSEI+uhtSGaWTvW8xD
         0ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591898; x=1782196698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
        b=sUz8j/sS1C+xUdGj7h8DN0Rwxg3RSLkqzhAUYYLAzubqbnh1U5sjieAZ2dz90x0V7/
         UiGRC5OFKXWWMaqnTjMKmd1tT8v1zTu96S3smNf68UeM8GJ3gGvXMMTXBzpFedyfYcqb
         zWEFe6LZFdzL1DGg/ogpDvIwE3R+4eW2MnuLv64p12/gX4RzrwcDD6Iu17pxEGBny2Wi
         Sfs1p/hTnl7MKD0jKFO9JXCTNM09pAJxJkhGslmhjqxd+G4cQflChIYeHnRJ7w7CFS2b
         iv25td+sokoBcjkWX4yv+2yVGoWg4sFTEnRXEbtP9zleR8cf3nW5rdvbWNrOLXz+Ml5w
         dY7Q==
X-Forwarded-Encrypted: i=1; AFNElJ894ytckVA3bwvoaaFVxcyUDAUc47GSPtASdisHvJfTL2QrwXhowez5//r2oMKknyrNOtJmRgswj7cCLkWq@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGN6lnaWbIy48iw4tgdcG+KP9MW2Tfgt/3Co2LqlurMTENjXd
	5Xg89HTfVTHcnAOkpttQRaBAMpCh589RHw0cYFM1GjXkFJ9ButIXkAuKLR+xMUHZ72a6ig4JvJl
	su+t5Xjxp3GBTVDOls922WZU7rj65oWE=
X-Gm-Gg: Acq92OFApdfxIX3kLz/jBFWv+rIRneFsH7FFNdUxFEuvo/THbezyfJMMPv9TDGoufTk
	XZa8yv1LCN7pfHhlAl7PvKi8tMZkcJwPUBXY5jeIyJt4/PmgMinrzV7T8AZwaqoxYvNddERoILo
	ShW3xgvWHuUZmrQAemGIEb+4zFQay4+JbZl08zW5InWfQ9p9R+jRYF35ccQdZkPPq4UeyRirvwZ
	Yo9/Wbj3qAIcLzM0WnMtT8AnmiWvrRLnZeUwjDfFa4U61k3REW17N+BxWRJwnftPCNXPwVbLQqT
	z4nPPGmjxLnwcbrGw+0RBrSfolzu5Bc0OBQsECf11tidXp98QsMCcHfCRmvFaiVkfTZxjWIXNQT
	B6Q==
X-Received: by 2002:a5d:5d11:0:b0:461:a19d:3547 with SMTP id
 ffacd0b85a97d-461a19d361emr1794950f8f.19.1781591897693; Mon, 15 Jun 2026
 23:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
 <20260616011516.4039110-1-safinaskar@gmail.com>
In-Reply-To: <20260616011516.4039110-1-safinaskar@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Jun 2026 02:38:05 -0400
X-Gm-Features: AVVi8Cc6TBHBfR45WJ_2epcrLUaiFCORhANibC721wRIalY3QlqXFyIm-p-MJJQ
Message-ID: <CAJnrk1Z_V8TShvWV6zwTMQqXra3J4J5CL5ofFMm9DGoLj9whEw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, bernd@bsbernd.com, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	fuse-devel@lists.linux.dev, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	rostedt@goodmis.org, torvalds@linux-foundation.org, val@packett.cool, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:15=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Joanne Koong <joannelkoong@gmail.com>:
> > > speaking of fuse_dev_splice=E2=80=A6=E2=80=A6_write actually, this se=
ries has broken
> > > xdg-document-portal!
> > >
> > > https://github.com/flatpak/xdg-desktop-portal/issues/2026
> > >
> > > Specifically what happens is that the EINVAL is returned due to oh.le=
n
> > > !=3D nbytes:
> > >
> > > fuse_dev_do_write: oh.len 16400 !=3D nbytes 15526
> > >
> > > (where 16400 =3D=3D 16384 (read len) + 16, 15526 =3D=3D 15510 (file l=
en) + 16)
> > >
> > > After reverting the series, there is no error because oh.len
> > > becomes 15526 too.
> >
> > I think this is because of how libfuse handles eof / short reads. When
> > it detects a short read, it fixes up the header length after the
> > header was already vmspliced to the pipe because it assumes vmsplice
> > mapped the header's page into the pipe by reference. It assumes that
> > modifying the header length in place gets then reflected in what the
> > pipe later splices out.
> >
> > The logic for this happens in fuse_send_data_iov() [1]:
> > a) sets out->len =3D headerlen (16) + len (16384) =3D 16400 in the
> > stack-allocated fuse_out_header
> > b) vmsplices the header to the pipe
> > c) splices the backing file to the pipe. if this hits EOF, it'll get
> > back 15510 instead of 16384
> > d) detects the short read [2], fixes up the stack out->len =3D 16 + 155=
10 =3D 15526
> > e) splices the pipe to /dev/fuse
> >
> > After this patch, step b) is a straight copy which means step d)'s
> > fixup doesn't modify what's in the pipe. This could be fixed up in
> > libfuse to not depend on modify-after-vmsplice, but I don't think this
> > helps for applications using already-released libfuse versions. I
> > think this patch needs to be reverted.
> >
> > Thanks,
> > Joanne
> >
> > [1] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#=
L846
> > [2] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#=
L956
>
> Uh, this is very unfortunate. But I still want to remove vmsplice.
> Maybe we can somehow save my patchsets? For example, let's return EINVAL
> for this particular combination (writable pipe + SPLICE_F_NONBLOCK).

writable pipe + SPLICE_F_NONBLOCK is a valid vmsplice call today, so I
think returning -EINVAL would still cause regressions. It happens to
be a workaround for libfuse only because libfuse falls back to
writev() when vmsplice fails, but I don't think we can assume other
callers have the same fallback.

Thanks,
Joanne

>
> --
> Askar Safin
