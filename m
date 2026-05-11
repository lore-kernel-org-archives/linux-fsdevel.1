Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25B4D90DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535664; cv=pass; b=f8d4DleJpsqRioob8CeR3Lo60Fd8Dvw6pVHd3PvI8wNznAYFBoVUs93HoMzwTP9wCMDNo4jGG+FkO6ygOSPgFjKpivhXtquKIFlDhL9+WPKsZAW2D8wQR/WvgjykBYQYLKuDyOhHoVpXdFCHzRFCWZM1tibwvmqnZD4+1Wu1axk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535664; c=relaxed/simple;
	bh=lJB7fD+0kZedYjEQATwAZeKYQRfTKZQy5z9HB8/efo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAthhN2QZ1akTyBHABZAXMoxLM/LFx9fQJU8xkfWRumBvF0YJwvkPnI96rfYE0EuStA2c1LLqi3WmKqa+DMIWSqoacHN7JfQaXTb2tTmO/EfaJSqEjEypHIS2X18sPUg/TvWrekcBKRBDS8ylfq96S6MTyey/GxkyeP2M5LlTK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com; spf=pass smtp.mailfrom=amlalabs.com; dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b=bbeDXEiq; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b="bbeDXEiq"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a88db610ccso5597742e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778535661; cv=none;
        d=google.com; s=arc-20240605;
        b=csJySoVz3Lbg/hHO0hlCmYTQXlH3CmnrwbDRmUoOg4hcLWXxwmJ4FvMiNWE2515Jel
         L3PWFDhj4aNgWEKeFWE/V9ozRjPZCst5KwK8BXstjtOURADbB72/Mh64jrSHbTdEKDSX
         OfxuiwUVFobhBpK2sLX8QhJrgftDRIg+4m/DNGoDrsa7A7OCqh15kta6/n9flmeq3i6e
         PLLAfj8D8+riR81nglYRB3Rvj/nPbV+xK5e5SdrIdTARikERmJKCkMtmWwXjjvxi8dF7
         CEFNgoGATJD+9IgPmU+nQa6WGRXndHE4oCWF76SF0p5qUbHMBezVnae67z4Elx2v/F9w
         0wWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nXGS2COif/6iKudvleqhAUyTu2yl4tq3AvaH+a188Uc=;
        fh=+2thV2dIMJcJMiYYzyILZi6UBS0kKOmEfbI5VPnem5I=;
        b=R2aOfgLNUeTTINy3jIbE7QMHBjJD9RD/hEj0HAgbF02k0BsymLlmm03OD4e5lGVk5i
         yZFlD5jf+WWsRii3y/v83V0Nf9MXtOwC6YDKJEWo4WRtCVkCADw2eGzp7kklwfI2xuci
         jAl30O8JY1Gwo9T7ZVAAU4vI8oVo3IKZMZfEH1+WgDTuEvfatK6Ddb3HW5PB5JSO+m1V
         7k7gc91sD3xdXQVUBZVzhsR2QFwnD+f23FvmRAg5WSQ3UCZ9ZI5eHXrZuCpkvmt4uBCf
         YPd//bWGhqwjO3ldNjbjOSKgMY0lxAN5+6iXx2DfVdtHQsvy6qL0lTJ89/ymnJOwYVfV
         oVlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amlalabs-com.20251104.gappssmtp.com; s=20251104; t=1778535661; x=1779140461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXGS2COif/6iKudvleqhAUyTu2yl4tq3AvaH+a188Uc=;
        b=bbeDXEiqpgCqQJGd97RlznsW78jwumAm0D2BKDVL40U6q7DyONTcSZo8/Q1xHnYHS4
         m4eqe9NuUgNH0QEI03OtW3utB/pfFP+2946Zo9b67X1XIZDfUi9fe7hzI0yqt7IIDTdW
         cHXsbFYX4HHMGLOOQBYXZk09Bfb8wd0PnAyuj18GDRChfb8RCKM+gpknA4nd6GA2KprX
         wvPVmMMysntHRYVIXaBcmvNDfuhzUAUJr4cCCtRNiJ30zCUGNy29CFGWxUx1m0BJLmvL
         wQTAuTMnQ1o6MuN1MmLOTDG60ol2f8n2pqubIwat993JXzcHbL7YNaf/3RIAo421NM1S
         O3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535661; x=1779140461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXGS2COif/6iKudvleqhAUyTu2yl4tq3AvaH+a188Uc=;
        b=Gi0897MW+lgNQEElSZbOlKn7hjDRBbVgYYbO8YaPMip/RkAplLywA31bLBgBeTTZxt
         8zmQne/TBkVSE7saNxIIsMd4tLHHI3/HtsnrdudQaIXNMuxbKalHzB7YsO/19UnPrOG8
         00w1mmD7VSKhTcDdksETp9xm/YAtpMLq0YB6DegPNWI9XIwt0e5PqTOBthy0FQB6ZFMG
         cJBxHHJeECvmmE7/hxmYcrUe33ZZlw/9aIHTUj44naONP7C8tNNJyJwK/y3I2ixqkOLj
         Cb6ZcG6Z9F8ZIFme4Z3+nifYUXHbP+tIW7wqI+SfQFK+dFLEEUwnyMEiSKMutI7QA9Rz
         tYzg==
X-Forwarded-Encrypted: i=1; AFNElJ8B1S4iuFGnMMIn/S9CZdd+CyZP9oF39uU5JcqGgBCLAxjfYxruazjBkC6bd9nKocY1wXIqq286Y5JZokzR@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRt8hKrssQVm628PrTfS74ItgmVpN92ovaGZLxOMzryZj3nC5
	lqdhsjiN9hQ2NOuInwtnrh+Ln/3SDfdVIMBymTOmJFFKnsBZMOgsWRh9+77JO1JzH6CHj7cb8Ho
	bJQiKbBe6GFcOz+yax2krkLLdmWW3E4CSmxDdHMSh+hA=
X-Gm-Gg: Acq92OHtzTM7YN0CaxJ0abBEdb2WLxTjiKNXCezUCD15opoxuQllKJ5+M7cT6ErMMeN
	hkK7xm8LkExQp9PLl0kRxhKh0TPAAPVsR3WwqpHhCWX0nrHwy9Y2aG5Tn9KTGoMzoRDDGsd6H3s
	2paKP++K3h651XytjbpQfvcaYbZGxBsCFf2t+LKWVu05MY2yWrnmxOWvQ58ay4Hu0m0c3fstYtm
	DOiEnLi6PnR1WBis3XpCd/RqC0o3lqBZznhwredokMMT10qs7bQmedN6N2I5sSirmutX/KY9iqF
	1dLdjBSOtGGlEHDvoiDF/ytzAUfib746azJ2jw==
X-Received: by 2002:a05:6512:acf:b0:5a3:eb4b:37a7 with SMTP id
 2adb3069b0e04-5a8b6c9c525mr2973242e87.6.1778535660345; Mon, 11 May 2026
 14:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501233933.2614302-1-souvik@amlalabs.com> <a708a295-9d80-4538-9d12-53c12820f9ed@kernel.org>
 <af4SR5-QwUCAClR8@nvdebian.thelocal>
In-Reply-To: <af4SR5-QwUCAClR8@nvdebian.thelocal>
From: Souvik Banerjee <souvik@amlalabs.com>
Date: Mon, 11 May 2026 14:40:48 -0700
X-Gm-Features: AVHnY4IWwwENmh7P5b_KrrZMmOGLtrgr6q2JnnDVvjY__BAFZLDH8ZYDhGP0lUc
Message-ID: <CANCY+o6T8eSnkw_mETH=kd9JDxp9tguHWnaU7L6Bp-sJMpniSw@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: check for empty/zero entries before calling pfn_to_page()
To: Alistair Popple <apopple@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, dan.j.williams@intel.com, willy@infradead.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review, will send a v2 with this feedback.


Souvik Banerjee


On Fri, May 8, 2026 at 9:44=E2=80=AFAM Alistair Popple <apopple@nvidia.com>=
 wrote:
>
> On 2026-05-08 at 19:15 +1000, "David Hildenbrand (Arm)" <david@kernel.org=
> wrote...
> > On 5/2/26 01:39, Souvik Banerjee wrote:
> > > Commit 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
> > > added zero/empty-entry early returns to dax_associate_entry() and
> > > dax_disassociate_entry(), but placed them *after* the
> > > `struct folio *folio =3D dax_to_folio(entry);` line.  dax_to_folio()
> > > expands to page_folio(pfn_to_page(dax_to_pfn(entry))), and page_folio=
()
> > > performs READ_ONCE(page->compound_head) -- a real dereference of the
> > > struct page pointer derived from a bogus PFN extracted from the
> > > empty/zero XA value.
> > >
> > > On systems where vmemmap covers all of RAM that dereference reads
> > > garbage and is harmless: the early return then discards the result.
> > > On virtio-pmem with altmap (vmemmap stored inside the device), only
> > > the real device PFN range is mapped, so the dereference triggers a
> > > kernel paging fault from the truncate / invalidate path and from the
> > > PMD-downgrade branch of dax_iomap_pte_fault when an entry is being
> > > freed:
> > >
> > >   Unable to handle kernel paging request at
> > >   virtual address ffff_fdff_bf00_0008 (vmemmap region)
> > >   Call trace:
> > >    dax_disassociate_entry.isra.0+0x20/0x50
> > >    dax_iomap_pte_fault
> > >    dax_iomap_fault
> > >    erofs_dax_fault
> > >
> > > Close the residual gap by moving the dax_to_folio() call after the
> > > zero/empty guard in dax_disassociate_entry().  Apply the same
> > > treatment to dax_busy_page(), which has the identical pattern but
> > > was not touched by the prior fix.
> > >
> > > Fixes: 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
> > > Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
> > > Cc: stable@vger.kernel.org # v6.15+
> > > Cc: Alistair Popple <apopple@nvidia.com>
>
> Thanks for fixing this.
>
> > > Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
> > > ---
> > >  fs/dax.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index 6d175cd47a99..6878473265bb 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -505,21 +505,23 @@ static void dax_associate_entry(void *entry, st=
ruct address_space *mapping,
> > >  static void dax_disassociate_entry(void *entry, struct address_space=
 *mapping,
> > >                             bool trunc)
> > >  {
> > > -   struct folio *folio =3D dax_to_folio(entry);
> > > +   struct folio *folio;
> > >
> > >     if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
> > >             return;
> > >
> > > +   folio =3D dax_to_folio(entry);
> > >     dax_folio_put(folio);
> > >  }
> > >
> > >  static struct page *dax_busy_page(void *entry)
> > >  {
> > > -   struct folio *folio =3D dax_to_folio(entry);
> > > +   struct folio *folio;
> > >
> > >     if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
> > >             return NULL;
> > >
> > > +   folio =3D dax_to_folio(entry);
> > >     if (folio_ref_count(folio) - folio_mapcount(folio))
> > >             return &folio->page;
> > >     else
> >
> > Makes perfect sense to me.
> >
> >
> > What about the usage in dax_associate_entry()?
>
> Pretty sure the issue exists there as well given this code path implies w=
e could
> pass zero/empty entries there as well:
>
>         if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entr=
y)) {
>                 void *old;
>
>                 dax_disassociate_entry(entry, mapping, false);
>                 dax_associate_entry(new_entry, mapping, vmf->vma,
>                                         vmf->address, shared);
>
>  - Alistair
>
> > --
> > Cheers,
> >
> > David
