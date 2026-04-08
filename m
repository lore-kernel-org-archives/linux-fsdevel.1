Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB313D3323
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661364; cv=pass; b=SdKRjK180zq95RGBpYMfhWKpYXFbIHPehUy7f98Ky8oY19Idmd0CCEl9ehuPdzjlfL+FWrcKHUb1xMQv8+Qr4SCfNVLWRdPU2r+uVH4JbleinO5FvSHUI6j8NksaFadsFdhQYRPT/z2mAoLf7Lzn/h4QL7Xk0SwBUbQGT1bKGUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661364; c=relaxed/simple;
	bh=ZuRKzrguWn7dV9KfPUpCM7mSZ8PITjb2tzRvSjD/A48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJFpidz/MrbJl1D9QHaC6A1Txj7ie4N+dn6v1q3zZ/lqMyELdN2HaFJSYhi9IgoP6+Gg5gVX8Lq1OaW+uUIXcaFBLnflGIVZno+DFe2Gzs92ps20vf5Rb1Smt8JknSMzl11tcjGsVGuLomvpQ2L6DeocF2BW97nqZ9n9uY8NWK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR5e5ami; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR5e5ami"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501d242e3fso6238622d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 08:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775661361; cv=none;
        d=google.com; s=arc-20240605;
        b=PvpL6qNkeqkx6iQR8Iw2stj4mbVqbzj03l6mIfe1l9bc46W3gSechhL7dIcR50KP4S
         OCmpdy5PuMWqrKG/zdxw+kYb2snP4ZGfLoJaGUBxX/QSPSEgXud0zyDNRam5xs6i6h5u
         5mzztdTRiaBuGLuKL16O/ZGC88gxer3QGpKpP5T1U7Akw6ggsFZtOJYHtee0+5zPXq+n
         j5m35nODk6uvxmZ6vMmyKM1KfUY3Th9q0B5+YQc3bGTO76sc0z4HyhOEgn/9HbfFWVsl
         W5PHWBxFHfpygm3WrMRO8sURe73//XYtSKwOXyUwrHXiNjWCsZ9GnwTvtq7V4Al02iWw
         TRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZmBpxsIXrR6m8nxFVg/92m35n/8on58zcXpihyOr3JI=;
        fh=U0jxzUfp9Jt+Gz8j1mz0ZPnXQKvrrFrIA5Dy87h0cUs=;
        b=ZpVMiVhTwMd+SL1Lx897p/0mEHiZR0Bu9C/mJnc1SgmCqlw2tO9g3qQ6UVQzKHi9da
         EmIDnCgVJGAQy2hFsCbA7oj3k3jfXR3aXU1dXCiLXxoxLaUAgxmPzrqSxaSJ+3IgKP6e
         rbmpPTX5s3avUnCMmIYMKCrtJhVjHZNj/6+hC3uX0zs6MMn7s4d/6I2NTku+lDnCe/qr
         sdb8+vnmz1l3+na3ox+EtiejqtOWXiinr7xBzDP00Gh8M9oB7HppNUsEi23xtLsVrveK
         vylJWDowsCz10ApijtFeocNyjE3cyRj/ZaSnDtMPz0Ivanis8rmf5wftuR2Mu+DmOEKo
         oKrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661361; x=1776266161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmBpxsIXrR6m8nxFVg/92m35n/8on58zcXpihyOr3JI=;
        b=gR5e5amicIf0ZtbgqJTwYJhoTOEr7ScKo1XybQcdXiLZURfLC7Axk7c27Dud28+R6N
         lddE3pPck1RxOkItJZbiswiqtwdotP0U3CxmmBgfrJ8gzrnjtr/mslUO2ioJYHJ3pvg+
         vRp8uyw4hVE80tVN39sUdi1mU0YPectrij2o9nfrBTwjAKqNV7p8ad8btwI26Kij7R99
         y8crkss0UVqofm4xJa90DRdVgvl3TfVkEYie3MWIs82KjJs571k0LIuPi36g+KVJgf3R
         jGcUp1zirZ0N0GH2pWbEtsl+6+MDMY2mJCkd8CvlgVccNbfyr+l7WMIcJP4uz6qoFqZf
         fSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661361; x=1776266161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmBpxsIXrR6m8nxFVg/92m35n/8on58zcXpihyOr3JI=;
        b=aHZABpLlWi8/bydKHV/g3sUpx4N7IpAQOObQphFFVSN8m1cJ4TO9c4jx9JcZV3DSlZ
         1GKZW9sQlBbIiQVRtgAo7ZrhsTPVs6Fv/bhDZm1oHgEl1qwFU9N1sHqhz4aibc01wZgf
         nSKSRV+wYOLbbBcWG/wNfu1fUrQsqCLdCtpOkK7wR/YwmeHoqIpCpGpr08LBzR0pL829
         rb7qrthiPQYRsZ7ioews3yYGuiVLD3sjrK9Cj2H0GQwcvxmBIXsp3gUH4gJ7I4k7RePW
         y3d+FpDKHR9osYpUDiwXWZOzWPox/z2kCJOo9+mQA8383ty4Jn/W3uRSSn00fqKxYsLI
         wHnw==
X-Forwarded-Encrypted: i=1; AJvYcCXX/9Nx9X1xzaYgmRs6pMQSX+XiVX4Y4g/67XSKRBKzvUU4KIlkFbdIcYLiayHZ5cIPI2IA4NitbqdWjuNA@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxe0hCa0yDKnZqxyB7ithxdVXXP+2ZUEKe2AM3T78jFWIZsBA
	6kY+M82i+fGgMKJ1QHIV89QcySmsTu1/XCKN+e1quAsIIUaplwHxhPfZGaJxsxq6VtRi8tV2YHd
	9dCq9Lyzw57/jDy0TAfw8B1DnQkilVVo=
X-Gm-Gg: AeBDieu2TMe4oUrhb/IwZb7M6vvNDOSUnM0G02yo5TeyHccjSzpeol/RCdJQXdVrmU0
	36+h/4xfW9fwwmBhiBGUTZ+ysbvr24hwg7TUCL1jju52Vk6BZuKnxaOOBLFeN6uumcW1YejkYB0
	3/ntfz85aQKbQTDzyYbBGUa2/5T2a8luWtG8El6G9Ezj68Hg0ei3enWnKZFUu2TcMVddQJ8zfVL
	ke33QUYhLgvPF3ZiJHJYWB2CcIVPe3hm6HSjysEUUdUYlh7Ieml/kYojyRTpt/73IovmDFIjb0k
	NyQcZw==
X-Received: by 2002:a53:bc85:0:b0:650:12eb:16ce with SMTP id
 956f58d0204a3-65048852dc8mr14052535d50.52.1775661360801; Wed, 08 Apr 2026
 08:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
 <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
 <87v7e24gdw.fsf@igalia.com> <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
 <CAJnrk1b9CkQ0i6FdFvxcKbhS7K4TG5yQKbnEXV=Hc+ry593KoQ@mail.gmail.com> <87bjftlpk1.fsf@igalia.com>
In-Reply-To: <87bjftlpk1.fsf@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Apr 2026 08:15:47 -0700
X-Gm-Features: AQROBzAKO7AivLdWPgq99N5zxxjpPU3_iu5dIOyJYKmluxheglV3BV4yH9pdjdc
Message-ID: <CAJnrk1ZjkgGJczG7VzmCjw4OwV-KC7uALHbBygPpy0rYKY3dPg@mail.gmail.com>
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

On Wed, Apr 8, 2026 at 3:22=E2=80=AFAM Luis Henriques <luis@igalia.com> wro=
te:
>
> On Tue, Apr 07 2026, Joanne Koong wrote:
>
> > On Tue, Apr 7, 2026 at 4:06=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >>
> >> On Tue, Apr 7, 2026 at 2:20=E2=80=AFPM Luis Henriques <luis@igalia.com=
> wrote:
> >> >
> >> > Hi Joanne,
> >> >
> >> > On Tue, Apr 07 2026, Joanne Koong wrote:
> >> >
> >> > > On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igali=
a.com> wrote:
> >> > >>
> >> > >> The implementation of lookup_handle+statx compound operation exte=
nds the
> >> > >> lookup operation so that a file handle is be passed into the kern=
el.  It
> >> > >> also needs to include an extra inarg, so that the parent director=
y file
> >> > >> handle can be sent to user-space.  This extra inarg is added as a=
n extension
> >> > >> header to the request.
> >> > >>
> >> > >> By having a separate statx including in a compound operation allo=
ws the
> >> > >> attr to be dropped from the lookup_handle request, simplifying th=
e
> >> > >> traditional FUSE lookup operation.
> >> > >>
> >> > >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> > >> ---
> >> > >>  fs/fuse/dir.c             | 294 ++++++++++++++++++++++++++++++++=
+++---
> >> > >>  fs/fuse/fuse_i.h          |  23 ++-
> >> > >>  fs/fuse/inode.c           |  48 +++++--
> >> > >>  fs/fuse/readdir.c         |   2 +-
> >> > >>  include/uapi/linux/fuse.h |  23 ++-
> >> > >>  5 files changed, 355 insertions(+), 35 deletions(-)
> >> > >>
> >> > >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.=
h
> >> > >> index 113583c4efb6..89e6176abe25 100644
> >> > >> --- a/include/uapi/linux/fuse.h
> >> > >> +++ b/include/uapi/linux/fuse.h
> >> > >>
> >> > >>  enum fuse_opcode {
> >> > >> @@ -671,6 +676,8 @@ enum fuse_opcode {
> >> > >>          */
> >> > >>         FUSE_COMPOUND           =3D 54,
> >> > >>
> >> > >> +       FUSE_LOOKUP_HANDLE      =3D 55,
> >> > >> +
> >> > >>         /* CUSE specific operations */
> >> > >>         CUSE_INIT               =3D 4096,
> >> > >>
> >> > >> @@ -707,6 +714,20 @@ struct fuse_entry_out {
> >> > >>         struct fuse_attr attr;
> >> > >>  };
> >> > >>
> >> > >> +struct fuse_entry2_out {
> >> > >> +       uint64_t        nodeid;
> >> > >> +       uint64_t        generation;
> >> > >> +       uint64_t        entry_valid;
> >> > >> +       uint32_t        entry_valid_nsec;
> >> > >> +       uint32_t        flags;
> >> > >> +       uint64_t        spare;
> >> > >> +};
> >> > >
> >> > > Hi Luis,
> >> > >
> >> > > Could you explain why we need a new struct fuse_entry2_out instead=
 of
> >> > > reusing struct fuse_entry_out? From what i see, the only differenc=
es
> >> > > between them are that fuse_entry2_out drops attr_valid,
> >> > > attr_valid_nsec, and struct fuse_attr. Is this done so that it sav=
es
> >> > > the ~100 bytes per lookup? Would it be cleaner from an abi perspec=
tive
> >> > > to just reuse fuse_entry_out and ignore the attr fields if they're=
 not
> >> > > necessary? The reason I'm asking is because I'm looking at how you=
're
> >> > > doing the lookup request reply to see if the fuse passthrough stuf=
f
> >> > > for metadata/directory operations can be combined with it. But I'm=
 not
> >> > > fully understanding why fuse_entry2_out is needed here.
> >> > >
> >> > > I'm also a bit confused by why the compound with statx is needed h=
ere,
> >> > > could you explain this part? I see the call to fuse_statx_to_attr(=
)
> >> > > after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts=
 the
> >> > > statx reply right back to a struct fuse_attr for inode setup, so i=
f
> >> > > FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struc=
t
> >> > > fuse_entry2_out, doesn't this solve the problem of needing to comp=
ound
> >> > > it with a statx or getattr request? I also noticed that the statx =
part
> >> > > uses FUSE_ROOT_ID as a workaround for the node id because the actu=
al
> >> > > nodeid isn't known yet, this seems like another sign that the
> >> > > attributes stuff should just be part of the lookup response itself
> >> > > rather than a separate operation?
> >> >
> >> > First of all, thanks a lot for looking into this patchset.  Much
> >> > appreciated!
> >> >
> >> > The main reason for swapping the usage of attr by statx is that stat=
x
> >> > includes some attributes that attr does not (e.g. btime).  And since=
 I was
> >> > adding a new FUSE operation, it would be a good time for using statx
> >> > instead.  (Moreover, as new attributes may be added to statx in the
> >> > future, the benefits of using statx could eventually be even greater=
.)
> >> >
> >> > This was suggested by Miklos here[0], before converting the whole th=
ing to
> >> > use compound commands.  So, I was going to use fuse_statx in the _ou=
t args
> >> > for lookup_handle.  However, because the interface was getting a bit
> >> > complex with extra args (and ext headers!), Miklos ended up suggesti=
ng[1]
> >> > to remove attr completely from the lookup_handle operation, and use
> >> > compounds instead to have the full functionality.
> >>
> >> Thank you for the context and links, Luis!
> >>
> >> Using fuse_statx over fuse_getattr makes sense to me for the new
> >> FUSE_LOOKUP_HANDLE op but the part I am confused about is why it needs
> >> to be compounded. If we are adding a new struct (struct
> >> fuse_entry2_out) to the abi, why is it not simpler to just make the
> >> new struct something like:
> >>
> >>   struct fuse_entry_handle_out {
> >
> > Thinking more about how passthrough will use this... I'm thinking
> > something like this would be ideal (though please correct me if I'm
> > completely off track here, Amir):
> >
> >   struct fuse_entry_handle_out {
> >       uint64_t    nodeid;
> >       uint64_t    generation;
> >       uint64_t    entry_valid;
> >       uint64_t    attr_valid;
> >       uint32_t    entry_valid_nsec;
> >       uint32_t    attr_valid_nsec;
> >       int32_t     backing_id;
> >       uint32_t    flags;
> >       struct fuse_statx statx;
> >   };
> >
> > where if the inode is not passed through, the kernel uses the stax
> > field for the attributes but if the inode is passed through and the
> > server sets a bitmask specifying that attributes should be derived
> > from the backing file, then the statx field will be ignored by the
> > server and kernel).
>
> If we end up deciding to revert back to not using compound commands I'll
> have to take a closer look into this, as it's not clear what the above
> means.  For example, when you say:
>
>   "... if the inode is not passed through"
>
> does this "inode" refer to the backing_id?  I guess this is some index to
> backing ids being used by FUSE, not exactly an inode, but I'm not very
> familiar with the code.

Ah sorry for the confusing wording. By "... if the inode is not passed
through" what I meant is if the server chooses not to have passthrough
enabled on that inode. If the server does wish for any operations on
that inode to be passed through to a backing inode, it will supply the
backing_id that corresponds to the backing inode (it gets the id from
the FUSE_DEV_IOC_BACKING_OPEN ioctl registration call). If backing_id
is not set (left as 0), then that inode will not have passthrough
enabled on it.

Thanks,
Joanne

>
> Cheers,
> --
> Lu=C3=ADs
