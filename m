Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB0346FA6
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621312; cv=pass; b=G0QVnulykjrzZDY2nFG5zk6LFQaQpjWFJKsPibKSDCFdg5Bvu0JKGRL+5yc2L9E0naxbryNsOrgZ/CQCDnbpfxR+RWN7JVYIO8xFMR+6SZ73CJmTzI4Dorl4BHk+FKsdA1Z4hFq/A+sSEIp7CO03Q2nQb0cHb2fAqx86GW8IuVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621312; c=relaxed/simple;
	bh=nTlNsEk0CFiqzdQuPbBiOZNXvOgKfi+6NZO/Edlv8wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlJInh571ybMCi414Y+useniVy4HcARj0EXai4NsxwOT6+aoY+whlOQvCEh3JbQM2yhZ5vAXI14pHLqwaPMkoPISsx1mP91plx0QOsipzwAN5khN/ETydUqf5BEH+T7oPoEUKI6Q6KDDJFTqtnAStc6QjtyN8J21uBB6Qffqp90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no3mjUOx; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no3mjUOx"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so10228912a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 14:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778621309; cv=none;
        d=google.com; s=arc-20240605;
        b=EJt/2Fk8nouU0djS691tc0ZLk9gbqBtIi+paqskBQhbaAxLJKF4mnQApjnj82paahO
         bs4VdKu2MoibAZ5bQ1bgm+YvevBZWTLrzGUjn6G0fPJzh8TwMC7YUNlwyQELJVdZoy8X
         H2a+zK9fTyFoOwQQajhWnlFtLX+cvQxTCcHPvdjhyvB2DpfNE4v/XT+nxOmIH4l8AQXv
         up81yoYUqvZgBVpTLq7BYLxxeLyC2k/dL4dykQABNzSPrxZb9yPtg+9j/1lOn7CPkmsw
         SYHUE+Oswja4vYOJoT88bPNY0e8EhVGc2SliW/KSoyY2tEglt95TQOdL132Dy1RJfv8C
         JfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSBPIsvIO46UuO2xJPqVuu2fMYhRVSRYA+smdqfJCdc=;
        fh=pULW8h424uFCPTSHiGXD6hMmY4Gj4vSfIryIqpfW2+M=;
        b=U033g/J9NnrVMwsArWs/SLVuQkeS5acgyCuTEYsFeR30NC0sEdpHSmw+NMnsVeArkF
         FqMGrYFdyNnozhfzf4Q/tp2XWIshWDS3wY1ERhON+vxZQiWyzmOmb4bPuquaD5Ws06X+
         2f6OGT5Fg40a0GZGn0KCyYvkNoasSiTt0jxnB8E6U4QK8Mxw2Cs5f42t1jxj6B6/5h8s
         HQYkfEZ+JAzufeUQClLF9nm+d5FxT+s4zRLFdfS/rxiKvEoENGav5JNGRxnmqmyLwIBv
         C7ogwioTxIzDYqQf6YTWE+dYDQR5c/Afn/N/p/PWDn8hwdhI1x24950+yfUxRGC+8SrX
         FisA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621309; x=1779226109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSBPIsvIO46UuO2xJPqVuu2fMYhRVSRYA+smdqfJCdc=;
        b=no3mjUOx+C1VehRWs9gitboLW/gNcrWPuUny/67ci+lccW20ccq2vXkKcecsNbqcRE
         UndlSJr2KVIILa5x8BznqzWmUpkg+iBILCr/Z4JE71rPsUIGg11g3F0FvANDID1pSMib
         zFr4iLVW4yvvvEzxVb2xzsE4xIk5XOrU8QvqEd/DbU/dyVF58io4yg0fovLJnXfyE4Df
         hVaRzCB89hb2XvjIpKdnRxC/HdRbFogq7Pby9fat3s6FYMBJo/eRjh3D/qSihHnq9v/U
         CBI0G/n85oSYk1dfY6IgwP4qgQb8QJGm9TlaaY+OLH3SYQjewSPjFdjf/MPfgCviwzc8
         zI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621309; x=1779226109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSBPIsvIO46UuO2xJPqVuu2fMYhRVSRYA+smdqfJCdc=;
        b=UpfmrjGA/X7y+ZyFQ2MEN3L19Ix3foQMua4zVBMhKvD8ZMLlBQHGPdlCdrxvdpwhuP
         N9LwwDGokrw/QLx5FinGsXS/UvDzLPTTn8hJHXSDFEX6NWyc93tXDMXZ5NqNaqqgEfDu
         bxCp++fwneLopMmLjn8IELqEFluur9BKRjkcscDMcxahBJcCjWkUwx75fJW2D/k4H6Oe
         7LJcvp8bCxzG1235EhtHTtHM6gs9hE0WCtYvM0uz2DsqGtnvpcxcgnzb8e5GJbu5puMF
         75xmVkclDXwdIEfbtJ1v9Y52gaghI8PswhzdWLRb/WoSZl0so0uc4BEfvbzba60mIljy
         sM/w==
X-Forwarded-Encrypted: i=1; AFNElJ+7zVBuGPuxNfEC1b22ew/i0ZZ1n7W9r+kJjpVT06AVXTLjIFqqFzd5bkfBQXOqlF1anSjSy7Ffr0vVvbth@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLoEv4NF9YK+FD8K/IUTsIoIasBh0BG11uPPmIqaW5YnDFcaN
	kxzk9K5/zGecCuTyLaWRKm+R4QgqO4sjLCvnZdcNOUMVsNS80HtKGhye9u9WFUDw0qXWvvnWYZ4
	A/86kGf+V8fBy78k87jvSBEXKA3bMAPY=
X-Gm-Gg: Acq92OFMNwFPMAzMm5VQXxyc+IpEkP19cj4OygIv9OlrtMhR0VCFNAgTkUuhqNZe1/O
	/lR3XJ1gqb0+LVbdtRf2QjhHSBbJvcP/0p4/ynUnb83rdRerQbidx4YAoT1CVJ2gscq8AJyXzFz
	ntFEnFYs56C9FlSPf01mG99N9U19Lqy3FFQTUj5d/VWMn6X7jEdAwSVWdXGtMYK6a+B3fAxnFQb
	jxcSB5yRScIg3HuoWkVnJm8qbhUJLSdtYyCK0Q8WbUNdFjWBluc7jTVXBpNYC+uW8HdCzhxfA4x
	KembthPoZ23zxiKspDmU+CnGVSXbuAN+ptpvBsfnoXZE4Z8L8fM=
X-Received: by 2002:a05:6402:14d0:b0:67d:6c95:9c8e with SMTP id
 4fb4d7f45d1cf-68256c5fe08mr179714a12.14.1778621308692; Tue, 12 May 2026
 14:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
 <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
 <CAOQ4uxgV4_Pet0w3f+Sq4kLkvgKM6FyJwZ4AQsnvctC3w=dP6g@mail.gmail.com> <CAJnrk1ZvB-R3Szn-VxOZvPRgX_dXwMLouBphnT9_URCE8SxTvQ@mail.gmail.com>
In-Reply-To: <CAJnrk1ZvB-R3Szn-VxOZvPRgX_dXwMLouBphnT9_URCE8SxTvQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 May 2026 23:28:17 +0200
X-Gm-Features: AVHnY4JCKqR4Am3jpmEEFUByOw47vYGALvukQFW2hpxx-rR9T8MkMf8cNVEBhEI
Message-ID: <CAOQ4uxidwSn69A08Urue7S7n8wrGQcyGuvRL387pD+rpSFP-Ew@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 9:22=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Tue, May 12, 2026 at 6:22=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Tue, May 12, 2026 at 11:31=E2=80=AFAM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> > >
> > > > * in passthrough: backing_fd passed at lookup/creation time only (n=
ot
> > > > at open time), expanded struct fuse_backing_map
> > >
> > > Yes, this needs discussion.  Amir may have additional info on this.
> > >
> >
> > Having the two different lifecycles (open-to-close, lookup-to-forget)
> > is by design.
> >
> > This allows the server to potentially move files from passthrough mode
> > to caching mode and vice versa, as long as all fds are closed.
>
> I'm unsure how useful mode switching is between caching and
> passthrough because the server has no control over when the client
> application closes all its fds (eg it can only react but not trigger
> it).

This is debatable.
My passthrough fs server coordinates state changes with HSM
using flock on open files.

Previous implementations used to allow using cached mode
until the file content is fully downloaded, which could be beneficial
when streaming large media files.

Current implementation uses the DIO or PASSTHROUGH modes.
I have not yet collected enough real world stats to know if this is
a problem for large media files streaming, so would prefer to keep
the options open for now and I see no reason to deprecate the
open-to-close lifecycle. I don't think is adds that much complexity
to the code (?).

> For my internal use case of switching on passthrough, I was
> envisioning the server handling everything through direct io until
> passthrough is possible (eg the remote file has been fully downloaded
> over the network) so that passthrough can be switched on even with the
> application having open fds.
>

Indeed, being able to switch to passthrough for new fds is a big win,
which is why I also changed to this method in the current implementation.

> >
> > Adding inode passthrough ops does not play well with this mode
> > this is why it requires the lookup-to-forget lifecycle, but I see no re=
ason
> > kill the open-to-close lifecycle as it seems useful for servers that
> > mostly care about I/O passthrough.
> >
> > w.r.t expanded struct fuse_backing_map, at the moment it does not
> > sound right to me to map a backing id X with more than a single backing
> > file or device.
>
> My thinking with the struct fuse_backing_map expansion was that future
> ioctls for managing backing files (eg attaching a backing file to a
> live inode or swapping one backing file for another) might benefit
> from a shared struct instead of needing to add new structs for each
> type.
>
> >
> > I think that the maps of fuse_file to multiple fuse_backing is better
> > handled by another layer of mapping (sort of a backing_mapper)
> > which is what famfs and iomap need, but it is just my initial thoughts.
>
> I like this idea a lot, it makes sense to me.
>
> >
> >  Joanne, if you are a concrete use case for that, let's try to see
> > how a design to this use case may look like.
>
> The internal team I'm working with is planning to start working on
> their server in H2. They will run some benchmarks to see if current
> passthrough and/or io-uring+zero-copy might get them the performance
> gains they need, or whether they will still need the set of advanced
> passthrough features they requested. I'll keep you posted once there's
> performance data and if there is still a need for the more advanced
> passthrough features (file mapping to multiple backing files, backing
> files dynamically changing, enabling passthrough on a live inode),
> I'll draft up a design doc to get your thoughts on.

Sounds good.
FYI, some of those issues we try to solve at application layer.
Our HSM application always tries to keep the inode itself across
state changes.
For example, by using clone_file_range() to fill in content.
With xfs, we could also try to use atomic swap extents, if file content
can change, instead of changing inode, but we did not try this yet.

> In the meantime,
> I'm planning to send out v2 of the inode metadata passthrough patchset
> sometime this week or next with your feedback from v1.
>

Cool. Let's get this rolling.
I need to get my test setup back in shape.
There were a bunch of fstest failing last time I tested passthrough,
mostly related to metadata cache coherency.
I was hoping that GETATTR passthrough could solve some of them.
If you have seen any improvements (or regressions) in fstests please
share this info with the patch set.

Thanks,
Amir.
