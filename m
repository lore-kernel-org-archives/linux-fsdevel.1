Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593FC42A79B
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438176; cv=pass; b=U+A0wVjNzTnYWORlh4yPFex4hrD/SKqrrHwUkJ/kBg+fi1TGMgoY5I1IyPE2SRm8AZdwKCnUz4P4b/+XXTZSuKOQoE7LT4R8y1TkZ9IBMO6zhocbxLOJCQd/5+7AQW3fN+dTimpJCoIyx+0w/6gWWwmiAyxIwqT0CeVd/qOFCJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438176; c=relaxed/simple;
	bh=4PxN0Vx0f6YnPv7E4cWFI/XyxCcq8wGf+Tllgqg04WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkZdI9b1d17ZMsEgCcxtiyOCGnCgIIpBf2xBWAyIBb6IByqqq2Kb0F4+iCU4AQTZHiRcwNQUFliWIJ/IafXjYQb0kwJP9NffduqSxig7NmI4csQof3EXK+M8CBUpgM3nDwI2nlGQ2zndtAaH+tqoKjQbDH+HBh4Fm9z0yg+zRvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epaWVq3q; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epaWVq3q"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1214350188so459585266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 08:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783438173; cv=none;
        d=google.com; s=arc-20260327;
        b=r03cg/sHoFtUlg+Z1Xo1QQ+zFyeSPqjsGEEhvomoUn6FuL7ftGK8oxvGeboOs0ay/3
         z35k5/CFEPjsquGOvDvCA7SHIpFdevXPUPqnD6avR7aDM7B+t4D0TW0uo3YEGqIKWPi7
         TLv5K+e+/kRks1XyYvJyQ594ciVORuk8vXsLR2XD76ske9fNf6cbuaNLAAH9fb5d3gcx
         Lg8eIzrtin3PGQNA9hZwgEm8NZPEWoBjK6uQQk3NohBWZUXET4NGek/XkzLEfvd6IxGh
         GOWFQfkRUj2P/aA5bBImPuth1nfes6211dULOfUkR+Sb6G5le9RIqypy/6prHeQSswF9
         Eing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ABt5Z57bqbnfrxUchqpkU71FDrKsRntJ2o6KLy7ajEU=;
        fh=h/AI5mxbtIAp0tklkx3A77/l+gaJDU3vtgI4voyRY+8=;
        b=OVOwu/Yxaj5snDVr3M9OTN/biPcUrgVbld7NkthLeJXrG0LtVt7B2Yw/LyvPvdSFKX
         MbTi/1COl0LCX0YI3S9k6IaIe2kJONcOfzwNe9+WnKahbOmUGuZ993AgVJLZwCHySdrc
         xZkTyArPz4YmSFOf+9BpS4b5jxxq7FQ40zlxZSFaHXuCwrBeOK0bnlQXvgKLNLz6NIOa
         OuOs+fDs2op4cEK8A+fysABbI0/yzOXkX7Xr7UwL2kJOGMaj8XdRaXEDNJc90AfUiYpK
         MbMHl4CZfdSD6O4a0j2JNLE1y7376n0HUuwDWS+zGizp1MySYr7NaqgUSWLHzipAI2pL
         R+2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783438173; x=1784042973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ABt5Z57bqbnfrxUchqpkU71FDrKsRntJ2o6KLy7ajEU=;
        b=epaWVq3qUwnuzEIYg06kRC+Wp7WXizA0Ei5oUBtM6MB5ysjGDUsUtfR6oEG1xDAyFx
         r+oz/HKn55nF9sxcp7nOEjd6ITXCX0HUAjz2dUN3obrWZd/h6hfqb7gxlQ0VrgHME/Un
         iJERGjdoHFOCniGt+ctC7lMiMbJ2rQ4w96D3uS0m0y+PUZIcWXZybak66XOQTXMD8/42
         Tgch0tjZvRTGQZ9HzesK5xUoHd5O7ArfIdVXZx4M2+Lxdl44R/PiQfWT6yI87T/bNW6t
         EC8A4NGG/V6StFOdHCrItAEBQKGc6rUw7sbB0Jp7LmhKXbV7tXuWtKKO78nCS7DFXx7q
         Bp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438173; x=1784042973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ABt5Z57bqbnfrxUchqpkU71FDrKsRntJ2o6KLy7ajEU=;
        b=NB3dRbc4oatY+PciJgD8mtYbWM3iXupzezIfK8z157GPpT3OB3cHnh+Idw2vJKIpWH
         9mP8m0MeWzFI51oyWgllBlAEP3DiMC5nxE0c+2ice7WUsVud3G5ZmBV59IE5cvy25pLd
         YPGAK0UGiQUj/pEGnANKr8wNj9KBUa+bAuLaZNTRQW/gWZABtXpkGj1mZ9kRLSrLg5VS
         F7le/KxOsqVxBI9elatQzt1DjjVEGiH1kLIDt4kg64okUJezG23nEH8VrrCvvSWs/rQG
         XjooAs77nLoGhXgc0C+s+1SsgkGcCUrdFoZh0LkiunGN+8b+59ELxhgxMOOR7QSm+o/B
         cz2g==
X-Forwarded-Encrypted: i=1; AHgh+Rqt2iMkfDk0fQMAHvhGn8X3HSiN40P6YYBh+nufN538rx20IZZ5IEBwEGFpXPz2f0NRHDLPDVOHs23qCQKo@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhtR/38E017v+zUaPFij/cEABMJshgHdwx1as+TdBlz9HO9R/
	Q4ovv4NHFBC8Q6yR6ZetnwKK3tyquX8mmhIXxNgv+JlBSuNBnMKv+TeEp67EZc7CkzZ5jxsZ53t
	OuJxQ5dEiocZkNdCG1O4OO9wnLlcWP9M=
X-Gm-Gg: AfdE7cm4xQgfTy2I4ypQC/ofIbxg5EI6LzvV42Ez8PhZhH0ePlA6hEiK9ldAagPxbxf
	FQam/lmKPmKMGcLIqhiqXrW+57QUi2AvU5V+sXb9gpTgxSOOLvaQxY/9dCPVvdqyVoAwgogD8xn
	93yfKu0f4zMLRP+ibcZJ/bsocaNB5NqTErAK6tr0YkUFO+0/JH4AS1A++bhTSNwDq9JLgO+u27p
	bC++CGsIzz88XuIjqvibsauXilW49bnvX49UQ38WnhZM9SJE7OyJoWCIgxjojUtKZwtHEJsZfBF
	6oxjAtbaXqkY+m4TQBtU3eYufDLDpuDKWUberkg=
X-Received: by 2002:a17:906:6ac7:b0:c12:e178:9e84 with SMTP id
 a640c23a62f3a-c15a6825212mr230812466b.49.1783438172265; Tue, 07 Jul 2026
 08:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
In-Reply-To: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 7 Jul 2026 17:29:20 +0200
X-Gm-Features: AVVi8CfIruI-G4ZiEtBpfFstC4QYc8f1a6SJ0ayLzJMtJpTfsR6bSJsBI4XX4hY
Message-ID: <CAGudoHFGFJZ_j-osEKnLvGYGai+SKVAJKy8B_PChWms7SN7xoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, oleg@redhat.com, 
	josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org, axboe@kernel.dk, 
	shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 5:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> TL;DR: This simplifies the pipe code, unify the page pools, reduce the
> code by 9 lines (not counting comments), and no regressions are seen in
> terms of performance.
>

This adds an additional acquire + release cycle on the mutex for every
write which preallocates, so I don't see how that's supposed to *not*
slow things down in some capacity.

I have a trivial benchmark for pipe throughput, usable with
will-it-scale (e.g., plop into tests/pipen.c):

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <assert.h>

#define READ 0
#define WRITE 1

char *testcase_description =3D "pipe read/write";

int fd[2];

void testcase_prepare(unsigned long nr_tasks)
{
        if (nr_tasks < 2)
                err(1, "bad worker count");
        assert(pipe(fd) =3D=3D 0);
}


void testcase(unsigned long long *iterations, unsigned long nr)
{
        char buf[1024 * 128] __attribute__((aligned(64)));
        int ret;

    int size =3D atoi(getenv("PIPEN_SIZE"));

        if (nr =3D=3D 0) {
        for (;;) {
                        ret =3D write(fd[WRITE], buf, size);
            if (ret >=3D 0)
                           (*iterations) +=3D ret;
            else
                break;
        }
        } else {
                do {
                        ret =3D read(fd[READ], buf, size);
                } while (ret >=3D 0);
        }
        err(1, "bailing ret %d");
}

Then for example: PIPEN_SIZE=3D32678 ./pipen_processes -t 2

This gives one writer and one reader, both on separate CPUs.

With this size of write I'm seeing a 7% drop in throughput with the
patchset when benchmarking on Sapphire Rapids.

> Summary:
> =3D=3D=3D=3D=3D=3D=3D
>
> I've spent some time converging tmp_page[] and the on-stack
> anon_pipe_prealloc pool of pages into a single per-pipe pool, as
> discussed previously in a few places, most recently at:
>
> https://lore.kernel.org/all/ajLA_zxsYyKISkwp@redhat.com/
>
> Problem:
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> 1) We have two types of page caches in the pipe mechanism today
>    * tmp_page[]
>    * anon_pipe_prealloc
>
> 2) they operate in different ways:
>    * tmp_page[] is protected by the pipe lock
>     *  per-pipe, persistent, 2 pages
>    * anon_pipe_prealloc is an on-stack pool, not lock protected
>     *  burst, up to 8 pages
>
> Proposal/Design:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1) Keep the same page budget as today
>   a) up to two per-pipe persistent pages
>   b) burst of up to 8 pages
>
> 2) no pages are allocated unless necessary
>    * Pages are _ONLY_ allocated based on the length of the write,
>      minus the pages already available in the pool.
>    * No page is allocated but left unused
>
> 3) keep allocation and freeing outside of the lock
>    * only the assignment of pages stays lock-protected
>    * Currently, tmp_page[] pages are allocated in the lock, so
>      this patch will improve it (thus the performance numbers)
>
> How:
> =3D=3D=3D=3D
>
> 1) replace tmp_page[] with anon_pipe_prealloc in pipe_inode_info
> 2) at write (anon_pipe_write), allocate the pages outside the lock in a h=
elper
>    called anon_pipe_prefill()
>    a) the assignment into the pool must be lock protected
>       * anon_pipe_prefill() does it
>    b) anon_pipe_prefill() can populate up to PIPE_PREALLOC_MAX pages in t=
he
>       pool
> 3) once anon_pipe_write is done, the pool is trimmed back to at most
>    PIPE_PREALLOC_KEEP (2) pages by anon_pipe_trim_pool()
>
> Future:
> =3D=3D=3D=3D=3D=3D=3D
>
> Once this lands, we could keep all allocated pages in the pool and rely
> on a shrinker to trim it under memory pressure.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - User READ_ONCE to read prealloc.count
> - Trim the pool at the reader side
> - Link to v1: https://lore.kernel.org/r/20260626-b4-pipe-unification-v1-0=
-d23fa6b1ee27@debian.org
>
> ---
> Breno Leitao (4):
>       fs/pipe: move the prealloc pool to per-pipe infrastructure
>       fs/pipe: add per-pipe pool push, prefill and trim helpers
>       fs/pipe: switch the read and write paths to the per-pipe pool
>       fs/pipe: remove the old on-stack prealloc helpers and tmp_page[2]
>
>  fs/pipe.c                 | 169 ++++++++++++++++++++--------------------=
------
>  include/linux/pipe_fs_i.h |  21 +++++-
>  2 files changed, 94 insertions(+), 96 deletions(-)
> ---
> base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
> change-id: 20260625-b4-pipe-unification-aba7b8525de7
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
