Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC333859E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771951; cv=pass; b=YN0yW2NvUbyxtTDRFIdisDulLufx4lBTKfzcrbDIF0oQXGhHROq1eYOS+yzbjsUSQSpSmWfkW9nFCjjzgrz2kRyFnHCQZCRMhv5t0TqE4moRlP+Q5QXV3YBhjPc4e3WDJo3R9JaMLmXYt3Crc0LIWbpH39UILZ6XfndhgObJmeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771951; c=relaxed/simple;
	bh=4JL2Qt2DI3APGBXjVMBWmxHtG1SS7XNFQ/7U9dMFgQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STpFDeNl1Xspzk9bTxLiLWka7UvoQ0KzmKIcMQNOsVghCwl9c/Q3aZyo04Q0bSroJNukefZQnzm8RaEPHz7pxFm300LsFyr8+EVjj5VEyp46nD2JX+v3ISZTyn9tCkRqmeCYCh6u7Moeq22ovGBRIu6qAKIz1vlgg/UU9DIi6b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pfkfk6m4; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pfkfk6m4"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so574202166b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 04:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776771948; cv=none;
        d=google.com; s=arc-20240605;
        b=co3a5zyaMApp5GU7HKQsnGh24Djd6V41El5vJSkw5awjdOyiBelo5DR6FoIRhgh5kq
         cx2T2btar4kiT0Es2Nm7rz2IwwsjOchWLghe0zsxawdLbdjjkD6L+T1X6aSEHolI4/KY
         8ZC4PS0gF2yhqyBm6eolqORsUpDhyNgG5LAxDXhA7tpBHvC8dzcT7ve+gawtbeOGF893
         aw+pC42/8llgZ4tP30s0iAPyBv4/bHPXLiAbquHTkPvwOz5s6EJd65vj4hOtoSXrmLDH
         pjYE4kDMeckeqXlmEtZl4Bxm1iapT1IBcXL8xTKg3pALLHoLS48H5df2t1bw6Dd3wYk5
         vNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LflzsKDmyw+bWUbUd22Ntb4nFdc6v6+wToT0YyFu8zQ=;
        fh=GWyWR/SwtYN55Fsz6BHdiKEhfuPWHno3hE/R0qrvU9c=;
        b=EdFePXImmjxlxOl1ObyzOtznrKGxbjZyMnnkPGXlBZipM0j+mLJsWslHO8IhTUG2mP
         zLC0G7ihohE9Xfz4E9hej5Kvu7NVtzBzxswKxQjrXTgv6BEv5pkSs5Z20qiX4SW10t9S
         FCmo2JSGulDrqHq3N+gJn2pK73TWJr/kzrsiFEi9CANdH08uYahxB06gpcoVt6pzs2CE
         hq62yvdn0whiv1GNqz2QO6wqhW3HAwLhjr8oX2vFj+pwTEzKfH3TdD6pdTBTw8ZEU49v
         u7fnXNF5TSmWUFi0VOSAnHeoGTdg7fZWq9kS71kzsLbyqGzK/FQ2EIkFrJtkOodwL5Ey
         +2Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776771948; x=1777376748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LflzsKDmyw+bWUbUd22Ntb4nFdc6v6+wToT0YyFu8zQ=;
        b=Pfkfk6m4i1x7lnxSh4KFJxcRncKkiMta59RacLDfPE5rNK05DCwLA8Nv22x/Xy4PO9
         X75HfA7PMMX9K8jInwyWvHu9K+BtBx2JfAZeR/ymEZIppXJoL8WE5JyfvNF2xYkz2NJP
         c2ZSnCw8CHGjFQKoHk/HC6eaTuray57FfWbw78elbkrCFcqOaHVCM7TbP23dot5EdBAg
         njEhGT7rPmtyPCET7+RhDMMr/CkCo4kQ5XyYFg9zv13r0MHd3KM97WWaSMpgkJxSFG2z
         858f+hIOs/hPR3PgX3MqgGs+ueagyUEgsgGzYCGSTXy4ymy7MmT0nE2L9KBAQq8AE5pC
         rOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776771948; x=1777376748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LflzsKDmyw+bWUbUd22Ntb4nFdc6v6+wToT0YyFu8zQ=;
        b=br6spWyWANsWZyctl1msFi+2BhNZI5g9ADzqe94MYcwHLTCPS/GrGBPmju0Nv7h8Jr
         Mcm2bPnwm5OhfKtbXOq+u9YxHC4uKo5L3XJspjxbBzyB7Uv6FrOdUZl6nhBopW5C+O2n
         fpEclcoTXlogJczzW0NGE9rRxy/hprEEfl2IBwhPm6vcaZO02AIOdwTVk4MFTba5PSFD
         0b0It3I87lxbvO8A08nT4j7Y/q+Vo1l63cdbG2wOwV52Jc4wUy4Lc4/X+1aJ5ykLubx+
         5C0Vcyv4jYPUeHcNkYrxL+jzuLnkvXf9N4Wu3w0tBu0xW8GO14NjZGnIicQN2S0YrWLc
         Wzpw==
X-Forwarded-Encrypted: i=1; AFNElJ/ztm+30YiyHN//1UwmXluqdsrH4vQDehPWrh0RZlr3Hz2Zh0VWgU5uIolXlbUW8LUiBITnimmWjiVv66eH@vger.kernel.org
X-Gm-Message-State: AOJu0YztQUIbYP7dnQwbxCnXJqa//Fca6T/uN0/LfNwawbEhuGFf5Dhf
	j4O4a4mCazakq0TXdiL540psZH+k3A/gKZOMkg7+zdTmfPAZrsyacerNkZWHmo7bNwbO3XyhoPD
	ek3FR1i/ta6+4SvrCHjRiJNyWK5/bNy0=
X-Gm-Gg: AeBDietvnu9cQgN8c4J03pDh7IXVtgyh/VqiduuC/dozUSmtbdUag7kxvyuAQgSjQss
	mEhN0xY7Lr/9BTEQdTrfCpXvTdp7HSvw5iIDtleLu9/OJ/iQR/4WH14Cm8TT6G814dihiOgzQ/f
	9y+RAbuZ7676h+qB0P4imtCPr6U7r3dPzOyQ9pOFzBf7SEiv14GYGTIBRcfnjSzwXc5CNWL4aQP
	+sZDlyK9p9xoiW311r+fsVkl2pkPyrXqMTYQE8JQIgijrBJIS57v2rvvoMqFpB7JezZyOq0o/Qc
	wE79pQsk/1LicKsnGNkYNiRQ8OUW5XNjAejs8neMoR8QmJdE1Xoa
X-Received: by 2002:a17:907:72c5:b0:ba5:bef2:2aa9 with SMTP id
 a640c23a62f3a-ba5bef2333fmr620099466b.35.1776771947929; Tue, 21 Apr 2026
 04:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <20260420-zuruf-haare-988a63f85290@brauner>
In-Reply-To: <20260420-zuruf-haare-988a63f85290@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Apr 2026 13:45:35 +0200
X-Gm-Features: AQROBzBs5KcOK9VcwtwguABZxfpy_QeKqrvEBiULkwD7rK5Url8tlgJ7X-XPaes
Message-ID: <CAOQ4uxijxbY=SKRe1jtMUxPh_5B=ctZwfRMA7d+JWLCxFPG6vA@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 1:27=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Apr 17, 2026 at 04:25:03PM +0200, Amir Goldstein wrote:
> > This document is motivated by the ongoing maintenance burden that
> > abandoned and untestable filesystems impose on VFS developers, blocking
> > infrastructure changes such as folio conversions and iomap migration.
> >
> > This week alone, two new filesystems were proposed on linux-fsdevel
> > (VMUFAT and FTRFS), highlighting the need for documented guidelines
> > that new filesystem authors can refer to before submission.
> >
> > Multiple recent discussions on linux-fsdevel have touched on the
> > criteria for merging new filesystems and for deprecating old ones,
> > covering topics such as modern VFS interface adoption, testability,
> > userspace utilities, maintainer commitment, and user base viability.
> >
> > Add Documentation/filesystems/adding-new-filesystems.rst describing
> > the technical requirements and community expectations for merging a
> > new filesystem into the kernel.  The guidelines cover:
> > - Alternatives to consider before proposing a new in-kernel filesystem
> > - Technical requirements: modern VFS interfaces (iomap, folios,
> >   fs_context mount API), testability, and userspace utilities
> > - Community expectations: identified maintainers, demonstrated
> >   commitment, sustained backing, and a clear user base
> > - Ongoing obligations after merging, including the risk of deprecation
> >   for unmaintained filesystems
> >
> > Link: https://lore.kernel.org/linux-fsdevel/20260411151155.321214-1-adr=
ianmcmenamin@gmail.com/
> > Link: https://lore.kernel.org/linux-fsdevel/20260413142357.515792-1-aur=
elien@hackers.camp/
> > Link: https://lore.kernel.org/linux-fsdevel/yndtg2jbj55fzd2kkhsmel4pp5l=
l5xfvfiaqh24tdct3jiqosd@jzbfzf3rrxrd/
> > Link: https://lore.kernel.org/linux-fsdevel/20260124091742.GA43313@macs=
yma.local/
> > Link: https://lore.kernel.org/lkml/20260111140345.3866-1-linkinjeon@ker=
nel.org/
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Theodore Tso <tytso@mit.edu>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Assisted-by: Cursor:claude-4-opus
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
>
> I'm all on board with this. I think this is worth doing and I think we
> need a better process than the "just send it and see what sticks" model
> and throw the whole community off the cliff at the same time.
>
> > Hi folks,
> >
> > I am posting this patch as a placeholder for a TOPIC discussion at LSFM=
M.
> > This is a reoccurring topic on fsdevel and in LSFMM, but I think it is
> > worth having, because I do not think we have made a significant progres=
s
> > in solving the vfs maintenance burden problem.
> >
> > As much as I hate manifests and even more so discussions about
> > manifests, I think that having a document like this will at least save
> > us some time in writing the bounce emails.
> >
> > Please try not to make this a discussion about a legal document!
> >
> > Note that LLM has helped me collect the relevant discussions and
> > articulate our collective feedbacks into a summary.
> >
> > Note that same LLM makes it much easier for random people to
> > submit new filesystems, so we may need to work harder in the near
> > future on push backs...
> >
> > Thanks,
> > Amir.
> >
> >
> >  .../filesystems/adding-new-filesystems.rst    | 167 ++++++++++++++++++
> >  Documentation/filesystems/index.rst           |   1 +
> >  2 files changed, 168 insertions(+)
> >  create mode 100644 Documentation/filesystems/adding-new-filesystems.rs=
t
> >
> > diff --git a/Documentation/filesystems/adding-new-filesystems.rst b/Doc=
umentation/filesystems/adding-new-filesystems.rst
> > new file mode 100644
> > index 0000000000000..2e59b7127c05f
> > --- /dev/null
> > +++ b/Documentation/filesystems/adding-new-filesystems.rst
> > @@ -0,0 +1,167 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +.. _adding_new_filesystems:
> > +
> > +Adding New Filesystems
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This document describes what is involved in adding a new filesystem to=
 the
> > +Linux kernel, over and above the normal submission advice in
> > +:ref:`Documentation/process/submitting-patches.rst <submittingpatches>=
` and
> > +:ref:`Documentation/process/submit-checklist.rst <submitchecklist>`.
> > +
> > +Every filesystem merged into the kernel becomes the collective respons=
ibility
> > +of the VFS maintainers and the wider filesystem development community.
> > +Experience has shown that filesystems which become unmaintained impose=
 a
> > +significant and ongoing burden: they are hard or impossible to test, t=
hey
> > +block infrastructure changes because someone must update or preserve o=
ld APIs
> > +for code that nobody is actively looking after, and they accumulate un=
fixed
> > +bugs.  The requirements and expectations described here are informed b=
y this
> > +experience and are intended to ensure that new filesystems enter the k=
ernel
> > +on a sustainable footing.
> > +
> > +
> > +Do You Need a New In-Kernel Filesystem?
> > +---------------------------------------
> > +
> > +Before proposing a new in-kernel filesystem, consider whether one of t=
he
> > +alternatives might be more appropriate.
> > +
> > + - If an existing in-kernel filesystem covers the same use case, impro=
ving it
> > +   is generally preferred over adding a new implementation.  The kerne=
l
> > +   community favors incremental improvement over parallel implementati=
ons.
> > +
> > + - If the filesystem serves a niche audience or has a small user base,=
 a FUSE
> > +   (Filesystem in Userspace) implementation may be a better fit.  FUSE
> > +   filesystems avoid the long-term kernel maintenance commitment and c=
an be
> > +   developed and released on their own schedule.
> > +
> > + - If kernel-level performance, reliability, or integration is genuine=
ly
> > +   required, make the case explicitly.  Explain who the users are, wha=
t the
> > +   use case is, and why a FUSE implementation would not be sufficient.
> > +
> > +
> > +Technical Requirements
> > +----------------------
> > +
> > +New filesystems are expected to use current kernel interfaces and prac=
tices.
>
> We can be stronger here and use "must" use current kernel interfaces and
> practices. There's no need to accept a new filesystem if it would in any
> way needlessly prolong the existency of legacy internal apis.
>

Sure.

> > +Submitting a filesystem built on outdated APIs creates an immediate
> > +maintenance debt and is likely to face pushback during review.
>
> "Submitting a filesystem built on outdated APIs creates an unacceptable
> maintenance debt."
>

Agreed.

> > +
> > +Use modern VFS interfaces
> > +  New filesystems should use iomap rather than buffer heads for block =
mapping
> > +  and I/O, folios rather than raw page operations for page cache manag=
ement,
> > +  and the filesystem context API (``fs_context``) for the mount path. =
 See
> > +  ``Documentation/filesystems/iomap/index.rst`` for iomap documentatio=
n and
> > +  ``Documentation/filesystems/mount_api.rst`` for the mount API.
>
> I think we can compile a list of must-haves.
>

I think that's a case of less is more.
Getting the doc merged with minimal guidelines does the job IMO.
Adding more will not add much value IMO.

> > +
> > +Avoid deprecated interfaces
> > +  Do not use interfaces listed in
> > +  :ref:`Documentation/process/deprecated.rst <deprecated>`.  If the
> > +  filesystem depends on an interface that is being phased out, plan fo=
r
> > +  conversion before submission.
> > +
> > +Provide userspace utilities
> > +  A ``mkfs`` tool is expected so that the filesystem can be created an=
d used
> > +  by testers and users.  A ``fsck`` tool is strongly recommended; whil=
e not
> > +  strictly required for every filesystem type, the ability to verify
> > +  consistency and repair corruption is an important part of a mature
> > +  filesystem.
> > +
> > +Be testable
> > +  The filesystem must be testable in a meaningful way.  The
> > +  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
> > +  framework (also known as xfstests) is the standard testing infrastru=
cture
> > +  for Linux filesystems and its use is highly recommended.  At a minim=
um,
> > +  there must be a credible and documented way to test the filesystem a=
nd
> > +  detect regressions.  When submitting, include a summary of test resu=
lts
> > +  indicating which tests pass, fail, or are not applicable.
> > +
> > +Provide documentation
> > +  A documentation file under ``Documentation/filesystems/`` describing=
 the
> > +  filesystem, its on-disk format, mount options, and any notable desig=
n
> > +  decisions is recommended.
> > +
> > +
> > +Community and Maintainership Expectations
> > +-----------------------------------------
> > +
> > +Merging a filesystem is a long-term commitment.  The kernel community
> > +needs confidence that the filesystem will be actively maintained after=
 it
> > +is merged.
> > +
> > +Identified maintainer
> > +  The submission must include a ``MAINTAINERS`` entry with at least on=
e
> > +  maintainer (``M:``), a mailing list (``L:``), and a git tree (``T:``=
).
> > +  The maintainer is expected to be the primary point of contact for th=
e
> > +  filesystem going forward.
>
> Tbh, I'd rather have at least two but given past experiences but
> probably not something we need to consistently enforce here.
>

Absolutely. Matthew already commented and I fixed in v2.

Feel free to review the latest rev on github:
https://github.com/amir73il/linux/blob/vfs-docs/Documentation/filesystems/a=
dding-new-filesystems.rst

Thanks,
Amir.
