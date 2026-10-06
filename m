Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B73DA7C6
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280117; cv=pass; b=XuMO+IGpQnw4sglPQjME3Ird/YI0NCiSyehD4Yafv1KCToY6KZlSi1eCKrogDFSmbbIk9k42U8KuAYoXHdPwxTJaGGh+1m1bPB4DRNyz5Wl9KF0Wcv8CrjwIQzRABbWrhzbM0e7IXQ95ESknUeiOs1iIhCprM/md+Pp6zfjvhx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280117; c=relaxed/simple;
	bh=z8C5llEeSas+wDevoi5ayKBoOPvXKhtMoOZYxs8J+Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9j3VtqLoA4MXR8OfSFQLrnybDp+0ukTlb2S1EUIpy251dmWeno4dGielmnLerBRJBDOk1FkCVrWyRXqWzZ5Y4Lw3+XIg+o5CEn5i9Cg9qm1QJbo2+m84fiGC120OznMUyBZVdergCqyP9nF8nnfkmWVJRVd19MKrx6+H/cDDS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XZSpqJ14; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XZSpqJ14"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53397554beaso27892661cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 02:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791280112; cv=none;
        d=google.com; s=arc-20260327;
        b=rl7OhbAZZCiLd8oGNWYKN7Ndbh2He3NgPAXCZhBm/gjR/459UfK1zE4EFRhzdL7A28
         JjcqieOUb7c0vjz7aOmE8ih3BSf0ss46PM5kYZHYN2VsDwIFX4JhY5Cv8DHkL7CUK6Fk
         AD4aJoPE1ov4ChpJGXTSl9xfhVu19uzOSpDS0PFe4Nplz+qlJqdT81C3ZVIgI71QQ6M4
         iwa78arKAM/LHjNjN7loVJ2eyy6JIDGwqvllKdKARoWeeTrRuAymDlA5jAbUbw9bpY6Z
         b9HXhx9E3XAI2QxhQOdPMTgVRYL0q2NRzX9XKaFuhKnEjMP2SlWhgJhnqp4fOUzGRcSx
         KQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/5ZFcmaqybTJP5VKzEwaO+zhe9+eXiIc/pJbQP9+B04=;
        fh=V95hsvnb4WS2/MRKm2Jw0AumdRT9lQ7pIx9z9kpN8xs=;
        b=K8aHPSqDVenlza7Hcq6ZrcLs35ooXFzTTOnWzmR6Yz6Y+2FTtQaLvOjQ60LZMl95cs
         asNZ7+c/FyJqkxZpo32oPfSlMyu6GlKCpR/J17FeUrFgufhY0oCGAETDeh6FYpawdLRU
         ChyOMd9eH/goK1OarpCbNQOvSzdUVFIKCGzZz9mo/Di7eYeEndtxKVKwKEJ4jeCYz2Kl
         GPY04j1lKld9veB6d8JdEmkbmKZLxghgD9YbvXzY4CmGuHF017Edx95SpwTuiUfVPuy9
         TuAefYjJpLRcmoVgGO4rU1WMLaoVhLMeHfz+KdLRK9UIXd6hszOsbQAHJhIIrT7BFGNt
         ACXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791280112; x=1791884912; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5ZFcmaqybTJP5VKzEwaO+zhe9+eXiIc/pJbQP9+B04=;
        b=XZSpqJ14jV0etdGDsBDvwGbtZKbssnTj2YlgxtYfwS8oQNRvjD3OdBHhs2QMwdygU7
         63LnXdEcsl8V9rIeMImbJE1LC0kZAJJvdMk6aCacqEluDHShkr/O39NSPsJYs5o+yMxG
         Jqh5IQlbkslM0GzrQbTt6hrRtDYxk0VaDZlZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280112; x=1791884912;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/5ZFcmaqybTJP5VKzEwaO+zhe9+eXiIc/pJbQP9+B04=;
        b=AVOmcXjBrdAwwc99IBd1UKYZzAxyPP0W9aZXZM8k2nI6DeV73UGHWkqWnj8ATm1n7y
         QHLTeysbRsybwZP2CozvedGco4wSmBwa1ssVaySCKGHbGaZaTetIoUAT4FK//JheYHTV
         9izNO+OsKiDJdCTA49OM9vVD6/bJBpTS5NI56Cs7f+t4z+2iktTlieh0qpQ84p6TD+Qx
         Tiy0E6DGqNQaHa8TcbVTHv74amtTrWC3GwlAXT70+ANeMy2Gx28OhSm6gYEB+I9nIuua
         rwo72ulvjGhuRKRfU2aTLOf5aGSrjLmmJBAKl9zJpbBtwjvC2D6pyXrm9w6j47VRRBhI
         4PUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBY3zMCdQckFFzGQj+SxTgih/TrFDhO+Y3rw9QL60b9LCybGzsP/vTIrRxzSoLE1/qKuG+KW+EguB4kB5x@vger.kernel.org
X-Gm-Message-State: AFuF++nj1vBD4O/cXD9eaqeUhNidlXT3vm/e3PEPmUucc2C3pzzwSBgt
	So0ebqYr1Gi9mjaRYmqjO1HONlWPsRBK+1+++fBP/9fBF7ywq/yawD0yxzCiyFbd/O7DNDmkG+b
	SgiPK7zesFqjQWNhIzJ6Jvaz67ixM2pRMlFMpNZgV3g==
X-Gm-Gg: AYBFou2FomE6ZTftSFA4XbbR5K5yckQ0ZZUGMnqHbTgfDiLpwY6EO3TiHlerNJlgRg4
	y3oga3lbpYjQciVlhs0/fU+V3kq7ypRvNOC+71NH+rV05ez/uU048mTFzDhhGRaIIvoCpNSLkuz
	0/egmSsuVri0Sm6zyiD802K2s7gj+WNFJZUpJX9vMuzH2Aulkv49BqXOqVoyz+85UoZWWoHdmSm
	jPTDumoyddrsQ6L7RQuxF49s8jZa32k1GB374/SJelrdMy8JE99k8mXG02LuXQbmnupCK/Gd37B
	/Q+ca5FTXadx55jNuHiU4aadOAaLEhs7gLAc7roIi1qGFfDVZg4IujEZeqVuANezKLljNHMJKdk
	ZDQPo1ACdrOjH
X-Received: by 2002:a05:622a:1911:b0:530:f77a:b162 with SMTP id
 d75a77b69052e-53511e4f3f3mr177910411cf.27.1791280112604; Tue, 06 Oct 2026
 02:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <asQcBebepPb9CXzS@groves.net>
In-Reply-To: <asQcBebepPb9CXzS@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 Oct 2026 11:48:20 +0200
X-Gm-Features: AclHuK80ssbUcTC90bN8pi5U0qILib7vm2yX0MtoI7xgqfk-YgE_-OE-vHSlWAI
Message-ID: <CAJfpeguEUTYk9m7g2gZTMui0yFDYWSGL1SZ9PvoYiCqjDmHp9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] fuse: DAX device based extent maps (famfs)
To: John Groves <john@groves.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, david@kernel.org, 
	willy@infradead.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 01:37, John Groves <john@groves.net> wrote:

> I see the kernel-side rejects these s/size/chunk_size/ strip extents if they
> are not all the same size. Why not put the chunk size in the header and let
> the extents honestly describe the offset and range that they cover?
> The current design can't test for sufficient strip extent sizes, although
> it replaces code that did verify this.

Not adding chunk size to the header is intentional to keep the API as
simple as possible.

> However, the smoke tests passing isn't fully legit, because the patch to the
> famfs fuse server passes the entire strip size on CYCLIC mappings, meaning
> it just produces a concatenation of ranges - which does not achieve the
> interleaving goal at all. That case degenerates to simple extents.

Are you talking about the case where there are multiple simple extents
each with a different striped mapping?

That case is supported by the API, but not the implementation (since
there was not test case).  If you do a test case, I'll add the
implementation.

> To be specific: each chase/dereference that results in an L3 cache miss adds
> a stall of (1 * MEMORY_LATENCY) to the fault time. This is the good reason
> why I didn't do any chasing in the fault path of the famfs code that you're
> replacing.

Please benchmark against the in-kernel implementation.  If there's
significant (meaning it may have a real effect on a real-life
workload) performance hit from using the rb-tree, then we can add an
optimization.  I don't want to add complexity without actually being
able to measure the gain.

> OK, one more. You're using the rbtree for indexing by file offset, which is
> a zero-based non-sparse range in this case. If this could not be avoided
> (which I think it can) you should use an xarray or radix tree for that...
> right?

Unlike xarray, the rb_tree API is one I'm familiar with. But nothing
prevents switching to xarray if that's a better choice.

Thanks,
Miklos


>
> >
> > Thanks,
> > Miklos
> >
> > ---
> > Changes since v1:
> >
> >  - moved 3 prep patches to fuse.git#for-next
> >  - introduce FUSE_PASSTHROUGH_V2 (Amir)
> >  - lots of small fixes and cleanups (Amir, Sashiko)
> >
> > ---
> > John Groves (1):
> >   dax: replace exported dax_dev_get() with non-allocating dax_dev_find()
>
> Golly, it seems like there's more than 1 patch worth of content from me here,
> but the chipper/shredder might meet the letter of copyright law in some
> jurisdictions...
>
> >
> > Miklos Szeredi (7):
> >   fuse: add helpers for EIO return value with kernel message
> >   fuse: support 64 bit, server allocated backing ID
> >   fuse: support opening 64 bit backing ID
> >   fuse: add support for opening dax device as backing
> >   fuse: add extent map data structure
> >   fuse: add extent map I/O support
> >   fuse: add support for striped backing
> >
> >  drivers/dax/super.c       |  38 ++++-
> >  fs/fuse/Makefile          |   2 +-
> >  fs/fuse/backing.c         | 292 ++++++++++++++++++++++++++++++-------
> >  fs/fuse/dev.c             |  21 +++
> >  fs/fuse/dev.h             |   3 +
> >  fs/fuse/dir.c             |   3 +-
> >  fs/fuse/ext_map.c         | 299 ++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/file.c            |  16 +-
> >  fs/fuse/fuse_i.h          |  72 +++++++--
> >  fs/fuse/inode.c           |  17 ++-
> >  fs/fuse/iomode.c          | 108 +++++++-------
> >  fs/fuse/notify.c          |  75 ++++++++++
> >  fs/fuse/passthrough.c     |  63 ++++----
> >  include/linux/dax.h       |   6 +-
> >  include/uapi/linux/fuse.h |  53 ++++++-
> >  15 files changed, 904 insertions(+), 164 deletions(-)
> >  create mode 100644 fs/fuse/ext_map.c
> >
> > --
> > 2.54.0
> >
>
> John
>
>
