Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FDF30648A
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887017; cv=pass; b=RSzhhDpJ6gMCu5eu27FjBpni/AAhRTw1mDp2VhRigtV39bDQaXkO+MD6cbtNLykjKRYcX/xLRPmR7TZ49/lgAtJ7bWVi7c8IM5LfARY6RCZ0rP8tGUbZWPdE2Sor3pMWnU/yZXN/H6Sn/VOrBazzRu0jEXe6GvCPkCRJd+2g1/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887017; c=relaxed/simple;
	bh=7K7tZs1hc2oPZ1IliccEThEHd45h4scRJ4SOua+rVr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQvt/B1trw1QZ3FLpBR/upa4EZaLEk4LB2KMNqg6KQTR6HezNJW7U4RPWEaCxYJhg18mXmGCzXMelIb+jtoyn8aK4VAfuWtMX/w72QJUv+I29ba/asiBGxVvYJ9eY0/SjZdo3a8lTJ0dYBdUvCt6YtAL364+8I+7FzZjBZvbfn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlKRCvy8; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlKRCvy8"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso1020495a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 16:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778887014; cv=none;
        d=google.com; s=arc-20240605;
        b=JwtKe0Rb226dDOFrLxnsL3Oye5N41YF1bC4GLYJBO5+mfyHCM1TxHKn9WSIMncF1Mj
         acquDh1U8ac9UkRJyOWBDQ3OlRghs85FMIovJZPtV0/ubMNdVK4xJccVyld4OdH/XGUh
         UKekMWBHQricR8DntlGO5QHf3ZfVmTg5rRpstAV12dJVZMIgWjCAsxq1I2rCST5Hsbbz
         Stsbfw25PRJSR1xLW1iSc05vUVdxNi8r53dnsyClOBjj3l1B4+zkNu83iTj4s9+eFWni
         He7ZAE/ClxyGLEltez5z0/XDYebsKE6Kg+Y5wvi5eNzp/8jPFXDKvowH/zi4zLPs447j
         CaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZyWunBeeWyIIt7WsSCYZEVF16khRNOvYgYQosGWQv54=;
        fh=LROgA5nYSawgJtSdj4Lfu48Su4Nz9pGf5x4LXPN57xc=;
        b=jFc7OARhbpABBQN6BbrxgFhdjNO1P+aXWt1i5ltyOzhbj4eRneeYdxArytAsAQILWx
         GpiLgq3NauZax/qflbdTE0kZ8avR1CL/90uvzhL20L3H0CvmO4MxfTRtpjQ6dSQXFbi5
         h+W9NK0wVnkp3ASUqX5bE+MfDFQi0u8reGCTAn6nI5YEiwQGyq5AWoj8G0BgGCRMlOM6
         tVfRJ2LOUd/2dRRcmNb0gnma3TSrX+UYGFFrljWhF4gE8A9FkLtKT7n2PdZFuFkB3os2
         7pHNIY3X5UW9Krb+aaR+BU4O39gm5rjH4zWIb8A44r+gsbtP7qdce+ZhZvu1yPOm8AXu
         1vHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778887014; x=1779491814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyWunBeeWyIIt7WsSCYZEVF16khRNOvYgYQosGWQv54=;
        b=IlKRCvy89qkGu/d9F1leZRK15AgBvr4qYsGUx8ptD7IWIEPi5d59EBjbx+MOhUeIa1
         pzDbtxSHQ1yuJemdnXrlLTD+MzAbZWNvzc7hOKLOSvtUWpGTNe6Zr9GI1e7qQbl780Mu
         Sk/SX1VP2w8T6r+3+d697eJbk+Ca16UhbKZ+JZmz68lDVGF990raNHdJ9ZMC0zUdTDV+
         6riehHcC8roxWn4Y5mtAF/Qg1ri2d3RsiXGw+d+8msWDKbVBNV6oa8j16/2zylk2020M
         9iNk7QWnyjEfvpU9XxMQvMVfHp3fxvwYgg5hq+g+93Aw+MbqOOF90xZCK0Ip+8wn8Ted
         l5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887014; x=1779491814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZyWunBeeWyIIt7WsSCYZEVF16khRNOvYgYQosGWQv54=;
        b=CiRSg8/V9uk18fiPPqum4jULtf11DaPvPnX5y4l2ghnUKP7zLsRyukqkay75MDPET9
         MFDs7RTjumxbPq/2rs9GODoYwRAaL3ErqbIJSIOyg0PWPBsQjmgdUM9+9N7wf2Z3Z4Fg
         nz9fC3LKSEAo5MH8VtH3wfNAQIPOt3U/w/tPvb/EbUseHwXNSp9dK/B5TTQwkCmKqu3I
         SJqE8D3CH3qQKVGDJicUg8frFn/XfSagdaSCav1ezPj9RcljA/tI3VLwl4GOMyfDNWIU
         rY9HOni93gty0z2+QAKVSXNFJQZb1AQGtfqcDplFkCdcbjeA5yMpr8umXQgE/BsTPBYA
         b4WQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Z9AivyHBjBiWAsztwL6DUbS77EDjocbbh0du/qTGEOojZJ3uT1XvXX1c+L2Qybng3FKbmBgAA7ECSmU96@vger.kernel.org
X-Gm-Message-State: AOJu0Yxufe4MetOjC/PcGUAOwrdAGzv6M74NiGaaUI/ehpSjxUdkGC4D
	DLF886ASkRaP9SwxP4AwQVuBAxdMMwIbTy7Iv1Q5T8rQXDqE2G5eH4aOL4NUgYogN/eXvn7LwV2
	1EZWERcv9Beo0NGrlMlemDPtBFdL/cLI=
X-Gm-Gg: Acq92OFWGwJ2RGkz6dFIBqyNGvVmPUIzPsi154uwKD2qu74XS/f2vaX5lgPo8f8YbKn
	pUJ1GfXX9JTvCvB6DF92DgNpTNWhFJ5RhcgngMd0q1TDDG2LUa0w3bV+YQP+gb2Em3QwKh2lf4t
	+9UMAfLnNGAFlfzzxwo5ELL5fvJVsy0Fj+Anpjdnb59kvGQzmPm5BSabZoanjddSyNbBYWpIzMs
	Qal0wVCw3tF6LK8ekmeEa4LfLV+EUb174Cvxf43ofs/f8WYpQG/lX2lTbK9clBLn6PA2QIeyVkG
	+eI5W3AErZTA6hB8bVIqzr9QA+Ss9OLKNU9r6z4SzayNNddtJ2bL
X-Received: by 2002:a05:6402:26d0:b0:67c:1ed6:2793 with SMTP id
 4fb4d7f45d1cf-683bd19552dmr3139618a12.22.1778887013598; Fri, 15 May 2026
 16:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206510.4103309.7610933581068572895.stgit@frogsfrogsfrogs>
 <20260514220921.GI9544@frogsfrogsfrogs> <CAOQ4uxja1znK3pz3YAX2uFM-GFVS1zENHJzHBLAVrVqcz6bVhw@mail.gmail.com>
 <20260515213600.GE9568@frogsfrogsfrogs>
In-Reply-To: <20260515213600.GE9568@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 16 May 2026 01:16:42 +0200
X-Gm-Features: AVHnY4KSrjVIm6SZja-smaSbPRCng8_nCZOGO6mkeeft-946xvHHrpupCHsPgyo
Message-ID: <CAOQ4uxj=ynNdzncciLP=caZD9UgUWn5Ebch9NOOzO3btrgwBuQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] fuse: enable caching of timestamps
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 11:36=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
...
> > It is so easy to get lost in the code handling attr cache coherency
> > between kernel and server, so many little details (a.k.a maintenance
> > nightmare). It's not great now, and becoming worse with iomap.
> >
> > On top of existing writeback_cache special casing and now iomap
> > more special casing, passthrough code also has special cases
> > that may need to be handled better.
> >
> > Can we maybe abstract some of these open coded checks in
> > a way which is easier to review?
>
> One way would be to decide that if the fuse server sets FUSE_CAP_IOMAP,
> it doesn't get to use any of the other functionality -- no dax,
> passthrough, writeback_cache, submounts, or anything like that.
> Whatever the fuse server thinks is its dataset for inodes and the
> directory tree, those are the *only* files you get to have.
>
> The downside here is that fuse servers lose a lot of flexibility, since
> (afaict) you can have a fuse filesystem with (say) a combination of
> passthrough and writeback_cache files, and that's why (IMO) the codebase
> is /really/ hard to understand.

You're preaching to the choir.
I tried to argue for this but you and Miklos outnumbered me
in the pro-flexibility camp ;)

I am not against flexibility
I am against flexibility "because we can"
Come a use case that justifies the extra maintenance (and testing)
cost that we pay for this flexibility, it will be time to consider it.

For example, passthrough and non-passthrough in the same fs
of course - we have a use case.
iomap and passthrough on the same fs - maybe.
iomap and some remote file that may change remotely - less likely.

>
> Then we can simplify quite a lot of the special casing crap all over
> fuse because I can create my own iomap-based file_operations.  For
> example, ->open becomes:
>
> static int fuse_iomap_open(struct inode *inode, struct file *file)
> {
>         struct fuse_mount *fm =3D get_fuse_mount(inode);
>         bool is_truncate =3D (file->f_flags & O_TRUNC);
>         int err;
>
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
>         file->f_mode |=3D FMODE_NOWAIT | FMODE_CAN_ODIRECT;
>         if (fuse_inode_has_atomic(inode))
>                 file->f_mode |=3D FMODE_CAN_ATOMIC_WRITE;
>
>         err =3D generic_file_open(inode, file);
>         if (err)
>                 return err;
>
>         inode_lock(inode);
>         filemap_invalidate_lock(inode->i_mapping);
>         err =3D fuse_dax_break_layouts(inode, 0, -1);
>         if (err)
>                 goto out_inode_unlock;
>
>         err =3D fuse_do_open(fm, get_node_id(inode), file, false);
>         if (err)
>                 goto out_mmaplock;
>
>         fuse_iomap_finish_open(ff, inode);
>
>         if (is_truncate)
>                 fuse_truncate_update_attr(inode, file);
>                 truncate_pagecache(inode, 0);
>                 fuse_iomap_open_truncate(inode);
>         }
>
> out_mmaplock:
>         filemap_invalidate_unlock(inode->i_mapping);
> out_inode_unlock:
>         inode_unlock(inode);
>         return err;
> }
>
> Obviously there are a lot of fuse features that I'd just turn on
> automatically if the fuse server sends FUSE_CAP_IOMAP (like atomic
> truncate on open mode and killpriv) to eliminate even more special
> casing.

<nod>

>
> Another source of simplification would be to make iomap/exclusive mode
> more aggressive.  In that mode, the kernel uses all its file attribute
> update logic and pushes changes down to the fuse server.  All the attr
> caching and timeout stuff goes away, becauase local filesystems are not
> cluster/network filesystems and don't have to worry about pushing
> changes up to the kernel.

Yeh, I suggested this in response to another patch as well ;)

>
> OTOH at this point I've forked fuse.  But if I'm going to do that, I
> might as well just burn the whole thing down and start over.  I don't
> yet have a good vision for how to handle the slow stuff like the
> directory tree.
>
> > Thinking about some attr_mask in the inode which determines for
> > every attribute, who owns the authoritative copy, server or kernel.
> > For example, for (writeback_cache || iomap)  kernel owns ATTR_MTIME.
>
> For iomap/exclusive mode, the kernel should own all attributes.  I'm not
> sure the current codebase actually *does* that though.
>
> > This is very hand wavy and far from dealing with all the complexity
> > in every specific case, but the bottom line is - very hard to review th=
at
> > this is all correct and nothing missing and very hard to figure out
> > what's going on when looking at the code
> > for humans I mean... Codex seems to be doing well ;)
>
> Not really, it's been hallucinating from the start.  That's why half the
> comments are credited to codex, and the other half are the WTFs I found
> while scouring the codebase whilst trying to understand what nonsense it
> was telling me.
>

Ha ha.

At least it is doing review :)

Thanks,
Amir.
