Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115263;
	b=DwXGykeMXS2aoNN/spUe+FWTzf9lEl85+UdkG32+YMwU8dsvabzNop2EdHnuWsqk0r4D
	 M+NiPA+KnSsgQfUP83M1A+zHlQ2sW0UPmNOj4P2DIrBwqJL4wfuvhqdKNbr6H5DtWxFvZ
	 IKCz6icKuo/q9M1S6dNmYb2QpBfMl3OGVwXe/6NkazdMUN43+K123A4BA3m++ctXw4nJa
	 vEQSrJSKGpCncWaUsd2Po9lJlZBEE9RvqfUATFyzfwNSDo1AQvBpZl3SFWhVVlSc3umlK
	 arb6RU5CgMyPpmTtjUfIrtojmOb6//Yz+5njhYXa+qTFEqOXe5VFzES0h1lARh5sgkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3BCqo9DTVlGvGGt63tyjWLqgcTRJp5lddshmK2HXV3Q=;
	b=zjZS+eHMoyBmH3Uc3IBb8JVjtNwf0ppOfFcdxZWomhBpRpEaNPmguVJkFt5KD5XIxp95
	 AWUFMFPXCWDBTm5SodQc2TDqb0Tic2ZDoJHAMiOtzgGTBPx81QffFXBB9f/QsIrQl0LkE
	 UltQ0v6ad8vhozpzxkbVbBVbRUEGoflN94IZpByccukeZOU0HdH3DMh5xbCn872+ubK2o
	 d8XJgN33vPcB3yqkQAPa6zTNvv/GoLffGg5PxFXfLSx/9VzZJOCHMr/fsBrdUXFMAse5U
	 sksuc7nvV8X1UzUJmcPPWV3aikTuVDQhY+UgHFJ40pKnOJbJw2xrybWqEp/56zkorhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I2CXkr71;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5A606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D5A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I2CXkr71
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5383c97c8cfso324551cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 08:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793115262; cv=none;
        d=google.com; s=arc-20260327;
        b=pAPhO6mYAVM9KmIx8gXwzHTIjxEeLJ0QmFgfuR9LQD7AGf/7N4G6b9gEWhd5Nqipg5
         qJTqldLv2gezRAFSRiuassEga3Xci2+Cn7F6kIWLCqGfQni8nxmvb7KMjFleX9Xjlqpx
         mrEBMmGlWEna0alKiA/wjNGij02V0mZTd3tVma+/4HZ/EHaRBDQ+K/q18QZ8JBw5eJ/a
         3OyeZ9urquslibKlvp2qsupFMDas8wuksDmz+cPJTTdYzkKcae00O35CEHT3CWeiWKaj
         pQL3hu5C8N0MQbJW6VFDDebQYIz9O/EFE8Asl8nrfp/klMuyUIqqVk6eTZdDqeAtgGJF
         qg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BCqo9DTVlGvGGt63tyjWLqgcTRJp5lddshmK2HXV3Q=;
        fh=lLnnVQ1Yipgnk9t39XUqqJwH2vpIM81K+zwp0yBggPQ=;
        b=NIqL5Bhzl9nJeJuOK6SENBw916+ygjzz3VpPivxvEdeMhWVu3W/NGbitgFbfEsN653
         o5eEbii8GmWJEW/nyVs2l9rZ48Ha6DDUPZ/OpDpaO9jqaiO97fCJrB8vDwp8p20pir8Q
         5x7jLBpxD7309RM02a+gN3//k2UGVdhwg7r1H6rTByANvpOzTFqrPSuGxMtEx+TKUZK0
         ET0YDMnwn831c7JxPLhkkyQrtgacqtLmBZfoXYwNubaQ3opaTUR6rYUCBu56XzL6MifX
         v+C5rfEzrVHCaEmpy9RZ5cjoZ97M2GmXz59yJz31bAhKk6PjMifmH9SZqJR/tFnr0Ruo
         EgOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793115262; x=1793720062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3BCqo9DTVlGvGGt63tyjWLqgcTRJp5lddshmK2HXV3Q=;
        b=I2CXkr71eslqj+MzkCc6GenReH55B9jr5dbqHpx5xXwrh5A5nfe28mCtZJLFc93rts
         kzzut8h77lK+HBp+hUYOY/JB8iTND4LYg0o9AoQimbHDYAI+3D57aAXgh+ZC/e/MGGuj
         fa7JcnFzV7NGUmxEPO55U8my+uiduAIt66MkZja5GFG0Aq/0iYlibtrXLvVxHs2wGymj
         L9bIjOnqL33y4JHjuneWUxb85XsIqsyoKKp4BuvfrHC9hgD3YvPCOefOWOU2tERQGbaE
         lQGM6tym4I0WRUaQq3QvWDzQCw8F0vkyJjuEizNzcgub7zA8OHwvq2kZYygY7fFyni3w
         tKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793115262; x=1793720062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BCqo9DTVlGvGGt63tyjWLqgcTRJp5lddshmK2HXV3Q=;
        b=TGCafxqmI9VeG+o5DaAEKvgiBNphyUHd68+1aPj0QU++vseUHg12XWhXa281KiqvHa
         6rUFJM22OJXs6L6MlYj/3PozYNF2iMO6IfmOVtqG9TK6TIlYCxn5K94S7grRXda0iohT
         hgajj07JMS5cKFgv6yWMhA83LSUCD1f+8GU/O2PZls8rhOV5QcRHtFa0/JaSK+1bA16D
         GZuiOy3uUVky2WNasfYRUZv1+HofcODqD4xK6YqS4tLZEvQGDnBt+mSDkly8fz7vaG1V
         6M2d8hqbL/jeXdTa8V4mXgAL/keB8TKeM4/65dVqerMorMudQqOh0p8Bw12dbdS/sL2q
         TFmA==
X-Forwarded-Encrypted: i=1; AKwUvBx/MR33B5bVqeJ+cXiwRv62ikp0QAP+UXN4Bjn2JfRZbv3vNZvUa/+lp4MrWKTGC0ccwG6LgFOdONz8z41F@vger.kernel.org
X-Gm-Message-State: AFq9FYKPeXxNKZ5k32z9n/NzzZDyyYayDJ4aU3yf5xHJpe6SahPWMsLN
	hh2SbNFSyXHirE7/wOnQ7C1e5BCuwmGm08SXIHvjuz2ZAALfcLLRTY3OKrUAmUECG809X8sIgYe
	9vED88YZLYHkQVW6O1myY9J3aQWL18z7noPRa0ABc
X-Gm-Gg: AYBFou1ft3g10hDswTowgLT1eeKeHsM/4gEVT9B2VI9y0vWUFTHn88mWGh9i+FGAkPS
	0LPDijuq8C46neWxtVnhkFF8+2AFd7BEqGbBT/HnxNRA2VUFlGZm/2WogquyIhiRgc0a7vOLdnM
	I6C5Iwn5cJxrsKVgQyLmDHwaSMs1eVYNAmSITCHD4s2yx1c+Lfwt9Rk8yNazDh5fbShE9WcOSLF
	wOsgQUC3U1xSRI3wz8xGUEKordRb/tr40T5vn0hAmsOi8AO5ZVX59ffV+pYLmAND1MkL9jY9PPk
	McmOvGKjPKyLU/OHPA0rbfeKZti/lwpd1u2cvaRBtjelJfvRNntq38vHctLXPY8V9eDEMPZ3OOT
	pVcTUpKYZc19/kD3W3f5aHF4O+8WzIpbBYfCVxGgZhlo5yrsLVD/27o5pzVITkfwY+Q==
X-Received: by 2002:a05:622a:2616:b0:535:9aa3:5ebb with SMTP id
 d75a77b69052e-53e75218a9emr18868671cf.8.1793115261144; Tue, 27 Oct 2026
 08:34:21 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
In-Reply-To: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Oct 2026 08:34:10 -0700
X-Gm-Features: AclHuK_escKhxIfcgdWHS93RIjhc6nNSVRM5pRyb491eVnaMJqYuWsz74l9RKRk
Message-ID: <CAJuCfpELhxhyVQANspX14OBLbghiAqndYcfv1hnmh4Nvo=1vAQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Shakeel Butt <shakeel.butt@linux.dev>, SJ Park <sj@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:08=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Reading /proc/PID/maps under per-VMA locks can skip continuously mapped
> address ranges during concurrent VMA splits or merges. This violates the
> guarantee in Documentation/filesystems/proc.rst:
>
> "If there is something at a given vaddr during the entirety of the
> life of the smaps/maps walk, there will be some output for it."
>
> lock_next_vma() reuses a tree iterator across calls under RCU. The iterat=
or
> remembers the range of its last entry. When its node is replaced,
> mas_next_slot() walks the tree again at the last index of that range, the=
n
> advances past the entry containing that index. If VMA boundaries changed,
> this can skip a range that has not been reported:
>
> - A lookup finds [A, C), then mprotect() splits it into [A, B) and [B, C)
>   before vma_start_read() locks the first VMA. The reader reports [A, B),
>   but the iterator still covers [A, C). The next call starts from B yet
>   advances past C, omitting [B, C).
>
> - The reader reports [A, B) and unlocks it. A concurrent mprotect() then
>   merges it with [B, C). On the next call, the iterator resumes at B - 1,
>   which now belongs to [A, C), and advances past C. Again, [B, C) is lost=
.
>
> Checking the mmap_lock sequence only within the next call misses writers
> that completed before that call began. Also, a NULL result is currently
> accepted without validation, so a race can terminate the walk early.
>
> Even a fresh lookup can skip a mapping. Suppose it finds a gap before
> [B, C). A writer inserts an adjacent VMA at the end of that gap, then
> merges it into [B, C), replacing the node. The lookup resumes at the old
> gap's last index, now inside the merged VMA, and steps past it. The
> original [B, C) remains mapped throughout. Repeating the forward lookup
> is insufficient: another merge can make it skip the same mapping again,
> returning the same later VMA or NULL.
>
> The fresh-lookup race also affects /proc/PID/smaps, numa_maps and
> smaps_rollup. Resetting the iterator after gathering each VMA's statistic=
s
> does not prevent a merge during the next lookup. Fixing lock_next_vma()
> also prevents omitted entries and incomplete rollup statistics.
>
> Tie VMA iterator state with the current mm and the write generation at th=
e
> point of last mm speculation in vma_rcu_iter, whose values we call 'rvmi'=
.
>
> This allows us to neatly abstract the existing priv->iter logic alongside
> query_vma_find_by_addr() which uses its own VMA iterator.
>
> Then, provide helpers that act on the rvmi - vma_rcu_iter_[maybe_changed,
> may_have_skipped]() to determine whether any VMAs may have
> been altered since last mm speculation.
>
> Additionally introduce vma_range_is_empty(), used by
> vma_rcu_iter_may_have_skipped(), to determine conclusively whether VMAs
> exist in a set range, needing to be traversed.
>
> Original fix generated by an LLM and sent by Josef Bacik in private, then
> amended by David Hildenbrand, and Lorenzo Stoakes added additional
> abstraction.
>
> Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vma =
lock")
> Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} u=
nder per-vma lock")
> Fixes: 0e985559d72a ("proc/task_mmu: read proc/pid/smaps_rollup under per=
-vma lock")
> Fixes: d9d1c2d81797 ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under=
 per-vma locks")
> Cc: stable@vger.kernel.org
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Overall the code looks correct bit I have a couple of questions below.

> ---
> Note that I decided it's best to defer any VMA iterator stuff to a
> follow-up - with the abstractions added it's clear what's going on and
> easier for backporting.

Ok. But once we get VMA iterator validation routine implemented, we
won't need vma_rcu_iter and its helpers, I think. Are you ok with the
fact that most of this change will have to be removed later?

> ---
> v2:
> * Took over the patch to make David's life easier :)
> * Introduced vma_rcu_iter tying the VMA iterator, mm and sampled mm seqnu=
m
>   together, and update lock_next_vma() + callers to use it.
> * Moved the sequence out of proc_maps_locking_ctx and the "must initially
>   be odd" requirement out of the header into vma_rcu_iter_init().
> * Added vma_rcu_iter_maybe_changed() and vma_rcu_iter_may_have_skipped()
>   to replace the open-coded speculation checks.
> * Converted vma_range_is_empty() to use a VMA iterator to be consistent.
> * Added Fixes: tag for d9d1c2d81797 (PROCMAP_QUERY), as per Jose.
>
> v1:
> https://lore.kernel.org/r/20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.=
org
> ---
>  fs/proc/internal.h        |  1 +
>  fs/proc/task_mmu.c        | 13 +++++-----
>  include/linux/mmap_lock.h | 22 ++++++++++++++---
>  mm/mmap_lock.c            | 61 ++++++++++++++++++++++++++++++++++-------=
------
>  4 files changed, 72 insertions(+), 25 deletions(-)
>
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 623bb43ede55..1d95ff577a06 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -393,6 +393,7 @@ struct proc_maps_private {
>         struct inode *inode;
>         struct task_struct *task;
>         struct vma_iterator iter;
> +       struct vma_rcu_iter rvmi;
>         loff_t last_pos;
>         struct proc_maps_locking_ctx lock_ctx;
>  #ifdef CONFIG_NUMA
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 74ffa5c99b8e..22361607020d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -165,7 +165,7 @@ static struct vm_area_struct *get_next_vma(struct pro=
c_maps_private *priv,
>                 return vma_next(&priv->iter);
>
>         unlock_ctx_vma(lock_ctx);
> -       vma =3D lock_next_vma(lock_ctx->mm, &priv->iter, last_pos);
> +       vma =3D lock_next_vma(&priv->rvmi, last_pos);
>         if (!IS_ERR_OR_NULL(vma))
>                 lock_ctx->locked_vma =3D vma;
>
> @@ -270,7 +270,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
>          */
>         if (last_addr && !addr_is_sentinel(last_addr))
>                 *ppos =3D last_addr =3D priv->last_pos;
> -       vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
> +       vma_rcu_iter_init(&priv->rvmi, mm, &priv->iter, (unsigned long)la=
st_addr);
>         hold_task_mempolicy(priv);
>         /*
>          * If seq_file had to flush its collected data right after m_next=
() set
> @@ -520,6 +520,7 @@ static struct vm_area_struct *query_vma_find_by_addr(=
struct proc_maps_locking_ct
>         struct mm_struct *mm =3D lock_ctx->mm;
>         struct vm_area_struct *vma;
>         struct vma_iterator vmi;
> +       struct vma_rcu_iter rvmi;
>
>         if (lock_ctx->mmap_locked)
>                 return find_vma(mm, addr);
> @@ -527,8 +528,8 @@ static struct vm_area_struct *query_vma_find_by_addr(=
struct proc_maps_locking_ct
>         /* Unlock previously locked VMA and find the next one under RCU *=
/
>         unlock_ctx_vma(lock_ctx);
>         rcu_read_lock();
> -       vma_iter_init(&vmi, mm, addr);
> -       vma =3D lock_next_vma(mm, &vmi, addr);
> +       vma_rcu_iter_init(&rvmi, mm, &vmi, addr);
> +       vma =3D lock_next_vma(&rvmi, addr);
>         rcu_read_unlock();
>
>         if (!vma)
> @@ -1421,7 +1422,7 @@ static int show_smaps_rollup(struct seq_file *m, vo=
id *v)
>         rcu_read_lock();
>         reset_lock_ctx(lock_ctx);
>
> -       vma_iter_init(&priv->iter, mm, 0);
> +       vma_rcu_iter_init(&priv->rvmi, mm, &priv->iter, 0);
>         vma =3D proc_get_vma(m, &pos);
>         if (unlikely(!vma))
>                 goto empty_set;
> @@ -1470,7 +1471,7 @@ static int show_smaps_rollup(struct seq_file *m, vo=
id *v)
>                         reset_lock_ctx(lock_ctx);
>                         /* Resume from the last position. */
>                         pos =3D last_vma_end;
> -                       vma_iter_init(&priv->iter, mm, pos);
> +                       vma_rcu_iter_init(&priv->rvmi, mm, &priv->iter, p=
os);
>                 }
>                 vma =3D proc_get_vma(m, &pos);
>         }
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 11b3ffef3966..9ccbbcbd7aca 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -17,6 +17,13 @@ extern int rcuwait_wake_up(struct rcuwait *w);
>  #define MMAP_LOCK_INITIALIZER(name) \
>         .mmap_lock =3D __RWSEM_INITIALIZER((name).mmap_lock),
>
> +/* Tie a VMA iterator to mm write lock state at iterator initialisation.=
 */
> +struct vma_rcu_iter {
> +       struct mm_struct *mm;
> +       struct vma_iterator *vmi;
> +       unsigned int mm_wr_seq;
> +};
> +
>  DECLARE_TRACEPOINT(mmap_lock_start_locking);
>  DECLARE_TRACEPOINT(mmap_lock_acquire_returned);
>  DECLARE_TRACEPOINT(mmap_lock_released);
> @@ -509,6 +516,16 @@ static inline void vma_mark_detached(struct vm_area_=
struct *vma)
>  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>                                           unsigned long address);
>
> +static inline void vma_rcu_iter_init(struct vma_rcu_iter *rvmi,
> +               struct mm_struct *mm, struct vma_iterator *vmi,
> +               unsigned long addr)
> +{
> +       vma_iter_init(vmi, mm, addr);
> +       rvmi->mm =3D mm;
> +       rvmi->vmi =3D vmi;
> +       rvmi->mm_wr_seq =3D UINT_MAX; /* Start odd so changed by default.=
 */

Why not initialize mm_wr_seq correctly using
mmap_lock_speculate_try_begin(mm, &rvmi->mm_wr_seq)? That way on the
first call to lock_next_vma() you won't be resetting vmi
unnecessarily.

> +}
> +
>  /*
>   * Locks next vma pointed by the iterator. Confirms the locked vma has n=
ot
>   * been modified and will retry under mmap_lock protection if modificati=
on
> @@ -516,9 +533,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_s=
truct *mm,
>   * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR if =
the
>   * process was interrupted.
>   */
> -struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> -                                    struct vma_iterator *iter,
> -                                    unsigned long address);
> +struct vm_area_struct *lock_next_vma(struct vma_rcu_iter *rvmi,
> +                                    unsigned long from_addr);
>
>  static inline void vma_assert_can_modify(struct vm_area_struct *vma)
>  {
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 83b7d3ded0dc..834bbf86e004 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -13,6 +13,8 @@
>  #include <linux/trace_events.h>
>  #include <linux/local_lock.h>
>
> +#include "internal.h"
> +
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
> @@ -428,21 +430,53 @@ static struct vm_area_struct *lock_next_vma_under_m=
map_lock(struct mm_struct *mm
>         return vma;
>  }
>
> -struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> -                                    struct vma_iterator *vmi,
> +/* Is there no VMA in [start, last]? */
> +static bool vma_range_is_empty(struct mm_struct *mm, unsigned long start=
,
> +               unsigned long last)
> +{
> +       VMA_ITERATOR(vmi, mm, start);
> +
> +       return !vma_iter_load(&vmi) && vma_iter_end(&vmi) - 1 >=3D last;
> +}
> +
> +/* Might the VMA tree have been modified since last mm speculation? */
> +static bool vma_rcu_iter_maybe_changed(const struct vma_rcu_iter *rvmi)
> +{
> +       return (rvmi->mm_wr_seq & 1) || /* Odd implies write-lock. */
> +              mmap_lock_speculate_retry(rvmi->mm, rvmi->mm_wr_seq);
> +}
> +
> +/* Could the VMA iterator have skipped a VMA due to the tree changing? *=
/
> +static bool vma_rcu_iter_may_have_skipped(const struct vma_rcu_iter *rvm=
i,
> +               unsigned long from, unsigned long to)
> +{
> +       return vma_rcu_iter_maybe_changed(rvmi) &&
> +              !vma_range_is_empty(rvmi->mm, from, to);
> +}
> +
> +struct vm_area_struct *lock_next_vma(struct vma_rcu_iter *rvmi,
>                                      unsigned long from_addr)
>  {
> +       struct mm_struct *mm =3D rvmi->mm;
> +       struct vma_iterator *vmi =3D rvmi->vmi;
>         struct vm_area_struct *vma;
> -       unsigned int mm_wr_seq;
> -       bool mmap_unlocked;
>
>         RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
>  retry:
> -       /* Start mmap_lock speculation in case we need to verify the vma =
later */
> -       mmap_unlocked =3D mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
> +       /* Only trust the iterator's position if the tree cannot have cha=
nged. */
> +       if (vma_rcu_iter_maybe_changed(rvmi)) {
> +               vma_iter_set(vmi, from_addr);
> +               mmap_lock_speculate_try_begin(mm, &rvmi->mm_wr_seq);
> +       }
>         vma =3D vma_next(vmi);
> -       if (!vma)
> -               return NULL;
> +       if (!vma) {
> +               /* No reason to fallback if nothing left in range. */
> +               if (!vma_rcu_iter_may_have_skipped(rvmi, from_addr, ULONG=
_MAX))
> +                       return NULL;
> +
> +               rcu_read_unlock();
> +               goto fallback;
> +       }
>
>         vma =3D vma_start_read(mm, vma);
>         if (IS_ERR_OR_NULL(vma)) {
> @@ -471,14 +505,9 @@ struct vm_area_struct *lock_next_vma(struct mm_struc=
t *mm,
>          * installed ahead of it. Otherwise we might observe a gap that s=
hould
>          * not be there.
>          */
> -       if (from_addr < vma->vm_start) {
> -               /* Verify only if the address space might have changed si=
nce vma lookup. */
> -               if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr=
_seq)) {
> -                       vma_iter_set(vmi, from_addr);
> -                       if (vma !=3D vma_next(vmi))
> -                               goto fallback_unlock;
> -               }
> -       }
> +       if (from_addr < vma->vm_start &&
> +           vma_rcu_iter_may_have_skipped(rvmi, from_addr, vma->vm_start =
- 1))
> +               goto fallback_unlock;

Before this change we fell back only if the new search yielded a
different VMA (the vma !=3D vma_next(vmi) condition) while now we
fallback unconditionally. Note that the VMA that we are rechecking is
already locked, so it can't change. Was the previous logic invalid?

>
>         return vma;
>
>
> ---
> base-commit: 33dbd62d6ff310b8cce8c70101639a6eddbb1b52
> change-id: 20261027-fix-proc-pid-maps-missing-vmas-c870d14e1ca9
>
> Cheers,
> --
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
