Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30439D6CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577533; cv=pass; b=pYi2I4bLojhSEGw2CRE9EyCMk3Jlt/D27+c+O4sq4vIXi2dZRcIgKEQeO7TWdWxWma5q4kjEFxoxFQjfbw/br+EkM2GKhQb9wPakgQIzpHUMO9S6KYAtmZC7xU24kdrEBwYNAYT1/tpa00x3aOP7WCKTcB7eUrodbViKPwTsdmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577533; c=relaxed/simple;
	bh=PejVIfKm6gMA2k7EB+iWymJvu0zxg39FhPOUMOHymSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhNRuqcq76EChKqYEr+siUE6lHcT9L0bHsoZ5TfDq+ltw+qokKrRw8b9HNkDSbtaUNxgw4WrKuyrKF6czqFrah7tl+6hLdEGHwDuMUDacy7+jJQKKtMndJ0DIyFqtK0JbiT27mqT8mOe6xxg56AaGwIdzqU3yCDimdSbb9cUuNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CADo51uM; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CADo51uM"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899a5db525cso32870426d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 02:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778577531; cv=none;
        d=google.com; s=arc-20240605;
        b=XQn5yRYvffDmM6Z/vASwiQBxATNvyTt93QUwTYA0LniJ47uMSype1L6jYpf7EAcnvX
         ew7E4Ral6drq9wvGuV0Ra51LjJIgPJVpdGm/phSZRM5msPTW8JiI86DLNq6NQHkjS/FT
         g/hgUSolnzdvzi3QIEn3fuldZ/4XAq1WnyjUExYPXJ3002vmPS5V8E6IEEpNvzjGf9M9
         PssxwcRKKIagespmRkRqZ7xexBboQuutSGgkE6fD+YkI3QbomVKCV3XdOf6NbviYd4o+
         dWeoCRuPXIM5rU0Mg5W7LTlPu0FNny432xSUZNSXdG2mig23V1sfz8ZvEmtG5N6o776+
         QYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=86V9k6wlWt9F888GzDwUK4mR1rnUbwmpjgDnqR6kVrA=;
        fh=ZmO2Yc0RI7k05Zvy3Cq+m770M5qWbnPanXP9FAw/UJY=;
        b=kdjfPUJg4S3PamZsx8r892QsmV/mTP+n4ux8ArFOAGraGhUuptQPZIGYIHSDLFTD6J
         zgKi2G5jSev4MwrRPmmWAab6kJhxQb7pGxqwbk6EH7sjRNOtHj9WE7lNj4nG47ct2FgE
         BXO/9ZDvfIeJh/vbiMdgSoD93XX/9nl7Dtjp6US8PT+Tnht7M0b2imbBMoST8ZiZ+lqa
         F+PzpkIjYg8Io9nOHIxVYGeQbrU3gVuhkw7EQ0xaPtLPO9UZVweT88ly66uRrHUneekD
         sh2kbSjU9E7YTFw+X1cui0Do305LHIiGa1pQKC2GK4q9+2/vUbFyWGHAjbPfmyeebRVu
         lYRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778577531; x=1779182331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86V9k6wlWt9F888GzDwUK4mR1rnUbwmpjgDnqR6kVrA=;
        b=CADo51uM8n0/GIqTW/gLPcJpC6O+uLj02ncCgtSMqlsnJMXQsAON5dbIaj2fH6vfGt
         bGmVsgW9BV8u8jqilVmicJg1s/hL0ioZnbRijnMwSYYmNg4mJf/M6bkrQp4LN2rcZ77C
         qZdU7oxCh0es16fWuX7S3+CEPOqfBqNHBmdhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577531; x=1779182331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86V9k6wlWt9F888GzDwUK4mR1rnUbwmpjgDnqR6kVrA=;
        b=E2pXkE1If+kCuxblKedWCGN5YUw/4MA9P8hQJ3sZ+JaNeIrkSaDbp0b0u8Ea7r9VmR
         YrvdRYfIrf1MJmkE8zH1ZsrncK481qTjjCdCMelU9wG5Bvw7Vwdo4Yh/raMMIBdGHW/t
         6UELsjRFRxgOQ3y0nAMbdZKBC0V5ESNIJzHd0I3FGy/U8yJhrMH5NUcnBmlCl+B0t2ba
         dZYRAmICveA2T4gxPnqGLB9qn/ojjDTrpHUUB455cR+E2YxbJOArE+QgzWIkvvWJo3sN
         jTRzLasJgt2FMsWlFxaJMpTS03aSkEKpqNc/gUbdM9Mvyy/+OchgRBX14SSGJk/Za80F
         yFsg==
X-Forwarded-Encrypted: i=1; AFNElJ828JuxShyKfwB62x9irgrig88mPgWznRRWR7ZGkj78I81emjaaEYmTvRyFeLE/8T6RB4u3JP4TB1HHlRMy@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBYWVXAVTu4vsFv5ADgspp21wkDI0PN0L8/P6pVnLqfjDLeWC
	cLCiNNn/AETN2eN0T3p0eRWq3mzjC7TDekko6qBqrSgCurl+ZSJw+qPXORzmz/ZUNp1HzqVKYNA
	dh09/SWbdRXWGGmuIeyjmRwu9g7WMOct/xm2RokOiMQ==
X-Gm-Gg: Acq92OFYoiOaaEesP7CC0CC8KdyrmC7JTf3Bq5QjmC3h9MDxP4Pbtj2j9NOpBg/XDgr
	+pkl1dzlUkLTyp+WsgulygfSzpw69SAp1UXjnCVQm4lbwJMOAZqObxFnJFxhify0KTeO/z3ewFC
	XgBl2EWairDVfu6iqM/YduSPG41yThAdCZ5iCuXhrVbtYJx3qZNSpFDGpbK35hZLMMIrZ5woobu
	5c4mpuPGAEU9Fng/SyaG4yNLbzUhwR9ZZO9DYERdHtn/765ecgTxnyHAhbWrBRov4mEwfpwMmpm
	9b0l0nrspOdQ8G8BT5B3dGQ1+4+4hPOW+MRRjpckoo3ta3RS/g==
X-Received: by 2002:a05:6214:226d:b0:8ac:a5a0:481 with SMTP id
 6a1803df08f44-8bc4249d8c3mr401632546d6.4.1778577530758; Tue, 12 May 2026
 02:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
In-Reply-To: <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 11:18:38 +0200
X-Gm-Features: AVHnY4LY0flrqk7lZiLWgJLEHl0t1ogo3cIM0o-DrODJzYVmHttrDyBRAo6YtLM
Message-ID: <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 07:05, Joanne Koong <joannelkoong@gmail.com> wrote:

> Could you explain a bit what the main motivation behind fusex is? Is
> it mainly to clean up interfaces that are now clunky/stale? Or is it
> more driven by limitations in the current codebase that make newer
> features hard to add? From the paragraphs above, it kind of seems like
> the latter?

I think the answer is: both.

Adding new features also hard because the old interface is convoluted
and inconsistent.

> If it's mostly to clean up interfaces that are now clunky/stale, I
> wonder if now is the best time given that, as Amir phrased it in [1],
> "FUSE is experiencing a renaissance of new features and protocol
> enhancements", and I'm not sure if we know yet if these new interfaces
> will also have some things we'll have wished in hindsight we had done
> differently, especially since some of these new features are still
> actively evolving and gaining new capabilities (including io-uring and
> passthrough). Would it make sense to let these new features and
> protocol enhancements evolve and stabilize first before baking them
> into fusex?

Excellent point.

Currently fusex concerns only the filesystem layer, and is agnostic to
the transport layer (except maybe the SYNC_INIT thing).  That doesn't
mean that we shouldn't have the same API cleanup in the transport
layer as well.  For example, I'd love to get rid of splice on
/dev/fuse, which I feel is more burden than blessing.  And I guess
fuse-uring could also do with an API cleanup.

As to when and how this should be done?  I guess that's up to you and
Bernd to decide.

But I feel that we do need to have more high level discussion of APIs,
if we want to avoid repeating past mistakes.

> I wonder if libfuse could serve as a bridge for the gap between legacy
> fuse and fusex, eg libfuse filling any missing gaps / translating
> between legacy fuse protocols and fusex protocols such that any fuse
> server written for legacy fuse could run using fusex, which would
> remove the need to have to do any "backporting" to legacy fuse for new
> features that are added to fusex and could accelerate the deprecation
> timeline of legacy fuse.

Definitely.  However libfuse does export a lot of details from the
kernel API (e.g. INIT flags) that would no longer work with fusex and
not really feasible to emulate with libfuse.  So some porting would be
inevitable.

> Some other things that might be nice:
> * handle_killpriv / handle_killpriv2 - sgid/suid + file capabilities
> clearing will always be handled by the server (default implementation
> in libfuse)

Which is in total contrast to what fusex now does (all that handled by
the VFS).  Need to resolve this sanely somehow.

> * in fuse io-uring: headers and payload passed together as one
> contiguous buffer during registration for pinning, deprecate passing
> separate buffers per SQE

Okay.

> * in passthrough: backing_fd passed at lookup/creation time only (not
> at open time), expanded struct fuse_backing_map

Yes, this needs discussion.  Amir may have additional info on this.

>
> >  - only no-open mode
> >  - new requests:
> >    + FUSE_LOOKUP_ROOT - return nodeid of root
> >    + FUSE_LOOKUPX - FUSE_LOOKUP without the getattr
>
> Could you explain why it's preferred to have lookup disentangled from
> attributes, eg why compounding lookup + attribute fetching is
> preferred over embedding the statx directly inside the lookup request
> without compounding? it was brought up in Luis's lookup handles
> patchset [2] but it's still a bit unclear to me why compounding the
> two is better. I think every operation/request that returns a struct
> fuse_entry_out uses the attributes immediately after through
> fuse_iget(..., &outarg->attr, ...) or fuse_change_attributes(...,
> &outarg.attr, ...),

That's one argument for decoupling: why include the same fields
(attributes, validity) in several ops (LOOKUP_ROOT, LOOKUPX, MKOBJX)
if we already have a separate one to do that?  It simplifies the
protocol.  If we started with decoupled GETATTR, then we wouldn't be
taking about adding these X versions, because it would be a simple
GETATTR -> STATX conversion.

There's also an interesting side effect of coupling STATX with LOOKUP,
which is inherently racy:

Thread A:
send LOOKUP + STATX for /fuse/dir1/filea
[server performs lookup and statx, sends reply]

Thread B:
send SETATTR for /fuse/dir2/fileb, which is hard linked to /fuse/dir1/filea
evict inode for /fuse/dir2/fileb

Thread A:
looks up inode for /fuse/dir1/filea in cache, doesn't find any
creates inode, fills stale attributes

This issue is currently solved with fc->evict_ctr in regular fuse, but
works fine without any additional checks in fusex because of the
decoupled ops.

Of course, it is probably desirable to compound LOOKUP with STATX
despite this, but it gives the implementation more leeway  (e.g. on a
different OS).

To conclude:  separating out STATX from LOOKUPX, etc. makes the protocol:

 a) simpler
 b) more flexible

Thanks,
Miklos
