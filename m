Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE583822B3
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604305; cv=pass; b=JtrurLFNqw2PdvCV2OlMfb+4LV/oqtvr1X96WydFdhcMzyf1D7BlTs6wlXCiHaMSxi7syJkT/fxf+MZaXhEQIJmB7vZ7QzcFv+rzTD/BaPtnm62w9A81wibrKdbIhtcAIEpeNRsNOM8HMqLvhu2DUkBnmfGoO7flVXuXGk3OCB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604305; c=relaxed/simple;
	bh=exqN6rkqRLDExdescYzSP8pbiJJGLaUxfResu3fscss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaR+dMpu/NbkyZqcV3NfuGAHNgI6/h/M63mnXrytFvD2wkusgwnfST2Nwz+9BZA3CmEUS9GfHUsMznCRxdjkRgrPDDSdeBcSM0eMBwEzuima20xreBRej6dztGz/1H99U7NW8oEuZAuDCFQf1rri2ENdBjJGF1VuzRuIJyqXjdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg93ne9w; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg93ne9w"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf5fbacc9so134879f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 16:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775604302; cv=none;
        d=google.com; s=arc-20240605;
        b=Rd446Pakk/Nz0+DFM6v7PYGs53XE5PhNh83+zh6rsDPeD3X6LhbQV6VmFCiDMLzJey
         hg2Dp/l69jgmYEAFaaVAOFoscG79KuhF9t0+d9gtz+UYQ4dOGo7YokNnzKjvg++iSQaU
         z74MoFcUU7GEFi3yR3k5bxkv3I1eSoai1/9xJtLRV83gwwnLh1T8oxj8IjpXxqKaDr9d
         X6Ahgd3uJvVDTH97TRVIt0lbdCvIPfjfDytMvX/H2NJkB2htivSABbJNsYg3pokERpVA
         jm3dZ9SO8GdtlRc5N8MnCC0vIp2DsAwyom84o/wg7wZ4RsZBcLYB5615syfqVzypPPG6
         6OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3wvxM84nvgbKdJfBPBEzVKOZ9SDXKB/Yb4VCnm/djm0=;
        fh=c1b+JJrDEoye72XIxbVzd5XkP+BTGTKuf/hSOYUC8NE=;
        b=iz8+ntYlIjMX9RYRO5VMs2+1Khy1lcNsPFijEl6l2DdPGqEs1OzynnmRdMBAZW98vw
         bXGPjA8EbM6nOJUKHsLuUolwf+8clYhWf3XoKpe64idSRL/q9UhClFnQOPl2tFyCkFXV
         WWx+Vvo7EJxL6aMpFvYo/3bmTSQSLrvW9UL0fCjS7QQApX/h8EHU91L8zT79HuzUl1Q7
         PbdAFBiItK9o84LUHRbpmuP63cO8o14GhdCGFZ2GF2o6at7Lz6ow/JO0k7B15yrA1lvU
         5qMu9eW6BnGt5RadRairUhzFrh8aPn1cgMLJ8l1CjhvegFP1MWs912G5UBLk7fPnnvYb
         jLRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775604302; x=1776209102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wvxM84nvgbKdJfBPBEzVKOZ9SDXKB/Yb4VCnm/djm0=;
        b=Dg93ne9wcAn5R5WfELWGFQoL67+40uzFNqvgkTOjkz8h7Bv062WwEXb0vw6pSQGcQJ
         0d9vQkSlBet3Ay2CFAGBMXWcpzX1Re9ZLofuRmXuunKjjwuK6O4GDBRjrKG1TEQu4lwo
         exPz0uUznJMhFcNin6pmI94hdgqW8bwKdELqEfhNo9P4V0fQeT4yBZfuZhBIxwTRPhpJ
         Km6Lhs/4cNL5KLflu521ertVpjlRfiMuxYr8B96547DoTyXxNqZIH4EOkTKWu7JnmOf0
         1IXynlkOUm97fEFYN3cjUWTsoODXHjk5VQUwMAdSbS/xXQKeagIyVAhrAtQ6OqJnWeFm
         W7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775604302; x=1776209102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3wvxM84nvgbKdJfBPBEzVKOZ9SDXKB/Yb4VCnm/djm0=;
        b=jf/9DxyRMBwWJAp4nzNmnekexfLlSQrEAz2UxdtvfAGiz4lKXyuUJKulYGQKUAXqFo
         bEEVlY3IxuXg0BduiklfV3ANo56wIemFQzU6OpnQUtZcOArOsOZTevLQeyROQqgPa9Rl
         9vFqSIzfQrXJcIvMVXMSv0lm2dvF6ru2zj5gxOJH2WTXwP0sy3NoFU7PJjwukhRvKWUr
         5DdkkwEKO2uU7D5gO7OapoqtGEdFC5mfurPQYU2LM5Fkwox85NbITnmbj2oJlJvPmfdj
         JGre6lS8L91B71JH3EXoY31AW0B5a7hR+Llgufn2DzslX1Mc0t2X8rscU15Hi14gDaH5
         ZQxw==
X-Forwarded-Encrypted: i=1; AJvYcCXFSUtYTZPDwM7x0Z++Ywq4VAFC0u4c/wwgANGmBRWoUsvn4E1oAndVsBQR3AOvKcYpcVsn54EDOYxSa3fB@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2c0xhU7AHO9XWNNYAUdDLzSAgfyeVuYgn++xkJdkq/Pe9ErN
	WmyqGz9AACymGXuqToy0hRJkDmX9UDnQIjldVk9JfNlXit2Jw47MycnNrZOyqg5ja9yC8ZD/vup
	dX1YoKw6DJSMzyv4gtIyVGN9Nm68f8eg=
X-Gm-Gg: AeBDiesBnMI+BppGbba496qRqoAo1ZCQMcZ+SMBu+W4wuC3aQQrtt4Q/ss/tKKIyhwr
	AUAvy4jDPBl6iuKuUyhy0Yi4PP6ZjI8Sw1p5pEqXwhapXjjckIS0uuCYlkhN42SMuSEnjS1Ofw3
	PKPM0UnXpFLaL1bKiNB2g55QfkN2nxdraebyH1UY0QTMa6pt1FQc7HQbmTf4L0SMzQbvJTegUzD
	RofVQISkaXJqWs5SHuttxjyiT0uwGgdQszChry7WyGASCiCVhSopCkAVBFL+HN4kqkadjik2lga
	y95mEg==
X-Received: by 2002:a05:6000:160a:b0:43b:8e96:d3d2 with SMTP id
 ffacd0b85a97d-43d211927eemr22267712f8f.13.1775604301502; Tue, 07 Apr 2026
 16:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
 <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
 <87v7e24gdw.fsf@igalia.com> <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
In-Reply-To: <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 7 Apr 2026 16:24:50 -0700
X-Gm-Features: AQROBzChyjIp4PuMBOixTe8oeAIiAopPeTuIaIi5sbskiFyiiOLGOBhYq4fVqF8
Message-ID: <CAJnrk1b9CkQ0i6FdFvxcKbhS7K4TG5yQKbnEXV=Hc+ry593KoQ@mail.gmail.com>
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

On Tue, Apr 7, 2026 at 4:06=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Tue, Apr 7, 2026 at 2:20=E2=80=AFPM Luis Henriques <luis@igalia.com> w=
rote:
> >
> > Hi Joanne,
> >
> > On Tue, Apr 07 2026, Joanne Koong wrote:
> >
> > > On Wed, Feb 25, 2026 at 3:25=E2=80=AFAM Luis Henriques <luis@igalia.c=
om> wrote:
> > >>
> > >> The implementation of lookup_handle+statx compound operation extends=
 the
> > >> lookup operation so that a file handle is be passed into the kernel.=
  It
> > >> also needs to include an extra inarg, so that the parent directory f=
ile
> > >> handle can be sent to user-space.  This extra inarg is added as an e=
xtension
> > >> header to the request.
> > >>
> > >> By having a separate statx including in a compound operation allows =
the
> > >> attr to be dropped from the lookup_handle request, simplifying the
> > >> traditional FUSE lookup operation.
> > >>
> > >> Signed-off-by: Luis Henriques <luis@igalia.com>
> > >> ---
> > >>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++=
---
> > >>  fs/fuse/fuse_i.h          |  23 ++-
> > >>  fs/fuse/inode.c           |  48 +++++--
> > >>  fs/fuse/readdir.c         |   2 +-
> > >>  include/uapi/linux/fuse.h |  23 ++-
> > >>  5 files changed, 355 insertions(+), 35 deletions(-)
> > >>
> > >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > >> index 113583c4efb6..89e6176abe25 100644
> > >> --- a/include/uapi/linux/fuse.h
> > >> +++ b/include/uapi/linux/fuse.h
> > >>
> > >>  enum fuse_opcode {
> > >> @@ -671,6 +676,8 @@ enum fuse_opcode {
> > >>          */
> > >>         FUSE_COMPOUND           =3D 54,
> > >>
> > >> +       FUSE_LOOKUP_HANDLE      =3D 55,
> > >> +
> > >>         /* CUSE specific operations */
> > >>         CUSE_INIT               =3D 4096,
> > >>
> > >> @@ -707,6 +714,20 @@ struct fuse_entry_out {
> > >>         struct fuse_attr attr;
> > >>  };
> > >>
> > >> +struct fuse_entry2_out {
> > >> +       uint64_t        nodeid;
> > >> +       uint64_t        generation;
> > >> +       uint64_t        entry_valid;
> > >> +       uint32_t        entry_valid_nsec;
> > >> +       uint32_t        flags;
> > >> +       uint64_t        spare;
> > >> +};
> > >
> > > Hi Luis,
> > >
> > > Could you explain why we need a new struct fuse_entry2_out instead of
> > > reusing struct fuse_entry_out? From what i see, the only differences
> > > between them are that fuse_entry2_out drops attr_valid,
> > > attr_valid_nsec, and struct fuse_attr. Is this done so that it saves
> > > the ~100 bytes per lookup? Would it be cleaner from an abi perspectiv=
e
> > > to just reuse fuse_entry_out and ignore the attr fields if they're no=
t
> > > necessary? The reason I'm asking is because I'm looking at how you're
> > > doing the lookup request reply to see if the fuse passthrough stuff
> > > for metadata/directory operations can be combined with it. But I'm no=
t
> > > fully understanding why fuse_entry2_out is needed here.
> > >
> > > I'm also a bit confused by why the compound with statx is needed here=
,
> > > could you explain this part? I see the call to fuse_statx_to_attr()
> > > after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts th=
e
> > > statx reply right back to a struct fuse_attr for inode setup, so if
> > > FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
> > > fuse_entry2_out, doesn't this solve the problem of needing to compoun=
d
> > > it with a statx or getattr request? I also noticed that the statx par=
t
> > > uses FUSE_ROOT_ID as a workaround for the node id because the actual
> > > nodeid isn't known yet, this seems like another sign that the
> > > attributes stuff should just be part of the lookup response itself
> > > rather than a separate operation?
> >
> > First of all, thanks a lot for looking into this patchset.  Much
> > appreciated!
> >
> > The main reason for swapping the usage of attr by statx is that statx
> > includes some attributes that attr does not (e.g. btime).  And since I =
was
> > adding a new FUSE operation, it would be a good time for using statx
> > instead.  (Moreover, as new attributes may be added to statx in the
> > future, the benefits of using statx could eventually be even greater.)
> >
> > This was suggested by Miklos here[0], before converting the whole thing=
 to
> > use compound commands.  So, I was going to use fuse_statx in the _out a=
rgs
> > for lookup_handle.  However, because the interface was getting a bit
> > complex with extra args (and ext headers!), Miklos ended up suggesting[=
1]
> > to remove attr completely from the lookup_handle operation, and use
> > compounds instead to have the full functionality.
>
> Thank you for the context and links, Luis!
>
> Using fuse_statx over fuse_getattr makes sense to me for the new
> FUSE_LOOKUP_HANDLE op but the part I am confused about is why it needs
> to be compounded. If we are adding a new struct (struct
> fuse_entry2_out) to the abi, why is it not simpler to just make the
> new struct something like:
>
>   struct fuse_entry_handle_out {

Thinking more about how passthrough will use this... I'm thinking
something like this would be ideal (though please correct me if I'm
completely off track here, Amir):

  struct fuse_entry_handle_out {
      uint64_t    nodeid;
      uint64_t    generation;
      uint64_t    entry_valid;
      uint64_t    attr_valid;
      uint32_t    entry_valid_nsec;
      uint32_t    attr_valid_nsec;
      int32_t     backing_id;
      uint32_t    flags;
      struct fuse_statx statx;
  };

where if the inode is not passed through, the kernel uses the stax
field for the attributes but if the inode is passed through and the
server sets a bitmask specifying that attributes should be derived
from the backing file, then the statx field will be ignored by the
server and kernel).

Thanks,
Joanne

>       uint64_t    nodeid;
>       uint64_t    generation;
>       uint64_t    entry_valid;
>       uint64_t    attr_valid;
>       uint32_t    entry_valid_nsec;
>       uint32_t    attr_valid_nsec;
>       struct fuse_statx stat;
>   };
>
> and avoid the compound stuff altogether? Is it because that would make
> the struct fuse_entry_handle_out too big to be stack-allocated and
> would thus have to be heap allocated? But if I'm recalling correctly,
> the compound requests path requires heap allocations as well. Although
> at that point if we're gonna have to do the heap allocation, then we
> might as well just also embed the struct fuse_file_handle inside
> struct fuse_entry_handle_out?
>
> Thanks,
> Joanne
>
> >
> > Obviously, I may have misunderstood (or mis-implemented) the suggestion=
s
> > that were done.  And hopefully the provided links to the discussion tha=
t
> > originated this approach will help.
> >
> > Regarding the usage of FUSE_ROOT_ID as a workaround for the node id, I
> > believe this is a more generic problem which will occur in other compou=
nd
> > commands as well.  If we want to create a new file system object and
> > perform some operation with it within the same compound, a similar
> > workaround will be required (or some sort of flag in the compound comma=
nd
> > to signal this dependency).
> >
> > I hope this helped to clarify a bit your questions.
> >
> > [0] https://lore.kernel.org/all/CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_sk=
sMj84xPPCMGQ@mail.gmail.com
> > [1] https://lore.kernel.org/all/CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uz=
G39DnVoVXMkA@mail.gmail.com
> >
> > Cheers,
> > --
> > Lu=C3=ADs
