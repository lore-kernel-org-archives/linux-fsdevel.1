Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7C23535E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042632; cv=pass; b=I6R9BDw9meegBNg3/rWlW3Ke149wCRYxQI+fK0XyP3XeOzIBu+KD2QeVpxv00ATSMEESFXAwk37VKYMSRx0X9HOYLkXT8qaDAK7TOFBpZ29aIHj6MDG4CPlJiXiyeklxsM9+FryELsNOmoFA9Qsrqwaxmw0KijClwZuvLwLaiAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042632; c=relaxed/simple;
	bh=YMafmxr+u+dHYErOVxj/FNmniwqg1vVnRq/lLcyl4cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KerGiUGMa6Aqm4OjpLyTolKGcrncpG8P6n8zR8ukDcGQfeu2Jc0X1Ba4tbFCT1WOGuDnffLIdTZJ5eW1crtL1UXLdvQeN8+ewSKG50eVAMPKXbSYStbHTIZwqHysnVrS6CSfwjL6mEeYGBcg/zKABTcCsc1yZm+tgJa1GRzEClY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSLPPSxW; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSLPPSxW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-472055b0efaso36049f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 18:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783042629; cv=none;
        d=google.com; s=arc-20260327;
        b=S9rNmuc/nY+bSSVxHaJJUsKZBSnYV5J3ez7Tzeo27xMLQhKClm7D8t0dCEqLzORO9o
         7ZouTHAGvIENkMKLqXLxpNTgp+tcjvVWcibNXnNaPovRo0EFi6RvUf6IpRAimg0P5EHm
         5xD6ZQhZIDBDUAJz/xnBe9564LPjorL4UyxdmKTSkRsY1QdzIZNbqHKo5OUeZZNDoESA
         Cm4/C2B4upjxRyj5ZyeZ60nx6aZIvVGqCJ6oRugNwQIFyvCdEWUx9u+6P29M+cgL6iLV
         g1w70YDtUvBtmXeA89cJSbU5xdIdPVyDmM5NroShmCIlG0liTG0jHEoOm+9f5v90BZb8
         OAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tNl1bH7dvjSHeVWsTMaZDTnFNN2LUwwSM0ajOC2Eq64=;
        fh=R3S3yUv79D8WbUOGLmdCZvTlB/Mmk768eYm9OWAXLAA=;
        b=NyUV0gOm99TCbOgrdkKkdmcZqcuPZdHiGqaWr0VwhTifgKY2o/ycS+H819Vc82WkH6
         2Ny6UV3ehAFcupf23bHXEaMg04ui1YadVMz4bV3s89UhBB5uCbcc4nRTedtyGK7PEnuy
         tS+rzn78TGR1HMlO6kMGElIJppZT8Kavgn8can4tQ1cflv1N8t6Z8I4QYiYzobt/xhXd
         O3GsZKhwg46efovf1wUIf3GJ6lYiCLt/SmtVEy/ExfGfjXK9CJkZNIzl170F5Fcbp73p
         zisrh6QOngoOWWbXYcFTIzxb5LJlaiOFaDgP8fAJ6ijf5GFiBJty5lb5AbvTc+BhmBuu
         z6bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783042629; x=1783647429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tNl1bH7dvjSHeVWsTMaZDTnFNN2LUwwSM0ajOC2Eq64=;
        b=OSLPPSxWqn16s4eGDyLbORnovIBg0BtZJEBnyWUTexpYXt8jm4lfKodTxqjuVIL9a8
         UIeaVlXFh12HjENRQT9FcNB7LBWNIifhYipV59o0X5yZl7VOhkxmJupuBO46kwiyiOkE
         93wutWBGfTbZYmDxWO1GLUv0N6WC/TtJFAsoLtujAJoUcXmoXaWQEB7x197T0hulyg/M
         ZC+NA03JauS5I1oypD3UhDj7Vp3kPaZmDldemIe0joGocE0Tba+pGkNt66yclJ/Y+5kl
         Y41OTrS7TTQoZX1XtA6f/MQITHdAjywPhIYWJv8Azlp0edlR7Cag82xBZZDniRrqnpbf
         T9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783042629; x=1783647429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNl1bH7dvjSHeVWsTMaZDTnFNN2LUwwSM0ajOC2Eq64=;
        b=QIzQcZayhu6bUTs8SIf3edI5pEz8UOLChtddZ3iUabkURFwuDCQMTNCzyhNI1DSdjC
         hUe/nLKy5nx20HbayXyyCGvPxq+N46B1MMxGiHf+8Hqd/pVwydKMExQGXS7FlJYGtOUB
         YdAlab8cgTW/EoU+NK8UIN/OkcX/Hmxgc+LgK++jgiSzXBE1fY/Yng+1IZ+v3HxUSc9E
         vYI8Z2x7zTHFO3pH50IIuOcd2ZxyxJlZH0g8/zBkAi4/cyptRkIxnHfPjyl/1y4qpOMJ
         jWxSX/Vkg2cWujGG1WBQ3cPIxxIkuCdvBG++UcQcIz6Vb+jS6bbMBLWjDZ/GwS9tE4MG
         rbzg==
X-Forwarded-Encrypted: i=1; AHgh+RoHsqKI8Z7PapE/CINLXtpv8cwLtQtpRlFw+JfT7T+YMvN+L7SnbGuOyn3xTxm2Mv98VsVgjRzsuaafT+YI@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSPWAB90K9AlKoFKPKbGsMc+otzlO0DPdZU9ZH5WclSRoKzMo
	aG/4kK/z+4jlV1YkODtlfM1mWaM/UFXeNSRXXvR+In0AoaSsuZ4NX719srly089KA0g+FEVvEIM
	a5ZhCqAU9HW2WCa0Oj+s63ar9kHWGfmU=
X-Gm-Gg: AfdE7cnuCiWBe9HQUA0LeTjRWec530c5TX/D2GI+dDnt61wSV1QegX+dPEKHO7kvU2L
	EzUBBN0vYWGfDrjE5IhZ0ja8Kh+4BBYDlh1axvChFEVbpSTEb5ALulmMvEsbAjfZhk3vDjpMVJd
	F321LoSBWB48iqlaP6U9LQTyTzZwnre/SpzXKCK6blz6TreOzOOO+ukxjQo//nXjkL7FjCa4t8V
	tDvwsFuR+1IvZ2nsefEUSzaNR9H1bUFTwBnEbesNyQim3KoDwc3rgivuooKWrH93xbmoh0HOTMh
	SbFihZMWyBMJIS46OZFTE3GfjMJmdbWvVYUQs8H3iHMSJBHPHkqS
X-Received: by 2002:a05:6000:310a:b0:474:b860:b7b1 with SMTP id
 ffacd0b85a97d-477573bbc08mr11953399f8f.9.1783042628647; Thu, 02 Jul 2026
 18:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-19-joannelkoong@gmail.com> <20260702192658.GN9392@frogsfrogsfrogs>
In-Reply-To: <20260702192658.GN9392@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 18:36:55 -0700
X-Gm-Features: AVVi8CcC6fzVqkOo0UfHNUMqKEbgK9tYEuLIjcETtAi_mnO3ekDmRCY21CtHqN0
Message-ID: <CAJnrk1YZQOQ0D6p6qYx1BPvKQaDgZsrKzLbGZzaH8tUkj_OoOQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] Documentation: iomap: update docs to reflect
 iomap_next model
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 12:27=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Jun 30, 2026 at 05:09:33PM -0700, Joanne Koong wrote:
> > Filesystems no longer pass a struct iomap_ops with separate
> > ->iomap_begin() and ->iomap_end() callbacks.  Instead, every iomap
> > operation takes a single iomap_next() callback directly. iomap_next()
> > finishes the previous mapping (if any) and produces the next one. Most
> > filesystems build it from begin and end helpers via the iomap_process()
> > helper.
> >
> > Update the iomap documentation to match this change.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  Documentation/filesystems/iomap/design.rst    | 115 +++++++++++++-----
> >  .../filesystems/iomap/operations.rst          |  60 +++++----
> >  Documentation/filesystems/iomap/porting.rst   |  22 +++-
> >  3 files changed, 132 insertions(+), 65 deletions(-)
> >
> > diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation=
/filesystems/iomap/design.rst
> > index 0f7672676c0b..7a37e303eea8 100644
> > --- a/Documentation/filesystems/iomap/design.rst
> > +++ b/Documentation/filesystems/iomap/design.rst
> > @@ -75,7 +75,10 @@ At a high level, an iomap operation `looks like this
> >
> >  1. For each byte in the operation range...
> >
> > -   1. Obtain a space mapping via ``->iomap_begin``
> > +   1. Obtain the next space mapping via the ``iomap_next`` callback.
> > +      From the second iteration onwards this same callback first finis=
hes
> > +      the previous mapping (committing or unreserving space as needed)
> > +      and then produces the next one.
> >
> >     2. For each sub-unit of work...
> >
> > @@ -86,7 +89,13 @@ At a high level, an iomap operation `looks like this
> >
> >     3. Increment operation cursor
> >
> > -   4. Release the mapping via ``->iomap_end``, if necessary
> > +iomap repeats this until the range is fully consumed.  The ``iomap_nex=
t``
> > +callback returns ``1`` while there is more of the range left to proces=
s,
> > +``0`` once it is fully consumed, and a negative errno on error.
>
> s/and/or/
>
> > +Filesystems rarely implement ``->iomap_next`` by hand. The ``iomap_pro=
cess``
> > +helper implements the finish-then-produce sequence in +terms of two sm=
aller
> > +callbacks, ``begin`` and ``end``. See `The Mapping Callback`_ below fo=
r more
> > +info.
>
> I wonder, under what circumstances would a filesystem /not/ use
> iomap_process()?

Hmm, maybe a situation where they need to share or carry some
filesystem-specific state / info between finishing the mapping and
producing the next one?

>
> >  Each iomap operation will be covered in more detail below.
> >  This library was covered previously by an `LWN article
> > @@ -189,7 +198,7 @@ The fields are as follows:
> >     * **IOMAP_DELALLOC**: A promise to allocate space at a later time
> >       ("delayed allocation").
> >       If the filesystem returns IOMAP_F_NEW here and the write fails, t=
he
> > -     ``->iomap_end`` function must delete the reservation.
> > +     ``end`` function must delete the reservation.
> >       The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
> >
> >     * **IOMAP_MAPPED**: The file range maps to specific space on the
> > @@ -208,12 +217,12 @@ The fields are as follows:
> >
> >     * **IOMAP_INLINE**: The file range maps to the memory buffer
> >       specified by ``inline_data``.
> > -     For write operation, the ``->iomap_end`` function presumably
> > -     handles persisting the data.
> > +     For write operation, the ``end`` function presumably handles
> > +     persisting the data.
>
> Unrelated to this patch, but this should say "For write operations, the
> end function must persist the data" because iomap_writepages doesn't
> handle inline data.
>
> >       The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
> >
> >   * ``flags`` describe the status of the space mapping.
> > -   These flags should be set by the filesystem in ``->iomap_begin``:
> > +   These flags should be set by the filesystem in ``begin``:
>>
> > +``->iomap_next``
> > +~~~~~~~~~~~~~~~~
> > +
> > +Each call must finish the previous mapping, if any, and then produce t=
he
>
> Each call?  Oh, each implementation of ->iomap_next must finish the
> previous mapping.
>
> > +next mapping for the current iteration position described by ``iter``.
> > +The mapping is returned through ``iomap`` (and through ``srcmap`` for
> > +operations that read from one mapping while writing to another; see
> > +``begin`` below).
> >
> > -``->iomap_begin``
> > +The callback returns ``1`` to continue iterating, ``0`` once the file
> > +range has been fully consumed, and a negative errno on error.
>
> s/and/or/
>
> I think there should be a transition sentence here along the lines of
>
> "Most filesystems are not expected to implement all of these behaviors
> in ->iomap_next themselves.  They should instead call iomap_process as
> described below."
>
> Or demote the next section so it's more obvious that the "iomap_process"
> and "->iomap_next" sections aren't independent?
>

Sounds good, I'll incorporate all the suggestions you recommended.

Thanks,
Joanne
