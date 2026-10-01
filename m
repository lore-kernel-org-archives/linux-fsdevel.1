Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A601D5CFE
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846971; cv=pass; b=ODAKyHhKc9eKDV1vT8vhjZBZnly6yc2eg8R+5fAaYp7aZrukrysRVqzO/OKAvAGjJW3de1zx8n+Qs9D/pEv8jyPli0CaREN8SfjtbBwKHwYbrRBcdUb/SRQVvPfQyJRDzPwQNm/rJJlk2Lg4BOQc3CI0mFlNAgWJLgimMYvfnUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846971; c=relaxed/simple;
	bh=jZHzvLN+YWJv0sQisf4gerkQl2AupObKC2jZdQ8u92M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klScns6bRRcM1azHF9+453s1AizdJJU48rdF8JfYwYfUbrz41jzFS7MvBEi8U+jDsD9TAs/NtQizlZCmNZ5uEpM1CI1n6dEAySqujFKXKEvhChKx9Wcgs1g52gkTvYb/25lnBuWfGNBO1WmaE9fesJXw93MKRv3Ezpa04Sc2PAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY1cCaLu; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY1cCaLu"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae359e2c0so9622772a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 02:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790846966; cv=none;
        d=google.com; s=arc-20260327;
        b=KVHS1Zcs2+qEYhmlzjKppNKtDYewRrTgFivAl90xkDsbaI1vDyp0joXqunhuZWWDFJ
         770Zb0feYseWXaAhptUdGakuB0sjkwbPPYfhb5zv7bqpnCiws0wl75BmGnBQrXqDyZrD
         2QsLW/2Y1gN8U/efKTUt93vNRKZ9weZn4/02/5Ft8+ccSlWlh39hVXKJtRYFS1oeSvdj
         SJ+NOkVRtaEo+oOG6DAvKFTRcdUTkUM0xkeY0qHxyVaErTEQx5BQ02OanAmj833Ijp7y
         iSzOKrxUb2g0JqREgNssdM02Wn9EDsv9xucWaHhXMAlhXUoBxUZ1OB8FtVbsOmFi9Sjj
         Jsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HCpnUTDBQc5LkLCypwiLrWXTqJ0v8a+JvAdX+sHd2j4=;
        fh=jAdfCnttM6q0UdgSmcyHoKuRqPJVix3xYweUFY+ZaYk=;
        b=CVlEWN/+TLAPWWzY2bCXWXBBopsH0WQg3OArgetmd8uqkb4zBjYW4C+49iwirgP0BP
         7zw+NphyxSuRoNf+zMUWNp4Qj4+VnXmk5ApNZv77TMRGrz31dYUEhS+qu52h6yfHq38s
         pqibCgR+F2t44qvOXJi9laBzsTDKPH4qIeirQk7TwqHXXUq5356yDt9nn4PgVtQaYe0l
         0r2VTt98wdrv8WinW1iwl5jMPCowJnhg7VfNmZQPjYURy00JKtsAhRPpndSPQld6E8Qa
         Hchs8OrHZ/ExX95/3GUu6tfiUtKbE0ic0mmVGg8+a5BP21W/8r4Mj369Rb5zknihb03C
         eKLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790846966; x=1791451766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HCpnUTDBQc5LkLCypwiLrWXTqJ0v8a+JvAdX+sHd2j4=;
        b=NY1cCaLuvPzoAwNmUZmOShYwrQBDtKgIcQwzEsv7pp9P8TLuD50u89/XpjOvIhsHGr
         8fkoq6Q7stfQ73q/g82gAO55Yeo/lhBXQzAMcHXdZfXXMxarqqQr79MPGq7Dwlju5/ve
         gb/6DzY4y5r9DZr98p/7fP2MvQ8iRZrsOp2bbBlF7fKXCwUkVb3Da/Gi8BGzBoqjbapB
         hTaj76Pz9CBCoFn+2973+UpYxK5rDgiwJq1o80EmHeT30Htfl8pr5W7LMTBHE/kuPQqO
         NOBbo/SWtnEgiYxtgsScSvxJnr4baQNrS5MREsrBRSLM0XC11nM+O5xuzK3awskQi7xe
         Piig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846966; x=1791451766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HCpnUTDBQc5LkLCypwiLrWXTqJ0v8a+JvAdX+sHd2j4=;
        b=uOW5F2Up7U4I/M75s8aHiwmOXlMVkIWSCUXkcfQWVI6oHpV6T4FUOKNySnfa51N7eh
         myQzCSllAW9Jg6OiNc2UflktbTEJwYmj7EKLmPYKvJMIctsraHimFw8cnwvvrF9/Inph
         x+TbCn7nb+SFrtq5AFYtrMT0yMOZdjLMz2brMg687OI2kfyqTVssIV8IK0cDKMpX5A9V
         CNYrquHvf7fwbAISVR3JwYZAy0l6ZpWgBto91gXfHRjaRmqTEvSawgxqlbonLjNrap2e
         39hwUyx/q7OEUx5jt8pYFHd8ZohjgY7chZyocTwTuzdk/lcR6f5S2cBLVLqlV6zfwoAc
         r+Aw==
X-Forwarded-Encrypted: i=1; AKwUvBycNFXOnjkqpaCfy7RE196vvjfMyIQvOAD/c1P1BS5dc2QBMFrd+ixVOGBHFEiHdgHe5l3ijy+6treO2uBK@vger.kernel.org
X-Gm-Message-State: AFq9FYL0yInPmPqCBaKeluFhuAhNFSincz3flLXt6SOrJF37Oti0U6ZE
	XPK0ug1gPayf+G8KWSfWnPmlPoUXEnzAO5b8fmFNZDP9ABvZhrLxmEijStFQn7HSiISSfKM3RAV
	Gc1gAkKO546cE5mSJWnhNtq3ks2t6KOkBeMjauAI=
X-Gm-Gg: AYBFou1ypgcVxS99kAPsYpktKaY7lFM3WkrQKLDRCOZC8+H7+8wNwetunm1lvU87qF1
	ko2dzlZZDU+9H6vXXPNDbHEb6P6L4TuKBmoVe4o6ov0S+/n7ViON+tpaAqxfkasfHva25xi5iio
	QNsl0ApnFOo+N0Yk8p4CXrX8R5tXwd+Vjfkz80zzhdqBwAj5hLJCILcHb501FvFQivWYTDGyxoh
	80Dbmc+0AyEJOeKBkaDXUVVSTd89wx4/H3QDmmuxq7T+Ag6TGWBGKkUjxr0UAlz0FXIDTu7Xr3Q
	ecbv+eKBv++5OskiAyvhtkgh6+wQqaHcZi+mhAYCbL09z4YZwCYwkYT407nPVoNQcVGb
X-Received: by 2002:a05:6402:270d:b0:6a9:a5d6:622d with SMTP id
 4fb4d7f45d1cf-6ae19864d1bmr3251507a12.3.1790846965815; Thu, 01 Oct 2026
 02:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913185016.523376-1-jkoolstra@xs4all.nl> <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
 <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl> <179072013439.37859.465558431050704411@noble.neil.brown.name>
 <CAOQ4uxis4tsea6fx+9iAffVX+qwBC9KzHg5GcP7ahthKd1T9KQ@mail.gmail.com> <1910540525.790746.1790806610320@kpc.webmail.kpnmail.nl>
In-Reply-To: <1910540525.790746.1790806610320@kpc.webmail.kpnmail.nl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Oct 2026 11:29:14 +0200
X-Gm-Features: AclHuK-KGaG7MdZslEeofy-MHWg6LFigaj5JnkX5PbgsR-pbCuTja2l09oqRNVI
Message-ID: <CAOQ4uxhYHf-gAkjdhs37vZREOcNds5a_6c3nBX0Lva3resofmw@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:16=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
>
> > Op 30-09-2026 05:45 EDT schreef Amir Goldstein <amir73il@gmail.com>:
> >
> >
> > On Wed, Sep 30, 2026 at 12:15=E2=80=AFAM NeilBrown <neilb@ownmail.net> =
wrote:
> > >
...
> > > The problem with this approach is that open(.., O_CREAT|O_DIRECTORY)
> > > might create the directory, then return -EOPNOTSUPP.  This is weird a=
nd
> > > I'd rather it not be visible.
> > >
> > > Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather it
> > > remain a -EINVAL on any filesystem which doesn't completely support
> > > the functionality.
> > >
> >
> > Joining late to this party so apologies in advance if my questions
> > have already been addressed.
> >
> > I agree with Neil's statement above, but IMO, the atomic_open() fs
> > match the description of "doesn't completely support the functionality.=
"
> > Therefore, I think that rather than success if directory exists, they
> > should also return -EINVAL/-EOPNOTSUPP consistently (see below).
> >
>
> The issue with this is that if you want per fs atomic_open() opt-in (in
> contrast to either implementing all instances in one release or disabling
> all), you have the issue that your lookup now depends on the caching stat=
us
> of the directory dentry.
>
> If that dentry is in cache, and positive, d_lookup() earlier in lookup_op=
en()
> makes it return early:
>
>         if (dentry->d_inode) {
>                 /* Cached positive dentry: will open in do_open(). */
>                 goto out;
>         }
>
> So you get your lookup. But if the same dentry is not in cache, now you
> suddenly get -EINVAL. I thought that behavior was more unwanted then
> what I eventually settled on, namely to strip the O_CREAT bit.
>

Maybe I am missing something, but I think you misunderstand me.
What I mean is - if directory inode has a ->atomic_open() op,
bail early with -EINVAL/-EOPNOTSUPP, because this is a network
filesystem that does not support atomic O_CREATE|O_DIRECTORY
and in most likelihood never will support it.

This gating criteria is not dependent on cache state,
which is what we wanted.

The justification of using ->d_revalidate() as another opt-out
is that existence of ->d_revalidate() means that the state known
to dcache is only semi-reliable, so making atomic create/open
promises is problematic (O_EXCL for example).

The problem is that some fs (overlayfs/ext4/f2fs) register
a mostly-noop  ->d_revalidate() so I proposed how to deal with those.

Thanks,
Amir.
