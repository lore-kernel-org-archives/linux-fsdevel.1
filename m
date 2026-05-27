Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC71315D21
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846171; cv=pass; b=HHoFYzYJ/8gcQD78DEOF9HaDRCXW1KxUB1DPQwSRmF0RcHlS8kpRZIIZRiH1nFbIazOXfx7+U67l8lDR1XxxQF8WNkiMdDWlHp8yaX4RfRLoYVc6Dhq8u36adaPgBHxPrClHluDgm0mGxNvUU4dgE+fY7+ryRNK1LwEX4Sk2mB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846171; c=relaxed/simple;
	bh=3dDU0ovfNjE8Z0Ui/Fcwy6KzdmHMn4n3K608kNqE59c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIjYPcP/uc6y4Vu1fINtrqNHLUXwxfJRD+x0y29F16vhWlIENEIqiCW5TUF9oe93AfySfRtYdBAn33+9PCweeUoW2frd//MNyrZpycNie+xnoG2gSkYdijFuMJtm1P2X5N0gDpDuPfkuaoKNBMuGNXB6JnJR1wPJfBoeAHkRNbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e36whtdb; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e36whtdb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-449de065cb3so10963501f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 18:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779846168; cv=none;
        d=google.com; s=arc-20240605;
        b=jgamFxI+2I0H9HGxQdfCdQPqPGWhKIzspBh5EJCDsgSdldzWmcvczDmpdX4YCO5Eil
         gOnkmgDFk88Dsmlyamoqopxc3V0KJT/cR1evS4wawwUdAPfVfkyoJyfgBf+NS68LKXfu
         5HcrNF+6gFzPmq8R2fBp9wIN5Bh9ZFkW6We1IVpA6v4EyGZTifDSBnDvS4XkoO9ni7Cc
         594oRWQSmqun/CsnmW3pjZRlW9/P7AreOhpWjCak1GILZCWt+FtZPh4gSVuqgG4yFk47
         6YIO7H7v7U39mq1AAwlndKGBWbHsRHlEgHhXXIl6QjVbOMDxNni7PQa4elidIGAA7eb1
         Sc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yiTKTKgoPDZ1BR8UlSt0W66yk+nGv8FOARy53b7PmkU=;
        fh=DjSRsVzZGroN6nYbZuyaspgU3HQo6RiA0Z27aOL1BKw=;
        b=COpMFEq9ZRNMfiu5ro/7N95Fg8NEFDqyYi0gT79olzEL5+MlkDBscl3D+MuYSRwY7R
         oVQYTYlEdRaneZbqDytALoRLZAVOYbndzP9AG2PdwQ94lXUY1KvBnyrJP48NfqYhOvHQ
         DmNrmErjbpeGNxmW6p9uo5o1dMI9B92UsgqwhfrfA/XIqqYjb3nUw5S5/nK2BJpkYPXT
         8kXCY/fuNa+VQ3pJyHbfHjwSY+d/4XZh3Piuc6iEgIZgRS9VriVwySJsIBU1IoJifM73
         JFvKxGP+aJerBrS4biAn3XKMc019xYTm0nVfAcVCPYbngIP9vTRDLbGSB/p2WHTeGx6n
         A3Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846168; x=1780450968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiTKTKgoPDZ1BR8UlSt0W66yk+nGv8FOARy53b7PmkU=;
        b=e36whtdbseyKK8TgxwWoqgR37NMHDi29ZO5n71m4xmDBx7c0ekxpW3nkKkWy7qLN4t
         etwriZsx7dvlJ1er32MApW3qHE4sHt3+RQICxzY0ZJUNaSbLt7dqf0ztl+DVoX76oRKZ
         VelJuzwuHn8FmYeGmGDI6qhcRt1NDxjINilEzQs3cZ/q41lGuExRZxnKMfU2f2b4WRSd
         Woxmn7jX0VkDcWfI++rnbOytpcvmRALy7HZK4kC05vkcUyIuwLzWXbrdpDNbcVnkRPYH
         p0nA/BWJTTUBhn2dlIiUxW/hkjFSxFB3lkmV6YWnbyc5FK1GDGFL4D1C480ls+DjLoZK
         YEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846168; x=1780450968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yiTKTKgoPDZ1BR8UlSt0W66yk+nGv8FOARy53b7PmkU=;
        b=TxShG2dxHJXpcf0Amm1OPsO/bDJmpevLB6BtyCEfzGO+v7a7i2P/7pooquOnUoeXyM
         BZxFN/kGBkRUSDfJLt0Tyz8VmT6HWf9MDvxd//fDKTJQ1sXUgZIL+g4tZ9opoZWMCVHT
         fjeD1V7b8SuIg0fQkB6rmwHQ/WQEaVZH4pdjac2Zcy7CQuZs+D6jJgp86ke3oV/1D1wC
         VL1FDJpeETdrXgKzMe/Evy7ApySd9P/ptGF73BstOMyjXeXsBVzThIDTN0zvkKjdhniO
         /SMmUcWAqroVxlZBU22m4wh+1bRkHtES4YnKCeDE9JKh2sK5OjIXnmETW3Yx44lEvA3L
         g/CA==
X-Gm-Message-State: AOJu0YyJI3sZST95WaRA5nSIBcMKezoHEGsddoNLe3dzioYUX9O6BqS7
	ajqPbd1zs9/d1gSGtTSszQNEVgZOade+bp9UbB7gC0tRJJZ6s1ZMqGk6kS0Ahhk/R/CtSOVseii
	5Bq2V9H3719nG0y7MVtCgTH8Tt6Rp9m8=
X-Gm-Gg: Acq92OEa/eq8lSKz5R3EiN15HCcQbpbl3L3CYbKn6cCuv4MqWrmUU/I4mH2mBfDRBJL
	hsVd3CU1mAfGi6V84T1JiWjnSUr3t8kK1BLNKgBB4Vw2YV7+STeNjbCugBAWOrYUTH9peOS+126
	lg827Z1WVgbAvCoAy2HFhO3Q6f+GbsVJZdwlhcKrP25mEhBenJEetHaUQgQ4SBYONUX7TlzU0hJ
	6YNz5dMhgU7nlAaD1jT6g4v4pGhFjfKXswFCzRpeK2dQceGv+1RJrnum/m93ncQnpWeLYfszFD4
	+6JO/ObexgUcXcbyNj5XPxPMbZxr1+6JJw==
X-Received: by 2002:a05:6000:2411:b0:441:1e8e:d8fd with SMTP id
 ffacd0b85a97d-45eb389fd78mr36980281f8f.29.1779846168064; Tue, 26 May 2026
 18:42:48 -0700 (PDT)
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
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com> <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
In-Reply-To: <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 26 May 2026 18:42:35 -0700
X-Gm-Features: AVHnY4LDC1uj9DPMsbn9uvlPbEP3o78k-rS2ZplLroRxu5-_KduxQfvjyJpX7jk
Message-ID: <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jan Kara <jack@suse.cz>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 1:56=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Fri, May 8, 2026 at 2:42=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Mon, 27 Oct 2025 at 23:39, Joanne Koong <joannelkoong@gmail.com> wro=
te:
> > > Miklos, could you share your thoughts on this? Are you in favor of
> > > disabling default strictlimiting? Or do you prefer to have it kept
> > > enabled by default, with some mount option or sysctl added for
> > > privileged servers to be able to disable strictlimiting + enable larg=
e
> > > folios if they use the writeback cache?
> >
> > So what I think we should do is implement some sort of slow writer
> > test, and see what happens with and without strictlimit.
> >
> > Tried to ask claude to do this for me, but not getting very far.
> >
> > So if I take this maintainership role seriously and not let myself
> > drown in the details, then the logical thing to do is to delegate ;)
> > Which is hard (for me at least) but I'll give it a try...
> >
> > Could you please check how things change if there's limited writeback
> > rate and we disable strictlimit?  And what happens if there are
> > several such instances running in parallel?
>
> I think for unprivileged fuse servers, strictlimting will always need
> to be enabled or else a malicious user can launch tons of unprivileged
> servers and eat up the global dirty page budget / starve writeback for
> the rest of the system. Similarly for privileged servers, it could be
> unintentionally slow or buggy and eat up the dirty page budget. I'll
> read through the writeback throttling code to verify this and run some
> local tests.

I read through the writeback throttling code and re-read Jan's very
helpful comments from this thread last year [1]. So for unprivileged
servers, I think we definitely cannot remove strictlimiting. If the
fuse server is slow or unresponsive with writing back the pages, it
will take up too much of the global dirty budget which will degrade
write throughput for other filesystems (their throttling will be
computed against the global dirty page count, eg the freerunning check
in balance_dirty_pages() and the pos_ratio calculation "pos_ratio =3D
pos_ratio_polynom(setpoint, dtc->dirty, limit)" (dtc->dirty is the
global dirty page count)) and any fuse stuck dirty pages are
essentially unreclaimable. Without strictlimiting, there will be no
hard cap on how many dirty pages a misbehaving server can accumulate.

With strictlimiting on and large folios enabled, the problem is that
the large folio size can potentially dwarf the server's dirty budget,
which can lead to excessive throttling. When I ran my benchmarks last
year, I and independently Jingbo saw severe performance regressions
for buffered writes with large folios (eg 2 GB/s BW w/o, and 200 MB/s
BW w/) [2] but I think that might have been because the machines had
limited RAM, resulting in a very small dirty budget. Fuse sets the max
ratio of the bdi to 1% of the global dirty threshold, so running
through some napkin math:

On a 64 GB machine:
  - DirtyThresh =3D 20% of 64 GB =3D 12.8 GB
  - BdiDirtyThresh =3D 12.8 GB / 100 =3D 128 MB
  - 128 MB / 2 MB folio =3D 64 dirty folios

On a 32 GB machine:
  - BdiDirtyThresh =3D 64 MB
  - 32 dirty folios

On an 8 GB machine:
  - BdiDirtyThresh =3D 16 MB
  - 8 dirty folios

On a 8GB machine (with assuming vm.dirty_ratio=3D20% and
vm.dirty_background_ratio=3D10%), we get 12 MB of freerun, 4 MB of
proportional throttling, and then full throtttling starts at 16 MB.
With 2MB folios, the 4MB zone between freerun and f ull throttling
doesn't leave that much room for the balance_dirty_pages() logic to
adjust the dirtier's speed, which I think causes the writes to
oscillate between freerunning and then being fully (overly) throttled.

I think this is also going to be a problem for cgroups with large
folios since they also, as I understand it, are constrained with a
limited / tight dirty budget. I ran some initial benchmarks with
cgroup memory constraints on NVMe and saw similar instability (a
single writer in a 8 GB cgroup had max write latencies of 6 seconds vs
15 ms without the cgroup, with the balance_dirty_pages() throttling
oscillating rather than settling near the set point).

I think this problem gets untenable for random writes with large
folios, since dirtying just a few bytes will charge the whole folio
size to the dirty budget. I have a patchset from last year for adding
more granular dirty/writeback tracking [3], I'm going to pick this
series back up. I think it will be useful generically, not just for
fuse.

For getting this to work on fuse servers with strictlimiting, I think
the next steps are to
a) as Jan had suggested in [1], come up with some heuristic to
constrain the max order supported for large folios for these fuse
servers if they're running with the writeback cache enabled
b) benchmark ^ and if there are still regressions, then we should
probably just turn large folios off for these servers
c) add the granular writeback/dirty accounting for large folios
d) look into improving the balance_dirty_pages() throttling logic to
handle narrow gaps between the freerun and full throttling zones
better and reduce over-throttling

Does this sound like a reasonable way forward?

For privileged servers, I still think it makes sense to remove the
strictlimiting requirement or at the least, let admins opt out of that
if they are confident their server is well-behaved.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/tglgxjxcs3wpm4msgxlvzk3hebzcguhuu=
752hs3eefku6wj4zv@2ixuho7rxbah/
[2] https://lore.kernel.org/linux-fsdevel/f9b63a41-ced7-4176-8f40-6cba8fce7=
a4c@linux.alibaba.com/
[3] https://lore.kernel.org/linux-fsdevel/20250829233942.3607248-1-joannelk=
oong@gmail.com/

>
> I think the question is whether we want to let admins opt out of
> strictlimit when they're confident their server is well-behaved eg
> through a sysctl an admin can set to disable strictlimiting for all
> servers. Otherwise, large folios will always have to be off for any
> server that runs with writeback caching.
>
> Thanks,
> Joanne
> >
> > Thanks,
> > Miklos
