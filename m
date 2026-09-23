Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5951DAE6
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201646; cv=pass; b=Ipkmbw70gVxPfliqf30jpy74SCvchIl6peoBB/K7S91z4yaFQVIoGKWtjRGi3Ydp0bcqJSJzhRaGDlU1fVUi6ZgKJVZZ4emnP3ZU0BCIEaDVYCyv5CIE7UK7g/dPv1jbUrqmzYU55BVBadeREdhm3g6MdChw+B6rCXpQeZmtDsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201646; c=relaxed/simple;
	bh=VEnChpsmZnLnP1dBy4G4iI9kzuFlgR20LU2PM96Q9xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbztChVyhIfsa/Qb7V305aBsZ/3reb/2Wyk7AjmjUCAoa5+Sj9KxdHXyJ3LkuPMvqMMCdNA40Ic1/ox4SkRSG4+zCpu0tf1ovC87ak7jKAmQ9CRX7uvAExKic97b47XwfbXmYtLUI2pwiuS7UeatrZsYSm2ESh4G3liotRrcacI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfTgCbDu; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfTgCbDu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so7552165e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790201643; cv=none;
        d=google.com; s=arc-20260327;
        b=Q4zwo6OuWOIOdc0K7QuKBTmovJjO/80mYZbqtKidwY8jpkkwUIeggmGUTjH33etEL6
         +yO9VdNnCKv2ZzGxLGqaDeryicD04/4i2QT0dfGCRdYWx3LkedQlczoaeHOmccuIQqIf
         lvnxAQuqxG5AxtNaoYovR9J7PkGQ8PTW2Z3xMxP6Ah9GI/43kUzWgE2rliQ0m/XKtUBy
         gjvKG+meznT1+JOoNTteEoX/zkznHjfCu11tI+K+iEJ22THKuyf4G5F7Mhg6sff8FLcw
         hq9+3h5q3MvSWhaWZ5ppNXsruwcKwVQCJcFHjwggbqXIGfjzYGnvZU1E85uIznfGsbBc
         yWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KGLEeue3o5yKWeja6+zG4Xk78pYqVNcln7LIJb2Z8i4=;
        fh=qs01hgMjqeQWut1g9qzQOgtEJNQovamq162HMgS0XN0=;
        b=HndHB6yexIFMuv9U5hO6jQJMa22j0rFLh5ENIn2+WpErX7jFkRL7iCSmhkBC/Q0N06
         ownG874qpag9hl10OrUgW++mhW3PXfQK/+4Po/YY4h2QtmOIEh0K+oYD3pdnYFW68kUh
         EKk5RCx0YWSOjU4WEFvaCsjw9UuGOuDGf9lPuip/hDciXpJlGLCYQooLKtapJpgssWFl
         RI+XJQZt870Yzoca1z7Ju54bVYsenjHfX4ijv3WGbktW2aThbk9yn+I2TY2KE3ezKse2
         Xn6CVcw4RXySILTRnDMSP9xz2TMgGI9KUETporKrdjd+wnbOWwkiPCgLv9ZmH+0jpnDE
         pmKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201643; x=1790806443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KGLEeue3o5yKWeja6+zG4Xk78pYqVNcln7LIJb2Z8i4=;
        b=GfTgCbDuvfxBWCF8GV45GznkemRihgKzFxp2uXdGZcfTmQkFZnpKJ4/vytpeGJT5LN
         drEx1EXvhm1HuthdaVEAwLlxhph4jINldfVBfxBxU5UkIcNUoF7Jd9j8LrgxBoNYvKSm
         zYMunNGBHGdfibs2qwUMW7C4JuNECFk/6kqIOYfPUhLeIEC3vxNjGaNSVCmRYW9gRpha
         iz3L4JaVKjiPkIYxbySLaX8QguWHeeGLHiJ5AEX0mIFyhnA4L8U1ojtilwLb2xkfiLE8
         cuuJd/CRDfbOPHQqJ3kJ871Zwip4iPra2NGR8CLfXAKvZQ4c2miPBFYC47TxOuigF7Q9
         17jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201643; x=1790806443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KGLEeue3o5yKWeja6+zG4Xk78pYqVNcln7LIJb2Z8i4=;
        b=XomZOWb0I6kHFvem1mXx7n116vDeE0cXx1XfJvm3tSvBQz+AWLMh0AkqucBmwICxog
         lBpgWeq/4sVtOl6++OQOQp1xhzHjAI994tsYLNP5a0IYpBRmt+Pc4xcta/tUlQCZGt/s
         LR5v2eg8D/d2Tv7xELkGdwxqI4HGhWVTAKpZAiGbro1+4GtTkXUjkZX7Yxyi7tdBq9wI
         QK28ay63rCy7V9Pt7siJHC16hXk3HRablyWFRHqo+sgl/pWH2ieqFDLWJoygT5rjX8V3
         HDkdrW1+CEYBZ+fSPUVx7yFRvh1aXQ/BDaxdeAgmFTFX6CHd1OqsdGk59lWSvse6Sz1U
         cFOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNPL4pe8JzMgYXJr8EhwQHAoCgniAiEHB0NdBIuWWc9eM1bvcpFTUjE9hwb9/s8ixwmFK/lsHNwH6sb26d@vger.kernel.org
X-Gm-Message-State: AFuF++lZG/EV+hS03IOSNDUq7Le59lOEZhdqf3lHUmwi42MgNG/Wy4bg
	Mj6+NxeeUeiHKBjVLtsRUniYSzPRmLWpXbKyT1Gk1yG1p2yIHPZk2w7XNy0Rt2CeBw3Va5qiqrz
	7D73EXSyQMx7F4smPcraXWtJzJ7XY+4cy0D5K
X-Gm-Gg: AYBFou0AZZ+rAjsziPmiKUK+RLGrPoNNHtZYOmndU9sFKn4qr8U8i/lGlPOtQh+f1l9
	iqPYQwt/fcmRf4vQ0wZuf1D/St0QPrtX0v2LHdFcXbzkRDoN2NPkCiMWDnuPbKlO+R3TQze++UK
	mr1n8s/w8d6fpuIIysnv2hwmkA0tIUsNQ8eSmfGAGyrT74EMA4GxtijOtDM9yO/EpEdtfJSiXJe
	3L6hCRneAzrzQ7RcJvCRh35MiVSZ6kn3tlQs9oFS6qYJzhJF7sOMWtg3xWluPcb0FPa9AjgGzxh
	Q63bp7LvYMteFCHUAf68/KEmCVVEJ5zpEmaCyq+cqWdWkPtxojb0Gmue
X-Received: by 2002:a05:600c:6092:b0:49e:7c4b:1753 with SMTP id
 5b1f17b1804b1-49fe66c6365mr7426965e9.12.1790201642420; Wed, 23 Sep 2026
 15:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKLmikMHpPdXmyPMPhad=wc_HerzCv3wEtp4s-E+NrjvuHj3pA@mail.gmail.com>
In-Reply-To: <CAKLmikMHpPdXmyPMPhad=wc_HerzCv3wEtp4s-E+NrjvuHj3pA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 24 Sep 2026 00:13:50 +0200
X-Gm-Features: AclHuK9uQV0YZ64bMUIZGVpEnfZ0aF3hCogiPdo_WisrICJyffPdznMyA0u7a6M
Message-ID: <CAOQ4uxhx=bhNQ1G_fzUTtJexUpZANP1yBu5rK1Q0u4fk53umMw@mail.gmail.com>
Subject: Re: [RFC] fuse: temporarily detaching a passthrough backing file
To: Mitar <mmitar@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:23=E2=80=AFAM Mitar <mmitar@gmail.com> wrote:
>
> Hi!
>
> I am writing a FUSE filesystem which stages what a command writes in
> layers, so that the changes can be reviewed before they land on disk,
> and I have been looking at whether FUSE_PASSTHROUGH can serve its data
> path.  It cannot, and the reason seems general enough to ask about
> here rather than work around locally.
>
> Once FOPEN_PASSTHROUGH has been granted for an open file, the server
> cannot take it back.  FUSE_DEV_IOC_BACKING_CLOSE removes the id from
> fc->backing_files_map and drops one reference (fuse_backing_close() in
> fs/fuse/backing.c), while each open file keeps the reference it took
> in fuse_passthrough_open(), released only when the file is closed.
> None of the FUSE_NOTIFY_* messages reach it.  Granting passthrough is
> therefore a promise that the backing file stays the correct target for
> the entire life of every descriptor which gets it.
>
> There are two situations where a server cannot make that promise.
>
> 1) Quiescing, to make a consistent copy.  A server which snapshots,
> backs up, or tiers the files it serves needs, at an instant of its
> choosing, to stop writes reaching the backing file so that it can copy
> it, and then let them continue.  With passthrough the server is not in
> the write path, so its copy is torn; fsync does not help, since it
> flushes rather than stops writers, and the only remaining option is to
> freeze the whole workload from outside the filesystem, with the cgroup
> freezer or similar.

How does one make a consistent copy of a file in FUSE server
regardless of FUSE passthrough?

What counts as a torn write?
FUSE server can gets part of the write while other are still in-flight.
I think you'd have to at least have fsfreeze support in FUSE, or something
like this to even begin discussing this use case.

>
> 2) Re-targeting.  The file which ought to receive writes changes while
> descriptors are open: a cache evicting or promoting a file, or a
> stacking filesystem redirecting writes to a new layer.
>

I acknowledge the need, but as you write this is complicated.

> Of the two, (1) seems the more general, and it is the one which does
> not depend on any particular stacking design.
>
> What both would need is a way for the server to detach the backing
> from the open files holding it, letting io fall back to ordinary
> requests, and later to attach a backing again, either the same id or
> another one.
>
> The io path looks mechanically simple, because it re-dispatches on
> every call: fuse_file_write_iter() reads ff->passthrough per write, so
> clearing it would send the next write through the connection.  What I

Certainly doable but I wouldn't call it simple,
It also brings odd semantics that the same open file (same inode number)
can read two different contents - not sane semantics).

> cannot judge is the rest.  fuse_file_passthrough() is a plain read of
> ff->passthrough, so a detach would need something to serialise against
> io already in flight, and the io mode transitions in fs/fuse/iomode.c
> would have to be driven in both directions: out of uncached io mode on
> detach, and back into it on attach, with the page cache invalidated in
> between.  The kernel does already perform one such transition at
> runtime by itself, when the first mmap of a FOPEN_DIRECT_IO file
> enters caching io mode.
>
> mmap is the part I expect to be contentious.  A mapping is bound once:
> backing_file_mmap() sets the vma's file and then runs the backing
> filesystem's own ->mmap, so the vma ends up with that filesystem's
> vm_ops and page tables into its address space, and nothing in the
> fault
> or writeback path consults the fuse file again.  A detach which
> covered only the io path would therefore leave existing mappings
> writing to the backing file.
>
> For (1) that is a bounded loss: only a process which mapped that file
> MAP_SHARED for writing can still store into it during the copy, so the
> copy of that one file may be inconsistent while every other file gets
> a clean cut.  overlayfs documents a comparable deviation, in
> "Non-standard
> behavior" (b) of Documentation/filesystems/overlayfs.rst, where a
> lower-layer file mapped MAP_SHARED does not see later changes.  For
> (2) it is worse, since the mapping goes on writing to a file which
> nothing resolves to any more.
>
> So my questions are:
>
>  - Is an interface of this kind of interest at all, or is "a backing
> is forever" meant to be part of the contract, in which case it would
> be worth saying so in fuse-passthrough.rst?

It's like that because it's too complicated to deal with the consequences.
Unless you prove otherwise...

>
>  - If it is of interest, would a detach which explicitly does not
> affect existing mappings be acceptable, documented the way overlayfs
> documents its deviation?  Or would mappings have to be handled, by
> walking the backing inode's i_mmap, zapping and re-pointing the vmas,
> for such an interface to be considered at all?

No, I don't think we want to go there.
and asI wrote, even the semantics without mmap can produce
undesired no-standard behavior.

>
>  - What shape would be preferred: an ioctl beside
> FUSE_DEV_IOC_BACKING_OPEN and _CLOSE taking a backing_id, a
> FUSE_NOTIFY_* message on the connection, or something keyed by nodeid
> rather than by backing_id?

notify would have been enough if you managed to make the
detach safe for races.

>
>  - Is there an existing way to get either of the two behaviours which
> I have missed?
>

Not that I know of.

Thanks,
Amir.
