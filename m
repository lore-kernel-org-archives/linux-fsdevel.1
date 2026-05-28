Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B1314A98
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006294; cv=pass; b=ex42/9WZ0GC8lXVr0mcE3TyLkplSaCuzJPnD03lkUD9OIixS/DDuh6z9G2d4e6SP/2RSVa88QjryiTvKON1+G0fS/82j0pp6JMz1NMBctJN8qkqssVqwEutTbkyGm2fX8tjot5aJ482wIGApyhe9oxEE7/wABwUX5NvnyEk2/94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006294; c=relaxed/simple;
	bh=euxIINF7wv73SHu6v2NinWc47eigP8Cku6fMCfrhzi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R31TKBHY1f+egMA/SkmVQkOkUMFJhPJxad2+30AkhSSWlbME33M3OPawavbj1/NqN4a+pwBx7p7JBboXfjrDToVq6Zt8BHeL3rV6sLZ0exZndmiQuqctxHmNrqGquTiuaeIfv5ZrTaZDxRNp/sHpQSkNelXSLZ4skp65C7NjkrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHmW0GZf; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHmW0GZf"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso18253f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 15:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780006291; cv=none;
        d=google.com; s=arc-20240605;
        b=BDtqLu28Z6H13s9QxGKhRdqnHFQ5qgI5h/B+iJH6GGBmO4XDrw2/56OA7SRrIXMDix
         X1GcaAmVlY/yVznsk8KCW5mtb4rbxVpe6sTuMl67coloWziIMxsvtSp+5gyLS4ki6ym7
         QgKAEa9ic7unLs9XIZvj97jPz/+pX7k7gwiXNW3BRy7uOXJL81bXSA1d5P5cxQ+zLRBu
         jJyZ1KdTcnpRdibF9wy0b1jgjCrtbc7JzYYDuqzaMnIupEj4dI35pRkQUO9C7wVhIe/6
         Br/ETaYTHAXGqD8QtyjalHO8xmZf+vpTG1Y0btRCPIMGuMWDHLvkE05amL0qnfmaUlay
         EwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4lxPQ44Y8kkRj37GFl6P5cOrmZUNkTL2anf97KW3Bg=;
        fh=pFYwCY4lBxVUdv+TPE2nDk6igW6Sww//U6wxZ8EPfaU=;
        b=DLKTDwsGT4oyf1chi3JVw6No/wufKgstjEl/CqmBkolb4a7aaldFQLzvV+vs4Q84aT
         zIPH5rSwOAhqeAQu3HMo4BViZyNHQ2ThHcx92u2hK7tUXzPrvqJ2Ex7/7L+TJYSLP0km
         3lU3DO6qxU9EqUQAgT41axgg61v5X/ATx8AINWVSUtRsyR0BvKOYcXxq2WPJ0L52lKOH
         CEJCVumQnw6PF0CFt71KlLFvlS2SvcnXTmOhjVqMXIN1cyWndZ7bWPXqk4x63SSwD9Bm
         8cpMgiJQNR+T+tHxq2xjoAG0gV26chFZofFHu0s6jRhFeeiN32l6noz3vKPRD6cWPQIZ
         hyug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780006291; x=1780611091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4lxPQ44Y8kkRj37GFl6P5cOrmZUNkTL2anf97KW3Bg=;
        b=dHmW0GZfan0aqomPRrdbya9DdkIIPIQl/CZnndD0ejHtDL9wF9Mxhy2ah68ElXh8f+
         VRDHI4klrdzMyKh1BZ+8fRB1BUHJ/RRTWpPnpfrF16s4gdaK17gF032G9ecPZuLqjW6A
         PCRDBbeD2+HV40xGhlVF3H95jwiccxFgxtCGWVvsssF0dFU8mrwGAcZvQaEydtM5U2yZ
         ljcxd0E7Ups4mZH1dUyKhCyIq/5a/VhoaIbfXdYTFttWjTQmhHFRak/kGd2uUAWPLuhB
         Vh66PKvHuKE+4yVRoPdx4foLux2Xkv7YQbqM3dz/mYutxrI+BPgXFM8vWo6SU3fN3Dlv
         YR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780006291; x=1780611091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+4lxPQ44Y8kkRj37GFl6P5cOrmZUNkTL2anf97KW3Bg=;
        b=TrSXzkiyWVqFTRbAuRdOdi6NB8OSclBsegbbz0GcAEcaMuqTtTYjx663Y1u1lvSakb
         3u1Sv/P+TfeRSUmk4al8U7QDzE4lEc0zn8JJU9IAju/loSSUaXw2f05ZRUuNGs+7Uxwd
         RT7hqLspHZzV1N57kHPKzLUnY3sUMIo/qXS4MvbZRx36b5I0kqazVwS9d0j2d2S8G3iW
         6MYpso1SIY1uw8Q2GR9R7aOZmh+b8TxWSK683edyXhd1kkkL1JkHSdIYJxzpBhWmBaXH
         7MeF5VksmHfrP2BT+nn1xR8NGtbSLRcldb4cIW7mi3O3eIYzBjm+aGEqVwaFgG0PZTVG
         8ERg==
X-Forwarded-Encrypted: i=1; AFNElJ+LuIUvthY9VcyHjmLuLoaPmfEbFMrqqEHtydTWsmOqgrrTjP1+4uqO4w5XLR1Y+ReDy81rvxqi+UwGD0F9@vger.kernel.org
X-Gm-Message-State: AOJu0YwOFD9RnVrgvEUwcmr2j30T2yxEhlF1q5HIsUn+OLj5DJqaFUd8
	n+0kCP76u5rjVp8ZpfaIEjvuB/Pq9by4TTV8FNtZ35XBmDODcG0VrMyHkcSD8oUD09TYs1f3HW8
	wyHkGTSCDvtS3sinbGf2XBpi1swMGP6g=
X-Gm-Gg: Acq92OGEXErbr4czRsO5O461vFXvsUl0vMhFqNYtgyWpz0/HypjHvRa67vrvviH8UrO
	Mmfm3LNjTT+nZI+IT3+bEBd2Sn0Jjrdr6xhLx4DDxjrbQw1Ta2Rhfod6PV6Qab4Va0yaH+8Dpsk
	sJmAjPJA8NCrtAdnLYigmLXxCjMITSKQqtFRtGP6uLC4/03RVRisRnAfmjN1hTe/qAnDJX53udP
	wRnMWmSZFlX8sD9s3so6Xqoa1Kzonw4Ns6ukJolYWQoQchw0N8FnyosrYJoXdeM4MqPw6Vfk4YQ
	xM28zwHexg7db9Sn
X-Received: by 2002:a5d:53d1:0:b0:45e:ef4a:8199 with SMTP id
 ffacd0b85a97d-45ef142b239mr162626f8f.22.1780006290541; Thu, 28 May 2026
 15:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com> <s4kv7qep3jlncs67q72xfhserpd66hpbwzkoppiddc5raufyjd@ksuvlfqcrbk2>
In-Reply-To: <s4kv7qep3jlncs67q72xfhserpd66hpbwzkoppiddc5raufyjd@ksuvlfqcrbk2>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 28 May 2026 15:11:18 -0700
X-Gm-Features: AVHnY4J9i-IsKz1LVWpcfAKopQuVr8rBpVqLk7xTOQelcmByKR9yM9o_ihP3Cqw
Message-ID: <CAJnrk1bG6ddP6-dgXpGBRGnCH49oTMPwkJmF--+gefmy+zBo-w@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 5:34=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 26-05-26 18:42:35, Joanne Koong wrote:
> > On Tue, May 12, 2026 at 1:56=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Fri, May 8, 2026 at 2:42=E2=80=AFAM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> > > >
> > > > On Mon, 27 Oct 2025 at 23:39, Joanne Koong <joannelkoong@gmail.com>=
 wrote:
> > > > > Miklos, could you share your thoughts on this? Are you in favor o=
f
> > > > > disabling default strictlimiting? Or do you prefer to have it kep=
t
> > > > > enabled by default, with some mount option or sysctl added for
> > > > > privileged servers to be able to disable strictlimiting + enable =
large
> > > > > folios if they use the writeback cache?
> > > >
> > > > So what I think we should do is implement some sort of slow writer
> > > > test, and see what happens with and without strictlimit.
> > > >
> > > > Tried to ask claude to do this for me, but not getting very far.
> > > >
> > > > So if I take this maintainership role seriously and not let myself
> > > > drown in the details, then the logical thing to do is to delegate ;=
)
> > > > Which is hard (for me at least) but I'll give it a try...
> > > >
> > > > Could you please check how things change if there's limited writeba=
ck
> > > > rate and we disable strictlimit?  And what happens if there are
> > > > several such instances running in parallel?
> > >
> > > I think for unprivileged fuse servers, strictlimting will always need
> > > to be enabled or else a malicious user can launch tons of unprivilege=
d
> > > servers and eat up the global dirty page budget / starve writeback fo=
r
> > > the rest of the system. Similarly for privileged servers, it could be
> > > unintentionally slow or buggy and eat up the dirty page budget. I'll
> > > read through the writeback throttling code to verify this and run som=
e
> > > local tests.
> >
> > I read through the writeback throttling code and re-read Jan's very
> > helpful comments from this thread last year [1]. So for unprivileged
> > servers, I think we definitely cannot remove strictlimiting. If the
> > fuse server is slow or unresponsive with writing back the pages, it
> > will take up too much of the global dirty budget which will degrade
> > write throughput for other filesystems (their throttling will be
> > computed against the global dirty page count, eg the freerunning check
> > in balance_dirty_pages() and the pos_ratio calculation "pos_ratio =3D
> > pos_ratio_polynom(setpoint, dtc->dirty, limit)" (dtc->dirty is the
> > global dirty page count)) and any fuse stuck dirty pages are
> > essentially unreclaimable. Without strictlimiting, there will be no
> > hard cap on how many dirty pages a misbehaving server can accumulate.
>
> Yes.
>
> > With strictlimiting on and large folios enabled, the problem is that
> > the large folio size can potentially dwarf the server's dirty budget,
> > which can lead to excessive throttling. When I ran my benchmarks last
> > year, I and independently Jingbo saw severe performance regressions
> > for buffered writes with large folios (eg 2 GB/s BW w/o, and 200 MB/s
> > BW w/) [2] but I think that might have been because the machines had
> > limited RAM, resulting in a very small dirty budget. Fuse sets the max
> > ratio of the bdi to 1% of the global dirty threshold, so running
> > through some napkin math:
> >
> > On a 64 GB machine:
> >   - DirtyThresh =3D 20% of 64 GB =3D 12.8 GB
> >   - BdiDirtyThresh =3D 12.8 GB / 100 =3D 128 MB
> >   - 128 MB / 2 MB folio =3D 64 dirty folios
> >
> > On a 32 GB machine:
> >   - BdiDirtyThresh =3D 64 MB
> >   - 32 dirty folios
> >
> > On an 8 GB machine:
> >   - BdiDirtyThresh =3D 16 MB
> >   - 8 dirty folios
> >
> > On a 8GB machine (with assuming vm.dirty_ratio=3D20% and
> > vm.dirty_background_ratio=3D10%), we get 12 MB of freerun, 4 MB of
> > proportional throttling, and then full throtttling starts at 16 MB.
> > With 2MB folios, the 4MB zone between freerun and f ull throttling
> > doesn't leave that much room for the balance_dirty_pages() logic to
> > adjust the dirtier's speed, which I think causes the writes to
> > oscillate between freerunning and then being fully (overly) throttled.
>
> Thanks for spelling this out. Even with 64 dirty folios effective limit I
> think the throttling code will be too unstable. In general I think we
> should aim at having at least ~512 (gut feeling estimate ;) folios in a
> dirty limit to have a decent wiggle room for the throttling algorithm.

Awesome, I'll do some benchmarking on this and gather some data.

>
> > I think this is also going to be a problem for cgroups with large
> > folios since they also, as I understand it, are constrained with a
> > limited / tight dirty budget. I ran some initial benchmarks with
> > cgroup memory constraints on NVMe and saw similar instability (a
> > single writer in a 8 GB cgroup had max write latencies of 6 seconds vs
> > 15 ms without the cgroup, with the balance_dirty_pages() throttling
> > oscillating rather than settling near the set point).
>
> Ok, so this is more folios (819) than my 512 gut feeling estimate :) What
> was the write throughput of the NVMe drive? The high drive throughput als=
o
> requires more dirty data to keep the drive saturated so that writeback
> throughput doesn't oscilate too much.

The write throughput of the NVMe drive I was using was around ~1.1
Gb/s (measured by running direct I/O). I think with the 1.6GB dirty
budget, the math for that ends up being that the device drains it in
~1.5 secs. The performance I was seeing with the initial cgroup
benchmarks was with 4k pages (no large folios enabled) on btrfs.

>
> > I think this problem gets untenable for random writes with large
> > folios, since dirtying just a few bytes will charge the whole folio
> > size to the dirty budget. I have a patchset from last year for adding
> > more granular dirty/writeback tracking [3], I'm going to pick this
> > series back up. I think it will be useful generically, not just for
> > fuse.
> >
> > For getting this to work on fuse servers with strictlimiting, I think
> > the next steps are to
> > a) as Jan had suggested in [1], come up with some heuristic to
> > constrain the max order supported for large folios for these fuse
> > servers if they're running with the writeback cache enabled
> > b) benchmark ^ and if there are still regressions, then we should
> > probably just turn large folios off for these servers
>
> Yes, as we briefly discussed at LSF, picking proper max folio order is
> useful not only for dirty throttling but also for memory reclaim in
> general in memory-constrained environments. Strictlimit is just one of th=
e
> cases where the limit is very small and so the problems with the memory
> overhead of larger folios become very apparent.
>
> So although we may decide for a FUSE specific heuristic setting the maxim=
um
> folio order, you properly point out memory limited memcgs will see simila=
r
> issues so I think a more general solution for selecting sensible max orde=
r
> would be better.

This sounds great. I'll run some more benchmarks to get more data and
then come up with a general solution and submit that as an rfc.

>
> > c) add the granular writeback/dirty accounting for large folios
>
> As Miklos pointed out and I think we've discussed that also last year sin=
ce
> the full folio is pinned in memory by a single dirty fs block (or whateve=
r
> is going to be your unit), finer grained accounting alone doesn't help yo=
u
> with the narrow limits. We'd also have to add logic to decide about
> splitting large folios.

If I'm inferring this right (and please let me know if I"m not), it
seems like it would be extremely useful to get the infrastructure
working better for splitting file-backed large folios. That seems like
the proper long-term solution if I'm understanding it correctly (eg
instead of capping the folio order statically across the board, larger
folios can be used until there's memory pressure that splits it or if
at write time we detect the dirty budget is tight, that will allow the
clean parts to be reclaimable and reduce memory pressure and
throttling)?

From what I see in __folio_split() in mm/huge_memory.c, it's not
currently possible to split dirty file-backed folios (eg
iomap_release_folio() will not release the folio if any part of it is
dirty), but I think we can get this working in the iomap layer for
supporting the per-folio dirty/uptodate state tracking for the split
folio instead of rejecting the release. Iomap already tracks which
subfolios are dirty vs not, so we have the information upfront as well
about how to split the dirty folio optimally. Do you think this would
be useful to get working?

Thanks,
Joanne
