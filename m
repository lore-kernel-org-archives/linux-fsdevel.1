Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B963403E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305060; cv=pass; b=UA7DxmkvT9+2zIPmbA8K4Z786/y/bhSVi4erXMWOUQsYjz9LyyUKba/qyOq3hb9kmx6gaQERkabs3o6BoCRKhNddgOMAJrhq82eq5KIY+vtokT9ECzmV8KHHTpR4ekOgBzCNDfoJKPGb7BEo8SLZ/6T7vLJ6C5+esWzNJvvrXHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305060; c=relaxed/simple;
	bh=RYQhR4/pwAjfTBfaUV6x4DC9DCiz845tJhWNEUuUUmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRljOA9VYsFUMaYL9mY1Im1C9mnb2apJy2pWphMcxQ3GJWEuoln1votKZvpzmjI5wY3U7M4IEw9T2l9FuGKPEyrrYixaGOK/PU6RiGYazE8pvnTr3MvwEJCz2UYym6Ie4e0/OQer/ZTA3OSUAdBL/ZE+zIw1Rzeg2h9iroXboVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TL/15FJJ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL/15FJJ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so400184a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 12:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779305057; cv=none;
        d=google.com; s=arc-20240605;
        b=EUmAHRBrjlZ+VA3JNoMl7ovrlEJfUhYEaa+FlNhS1g4XN+dJ7meAmVcJ7HhQbu2sBd
         gz19EL5l1ZHin2h0+FMOvkCocv3q28pZbCx4HeZ4g66lZya+WZeJ3lXYaOMq6VZen2vb
         vI3k/lFTBtSUoeXasnqFEROOuOt3HJ0wL6OYlinnDXWnkX3WK/4ztum7g3CF0IYTbKIP
         MaRJDxeqq04Z9e5WsNrYpPMt77y7SxrStLnPuCNoK9pRThdZWr8N8gT67wvW38dd/xDa
         +ipGhjvpjVZAL8nbTH2sVAyR3hq91alOypIGwHt9CIT7v8IhJIrzpJRwjphWqkB7OE1E
         /aVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MywtOlXewxjrYMqMQj5KpULsLy3W5gueIKRBIijwzkA=;
        fh=MH2hv5zL7nXr/RbxC1NCjrzO8q5djU+khJfTfZNZOnE=;
        b=cnAt98kT0BTFtR635CbV6UtenQWzmdQSvtCHXrU71tKBDB12QKwRft+HJ0ztf6i3uc
         9Wu9oANaNFTXrY+MZ4zewQeqk9vtCf62KCSQnhRy48KAgjA/L4mtF8T4ZRMBKCW6LFc1
         3nw/sM5fK6YJbIyYIqbbErmvAG0ZT9ZY09doNDsiV91uFSMhgqQf1XJkIeH9wJo4tINz
         LYsRD3LTg9lDK88zqak5/vC4xkADfyYy231w1WVgKWFnP8XJKtp7ZtSabcsojxkvJJNV
         PDwAUSrN3onMiXc7dG9JaB7tZ3o0L32OGepJJhv8DJaXQWnzWtTvTT0sqoBHsOgeGHGi
         P9Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779305057; x=1779909857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MywtOlXewxjrYMqMQj5KpULsLy3W5gueIKRBIijwzkA=;
        b=TL/15FJJ+4F1He32HhQGsa6hkdepo98vMs6kq2x0J6jmyDzlR1LBcN/PXcdSwJDVrQ
         e7RNOSwnHJuUvgSO0Fo2x035ICPMna+9lGlcCKNZlW4XcTjHur18Rn3RgLQ4VQQdCEiP
         y8iUgl8OKjtHWvz8Xt5cWDWaKmorVgeHYUFzIimq4Uj3I7NesYJkvH/0LsOYIWg3U5cZ
         sY3xAR5kgZ68MKnz+2ENZfsWKg4vw0fHZIBhWkBj6MckzY/xnb20yB1EilGaTMfvM+Vp
         Z8735igb9EKTiWmOcj5tVvKx6VCjsFOUE+ZoWtUpi6IYMrcik+hdY7LgrK+hRH6ZdMxI
         OCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779305057; x=1779909857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MywtOlXewxjrYMqMQj5KpULsLy3W5gueIKRBIijwzkA=;
        b=P2ECUytX7cqQHrhE8vLCxD3IuXNmR65Xh0Js6OGJJ2mz99urJ/QY/GrQHHXPYjc2kX
         5SQlUAqZIi+nw1yHSKvzriXHiOKWOeW0di97Z7mthd31Om2WEY73+Yae7oqVsAWUdxt0
         ikOlEpuadzpdUE6BgItUQQ2cpIGOCxRDT5LxyRzrQHei0IMKTUsncwpa6pTPqXWagV07
         A51UH0FNdzKbBzjmzpuu16znqkfEsDZasCZmOIPymMskJqnGpEQrBwaLj8+I4u1qLytv
         oYPOZ7crPnZM054OrbNedzWCNdMckHzZgzkj5ZlqdgmwZG4bD+X+4XVhJ38DpqTDS2x8
         rFsA==
X-Forwarded-Encrypted: i=1; AFNElJ8X+MwhkIKQcaQh46mUTwtfAhJV3Yhe3JNOP/ivbzAYVdM7UOtdLf8r+XlH7HMnTJ/3zFQZZ/rlU6BKcEdB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2Iwa/lrQLfTO4g+cNVLGoyKLzMFsUKTEsFdt/0Lp7egdaucX
	RfLIoYWHc+0+s3iDEkeY+nYh4jfAefdy3tAPm8otfq/5rchJKLV1xET+crlekxeFqYOcIRxHpQl
	VWNA5I3DIKpeuPCYf+BgoQZPgbclQpT8=
X-Gm-Gg: Acq92OEJggO4HkfudykHehhjFwwYij/8SuD1xqNxCF5pNswLnMDe8GLXZh7c9KMAc9O
	dDNndjj44w24lK7JdYt4+9vSPklBml1XAEwVX04qUdvu4UPdmxn6xERiCOSS0NUcspG1BJz7U91
	icmrxNPR0h3lv2gFg68Fgh6Er+r5tFnBWXp2+30H1foNabmjpn3lJ/YfE/RH7yxC2cyt1TPPf7p
	jM0Aw7jQRj8FtqTp5ZtJuw8ksdI8nwz8YvoVAczG+Ga3a3luSWIOEDFEOEOMy4Tita/vMt9NfLC
	OCMWc7HbuzxHV0zdufQAuY4sPSzPyChvGF8dhRlPTg==
X-Received: by 2002:a05:6402:450a:b0:687:325e:748d with SMTP id
 4fb4d7f45d1cf-687325e7618mr1999814a12.17.1779305057158; Wed, 20 May 2026
 12:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <20260512202336.GC9544@frogsfrogsfrogs> <CAJfpegsPqja+MzfmvCE5054y9pv1_cwPRH2uGmFws-wwxJmrZQ@mail.gmail.com>
 <20260519220359.GJ9568@frogsfrogsfrogs>
In-Reply-To: <20260519220359.GJ9568@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 May 2026 21:24:05 +0200
X-Gm-Features: AVHnY4Ln7lY5nmU0TWl6gzR2CNOIIBxLScEwRHXkKG8ot2v33vyDrK87LvFUFUM
Message-ID: <CAOQ4uxg7mkmE+Y+2rrYodwng1ZZZ6PycbwaBufATH4KLOcRnXw@mail.gmail.com>
Subject: Re: [post LSFMM summary] where is fuse going?
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel <fuse-devel@lists.linux.dev>, 
	linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:04=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Tue, May 19, 2026 at 11:01:18AM +0200, Miklos Szeredi wrote:
> > On Tue, 12 May 2026 at 22:23, Darrick J. Wong <djwong@kernel.org> wrote=
:
> >
> > > As for fuse-iomap I'm not sure how to proceed
> >
> > I will try to dedicate this week to reviewing fuse-iomap, hopefully
> > without too many distractions.
>
> Well gosh I had better get going on posting v9 then.
>
> Since 30 April I've:
>
> * Ripped out the BPF stuff after all the shouting
> * Added a simplistic iomap filesystem striping mechanism
> * Tightened some of the checking of the iomaps being given to the kernel
> * Made it so that you can remove backing devices
> * Actually check read/write access with the iomap bdevs
> * Improved inline data write handling to be less flakey
> * Amended iomap writeback so that you can run a standard ->iomap_begin
>   to collect mappings
> * Banned freeze except on iomap filesystems
>
> * Fixed some integer truncation issues
> * Add some iomap helpers to libfuse to make it easier for fuse server
>   authors
>
> > >  -- in the long run I think
> > > it would be cleaner if each file IO path (virtiofs dax, passthrough,
> > > writeback_cache, iomap, and whatever we call the original one) had it=
s
> > > own file_operations.  But that would require us to refactor the commo=
n
> > > code chunks from each file operation function into a bunch of smaller
> > > functions, which I think would sharply increase the review backlog.
> >
> > And so the plan is rather to basically start from scratch and do that
> > form the beginning in fusex code.
>
> Heh.  In reading through the fuse code to figure out how I'd get that
> done, I came to a few realizations:
>
> 1. It really *is* easier if the server can set FUSE_CAP_IOMAP and from
> then on every file on the filesystem does things the iomap way.
>
> 2. Many of the random weird callers of fuse_inode_has_iomap() outside of
> the regular file IO path are *actually* looking for "is this an
> exclusive-mode inode"?  That's pretty much all of the file attribute and
> ACL handling code.
>

When you use the term "exclusive mode" you mean the same thing as
"local" filesystem as opposed to "remote" (or clustered) filesystem that
can have attribute changes on the server and needs to implement revalidate.
Is that right?

Can we maybe stick to the "local"/"remote" terminology?
Or am I missing something subtle?

> 3. iomap and exclusive mode are mostly orthogonal concepts.  One deals
> with plumbing, the other deals with attributes.
>
>    3a: iomap without exclusive: This is a clustered filesystem client.
>    The client grabs a file layout lease from the server, and uses that
>    to populate the iomappings.  Timestamp updates are forced out after
>    each write, but otherwise it's the same attr cache and timeout that
>    regular fuse uses
>
>    3b: iomap with exclusive: This is basically fuse4fs and all the other
>    local filesystems.  The kernel knows that the fuse server isn't going
>    to change the file attrs out from underneath it, so it can cache
>    timestamp updates in the kernel and only flush them periodically.
>
> 4. Figure out how all the attribute handling works in fuse is really
> really complicated.
>
> But there are questions here -- I'd like it if the fuse server could set
> FUSE_CAP_IOMAP and all files are iomap.  All the weird userspace inode
> flags setup setup code goes away.  It'd be even nicer for 3b if you
> could declare at mount time (or FUSE_IOMAP_CONFIG time) whether you want
> exclusive mode or not, at which point all files *also* become exclusive
> files.
>
> The problem with 3a is that I don't have a client or any way to test
> that.  If I just don't allow iomap && !exclusive, how sad would anyone
> be?
>

My view is that as long as you keep the design sufficiently extensible
to support iomap && !exclusive in the future,
let those who care enough about iomap && !exclusive step forward
to code and review and test it if they care enough.

Thanks,
Amir.
