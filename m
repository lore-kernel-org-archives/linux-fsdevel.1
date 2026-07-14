Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6684280035
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991625; cv=pass; b=NMPlt1Mt7qIFUTcaBX/3IxQWFb4w3Wq57+0asDhlpFzyPScD+g1fglQbHxe7G3IYobj0Cbn/ifTtyTlwGuDlL9n/qc9V6ELQmlzN+L6lsaYO1aa2W54MSmKRQ9aqFUKM48SXW4CgUjXbRo1CfFlaF0vUrTWR5T4PazfClDDb38E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991625; c=relaxed/simple;
	bh=eRS3r3eqwvpl/2inXyOi1m/776FfLO1zFPPdxEGYq2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yv6pLaERSwSeqD5HiCKXrD1EkRDclKoey8/eEQDYp8/sYMQCayLSskV80tMgK5Ulc6gRkjAYRkYDzKIeFqIRbtuLYgAj1jHTZR7ealx/e79Hh/w8BPK4mnrtEy3Nh73olG9epzL0ultnpThV3PkdOgDMuwBcqosDKk9+G9JCQ8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjFjwhFR; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjFjwhFR"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso2295552f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 18:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783991622; cv=none;
        d=google.com; s=arc-20260327;
        b=SrKATFNx91WZRaTVAYNyJ8JUY2kGUbAbJsI5byr/QBffhIWh3UKRD9gD99JpQL4t7l
         lNb2bBlsEfYOlzTGIKMreRpDqN0vDkcJ8XwtU0zlSLJo1jOPDp1bvqGVwDkM/15HkmQ7
         TxDYPgoIlKtgfkqYLpKI32jelkhT41dJhySl9Fbpm8YdV/krJDN89axI9YOB+0dvcv63
         gzmBOw4ArwoLQTGbLgFyeDaAlDgxTtjVehevN9oZ04hUHOUScTfkwVexlJ2H4qeRoHwX
         vgwbNdE/SHBWaBXGNtSv84nQfNoFXwDH0q6Mhj9XU+F9sbdIlHBuucQiQPgNjTGNZJ/t
         Ep4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9zvs/4Q9rFfF2Zxa+4Sity7+TLXzEBtCkYAA95hYUo=;
        fh=XpDyPj5RwPqoWeq44zmAhKt8dZxKGgH/TGmSYSUpk80=;
        b=cFltZ90x4gSCskxrPYokAcGpeILQ9XhTA+HnGkxXdCCYccyi7UgdbRMQLmj8eTsXWK
         WRZMJdZiDzhwzTLvYLn8R/yrs9+14mC3wiRc5loKwNEyd7cRmnwXOb01+S8EsFjPpIwX
         WRNo45xx/KEPP2fTEPcAaiHrpHDmViILDNA/x/Rc1+mwkZ0b9CBvRK6EDRcBPeivdmyX
         RSPyjKT4+BF2/8TN1Zjmgxaysg1jktgMC9yEYhoZtP90EJlbN1TKSfN42IuqhWdBG/x2
         rDoOILE2mV9HFg0joPNnjIIC6tqvFHJzcvceqrIl3b37K2ozuFkqqGedy5Yv7H46mY4+
         dAUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783991622; x=1784596422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9zvs/4Q9rFfF2Zxa+4Sity7+TLXzEBtCkYAA95hYUo=;
        b=hjFjwhFRV1usskYV9uzsSIsPn/2a3KSgfucYPNS4o411w4TJE7/DKj/kDYfdBoNOMa
         sK6vkAfOdlthyGR8VilZzo9Cbafd22QhMa9qZzvF2UN/ltc8gt/g/BP5yVSd7UDRUNaf
         0kbSD+PT175rzilnxF4sWZo5vF1eOGmRjchCNo403kon68HPTEXdy95P3+yYRU+TgBzF
         D6r36+XngxXmNtYGx/z8eIwIW1c6E+JgUyIpuRz+nfrh/pgcp67ar00iJrpKOUFYjece
         PlXh1W8+UuG28MgjAra0qsEUHuIlH8SLzlbK6ra4VNmznd6PzEUzJIBDnLAxzxMtYRXW
         MoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783991622; x=1784596422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9zvs/4Q9rFfF2Zxa+4Sity7+TLXzEBtCkYAA95hYUo=;
        b=H4mgwCRl0+eHVhqYEwCW/QkYf91LEZ5cL7uEBnBtiBnBISo6a2RKzg9D6v+NCkkx5B
         J/KLbGwJfUlAR+6uHlknQ1HpV8HoWFZT1kRKDJvPGc/OceLZ33JtdwwRxbYxElIZrdj5
         hjcdstOkdyEvMKQ0jB2r7SLB8Ff8c0VuGJtQQjHWSa1lezwAAyK+jNyiK5C5PwqvUgVO
         LNEIeR33yipstPLvHmbdMyQ3NAbCfU9Y3y86Kk5p7Y8S+qB1IlN1e9CKwg2Hp0NjHwlD
         pr18+SKreDaRRQDLZq4GDiQPU6miUeFdLuCivZ0JdS+L6GzoV7Q7ywH/NHMEekoFviVp
         gZSg==
X-Forwarded-Encrypted: i=1; AHgh+RrtDUqUiZw+C5KWRb0DtqqC7cVYkfgLZHatMYY9+YOKkzyi0dbVX3Wj10ogkcmGhkCUDaOnwSAR4qIpjjky@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8V+oGGv200ZoYNFZD89jEOjeXXYfK11xgPYLRShONChoXGix
	CwKKy0rQHKyKGPhfOepNQc3/q7w5uXdTAwuDlSsyJRdh7SaGAhvV7GfVnTuXcUgdtozvXeoIsqJ
	jSR8v4/75asai2Xj93a4Y+LzOATdAz4U=
X-Gm-Gg: AfdE7ckOT0ntxrGSE0BrXXGNuorW/Qm4Y8rhv3AH3b1Z84RPNdoqsvxfOixl1kymB+1
	Goz0p6fXAAfk8MQTyAyIZVfkUeBwci+gIF1vvJqXsbxGCA4GqU9MyIQcftHpEv5P0yo3Fij41iu
	yFz3KTKxBgeeqG02MtQx+9mTVp1BBPOcDuvDgdhQR0PVXl0pAl5knH2i7hu/3Y7SBRNeedVhfbH
	cWdifRjyfweGrC4+DRw3a3gr753oRgUl5TUneGa+C+nfQuyoZ+X74i8K8yfoMqEvHLR8OtoIbsO
	N6K5FE1Z+Z9L7CZQ+/lbdA5teWrznuAh9H0qNahbEoPCAvI7CL6k03gtJPPqYOaS3vi0Ww==
X-Received: by 2002:a05:6000:2906:b0:477:6da:1b8f with SMTP id
 ffacd0b85a97d-47f488b2454mr382374f8f.34.1783991622051; Mon, 13 Jul 2026
 18:13:42 -0700 (PDT)
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
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
 <s4kv7qep3jlncs67q72xfhserpd66hpbwzkoppiddc5raufyjd@ksuvlfqcrbk2>
 <CAJnrk1bG6ddP6-dgXpGBRGnCH49oTMPwkJmF--+gefmy+zBo-w@mail.gmail.com> <oocwnxqgd4klrem6hkya3sddqoxkosml4ysz23if4j7wj2qdwi@5skgc4ftu7io>
In-Reply-To: <oocwnxqgd4klrem6hkya3sddqoxkosml4ysz23if4j7wj2qdwi@5skgc4ftu7io>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Jul 2026 18:13:29 -0700
X-Gm-Features: AUfX_mxGYLyqGVRnxuiEgq-1unfq_iO1Y9aI3_BjCE6WoNVbw-1i77CB6bGHJSY
Message-ID: <CAJnrk1ZU40tRDq0z3yM0+yv=KhiZ-fNjUTO=ccv1tuc0xDx2Vg@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 4:04=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 28-05-26 15:11:18, Joanne Koong wrote:
> > On Thu, May 28, 2026 at 5:34=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > > I think this is also going to be a problem for cgroups with large
> > > > folios since they also, as I understand it, are constrained with a
> > > > limited / tight dirty budget. I ran some initial benchmarks with
> > > > cgroup memory constraints on NVMe and saw similar instability (a
> > > > single writer in a 8 GB cgroup had max write latencies of 6 seconds=
 vs
> > > > 15 ms without the cgroup, with the balance_dirty_pages() throttling
> > > > oscillating rather than settling near the set point).
> > >
> > > Ok, so this is more folios (819) than my 512 gut feeling estimate :) =
What
> > > was the write throughput of the NVMe drive? The high drive throughput=
 also
> > > requires more dirty data to keep the drive saturated so that writebac=
k
> > > throughput doesn't oscilate too much.
> >
> > The write throughput of the NVMe drive I was using was around ~1.1
> > Gb/s (measured by running direct I/O). I think with the 1.6GB dirty
> > budget, the math for that ends up being that the device drains it in
> > ~1.5 secs. The performance I was seeing with the initial cgroup
> > benchmarks was with 4k pages (no large folios enabled) on btrfs.
>
> OK, you might want to experiment with some other filesystem (I suggest xf=
s
> or ext4) as well. Btrfs writeback behavior is a bit special with its data
> checksum computations etc. and thus latency of starting writeback. It cou=
ld
> contribute to the erratic behavior with the relatively low dirty limits.

I reran the benchmarks on xfs and ext4 and saw similiar results. The
max write latency under the memcg were
xfs        5.1s
ext4      5.2 s
btrfs      6.2 s

compared to the non-memcg case (0.4 to 2.0 ms). This didn't affect
throughput though, just the tail latency. When I ran xfs with large
folios disabled, I still saw ~4.1s.

From the balance_dirty_pages() ftrace tracepoints, the dirty_ratelimit
value is consistently stable / accurate but it looks like what's
happening is that during freerun, the writer essentially dirties at
memcpy speed until the freerun ceiling, and then the soft/proportional
throttling kicks in but doesn't kick in fast or hard enough, which
allows the number of dirty pages to exceed the hard limit by ~2x, and
then at that point the writer is forced into the loop where it sleeps
max_pause (200ms) each iteration until writeback has drained the
number of dirty pages back under the limit.

If we wanted to fix this, it seems like we could for
memory-constrained memcgs either start soft/proportional throttling
earlier or make it throttle more aggressively as dirty approaches the
limit, or start writeback sooner so it finishes draining the dirty
pages faster. When I experimented with lowering
dirty_background_ratio, the worst-case latency dropped around 2-3x
(~6s to 2s) but there was still multi-second tail latencies. Maybe
this indicates more that the throttling needs to happen earlier/harder
than that writeback needs to happen earlier.

I'm not sure how much this matters in practice though, given that no
one has complained about it.

Ironically, for fuse there is not this problem because with
strictlimiting, it makes the dirty budget so small that even with
exceeding the hard limit by ~2x, there's not that many bytes to write
back so there's not that much latency waiting for it to finish, and
strictlimiting also inherently starts the soft/proportional throttling
more early/aggressively, which prevents too much overrun exceeding the
limit.

Thanks,
Joanne
