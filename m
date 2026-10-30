Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793320017;
	b=I2FCqR/a9vLwNxDtVbKYZ/rAVQnwLCZxaT4mpLIaqBhKIkSw1Z7k/nzJKzr7u+opwXPh
	 Q3bkbWbscZu73BVbf7XojgPkp8Lj5lDJcp/W+8Gpuw5vac00Izad5bfzkrklMMmLdNrJ/
	 Ol9E/8JL/0C3bju+pffYdUkaYdwmjd8uFZJSJWi7IEFsearjyS0N/D54/dOJhkHqkny6p
	 I7pyR12iafHZAAQh5pA8arIfZgMIPqXbmkUMlQOk29rqC7Y0tkyj2NmLxISXSvoDDTYjB
	 aOWVY7eKlbBWA1bb8rOoEvpVbOojhxVneGV4b/ec9+iNAcAMg7IOq4PnlEiANizthlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793320017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SqR7Qlmk74yXkmM8mpkoCIRlm5LIZR8YEquqyqfTCLY=;
	b=2bOXs+3fHXUO2w1GoabE5dFx7iNfktZhs5yTp69I2Z2DpBj2i2m3QWONUUz9LzagRYPc
	 xC27XAlstRaXxO7W9NjSZUONd+pqiOF/5M6yrE3sYP37j7yNyeqVbv9/qtYN2pdRoz0qk
	 sTpGJEJHViKw+I6c52EipNnHQBd87d7hTvhT/TNowfEtSDZRwoGv5zGdNlQrYGqAiVo4P
	 GXyXjlN0+CXDA+7t2f2eIlykwq4yqlC2kblcTGvS/3FN8HO18I12iaM0LkaFAIToIIoff
	 SlF9tw4cwyI+st95vojg2AZwp2VCLSnHSd6vKsHDKH3akxUqSa0/93HotYjbd9ayGLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=O503UjZ7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A6606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 00:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C6A6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=O503UjZ7
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be47aa555cso218568e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 17:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793320015; cv=none;
        d=google.com; s=arc-20260327;
        b=KtpId5kBPvvEGnDRb+4h6STTjsA9v2sBa1+eomZbIvagY0giS1fQ2aWXe3iPR95lmy
         qzf9FRXZw8YLIXlOLjrNqvfbLHEA73QVDU8a/5DAlcWlJkZgyqrCUY+aqb1c/A0Jvw2T
         gaQDGlBbCHyTFky+N8iSRsX/+OB463JbGg51C1GwTGrGjjpJ72WpDfv0P9+gre3zMvo7
         xmGkNiXCdfied+A6i3U314W5SauXvKVa6VF0ErXn5LwYhFIroLyiXLcDuJgfTRqGQDmV
         ASSkIZ9/SapK7qGO+WJCJjRllPaZslGfdAI8hNPLxJoV28ezgIyzaYCaxl2FsCqBu5dc
         TDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SqR7Qlmk74yXkmM8mpkoCIRlm5LIZR8YEquqyqfTCLY=;
        fh=wLf1Nne1D3YywA5zC4v2OKIwVP9RdMMOGHGsU5vosDw=;
        b=cdCWbuToUdlSz63DoFzY/zGvdBLPm+msk+Mn0MSHtAuX5JLmHDkwSfjQEsVl7LTelB
         yVtbfRGGoLaZ6eB0597I9BgJWrSqVLnwXz9rB2NqP7tt7/77cKF6yUc2ugbtGw19uqGC
         GTHjAVbyKCKMBbDeuaVExDgBky/BU3XaTJwcqRX/cFFESQe7//QE49Ss4KsYJtnKbJSK
         wVhWLtOQAnlksU23GzO6r7/DCTST3fYtyynl318t0MQj5tWgi5gZ6DPKnaLQoHdO4V2E
         0lh9zLaveQcs/893XWZACXrwk7MNoG558lMvit4OlTQWJer03JpdaB/sUTHWCvGSykYY
         pPxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793320015; x=1793924815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SqR7Qlmk74yXkmM8mpkoCIRlm5LIZR8YEquqyqfTCLY=;
        b=O503UjZ7fMXZsU1qRRq5Qfc8GFUwnWkY3mMLLrFUPM1gk/hfbdcb9Pops7GCI0GBBa
         vONTTBLAAbAFHNnZGOPQIwfyR9o/l6SNCs7fRjFQCPNDd+QjmAYtBmJSnSj9YdJ3/NKI
         Z+7a1O3MVDPsyEo6ywZ2WmcAvahNWZzS+mCPYGq1f0VbyQ0qOrLpI+R9M2/6Q1K74HMY
         cDvHBv09E01SeMZO60MfHnGTbHhfWIcOgNCtFbyGiipupUpWlUy6UbWCtfITq+8te9TG
         S5LNtPnIPh9f96dIktlAlytzu0r6RF96xDMKw8buqcXgU6Zwb6jBbPIxlx6FTmKBq7dc
         59CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320015; x=1793924815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqR7Qlmk74yXkmM8mpkoCIRlm5LIZR8YEquqyqfTCLY=;
        b=g8xu+GYF6xlXIF2WXOXWEbR9P0d2UdWHkM/uy2nwY14q79XqUBWAJp4I9cYtVIYdGh
         6qPFNhn04Bkus8Cz+O1+cyWB6lhgcon2WbbCM3p2taw6VZ09vEplZLxanrTzpGpKcq7Q
         uxZH8PYq9bGwv4yS0bQ0muDN+BkyImn/0/E1IMOtQf8jqGo0AgV8Bmy+JYa//GKj2NKD
         vSrJRliGGFJCHYzSerZ6G1ufDPbNklBdcUW2nfgSPDucfkmXpyuqP8cjg4M0MjZDggR8
         EU4uImWtGfI/WmQ5FJZAsrHh+YAh98lOdF4TPbr18eSWCi6nf4BKPkzwJykb17dXT3vD
         LNdA==
X-Forwarded-Encrypted: i=1; AKwUvBxWudl9vmFpdJiKu43WXePlQSUQz1ChyCmuS0ipnBSgIFtTZ2MeLOlEwvU2dqSNyGbXxuRO3DwBM6j13N9Y@vger.kernel.org
X-Gm-Message-State: AFq9FYIYXLE7twUHApvNb9hN3L1/LjpTPnr+7MdVTI07iyVW8qE+qsxY
	wnwm71vg+41zlVMoAi4etmLg8yaV8CfT371ExA1kQk0l90cHcw58/xMdQC1Fj/9JVDtZ/LM22N3
	S0W7hsBb6QVlmP/7DAgthRP0M1Kkb7Ks3rF3NOcgc
X-Gm-Gg: AYBFou2Dnre7qjy8kDSY2W/sG+OfXdpnO+tBI9wBsSoltdhtcJb7vluzTC5vf+sPwkr
	I6/6lq15QAo7iouGiT1NTDcohmFwYjhPmzZOpYljTgIGMK0vZlabEuIQOlJhwNElXFkDeHtbtHl
	wo8kLzbFZIi4AOCNi4BtpEOKdmJUeSfk1gCE6wHGKBlzrYbbNutz4zfYEZHWyaBdsXqDgQ5v8RY
	r67AZnmNMSDe2SVmdmUpAZjMe/1qjvl3+2/zStWXqrhWGkzj/aFI+C8nNBwZogWzXX+fl57ijf7
	cxCzuCWJkDZVPGyLRGRVjy6IxM9CeVtUa2VPJaQvh+2c8kAhUXrxyVVIPwIXv9IZB8mDD9U8e01
	KtVgC31RuqxN6I4zWq4hGNZ8zAGMB97nwbUfbVCtFdjJtFe9Hr5f1q42Dcpns4LTotXWKG+b8
X-Received: by 2002:a05:6512:32cb:b0:5bf:ba1e:afef with SMTP id
 2adb3069b0e04-5bfd9520081mr152686e87.6.1793320015099; Thu, 29 Oct 2026
 17:26:55 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026220546.3114241-1-skhawaja@google.com> <CALCETrXNEWQNPjtuHnTfVFOafeJ7APXq288Cq16Q5adDNYx9+A@mail.gmail.com>
 <auEksxfAi9lHFXmT@google.com> <CALCETrXDY2e8x2kdr-FQvFLs-Y7FwNozXGDvqqM6yvVA7QLV3g@mail.gmail.com>
 <auPKfqh_YjRU9Ui3@google.com>
In-Reply-To: <auPKfqh_YjRU9Ui3@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 29 Oct 2026 17:26:42 -0700
X-Gm-Features: AclHuK_wmS3zhRrQoH9hx3ZcC8OW5l1uNKU_reQs4AjmGufZO3hljBUi1_f8y4I
Message-ID: <CALCETrUEyfvaEGxMHo=c0ia3CDgSxg-YW0_=Z7T31Ou+pvicuQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 4:16=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Tue, Oct 27, 2026 at 08:57:29PM -0700, Andy Lutomirski wrote:
> >On Tue, Oct 27, 2026 at 3:55=E2=80=AFPM Samiullah Khawaja <skhawaja@goog=
le.com> wrote:
> >>
> >> On Mon, Oct 26, 2026 at 03:46:34PM -0700, Andy Lutomirski wrote:
> >> >On Mon, Oct 26, 2026 at 3:06=E2=80=AFPM Samiullah Khawaja <skhawaja@g=
oogle.com> wrote:
> >> >>
> >> >> This series introduces F_SEAL_PUNCH_HOLE, a new memfd seal that pre=
vents
> >> >> holes from being punched into a shmem or hugetlbfs memfd while leav=
ing
> >> >> the file fully writable.
> >> >>
> >> >> Background
> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >>
> >> >> Drivers such as udmabuf and iommufd (via IOMMU_IOAS_MAP_FILE) use
> >> >> memfd_pin_folios() to pin the folios backing a memfd and hand them =
to a
> >> >> device for DMA. Pinning keeps those folios allocated, but it does n=
ot
> >> >> keep them in the file. If userspace later calls
> >> >> fallocate(FALLOC_FL_PUNCH_HOLE) or madvise(MADV_REMOVE) on the rang=
e,
> >> >> the folios are dropped from the page cache while the device continu=
es
> >> >> to use them. The pin holder is never notified, and from that point =
on
> >> >> the device and the file silently diverge.
> >> >>
> >> >> The existing seals only partially address this. F_SEAL_SHRINK preve=
nts
> >> >> pages from being dropped by truncation, which is why udmabuf requir=
es
> >> >> it. Hole punching, however, is only blocked by F_SEAL_WRITE and
> >> >> F_SEAL_FUTURE_WRITE, and both of those also forbid writes. That mak=
es
> >> >> them unusable for memory that must stay writable, such as guest RAM=
 or
> >> >> DMA buffers, and udmabuf explicitly rejects memfds that carry them.
> >> >>
> >> >> Proposal
> >> >> =3D=3D=3D=3D=3D=3D=3D=3D
> >> >>
> >> >> F_SEAL_PUNCH_HOLE fills this gap. Once it is set,
> >> >> fallocate(FALLOC_FL_PUNCH_HOLE) and madvise(MADV_REMOVE) fail with
> >> >> -EPERM, while reads, writes and resizing are unaffected. Combined w=
ith
> >> >> F_SEAL_SHRINK, it guarantees that userspace cannot remove pages fro=
m
> >> >> the memfd while the memfd remains writable.
> >> >
> >> >How does this solve the problem?  F_SEAL is about a userspace
> >> >contract, and if there are existing users of the APIs in question, it
> >> >makes very little sense to start making those users fail because they
> >> >haven't taken the appropriate seal.
> >>
> >> It doesn't change any existing behaviour, nothing starts failing for
> >> users that don't set the seal, and drivers wouldn't require it. It's
> >> opt-in. Userspace that wants the guarantee seals the memfd, and a
> >> kernel user that pins it can check for the seal and rely on the pages
> >> staying in the file. For example, the iommufd live update path could
> >> skip verifying the pinned pages at preserve time when the seal is
> >> present,
> >> and do the full check otherwise.
> >
> >Can you clarify the API you're proposing and the issue?  It seems to
> >me like the user is expected to preserve HWPT state by creating a
> >memfd, then using some new API to tell the driver to "persist" its
> >state into the memfd (possibly by binding its existing state as folios
> >into the memfd)?  And userspace is supposed to seal the memfd against
> >growing and shrinking but not against writes?
> >
> >What if the user writes to the file?  What if the user populates
> >pages/folios into the file before using it to preserve HWPT?  What if
> >the user mmaps the file?
> >
> >Have I understood this correctly at all?  Why does memfd make sense?
> >If the goal is to attach a bunch of pre-existing pages to a file so
> >that the page preservation machinery can preserve them, wouldn't it
> >make more sense to have a handoverfd mechanism where the kernel can
> >make a handoverfd that stores its purpose and logically represents
> >some pages but does *not* allow read or write or fallocate or any
> >other user operation that actually acts on the data or its memory
> >layout?
> >
>
> Not quite. Let me elaborate my use case.
>
> For live update we need to preserve HWPT (iommu domain) so the devices
> can continue to do DMA during live update. Domains are preserved by
> preserving page tables and relevant data structures using KHO.
>
> To make sure that the devices can only DMA to preserved memory, the user
> preserves the memfds (into KHO) that are mapped in the preserved hwpts.
> During iommufd preservation we need to check that the memory backing the
> iommu mappings is preserved. We do this by checking if the mapped memfd
> is preserved, but if the memfd had a hole punched into it before its
> preservation then the punched pages will not be preserved. For this we
> need to do a complete page table walk and test each page separately.

Let me see if I understand.  If I'm following, the user makes a memfd
and does something that maps that into HWPT so that devices can DMA
to/from it.  And this is presumably something that works independently
of KHO, and it's preexisting, which is why I had a hard time finding
it in your patch set :)

And the hole punch issue is already present today and will cause
incoherence vs the user's view of the memfd but not actual corruption,
right?  So maybe that should be fixed but maybe it's okay?  (I still
think it's nasty that hole punch while pages/folios are GUPped or
otherwise gotten or pinned causes incoherence.)

But during KHO the system will ensure that the memfd is preserved but
doesn't preserve these detached folios?  If so, maybe the actual issue
is that either it should be impossible for folios like that to exist
(i.e. blocking the hole punch) or perhaps KHO should also preserve
these detached folios?

Certainly the *clean* solution seems to be to disallow punching a
folio out of a file if someone else has a reference to that folio, but
I can definitely see how that's a real can of worms.

>
> A punch hole seal, before the memfd preservation, allows iommufd to
> optimize the validation path and avoid doing full page walks.
>
> The HWPTs are not preserved into memfd; the memfds are mapped into HWPT
> and we need to make sure that the mapped memfd has not mutated and the
> pages mapped from it are preserved. Also it is ok if the user writes to
> the file or mmaps it.
>
> >>
> >> https://lore.kernel.org/all/arVYa_90j0oN1hnu@google.com/
> >> >
> >> >Would it make more sense for the drivers in question to set some flag
> >> >(refcount?) on the file to block hole punching?  Or perhaps to have
> >> >the hole punch code notice that it's trying to punch out a folio that
> >> >is pinned or otherwise referenced and to refuse to do it?
> >>
> >> The pins already keep the memory alive while it's used for DMA; the
> >> problem is only that the page silently stops being part of the file.
> >> Refusing to punch pinned folios on every file would change behaviour f=
or
> >> existing users: fallocate() would start failing whenever a page is
> >> pinned, even briefly by O_DIRECT. A flag set on the file by long-term
> >> pinners would avoid the short-term case, but it would still make punch=
es
> >> start failing for existing users of those drivers, which is why I went
> >> for an opt-in seal.
> >
> >Wait a moment here.  Given my comments above, I'm not sure this is
> >relevant to this patchset, but...
> >
> >As far as I know, right now, a program can open a file, register some
> >of its pages with io_uring or RDMA, and then use io_uring or RDMA to
> >write to those pages later.
> >
> >And another program can open that same file and use fallocate to punch a=
 hole.
> >
> >And then the first program thinks it's reading into the file, and it
> >ends up not reading into the file.  Which makes the hole punch
> >operation rather different from the write-zeros operation that it's
> >supposed to be a fancy version of.
> >
> >Now this doesn't sound like a security problem per se, since the
> >offending hole-puncher needed write access (admittedly that write
> >access is only needed at hole punch time, not in the indefinite future
> >when weird behavior happens).  But this whole sequence seems highly
> >suspect to me.
> >
> >Are you *sure* it wouldn't make sense for a GUP'd or similar reference
> >(whether pinned or not) to *actually preserve that folio's status as
> >part of the file*?  Or maybe for there to be an extra pin bit to do
> >this?  Because the current behavior is pretty strange.  And I'm not at
> >all convinced that anyone would really object if the kernel prevents
> >hole-punching a range with an active GUP, especially if this behavior
> >is restricted to writable GUPs.
> >
> >I admit that truncate seems slightly different in the sense that it
> >seems more likely that someone would be annoyed by an inability to
> >truncate a file.  But still, truncate does have the same issue.  Maybe
> >extending a file could notice that there is still a folio covering the
> >newly extended range and stick that back into the file?  Seems messy.
>
> For live update either approach works. If pinned pages cannot be punched
> or truncated, iommufd can rely on that directly and the seal is not
> needed. I went with an opt-in seal only to avoid changing existing
> behaviour. If folks are fine with blocking punch hole and truncate on
> pinned pages, I can send patches for that instead.

That needs opinions from other people :)

My two cents are that blocking hole punch (or making hole punch fall
back to writing zeros) seems entirely sensible, but I'm less confident
I know what to do about truncate.

--Andy



--=20
Andy Lutomirski
AMA Capital Management, LLC
