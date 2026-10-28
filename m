Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793159869;
	b=ohVCj8p7YvBtWQfGFEOZfpqBpwlV934K5UWv3nK7A2acWrIBZYLAG7zA3EMaAamMRPyy
	 CJfoP6k7cOvabYomEGC5UPD0dv9azPgQIEPgZXk1czCFPcGoAB2UsKXHq8sjz/v/NeFUz
	 0Ut36skfH13hNGlYWTix2c1jYYw4udqlSG+j59CQs0B3wYA3EhDhYf/mB80WNunuOvqGK
	 nAYPJfpbfIgSqEHDZx4GJ1Hk2UVLA5nbyvdhZn3IgH7igtCRlpzm3D8+KPY7zViEXoMA1
	 UnNhjsLySLMtpqE9pWAIwijmIlKX9U+mCaTCwMxix/OfcM6Ps7Jxg7NS2c7pFrP0AuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793159869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NMXrGQL+HMAYYOepT9QRjy9INGR/r2c4dPSHBgR+Ovg=;
	b=Ptvup5Tw7mTceiZv+whIVharjbVy378SiSNgDoVzDcnQldKjzVn+e2P2EwrNGDIFouPx
	 kJeHjbobMs08u0T+clPYm1ZqkBNNCoiUJANDXofpLemNJL8MsxL26PoHfIiR8nkZF11RE
	 N+6lOfciGRQ8p532LY53ZC4hCdHJ0PCoKgAh4DLPjSlcF0kil9Dj2JCdf90TIm9e++zqL
	 bY4lu90OE3V4jJB+8BE5TXhY2xWhQGOwwfrKEDcwBhuLuvayZB5cgmhhzyxIIy9w9b5oB
	 c1ijzzg7etevMUSfx2t7dt4d4bZ8pYuMTJEjQpniFOKrjbIPH3btK0GjJOqeCSt+NGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="gaw+DbF/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB7606A338
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 03:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6AB7606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gaw+DbF/
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bfa686881fso498910e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 20:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793159862; cv=none;
        d=google.com; s=arc-20260327;
        b=a34kRB6+fI3fAPx2CeyChJLdIq8M8LPsF7m8opnWwGrh6kHcDG5MIOolEC5htDgwOK
         CkUFrwBzPKE/+HXqaceyOPwGSm9iYRbXRadrI+9uVLIAvn+8IOkF7FMd/uoF0atzU6Up
         bLOW24sFtgXVBqYVlyEWb0oPC7OtinPPjhiJiKsBHGcZVWPDGNKf68Av0ZOZ2QDslZxf
         I0/D79adFNJtoDJGenboVeXzlFqf3CzJpOm8aZlUqFSQJzzGPOHPbnLQjrUnlfBLX7XA
         9VVYfL8gz6Fpx/IzE8MaYgMwQzkGak4m24DZ8BNT1uaOa5n//0qs0gWwOaA1OrsFBYKi
         2hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMXrGQL+HMAYYOepT9QRjy9INGR/r2c4dPSHBgR+Ovg=;
        fh=/f98aOe1S3JchgH1NZn8eUMOaDMlOcAxfxeOLBGNlYA=;
        b=VnnK6g3HAIj4qlYLc3awTLnrms3iDwEoptfIQoru3wEfnPZwxMLlkau9qBBdowXp92
         ILgkkXX64w1LflH57J3QeRr0h/UQnLXgyxyd5AfNj+/s5X93aa8Mh5qHg7ytI/2D/kh6
         H0c793eOBnOYuZ2Cd0nobdCCI0FjIQQZzf1yqgbZwnlsO+Xe5Ysia89jPrHR3IA7gdjD
         DkJGA2G+b3SRuGBUUB1xYqKsvPvItgGhAnlLXb+HaY38Kwce18xYNimcoLHjFKj7paxc
         gnMS5CLqyfaqxTgv7IvPCOmUbymxgom9A/Ur3mvxXYbFRRrsWLOXY5vqeFrQsh5xZlSA
         EQ8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793159862; x=1793764662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NMXrGQL+HMAYYOepT9QRjy9INGR/r2c4dPSHBgR+Ovg=;
        b=gaw+DbF/nmUl3kDK8zxqfHwK29AhYno3poVrvFH+EON0nOKHPGtXEaQesZpl7p8ajG
         rkw2MBoTDlVJnO4hjaG3tIMKVF54uRl+Xz7QQn7JMuY1VBhMdKJ7mibQ4552uDCP/oGP
         JeFeUyzddTGiWDdLWwCE5G94LI1vdM747u+BzTfDchR41u8JzfXm/7h04TVnIyj4mIXF
         u1/+E3queoRBnMH0CPGHAK9YTOywC0B3ujvaPAuaIqqwuPGJ4qG/P7s0H5G7gQ8JfYu8
         /fnyjHcpNRJeD8oX7PgoslrLmdSDr9Q/7hgYIxQ24YorJuyT/zXhUfP/YyOFF8f6zopi
         /xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793159862; x=1793764662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NMXrGQL+HMAYYOepT9QRjy9INGR/r2c4dPSHBgR+Ovg=;
        b=q8rZ00k3O4P/+Fzkka0yWontckGZ+1UTe+5Tgx+FI8KGJb0/saf+5sXfsz0ySJZkX7
         osExv2F43XqMutKWyFaCo86op7iD45kePHDWb8H6MVNRppoCjd3DVcgEYIiLKZPN6cty
         CWuse3xLYY7XNU7bbZ43NX9YiYcA04215VaiQL8zXILTB2QH+5N3hWOAlpRZRtBNY4Fs
         bpvCjlpIVDecjRqwBo+nmfgIA0lG2ctfzAL6pDS8K066jHeJRPjpsJE5TtnTWYRP1Uvv
         sPbhsLeVtmqlqROfGXNbPj2rZPA3Bgw7uzBs26H7DinR71MrYYtx4Dj/XdUDtO4CKMVz
         zd/g==
X-Forwarded-Encrypted: i=1; AKwUvBzOf6wgM/4aeu+xkAlzZNoAtdIUg3xeveuq/ThrSb2oKEcOBNf3TFEfMWOPw0S/cPXvXv0RVxa95IQfkLUa@vger.kernel.org
X-Gm-Message-State: AFq9FYLGOfNaN6h7VYdYTqdA/wfj5T4qW36WuAKsLKNnJNein972ynLC
	H8fq3i9rGFtG5mFBXxrxEF5obKYzIGR0feJ0AiHp3KpYflCJ3PHOf462S2QUaaDcNNp8Ld8KHC6
	GLm7rW2HlT2uHhZhuFTrJkphVtbMZJyYhRP379vcB
X-Gm-Gg: AYBFou2LaEXo9FhjpBlGk1jHECSCb1+eHAWdFFAC+DfNGg4so4iPbGmoQKn6eX7kpUs
	ai4U+D+37Vmnjo9FNbbU+0Zmojba/cCWfaH+uhu1Bcs2n/4K2VWNetxNXZ/od0vrMNsLDbRw6sK
	7y/yTT3H/PqOiov5hp+Gs+0lxcanA+B2HpFehRwEn44VxkoQ3TCWltI0SQTUAXLGnHErVQpXnOn
	E6jrBRa8HRo4mGt32/Rvp/j8g/3gusfDlz9fWot04fluvBt8FLKEotMY09HCzrXMUr6saXfCa9b
	vD2PFJn3Z3HIU9GtCvtOgOLifrZEnp9CPeI42I5JlyEs8zdy+1uvnl0DKqt4KPZPQxVw5D3RSMM
	C6O8WvwiILG8UeLzEAjMRpi+yOJIh+IOo4g==
X-Received: by 2002:a05:6512:39cd:b0:5bf:c619:b088 with SMTP id
 2adb3069b0e04-5bfcad172c1mr381529e87.20.1793159861277; Tue, 27 Oct 2026
 20:57:41 -0700 (PDT)
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
 <auEksxfAi9lHFXmT@google.com>
In-Reply-To: <auEksxfAi9lHFXmT@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 27 Oct 2026 20:57:29 -0700
X-Gm-Features: AclHuK-ukwGAOGBSGCB4Bz_ycZfHCvtj9w2gkhhBJhRypC_kHO1bNXVuIJcmKsM
Message-ID: <CALCETrXDY2e8x2kdr-FQvFLs-Y7FwNozXGDvqqM6yvVA7QLV3g@mail.gmail.com>
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

On Tue, Oct 27, 2026 at 3:55=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Mon, Oct 26, 2026 at 03:46:34PM -0700, Andy Lutomirski wrote:
> >On Mon, Oct 26, 2026 at 3:06=E2=80=AFPM Samiullah Khawaja <skhawaja@goog=
le.com> wrote:
> >>
> >> This series introduces F_SEAL_PUNCH_HOLE, a new memfd seal that preven=
ts
> >> holes from being punched into a shmem or hugetlbfs memfd while leaving
> >> the file fully writable.
> >>
> >> Background
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Drivers such as udmabuf and iommufd (via IOMMU_IOAS_MAP_FILE) use
> >> memfd_pin_folios() to pin the folios backing a memfd and hand them to =
a
> >> device for DMA. Pinning keeps those folios allocated, but it does not
> >> keep them in the file. If userspace later calls
> >> fallocate(FALLOC_FL_PUNCH_HOLE) or madvise(MADV_REMOVE) on the range,
> >> the folios are dropped from the page cache while the device continues
> >> to use them. The pin holder is never notified, and from that point on
> >> the device and the file silently diverge.
> >>
> >> The existing seals only partially address this. F_SEAL_SHRINK prevents
> >> pages from being dropped by truncation, which is why udmabuf requires
> >> it. Hole punching, however, is only blocked by F_SEAL_WRITE and
> >> F_SEAL_FUTURE_WRITE, and both of those also forbid writes. That makes
> >> them unusable for memory that must stay writable, such as guest RAM or
> >> DMA buffers, and udmabuf explicitly rejects memfds that carry them.
> >>
> >> Proposal
> >> =3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> F_SEAL_PUNCH_HOLE fills this gap. Once it is set,
> >> fallocate(FALLOC_FL_PUNCH_HOLE) and madvise(MADV_REMOVE) fail with
> >> -EPERM, while reads, writes and resizing are unaffected. Combined with
> >> F_SEAL_SHRINK, it guarantees that userspace cannot remove pages from
> >> the memfd while the memfd remains writable.
> >
> >How does this solve the problem?  F_SEAL is about a userspace
> >contract, and if there are existing users of the APIs in question, it
> >makes very little sense to start making those users fail because they
> >haven't taken the appropriate seal.
>
> It doesn't change any existing behaviour, nothing starts failing for
> users that don't set the seal, and drivers wouldn't require it. It's
> opt-in. Userspace that wants the guarantee seals the memfd, and a kernel
> user that pins it can check for the seal and rely on the pages staying
> in the file. For example, the iommufd live update path could skip
> verifying the pinned pages at preserve time when the seal is present,
> and do the full check otherwise.

Can you clarify the API you're proposing and the issue?  It seems to
me like the user is expected to preserve HWPT state by creating a
memfd, then using some new API to tell the driver to "persist" its
state into the memfd (possibly by binding its existing state as folios
into the memfd)?  And userspace is supposed to seal the memfd against
growing and shrinking but not against writes?

What if the user writes to the file?  What if the user populates
pages/folios into the file before using it to preserve HWPT?  What if
the user mmaps the file?

Have I understood this correctly at all?  Why does memfd make sense?
If the goal is to attach a bunch of pre-existing pages to a file so
that the page preservation machinery can preserve them, wouldn't it
make more sense to have a handoverfd mechanism where the kernel can
make a handoverfd that stores its purpose and logically represents
some pages but does *not* allow read or write or fallocate or any
other user operation that actually acts on the data or its memory
layout?

>
> https://lore.kernel.org/all/arVYa_90j0oN1hnu@google.com/
> >
> >Would it make more sense for the drivers in question to set some flag
> >(refcount?) on the file to block hole punching?  Or perhaps to have
> >the hole punch code notice that it's trying to punch out a folio that
> >is pinned or otherwise referenced and to refuse to do it?
>
> The pins already keep the memory alive while it's used for DMA; the
> problem is only that the page silently stops being part of the file.
> Refusing to punch pinned folios on every file would change behaviour for
> existing users: fallocate() would start failing whenever a page is
> pinned, even briefly by O_DIRECT. A flag set on the file by long-term
> pinners would avoid the short-term case, but it would still make punches
> start failing for existing users of those drivers, which is why I went
> for an opt-in seal.

Wait a moment here.  Given my comments above, I'm not sure this is
relevant to this patchset, but...

As far as I know, right now, a program can open a file, register some
of its pages with io_uring or RDMA, and then use io_uring or RDMA to
write to those pages later.

And another program can open that same file and use fallocate to punch a ho=
le.

And then the first program thinks it's reading into the file, and it
ends up not reading into the file.  Which makes the hole punch
operation rather different from the write-zeros operation that it's
supposed to be a fancy version of.

Now this doesn't sound like a security problem per se, since the
offending hole-puncher needed write access (admittedly that write
access is only needed at hole punch time, not in the indefinite future
when weird behavior happens).  But this whole sequence seems highly
suspect to me.

Are you *sure* it wouldn't make sense for a GUP'd or similar reference
(whether pinned or not) to *actually preserve that folio's status as
part of the file*?  Or maybe for there to be an extra pin bit to do
this?  Because the current behavior is pretty strange.  And I'm not at
all convinced that anyone would really object if the kernel prevents
hole-punching a range with an active GUP, especially if this behavior
is restricted to writable GUPs.

I admit that truncate seems slightly different in the sense that it
seems more likely that someone would be annoyed by an inability to
truncate a file.  But still, truncate does have the same issue.  Maybe
extending a file could notice that there is still a folio covering the
newly extended range and stick that back into the file?  Seems messy.


--=20
Andy Lutomirski
AMA Capital Management, LLC
