Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392B3ACF10
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280717; cv=pass; b=POGlGcaRGU24Q1ZJWpzoCwUEy8c9tZOjRiAorKiACKsCjNEhPzhsSPqNytrCs/HljfVsiK6YM6xwaZwihQrhT9pRz9zZMLUFwyR1K4Usi8r073zpBxGiV3p6zJfzVc71xQDR6JedY9TTv3moKO/PriBBzc9hNADehbdpXDes9KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280717; c=relaxed/simple;
	bh=a5WlGur2x+nU1ZXEt1S7Pr3BhzTo07kXxugDtAVEEhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCghcW+JZkorkpoo5elOxmpwwZ0gd6oNpwWdDF1adA+s+phTbmoNRPKmlFGgo+IHtPBXr0VhcEQT5URsWA9m3pw9+RC7MqU2KNazS+FUupTti8S6Vsrfcq9AQH6I04lZBjVEwbq0MAQPdj+07jUMtY6+gaXs+pFRHIWlUesyQwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeVsCtH9; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeVsCtH9"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ba699316b42so1226031466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 02:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777280714; cv=none;
        d=google.com; s=arc-20240605;
        b=J88ktwrNuD0+tKT9okCByeQYrrAyKzNFphPyswMIp15y0WHZRlhBfZA46CMCbNnDzr
         Ik1zbvGZrwCTrhI5xRW9W4sgmE/USnDkly1iPG8O9iO1bvojQBM4ZlDH1rAkH90iifuk
         aEaysBb8wK2IjHJJA3i4lmzHAZE2ZP5ofKKAllUkPc/md3OaU2uYH2MY5d4EY7E0+4Gy
         m9vAmust5IWrXj1mPgo6I06QO3/mmiy5/TcwxmqThnHotdNWMPCJIzG9BZUj8iXWA1In
         XDuYOTp4DeYD8mNomsSG/gh3Jf4MarnhSydJ5ofD9qZVjYalLUOy987869O8wXWWEgyt
         Hkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BGupVN5az5s8pFT8H0NZ4pHuG9HKT10qjTmw5QNkxIM=;
        fh=7LsvkxWdqWeKjV6YbCyermYvthabHKw8NaftqFGG2V8=;
        b=K7z2Gkfi5M9kEH+JqKIufWgdzSrHyVtPa8CzyHPYdQayCJ9+0e8Wu453k1RZcA7gWJ
         FdgVxhFkuhl/BMJhNO29BNGQ/jNHQ7zVhv4usP3ijGWRnnai8gCuO3AEt/ixQtqhnGne
         YEJWLwmYKgQcoMmrTom/De7G9mQ6tj+YErWaMH3k5FsIL5+wnFQbG3QKXxnBRa5yM3lP
         mIbi7p5m/lfP3ZYWrFE9eRyd0nyrqV6BROClWDsoOnsOa9g36blW6kGQPo7WF6IXTwgT
         nSM0CdwHG++YjPeMbogIcrVIIFG+dVnwr9vQNDetRxFoxLSu/W265DYQJC1fx953rhvF
         0LbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777280714; x=1777885514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGupVN5az5s8pFT8H0NZ4pHuG9HKT10qjTmw5QNkxIM=;
        b=FeVsCtH9PneHPhOEcOJCpacTtqhXnJHPtiJ4+PawigBG+gw6FpulourYIBqe7RbI2E
         QaBFIqQPJ+GtuyXwafgn8USJGEwOpU5XkKvFghsDHa5FV1PlkvFMesDHwbR4rGJzjVKM
         UVb/q2WRcAyFA4NShDXS9Qbcsgm4b8L90wheIVFcTIIt7quepxV5GvYIJUTgXM5s7lAf
         qkKxHJ9RU8YsMvPbFyDpfb6y6x9x6cIcgZ7KSB89hDAbe0ZYluKs/GrQEki46kHwhhNo
         +/oqHS2wFahQO5WlgIaBujyRMgbEaxxanXNdLDWiPfDqVJewL5TxJgE4hdtw5t8ulwQ2
         M04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777280714; x=1777885514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGupVN5az5s8pFT8H0NZ4pHuG9HKT10qjTmw5QNkxIM=;
        b=BsWywoxpRFX3D2QfzZGamd30GdcJUE8vuA+r6q7f55G467XMuq9Jkp0rWrFV9rqrPV
         hQHm2zLN0UKAvNFmAB4OJJcUiBDe9bm+sUO4OolDAaw8XiIhV/EKRX1VxBk13fmzMyE5
         w67fQ2LUeY2rTKbLEKMF6Dsuu7yKnOrMbs96RTn+rCorjbhR6jW3ldcW89Gpie6+y5c8
         aN/a+5HLKSF81/EMwtLn9zTys48LywhwhAFyyJWytIy3YKMaznGyyhKfTaM5q8JwQmmt
         M6dbgKNnkLxJ+FgeiptAf//6ibpGAWvszXoKSA3e28brSpfFseeakboFu6zWkI8PQXN7
         KyYw==
X-Forwarded-Encrypted: i=1; AFNElJ/jE7KIrdDy6TR9Sc90bStWzv5b2nWYqtIbrYSmqotsRKf+RSswVw0Te/BJnbv1CZbDK0+wh6s9Fo6ABqvL@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJFWPOd6kD1/4m1HBzCGkz40rVAfm0c3nLmnI9AEBetCgVcIf
	XIre2I/CCnWy5J+mcmkJmO2cxa5XB+Gft2/Vmex5VGWv7ZwhrjjPEmyCQLqAotATIx7nwh0/bcp
	6Ye06thsMsICZeS3JBHCpct5T1mjFRtI=
X-Gm-Gg: AeBDiesVQ+LuAwPYtnV0aAKfVukICXlye2l46w2m4bzBO+/iqE0pQlthzOWalXVX42b
	LG1/Skv1wKm1o9sVfhO9eJkjt2OzCjxrWQ0urkUrj1AhzHvzGussGfdqnO/0yGm8Ilx1sIDwc+n
	nqQpGmdsYFcrDXOCGRC7MBJm3FUt9gBynqdgbsCVwWeDvpdRUX5rHh6jQ7yxsdl1wccOsUW0Fne
	o4c4nDzST3WBo34nRUshshdPw1VXMGt4NZ/Kkc1vaU47V6hYsPJtATX6WRDUgqRpBGXDtqPbSY5
	1rOiu7BhLUVU24MengeMYL4HDmElcEX4pzT5OdREKtrgDyE9O6xLS1r6e84ZajY=
X-Received: by 2002:a17:907:97cc:b0:bac:75ae:ef3d with SMTP id
 a640c23a62f3a-bac75aefeedmr894007366b.0.1777280713694; Mon, 27 Apr 2026
 02:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-8-neilb@ownmail.net>
 <CAOQ4uxi8rqkbhK4=8N1ncfU1m6bjdHLbinSf=j3k0oVEaSa-wA@mail.gmail.com> <177727962988.1474915.2841674553452335690@noble.neil.brown.name>
In-Reply-To: <177727962988.1474915.2841674553452335690@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Apr 2026 11:05:02 +0200
X-Gm-Features: AVHnY4KY3DGiJbeLpxnNIOueb0cG8ugd69Mb3NfCiVfs_OCISzp2jPWuCU1oOMA
Message-ID: <CAOQ4uxiMUKHuGwpSkD=M4Z_QLxHn7Os9vaaWqAWd36HdfDRYuQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/19] VFS: Add LOOKUP_SHARED flag.
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:47=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> On Mon, 27 Apr 2026, Amir Goldstein wrote:
> > On Mon, Apr 27, 2026 at 6:06=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > Some ->lookup handlers will need to drop and retake the parent lock, =
so
> > > they can safely use d_alloc_parallel().
> > >
> > > ->lookup can be called with the parent lock either exclusive or share=
d.
> > >
> > > A new flag, LOOKUP_SHARED, tells ->lookup how the parent is locked.
> > >
> > > This is rather ugly, but will be gone soon after we move
> > > d_alloc_parallel() out of the directory lock as ->lookup() will *alwa=
ys*
> > > called with a shared lock on the parent.
> >
> > Neil,
> >
> > Forgive me for being skeptical about the *always* part.
>
> Scepticism should always be encouraged.
>
> >
> > How long ago did we add ->iterate_shared()?
> >
> > It's true that Linus eventually got rid of ->iterate(), but we did not
> > get rid of the assumption that iterate_shared() might be upgraded
> > to exclusive lock.
> >
> > The obvious reason is that *someone* needs to do this work for
> > old filesystems, which are also hard to test and nobody wants to
> > touch them.
> >
> > I have nothing against this patch, but I think it is more realistic
> > to state that LOOKUP_SHARED is here to stay, so if you think it
> > is too ugly, maybe there is something to be done about it.
> > Personally, I do not see the ugliness though.
> >
> > Am I misjudging the situation of shared lookup wrt old filesystems?
>
> Yes.
> All filesystems must support ->lookup with a shared lock because it is
> already the case that with a simple lookup only a shared lock is provided=
.
> A filesystem *could* examine the lookup_flags and deduce if the lock is
> actually exclusive (e.g.  if LOOKUP_CREATE is set) and misbehave
> accordingly, but a vanishing small number of filesystems  (NFS and ....
> I can't think of any others) ever look at the lookup_flags and I'm
> certain none do anything so ... creative.
>
> So I'm certain that it is safe from the filesystem's perspective to alway=
s
> call with only a shared lock.  All that is needed is to change the VFS
> to only ever do that.  That means separating the lock for lookup from
> the lock for create/remove/move in directory ops, and one way to view
> the current patch set (the complete one, not just this initial set) is
> that it does exactly that.
>

I see.
I will remain skeptical, because there is always *something* with some
special filesystems - think fuse servers (not under your control) which
have grown to rely on the kernel to serialize atomic_open() on the director=
y -
but the level of skepticism is lower now ;)

I mean it would suck pretty badly if locking order would be fs_type dependa=
pt,
but honestly, I do not think we will be able to avoid that, so we need to
make sure that humans and lockdep are able to understand the different
scopes of vfs locking at least per filesystem type.

Thanks,
Amir.
