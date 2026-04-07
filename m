Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951C37F8CF
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605111; cv=pass; b=JQwpEw789MlJqaUHDunptlJaL1K8hKOgtlguCQLcQlq4MUuqBL+Pn9BiOmNmWSfYQ7JFq+BZo01SJGvWNt4ff3jh9+LQqr3Ok532oQ1NlUk7bZfwG3++dCXBmCya3cregixVkZb7Yaaz9aNa40Kp7a1NuNE1of4hfynKRc1TMds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605111; c=relaxed/simple;
	bh=zlwYW7fdwAwZvTYfMRjR0KpmzJ90GNurI17qKIQ0Coc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXpKtE3xJdfkGTT25dgmlv975cF0R3j+rdng5UfR47ErUWqQf7nGJyMPoln2z7aAnvxQqtQhSyfkuP8WuyeZFDe8dLiiwHPdqf4Vi3X+7XncY87bsmCuZIwSbe+GHychviHjB5T4UIFRxXW4xc23GpGcFbrVOxl3WLoxkRbkBvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oReFSSxK; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oReFSSxK"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf7683a28so3343415f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 16:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775605108; cv=none;
        d=google.com; s=arc-20240605;
        b=Ijopu4kp/EPCDpRDTFq+dC3NxHVaV0SI4P788HQYh1tHoMrDKLqLnc9NOLWJUm6LDn
         rxo5LJ8reQIt3kW1cq0FGW832IYjW0OcQkNS0XATWcIChCz/BzCDChHdbe9YVX89UAhY
         YiCBceMuRMwR0N1s9eUFhBBSjO9wPNb8qniCskE2ZKkWWGTfF+mPjuvWD36uhqgDRcNT
         Ak+T5n7qO5wLNkDiT7eWtZmm1IC4NdOBUphCDS9MGdV5tWs+Xg97QrqHRvFxrV5kgBnI
         oNrYGclWtbgAjtvcdJCGd08bCnNFf2FVzZEOUUpQ11MOjWMs/8LjF/WWjXIT/WgWMdPS
         7KrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z0bxf4LESdnBWSpH2UfyMGAl30UruMJiWIFPfVSSlLo=;
        fh=GVwcfIkknwMhhjlnQsFs3fdXMIQcHYpBbnWurUKd5WA=;
        b=Sr5Q/mzVJ6Zj1dRZ9O8wU1QiI/psQUQsWVNUEPxBdICJv6MrPgGQ/XdmXpbPSYE/Xs
         WiyjYyuqA7OgHbYe7aTvovkBKa6embyS31OBz+m1HN7ZUiwXsLVg/Eg4yOeEB6ABPmdU
         EVa25l7kmuy6z6VZ6xqbGFdZOaEG6aOiqTuq82Wv2se4Y8SPIHvVaW5r8hbJxMrlMnTs
         lGyesVz5rro06B1UFy8PuUKnt7CJTqLyBzCLdW7kWCc6S59NXJ3x4uw89i3wNN8E6MML
         UcX4A8GJw+Ymzz7MZHZ1v0zBy0DdUaTyozXJSgQLrka//0noICDwDsMD8j1ymkj93sfb
         tiJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775605108; x=1776209908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0bxf4LESdnBWSpH2UfyMGAl30UruMJiWIFPfVSSlLo=;
        b=oReFSSxKYZ/dLQ6mxxmY0qsW3L8tW8bOL6cXsA6NdATKKSq3HXi7gVfrBBJtWAu6Q8
         /n5ci/qKWKbzt6JCac+PPs3/YjiwKp5DrZQOHStZxPE1UdgsEjgh4ZrNisoJq97Q3Ozh
         aqr3cgQySNIt63OK7wM7CsAv/z6/IKHmHzETYRtl+lTO5hQdl/gakhYgsGClAlF9biYf
         R8Er7W998WSQkOD8pvR9nUmacngFLhTetKOJWV20bhpKhVeM1AoTmfFtixwNBoM8wvHv
         QABMCctRbh4es2NSM040XDaQqwnfvs06tDV/h43Beou5v5vhJyGZyFXKPajvCoY8dH0+
         28Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775605108; x=1776209908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0bxf4LESdnBWSpH2UfyMGAl30UruMJiWIFPfVSSlLo=;
        b=gU8od6NUdQIo9ENzsj7MjVqhvWYZWoxbMKXmxoxo51M3b2i6HICpjQrR5G1mz+hq6v
         gg4qq6E954Z5AnbN3zCpoeSfeoqi51knJIsvhm5/z1+ynUXW6oisyw5GjsUll5Oq8rB7
         OXpfalpByypORxhr23mLwmSO+My5tFkQvGt+o6EDbKw8bce6nQY9YPmlaDsE59bfpjBU
         dpqbB7WV5pPuSJeIcixGWMAmBXlNcAbeJHqgjD5x/g6pWvQvlFHu8+H8f3QJdEo6KKZN
         cpoX1DTZ9QY2ezAm75FYfFiG+YPiS64XZCRFELFEcfxxCSEISi3LA4heKA/9yrl1O7x5
         hQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWsbZcgqsGNKYtRMQCc5+ZKlsrQTvxRj4b5KO2TOJkgIlx//IRh9XMaDs7pdSqkhDkrGtvO069zxW7rPURN@vger.kernel.org
X-Gm-Message-State: AOJu0YwD73SoImIiHlQpfhRN5JznchkgUZ4UrUf/ZwJRxzVdVxgsP07V
	RankNhfyZArzPTbfe0IZkefqFzbJIwjMdQNoitRFzgaIgoudp5UxvF5nGO0W1QFjkYDgApIcR8+
	iUy9C1heX2xYdCw/jFfJPjvtegO0icw8=
X-Gm-Gg: AeBDievV5RkgJ26+5TjRYnLExYYyUGbW/vrzEKrId05UY4oBfuYE+Fw0LAudElgJSkU
	FjxRZCQqSbqADGyGCG5TFL7IMGYJiTtUXKvQERH4/dFz8bjzXmct9RozNPTmuFJIccJjlN+ZkI6
	vR0bUEXWXYIGg3ZFjmrmQP6px9zGsjkrkMFNa7CHUqX5nIyQeHNtMvyTBmqFBVNnQX6aln7b99Z
	zXFHMcxDqHDNnbwEVbW+o/Zi++3UlNdzipwvvKL1jApCT7TosOQ6BMWU9jHdt+jaBXNMHK6y2Fp
	m57Hyw==
X-Received: by 2002:a05:6000:2408:b0:43b:4d2e:a004 with SMTP id
 ffacd0b85a97d-43d29269f55mr26961207f8f.10.1775605108421; Tue, 07 Apr 2026
 16:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
 <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
 <87v7e24gdw.fsf@igalia.com> <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
 <CAJnrk1b9CkQ0i6FdFvxcKbhS7K4TG5yQKbnEXV=Hc+ry593KoQ@mail.gmail.com>
In-Reply-To: <CAJnrk1b9CkQ0i6FdFvxcKbhS7K4TG5yQKbnEXV=Hc+ry593KoQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 7 Apr 2026 16:38:16 -0700
X-Gm-Features: AQROBzDjiD4tgnakCh_4zOnEalDSdwLdtAMPYoFs7e0MS4LMgQ2mSMQziJAwd7s
Message-ID: <CAJnrk1acCTAKriA4w=gsrt5FswHABs7J74osNHeehxPepD8A2g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, Bernd Schubert <bernd@bsbernd.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Horst Birthelmer <hbirthelmer@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 4:24=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Tue, Apr 7, 2026 at 4:06=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > On Tue, Apr 7, 2026 at 2:20=E2=80=AFPM Luis Henriques <luis@igalia.com>=
 wrote:
> > >
> > > Hi Joanne,
> > >
> > > On Tue, Apr 07 2026, Joanne Koong wrote:
> > >
> > > > On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igalia=
.com> wrote:
> > > >>
> > > >> The implementation of lookup_handle+statx compound operation exten=
ds the
> > > >> lookup operation so that a file handle is be passed into the kerne=
l.  It
> > > >> also needs to include an extra inarg, so that the parent directory=
 file
> > > >> handle can be sent to user-space.  This extra inarg is added as an=
 extension
> > > >> header to the request.
> > > >>
> > > >> By having a separate statx including in a compound operation allow=
s the
> > > >> attr to be dropped from the lookup_handle request, simplifying the
> > > >> traditional FUSE lookup operation.
> > > >>
> > > >> Signed-off-by: Luis Henriques <luis@igalia.com>
> > > >> ---
> > > >>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++=
++---
> > > >>  fs/fuse/fuse_i.h          |  23 ++-
> > > >>  fs/fuse/inode.c           |  48 +++++--
> > > >>  fs/fuse/readdir.c         |   2 +-
> > > >>  include/uapi/linux/fuse.h |  23 ++-
> > > >>  5 files changed, 355 insertions(+), 35 deletions(-)
> > > >>
> > > >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > >> index 113583c4efb6..89e6176abe25 100644
> > > >> --- a/include/uapi/linux/fuse.h
> > > >> +++ b/include/uapi/linux/fuse.h
> > > >>
> > > >>  enum fuse_opcode {
> > > >> @@ -671,6 +676,8 @@ enum fuse_opcode {
> > > >>          */
> > > >>         FUSE_COMPOUND           =3D 54,
> > > >>
> > > >> +       FUSE_LOOKUP_HANDLE      =3D 55,
> > > >> +
> > > >>         /* CUSE specific operations */
> > > >>         CUSE_INIT               =3D 4096,
> > > >>
> > > >> @@ -707,6 +714,20 @@ struct fuse_entry_out {
> > > >>         struct fuse_attr attr;
> > > >>  };
> > > >>
> > > >> +struct fuse_entry2_out {
> > > >> +       uint64_t        nodeid;
> > > >> +       uint64_t        generation;
> > > >> +       uint64_t        entry_valid;
> > > >> +       uint32_t        entry_valid_nsec;
> > > >> +       uint32_t        flags;
> > > >> +       uint64_t        spare;
> > > >> +};
> > > >
> > > > Hi Luis,
> > > >
> > > > Could you explain why we need a new struct fuse_entry2_out instead =
of
> > > > reusing struct fuse_entry_out? From what i see, the only difference=
s
> > > > between them are that fuse_entry2_out drops attr_valid,
> > > > attr_valid_nsec, and struct fuse_attr. Is this done so that it save=
s
> > > > the ~100 bytes per lookup? Would it be cleaner from an abi perspect=
ive
> > > > to just reuse fuse_entry_out and ignore the attr fields if they're =
not
> > > > necessary? The reason I'm asking is because I'm looking at how you'=
re
> > > > doing the lookup request reply to see if the fuse passthrough stuff
> > > > for metadata/directory operations can be combined with it. But I'm =
not
> > > > fully understanding why fuse_entry2_out is needed here.
> > > >
> > > > I'm also a bit confused by why the compound with statx is needed he=
re,
> > > > could you explain this part? I see the call to fuse_statx_to_attr()
> > > > after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts =
the
> > > > statx reply right back to a struct fuse_attr for inode setup, so if
> > > > FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
> > > > fuse_entry2_out, doesn't this solve the problem of needing to compo=
und
> > > > it with a statx or getattr request? I also noticed that the statx p=
art
> > > > uses FUSE_ROOT_ID as a workaround for the node id because the actua=
l
> > > > nodeid isn't known yet, this seems like another sign that the
> > > > attributes stuff should just be part of the lookup response itself
> > > > rather than a separate operation?
> > >
> > > First of all, thanks a lot for looking into this patchset.  Much
> > > appreciated!
> > >
> > > The main reason for swapping the usage of attr by statx is that statx
> > > includes some attributes that attr does not (e.g. btime).  And since =
I was
> > > adding a new FUSE operation, it would be a good time for using statx
> > > instead.  (Moreover, as new attributes may be added to statx in the
> > > future, the benefits of using statx could eventually be even greater.=
)
> > >
> > > This was suggested by Miklos here[0], before converting the whole thi=
ng to
> > > use compound commands.  So, I was going to use fuse_statx in the _out=
 args
> > > for lookup_handle.  However, because the interface was getting a bit
> > > complex with extra args (and ext headers!), Miklos ended up suggestin=
g[1]
> > > to remove attr completely from the lookup_handle operation, and use
> > > compounds instead to have the full functionality.
> >
> > Thank you for the context and links, Luis!
> >
> > Using fuse_statx over fuse_getattr makes sense to me for the new
> > FUSE_LOOKUP_HANDLE op but the part I am confused about is why it needs
> > to be compounded. If we are adding a new struct (struct
> > fuse_entry2_out) to the abi, why is it not simpler to just make the
> > new struct something like:
> >
> >   struct fuse_entry_handle_out {
>
> Thinking more about how passthrough will use this... I'm thinking
> something like this would be ideal (though please correct me if I'm
> completely off track here, Amir):
>
>   struct fuse_entry_handle_out {

(this name should be the generic "fuse_entry2_out" as Luis originallly
had it, not "fuse_entry_handle_out")

>       uint64_t    nodeid;
>       uint64_t    generation;
>       uint64_t    entry_valid;
>       uint64_t    attr_valid;
>       uint32_t    entry_valid_nsec;
>       uint32_t    attr_valid_nsec;
>       int32_t     backing_id;
>       uint32_t    flags;
>       struct fuse_statx statx;
>   };
>
> where if the inode is not passed through, the kernel uses the stax
> field for the attributes but if the inode is passed through and the
> server sets a bitmask specifying that attributes should be derived
> from the backing file, then the statx field will be ignored by the
> server and kernel).
>
> Thanks,
> Joanne
>
> >       uint64_t    nodeid;
> >       uint64_t    generation;
> >       uint64_t    entry_valid;
> >       uint64_t    attr_valid;
> >       uint32_t    entry_valid_nsec;
> >       uint32_t    attr_valid_nsec;
> >       struct fuse_statx stat;
> >   };
> >
> > and avoid the compound stuff altogether? Is it because that would make
> > the struct fuse_entry_handle_out too big to be stack-allocated and
> > would thus have to be heap allocated? But if I'm recalling correctly,
> > the compound requests path requires heap allocations as well. Although
> > at that point if we're gonna have to do the heap allocation, then we
> > might as well just also embed the struct fuse_file_handle inside
> > struct fuse_entry_handle_out?
> >
> > Thanks,
> > Joanne
> >
> > >
> > > Obviously, I may have misunderstood (or mis-implemented) the suggesti=
ons
> > > that were done.  And hopefully the provided links to the discussion t=
hat
> > > originated this approach will help.
> > >
> > > Regarding the usage of FUSE_ROOT_ID as a workaround for the node id, =
I
> > > believe this is a more generic problem which will occur in other comp=
ound
> > > commands as well.  If we want to create a new file system object and
> > > perform some operation with it within the same compound, a similar
> > > workaround will be required (or some sort of flag in the compound com=
mand
> > > to signal this dependency).
> > >
> > > I hope this helped to clarify a bit your questions.
> > >
> > > [0] https://lore.kernel.org/all/CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_=
sksMj84xPPCMGQ@mail.gmail.com
> > > [1] https://lore.kernel.org/all/CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3=
uzG39DnVoVXMkA@mail.gmail.com
> > >
> > > Cheers,
> > > --
> > > Lu=C3=ADs
