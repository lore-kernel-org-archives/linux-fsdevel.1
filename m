Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32D3DB990
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607215; cv=pass; b=YDtPabl6br3fRSkJe/UO/O85zs4eEKyso/pRJBURal7kVsY1N3MKlGjKMdiGIA5FEMXhrWSxmljrJj+8C2TryEcwqrDppl4mKntoLTJLDKinBoZr1YixVBSCfn/DXqp7pd1CxJybhg0InoUP9Q1HH1m7zg8vjc0joujH/TbtAg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607215; c=relaxed/simple;
	bh=bx1ALw++qxDz4TNZohgE9siVkcyKnijRmQ6zSVOuvCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zq5gi84kF8jAve5pq3ksC2yKeYkSkbjbneHDMibJwfvCnrTia1YHZ1hp3AKQvoya+kKc23Xwh/7BDi40VjeajrkOd4H78BhzGsDfdhEhzz9GEwsMJATwXoRiwz5GugaOci8o+6by0FVC+dDiVv75BboMszrxpFEoe97reYFrn5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmY/dbnC; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmY/dbnC"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4526a8170ceso3217227f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 10:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778607213; cv=none;
        d=google.com; s=arc-20240605;
        b=WnJkw/+JOEaWfPoGCq4wgVOXgFbAHT8I4UjDAeviux6Q5Oer1r1C6zgrr5mT6dv7+B
         2OPf2bPQZCCgRX/BkM7SCOXeLr7oWFJAs4vpgJf0Agi+r27yBlVXVciIZrf0H0FWg3io
         4Qr4DiJevCPAFbCvuedF9vYRMx3bvl2FmzGEpFyGwdkpwZsSQWwHNoddwbMhk7o1Xybr
         UrrMsn11EQveBJrhMzBTX1A6cu3vvVErj8N3/qYPZW2pgpR4JoudirDJeC8aiCX/45pM
         W5w05z4zvWAFhOMrmWUl/Zy+r5IpQ4U6QljmAq0ac/4nqkt/ipqS9Lc/y1C2vfKO1B9E
         rPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H/0sPaYMmGoBFflRfz/2Lij5pJssu3sZGPvBsHgCT6E=;
        fh=2ILmVBEBcflogWI5hvM82yvUiNSpLrHivQUjWOamv/o=;
        b=KGD31ukunie3EoN3Kani2GutA3IA+OrrrxPJeEQuCpRBIULR81cLdwJDZL0aAXZkHF
         HiTQ21O4aNsh8GIZCM7bhpOGtXSWck5cLr2/x1CUrkdym1NYkUHeG3xrKQFvPMq55Dcz
         JkMrA1LZJViMv0tcPRxaLMUZEmMHaN9Ov2jrm7oRs1txgDGChnsQVSJG0qe2Zebaxuj0
         rZwHgRzyrRRfC5KQ74iPja85AxPjvOCkgYMs2bkTnj/pThKSPuXXnqSwQ4LrnKvYSEgS
         DqE+lAt/nAksXe8VzEcF308ipLggBo0IYTHDMtp2Ef29pKMaxUpdYGnf340ehHtMqYnp
         N6Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778607213; x=1779212013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/0sPaYMmGoBFflRfz/2Lij5pJssu3sZGPvBsHgCT6E=;
        b=RmY/dbnCiT1XSfHtgqgZZlMylucS0JyLFvwq3EO74Q66rNI3EaMZKwfiZgmGllyHUR
         76FnEvu/fasyOq/ASOAYUHUjOQZjsIJQK1ycSMTOStZGTx2fluH/3W5DE+6VN8/xsOLp
         bN2Ugl92AiRPC6h06LLtvWJPmkmBwhIDikNEHAZGs7uPTM9xVHTGAKxe1D9xxbly1k60
         u65G4cQb/hTUkufreMTV+IaWMJ4YBHfjUSXTSktJjDoTvhakBqvYM5lFCB8c8NRB4GEg
         lZII+COrQSmF5i3RZi11nzpkn2l/5FxOZQszeegGBH+MZM5pV+wdcNAlCi0aGhqhGTU+
         OzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778607213; x=1779212013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/0sPaYMmGoBFflRfz/2Lij5pJssu3sZGPvBsHgCT6E=;
        b=XDiUfp3hhgd0QUIrVIV/nssxgcW44JmJ+B1GFWG9WmI3JLLnffAjELnu0vr7A3kTwo
         BmAvItkoJxTR9tN/xFuROiyPrZ9CosKrEjUe/N7tPvkb5RxHjcZI44gty0inZ8V5T/db
         X9I7k4xtRwjZAHkCN/XzTcYVlg6Aj5FRUKBatLUdR3dWoj0KGV1sYjLR6Kt2Wjg6V2Pe
         BcxP/GgTs9e0zRotPe/6UZBQMLflzVTobo7NrN2uwzu+lEjYRj0bDW/GP53fIEI5UPw+
         A8bX8DmGZbUmkhBtuHFXON1M/tqYNw/6Jo+uAt62W5C+uxNy6BY8q94fSkGg9OQMkTMC
         uogQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yKXJkZdflIuBGVqots1UMAKtpCyYr9o5BbmHK7zdtza7IsWmm5I07w8BdKmDVStaCxvAQwnMiOWn8KTdw@vger.kernel.org
X-Gm-Message-State: AOJu0YynJPhO6cy+0l8ECkYAab7ALKAsdTXcKy0QWTuprsZJucWi97s1
	XTRLT5kXyI8bshpWf3DhltYsi8gXnNWpr6PCzwohIr16m9+eNrFntIuLgjXUhoKYcjLJNGCUH0+
	xU1ZiotC8KnMktcy2Ku3l5wEr/TNvwQc=
X-Gm-Gg: Acq92OGIAPbhzqhYW4ySZZadTqjJavhfdx3y/wUr+JmV9vkDexkF9QP0/AP/XR75HtD
	yRBh+sLBsGTyTpK5NSS2tZeO7xX32gEOyvuZKuKFIv19AO47uKk/PfJuDZ0AFunYvSX/9uLJF1w
	bScLiwRBIKPLJ1/7tJeMg3SlVxMf1aGtSg1gH+gisNkA2DUsYwTD5ryOJ9tYMoQ9nGLpV4MY+qw
	rVEc2zOXpPCJwR2Ore3mwxZ4SzSABp+ANHELsAH9ek+gx/Iy3F/7kSBHcF9624CK5zeuI7/dFrK
	Ud7QhA==
X-Received: by 2002:a05:6000:2681:b0:451:3b12:9bca with SMTP id
 ffacd0b85a97d-4568c19cfe8mr22719758f8f.25.1778607212540; Tue, 12 May 2026
 10:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
 <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
In-Reply-To: <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 May 2026 10:33:20 -0700
X-Gm-Features: AVHnY4Ky6JxxgiwpbdhVNQQpmXajlM2ggWvSqKiAo42kFpwU2nzT2qIZUpPGVkE
Message-ID: <CAJnrk1Z+Y2SJ7o-Ms8s9OfEutsYefbQTjRYXBfy3BhWw1hWqAA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:18=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 12 May 2026 at 07:05, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > If it's mostly to clean up interfaces that are now clunky/stale, I
> > wonder if now is the best time given that, as Amir phrased it in [1],
> > "FUSE is experiencing a renaissance of new features and protocol
> > enhancements", and I'm not sure if we know yet if these new interfaces
> > will also have some things we'll have wished in hindsight we had done
> > differently, especially since some of these new features are still
> > actively evolving and gaining new capabilities (including io-uring and
> > passthrough). Would it make sense to let these new features and
> > protocol enhancements evolve and stabilize first before baking them
> > into fusex?
>
> Excellent point.
>
> Currently fusex concerns only the filesystem layer, and is agnostic to
> the transport layer (except maybe the SYNC_INIT thing).  That doesn't

As soon as fusex lands, doesn't this mean with the linux backwards
compatibility policy that any user-facing transport layer decisions
are also locked in? Or is the uapi for it still able to change later
because fusex is marked as "experimental"?

> mean that we shouldn't have the same API cleanup in the transport
> layer as well.  For example, I'd love to get rid of splice on
> /dev/fuse, which I feel is more burden than blessing.  And I guess
> fuse-uring could also do with an API cleanup.
>
> As to when and how this should be done?  I guess that's up to you and
> Bernd to decide.
>
> But I feel that we do need to have more high level discussion of APIs,
> if we want to avoid repeating past mistakes.
>
> >
> > >  - only no-open mode
> > >  - new requests:
> > >    + FUSE_LOOKUP_ROOT - return nodeid of root
> > >    + FUSE_LOOKUPX - FUSE_LOOKUP without the getattr
> >
> > Could you explain why it's preferred to have lookup disentangled from
> > attributes, eg why compounding lookup + attribute fetching is
> > preferred over embedding the statx directly inside the lookup request
> > without compounding? it was brought up in Luis's lookup handles
> > patchset [2] but it's still a bit unclear to me why compounding the
> > two is better. I think every operation/request that returns a struct
> > fuse_entry_out uses the attributes immediately after through
> > fuse_iget(..., &outarg->attr, ...) or fuse_change_attributes(...,
> > &outarg.attr, ...),
>
> That's one argument for decoupling: why include the same fields
> (attributes, validity) in several ops (LOOKUP_ROOT, LOOKUPX, MKOBJX)
> if we already have a separate one to do that?  It simplifies the
> protocol.  If we started with decoupled GETATTR, then we wouldn't be
> taking about adding these X versions, because it would be a simple
> GETATTR -> STATX conversion.
>
> There's also an interesting side effect of coupling STATX with LOOKUP,
> which is inherently racy:
>
> Thread A:
> send LOOKUP + STATX for /fuse/dir1/filea
> [server performs lookup and statx, sends reply]
>
> Thread B:
> send SETATTR for /fuse/dir2/fileb, which is hard linked to /fuse/dir1/fil=
ea
> evict inode for /fuse/dir2/fileb
>
> Thread A:
> looks up inode for /fuse/dir1/filea in cache, doesn't find any
> creates inode, fills stale attributes
>
> This issue is currently solved with fc->evict_ctr in regular fuse, but
> works fine without any additional checks in fusex because of the
> decoupled ops.
>
> Of course, it is probably desirable to compound LOOKUP with STATX
> despite this, but it gives the implementation more leeway  (e.g. on a
> different OS).
>
> To conclude:  separating out STATX from LOOKUPX, etc. makes the protocol:
>
>  a) simpler
>  b) more flexible

This makes sense to me, thanks for the explanation.

Thanks,
Joanne
