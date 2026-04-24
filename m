Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7213ECBF7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055339; cv=pass; b=WyVhGCegtSP/SWvpH3PiKz9k9jIO/TaxWu61ziQHdJiXXuLTanL27T2e2mG1UhlFdlt1+sWIS2Bn4P+o6sV/EBE0yXgWMMbM7QJxzk+RoSPMs3Z/TARqhRpVgFSX724t89VG+uIcrPElG8zEom9u67i14DppTZ5631ef4FpJRiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055339; c=relaxed/simple;
	bh=8rO2083aLBq61GOTbhsIrvySGv61xLrJsOS67lJka0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piTNMRYXQtyM9fZsXyKWhj2kUeXGiwNh3mlC1Nv/V9/0ONut6DoL7pHWR5eMnrOuHoiwAhTMU1lxL8OcS5w2SPzvMZmh7l6CsT2BdLGC9k4WVONpI8WGJiaMfaKJ2zzPsiEylOg7KOpMx/8wz9r+aD+u9aWSsVM8TL4RBaf/BNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3zAgnjk; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3zAgnjk"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-441209fb77eso3181206f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 11:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777055336; cv=none;
        d=google.com; s=arc-20240605;
        b=AoOagI8ZeVg+FprYJhw7dqxHtbNGGhzImoXdmk3u6gfIEIopqiktnHdUt+X/sE7jof
         Nit2fNrLBa8Qe39otLoumeGJoB/AlOEjZswauD4umWTkiv6G/MsoFs0gn2asfmWrXuoJ
         nJ+wcZDAryNY6LuTNYRT/dJKEBEPXQK1JJSKfkIzIWGaTVN13ik+adBujPcoqq/eR3Rv
         /8Ys/mGssioLUUfSFNHejnrbHYAy1aUFHZHd8VRZD/Jm9UVvYOtKIDW+qiwHmGtbxqch
         IZYY4mpcJIJavNpGQ/MGTj3NDgQ2PTUlr377gSuRwU0i2eskexBIL21ubEYeC2m7JWtM
         Wgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3RviMO2our0cPSaycktZix7+ios2n20gMA9XnhIUvbM=;
        fh=dZjUQCmqVSbLJn/DvZl7dNxuM3Bfnz3oqCMXu6Gf+KY=;
        b=OTcidAAnShIFNuzTN81A9LD8SH9VMCvN/sZdcg87DsutzuImXNN0GTB9P3dJql1AY9
         gpYJmfBHepN5U8vqOtZ27lkhRtxYpSV5z6bxivOd3Dm7jihSeul0L8RfiPKXk2hUqJ1/
         HdOtzZJf8sVqZcDWRDVhetT9fpnwzHXNyAlnyyQi88qOX55k/SXEXYnTyfuwbuT/TyIy
         gejgZ59QOpqPYtnQaBIMerv54IewiP/x3ANo+q2xa4x8ALU5ZKmIHi67oLA8qfR1GTxS
         6lcBDUf3PhOXjHeDQoVOzHcoJiGfhGR85dvhQifWptGjuMI8zWcHxcp7PIw/cl9WaEoX
         L6fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777055336; x=1777660136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RviMO2our0cPSaycktZix7+ios2n20gMA9XnhIUvbM=;
        b=B3zAgnjkdCsmW4/FWAUdtqEnpH/TjrcyCGzdr94XViNZEgt9Wpqc/vTD3jxg0Od/TO
         QdtV9KFZ6OFPgdki0H3fVWLpN4P7RDqkfzWKvfCcBGMdkCJn8UZjOS2oeSipLkLg0tRP
         /pIaDFvGyIFNbWTyQyO4lmSH2TRNU0rhJBpqmnLrhUJ3g7zmLyM3zYw14g/HrgGjK8FK
         w29tZiyUgjy5o9NQRprdbxwj8JL6FSzas4q5Uvvut/noq6/mvTriIjItOyhBuE2/n4yw
         dz09CNdGXopcxiG+wK7bpKz6aAlCxhAS7O0oezQkMBa38KpxK0v0YBagf+WpvpXPh25y
         iO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777055336; x=1777660136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3RviMO2our0cPSaycktZix7+ios2n20gMA9XnhIUvbM=;
        b=DkNkNkpyL085mu+kot4frTwt4n+O9o7HyqjMHGqZ57KQJ/I9gAn5sXLTysjt3j017k
         kHU7gQz/FTD6TCmLteOhQDuhKU5xiW3yiHAqpQ/lPq7GFJkPgoRYSekVSlDvRZYaNZeV
         UFLRhtQOvChLtBdURyQ5WAk47PwExCnsw5U+hksxuRXpdwW+CLVRUJ4l3zm4oPsV6E2q
         ExVnl+B3Q7IWywhGotEib8JXtSEDrXbh2NF7qGsn9XdoNk/yA2NmxdG1mVFE1J3eLA9L
         9nNGnECnhKPqJsFV6+LYsvd2HntLmwaqto11lJ00GlQGjrMzevtJsBigqPX5SXqzoXqb
         koyw==
X-Forwarded-Encrypted: i=1; AFNElJ89GEh+DaFZIB3cVglSJ0LAGa4XYKiTGbS96lud1HJjP9echLZDjL211jNaUg3+kz+sQAALzLWYzg4jpW2I@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzw0vFi9rkQ5H5/NK1Zl64Mjay0AG5sEvJ2vbN+oBqQDiim9d
	Z2FbjU+KwOTcDM9UN7wMgEX7uJaGKeMINwcG1MLdOwa3+hbjllmjf14OMP7IYXBOpQ839+ZXniQ
	WRKE9YdqyF9/Pa+AL5MyZ9KWlSYV1mko=
X-Gm-Gg: AeBDietTQXHTD4cTdYuTNg7Bo/jNSt3DqseH11uOffu8VJGF68ZCnXv9aJqxWI3UfI1
	S7mi5pnxy2BmgGbWUJr9IPSJCuJieOhJoQRPaoxr/YA6pPclEeEZkMewhyMBZI9BZPsS15x2D25
	jzf4girHwixiosFso0OSWZ8oWNC7a2X4RUa7z90a/RrV2g9pTuy3IxW5a6ZQ5Dw5YNzAJg4LLWa
	dm5pjAoTROT527KIRSEss1kmwjsajW2J0z5xwIZzqFq2INKUaMwPeL4sGu6qNhoj4ieBW1tNarm
	vFciW6+MlIrr5wrRD0POQioqKcDEAFgCpbxfH7GVO0eJ
X-Received: by 2002:a05:6000:480e:b0:43d:2ea7:df30 with SMTP id
 ffacd0b85a97d-43fe4043916mr45387860f8f.7.1777055336070; Fri, 24 Apr 2026
 11:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com> <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Apr 2026 11:28:43 -0700
X-Gm-Features: AQROBzBP56M81XBGe1nAOwMhyn7CmfemzOkuvHC9Tz5GMvZjtNu5e7HnvUvDrxU
Message-ID: <CAJnrk1aYYSVU-AdxRoqC5H8xk+4rt9Tf=3BPphsw4vvNxjpEyA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] fuse: {io-uring} Allow reduced number of ring queues
To: bernd@bsbernd.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 2:41=E2=80=AFAM Bernd Schubert via B4 Relay
<devnull+bernd.bsbernd.com@kernel.org> wrote:
>
> From: Bernd Schubert <bschubert@ddn.com>
>
> Queues selection (fuse_uring_get_queue) can handle reduced number
> queues - using io-uring is possible now even with a single
> queue and entry.
>
> The FUSE_URING_REDUCED_Q flag is being introduce tell fuse server that
> reduced queues are possible, i.e. if the flag is set, fuse server
> is free to reduce number queues.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c       | 160 ++++++++++++++++++++++++----------------=
------
>  fs/fuse/inode.c           |   2 +-
>  include/uapi/linux/fuse.h |   3 +
>  3 files changed, 88 insertions(+), 77 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 9dcbc39531f0e019e5abf58a29cdf6c75fafdca1..e68089babaf89fb81741e4a5e=
605c6e36a137f9e 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -249,15 +249,17 @@ static int fuse_uring_init_q_map(struct fuse_queue_=
map *q_map, size_t nr_cpu)
>
>         q_map->cpu_to_qid =3D kzalloc_objs(*q_map->cpu_to_qid, nr_cpu,
>                                          GFP_KERNEL_ACCOUNT);
> +       if (!q_map->cpu_to_qid)
> +               return -ENOMEM;
>
>         return 0;
>  }
>
> -static int fuse_uring_create_q_masks(struct fuse_ring *ring)
> +static int fuse_uring_create_q_masks(struct fuse_ring *ring, size_t nr_q=
ueues)
>  {
>         int err, node;
>
> -       err =3D fuse_uring_init_q_map(&ring->q_map, ring->max_nr_queues);
> +       err =3D fuse_uring_init_q_map(&ring->q_map, nr_queues);
>         if (err)
>                 return err;
>
> @@ -267,7 +269,7 @@ static int fuse_uring_create_q_masks(struct fuse_ring=
 *ring)
>                 return -ENOMEM;
>         for (node =3D 0; node < ring->nr_numa_nodes; node++) {
>                 err =3D fuse_uring_init_q_map(&ring->numa_q_map[node],
> -                                          ring->max_nr_queues);
> +                                           nr_queues);
>                 if (err)
>                         return err;
>         }
> @@ -299,7 +301,7 @@ static struct fuse_ring *fuse_uring_create(struct fus=
e_conn *fc)
>         max_payload_size =3D max(FUSE_MIN_READ_BUFFER, fc->max_write);
>         max_payload_size =3D max(max_payload_size, fc->max_pages * PAGE_S=
IZE);
>
> -       err =3D fuse_uring_create_q_masks(ring);
> +       err =3D fuse_uring_create_q_masks(ring, nr_queues);
>         if (err)
>                 goto out_err;
>
> @@ -328,12 +330,36 @@ static struct fuse_ring *fuse_uring_create(struct f=
use_conn *fc)
>         return res;
>  }
>
> +static void fuse_uring_cpu_qid_mapping(struct fuse_ring *ring, int qid,
> +                                      struct fuse_queue_map *q_map,
> +                                      int node)
> +{
> +       int cpu, qid_idx, mapping_count =3D 0;
> +       size_t nr_queues;
> +
> +       cpumask_set_cpu(qid, q_map->registered_q_mask);
> +       nr_queues =3D cpumask_weight(q_map->registered_q_mask);
> +       for (cpu =3D 0; cpu < ring->max_nr_queues; cpu++) {
> +               if (node !=3D -1 && cpu_to_node(cpu) !=3D node)
> +                       continue;
> +
> +               qid_idx =3D mapping_count % nr_queues;
> +               q_map->cpu_to_qid[cpu] =3D cpumask_nth(qid_idx,
> +                                                    q_map->registered_q_=
mask);
> +               mapping_count++;
> +               pr_debug("%s node=3D%d qid=3D%d qid_idx=3D%d nr_queues=3D=
%zu %d->%d\n",
> +                        __func__, node, qid, qid_idx, nr_queues, cpu,
> +                        q_map->cpu_to_qid[cpu]);
> +       }
> +}
> +
>
> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring=
 *ring)
> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring =
*ring)
>  {
>         unsigned int qid;
> -       struct fuse_ring_queue *queue;
> +       int node;
> +       unsigned int nr_queues;
> +       unsigned int cpu =3D task_cpu(current);
>
> -       qid =3D task_cpu(current);
> +       cpu =3D cpu % ring->max_nr_queues;
>
> -       if (WARN_ONCE(qid >=3D ring->max_nr_queues,
> -                     "Core number (%u) exceeds nr queues (%zu)\n", qid,
> -                     ring->max_nr_queues))
> -               qid =3D 0;
> +       /* numa local registered queue bitmap */
> +       node =3D cpu_to_node(cpu);
> +       if (WARN_ONCE(node >=3D ring->nr_numa_nodes,
> +                     "Node number (%d) exceeds nr nodes (%d)\n",
> +                     node, ring->nr_numa_nodes)) {
> +               node =3D 0;
> +       }
>
> -       queue =3D ring->queues[qid];
> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
> +       nr_queues =3D READ_ONCE(ring->numa_q_map[node].nr_queues);
> +       if (nr_queues) {
> +               qid =3D ring->numa_q_map[node].cpu_to_qid[cpu];
> +               if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> +                       return NULL;
> +               return READ_ONCE(ring->queues[qid]);
> +       }

Hi Bernd,

Thanks for making the changes on this - I really like how much simpler
the logic is now.

I'm looking through how the block multiqueue code works
(block/blk-mq.c and block/blk-mq-cpumap.c) because I think they
basically have to do the same thing with figuring out which cpu to
dispatch a request to.

It looks like what they do is use group_cpus_evenly(), which as I
understand it, will partition CPUs taking into account numa nodes (as
well as clustering and SMT siblings). I think if we use this for fuse
io-uring, it will make things a lot simpler and we could get rid of
the per-numa state tracking (eg numa_q_map, registered_q_mask,
nr_numa_nodes)  and simplify queue selection where now that can just
be a cpu to qid lookup instead of a two-level
numa-then-global-fallback lookup.

Do you think something like this makes sense?

Additionally, as I understand it, in this series, the ring->q_map
mapping has to get rebuilt every time a new queue gets created. What
do you think about just having the server declare the total queue
count upfront and then the mapping can just get established at ring
creation time? group_cpus_evenly() would only need to be called once,
the cpu_to_qid map would only have to be built once, and we could
avoid the rebuild-on-each-queue-creation complexity entirely. Do you
think something like this makes sense?

Thanks,
Joanne

>
> -       return queue;
> +       /* global registered queue bitmap */
> +       qid =3D ring->q_map.cpu_to_qid[cpu];
> +       if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> +               return NULL;
> +       return READ_ONCE(ring->queues[qid]);
>  }
>
>  static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
> @@ -1348,7 +1356,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>         int err;
>
>         err =3D -EINVAL;
> -       queue =3D fuse_uring_task_to_queue(ring);
> +       queue =3D fuse_uring_select_queue(ring);
>         if (!queue)
>                 goto err;
>
> @@ -1392,7 +1400,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>         struct fuse_ring_queue *queue;
>         struct fuse_ring_ent *ent =3D NULL;
>
> -       queue =3D fuse_uring_task_to_queue(ring);
> +       queue =3D fuse_uring_select_queue(ring);
>         if (!queue)
>                 return false;
>
