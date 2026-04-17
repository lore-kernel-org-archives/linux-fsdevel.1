Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2CB2DB781
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444308; cv=pass; b=rTXmIfLE9zRL6q4HGqT11SCAlOL0bocoNLv+3QWQNro16r6YbjVAQNSMc3rWqpWmssIAN2eiKvkpfIUDfPPZ/x+wKboQrdDEslJuI+IcTuaZpBMSCSmYWI8TcX0anE6ZlmXUerYf9b+E2b9ANPKxdCligxX8SOpwrAdddbafELM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444308; c=relaxed/simple;
	bh=Vt/A3MUvgCHrmIHQvKKv6jL/gxilWMx+ccgjO4X/Vd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9+IdaXKwCTVg6yn/SxuZNCf8IhodLkgl+vit6Iys1HCRoq9B9D4JdyGP9aWdN4XesnFXOCu0mx3wB7dvSodAdSgLCmMi2T373UJa2Qcr8OAmixHjUFdFcTZOdswqxkFl5SqlGoF57qfHTi+0BSs9ESEqAesPVTAWj7GXFeyrKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U06lYrcR; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U06lYrcR"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba51e69988aso31891366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 09:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776444304; cv=none;
        d=google.com; s=arc-20240605;
        b=ZUpEuG2D2PfKx+NJwvDSVyGGyBr0Cs2Z1NQg+kSiIO0D+/214G2HCZLMe1e61E8KXQ
         lEsor+RtcwdFlHhMzripkgLhrYLFIxfr6NZt0wS6uV+5MoQgzvHoBfOt7tyHdn9qOw2f
         xHxJsMCkVce+xGnLGW6uLTVsGm/n6RSZkoJD4GTojYvqDyWqmOXqLX094kL07Qx3pLOx
         RBC6DniDCih/yQVCvYBaMwXHDH1XNyvTzqx/jag6G7eYAJ09FiwSr9NS86t3jHUjyqDR
         nnrPbRLuonLzFnuzOXAZUkxFu46/1GqL050f04DmW1xRWVGsQxj0Xgbj4T3ZTrHdHm8n
         G4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ySvU+LPo8rIwh5CFxy9WSfOn4ifdsYseV9kEDrZq4mo=;
        fh=eJUexru9r6feXSy34xernBGEvEZZwBvBEChb/3ZQQBc=;
        b=EPHAWaa5Cb3s58SrL7fr4V5I5v04RGiBAv58pzgCXhK+e+0ysqqH8VjmfR7HeFKWVJ
         wf12IK3842fEc4AAJN4CduzbaRR/H4xEcZeIIGZh7aDXnAz/3zPQ/S1KsY5NRKqd0zuw
         PqE5J74EWYdvnbnTy+uSvT0edGifbRWx5LvaVBwIxOQpOFLYd/y4xFlWagNQGHPiu7Db
         vBN/vxFyFZ15ZxBqnT9nDJL8ahkNa4CCkJ0jPcXUq93TJBqaD1DYsAV0oRjY8h0UgmyL
         u+H3YhFhc3+YCOLd4859melDB7aLdA8VAG0BycXdVN/cTkiSqkbb1PQ96NPlsrU3kVtZ
         VAGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776444304; x=1777049104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySvU+LPo8rIwh5CFxy9WSfOn4ifdsYseV9kEDrZq4mo=;
        b=U06lYrcRCibPeJVLkzQiGOKVKyr4Vzy8GS9hyVIYaNDaAy7KwWGW+qA0Hkq7HDLaev
         sC3jPTRs8stTqGp09eeppnHuitNbn73Q+hKj8kwBJgwFA8eUH3hEvTkw+f6KtCF9Li7v
         7DlLcDclqDOOc1GC4pC7Vg6wl4H1X2032WeVMKm8mp0K6rfzhCSVR1ajPRGLNOKqMuGV
         V+dkaNnp0AvWn4UKeWZXG3fJn6btUnV4kXVPJ3N9DMY1rMyI4G29JULEEHKkEUXFIbKT
         XCP0SWjKDXrh2ysxBUVY6HbaZqKnwzM+94c6KBCvtKitUO0VBHDFjzu2TqMXxe00ar/O
         YmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776444304; x=1777049104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySvU+LPo8rIwh5CFxy9WSfOn4ifdsYseV9kEDrZq4mo=;
        b=gwVJ4etraBxC30RDa2xOlstOZTUvjHYg5dmgmn5b9IVOyvguWqSn3Eydf94QRd5MuP
         uMnbDltnetKw0EL34JU0mNuL5uE2PB48Gy3mIN9NyaBPsWsKfKiCtQcu/A/RX+8+lONK
         C46ALwKSbm3nP20ZL9wPGteKoRw5Q5pWMg61p5RYF3huqnGubJEy5iSc788wxPl5Lyo9
         tSTROzpNqDhByLjccnd6pg9DMZVftnjMl5GrZN+pvs6hrunbcMK0n8WLLPe54udud20J
         Y0WX52KAAHE7Hia8oUCKbo7rAotJiVN9vPNvrmzLYTrqsAi+H0g2UvENLzJ3FXJiYbCq
         QkOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/+XfhNLkB9PTsHAlgt4l6Ub9TrPpee8JnvMf/olvuO8uzgx5+Gvqr9+QeuHkn/8yxShQ/e3nrqTIUrToQ@vger.kernel.org
X-Gm-Message-State: AOJu0YylZ5pOG+JX8m2m40rrY8JcYP2UmA9Ns2+j8odhOT/6ojpO8IXj
	8VMg+qSqKybdnzA19j91pMaCJdo+VwEhYAnJaqTSVEeu8/nD6FFjxoWD6p+4wKkNhW0vM4DZmGh
	w3r7xfZA/OkWEtC/lrDFRIg81wKTS6+M=
X-Gm-Gg: AeBDiet1FURvYeg5HlQ9iXB2xpfXhAgIxT57Pi8ZSGss+bGN8iL40UGoUaXbckUZOj/
	yzne4b1WEEjxbr6sZJyPiDHXwjBZbRyFX2uUuqAtMOVdN1S8EGzHFs/PvRT5CAafTHQI8PkYXkQ
	IjP0Jq/cuPiabZdvJQm/q90dczWsbkvk3FcBkmTUSeou6CIrdBoUT0EDbaQCfGa1zVkIURKoOuZ
	5sBVPKBLE2ItYjpyDgSpOcgTc8husW5NRfOkMQLkhocnLu65ZfFLOKe5Y9IkcgmpS3/M01412EF
	/mvPy667dd+L5TiHk81FTS7zRNRLmVYwroPMOQkkAYV6jjevS4yC
X-Received: by 2002:a17:907:6d08:b0:b98:40a3:aa0c with SMTP id
 a640c23a62f3a-ba41a632ec1mr190875666b.24.1776444303116; Fri, 17 Apr 2026
 09:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <aeJTecsykkHMSvNh@casper.infradead.org>
In-Reply-To: <aeJTecsykkHMSvNh@casper.infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Apr 2026 18:44:51 +0200
X-Gm-Features: AQROBzBGKSK0J4JpMY3lTn9skAMaLMgevzs5JPIg49t47JZjL2w5d5qB37fGef4
Message-ID: <CAOQ4uxhhoWX90c-DT0oJMXY=oN8vTmmwM1tGRJAv2AqwfYG=tw@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 5:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
>
> Thanks for getting this discussion started.  Some thoughts inline ...
>
> On Fri, Apr 17, 2026 at 04:25:03PM +0200, Amir Goldstein wrote:
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
>
> It may also be worth linking to
> https://en.wikipedia.org/wiki/GVfs as an alternative to writing
> an in-kernel filesystem or a FUSE filesystem.  Very much depends what
> one's goals are.

I rather not.
Feels like saying FUSE is enough of a code name for
You may not need a kernel fs
I don't feel it is our place to guide people more than that...

>
> > +Technical Requirements
> > +----------------------
> > +
> > +New filesystems are expected to use current kernel interfaces and prac=
tices.
> > +Submitting a filesystem built on outdated APIs creates an immediate
> > +maintenance debt and is likely to face pushback during review.
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
> > +
> > +Avoid deprecated interfaces
> > +  Do not use interfaces listed in
> > +  :ref:`Documentation/process/deprecated.rst <deprecated>`.  If the
> > +  filesystem depends on an interface that is being phased out, plan fo=
r
> > +  conversion before submission.
>
> Maybe these are one section rather than two?
>
> I'd add "If it's a network filesystem, consider using netfs, or be
> prepared to explain why it's a bad fit for you".
>
> Similarly if you have a block filesystem, and need functionality not
> provided by iomap, be prepared to explain why adding that functionality
> to iomap is infeasible.
>
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
>
> I kind of want a section on "no weird ioctls".  Anything you want to
> implement beyond ioctls already implemented by other filesystems,
> you need to bring to linux-fsdevel as a separate proposal from "please
> merge my filesystem".  Almost anything implemented by f2fs is a good
> example here.
>
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
> Preferably two maintainers, although even that wasn't enough to save
> bcachefs.
>
> > +Submission Process
> > +------------------
> > +
> > +Send patches to the linux-fsdevel mailing list
> > +(``linux-fsdevel@vger.kernel.org``).  CC the relevant VFS maintainers =
as
> > +listed in the ``MAINTAINERS`` file under ``FILESYSTEMS (VFS and infras=
tructure)``.
> > +
> > +Expect thorough review.  Filesystem code interacts deeply with the VFS=
, memory
> > +management, and block layers, so reviewers will examine the code caref=
ully.
> > +Address all review feedback and be prepared for multiple revision cycl=
es.
> > +
> > +It may be appropriate to mark the filesystem as experimental in its Kc=
onfig
> > +help text for the first few releases to set expectations while the cod=
e
> > +stabilizes in-tree.
>
> I'd like something here about how to structure a submission.  It's
> neither acceptable to send one big patch containing your entire
> filesystem, nor do we want to see the entire history of development over
> the last eight years.
>
> Instead split it up by topic.  Superblock, inode, directory handling,
> address_space, ...
>
> > +Ongoing Obligations
> > +-------------------
> > +
> > +Merging is not the finish line.  Maintaining a filesystem in the kerne=
l is an
> > +ongoing commitment.
> > +
> > + - Adapt to VFS infrastructure changes.  The VFS layer evolves continu=
ously;
> > +   maintainers are expected to keep up with conversions such as folio
> > +   migration, iomap adoption, and mount API updates.
> > +
> > + - Maintain test coverage.  As test suites evolve, the filesystem's te=
st
> > +   results should be kept current.
> > +
> > + - Handle security issues promptly.  Filesystems parse complex on-disk
> > +   structures from potentially untrusted media and must treat security
> > +   reports with urgency.
> > +
> > + - Filesystems that become unmaintained -- where the maintainer stops
> > +   responding, infrastructure changes go unadapted, and testing become=
s
> > +   impossible -- are candidates for deprecation and eventual removal f=
rom
> > +   the kernel.
>
> Interact with other filesystem maintainers.  They are not your enemy
> although they may compete with you for users.  There are opportunities
> to share code, share approaches to fixing problems and share features.
> It's inappropriate to hide away on your own filesystem list and pop up
> once per kernel cycle with a set of patches that nobody's seen before.
>

Very good feedback!

Pushed commit with the changes v1->v2 to:
https://github.com/amir73il/linux/commits/vfs-docs/
so you can review the incorporated changes.

GitHub also displays the doc in a ReSTy way that could be nicer for doc rev=
iew:
https://github.com/amir73il/linux/blob/vfs-docs/Documentation/filesystems/a=
dding-new-filesystems.rst

Feel free to comment on github if you have editorial fixes to suggest
before I post v2.

Thanks,
Amir.
