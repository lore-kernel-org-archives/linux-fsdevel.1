Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358892DF6E6
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877205; cv=pass; b=L484J7t50oQ4BJlcsdRFIVTdW60ZTG2GqaHvtD2RqsCgNrvsn5ZDeR5rxKLtPSJQ3k4rIr1YnHGuWnNHU17oWMt9PS2ztUCjKUmRgaM1KR7TbWZjy55kf5kb2FQiVxDiBeYmJ6tkSZ+RwbuwLj5ajeym5agw3sN/9bF+v9RjdbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877205; c=relaxed/simple;
	bh=cco+5oXzl9OcKLeS1epBbONJTaKK6GrymQgbT7xYtAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohD/vEOik0B7qJkDcxeSaHltP2+W9uYFnOelQfVlVIACt8rnu96XKWuj9P1CSGIafPZqnp9trtA8p7AYyN48AyX+D7UkuQUJHdYyng9kD6FxNNcjNBeekhps/UVaqHTS2D2uTtZQzbCktI73IB7I4GrHgjGM5KQnY6uwDVREv7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfkpvHrJ; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfkpvHrJ"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2afe9fa8e0so826709966b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 10:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790877194; cv=none;
        d=google.com; s=arc-20260327;
        b=A5lk+FDTRGT2BeudBf44ZRdpB9WvKFhziv0sinnVDeJDZZkAXl2NcCkvKVYsmKZNZU
         mPUPRnt0RAoHxMIqcJc1D91JveGUUdVLIpRV5WhOjfK1wtmtq6tNBHQ9IZnKEJ8tDx+8
         fsI/Ja8nk+x7JWw8o38o3RaaexgB6MHQ3UczvDWn2qbIJs0ZLjs8x1lSSsN7Uue/EoRm
         tC+ybDt9T3Z7MPXYvZSHcmCNv55JIwBwJzUDDhUX133hcW3JweaEgCnco47TFG5eJrCz
         LYxZVu2k6eN5GaZ9Q7yIduFC74rtGDGPtqG3ag7UYEYHkUra9uY/PTz2pkZRmuj4p7pM
         btwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5FPwXskimTV5Cm3JlZNRWRS1UDu2MkqsLKRMDAqBuMc=;
        fh=MVc/P0m1pGdSxDkMgYFBRusDJRLe2k7TIm7tyNwiigE=;
        b=kARYLRGFgU7mBDmTlMCzMecmgLgQOKtEFH6FJpexdN00SaMM1rxxCjRn/J4ghGT1LT
         PQg0EOZEnxJZWrkBMZsH6R7qTrCxf63Rgq4Jkw7GU40T0Vr3xprJMpNAU7+wtnWkEUIh
         Ym9YqbjWCJoN/fF7uBgkI9twGhOGiG0JdIXaO1z4DYef1PupHjciBYmJjbyHFANp7vap
         aeyS0ujLUiD9uQdhqB/eSdQeXXSNbx4FxykO8TszSpKC2Baw1z38pVLZCd0Hyxc7EQi8
         HLQ7sFB/WS5i02K7MDkr+wombGxbEN52fUPsekeN7ADlB3l6d6WAoLj891MJLlD7Nb/g
         UheQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790877194; x=1791481994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5FPwXskimTV5Cm3JlZNRWRS1UDu2MkqsLKRMDAqBuMc=;
        b=rfkpvHrJyQuLfNvHC5aC0YHh/881B3p/r8WTUOCn2CLIo+epVr9lqd1Ae3uVQGb44m
         gR1w2PbvWWhG9IMd3dAyhC4sc+CfwYG+Mh3eOWbvXvNksnA6ZrDXcIBjgZMZYyYHBZ4d
         CntSibIGjFuERrk3yzM+C5E7ijWTlawGH/bK/RKcBmYlVSpydYixha6vqi7Pb2PrYZtz
         4iB7ZD8pqJ5qUSEGcREeygJ4nE6OzTSKhPk0UUB9wBvrBmAiJnec/TyweVX4npJPgPhS
         p1N6xbq3h2gKmcjGktLXvpr61LxQYB4yEQAIdTm7eY3zlXwOqwUIMShZhFNCHFZ+GBAO
         uz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790877194; x=1791481994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FPwXskimTV5Cm3JlZNRWRS1UDu2MkqsLKRMDAqBuMc=;
        b=MjVOb3spoKrtEJg8G7yAddCxAX3wz6iloHoHig498AnwKSSqSbJ9U9mqclPtssSy2c
         o0nCKD03FZOu9KzZJPhVjwJKV5lZmZk2WlnmmdOWn3hBIGtXLqznbeY0YwtkuHGIQFQb
         prNIVoHSg2wb9UcRB86bmJiaek3UXL6VtQ0rQgDDqeFZSER8z0M/JW9Nj2FggYD+LIpP
         VlUee3JRgRxzsV3rDpO8P5ZBYJvAUhy1b5cyUkPqblAJzXC/M3V96J5jkcqlF2x+tvpR
         GB75tQbTgPbSMxZOcinnK9bRqQ2S0ZZNLhjBsq06JfRRAad0AN4LetFbFk94xDLMPoVm
         Etdg==
X-Forwarded-Encrypted: i=1; AKwUvBzR+44GFO7n2biMXtPMPTs5elQ4Sud0FDQ9RCQh5Aw4HhSstGFtWIonXFDuvY3U4Q36D7FwrqIC0NTWkGVf@vger.kernel.org
X-Gm-Message-State: AFuF++klLFHv8EFfwK59znsFP3Mrq7qVv1ucUBFiy1MunxKFjTltBK2V
	6C/mLJ6eLS/fgMmhtHC8Xd5UCEU/I9EVIWN5fC5oel/4tQh9VIZdVi0qDWM2VpMsYn1SoLFIPJQ
	stpqw5vE2zFAHr57j88yua7WACle2wTs=
X-Gm-Gg: AYBFou1tkv6MNgD0Lnr8IAzGRg1XhnK8T5YHmGQh3Yiz6UgsDcC380LIrVprF8dzqqM
	GkxLDH7Ke4qrjPiUqQswM1R3Al0zrqef9OCIKkaam9c7ij3Anc1Jolmrg8Kb6D+Z1614BbHR+IN
	tbuvYmpBDNFzUT/ZYUSZmAWb/gD4FPb/4PGVTfR+3XCiLZ8mCITL+P4AsdVHz/tc8g7hxonlz8E
	dNw7vp8185FDkJn/plPd3AcgUNdv9tI/inFZpQ5xDfErBxAprt2iD16h0PqmGXLwN4qjW2CW30j
	do23/W7uv9x2c48drKP4XZLXpMh4TNxnUhqEkcCkeNNYkFZBJndAjnsxB//tk/UEo1Y=
X-Received: by 2002:a17:907:2d8f:b0:c29:5d41:dfe8 with SMTP id
 a640c23a62f3a-c2e4b443e7emr30126866b.43.1790877193384; Thu, 01 Oct 2026
 10:53:13 -0700 (PDT)
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
 <CAOQ4uxis4tsea6fx+9iAffVX+qwBC9KzHg5GcP7ahthKd1T9KQ@mail.gmail.com>
 <1910540525.790746.1790806610320@kpc.webmail.kpnmail.nl> <CAOQ4uxhYHf-gAkjdhs37vZREOcNds5a_6c3nBX0Lva3resofmw@mail.gmail.com>
 <1000409963.929534.1790869356300@kpc.webmail.kpnmail.nl> <CAOQ4uxism8-zwCDgGjO4Rxz6DqOkZJeZOeYKHf3QaBDFZHpcFg@mail.gmail.com>
 <563229463.934215.1790871823693@kpc.webmail.kpnmail.nl>
In-Reply-To: <563229463.934215.1790871823693@kpc.webmail.kpnmail.nl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Oct 2026 19:53:01 +0200
X-Gm-Features: AclHuK_pfqjYtJsEEhZFVwP00mJld4bjVtzKfR6264nsENJOPN0vxrbfYWt5b0I
Message-ID: <CAOQ4uxiZBgg6WNRCNifsMRkuhX0176oef10TyhzdmTvqkEVnUw@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:23=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
>
> > Op 01-10-2026 17:59 CEST schreef Amir Goldstein <amir73il@gmail.com>:
> >
> >
> > > > Maybe I am missing something, but I think you misunderstand me.
> > > > What I mean is - if directory inode has a ->atomic_open() op,
> > > > bail early with -EINVAL/-EOPNOTSUPP, because this is a network
> > > > filesystem that does not support atomic O_CREATE|O_DIRECTORY
> > > > and in most likelihood never will support it.
> > > >
> > > > This gating criteria is not dependent on cache state,
> > > > which is what we wanted.
> > > >
> > >
> > > No in that case I think I've understood you (or maybe still not?) My
> > > point is that we can't do that if we want to be able to individually
> > > support O_CREAT|O_DIRECTORY for some ->atomic_open fs. If we bail ear=
ly
> > > the how can say only NFS support it at some point? You get into the
> > > situation where everybody needs to have support or no one.
> > >
> > > Does that make sense, or do I still misunderstand you point?
> > >
> >
> > If we gate on an existing criteria now like ->atomic_open()
> > and/or ->d_revalidate(), we keep semantics simple and it
> > does not limit us to change the criteria in the future.
> >
> > But I don't insist on this criteria - it's just a suggestion.
> >
>
> Oh no, I don't think it's a bad idea.

It probably is though..

> I was just trying to understand.
> And like I mentioned, I don't understand the detail of ->d_revalidate()
> usage.
>
> What do you think about Neil's suggestion to keep ->atomic_open out
> of directory creation for the time being with:
>
> 1. use ->atomic_open(O_DIRECTORY) for lookup, no O_CREAT bit passed in.
> 2. if positive then done, otherwise (on -ENOENT from atomic_open()) we
>    call ->mkdir
> 3. open that dentry in the regular way, WARN_ON negative dentry return
>

I don't know enough about network filesystems to say, but it sounds fishy.
I think we want consistent defined behavior for O_CREAT|O_DIRECTORY
for filesystems that support it and my understanding is that this
suggestion is not going in that direction?

> But I don't know if the kind of atomicity I care about is affected by
> ->d_revalidate() filesystems.

It is not directly related. It is circumstantially related.
->d_revalidate() *could* mean, in the worst case, that holding the ref
on the dentry gives no guarantee on keeping the object behind it alive.
In the worst case, maybe a new object with same inode number could
be created in the same name.

I am not sure this can happen in many filesystems for real, but I
am pretty sure that it can happen with FUSE.

> With O_CREAT|O_DIRECTORY we just want provide
> the mechanism to ensure that the process actually did the create you get
> the fd for.

Yes. And I don't know if you can get this guarantee from all network
filesystems. Requires an audit.

Thanks,
Amir.
