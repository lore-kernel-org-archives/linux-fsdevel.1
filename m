Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA563537FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777477245; cv=pass; b=u0ykQ8jEiZtRZPQrWgGM2oR3DBPhOSiLlR9E3gtY/wJHZ+YEHGeVE7r14X9BUDYOUa+6IbDeqh3Zz9gItpqKH/DTLVAW49HfR2XA7zMjOoUmAuUK3nPpJKOp/R7GpyeeSeU/kcqXvl1y4z7+Yl6DhOCjeSbIEvc5coSEZJaX2Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777477245; c=relaxed/simple;
	bh=CeaAKYToyIva9yMj9oHgTZNPSsqw1dWHGjrRswh1f+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGI15JD64Uo/dZblchgdlFfkg8aINz/SSXElQX5OnyhP+DCSITOtGGtOOUSDcKsUTI3NzGq5ZLRnwJaXZTkmFWszW0LQKsuI5abqgTtB/3Ptv1x75gIBGsddCM5dSAf6F9bcuHQGS+4KUnyPb7sj88KCMLieH/YHxwY0sALaRis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+V5DjaS; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+V5DjaS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d73352cf2so10692608f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 08:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777477242; cv=none;
        d=google.com; s=arc-20240605;
        b=A+zDrX7ozuR74Wq1qMZKE+qD0v8L5CDYHtL6ojKj9nZF0sP2CdOo3KpN+NkcxgRKvt
         ChzgJZI8108mXY4CK7WsAGeAB+VFk8mqu2C0w4XZU5YjcBf672j+e7D3pAiS844aa624
         8vCbvl5JsfW09o7T2S5DG864KkRSIj1ffo3wpZ6K6uAsNzzKeP0JmtsyAbgf3PDkw7T2
         3ABnBCNjRcbvGiStq1I4ptOrSrfzzfrG56qdAusiwkO1mOb3d3AeIjqXcvmEyMKkdMqx
         hmvtHr7UBPhyOYkruPY7tK6Is3TT7TMUGsJLFv1zwbGiiWriYzFXDU7tC3WkLfCs6wFV
         Dflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/1dPj0h0Ry/Dl6OMSclcpGdduy2t86/d3rQzSExzQpo=;
        fh=cCjWpB24eTrDexqv6EKoJkZEMVPw7XuTcsqVw07T6QQ=;
        b=abRaG0PogUZp2W27vYulVYMzmUwd1Y2986yWfpElX01NmT5XRAQKBSk0EKMjVdsbPz
         00YndYNDgVS/AQl19z1/NyqTS6lxeBAGd1SrT7tAOaxtMQpvS8jAS54+ViTC51rMktrc
         Q2V04rws5gNz6qWkAwnt7C0L2CsxFbPiWhUcMzO20MCEYwMDKaBlwY0t3hDVmFRmsrJE
         3NgWAJt+/wUTl6thCqGlJ9p3oK8z4AxIf5qUoXkLmXR1NINiNDw5eeOTcvlyNp4ZiJ0j
         uPcoza/XIpFMkVB+T7EFJ2xxYXc8mswxhEW0L1O/i1wg90V4CQGxtxxdJNj0DnqlwJ7f
         LIBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777477242; x=1778082042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1dPj0h0Ry/Dl6OMSclcpGdduy2t86/d3rQzSExzQpo=;
        b=F+V5DjaS06NxlgG4LMFvSizabvXK4mFV+8Y6l9SMkNGPUGlDa+TNktD1FyXHTnEuFY
         YpnR4yCa2FZzc96HhYeBXgRkc/tQNKVjED4av3gYbJZgk2VM8qZFQDj6Pi/hwATLgUOu
         OAR1Mbdf6w/ZKHOtrnbblN2kwRP7c+VaJwA9cgKuPbyDiPrPvpS7f25nCTHaRyMQ7X0m
         Pp9k3A89OZK1AipnedsD6O8mswV9IqVg6iqdc7pp/WmmpP58LbZktyAUyTflX56SbdCd
         Y/DVW66OHVKs5ZqCXu6Q3Ux1BNAFePLxSN1QUB9rft6iZOlSO3UKeDz4UnyAFHVzWxZ3
         lciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477242; x=1778082042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1dPj0h0Ry/Dl6OMSclcpGdduy2t86/d3rQzSExzQpo=;
        b=lGiPDFpoEDD0bgxzoFO9C4an6RZsv+eBo8Tdri9hjj2UcaABHeurp+NYPPpgdEEBR1
         e5HXb1tOYqFeAczy4bH1M1su5q4iSWhzMf35dz+2Gvokni8XzpAO2m9ouEJO6hoP+rvP
         58uSonFCQcCFYoqXQaAL/YEG825GlC9d4KFKN70Ccde51anbZIdlsYIJ96vZdCaa5/b6
         Pd5gWiCF5rdsVisjvhhRapE3xZX2D8pBSj1bbE93HgQod6tfTbt1OJVuOshBWb0ilUwe
         lDTYHB3+RE0fZMyc56z2Gbiln08PsIm2NFFvednFLoXjKJlQTVH49hMu9+0/3XMcCPzk
         sexg==
X-Forwarded-Encrypted: i=1; AFNElJ9+VhdQQMamJjDR0OZ9UM99HRSakg1TYz0OqmoalA504WCHxxduFp6hvhqtb6L0bCk/p5dY1gH/3FGW+VgS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+7dAXowen3/L+wQ5/TU5cu6aCE7g+1aAA/p8e24U8b8hPAdQ
	ktXhtaZrxr+QMIqMvU+/Fcdpz/pnt6zTs5CFr+dxkcIEFk8E/8RY7xXS+sbBVoc53MbipiOIFLv
	f6Y3phDtb/p41g8aZT9zMRy0V/1419+4=
X-Gm-Gg: AeBDiesSPFhtwf67EPQeB++Opgbfj3loFRqHOSgxvbiuGH5Ab/57HB1CETJUHp29Nuo
	vgdiVCOIaI4CdqlvZ+vxgzKLjXy6VnFNz54+hdZumxxm1I0PjHQ2gKg0b8jqV1yiddjkjBJAiZR
	e1LVZBpCUsVYBd4Y+g0mcSK9mo+S8bbJOhx/eNli/tD9K+wwHI01+TOiTEx9uqYpGCuu1+6IZ6d
	veb2CcZTN+axwsfQm4mHnQfEE4k5w289OdL4GJowUiJqrkSsmVzlT85FPwMuBkSCGP6aHtw/cJm
	Z5/s0mcJVd4hwd/v2kFzBpbs3CrRQ/Sjig==
X-Received: by 2002:a05:6000:616:b0:43d:77e1:6a69 with SMTP id
 ffacd0b85a97d-4464a7290damr14356599f8f.38.1777477241984; Wed, 29 Apr 2026
 08:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com> <20260413-reduced-nr-ring-queues_3-v4-8-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-8-982b6414b723@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 29 Apr 2026 16:40:27 +0100
X-Gm-Features: AVHnY4LQSyUH50f2SwDxuV8Vc2RyxklxRb1Wazvps7XwQUMTcFfO97mC23iDIAo
Message-ID: <CAJnrk1bE7ALGtWdV2Jm8_36gZv1o3AhF9Pdehwr+tTij_b1JYw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] fuse: {io-uring} Prefer the current core over mapping
To: bernd@bsbernd.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:41=E2=80=AFAM Bernd Schubert via B4 Relay
<devnull+bernd.bsbernd.com@kernel.org> wrote:
>
> From: Bernd Schubert <bschubert@ddn.com>
>
> Mapping might point to a totally different core due to
> random assignment. For performance using the current
> core might be beneficial
>
> Example (with core binding)
>
> unpatched WRITE: bw=3D841MiB/s
> patched   WRITE: bw=3D1363MiB/s
>
> With
> fio --name=3Dtest --ioengine=3Dpsync --direct=3D1 \
>     --rw=3Dwrite --bs=3D1M --iodepth=3D1 --numjobs=3D1 \
>     --filename_format=3D/redfs/testfile.\$jobnum --size=3D100G \
>     --thread --create_on_open=3D1 --runtime=3D30s --cpus_allowed=3D1
>
> In order to get the good number `--cpus_allowed=3D1` is needed.
> This could be improved by a future change that avoids
> cpu migration in fuse_request_end() on wake_up() call.
>
> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
> ---
>  fs/fuse/dev_uring.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index e06d45b161d5000e24431314b2222b66bdea58aa..5c00fd047c8bd359ec34fb6a4=
1abba44f6794517 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -19,8 +19,12 @@ MODULE_PARM_DESC(enable_uring,
>
>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
>
> +/* Threshold that determines if a better queue should be searched for */
>  #define FUSE_URING_Q_THRESHOLD 2
>
> +/* Number of (re)tries to find a better queue */
> +#define FUSE_URING_Q_TRIES 3
> +
>  bool fuse_uring_enabled(void)
>  {
>         return enable_uring;
> @@ -1311,7 +1315,7 @@ static struct fuse_ring_queue *fuse_uring_select_qu=
eue(struct fuse_ring *ring,
>                                                        bool background)
>  {
>         unsigned int qid;
> -       int node, retries =3D 0;
> +       int node, tries =3D 0;
>         unsigned int nr_queues;
>         unsigned int cpu =3D task_cpu(current);
>         struct fuse_ring_queue *queue, *primary_queue =3D NULL;
> @@ -1336,26 +1340,36 @@ static struct fuse_ring_queue *fuse_uring_select_=
queue(struct fuse_ring *ring,
>
>         nr_queues =3D READ_ONCE(ring->numa_q_map[node].nr_queues);
>         if (nr_queues) {
> +               /* prefer the queue that corresponds to the current cpu *=
/
> +               queue =3D READ_ONCE(ring->queues[cpu]);
> +               if (queue) {
> +                       if (queue->nr_reqs <=3D FUSE_URING_Q_THRESHOLD)
> +                               return queue;
> +                       primary_queue =3D queue;
> +               }
> +
>                 qid =3D ring->numa_q_map[node].cpu_to_qid[cpu];
>                 if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
>                         return NULL;
> -               queue =3D READ_ONCE(ring->queues[qid]);
> +               if (qid !=3D cpu) {
> +                       queue =3D READ_ONCE(ring->queues[qid]);
>
> -               /* Might happen on teardown */
> -               if (unlikely(!queue))
> -                       return NULL;
> +                       /* Might happen on teardown */
> +                       if (unlikely(!queue))
> +                               return NULL;
>
> -               if (queue->nr_reqs < FUSE_URING_Q_THRESHOLD)
> -                       return queue;
> +                       if (queue->nr_reqs <=3D FUSE_URING_Q_THRESHOLD)
> +                               return queue;
> +               }
>
>                 /* Retries help for load balancing */
> -               if (retries < FUSE_URING_Q_THRESHOLD) {
> -                       if (!retries)
> +               if (tries < FUSE_URING_Q_TRIES && tries + 1 < nr_queues) =
{
> +                       if (!primary_queue)
>                                 primary_queue =3D queue;
>
> -                       /* Increase cpu, assuming it will map to a differ=
et qid*/
> +                       /* Increase cpu, assuming it will map to a differ=
ent qid*/
>                         cpu++;
> -                       retries++;
> +                       tries++;
>                         goto retry;
>                 }
>         }
> @@ -1366,9 +1380,10 @@ static struct fuse_ring_queue *fuse_uring_select_q=
ueue(struct fuse_ring *ring,
>
>         /* global registered queue bitmap */
>         qid =3D ring->q_map.cpu_to_qid[cpu];
> -       if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> -       /* Might happen on teardown */
> +       if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues)) {
> +               /* Might happen on teardown */
>                 return NULL;
> +       }
>         return READ_ONCE(ring->queues[qid]);
>  }
>

This kind of seems like a runtime workaround for the mapping algorithm
we used in patch 5 for the round-robin distribution.

In patch 5, the mapping logic is:

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

I think if we tweaked the mapping initialization to

      if (cpumask_test_cpu(cpu, q_map->registered_q_mask)) {
          q_map->cpu_to_qid[cpu] =3D cpu;
      } else {
          qid_idx =3D mapping_count % nr_queues;
          q_map->cpu_to_qid[cpu] =3D cpumask_nth(qid_idx,
                                       q_map->registered_q_mask);
          mapping_count++;
      }
      ...

then it's guaranteed that a CPU with its own registered queue would
always map to its own queue, and this patch could be dropped.

Thanks,
Joanne
