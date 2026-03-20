Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D03CFF7C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027131; cv=pass; b=G7Nl7tyuA1mtHDdlavYuUYIGFICYZ+IRWxZqR5r9zh2dwEbPjPijQuTgdJhPsRG8AJJH4xmUcTeBnJ5i6DXapFAPZOiejnRGpku4DA4vRdmIQ4sEuzMxZZ8QLhsMAtBdzLj+lWTBbg91LUTVKdAA1927OVVvVtdAd53PZtWjGSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027131; c=relaxed/simple;
	bh=5/M/GSgdy2iD6956IohJbQ5eJFj+4someJVMQge8wvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BybhLC+YABjcgkMczg1sjObOA3DX1L0MgbFUqqHOqRIyrc+SBjnlc8+BKL0tYJLVU3kQUsXSY6fGLTYUXbZBZ+9BJF/hVAFBQf4nJqtiamoVn6dV++JKfqeV81l6luBSjJinCjEmsE6/TySQmySRe5U6SB30GMjQuN4YNOJ9G7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoeqSbdp; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoeqSbdp"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1487151f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 10:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774027127; cv=none;
        d=google.com; s=arc-20240605;
        b=BfxwERQvrqLMAX5MrEdfhEcw7Sr/3KXZIO4GSoI2wuK/SoMGGwZHTSscypE0h8Va5C
         G/WtbdUaYugx3VwpmEd5ZoAsRlq//XOP7gL1OO2I37bAchZEfgBix3pbjqbjvxS5LEOe
         St3uQZM1SmnBKJ2OMUTya58CEeB89fYwr9q3DINoHZK+p7DgOF5TukmobR7E7ISFb4p4
         RrS4xr/MVwimkHRkpYKH28cVov/Iz/DZyJEKU86fOTAyNwzKsYcd4xEjlzA0YrEDN9Bo
         7xTXQ+MnCNX41V+VzpL1OAXclKAauXM0BUjgAQRgaQlUjJrXrFifJWlSg4YAsdyUlasd
         tATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/M/GSgdy2iD6956IohJbQ5eJFj+4someJVMQge8wvY=;
        fh=vCFLvRB2V8OvcopT5utd4JwGsc1mhKOBcLwS//O1aVA=;
        b=D9Am29nl+gYncP5PfrC/zxWdnIRXz/fcBDxmNBp4GjMKKOkF7GllwF2qhDeAt4Q0q8
         YDN1H5XRvMRLuVNYiOv6UMHsTtl1QUWWPdib0u0L5Hjg633dAP98N5kdFVhQYs1tCF4V
         3eO7fIBQQFKtLq8LLV2xIX/l8T9Ti44zvuHoja6lz/CInn8Sx/Cg3BlBRQzSGVGhzvOm
         f3upurZQwA9WTVu+K6puZxe2J4eVoeF/vYYxohpmVa+No9IYjJeWixkoN1r65IL98AnA
         +Ajar5Qjp+LtSPEhd/X6wcBzw7HkN5yi88VB54yT8uCwuijH6LH/8rPPBCDMtoo0MzsH
         BmiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027127; x=1774631927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/M/GSgdy2iD6956IohJbQ5eJFj+4someJVMQge8wvY=;
        b=OoeqSbdpmgrPd7/ggT0wMOWL/3yPAL0prYotcaifn5say+A1LrlrU/0OdpbZNHCMiA
         FLWa0LiV2cbaciSJkVUn1L+vwQUJEPReZ1Vl0vM8heU+yqKKOPIughzAdxZxmW2Hwt+u
         nxHOqRenDKeerAycsgafFB6w96GyjWYePdwwESHw5GH0m3kWVh+1ekc2+Y4xwOylEQ6U
         BvyLlnPpMcLhqch3zUgf+npC/CU6pDCiA6bPMAzC58rC+4W9Gls+994FUCVm9UsoyKeV
         a9katfsoC7rV/4PcJ2+Dcszx/c4XwU6Rd28I6lDoUj7TVEw4KE1PdZbyvy/n82U8VwGe
         mPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027127; x=1774631927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/M/GSgdy2iD6956IohJbQ5eJFj+4someJVMQge8wvY=;
        b=rrXcCpXQHDptY84kLMMsEDnajvOL1OtRMuSgdoPUsEyFZ3zcVC8UQWBMIanbWymoDB
         dFjMiLjoV72RhRpsahkugI4q6lOk4HEtgRlCc+tyl4z96FPyY80i5r9kwxxv4n4nlt/f
         TqUQMyEMPoqEhPCOJ6iwZ2+6Dx99hsgNivK7fzEUoM1xM08pnlKkhI0ysUXYvhU/KkEL
         615GT8MB+RATdoSEdOP4zVAMpOKuXfi64fOW6H6tkNeIi/VuLxeUL3Yte+kW6e+56ZG3
         1rQtHzSwWNiw0Gh5VO0QTlS2YCKqYnT5jeRoPuyQ5OzgxbKoxyunbeD96smrn6bZ24FJ
         aYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Cb/xgZ4FyyE2RfT0CC3ZEbe9iyBDXVciVam2N8XpfUeJd0Xn/kRPpZdaHf/0sSWt5EDCk4qJ5lzt1HsI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsft8jJnGtRNFPbq2LtGz3cXLzXYm5CL3uQmJeV1l6n7xaKKRz
	u+JSCMw+pRxM924QXP6wJrIGu/Nvp8nHH/xdINZzh8vGvVOZxVqe5UfSsw9YQ98jpewEKhCgtMz
	7fyhqPOwcUfKa0tHMNPahOLdmhnUNeWs=
X-Gm-Gg: ATEYQzx1rWZkZ8odqu2TwFN56VpvNjyGyZF7Voup+5M58/jrMYrsEvVRYjMYhHyZe40
	58rnIscMH5+/bFkqdz7fvXuGfbXKNCRc3uThP5UF20+mr+Bc4XGJpDG9Ygs6y0Y/fFOQ3b8LxGr
	ahgObvsOSKiXo5PSqn/jxHuBNSzTMdczhSxFJl4/+9EKyLm/rMRU14NJhsLL+locRZawbvDKL5l
	lEN/9oOGFvHwPtOt3MfV1iU2O6HQjJUjdQajlP5mgzK9h2TEl9C+csPySPP1xp7/2U1mn8LvsD+
	Pw1f9g==
X-Received: by 2002:a5d:5f86:0:b0:43b:5356:a7f7 with SMTP id
 ffacd0b85a97d-43b6423db79mr7020231f8f.9.1774027126966; Fri, 20 Mar 2026
 10:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
 <abhg4tbxDhYO_iHV@fedora.fritz.box> <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>
 <abqvmS4adTXVxFIW@fedora.fritz.box> <CAJnrk1bF0JFAWOF=4hjMhiciSLrvob268fcQgv3P28Po8J=qwQ@mail.gmail.com>
 <60103445-0d45-427c-aa00-2fa79207b129@bsbernd.com> <CAJnrk1aWgWxzh0ETFkZXvJcfHFAC8KESEBLXa2S=ZqDfSSssvA@mail.gmail.com>
 <abuw1Z40Dg9Rp4Vj@fedora.fritz.box>
In-Reply-To: <abuw1Z40Dg9Rp4Vj@fedora.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Mar 2026 10:18:35 -0700
X-Gm-Features: AaiRm50qDRt3MPV1aIK9aInJ-Js-6qEVKx9sfcSJUOgQzr7o_3KzUBSjttlNbF4
Message-ID: <CAJnrk1YJZnk4MOL+EgzcyAYhY_++OCs94USppA4iHDOAw0TAzg@mail.gmail.com>
Subject: Re: Re: [PATCH] fuse: when copying a folio delay the mark dirty until
 the end
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 1:32=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> On Wed, Mar 18, 2026 at 06:32:25PM -0700, Joanne Koong wrote:
> > On Wed, Mar 18, 2026 at 2:52=E2=80=AFPM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> > >
> > > Hi Joanne,
> > >
> > > On 3/18/26 22:19, Joanne Koong wrote:
> > > > On Wed, Mar 18, 2026 at 7:03=E2=80=AFAM Horst Birthelmer <horst@bir=
thelmer.de> wrote:
> > > >>
> > > >> Hi Joanne,
> > > >>
> > > >> I wonder, would something like this help for large folios?
> > > >
> > > > Hi Horst,
> > > >
> > > > I don't think it's likely that the pages backing the userspace buff=
er
> > > > are large folios, so I think this may actually add extra overhead w=
ith
> > > > the extra folio_test_dirty() check.
> > > >
> > > > From what I've seen, the main cost that dwarfs everything else for
> > > > writes/reads is the actual IO, the context switches, and the memcpy=
s.
> > > > I think compared to these things, the set_page_dirty_lock() cost is
> > > > negligible and pretty much undetectable.
> > >
> > >
> > > a little bit background here. We see in cpu flame graphs that the spi=
n
> > > lock taken in unlock_request() and unlock_request() takes about the s=
ame
> > > amount of CPU time as the memcpy. Interestingly, only on Intel, but n=
ot
> > > AMD CPUs. Note that we are running with out custom page pinning, whic=
h
> > > just takes the pages from an array, so iov_iter_get_pages2() is not u=
sed.
> > >
> > > The reason for that unlock/lock is documented at the end of
> > > Documentation/filesystems/fuse/fuse.rst as Kamikaze file system. Well=
 we
> > > don't have that, so for now these checks are modified in our branches=
 to
> > > avoid the lock. Although that is not upstreamable. Right solution is
> > > here to extract an array of pages and do that unlock/lock per pagevec=
.
> > >
> > > Next in the flame graph is setting that set_page_dirty_lock which als=
o
> > > takes as much CPU time as the memcpy. Again, Intel CPUs only.
> > > In the combination with the above pagevec method, I think right solut=
ion
> > > is to iterate over the pages, stores the last folio and then set to
> > > dirty once per folio.
> >
> > Thanks for the background context. The intel vs amd difference is
> > interesting. The approaches you mention sound reasonable. Are you able
> > to share the flame graph or is this easily repro-able using fio on the
> > passthrough_hp server?
> >
> >
> Hi Joanne,
>
> I have tried to reproduce this with passthrough_hp and I never saw it.
> So my answer would be something like: I don't think so.
>
> This happens even with large folios disabled. I was just trying to
> solve it, since I figured it will be worse with large folios.

Thanks for the context. I haven't encountered this bottleneck myself
(yet) but if you are encountering it pretty regularly, I agree with
you that it definitely seems worth addressing.

Thanks,
Joanne

>
> Thanks,
> Horst
