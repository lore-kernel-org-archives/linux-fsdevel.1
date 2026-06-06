Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53C1E5B63
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711253; cv=pass; b=BdrtggTjr27Qi+CYNvD9WTmBYNPY2itB+lezCEuvGQG4wfuvJavnKuOAk7JbvC2kqmYn4/XOZmwqMSqhYPuSmIgslISiDPO1qKDgjrrPE68PQV+Nq1oyVCx/lVvLE0+ZQuHSXkh88CHjCcoUcSgb3uesd/P5TyvVPHvq6mh6MVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711253; c=relaxed/simple;
	bh=y8MrArTloh7HwYIn5HGHG4Q/EWjSmkN3cfOm9flDh4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RF3cv5qNqXD67vFnxH3PxqxZuEr47XZrf1vBEdvTzr0+xB0k1dfkGoUVMu4etXgbpXJ7xGV0/MrumU+YlHEQnVrY9eYD1JPW0YlVLecy//x2CBdgMYPzOiyna2Ewlxo8fy5h1gJFjOD0Tm3JPIVPWhuJZVEadEUIuQrXJyeDEMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4QMJ2kv; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4QMJ2kv"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5175d339e8bso956651cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 19:00:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780711250; cv=none;
        d=google.com; s=arc-20240605;
        b=CauIKvKahIFkD/H5OiLp2cgC8BgQPkuXJ7AF4tf/S2Afq9BKjt9U3Ujx77PzZDUlgm
         H6WTgJe9z5oWIelDtYcFbNibbwaCaqy+pUCaWW3AmsK/sfY49dLHsrFP7PlTLQoEhNUu
         KUsbT5PyHvg34OngKDaYrhWoy2fJfw8oT6ln6Yt8dekxhGhqpuzdDPh/dfpJ+qrOB1I3
         JNO9jiAd4mzsnpJJ/rjV3vX3bMzB09dIPY+DpgUOZ0FuWZHN2OiHWunWB0rmBkt0tWnE
         N7rY1b3sj4U1oSdoBjxb0cRligr4MSgSodDPHzjYjo1n0AfEvJob7Z/5QQEgipSb7wg6
         j4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W3uN84pHMHR/C2UzmkBURXkAlMHc0n4HuIo+YW7P8R0=;
        fh=Qw5y6LhVSSOqePczY6zN8ZqxFfB4I8Q4PI2pWe8lY9o=;
        b=iR4Pt/9rbZgixiYpW2IkCvjAKLIEKv8NVt8sRd2QQd7ZRH4pCW0JAQlGzGGm3ujgRV
         oV/RYAZiqMwWbW/xfMLj4uiDxRN1dCLgNaVFkjL4L40juHIel4XGGveVQRxU43tK2a4B
         VZ6dO9NL219gecliPh5jIu+Hcwq3/pPeckntQlJAEBFToVzNBMXiPpp+BuRFKmRj/sPr
         TQWCw2eiDP3QhVHAUzfkOG+6ImyfyXHbIdYvbBeGE0bLITsJEH2BnGN3gA3E72kmzQ1i
         K9Aot/ICCzqZLq1Zhh3zrhJSDoIIneDpusFICiFAwlpSKpN13i0U0EZ5WH2FLzy9zIP5
         0FJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780711250; x=1781316050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3uN84pHMHR/C2UzmkBURXkAlMHc0n4HuIo+YW7P8R0=;
        b=G4QMJ2kvGT0lCwtBKHl6SMSycIrw6eUjSNrQFYw2XCVETTjkQ3RcdjENQ1zgEjjfBy
         bgLWrpS0HeFZWaINmiPTjgd6ZFlLpzWrXbZBDoKflJyLgI5XrRh5hEpOv3pdiFvsFlTq
         xy4MDRL2RXMtow8raujGeCSeQRXulO+ZmPpf6K+VPY+Xu6XU9MNCTPPeGR8fCcjVH8bA
         Lt6gmH87jIFO52jd5tNSWCTQeb6c9lSwLk3PWtALtabBihHPXS0W/atFoL04vZ8FesRu
         m03CAVYQOpZLXP3kRgAGVIiFigo8aRR/7cx6ZBqSEdrYoqGRTrY39mR+D36wzGfqyOdX
         jPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780711250; x=1781316050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3uN84pHMHR/C2UzmkBURXkAlMHc0n4HuIo+YW7P8R0=;
        b=GtA38mSawmijRgBEdz7E+M7uDcH0bYVw4api6Ue8SQSZB7H+7QVplt+IGjT7kE/g7Z
         esgyEJtVRG0JxdhqzZkwcbrpbztAPgBx9d8koy7v99N94thtLs5hwy8h8+X0eFEdFHmQ
         /fY03ZJfqi9+iIwkkyAEOUZ5W0TjvojXhl0i9C716ONlfhBvQR/i+a8VgqjuuegK21PH
         iQmnUB8h97p8j587IkbjUamvQsIK1sdgsJyt74N8uHaImT+bXvx40DkThu71LWlZSSM8
         tMGeAoPEvV61HXZLPhnynA2fmsHT4Fs+12mqp1leYb/PXzdgF80pNvvKa1lfq7qXzd6z
         IudA==
X-Forwarded-Encrypted: i=1; AFNElJ/6Dix6hgak2/eUE/pTBBvtOzOJhS94Zctrij8kZi2mGul/mDlp53AF10eFgrLP3uT0k0x06kU0rHQApe/m@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVNK/P/ei+/3HZ30QWjFWaJqSvRzIETb7IIvfa2aKY8jm0Hrs
	Tiub/IGIYZ85HWu4/Eu6O8z4JBCR9um5VbyLpNv4/DsjlYnwcNBpMnsiKvcGdEuqePsz3PLz7Ph
	ITUa0BdxOFGyU6wNNPrJxxuZxIIjfgYVUQ+ofKygt
X-Gm-Gg: Acq92OGbMnhq8vNwgYNfdQ1EziakiClhPLfwtHZb5KK/xnr8ik413gt4Fj9sb/kNaeQ
	Zjh4kylPDQiQ8wFtOz3WzQQGXNvFSvjvngujn3RH+HgY5hXe64PcxjvPD8aJA35GqGI4juIE1OY
	7Lo4e4ufXkNtZXUQ5chtbdnj8xwuKgeCKiOP52D4SrsEuZIJIhzwkVZUiHiYPe75uY62ylhAa5p
	m/W91uNteMoXmrKpY3TIBoLVeDdgnhy3QQAPPZpxGrVmeuLkr59AG5fFlNdw3GCuDi0lPxe+7V+
	Pir2Fcq0jxlOAtple4miEw2MBD+jgSQoY6y8a3BDmuXsoE6d
X-Received: by 2002:ac8:7417:0:b0:517:99ea:ab80 with SMTP id
 d75a77b69052e-51799eabf02mr8967011cf.26.1780711249743; Fri, 05 Jun 2026
 19:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <20260606015729.1837935-2-surenb@google.com>
In-Reply-To: <20260606015729.1837935-2-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 5 Jun 2026 19:00:38 -0700
X-Gm-Features: AVVi8CeX40G7QLU5oGSI4qQlj7diB0CQ5YrZ_KNxk7OTfs_4cG4fys0JJTzkVwg
Message-ID: <CAJuCfpGMAe_1ne7cWAoug=zyh+H6CQbcwzaSK_tEnMoN8xnnrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 6:57=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> proc/pid/smaps_rollup can be read using the combination of RCU and
> VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
> required to safely traverse the VMA tree and VMA lock stabilizes the
> VMA being processed and the pagetable walk.
> Note that we have to keep the logic to drop mmap_lock on contention
> because even when using per-VMA locks we might have to fall back to
> holding the mmap_lock.
>
> Running Paul's contention benchmark [1] shows considerable improvement
> both in median and in the worst case latencies:
>
> Execution command: run-proc-vs-map.sh --nsamples 20 --rawdata -- \
> --busyduration 2 --procfile smaps_rollup
>
> Baseline:

Forgot to add the names for the columns:

#  Median   Minimum   Maximum

>     0.174     0.161     2.553
>     0.174     0.164     2.663
>     0.174     0.165     2.664
>     0.174     0.166     2.679
>     0.174     0.167     2.691
>     0.174     0.168     2.704
>     0.174     0.169     2.729
>     0.174     0.172     2.741
>     0.174     0.174     2.745
>     0.174     0.174     2.755
>     0.174     0.175     2.790
>     0.174     0.177     2.809
>     0.174     0.179     3.096
>     0.174     0.183     3.144
>     0.174     0.184     3.158
>     0.174     0.185     3.175
>     0.174     0.185     4.568
>     0.174     0.198     4.821
>     0.174     0.214     5.143
>     0.174     0.251     5.220
>
> Patched:
>
>     0.007     0.007     1.952
>     0.007     0.007     1.955
>     0.007     0.007     1.955
>     0.007     0.007     1.955
>     0.007     0.007     1.957
>     0.007     0.007     1.969
>     0.007     0.007     2.065
>     0.007     0.007     2.075
>     0.007     0.007     2.146
>     0.007     0.007     2.195
>     0.007     0.007     2.223
>     0.007     0.007     2.259
>     0.007     0.007     2.488
>     0.007     0.007     2.562
>     0.007     0.007     2.599
>     0.007     0.007     2.697
>     0.007     0.007     3.030
>     0.007     0.007     3.075
>     0.007     0.007     3.145
>     0.007     0.007     3.225
>
> [1] https://github.com/paulmckrcu/proc-mmap_sem-test
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/task_mmu.c | 134 ++++++++++++++++++++-------------------------
>  1 file changed, 59 insertions(+), 75 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 023422fcee12..c2bd9f5bbbcd 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -233,6 +233,16 @@ static inline void reacquire_rcu(struct proc_maps_pr=
ivate *priv)
>         vma_iter_set(&priv->iter, priv->lock_ctx.locked_vma->vm_end);
>  }
>
> +static inline bool is_mmap_lock_contended(struct proc_maps_private *priv=
)
> +{
> +       struct proc_maps_locking_ctx *lock_ctx =3D &priv->lock_ctx;
> +
> +       if (!lock_ctx->mmap_locked)
> +               return false;
> +
> +       return !!mmap_lock_is_contended(lock_ctx->mm);
> +}
> +
>  #else /* CONFIG_PER_VMA_LOCK */
>
>  static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> @@ -268,6 +278,11 @@ static inline bool fallback_to_mmap_lock(struct proc=
_maps_private *priv,
>         return false;
>  }
>
> +static inline bool is_mmap_lock_contended(struct proc_maps_private *priv=
)
> +{
> +       return !!mmap_lock_is_contended(priv->lock_ctx.mm);
> +}
> +
>  static inline void drop_rcu(struct proc_maps_private *priv) {}
>  static inline void reacquire_rcu(struct proc_maps_private *priv) {}
>
> @@ -1486,12 +1501,15 @@ static int show_smap(struct seq_file *m, void *v)
>  static int show_smaps_rollup(struct seq_file *m, void *v)
>  {
>         struct proc_maps_private *priv =3D m->private;
> +       struct proc_maps_locking_ctx *lock_ctx =3D &priv->lock_ctx;
> +       struct mm_struct *mm =3D lock_ctx->mm;
>         struct mem_size_stats mss =3D {};
> -       struct mm_struct *mm =3D priv->lock_ctx.mm;
>         struct vm_area_struct *vma;
> -       unsigned long vma_start =3D 0, last_vma_end =3D 0;
> +       unsigned long vma_start =3D 0;
> +       unsigned long last_vma_end =3D 0;
> +       loff_t pos =3D 0;
>         int ret =3D 0;
> -       VMA_ITERATOR(vmi, mm, 0);
> +
>
>         priv->task =3D get_proc_task(priv->inode);
>         if (!priv->task)
> @@ -1502,89 +1520,55 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
>                 goto out_put_task;
>         }
>
> -       ret =3D lock_ctx_mm(&priv->lock_ctx);
> +       hold_task_mempolicy(priv);
> +       ret =3D lock_vma_range(m, lock_ctx);
>         if (ret)
>                 goto out_put_mm;
>
> -       hold_task_mempolicy(priv);
> -       vma =3D vma_next(&vmi);
> -
> -       if (unlikely(!vma))
> +       vma_iter_init(&priv->iter, mm, 0);
> +       vma =3D proc_get_vma(m, &pos);
> +       if (unlikely(!vma) || vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
>                 goto empty_set;
>
> +       if (IS_ERR(vma)) {
> +               ret =3D PTR_ERR(vma);
> +               goto out_unlock;
> +       }
> +
>         vma_start =3D vma->vm_start;
> -       do {
> -               smap_gather_stats(priv, vma, &mss, 0);
> +       while (vma) {
> +               if (IS_ERR(vma)) {
> +                       ret =3D PTR_ERR(vma);
> +                       goto out_unlock;
> +               }
> +
> +               if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> +                       break;
> +
> +               /*
> +                * If after retaking mmap_lock, already reported VMA grew=
 or
> +                * merged with the next one, then iterate from last_vma_e=
nd.
> +                */
> +               smap_gather_stats(priv, vma, &mss,
> +                                 vma->vm_start < last_vma_end ? last_vma=
_end : 0);
>                 last_vma_end =3D vma->vm_end;
>
>                 /*
>                  * Release mmap_lock temporarily if someone wants to
> -                * access it for write request.
> +                * take it for write request.
>                  */
> -               if (mmap_lock_is_contended(mm)) {
> -                       vma_iter_invalidate(&vmi);
> -                       unlock_ctx_mm(&priv->lock_ctx);
> -                       ret =3D lock_ctx_mm(&priv->lock_ctx);
> -                       if (ret) {
> -                               release_task_mempolicy(priv);
> +               if (is_mmap_lock_contended(priv)) {
> +                       unlock_vma_range(&priv->lock_ctx);
> +                       ret =3D lock_vma_range(m, lock_ctx);
> +                       if (ret)
>                                 goto out_put_mm;
> -                       }
> -
> -                       /*
> -                        * After dropping the lock, there are four cases =
to
> -                        * consider. See the following example for explan=
ation.
> -                        *
> -                        *   +------+------+-----------+
> -                        *   | VMA1 | VMA2 | VMA3      |
> -                        *   +------+------+-----------+
> -                        *   |      |      |           |
> -                        *  4k     8k     16k         400k
> -                        *
> -                        * Suppose we drop the lock after reading VMA2 du=
e to
> -                        * contention, then we get:
> -                        *
> -                        *      last_vma_end =3D 16k
> -                        *
> -                        * 1) VMA2 is freed, but VMA3 exists:
> -                        *
> -                        *    vma_next(vmi) will return VMA3.
> -                        *    In this case, just continue from VMA3.
> -                        *
> -                        * 2) VMA2 still exists:
> -                        *
> -                        *    vma_next(vmi) will return VMA3.
> -                        *    In this case, just continue from VMA3.
> -                        *
> -                        * 3) No more VMAs can be found:
> -                        *
> -                        *    vma_next(vmi) will return NULL.
> -                        *    No more things to do, just break.
> -                        *
> -                        * 4) (last_vma_end - 1) is the middle of a vma (=
VMA'):
> -                        *
> -                        *    vma_next(vmi) will return VMA' whose range
> -                        *    contains last_vma_end.
> -                        *    Iterate VMA' from last_vma_end.
> -                        */
> -                       vma =3D vma_next(&vmi);
> -                       /* Case 3 above */
> -                       if (!vma)
> -                               break;
> -
> -                       /* Case 1 and 2 above */
> -                       if (vma->vm_start >=3D last_vma_end) {
> -                               smap_gather_stats(priv, vma, &mss, 0);
> -                               last_vma_end =3D vma->vm_end;
> -                               continue;
> -                       }
>
> -                       /* Case 4 above */
> -                       if (vma->vm_end > last_vma_end) {
> -                               smap_gather_stats(priv, vma, &mss, last_v=
ma_end);
> -                               last_vma_end =3D vma->vm_end;
> -                       }
> +                       /* Resume from the last position. */
> +                       pos =3D last_vma_end;
> +                       vma_iter_init(&priv->iter, mm, pos);
>                 }
> -       } for_each_vma(vmi, vma);
> +               vma =3D proc_get_vma(m, &pos);
> +       }
>
>  empty_set:
>         show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
> @@ -1593,10 +1577,10 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
>
>         __show_smap(m, &mss, true);
>
> -       release_task_mempolicy(priv);
> -       unlock_ctx_mm(&priv->lock_ctx);
> -
> +out_unlock:
> +       unlock_vma_range(&priv->lock_ctx);
>  out_put_mm:
> +       release_task_mempolicy(priv);
>         mmput(mm);
>  out_put_task:
>         put_task_struct(priv->task);
> --
> 2.54.0.1032.g2f8565e1d1-goog
>
