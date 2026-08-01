Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E43392C27
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785613287; cv=pass; b=TjROm/UuX6w774rLOVd/ovcSvf+Zb/Rzn9oSGQScBA20OI5+hzkl5TpVi0IqnTxJaIpJt72fpeAibdFDatEyKOu32ZfzFoV41emkhH4nAoL0RWZz5BWdU17RwUhfT/rg3/Lyj8P39hYX/IZVK5NkJ3/G+6x6wCd0T8mbodqLfj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785613287; c=relaxed/simple;
	bh=LNXGAw6Tz5+TiEf6Gi38jYu8BqJmNJm2XXZgBq9ghCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esy8UCfrvS1oyz3WP06EnkyFJR9JjtvX8/LqbxG9MT5sKLklxwoxTehIocr1/50360Afbt3Iqeb1Bv5vYvItXWBix2lOlKgIdoiUcEW1mrfEQ67VM1NEk80ohRQgPeKo+FTDwEqyTiYvee+q2tfUS2XkIVLzbtvg4khrLC3+hYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3efuV5S; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3efuV5S"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so3348021a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 12:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785613283; cv=none;
        d=google.com; s=arc-20260327;
        b=ZoPb+m0o4t1HPfF++bYfV2+chWeJuk8T0RLeu/2sEZJNd01upQ9+wC0wYiddOQXhap
         b6C2+gXVRtFDq1nBKR7ArXHf4E02vAefoNcsubruu4jPhVIFmL2SaekxpD+9Zx34yQZf
         h3v6QNkSc8tQUQ7DSl/WpAJnFWnae8pa73/shalRG5RNrO7JEZJ5AxkEQMUlvhfqgRTd
         4Q4IZcFTFQsDx4CUhdg4Cgw3cimS6d/WTeRu0O8os7PHg9RmfRT8hA6w62lal2RSxau7
         tlzSflGSMogE0894QEQwmHZFR+TeM8i3cSAGZWCPjGZP5+xqSjAxh50iY0RIOKIDNC/q
         RE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jtnMDCYtuZDOB8PvPIKFhiVJNyKCM9rWJUcJ2niqMHY=;
        fh=pSIv9XNf2FVF+JuLFAAgwi3KLWNYkVmP2Q0DdkZjnuQ=;
        b=TQCOEbZEj91bPkt4VkQUZ1FNiBBShYpuuKJ96NdudKh+El9kccC1ug1aALnPwiNihE
         nm+0g+/DD/Di9fU6C3MSGbh1Ox4mmeICXgy3qykkcrLk7mw8fq86XVF5cY2m2UQ6px95
         25AM5jvFwEOHbIUEl5XrIwHhWRT1+GH5P3JAUsrGSxJKfTGk62Tnc+j9iy15irtydzoz
         kacRY19XBqZZP91eKGyEnscYgypwzz2sTaX8lXcVUxEY2INoq/W9rkxQwozb4+HGGvoa
         DuZCOkWPxt1qu3BEyDnc3SAnKZ22cwjBc4RuCQZj/wxcCN0UGtAOmNpF/ya4rUMsFoIC
         plYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785613283; x=1786218083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jtnMDCYtuZDOB8PvPIKFhiVJNyKCM9rWJUcJ2niqMHY=;
        b=m3efuV5SVh6n5r/7LNgYWsKccoMiZTSG0a90psFRAuU9nT8gHHxQfA/mxbJ4uF9aTI
         BpnhCrbF4U17DNilL/s4hjsPLzJmQ7n7xwu/j9BqKd+aueZRLyCBiIUX9Tvc6Cof86OK
         rXaibLXpaEuceCMjb3v7yV/9/dkFs5LEH9mSl0ljkCHyz1B+MmVsTqeQfqW1Y6s1UHpT
         dZ62H1urm/TSNQcfIRtr8A8UYfHcI+z7M+vXVJwMXw7RWe6ey29KlDW0EnHHsi+dCYfZ
         Jk0g1hR7WEI0l6mdSyDxTDS7JJtEfhWd/9RYBuRp92Yz2iMPoKAsOPcTYzFKfUAW7XuG
         N87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785613283; x=1786218083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtnMDCYtuZDOB8PvPIKFhiVJNyKCM9rWJUcJ2niqMHY=;
        b=aPfzRetcCta4zhODV3LG8k+O1PJSVmZyJuus+F45LHmjDC8v4IgJWGlzH3mNMLHyF9
         26o+I+IKzOqqYBO9bYVPgKiVN8q8Xzcs30NASQ6v34wG4QMwybkk5za8NXnTOxhu+E5P
         wAb2y22Y5GPWqIADRx2xqrIGbJ49jyOGy28SfRCb9KMvNjNjcIqqoa7rf78CkMN5RhI7
         bKNEAF3gV3qJ8CS7J93nNPN0weibc4iz5BQKIGD04q+9upzxYVYFNtGLuJdb9dlWl04U
         ChRGqyJavmBQ5By0J+H+X8mDH7WlmShlc+DhzgOedsu6U9+xQqXwQQb2t5In0QIUT/jJ
         qsyQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXKGY6HWXWvTHfsBDv1sHaDqLT0CD3WiVvmJyx6CaLc2XNutjwZUGxjFLLiY9tErfsz6f6QdrNwl/UwUeL@vger.kernel.org
X-Gm-Message-State: AOJu0YxL6ai2mrIDO86V5WQ1JjjF9C+2CsRoGlUiDXwhbISWMV3HwRra
	R9z1EM1uCC+mx0tkXpTdY9uTJPeFuBbUu6rIDoUCXcO+3zuWWmD18Gagw1PtZsBsvlh/uCLbwVg
	dnxlVH3q9hELc1yzQkcTvj4VAbqvfies=
X-Gm-Gg: AR+sD12wU1dlaZxm+X8LNTwzjlPnMwuGFGjWiIC9IT1kmwbVUTikOG4xMi5DzAjD2gT
	uHPpnaKGBSxjBLmbkBSl98i654yMNS60cHi6i6R98L85bBf3y2RLkm7spfCPFqktVD6geefaI+6
	hGO50by692v6LMXwdKIvwbS0j7qEBbFnwWf7acrrsT8ZIiFHzCJQpsg+ctWk0nFnLAy91+0EDok
	lBus5kRgFapTVGvsacNwdgtVSRmVJHMnACbvthUJUU4FF3xN8TBpHKT9hZPZe4VMDKV9UrxhVJC
	PHlrnehiKsUsBvTcKcX+li2XrPaShgsi/UK4ZxdnG3v8Vw==
X-Received: by 2002:a05:6402:4541:b0:698:ad7f:9383 with SMTP id
 4fb4d7f45d1cf-6a0a7ca26camr2513308a12.14.1785613283186; Sat, 01 Aug 2026
 12:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616231325.16788-1-russ.fellows@gmail.com> <20260726015955.319132-1-russ.fellows@gmail.com>
In-Reply-To: <20260726015955.319132-1-russ.fellows@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 1 Aug 2026 21:41:11 +0200
X-Gm-Features: AUfX_mzQD4_GlZXDQI6JfCQpKnGigqG8DsmxHVr6ulogZ1XWG4BG2zyaNWasR7Y
Message-ID: <CAOQ4uxhHx5kHT0PfyZ+yb1Y2s0LS6ph-jQ3n66w9Zw13v-5L9Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: allow parallel direct writes for passthrough
To: Russ Fellows <russ.fellows@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 3:59=E2=80=AFAM Russ Fellows <russ.fellows@gmail.co=
m> wrote:
>
> This is v4, about six weeks after v3 [1] -- apologies for the delay.
> Thanks to Amir Goldstein for the detailed review of v3 and for the
> suggested patches; this revision implements that feedback.  The v3
> thread [1] has the full context and Amir's comments.
>
> The series is also available at:
>   https://github.com/russfellows/linux-fuse-passthrough-patches
>
> FUSE passthrough writes are fully serialised on the inode lock, even when
> the server advertises FOPEN_PARALLEL_DIRECT_WRITES and the write is a
> direct, non-append, within-EOF overwrite.  Native FUSE direct-IO writes
> already take a shared lock in that case; there is no reason passthrough
> cannot do the same.  With a passthrough backing file on XFS, this is the
> difference between serialised and fully parallel 4K random-write O_DIRECT
> throughput.
>
> Patch 1 stops fuse_file_io_open() from stripping
> FOPEN_PARALLEL_DIRECT_WRITES on passthrough opens (which bypass the page
> cache without FOPEN_DIRECT_IO).  Patch 2 lets fuse_passthrough_write_iter=
()
> take the shared lock for eligible writes by sharing the existing direct-I=
O
> write-lock helper rather than duplicating it.
>
> Rebased onto v6.18.39 (LTS).

Hi Russ,

This version looks good and very well tested.
Please add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
to both patches.

The only thing is that your patches need to apply to the current
upstream master branch
not to an LTS kernel.

Kernel patches always need to be merged upstream and only then
backported to LTS kernels.

The merge conflicts with master are minor, but please rebase and test on ma=
ster.
With that done, I hope that Miklos will be able to include v5 in 7.3 PR aft=
er he
gets back from vacation.

Thanks,
Amir.

>
> Changes since v3:
>  - Patch 1: keep only the FOPEN_IOMODE_CACHED() helper (drop the
>    IS_DIRECT / IS_PASSTHROUGH macros, which described how I/O is performe=
d
>    rather than the ff->iomode state and were misleading); fold the
>    O_DIRECT/fcntl note into the FOPEN_PARALLEL_DIRECT_WRITES comment; and
>    simplify fuse_file_io_open() so a pure direct-IO open needs no early
>    return.  (Per Amir's review and suggested diff.)
>  - Patch 2: instead of duplicating fuse_dio_lock() into passthrough.c,
>    generalise it: fuse_io_wr_exclusive_lock() now also handles passthroug=
h,
>    the uncached-io refcount is factored into fuse_parallel_dio_start/end(=
)
>    (no-ops for passthrough's permanent uncached iomode), and
>    fuse_dio_lock()/fuse_dio_unlock() are renamed fuse_io_wr_lock()/
>    fuse_io_wr_unlock() and shared by both write paths.  (Per Amir's revie=
w
>    and suggested diff.)
>
> Testing (fstests / xfstests)
> ----------------------------
> Run with the libfuse passthrough_hp server under xfstests (FSTYP=3Dfuse),
> './check -fuse -g quick' (642 tests), on v6.18.39, backing XFS on a
> RAM-backed null_blk device.  An unpatched v6.18.39 baseline was captured
> first, then the same tree with this series applied; results were diffed t=
o
> isolate any patch-induced change.  Two server configs were exercised, as
> suggested by Amir:
>
>   passthrough (default):    unpatched 25 failed / patched 25 failed
>   passthrough --direct-io:  unpatched 27 failed / patched 27 failed
>
> In both configs the failing set is identical with and without the series
> (the --direct-io set is the default set plus generic/355 and generic/362)=
.
> Every failure is pre-existing on the unpatched kernel and is a known
> passthrough_hp / fuse limitation (permission/ACL/atime/mmap-coherency
> tests), unrelated to this change:
>
>   =3D> zero regressions introduced by the series in either config.
>
> No kernel warnings, lockdep reports, or splats were observed in any run.
>
> Performance
> -----------
> Custom FUSE passthrough daemon advertising FOPEN_PASSTHROUGH |
> FOPEN_PARALLEL_DIRECT_WRITES, XFS on a RAM-backed null_blk device, kernel
> v6.18.39.  fio 4K random write, O_DIRECT, libaio, iodepth=3D64, single sh=
ared
> file:
>
>   numjobs | unpatched (IOPS) | patched (IOPS)
>   --------|------------------|---------------
>         1 |         352,000  |       352,000
>         2 |         440,000  |       648,000
>         3 |         429,000  |       951,000
>         4 |         423,000  |       987,000
>
> Unpatched write throughput is flat regardless of job count (the exclusive
> inode lock serialises all writers to the file); with the series it scales
> with concurrency, ~2.3x at 4 jobs, up to the backing device ceiling.
> Single-job is unchanged (no lock contention), and 4K random *read*
> throughput is unchanged (~1.37M IOPS with and without the series), since
> reads never took the exclusive lock.
>
> [1] v3: https://lore.kernel.org/all/20260616231325.16788-1-russ.fellows@g=
mail.com/
>
> Russ Fellows (2):
>   fuse: preserve FOPEN_PARALLEL_DIRECT_WRITES for passthrough opens
>   fuse: allow parallel direct writes in passthrough write_iter
>
>  fs/fuse/file.c        | 53 ++++++++++++++++++++++++++++++++++---------
>  fs/fuse/fuse_i.h      |  2 ++
>  fs/fuse/iomode.c      | 23 ++++++++++---------
>  fs/fuse/passthrough.c |  6 ++---
>  4 files changed, 59 insertions(+), 25 deletions(-)
>
> --
> 2.51.0
