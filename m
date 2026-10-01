Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355774F68D4
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854163; cv=pass; b=e06wS1T08yBZKG/ZC5Rgwo0Bbt6jO8pOFjg/GKfCFe1w/NRCtbBOKJmCh2IH84phHAkBZ2PBSnk9WODC0sPdBjD/KqyGqQ53RYCp51M9fP2L6j8yLU9qWUkq4+skXh9srMhdgLKAZRiyxtkawIFNYyjXFz0GwRVLZ6pkvQ/skmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854163; c=relaxed/simple;
	bh=Ot1+xCJHzq0e02e3Cyh06QAAuD68wjvmC/Hp2Hqnjv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3onBj6IEO8zq2s3fIT65SiFXuAdY+Z+M9splLm3/CnHyYMEAzkCgrB5FWFUYI8v5zI72fwS2Y8ggEX1Oilkr6CaUFIfE/zZRFziaj0tJvz4wbGm9bpb9urC5xKbxwN+dN0+4eM0snqvHvIkhL5Qqt3DSjQz1AWn80W6e1zUHDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK9BTSGK; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK9BTSGK"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6aeeccb7d59so842163a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 04:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790854156; cv=none;
        d=google.com; s=arc-20260327;
        b=heJF4Qn23wzLwgrP+1RuDuspvmyWu3V+ncxoxDXXuW99IorlzOAbksct4E8WwWhEkk
         Aa/RSdqxmf0VI/2wo6RiU3dNrFpzTnE3uH1j1yILDseDuVwT55BzE73Nsq46L88Vq24j
         uDLDvudAdjSjwaeUAtU4oQG/5UkIXWzWr44qUY/XmGd7AsMW55KWGjsa5c/vf+8OzWqJ
         0butbz+mCjAMkAj4OuiLIMvctCrlRSSbGckPaVchWnxFX78BKdRMHeRXwsBakUEckz2m
         t3hHr0/UkwFHrYhcOB+0YndTjEkYezhcef/qPpeJe/C/Z52rvIkmPvdROUPE2Xlpu4RT
         OmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RmUrB8DoICBbcpN5AXnNeG9QLbqxZWqBz7y7VYPLydw=;
        fh=0Za8PCZTzJ+BXzuo53LHpUpKow7HdbimqJh+CmSeBtw=;
        b=bTjtg0iyE/26UdgoDZR5VcAfMSVRin91AZhAx/OmQtFVc5YTr4erEwUUtKHBlS1+cP
         yUFMWr6bjfeX1gxDTvv6smEW8HGEqvw8JtVWVqnOn4V1Ry9nGRaCYpzyjA5kAqHql9bD
         cT0aJ/oBxc2eqG2lCOjbsfPBNGRjchneN6Ys+CkdwzNf0dCvRADQyJYup/XJ99/KIvEl
         Q61O/mvkeQL4qJd0i1JbBZ4Btj1DWVn6y9wprMh3ffFAN3+7uEO5ykd3QleJ0/HG5/mc
         meE8/TGeKZDH1/aWdVS2TgEiPRlOGePEZ2CX8cZWI1AdHlTQH3WnF7NnihBMS8Zjrz8u
         GpdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790854156; x=1791458956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RmUrB8DoICBbcpN5AXnNeG9QLbqxZWqBz7y7VYPLydw=;
        b=lK9BTSGKwiblSiz/mizW948fGsD3gAFBTSoQCy8JrRIaHOJfpP9rjdTHnBtAaU8dYV
         HvesHu2KyEtZigjSGOz3c/0KzNFQyNwuycConmFRBxj28ZvrADyWw/ZIJiBBJLLBZTOE
         nAALkx7ooMm179gdNsj+7rMfNBh76ioI7dZGhbrQ5m8Wk35ABrsoZoDWaSHH4qO76z6z
         EERjO/Wc72cQNP+zhxF5Z/f2pg+fxKdoLLB7pIMO5AdcarVRxreJe8kNrBHWZUOnRvGl
         lk3ZFHayF2xQuSEnlaTQPzjgnAUcxP0/Gegu64CUvIlLamSDJ+M3XvYL7wLmFOTebtyL
         x7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790854156; x=1791458956;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RmUrB8DoICBbcpN5AXnNeG9QLbqxZWqBz7y7VYPLydw=;
        b=MvHC4BLDH3wOlcISaphu3K94FOshNXPQLOmq3RdkwObkrTuPtCJjIVGvtS2zdAJ5oR
         TSH1Hoxgpd9hzFEp5EFAh8PIw+U4bPAz2b6xeh4HrmHseCrXJ+CXTo4ZG38AIOif94Ft
         2phsliKNTYdEGwxd/tf4WKso3Er5jm1FwW4IYdJdGyicF/dqTEcENQW/HYuS6djtVBaz
         LAbFLEfnnxy0tnujp8AeapbuHG7XKIqItNJe0YLJ6tQ9mS/AuE7LiXjYP0InvailZHfY
         Ff+3yzVM+XydYujVjozkw5pLe33jpz6ngOg6VNGYaRSXs/fcupTqkZCrkL+Lmy5eBU2S
         kPgQ==
X-Forwarded-Encrypted: i=1; AKwUvByi7csPoz1IeDD7Jlf+OzqFjCgCCttuFX3/wyKqPg7QTRqga6lNQVIRR6cTuqMNeJWTa+bPVFSasgH40TgL@vger.kernel.org
X-Gm-Message-State: AFq9FYKukehDZ8kISbeYoj6iYHFinLevQkNF6KZJ1k9RqT4MJ+2QufMN
	0/GeEoL8hNXlrQPtcIEz9MJGXRfYQEC3mrAJCzcbcjLLKM7K+8IqyhSDxckm7yDSqtu7MReLQmg
	KfWz0eLfGhCXj3cA2basWFkty+N4dZQo=
X-Gm-Gg: AYBFou2ZYrfA15cTto5xtMlRREwwzYDPmTRqkuTYDxv4g3EGQk4GejE6LqyBzVXxThB
	fx5QL12Zavy4sa9uuFI8J5MCMEevE0YnIgSXnCHZmoRb0ON0XLpRr3gYoG/qp6BuVwDa6QYcR4k
	31W5N/FvtyZwkfqB6N5d/tMsdRPp5vw34OBCZiW03JbWnAYsxnqsRToc2pasIiLgjMBCvLOGh6T
	dC6jjH97DvdOH20pRHNBzJzxgzWh2gfDS/uD2+a/mMjAkXetcVqmqqXHB2J5B2DGm0AxW0FWrNK
	+Y0JZgDOpuSwHNcXMlnrBEmARl0gxY/4PhzFgsQOI6hiVurQQMaotUVF
X-Received: by 2002:a05:6402:a544:20b0:6af:92a6:97df with SMTP id
 4fb4d7f45d1cf-6af92a6a414mr43983a12.0.1790854155697; Thu, 01 Oct 2026
 04:29:15 -0700 (PDT)
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
 <179084933040.37859.13445625413196658440@noble.neil.brown.name>
In-Reply-To: <179084933040.37859.13445625413196658440@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Oct 2026 13:29:04 +0200
X-Gm-Features: AclHuK_pcBihlxtanRskirK29rw2qS74wFNrXL56cTDsIdZmgFEUTJL-6VkpUbc
Message-ID: <CAOQ4uxhryRbKojbMDA2Y9u4o0sNUVTt8KshacWqqEJYb-EYnzw@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
To: NeilBrown <neil@brown.name>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:08=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Thu, 01 Oct 2026, Amir Goldstein wrote:
> > On Thu, Oct 1, 2026 at 12:16=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all=
.nl> wrote:
> > >
> > >
> > > > Op 30-09-2026 05:45 EDT schreef Amir Goldstein <amir73il@gmail.com>=
:
> > > >
> > > >
> > > > On Wed, Sep 30, 2026 at 12:15=E2=80=AFAM NeilBrown <neilb@ownmail.n=
et> wrote:
> > > > >
> > ...
> > > > > The problem with this approach is that open(.., O_CREAT|O_DIRECTO=
RY)
> > > > > might create the directory, then return -EOPNOTSUPP.  This is wei=
rd and
> > > > > I'd rather it not be visible.
> > > > >
> > > > > Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather=
 it
> > > > > remain a -EINVAL on any filesystem which doesn't completely suppo=
rt
> > > > > the functionality.
> > > > >
> > > >
> > > > Joining late to this party so apologies in advance if my questions
> > > > have already been addressed.
> > > >
> > > > I agree with Neil's statement above, but IMO, the atomic_open() fs
> > > > match the description of "doesn't completely support the functional=
ity."
> > > > Therefore, I think that rather than success if directory exists, th=
ey
> > > > should also return -EINVAL/-EOPNOTSUPP consistently (see below).
> > > >
> > >
> > > The issue with this is that if you want per fs atomic_open() opt-in (=
in
> > > contrast to either implementing all instances in one release or disab=
ling
> > > all), you have the issue that your lookup now depends on the caching =
status
> > > of the directory dentry.
> > >
> > > If that dentry is in cache, and positive, d_lookup() earlier in looku=
p_open()
> > > makes it return early:
> > >
> > >         if (dentry->d_inode) {
> > >                 /* Cached positive dentry: will open in do_open(). */
> > >                 goto out;
> > >         }
> > >
> > > So you get your lookup. But if the same dentry is not in cache, now y=
ou
> > > suddenly get -EINVAL. I thought that behavior was more unwanted then
> > > what I eventually settled on, namely to strip the O_CREAT bit.
> > >
> >
> > Maybe I am missing something, but I think you misunderstand me.
> > What I mean is - if directory inode has a ->atomic_open() op,
> > bail early with -EINVAL/-EOPNOTSUPP, because this is a network
> > filesystem that does not support atomic O_CREATE|O_DIRECTORY
> > and in most likelihood never will support it.
>
> NFS can certainly support O_CREATE|O_DIRECTORY.  The MKDIR request
> creates a directory and returns the file-handle of the directory that
> was created.  I think other network filesystems return the identity of
> the created thing - or fail if it already existed.  That is enough for
> full support.
>
> The only cases where I think I think there is any doubt of support is
> kernfs and tracefs because they don't return the inode.  tracefs is
> interesting because it drops and retakes the parent lock so it isn't
> immediately clear what atomicity is available, though it doesn't support
> rename at all so maybe there is no interesting race.
>
> >
> > This gating criteria is not dependent on cache state,
> > which is what we wanted.
> >
> > The justification of using ->d_revalidate() as another opt-out
> > is that existence of ->d_revalidate() means that the state known
> > to dcache is only semi-reliable, so making atomic create/open
> > promises is problematic (O_EXCL for example).
>
> The idea of using ->d_revalidate as a gate is certainly interesting.
> Apart from the interaction with case-insensitivity, if we initially only
> supported filesystems that don't have ->d_revalidate, I think we would ge=
t
> coverage for enough filesystems to be interesting.  We could then take a
> bit more time to think through the rest of the picture.
>
> I don't think O_EXCL is at all problematic.  ->mkdir() is already
> required to return -EEXIST if the directory already exists.
>
> >
> > The problem is that some fs (overlayfs/ext4/f2fs) register
> > a mostly-noop  ->d_revalidate() so I proposed how to deal with those.
>
> Presumably the fs would provide two dentry_operations structures and
> choose which to pass to set_default_d_op() when creating the superblock.

Yes, either that or clear sb->s_d_flags & DCACHE_OP_REVALIDATE
when d_revalidate is not going to be used.

> Doing that would even provide slightly better performance in the
> case where no d_revalidate is needed.
>

Very slightly, so this should not be a reason, but advertising corrects
contracts to vfs.

For example, if overlayfs would want to install:

static const struct dentry_operations ovl_dentry_real_operations =3D {
        .d_real =3D ovl_d_real,
};

It needs to know that none of the underlying dentries is expected to have
a d_revalidate op at super fill time.

Thanks,
Amir.
