Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793372065;
	b=nKJMYQb4OVztWtLLaIuoXDzAxpUpIdkBEhf1Bpzh+yaCbjaR038avnMt8EzZVZoIYLaG
	 28qKQr0OFPzHuL41TblHNcVgchOSnJPMeHju6Oz4ePbQHFkdYhuBwnhKXb02/4YAVtTVL
	 oAyHcTD97foQEjQd2AU871szVFsbQc00tXMVRBZa84ZGSS0O6AbGn7nsyTHE12e06rO4H
	 Sfkw3Ut8nZ0zfu2jtG01UGoecdfxalIZlAvi0Oil4sIA17OCxdK52lnhcpTb2X5VzAFpk
	 aLpAZceTVyqfsJ+/Cei9opDnpG/fC9qUUDXcpjHsCLQzdrYSP3RviV4Fo0OvFI2p3gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jMsUz0CmedXWqrdh2TheB4BjYFtAJcIsl6CPDLvVdyA=;
	b=z38P4DIfgwCvs94LcUj3sOQgUWr3WUvYJYaD7BvS2l1gyhoFT3mr0ON18szJFOJwJQEY
	 72cWLKS4zRANXm/SlPenxdjgIFS1kdJUb7nKlPTxnxey5j2kZavD8vWnaUPLXo0GLJmzy
	 xllHSvXerDbiygyf1IN21ZGFqsIAJWZAwZuvJBj8IvFeUDNqyK5kQl8K9tn6r/OdAcbqS
	 W9+pyK9g3c5DBkF+yySnodRrn0NwF+82U9PhobEVW6wLxCEOcSpV6UK3Q5T9kfH5pOigW
	 WOo/olU7vTUlvc4Q2nv9X08lkKzzqRpootD2ewDmG9ODxdIrOxjmGDUlWm/fwGeeywg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=llSAjB83;
	arc=fail smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514F606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 14:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B514F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=llSAjB83
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4c78e8caso918760e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 07:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793372063; cv=none;
        d=google.com; s=arc-20260327;
        b=Ufj5JtahNw29s3ZkH5Y5rg5d2cuNkB5wHSDAsK1eAkom6A4oSRhPfhnDZZsrHovDbL
         65s0hwXOi0zXqVkNjhPvqs6X+yGQMHUYqERYbrc+V4xyditcjEfkTIbuZlQuE5L4FFt8
         u1QMEaS4ms4gTDJFfuhe28l3mkxnh9L1MPNegTf0OElxjSLkNlBXVsIk2wJFD1VI6+72
         f4BDJuyJcxfsWvUjuKs1q6+PMlR/Do2JH8Rd/MUhLFKVMLc2Mn1o96Z8nW5n2V5Z2Zj7
         r9Ni+pCWF+MpfgSyGCHVntw4Huk+KbSoP9v8VKHwpNNV2OeQcx1+atAAljGP7YVxFxvF
         iZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jMsUz0CmedXWqrdh2TheB4BjYFtAJcIsl6CPDLvVdyA=;
        fh=ioUetk/YRMlOSyst3a25HrOZosX9OdV0XQ8I9aNVLN0=;
        b=nGRbAXmm0hgFPAcRkgaPBEkWIgNmzIA4XvM/CfZZD1fS5jhlW2z2/im6hicIbabume
         tvsUe4RgtcDKiS6IGhCQGeqJZgAeAHPYkO+cJJJ3cEeq9TWfEGn238HmirDTWG2iU9nf
         fhu0nTJS//NY4euMi2rbB0OYLvFwxkS+sS1fGnxVhSgGvEP2nraROVf7VZjx7P4TKt2c
         bUxlq83ouGLr/O6a4a+/gcPnL/8s04nAE6EBZ92lnh4GL2xi7HDDWvJrj4MK5KEJOoYo
         JovBCMNd+L7DS/TnsBxyV2Hy2tAjy8/KFYPNZIkSuml2Nydl414Y9a9vCdy2xbH0TJqe
         HNnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793372063; x=1793976863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jMsUz0CmedXWqrdh2TheB4BjYFtAJcIsl6CPDLvVdyA=;
        b=llSAjB8353GhiWJmW3lo0k47FpkVKUdOxkuIOEucyL686RRVtqlcVe+w6TaigBAncs
         RuBiEjJ5RrmdukHl9fbglfLqkd2Dg+gjSdyMfUNinYhI7lTg3SjhAWHlmdLd+D8lytl0
         M1Rn3HwniQdcK7QDZQC67l3ULytWecMDkddi/H2Av5rBgVEioLJ5lIUl6VdFcNi8F8Di
         ZlrBvbaHyHBGra4g6QxFHMA0e8cVrMPmfnPiJB8gTSMYPlzsJT2zqxQo9dExYOy/fmGw
         DBqyFbwKfTBpdLVueOJy00qtFaDWF4VRQSHd1hnmI3eyBv0v9uPa3/SYP6vznJSqPqAm
         FduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793372063; x=1793976863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMsUz0CmedXWqrdh2TheB4BjYFtAJcIsl6CPDLvVdyA=;
        b=OCkrcKvb+ddcHZdUW8ES14M2pacOs6Z0O3Yfm2S9Nmg6q9SPiAzCtONSDhb3Vq9+u1
         HvnlauxFNfj1fLu/OA/WM9Mev3r+YWmibY5QNweXDaR13wpktcdRHzAnNG5AxmDcAt6J
         oCgy0KUNHLRiyE1NXsmcDcwsFJxZbnBLz9LYMSjJ+0iJloZWQaT4lJui4HE2S8NnYOnU
         6T9Zx0dI8DAP405+fgXmWc0KE5UeTMnKQBWZmWxPSvDfD+Jxv8WXqrPbOP9mRJpEmlcP
         1NxBWsrxxswG7kvO0fFaOSYOu1NRAQ4gh5X9tyIfMG/55R/BZieyYNwGoUR4xwxSeLj1
         iIOQ==
X-Forwarded-Encrypted: i=1; AKwUvBztGPnbSJsUt8z7pB2LO5LPEvofrCv+0TRgZoasMN7BFHhFgu6nUAOT1JypuI+BiGp51H1lxd9jBC6lfvZR@vger.kernel.org
X-Gm-Message-State: AFq9FYK1LUKH8r/1IrSkQGHETtu71QTJeiEtDo/aEsPTT4L5zFm0zxyT
	yUoWt74+ZrYCXzPRKeIMZOkKRK/YhKdwG7W1T1uHQzXoQDXWOml/ONeBvej2FO6MKPbKSwZsy6g
	mTUVXcYMSADDCG9lU8Nezl13ATO1ePZxQV9oYVIEf
X-Gm-Gg: AYBFou12dXBEyh+nqYOp6m/XZw0bBZ+c2WVxTIfhRuz6p4zqBoi5h0lVcuuNR/A/5FN
	5Deao2spfYz3CfcubnoHQ8KSkOYyXpWJEoHdPX/IoP0l/umsjFktp+qmId/tFymCpf5bTO6p+8Y
	Ay0uEVYul+HaC3hRoa3wHi17xjF+53qunaylnd7edQkBiT/WfGZA3De+JedgVQYOnc5rOlo44HP
	uS4KbGVXUrNIdkY9vropeHPVpeeEX4tGJfg9qFL4solU+n3iQOw+jKHfOKdqhlVPxfOgLQcv4kj
	3iwNJf6wSdqtBf+7WofLII5Wyb3MrP0o44F8ILkTfzHT72L2vOpVdXrwBmq8q2bmF3jq6umDrr5
	QqoWyJZHx5LNxQjtQMe/9fu+Uncv4M64Ntw==
X-Received: by 2002:a05:6512:3402:b0:5bb:7b2a:5b2d with SMTP id
 2adb3069b0e04-5bfd9566d37mr824353e87.35.1793372062806; Fri, 30 Oct 2026
 07:54:22 -0700 (PDT)
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
 <CALCETrVpEP=HxVqdSP_AgA=U7ignwAgjz5Vi9+Z9dZsX5DXeLw@mail.gmail.com> <20261030121259.GC3889730@ziepe.ca>
In-Reply-To: <20261030121259.GC3889730@ziepe.ca>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 30 Oct 2026 07:54:08 -0700
X-Gm-Features: AclHuK8DrMlKsyKpQjiDV0_C05DMTWGTaa3ilPqU973TM9OhhHNjeL5jGLxSymM
Message-ID: <CALCETrW6RUgTGFuqx+cxV0c+Oq4d-P5C8AQ2ja0ESMP_8JGpxg@mail.gmail.com>
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

On Fri, Oct 30, 2026 at 5:13=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Oct 29, 2026 at 07:11:25PM -0700, Andy Lutomirski wrote:
>
> > I can't shake the feeling that the problem here isn't so much that KHO
> > + iommofd doesn't like this but that the behavior in question is
> > nonsensical.
>
> It has been this way for ages, like David says if userspace shoot
> itself in the foot it should not be surprised by this illogical
> behavior..
>

I dunno, a couple weeks ago I tracked down a 20+-year-old bug, and now
it's fixed :)

> You can get the same nonsenscial thing with just mmap too, you don't
> even need a memfd.

I feel like there are multiple levels of footgun here.

mmap anonymous (or MAP_PRIVATE), pin the pages, munmap: okay, mmap
creates unnamed private memory, and munmapping is maybe like unlinking
a file -- if someone else is still accessing it, it's still there.  In
fact, you can mmap, fork, unmap, then mmap in the same location, and
your child process still sees the original memory.  It's not clear to
me that anything is wrong.

mmap anonymous, pin, MADV_DONTNEED: okay, this one is starting to be a
small footgun.  But at least it's pointed at *your own feet* (unless
you've forked, which in which case maybe it's pointed at a related
process' feet).  I would still argue that the kernel could notice that
it's false that I "DON'T NEED" the memory and fail or ignore the
request.  And the kernel's pages are still anonymous.

mmap a named file or memfd, pin, truncate or punch hole: who says the
footgun is even pointed at my own feet?  If I mmap a named file,
SCM_RIGHTS it to you, and you mmap it too, and then I punch a hole,
the rmap machinery had better invalidate your mapping along with mine
(and get the TLB flush right!), and it would be an unambiguous and
severe bug if this didn't happen correctly.  After all, what you have
done is to assign a *logical range* within the file an address in your
address space, and nothing I do should change that fact (except,
sadly, truncate, which can give you a SIGBUS, but your vma still
logically refers to the file).

So why is the kernel exempt from keeping its own mappings coherent the
way it keeps user mappings coherent?

What if that memfd (or tmpfs file or whatever) is shared between
multiple processes that don't trust each other?  One of them can cause
it to become incoherent from the perspective of the other one's use of
kernel APIs.



P.S. You can access the offending APIs from a VM guest using balloon
in typical implementations.  If the host userspace does not strictly
enforce that the guest doesn't balloon memory that is not ordinary
host memory *and that is absolutely not in use for any sort of
kernel-side pinned-folio IO*, then the guest may be able to cause the
host kernel's or hardware's view of its memory to become incoherent.
Heck, host userspace could literally use a memfd to share memory
between the guest and a separate host process that implements a
device.

P.P.S. It's possible for there to be a legitimate security boundary
between user or guest code and a future version of *the same*
userspace or guest, via DRTM.  Someone should build a guest that sets
up some form of host-kernel-pinned-folio IO (IOMMU or simply a
host-side emulated device that works this way), then
DONTNEED/REMOVE/hole-punch the memory, then do the DRTM dance and
attest to its state.

--Andy


--=20
Andy Lutomirski
AMA Capital Management, LLC
