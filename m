Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96D3E1688
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405285; cv=pass; b=FQzQVYr0K6aMHTjsuwV8J+Tjoh7U97nKzBdh+eJLmVNeN8d9l2kKxwfl6Wypcp2E2dFMQ5vzCssBI0vrt77tqwVU+GLGKEIkz/mUGAW3dxIV+IEjQOW72hRA39LTLB6iC3P0Wi0OSe3bPG4rK6gLs11zaqXwULnfIix+wQuVLxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405285; c=relaxed/simple;
	bh=/ho6lGJ76kzPFSZknYfMFJy4z+tOkx5CZ9MjgdeQ1dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwHQnRtmomLIETHeubk7oFbhQ1nCPjSHvHEEeisTXxUKo69J+YXX09jdnSLKWpcEhqTqTW4Xbt2+SZsbID5JZuEXB1lQ/1LxINLWOy3dR7Vbg3nTva3BRPPP4/c+b2xVKIlwecOEKTzD/8tKFYiYSCuhf7wH48/EnL1tWyBB4Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR98E/Zs; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR98E/Zs"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so4573405a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 06:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780405283; cv=none;
        d=google.com; s=arc-20240605;
        b=bi443FjZlx4va/B7GLd6ufhckb/1pz2PhjlH9T8yo8ZotbyW2BkX5tvmdEfJOhlcuZ
         HsV82iixBL/ixnlAiNlBFJBeOhlBEbY5rD3k1GQfMtJE5FACXo/GDSSGXV9rZwMDwPjj
         Q+pc0yajsg2RLP4dfcsM6tYhWlrqwk1neUYCu8401U0elUlOMnQaUgiFzLpQiNeN0fd0
         t0mvqHPcxU31+2FgtKsltfLN1Mp7VnlNgGPydM/oeAqd3F+n7JXUADjNkMVOiSGg247Y
         IxCCcmWh9NcimX2mO6Lkp9KyCu09vhyw7o1571s3B227TCkFDNIo8uNOdkUiAVcoA60t
         ojpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GT12yK06xRWdhw1OHOoMBEbkBjZ5NuBepZ00tWwU0+Y=;
        fh=J5bdFjqtVSjsPkQkPrSJfkjEHNMkPo0oALXF+hL8vDk=;
        b=IMbkcKAWVdDnEGjkPiOo7g6dpuBMS2B0ilUJxUqio25GPZXlP2uFvyIEMa9hSJW3wt
         helEfrJNibvhQquY38NiLWDmv1JPuGyq98YXI5TIugSMDyIUagIPaj9Ku7WMUtEOE1IC
         WIAJip2K642WaSqd/hS3RQwk6AMqFkn6QcSauzq4T0WpRded3pTJkLv5wirv8CCiWM1z
         pNAWCUfEKUH+jDBMP0t0u1fnfORwgLcMbeWGf5OJwCGaVHwb1UM80qeY9t8v+tYA8zRz
         WTaIo0xs6dHWwQncEIOs3iU6f97yzcgIM/Pf9j0CTOrMIZq6A4c8ZL+V0icMsIpAXquT
         EipA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405283; x=1781010083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT12yK06xRWdhw1OHOoMBEbkBjZ5NuBepZ00tWwU0+Y=;
        b=FR98E/ZszJoorkLXfyjz3Oe7h8vQuZfCTTZkwugrHqNYWFxBoa7aCt72qvA2mcNsnP
         dJcZY9OucUVljZGq3BEZ9wpm3kUvKFY8JCwyrLhunppvrARAFOfZo48fy5KqkHwIb1uo
         dtfiik2ugnfk/xYaJhXF8p3GP3I0xBerMt8A4PvSvRO6uk6AePU+LsKq5yb1dtGMs+ML
         MbdJ0eI75fPp/oA8pvTxjxtT6qFgE2XI0ogNKOT9GGNyis5I/WbihxXKRf5EYup4xn/x
         JExQXimS1rEjbq8tWxhBE7VJqxuS908ZLBGFxII8idhZ8d03tZ+8VqNXpuBlIpjdNFeO
         SNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405283; x=1781010083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GT12yK06xRWdhw1OHOoMBEbkBjZ5NuBepZ00tWwU0+Y=;
        b=lVbRKGWzczlw1qRNIsY+UcTlgezaFuGMA7KbLTcJMJFUgZDszyn9QYs/YzjhsN+bzG
         3aRhENLU8vV3cpzZ9BfbdbBtipkufsLazy4f4oV8zhLDfsoojQ6YPAWkk/noH3U3cuhB
         gj1Dk1V0R9dIoJ/JE+GsqRq2nC+33EDK0sKAnZOl6LuJSV0gHNzBNJAUPBLfkNaNLoah
         +A9fPc6VyMs3OjjomRLfOJR/C/1g1ieqUiHeWXzuTLagNJ3PQERFkC1Z2af0sznYYEBN
         p+DECf3Gy9WFGVLCu96GMIwvmxh6sAWv7Ch8UW42HAuzB9KOr18HLNOXKTmOlriErcy0
         5FXA==
X-Forwarded-Encrypted: i=1; AFNElJ8deZf0xybCZWFnxVqFoS1aukwdEJ+w8Wm/2A93U3v2wU7q4l8ro/ep5zPfMEmVX5h0so5MWWfdOwKi4AdG@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGAjMMS28fTZ1isfNqDYqsXeOIDJAq5zPchJd0j08neSC8+Aq
	gsyCF3W9JEKrFTfLVooGvQ0FKYnzpl0Dn3hMyi6zdkphbFlSOoI4oo+A5Dhqxbwg6DJW6+0KY6h
	Ew+WcHpuSqBhnEb1DmeAeg3ZazgYJTNk=
X-Gm-Gg: Acq92OExIoSDTYtAWCpbmZ5u2GEaXFpq63ejBqzJHIGY+BWBVMd51ChcoYUNttD4IQB
	ahDiHkp/gJHAey0lJyc69+ITvSRNaaf1eEKq2McD07vzBqpxvhLY9vNqG8WqtjFzZQ1NfKJXKHv
	tiHJI+39j0bxNMCtB/1ybBbc0n8i1sTVZxQO3gqrCcQ/HUhAidffoU7t3p/JzxyQ9hMNLC2+Qs2
	gDmNP/0y6T0x6nWL6C0keOmPAsMG4/+Yj3YgzpmtaX1QfeDneYRgsa6qKFCvuI8rGlP2+6/otL6
	VsO1e2lY4j8VNkGeceJtF19H/K5Z6aDibpEdrjEbdQ9PLTSq0BXT
X-Received: by 2002:a05:6402:285:b0:677:75e5:a1b3 with SMTP id
 4fb4d7f45d1cf-68c8cc290b4mr6202827a12.18.1780405281580; Tue, 02 Jun 2026
 06:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529134302.1989958-1-mszeredi@redhat.com> <ah5-40YypaswEG-1@groves.net>
In-Reply-To: <ah5-40YypaswEG-1@groves.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Jun 2026 15:01:09 +0200
X-Gm-Features: AVHnY4LI10OeqWefZhuYWnhAbyP5T-wCIDkQosynud5f2Rd959bkvyQoiKpPdRs
Message-ID: <CAOQ4uxj3ROiCCRxPnbNJkTzU4KvSYCiVj7jAe6koKZgw7t=2Kg@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
To: John Groves <john@groves.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 8:59=E2=80=AFAM John Groves <john@groves.net> wrote:
>
> On 26/05/29 03:43PM, Miklos Szeredi wrote:
> > The difference is that now the server needs to look at the fmap and che=
ck
> > if any new device needs registering, the device index is now allocated =
by
> > the kernel and returned by the ioctl().
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> > This is the first part of what we were talking about: using the backing
> > file API for dax devices.
> >
> > It's on top of the famfs-v10 patchset.
> >
> > Totally untested, haven't even tried booting it.  Obviously needs
> > nontrivial conversion in the server code as well.
> >
> > Thanks,
> > Miklos
>
> Miklos, thanks for looking at this.
>
> First, a scope check. This patch touches only the daxdev registration -
> GET_FMAP, struct fuse_famfs_fmap_header, and the simple/interleave
> extent structs in include/uapi/linux/fuse.h are untouched. I'm reading
> that as tacit agreement to GET_FMAP and its ABI. Can you confirm? If so
> the large piece is settled and this is really just about how a daxdev
> gets registered.
>
> Device indices - the part that has to be right
> ----------------------------------------------
>
> Everything below turns on what a famfs device index *is*, so let me make
> it explicit, because the patch's model of it (kernel-allocated) isn't
> workable for famfs.
>
> Famfs daxdevs are shared memory. The same physical memory is mapped by
> famfs on multiple nodes, and on each node it most likely has a different
> name and dev_t. What is invariant across nodes is the daxdev's UUID. So
> a daxdev's definitive identity is its UUID, not a path or a dev_t.
>
> The index is assigned by famfs userspace, as the order of appearance of
> daxdevs in the famfs metadata log:
>   - the primary daxdev (which holds the superblock) is always index 0;
>   - additional daxdevs are introduced by ADD_DAXDEV log entries and take
>     1..n in order of appearance.
>   - ADD_DAXDEV log entries establish the UUID-to-index mapping
>   - any file may have extents referencing any or all daxdevs defined
>     previously in the log - by index
>
> Two properties make the index a userspace-owned, cluster-invariant value
> the kernel cannot allocate:
>
>   1. Bootstrap. The famfs metadata log establishes the indices - each
>      ADD_DAXDEV entry defines the next - and an index can then appear in
>      any later file fmap. But the log is itself a file on index 0 (with
>      the superblock), so index 0 must resolve before the kernel can even
>      read the log. The numbering is fixed in the log before the kernel
>      sees any of it, so the kernel can't be the allocator.
>      (idr_alloc_cyclic never hands out 0 anyway, so a kernel-assigned
>      primary couldn't even be index 0.)
>
>   2. Cluster-invariance. fmaps live in the shared-memory log, read
>      identically by every node. A given dev_index must denote the same
>      daxdev (the same UUID) on every node, even though it most likely has
>      a different name and dev_t on each node. A kernel-allocated id is
>      node-local and mount-local - the wrong kind of value to live in a
>      shared fmap.
>
> So the index must be supplied by userspace (which owns the log and
> resolves each index's UUID to a local device), and the kernel looks
> devices up by that index. Resolving UUID -> local device is inherently
> userspace's job; the kernel trusts that resolution and never needs the
> UUID.
>
> This is also why the hand-rolled daxdev table is the right structure, not
> incidental cruft: a small self-contained array in famfs.c, keyed directly
> by the dense zero-based index, closing the discovery race (valid flag +
> wmb) and giving O(1) lookup. That's exactly what this index namespace
> calls for.
>
> Identity by reference, not by path - this part is right
> -------------------------------------------------------
>
> The genuinely better idea here is getting the kernel out of resolving a
> device pathname: the daemon hands over an already-resolved reference
> (you do it with an fd, from which the kernel takes inode->i_rdev)
> instead of a string the kernel has to kern_path(). I want to adopt that
> - credit where it's due.
>
> The minimal way to realize it is to have GET_DAXDEV return a dev_t: the
> kernel uses dax_dev_find() and kern_path()/may_open_dev() drop out
> entirely. No ABI change - struct fuse_daxdev_out already carries the
> index and has reserved space (sized with room for a uuid), so it's just
> filling a reserved field, and the index is already first-class in the
> reply.
>
> The fd delivers that same dev_t (the kernel already reads it from
> f_path), so BACKING_OPEN can realize the same idea - but the dev_t is
> the part that's actually the improvement, and the daxdev reply ABI
> already models (index, dev_t) while fuse_backing_map models neither. So
> realizing it is cleaner without the fd than with it; the costs of going
> through BACKING_OPEN are below.
>
> On BACKING_OPEN
> ---------------
>
> If you feel strongly about FUSE_DEV_IOC_BACKING_OPEN, I'll make it work
> - but I want to be honest that for famfs it's a shared-almost-nothing
> approach:
>
>   - famfs needs its own handler regardless (the famfs branch of
>     fuse_backing_open), and that handler can keep populating the famfs
>     devlist exactly as today - so the only things actually shared are the
>     ioctl entry and the {fd, flags} struct.
>
>   - it forces 'select FUSE_PASSTHROUGH', pulling in file retention, I/O
>     forwarding, refcounting and close - none of which famfs uses. Famfs
>     maps device memory directly via iomap/dax_direct_access; there is no
>     backing file and no famfs close path (fuse_backing_close already
>     returns -EINVAL when famfs_iomap is set).
>
>   - the ABI doesn't fit. struct fuse_backing_map is {int32_t fd; uint32_t
>     flags; uint64_t padding} - it's fd-shaped, with no dev_t field and no
>     index field. To use it for famfs I'd have to carry the device by fd
>     (which forces the daemon to open() the device just to register it -
>     the daemon otherwise never opens it) and smuggle the native index
>     through padding. And the fd does no real work: in famfs_daxdev_open()
>     it's borrowed only to read f_path -> devno, then dropped; exclusivity
>     comes from fs_dax_get()'s holder, not the fd.
>
> On access control, in case it's a concern behind the fd: the famfs path
> is already gated on the server holding CAP_SYS_RAWIO at init -
> FUSE_DAX_FMAP is only offered under capable(CAP_SYS_RAWIO) in
> fuse_send_init(), and famfs_iomap (hence GET_FMAP/GET_DAXDEV) is enabled
> only if that flag comes back. So the registering daemon is already
> raw-IO-trusted; there's no access-control gap an fd's open would close
> (may_open_dev() isn't a capability check anyway, just a mount-nodev test)=
.
>
> Net
> ---
>
> I'm glad to (a) confirm we're aligned on GET_FMAP and its ABI, and (b)
> switch GET_DAXDEV to return a dev_t instead of a path. I can't move index
> allocation into the kernel - the index is a userspace-owned,
> cluster-invariant value for the reasons above - and I'd keep the famfs
> daxdev table where it is. Lazy discovery has to keep working either way:
> only the primary daxdev is known at mount; the rest are discovered as the
> famfs metadata log is replayed and first referenced by an fmap.
>
> If you still want BACKING_OPEN after the above, say so and I'll make it
> work, ABI overloads and all - but I think GET_DAXDEV + dev_t is the
> smaller and better-fitting change.

John,

Allow me to be blunt, because I find your email counter productive.

I insist on BACKING_OPEN. Please stop going in circles.

Miklos is working hard, doing all the work for you, basically preparing fam=
fs
for merge nowish and what I hear when reading in this email is a very long =
rant.

Maybe I am slow, but from this very long email, the only thing that I find
technically relevant is "the index is a userspace-owned".

All the arguments like "famfs does not need to open the device" and alike
are, unless I am missing something, completely irrelevant and counter
produtive to your goal of merging famfs.

Yes, you will need to make changes to userspace, please don't list those
as technical arguments for how the kernel should be implemented.

Letting userspace assign the backing id is trivial.
Can either create a new ioctl DAXDEV_OPEN or reuse existing fields
and flags in fuse_backing_map, so that passthrough server could also
assign its own ids if it wants to.

It's all about sharing the infrastructure, not the ioctl number.

Are there any other technical problems that you can point out
with the patches that Miklos posted (including FUSE_DEV_IOC_STRIPE_OPEN)?

Sorry for the tone of my email.
I hope that the good intention of working together towards an acceptable
way to merge famfs speaks louder than my ranting.

Thanks,
Amir.
