Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1C38BF83
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775603189; cv=pass; b=lOnC16rKLl2MXxIQqpGKO3DJcsZswMVEVx8bjVw84miyRRvxlTGiPU3m3mdA9zhbz8CaIP2m5f41yijYeu3egknQcRkdxFnTx83Ddr09owwLpjmHo6yRUp5339XhJu79yer4D0oAoN7pVNr4RkgBabN2fEkguG3e0gFMU58qjtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775603189; c=relaxed/simple;
	bh=LB0ZVsQWwLLR2xBI5oMPFQJHkC+ZQzNVMBgxmiStnPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6Z5vqJq/LXDzei0AQ344W/X1TUUXuRxWSzZoUrpKGHEG2JwlnqCiV1pQ4FYXEpGzZIeylgpnYtz4NHyuhxG6h2PPLuFE+7y+LGhCaZgbxv1vCmWKbO9v9dcUn3lUAL2DLLTwb4Wmmz6ZGHtGK+YVM/FHyPk28uwyIbVn7bjjbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDneMbhE; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDneMbhE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so42181665e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 16:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775603186; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8uuwPBIArGUY4ua94gdvEcnr81W4mlGGaVOUV6sdPr4W888gz1RK9VF5LUsSmtP6K
         aCP9YRGNFWGo6OVVt1jv8TkZn5sVffF6CkmLSYtq3m0vxI+Q7VgrQADB2s0/ugMpVT/0
         FWFEnG6X244Tui0fNfvSehJK9LnFGf/38vfCKKy1RlLuoB70YCq5NyJNUcdz2e6opK1Y
         d80mauVtCOFkvOaXOzsaBvWovXavasUZv7sfE2y/jDwV1FBkL4qqi3l2HjrTeLmqv1IC
         cmmyScw8pwiuIhd9bKYGxUU1gfxpI/yUz+6fnRaEc6Ejo9tlLkf+TqQUhy1SBdI4H+MW
         ldWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IbPXh8zE8gg3iL1ly+5nytHF9PDzZRYXMhQbpPxA8Vk=;
        fh=wXLsQ4h/myZizvh2+NjBMHThXzHtuyMdmcg8bNy4NPQ=;
        b=iDJe+mrATq3dOASdVAp6jzi20BV8GjUrj9oNPAsDlf16JDawZIUZysTYJnGvYTcD6m
         0GupuKXONxrdDe2SNU2vn5lX19wtQgvPjjC4topp1IIPCCZsADjHtGaESRFBc+F+VmIb
         vDb2Y3h0ImPZNEeiZ6Vkj4TYKLGtdMKbUWJkDxrYgpl8fL08Bf0yQrD/2GIQEELrgc34
         i2pP926ckHzIvnqQWbZWmNdegFmOO9WawIaZtwPJYJp3MT2KqR9PjglHyAbi+sitPquh
         5FmdhHrFxVitQy21EOP96QLHzUiFgMAH6xgXm/+O4DJsOBQHTWTO+DCER3C5cBmPu7bI
         H3UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775603186; x=1776207986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbPXh8zE8gg3iL1ly+5nytHF9PDzZRYXMhQbpPxA8Vk=;
        b=FDneMbhE3522/7d5InAiJK+9TD5ew4/9VmpqIS/FmetODsvVniDYp4WiBSMIrqaDXM
         HFS6pq+vIusE3DyJbZ/46zNY9I3P+pasanYqNmh/tz8hOmEvQz4EuYzqjQ37Xy2asHIA
         aq7HrpiX94yiIbNJFy+Redzg1EC2vdkiaIUweTdSlWQ6YpnaRWu5E3deAtXdsNPKnPze
         WnDwYPo2nCcqtnVXzME0ePgSFX0+BPsTm3mccxYfLTDhnOSBDsxQMo6RnugBAT3R0dTJ
         FjA0HqGv1pYBGe8QO1+bmD9S+rTJrPstXcpPFpFEyI5TLQnmD8M0e7tvQmVCoSAyLAcI
         5kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775603186; x=1776207986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IbPXh8zE8gg3iL1ly+5nytHF9PDzZRYXMhQbpPxA8Vk=;
        b=EDcMQifnIBiZOgkhroopytYC6sFNSkEracI7A6G5g0oOLLu31UhGvRXguoJ1oZ7Yvh
         H2tt5if2rePRart7cHCOWinbASZx/f6IpcaU9pYn6PsTpTcqckJCFIL4QIxSyEaIiFpi
         gK5+UBBmwucwDSftFC+r+VO+GUxHu2Ef7GccyrESedvlizhr4Ldnu4STcEh2iZ1Fmryd
         PPhQNgyuNwnOB4E5bgwCMIwAV//xJz6hOrYCJH98h9W+w6gN6uLU6SgDBFHt5T48kNJM
         wN5x96lVtm8BGm7F2TSq0aq9MotqDV6Exa99H2mhOAwsC+gBziN0E3AqZ84oaonFHeYt
         wNNA==
X-Forwarded-Encrypted: i=1; AJvYcCUo0vC2V0G2O20q8XTcR34393BElVJl9XU62mqQX1DMZWtRX/H21tbQRsQh/ZyH4KEpTF+JyXQhdUweL6c6@vger.kernel.org
X-Gm-Message-State: AOJu0YxLvyDm7B1zP0w58JfMYElVgu79XfjC5E8rgswDN7e86iFtP0Am
	qqRJJjejoA+pARaoekWJC/p7EjGAXmqQc0hzVDUapqu7evXTgL+YCVhP9+47QOSYeUD0wJuHr5c
	i12aN/pTF3Y1nTlFAKZcequEBaKntSGs=
X-Gm-Gg: AeBDievE8/t5vWHpSfwKv4/Lm+O/JtVg4LpCfYRdGgfqrys2LVKPCMUOTutFtSPgASj
	umr0TBOIRuqlwLntsQcLsvg2+NV1mMIqje6W1njdOgs08enB9if6AHC5gIAVHL3mk1Zefrku+LS
	lhVnKPCZSAdkrHG8tlJg6vVXC9su7vJGpQhQST2mcsRc0Ma1gkS4JrzUae2Z/7a4NaWRTlI23Dh
	pCs4vHDAnLlkUceZXySb81KlRbskVvtFXcdV3CP4cIMNZlP/6QH46Zv9zU6y1y7yLO67GlQuKub
	K5GdIQ==
X-Received: by 2002:a05:600c:5251:b0:488:c257:a73b with SMTP id
 5b1f17b1804b1-488c257a952mr39549825e9.9.1775603185445; Tue, 07 Apr 2026
 16:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
 <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com> <87v7e24gdw.fsf@igalia.com>
In-Reply-To: <87v7e24gdw.fsf@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 7 Apr 2026 16:06:13 -0700
X-Gm-Features: AQROBzDH6OrGSbCEgdGrgJWOn8d1SQj2Wulic8fz7ffautXqq8VYtBGf_JFXn60
Message-ID: <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
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

On Tue, Apr 7, 2026 at 2:20=E2=80=AFPM Luis Henriques <luis@igalia.com> wro=
te:
>
> Hi Joanne,
>
> On Tue, Apr 07 2026, Joanne Koong wrote:
>
> > On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igalia.com=
> wrote:
> >>
> >> The implementation of lookup_handle+statx compound operation extends t=
he
> >> lookup operation so that a file handle is be passed into the kernel.  =
It
> >> also needs to include an extra inarg, so that the parent directory fil=
e
> >> handle can be sent to user-space.  This extra inarg is added as an ext=
ension
> >> header to the request.
> >>
> >> By having a separate statx including in a compound operation allows th=
e
> >> attr to be dropped from the lookup_handle request, simplifying the
> >> traditional FUSE lookup operation.
> >>
> >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> ---
> >>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++--=
-
> >>  fs/fuse/fuse_i.h          |  23 ++-
> >>  fs/fuse/inode.c           |  48 +++++--
> >>  fs/fuse/readdir.c         |   2 +-
> >>  include/uapi/linux/fuse.h |  23 ++-
> >>  5 files changed, 355 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> >> index 113583c4efb6..89e6176abe25 100644
> >> --- a/include/uapi/linux/fuse.h
> >> +++ b/include/uapi/linux/fuse.h
> >>
> >>  enum fuse_opcode {
> >> @@ -671,6 +676,8 @@ enum fuse_opcode {
> >>          */
> >>         FUSE_COMPOUND           =3D 54,
> >>
> >> +       FUSE_LOOKUP_HANDLE      =3D 55,
> >> +
> >>         /* CUSE specific operations */
> >>         CUSE_INIT               =3D 4096,
> >>
> >> @@ -707,6 +714,20 @@ struct fuse_entry_out {
> >>         struct fuse_attr attr;
> >>  };
> >>
> >> +struct fuse_entry2_out {
> >> +       uint64_t        nodeid;
> >> +       uint64_t        generation;
> >> +       uint64_t        entry_valid;
> >> +       uint32_t        entry_valid_nsec;
> >> +       uint32_t        flags;
> >> +       uint64_t        spare;
> >> +};
> >
> > Hi Luis,
> >
> > Could you explain why we need a new struct fuse_entry2_out instead of
> > reusing struct fuse_entry_out? From what i see, the only differences
> > between them are that fuse_entry2_out drops attr_valid,
> > attr_valid_nsec, and struct fuse_attr. Is this done so that it saves
> > the ~100 bytes per lookup? Would it be cleaner from an abi perspective
> > to just reuse fuse_entry_out and ignore the attr fields if they're not
> > necessary? The reason I'm asking is because I'm looking at how you're
> > doing the lookup request reply to see if the fuse passthrough stuff
> > for metadata/directory operations can be combined with it. But I'm not
> > fully understanding why fuse_entry2_out is needed here.
> >
> > I'm also a bit confused by why the compound with statx is needed here,
> > could you explain this part? I see the call to fuse_statx_to_attr()
> > after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts the
> > statx reply right back to a struct fuse_attr for inode setup, so if
> > FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
> > fuse_entry2_out, doesn't this solve the problem of needing to compound
> > it with a statx or getattr request? I also noticed that the statx part
> > uses FUSE_ROOT_ID as a workaround for the node id because the actual
> > nodeid isn't known yet, this seems like another sign that the
> > attributes stuff should just be part of the lookup response itself
> > rather than a separate operation?
>
> First of all, thanks a lot for looking into this patchset.  Much
> appreciated!
>
> The main reason for swapping the usage of attr by statx is that statx
> includes some attributes that attr does not (e.g. btime).  And since I wa=
s
> adding a new FUSE operation, it would be a good time for using statx
> instead.  (Moreover, as new attributes may be added to statx in the
> future, the benefits of using statx could eventually be even greater.)
>
> This was suggested by Miklos here[0], before converting the whole thing t=
o
> use compound commands.  So, I was going to use fuse_statx in the _out arg=
s
> for lookup_handle.  However, because the interface was getting a bit
> complex with extra args (and ext headers!), Miklos ended up suggesting[1]
> to remove attr completely from the lookup_handle operation, and use
> compounds instead to have the full functionality.

Thank you for the context and links, Luis!

Using fuse_statx over fuse_getattr makes sense to me for the new
FUSE_LOOKUP_HANDLE op but the part I am confused about is why it needs
to be compounded. If we are adding a new struct (struct
fuse_entry2_out) to the abi, why is it not simpler to just make the
new struct something like:

  struct fuse_entry_handle_out {
      uint64_t    nodeid;
      uint64_t    generation;
      uint64_t    entry_valid;
      uint64_t    attr_valid;
      uint32_t    entry_valid_nsec;
      uint32_t    attr_valid_nsec;
      struct fuse_statx stat;
  };

and avoid the compound stuff altogether? Is it because that would make
the struct fuse_entry_handle_out too big to be stack-allocated and
would thus have to be heap allocated? But if I'm recalling correctly,
the compound requests path requires heap allocations as well. Although
at that point if we're gonna have to do the heap allocation, then we
might as well just also embed the struct fuse_file_handle inside
struct fuse_entry_handle_out?

Thanks,
Joanne

>
> Obviously, I may have misunderstood (or mis-implemented) the suggestions
> that were done.  And hopefully the provided links to the discussion that
> originated this approach will help.
>
> Regarding the usage of FUSE_ROOT_ID as a workaround for the node id, I
> believe this is a more generic problem which will occur in other compound
> commands as well.  If we want to create a new file system object and
> perform some operation with it within the same compound, a similar
> workaround will be required (or some sort of flag in the compound command
> to signal this dependency).
>
> I hope this helped to clarify a bit your questions.
>
> [0] https://lore.kernel.org/all/CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_sksM=
j84xPPCMGQ@mail.gmail.com
> [1] https://lore.kernel.org/all/CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG3=
9DnVoVXMkA@mail.gmail.com
>
> Cheers,
> --
> Lu=C3=ADs
