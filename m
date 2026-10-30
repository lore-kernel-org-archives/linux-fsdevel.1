Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793389982;
	b=t9WhLvWWnZpbJH+7GrKz1b10JGsi0ujh0EQFJv/rORnA3klNTljHuNjgeWXSjinigj3E
	 yheLZmab2vjIZrbSNHb2BblLkgVnQHkX8Hl3pOwkqqnwTxTKDCzwAI74qKORZBfQ4tbZq
	 B2j8E/v/pMZQ1z+13/tIlXfF9pHtricW1bbEYZN8V4bEjEkmC3RcG2j2NsfnfhpTIrDzp
	 2Tk773FDMVQ/EBYS969zcMLc+6LnHwpD3nIKMXS90VRRAKcdtRYdlcnjDWvRGn+iBqSH/
	 9KjGBoVLMLDPzMYEoeTYTOfmtBdJicP7iUNUsIFVjIPuUcu3zj+n5aWTMJjsqHVC9Pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M+BdM9WeGKtKZaWhqQx0TQqxdfo0Oqgz9BExV/rtU8c=;
	b=agCwKp8MRNTftt117vtWdUbQWtnGda1p6GLMKVYIYFNqzjbWpTp7oeRE8tQVGKN3AJ43
	 ZGb5M774g/Rd8b5dfzlDf5EqXe9Q0H7ry6T9rvfP9EFnzKJBzrrjvjVm6pdA64MiKmzIQ
	 7cxJGsoBm1u5yjj1eeCgZL9E3Z2/0qwLkV3DZcf/xp4mUDKG3sUqUgbMg7C/FYy+2hzEX
	 Q+hfCcZQqQXTMLSoARwilYzqnKf6cBYRS5ZO+MQT0P24SZ/NirnHeRhCSqY5ETME3Luyz
	 4YpHjDwxPgd/VBOiXeqnnRoMXyLuZdE77cF0yEYMmwJJU3AbYDkmcA2b6VQAQdHwO4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Qe/gAcEi";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70526606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 19:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70526606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Qe/gAcEi
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5364648ae07so10940291cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 12:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793389980; cv=none;
        d=google.com; s=arc-20260327;
        b=rR6s+BXpZnOYluDPpYp/6uf3dtvsrZn1cCPy2BrLLAYo6f+zTO/Rl4duVcPqnrLUst
         nNSZTo+bC08HAcah38z6aGtUSivE98Ji7mhYAXZQVhbKeQMwAeloAuH7hDqEGDN4QzOs
         jqUzJZROwOQVZEAU7M6FZlkrJSoMoPf65f/UfD69CL/0lNH+KuHO/1MP8okLPEcmAkuS
         Nd2uui0N+HdavWWnmAdjaW+jIznkiZPCcT6fQyAM1llkyA6y4oaFka3USHPpnfmOUnin
         f4mcWHyr4dnP8rnASaDm3ePOfpDOHIwh7Hyi7zEQuGZqGqSd52a4cnfJuug4DLjFW9RM
         8vFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+BdM9WeGKtKZaWhqQx0TQqxdfo0Oqgz9BExV/rtU8c=;
        fh=EQSGBkIgm6JTV1hsHFHL81/Pk8XX/6RkivTQGK8rV6E=;
        b=pllerqPmV/PEKSjOOcSUy3jGttqWbBUJhPWI2bn5eUi0MEodYk9Af/cGoE75DffFsf
         3ZjNqPZrjrJHEh863LWx5bSs35q3YRTysP4ZeJfqrkETTB9juzl4s6VB+Rqxg2zA9Qmu
         3BYydCs0881p24U1ZI3lnAAEoHe/+7YD3wrfmXpwjzJGKPV9Y89szJ68CR0FUcRIvZ8/
         xWdRDEYIIfzqudo0/c+7zu6bllcya+PYQy0q3ipI35Qf+rhCGqxiiFWY/f/syxJsGKop
         tvAHNESknWARiCWFfe+SJIE0/6nN2ANtTaRw+1qy4fOi0S5Ro1puMvGQQXNKWTifRB6c
         CEhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793389980; x=1793994780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+BdM9WeGKtKZaWhqQx0TQqxdfo0Oqgz9BExV/rtU8c=;
        b=Qe/gAcEi05CmazbVFGJG6MC2y/lEV7BIPbL2moKmqBCgaUI1F0umwaCz7ccXtSM3Nm
         E0Jlp77DRyMTuUTf82/ojtyzo+CDbCzVaywRB/kOgDeOdjojaKSMrwm8R4M1HZ+6y800
         65mX5dfPNYKxwGQLspt8lgAAXSkzCdzoJeYHJ0CmZAlzse46eVRnPq9toAwzBv6D0msf
         PGGRhbir0eSUeuhde/eAv8CsqKwzj8vcXXAUrqC7AsGUCmpxjaKI8BjRkdf6XLOjgJtO
         Xl8FNOUbs7wAtPKFLtgPn6BEquVGDezxdUaLdmxEOvsiOtzr6Aw80PTpSTYzYsLicEsX
         cD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389980; x=1793994780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+BdM9WeGKtKZaWhqQx0TQqxdfo0Oqgz9BExV/rtU8c=;
        b=mpBgrTZNZN29xM/Sydz2Xj3FaNtxUP8fB5YkB7oBe30qhaArCCvHUZ0J5h0QNwgZEM
         2fr3EdMueY88Fu9PHjwfK+yFQLKGP62JROCFonvjgng79qZEJuoP18wDQJRScWcLPZYs
         WAeJMok1eWsLXV4CyCtzVsEWq9X/yJ+/A0b/zEwR1NTEm4m0QptpAcRzuZmOO65uts7F
         1dv65zFbFEvolm73qgDZU8gv1gFEDEO0viGSLBhFFnoHB2hT99rvtAoOLlWoswc2TGDD
         Efv85zVZAM7qgWb+kRPzQhBXifKWPbEn659PJnZtbGBgv7OKQpgtVLxwSL6hNKYpUJrB
         7Txg==
X-Forwarded-Encrypted: i=1; AKwUvBzC2qfUwdl1ulZS9TGfsZzfLNvN3JxFzRmvQJ6fXOjjeHGmJ/jXHpz6ciKaiL0EM8qkx6iqszmhpni1JwiS@vger.kernel.org
X-Gm-Message-State: AFq9FYJZ6wQdsDPU7QOiTwDcgo/BjqmmgyRiDD4QXZi+xovk7gpjR0vD
	r0fJy9aVIXXwIDWARWjKDcDRgVqeppc7p1TQ8jfLBj2ctmzCJHNEpsH3eOS/UlvHv83d/Gw3EUi
	6xXmD1d9ZMVRO+VFwJDzYIhOkV3++AkySuINbhKpi
X-Gm-Gg: AYBFou21nGL7Bz+P6VCE4J7nzBIk1iKojqfECR3/Vypmeh3D4n/wqzSYi6uwoPLiSj1
	aRu9rV9dY6vHINrluqcVogn8TUMQIieVt7eUnpaYThLbSK04cSEGJtxj9VfMRCX8szy2q/aco6m
	oaTw4GGD1DXjMX0O9A4F+e/iiJcSaqzVIydoAXw+RQN8osVyxX0+My+OVjk6FjjBf7bKeVPtg+d
	NpBJHkZfqVjgscqy/JZBZXm4jmJnwUVGmSzyzH9VZFMeENevqeUPffnEhJrlcBxi0oUeH09fxFE
	NFantnZaknTZaUD3TMtzgAu6hur3XA+7T/++uUnXTrO2kGumoYOIvTZyxsMCidj0bgyBYt0k1Pv
	n1WjYY3rJpkfRY3IOWX3EAqYoiuBYXo5uVLwR5iBdVdzqBqNxk1M5Ovc=
X-Received: by 2002:a05:622a:34e:b0:536:43d6:2a94 with SMTP id
 d75a77b69052e-542b7145036mr51380891cf.34.1793389980143; Fri, 30 Oct 2026
 12:53:00 -0700 (PDT)
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
 <auPKfqh_YjRU9Ui3@google.com> <CALCETrUEyfvaEGxMHo=c0ia3CDgSxg-YW0_=Z7T31Ou+pvicuQ@mail.gmail.com>
 <CALCETrVpEP=HxVqdSP_AgA=U7ignwAgjz5Vi9+Z9dZsX5DXeLw@mail.gmail.com>
 <20261030121259.GC3889730@ziepe.ca> <CALCETrW6RUgTGFuqx+cxV0c+Oq4d-P5C8AQ2ja0ESMP_8JGpxg@mail.gmail.com>
In-Reply-To: <CALCETrW6RUgTGFuqx+cxV0c+Oq4d-P5C8AQ2ja0ESMP_8JGpxg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 30 Oct 2026 12:52:45 -0700
X-Gm-Features: AclHuK9sB5PkTPxFH6Td3Meg7Fy9jFpGf4zpslN407GFn3D8So9__FrNUMzsHq0
Message-ID: <CALCETrUGa4zE3Zx+5Dw_UYEFgMmgDYQUeCxvPKv_-u56hQ1W7A@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 7:54=E2=80=AFAM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Fri, Oct 30, 2026 at 5:13=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
> >
> > On Thu, Oct 29, 2026 at 07:11:25PM -0700, Andy Lutomirski wrote:
> >
> > > I can't shake the feeling that the problem here isn't so much that KH=
O
> > > + iommofd doesn't like this but that the behavior in question is
> > > nonsensical.
> >
> > It has been this way for ages, like David says if userspace shoot
> > itself in the foot it should not be surprised by this illogical
> > behavior..
> >
>
> I dunno, a couple weeks ago I tracked down a 20+-year-old bug, and now
> it's fixed :)
>
> > You can get the same nonsenscial thing with just mmap too, you don't
> > even need a memfd.
>
> I feel like there are multiple levels of footgun here.
>
> mmap anonymous (or MAP_PRIVATE), pin the pages, munmap: okay, mmap
> creates unnamed private memory, and munmapping is maybe like unlinking
> a file -- if someone else is still accessing it, it's still there.  In
> fact, you can mmap, fork, unmap, then mmap in the same location, and
> your child process still sees the original memory.  It's not clear to
> me that anything is wrong.
>
> mmap anonymous, pin, MADV_DONTNEED: okay, this one is starting to be a
> small footgun.  But at least it's pointed at *your own feet* (unless
> you've forked, which in which case maybe it's pointed at a related
> process' feet).  I would still argue that the kernel could notice that
> it's false that I "DON'T NEED" the memory and fail or ignore the
> request.  And the kernel's pages are still anonymous.
>
> mmap a named file or memfd, pin, truncate or punch hole: who says the
> footgun is even pointed at my own feet?  If I mmap a named file,
> SCM_RIGHTS it to you, and you mmap it too, and then I punch a hole,
> the rmap machinery had better invalidate your mapping along with mine
> (and get the TLB flush right!), and it would be an unambiguous and
> severe bug if this didn't happen correctly.  After all, what you have
> done is to assign a *logical range* within the file an address in your
> address space, and nothing I do should change that fact (except,
> sadly, truncate, which can give you a SIGBUS, but your vma still
> logically refers to the file).
>
> So why is the kernel exempt from keeping its own mappings coherent the
> way it keeps user mappings coherent?
>
> What if that memfd (or tmpfs file or whatever) is shared between
> multiple processes that don't trust each other?  One of them can cause
> it to become incoherent from the perspective of the other one's use of
> kernel APIs.
>
>

I'm contemplating what would be involved in fixing this for real.

First, there's a scary code path in shmem_replace_folio.  AFAICT
memfd_pin_folio() can race with swapout, so a pinned folio can be in
swap cache (obviously we won't *free* the folio if we do this).    If
we then decide to replace the folio when we swap it back in,
shmem_replace_folio() will not notice the pin and we become incoherent
and no one needs to hole-punch the file for this to happen.
Fortunately I haven't spotted a reason that shmem_should_replace_folio
would return true in a case where we care, but if someone does what
the comment suggests and makes it start respecting cpuset or NUMA
policy, this could easily change.

Other than that, I think that hole punch could be made to be fully
safe in one of a couple of not-horribly-invasive ways:

Choice A: Make hole punch work like migration.  Unmap from page
tables, do folio_ref_freeze(), and tolerate failure -- either just
abort the hole punch operation or zero the contents instead of
punching it out.  (And contemplate whether this could be made slightly
more permissive by tolerating a swap entry that still has a live folio
if the live folio has the expected number of references.)

Choice B: In addition to tracking references, mappings, and pins of a
folio, also track a new type of reference that keeps the folio from
dissociating with its mapping or changing its address within the
mapping.  Most code that pins a folio would be changed to take one of
these fancy new pins -- the main thing I'm thinking of that wouldn't
need to is writeback or perhaps non-long-term pins that are just
reading the contents.

Choice C: like B but instead of deciding per caller, treat exactly
paths that take long term pins as also pinning the folio into the
mapping.

For B and C, a big open question would be how this interacts with
truncate.  I think the idea behavior is that a mapping-pinned folio
that's past the end of a file would remain and if the file gets
extended then that folio would represent the portion of the file that
it covers again.

--=20
Andy Lutomirski
AMA Capital Management, LLC
