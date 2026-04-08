Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50A379EC8
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660754; cv=pass; b=FLTVhTWW2DA/6ept5ec71odZMClBD13cA9CMPm78m04VzSZBfjsBa9DhJ48C+rVC9Tsv567ZQ5qJAZwNKiyDVA26O/6M5NpJ6XyKy9yyyBoEIE2WteRyJZREESzwM5omEWOHJM8Q/FCyRG4CEUXQCwQKVSUQ3DxUrYbdwn++KB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660754; c=relaxed/simple;
	bh=KfgXCoXu7LYjaoSM1rI5qw3z/wD+juINVYkpqhFMxh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9TAno9a3wn84oS25IZf5CX9xmfhJ0cKLXS1Yu3MRNZhvDEyBO8vxtHRmatZ+hvTc3DWWNme862w8N/hVf6Q8ixuuoGV/dElzedzAa+o9ccffXvQnlQvVcylIY7WNcWhr1zzHXeG+DT9Txi6M8bAhJshR3SoiEtt9iY2K2TTl9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evCyAtoJ; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evCyAtoJ"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64edf260b49so1865989d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 08:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775660751; cv=none;
        d=google.com; s=arc-20240605;
        b=QYT1wL5jRs9qtF7RifNoKk33QgHuqFbj1pHMurLRfbD+mlCG6XQibCax2TiS2qhN4v
         dfNVfMK5qfqSTMikvFtH80dJSu66q3kTD+jQJnGdT5zq1jvwwgC647WWPiEDzMUEn5NE
         vQejuiXtpwrFi8SWW2AL11IVqjneiEzpF1OEJ5PZnLKNHXL7RMIxbTsx6WrPVjPSaLsm
         vybh0PgwX7kJ2WuHEZ7AsNGWmPi1YjGIY58N0L/m1/bU66iivChIkXVqtQRrWlqnTsp8
         2fCzAUuau+KlGmNkuBsNgk72YrWvAM9hVPTysiOKNDcm2lLBYOk4cMqcHG1vV+1AZeUb
         YknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=20sLh35Xu7yfEKfQNapddrXBpNTNHBJhbfkBeFrwmog=;
        fh=oJlpGMjHbp6z/4utAs9NCJWff0YHw/umNB323jHJAV8=;
        b=RwAv2p7y0Kl/TB8fyjFEJ0HeIx7+TQRjl7zg4U4KATNygiGALFUeEgVRE4gEbkkl8Q
         5DVMNsP8v3omj7/706hRIOipKeB8GLIa/O9A1HzxIx2k203KZvKx+DqckKELhfoiwMB7
         egBfU6sSGyYm8Wibqf0Ko/PqEToy1/KNr95pREM12maYm9HYqe6ky2L3Eu6ulGs4cXlI
         p4wg1o4W7VhIqpdT2xg9xuvYBXH+TjWYDgBsJpjJaxy2oxjLmy7z8CSeqj26wvXgkage
         psvW5N+2UkzuigfpHDov3CmLZvZsdDNaa1sYiwTC5dqNGTkjIpLPR2RmIaAEK5F49jI1
         RBkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775660751; x=1776265551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20sLh35Xu7yfEKfQNapddrXBpNTNHBJhbfkBeFrwmog=;
        b=evCyAtoJR7voVBf7FxT93euVcJrsxgtMFdJLAm61ddgXQHNEZq17t4zs+uYJ5+gCSm
         0A+44s163H7CSa1X543S/ipcZwoT2x4H5yg1lymBOjY+Xqf7D2d9pD8s+vDWQCNl0oPl
         8jxduYhV6WMzmnWrtu/OLbEnBwGHcTNrV2AkNQvgfMK8KlK616VmnYEoippzP7i/d8L4
         /Fdcm8h5BzizLRFewjnkWK3zQqu38ZHScXVzy1blR9GeHz2U5N7K9L2Kxya/p3Z0rT0M
         0UFpbAUxELkQGUkByCAtaltgRfkGOlLvTR1fwjbcqfL2uj0AGzS8AeNfIobJCnnKOTLH
         Ppkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775660751; x=1776265551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=20sLh35Xu7yfEKfQNapddrXBpNTNHBJhbfkBeFrwmog=;
        b=KCHWmL1oCgTM3dNVONZ2jaGBHER+tIsg2QkJ2X8H2lVWu9C9eJrplFH4COdSKMNzKc
         qAzvKEWTRa2PkwIMIzJvC+ZmQ2EVaKhbyfYgA6D2/WY0qYxdMsgn6bJ69HUHjA0KEhQV
         oYp++kUQwXmVhgWmaTCnehgrwcqhmBrVBauH5q5DoLXIuffU3WiJlAca+om7i15opc7U
         lVDrSRF8DjLaaBJ5CakmQOc08zQ50zyOXpvfON4gumVRvMSmqnzVEfWB7lip2kQnC8iO
         TP4hZQM4p90bblzvRT+QicLFUKvkrstbEDxEzhGpE0OJO/p5M36o2NFvlIXZAervFya0
         TSrA==
X-Forwarded-Encrypted: i=1; AJvYcCUR5ntUhi/Zg3b2Msce62YT4Et6Ijkd3TpPWCLjkApka6lpQc80ozQ+I4HAK9puFJlHVWuw7UZGHx3UoQAt@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZ1ZSbEOyzhTO43br1Lj9sZ7AyvRMWexFc+zQL7rcKBcdcEjG
	gtUN5nuX+c2s4s+NONzPAGlxowJAJdonIo2swHT+cB+MogLxZ/ePUxgcQ4XjFeP1ogLdcovR+Vs
	ibeviL9IMONlInWH1sZfNZcff9WMltFg=
X-Gm-Gg: AeBDieuMSQxPzvV9zOmwS12Emn/ESc8ZZ9c84mhLfZgYx71oJB4k6fLCvkbZxieel9T
	7Imze5BkLekODCgkF9YuXMgfHhvc/aGoVOBYtciBKycDMLgtFuMRREIOwDs2LMsrEhvN7+4UD3l
	fWJxxz3QQHmrwgMyfbbT9Zcvq8T/4pfv6BqZFbYEZgJDKkXidytDZCy9ZRDngc2Uos27BLX7s3R
	D+NKT2EV4grOh8kegvTaGCHAUAhiZ1Iz4Q41gPLAIKBEcISQwNq3g3p9bgUvBh41N2jSGCy1pc1
	HJjjpw==
X-Received: by 2002:a05:690e:d07:b0:650:7b78:2bf6 with SMTP id
 956f58d0204a3-6507b782cc8mr5943656d50.21.1775660751341; Wed, 08 Apr 2026
 08:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
 <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
 <87v7e24gdw.fsf@igalia.com> <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
 <87fr55lpu4.fsf@igalia.com>
In-Reply-To: <87fr55lpu4.fsf@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Apr 2026 08:05:38 -0700
X-Gm-Features: AQROBzC9pYCdC-FHJ1-0A1K4nRL1beSTVjfRcm0YGS9dqGkHSFKl9HBE5eCCUFw
Message-ID: <CAJnrk1bHqHQ5b2_HYskiJ125BdDFGHqG0zusbuz+1a2vCz-FfA@mail.gmail.com>
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

On Wed, Apr 8, 2026 at 3:16=E2=80=AFAM Luis Henriques <luis@igalia.com> wro=
te:
>
> On Tue, Apr 07 2026, Joanne Koong wrote:
>
> > On Tue, Apr 7, 2026 at 2:20=E2=80=AFPM Luis Henriques <luis@igalia.com>=
 wrote:
> >>
> >> Hi Joanne,
> >>
> >> On Tue, Apr 07 2026, Joanne Koong wrote:
> >>
> >> > On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igalia.=
com> wrote:
> >> >>
> >> >> The implementation of lookup_handle+statx compound operation extend=
s the
> >> >> lookup operation so that a file handle is be passed into the kernel=
.  It
> >> >> also needs to include an extra inarg, so that the parent directory =
file
> >> >> handle can be sent to user-space.  This extra inarg is added as an =
extension
> >> >> header to the request.
> >> >>
> >> >> By having a separate statx including in a compound operation allows=
 the
> >> >> attr to be dropped from the lookup_handle request, simplifying the
> >> >> traditional FUSE lookup operation.
> >> >>
> >> >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> >> ---
> >> >>  fs/fuse/dir.c             | 294 ++++++++++++++++++++++++++++++++++=
+---
> >> >>  fs/fuse/fuse_i.h          |  23 ++-
> >> >>  fs/fuse/inode.c           |  48 +++++--
> >> >>  fs/fuse/readdir.c         |   2 +-
> >> >>  include/uapi/linux/fuse.h |  23 ++-
> >> >>  5 files changed, 355 insertions(+), 35 deletions(-)
> >> >>
> >> >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> >> >> index 113583c4efb6..89e6176abe25 100644
> >> >> --- a/include/uapi/linux/fuse.h
> >> >> +++ b/include/uapi/linux/fuse.h
> >> >>
> >> >>  enum fuse_opcode {
> >> >> @@ -671,6 +676,8 @@ enum fuse_opcode {
> >> >>          */
> >> >>         FUSE_COMPOUND           =3D 54,
> >> >>
> >> >> +       FUSE_LOOKUP_HANDLE      =3D 55,
> >> >> +
> >> >>         /* CUSE specific operations */
> >> >>         CUSE_INIT               =3D 4096,
> >> >>
> >> >> @@ -707,6 +714,20 @@ struct fuse_entry_out {
> >> >>         struct fuse_attr attr;
> >> >>  };
> >> >>
> >> >> +struct fuse_entry2_out {
> >> >> +       uint64_t        nodeid;
> >> >> +       uint64_t        generation;
> >> >> +       uint64_t        entry_valid;
> >> >> +       uint32_t        entry_valid_nsec;
> >> >> +       uint32_t        flags;
> >> >> +       uint64_t        spare;
> >> >> +};
> >> >
> >> > Hi Luis,
> >> >
> >> > Could you explain why we need a new struct fuse_entry2_out instead o=
f
> >> > reusing struct fuse_entry_out? From what i see, the only differences
> >> > between them are that fuse_entry2_out drops attr_valid,
> >> > attr_valid_nsec, and struct fuse_attr. Is this done so that it saves
> >> > the ~100 bytes per lookup? Would it be cleaner from an abi perspecti=
ve
> >> > to just reuse fuse_entry_out and ignore the attr fields if they're n=
ot
> >> > necessary? The reason I'm asking is because I'm looking at how you'r=
e
> >> > doing the lookup request reply to see if the fuse passthrough stuff
> >> > for metadata/directory operations can be combined with it. But I'm n=
ot
> >> > fully understanding why fuse_entry2_out is needed here.
> >> >
> >> > I'm also a bit confused by why the compound with statx is needed her=
e,
> >> > could you explain this part? I see the call to fuse_statx_to_attr()
> >> > after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts t=
he
> >> > statx reply right back to a struct fuse_attr for inode setup, so if
> >> > FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
> >> > fuse_entry2_out, doesn't this solve the problem of needing to compou=
nd
> >> > it with a statx or getattr request? I also noticed that the statx pa=
rt
> >> > uses FUSE_ROOT_ID as a workaround for the node id because the actual
> >> > nodeid isn't known yet, this seems like another sign that the
> >> > attributes stuff should just be part of the lookup response itself
> >> > rather than a separate operation?
> >>
> >> First of all, thanks a lot for looking into this patchset.  Much
> >> appreciated!
> >>
> >> The main reason for swapping the usage of attr by statx is that statx
> >> includes some attributes that attr does not (e.g. btime).  And since I=
 was
> >> adding a new FUSE operation, it would be a good time for using statx
> >> instead.  (Moreover, as new attributes may be added to statx in the
> >> future, the benefits of using statx could eventually be even greater.)
> >>
> >> This was suggested by Miklos here[0], before converting the whole thin=
g to
> >> use compound commands.  So, I was going to use fuse_statx in the _out =
args
> >> for lookup_handle.  However, because the interface was getting a bit
> >> complex with extra args (and ext headers!), Miklos ended up suggesting=
[1]
> >> to remove attr completely from the lookup_handle operation, and use
> >> compounds instead to have the full functionality.
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
>
> I'm open to drop the usage of compounds for this, of course.  In fact,
> during the v2 discussions I suggested here[0] the usage of a similar
> struct fuse_entry_handle_out.  Using compound commands was a way to try t=
o
> simplify the interface.  But maybe at that point I was too quick at
> jumping into the compound commands suggestion.  It may make sense to
> reevaluate this decision if you think it simplifies things, specially for
> passthrough.
>
> [0] https://lore.kernel.org/all/87zf6nov6c.fsf@wotan.olymp
>
> And I agree that the stack allocation is unlikely to be a good argument a=
s
> I can see that using compound commands can make these stack allocations
> even worse, as we need to allocate more structs for more operations.
>
> Miklos, do you have a opinion on this?
>
> Cheers,

Thanks for your flexibiltiy with being willing to re-discuss this. In
my perspective of it, I like in theory the composability / modularity
of having dentry resolution/creation be an independent entity from
attributes but I feel like in practice, these two things are tightly
intercoupled. This might just be a lack of my VFS in-depth knowledge
of it, but I don't really see any cases where we would want to
resolve/create a dentry but not need to know or care about its
attributes. From what I see in the fuse code, every operation/request
that returns a struct fuse_entry_out directly uses the attributes
immediately after through fuse_iget(..., &outarg->attr, ...) or
fuse_change_attributes(..., &outarg.attr, ...). For passthrough it
could work just as well with compound requests for forwarding the
backing id. But imo going through compound requests adds complexity
and overhead for no benefit but maybe there is something I am missing
/ overlooking here?

Thanks,
Joanne

> --
> Lu=C3=ADs
>
> > Thanks,
> > Joanne
> >
> >>
> >> Obviously, I may have misunderstood (or mis-implemented) the suggestio=
ns
> >> that were done.  And hopefully the provided links to the discussion th=
at
> >> originated this approach will help.
> >>
> >> Regarding the usage of FUSE_ROOT_ID as a workaround for the node id, I
> >> believe this is a more generic problem which will occur in other compo=
und
> >> commands as well.  If we want to create a new file system object and
> >> perform some operation with it within the same compound, a similar
> >> workaround will be required (or some sort of flag in the compound comm=
and
> >> to signal this dependency).
> >>
> >> I hope this helped to clarify a bit your questions.
> >>
> >> [0] https://lore.kernel.org/all/CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_s=
ksMj84xPPCMGQ@mail.gmail.com
> >> [1] https://lore.kernel.org/all/CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3u=
zG39DnVoVXMkA@mail.gmail.com
> >>
> >> Cheers,
> >> --
> >> Lu=C3=ADs
>
