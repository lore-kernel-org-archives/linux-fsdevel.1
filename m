Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C480364EA5
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782075021; cv=pass; b=srkU6zQdcBRXJU3MDW5kxuTE9I7CiHA6bznBGFXw+gGPPN/GnoajEz7wJH3TCY+EEZk86eJgebdasVqS/kq0j43/ZdmnGBR5qWvuYdVjC+ub347lGgqf8ALL1KAxuF/DS5bl+EaxpsYAXToxEXyTO72AuS3hf+f/11d+M2WsWFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782075021; c=relaxed/simple;
	bh=WvJq9ePfdbKsX2TAbyHCprlhffFpU8YvzQ7kO/0mQWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXSUbhP/iYCvWzLSYih2vn7ecCUqzQBlZeJViho6TFmEP4AJGIvK9a4tKZm+htnZBbYPTkVnJfGdeRDPeRpVNinH1GYnYNnRdPHP6EDqSxA5kHY8sWe6mY8+zhh+A30amrFwa7n8+5jzUnZuiLRqWMtkpxYupdfl+txb9NkUlUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmh+9r1q; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmh+9r1q"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-662e7fed068so1639268d50.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 13:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782075019; cv=none;
        d=google.com; s=arc-20240605;
        b=gi/zH6M1Is6kwKgcS15iFV417fil4VBKnZRpoP/nSpQBxb0uuA2dYU3CQH6BxuJo1G
         eegbyZFTSdi8dq0LU5boTfg/ba+KmcxWoOHfB5IZjNK1PUF2sY3GByNUnOiLP1f28eHR
         oyqbTPTVwQFYlQ65L66u9iNSDyxt9vGLAkVfYbUpl8p3CverXaaPpwJJoPL5mjpNeu6L
         6hDxJ/rTcUUc57ottqAvtJIs5K8ic4kY/pvSY6nKsH6KnUGtpGaRI8c0Y5eDLYP1bibq
         Z/09P5UZOKehbAi6kL4E79iNt0PwjMF/rHFPJBOwXqkDED2ULfBB8O5II1CH8gN8Ktrj
         rNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GISnEx3D6mq0Npy8uED8fJSbLuzRrd9nWr5blF9KRY=;
        fh=DsRcf/oBWl5DQ8MC61i+RWYcpofEVsYkMGHabbJGB4A=;
        b=iWiQIDrL10qkVKP2d4vMWY2llDlKAbMPlXd9v/63IbEbtw35UsS7BZC9U62PzEmKC3
         OGmu3vK1RQCINN8bu7EOkihWNO/fbp0wG+RR7ycF1+Vz4zjRKuxQhCpQWtiKAxdj0kUW
         jNPfaJ6ZFubYBOEwlhlmUG7qyDJtHuMsSqsvELTI7uYSJRo5lqrTcsHSZ9Eg/DjYfSID
         UbUDgJdDwlP69Wl8wFOmXvXeP4gCNG4ADodCg7zHj+FCz9yXkb0B0Wxb9+6/f6ui1x7c
         JRGjkr5GfAhjFOtho5jcyr2BeUtpOT5inLfqX4cRL+PkAAbHgRx6kcF4izwZAr2E5bxc
         eD0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782075019; x=1782679819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GISnEx3D6mq0Npy8uED8fJSbLuzRrd9nWr5blF9KRY=;
        b=nmh+9r1qpHpIXM29oeNWP4ku1+0xJboQoCpL6wNYl9riatfmoPTjbfyuLSELNjSHBU
         B0UY2RVniK/1CzsrZaz3k/aq/eGmbTvC+BFuMcey5HLWMjEcOspSVoIq01DjCTl5a1MY
         wszdGR1EYqEswUfoe+nsLTwKZmGimiESZNi9sJfUdmNsT3B1MqK8Xe2f6lETzLyLF8KZ
         sXcFV6Peua+ejxzTeDy4VRvULHvbW4Tz/yki9yZjQcdBeaLcUqGHwBZP0ncNIqM9wcel
         MlWTLnl3ClBXj4kvvsOC4Hr7nIA9SlGjeVhSCUnXKUnnwqLXq4AZRdXBmU0wWUdMYlK+
         p0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782075019; x=1782679819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3GISnEx3D6mq0Npy8uED8fJSbLuzRrd9nWr5blF9KRY=;
        b=Oeo/nhzOu4W5mdsS2oKTwyj98CKPND7vNcpj2usmEBDXAQpr4EaDjpPQD45beGl0rX
         yP7obv8Jmf8/tYHBU6cyS8OP+pe6AtdY52q8mHYKglPvcX3yEgZ+93H140rlYcQcFZW0
         HKLkcwymLBhTVtiJ0f8RspfjzbqhoCibzsoEjHk8TVgjBoM1lOlC0q4pOouh21273jxD
         oWFkKFrQBDxWygd3ZAOLTtdpgNcGLaR54GvEqNP9RummvjzKv9nzFFibqT2UkwrwBRCI
         oyFnWycLcMnKK3wTkTFbvFOoRJQEG70SoH3seNFOl1zdyvyqAG2VGdnWARIafmEYgWl4
         dWdw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+ulhsXSrUgpsuKhfq7vznCJ2nn09m/dpGZ3lCWknoU1FnGtff1LMdHcnm4vBy48uZ7NwgP63T8oZqBMRr@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwml3iFENicakGna7eXsE1ayTG4vPirifAUnZL9bLdxbxJQf/
	bY8Kgsfd+AJ86Wtdms4JOj7Fcsuvq0GgqLy9bmLFUXG3j7ng7/rn5qouFcR9U6bIRDPdxgpqy7a
	vmuEr6/m+33M2FoXCTyhnariJamW1QlU=
X-Gm-Gg: AfdE7ckOg1Ib99IrGnWSFZJDV+R1SimJfUxB/KdBIQxH4BkjkNEu1He+77/Ejt0SUBH
	R70ctyLpwEwQZft7uzFnBsPzhReTehjVxlNswdzD1hlmM2hh+sLz6FoepjctGkrlBNZHr8jwFpA
	pxNIGmCT7VO0SSybj1BHOI5+9xauGfLXr43xrS6ch2LzmbPhwjg2ySlFmE4PxuR0h54BGBZErZB
	0aLEzOnKogCaaLVivtXykKIZ13M+C5FAcVlRqb8vRIzwHfDnHA5fwC1ruTGfm4MIDJ4EA==
X-Received: by 2002:a05:690e:12c5:b0:662:d2cb:b86 with SMTP id
 956f58d0204a3-663033c8313mr9737842d50.47.1782075019080; Sun, 21 Jun 2026
 13:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org> <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
 <20260606042112.GA6060@frogsfrogsfrogs> <20260610-chaoten-ringen-bauer-516e17aff523@brauner>
In-Reply-To: <20260610-chaoten-ringen-bauer-516e17aff523@brauner>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 21 Jun 2026 15:50:07 -0500
X-Gm-Features: AVVi8CcMcr3qiU2vqazlyedt_b-ghwUYq0o9F_0BglD7cb0GeX_89nU1gU2fwiI
Message-ID: <CAKqfh0GqLNmui=BU1Xw7Xk0StWGueq=k5KN9uN0v6Y-DMWAwYg@mail.gmail.com>
Subject: Re: [RFC] Maintainership of the EFS filesystem
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 2:38=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Jun 05, 2026 at 09:21:12PM -0700, Darrick J. Wong wrote:
> > On Fri, Jun 05, 2026 at 11:02:44PM -0500, Maxwell Doose wrote:
> > > On Fri, Jun 5, 2026 at 10:44=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > As I said, I don't see the point.  Do you have any EFS filesystems?
> > >
> > > I don't personally have any EFS filesystems but that doesn't mean tha=
t
> > > others don't.
> > >
> > > > Are you volunteering to do any major development on it?
> > >
> > > Like I said, we've already found some problems, and like I said I'd
> > > like to fix those before it becomes a FUSE as you suggested. So I
> > > guess I'll volunteer to do some major development for it as well.
> > >
> > > > Why shouldn't we just delete it?
> > >
> > > Because in my eyes it's an awful practice to just delete something
> > > overnight (probably not your plan but still), I think we need to have
> > > some maintenance for some time before this gets removed.
> >
> > How do you plan to do QA with the EFS driver?  Is there a mkfs or fsck
> > program for it?  I don't see one in Debian, though I didn't search that
> > hard.
>
> If we can delete it, I would prefer to delete it. Less code is almost
> always better. I also don't think the maintenance burden is minor. We
> really only get away with that stance because we continue refusing to
> allow block-based fsed to be mounted in users namespaces. It's so
> trivial to find on-disk image bugs for non-actively maintained fses
> that I don't see the point in keeping them around unless there's an
> actual future for them.

Well it seems that the general consensus is to remove it and at this
point, I agree (I suppose I was a bit ignorant :( ). Should we send
the patch now or give it some time?

--
best regards,
max
