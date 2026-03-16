Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E9A24E4AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648352; cv=pass; b=iFxS7ZQuKpxgfX2SYTsWVNbBFVm4PS+710/em3AcqneKpDnoE0xJ3hmsV9CHV+ZrnotjpEX5jemZ9qiL38tbuhxo7VXx5f/gHct8zImD2xYL7zC1kW642KOKsgLuxUxDvjkPC3EF23HhfUiswO5e9X57UJCuU8dZTwi7W2/7fmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648352; c=relaxed/simple;
	bh=bdScPVnsSaD+D5rBbEd4IKRSFhQUqItHVl2QejrINfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaRi1Ql/PDQfXulnIze8xHuyMo/OdUu0Viuih6hbTl3XYhoWi+n08rJgi1NH2pntzW0FM6Wn/7MNDxYBVXATvZyGwG96dA0IIpWteXM6z6ntuXoDeTpmTZEr+CwZEcbOe6Z4xrIxulbMgag4GP5MGmu29Y83WWWng8YRjRiJkBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuSwyXkl; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuSwyXkl"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so4024467d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 01:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773648350; cv=none;
        d=google.com; s=arc-20240605;
        b=l0y1KyUyC68eKHO3DL9RWmx1FZRdZJnby3rjucOHA2wCHtm6daEmgFBEFaREb7j13j
         t2cIaJWpUq4JiUFspKO28ZKt+EAFwuI80ReZ77wEvaa6C5rQ0r3loSSWWphrQkPVlX2o
         EBJQKSEEP69mGadE6IrcmglYvIlUPDBI5O0Rs8tk9ki9+CGmjQBKw/6jC2fJzH0+R79g
         OAgX2n1ZpnyapgiOIF4XYQU2JqeQHJaLZvYGRQ97BSvyK07wvl0PJ9J47SCM5INF/koc
         2E+Lq4LWMlTgg9afdymEywKmQaJGy4Isgrjfl8HZXyXAPRBodI7JaWllo9/p203/mbLF
         vZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntlsUflN+hnqA9YBuYkxoTPzbyNwVTClPHMLwCnFBWc=;
        fh=LCG7+/Zj3lFuEPB1XbQhTZmzyY1rrpVM+n/vgoqpbLw=;
        b=WHc/UdMsGX1wCZK62+a57EFNNawbsPuOpqLCKr72Zjg0Sy4Sar/vKmEKg9PKDpdGHt
         ErQSYoQ7sIfvNtCvj0cNy2xMYfIzuJjyh3swoHZ4QagI4V5kEQaSkpLWjSzKFIiGUwDY
         6YAA78wNUazblblHWViVyeBq4cvHtDVEouODUOsyO4slU6kYkVeGI7sVVaTU4163eugK
         qCi6qE4xlACR+ixc2ewNbzbDswn2KF4kEyZ37vDPRbxNHDAl+CB0ohFuA2PqspBo2Pcg
         2/cQDKc7KlAc9N9tJnE5wfb374ltNgFm78VC4VkzBSi5uEN6sWQ8kCt8sXmKNC7LhDIz
         YW3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773648350; x=1774253150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntlsUflN+hnqA9YBuYkxoTPzbyNwVTClPHMLwCnFBWc=;
        b=FuSwyXklUE/poytXURUHX/DPQ1FTJfK6frPQRRVIrgta/Y4hU4hwwj03fNcY/ecnU3
         jb94vHMIWfZyrkiinHkoaIbYNa+Fy/gd6imhppOgtsa+JZX0pjUv2nP6WPaWa2NWjgot
         wk+Q6yzdnsXo8xIz+hFB4epdRP6LtLlxz57aX/MKn1ZjYrt4WeX11NhLidJ0wc4VXETO
         I3ekAmw2vKA2f7H813ZcK9uOgeTnKfImab4Z8Cqu7sqzyaSgNCKmteIYBCS3CFC6xMpW
         GWg40cQ1fm7wXAtKy4suZFX08HbRTvIaojdJ8ikAtoDE3pIAE5mhOZap4tvtkSUtqBMO
         oCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773648350; x=1774253150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ntlsUflN+hnqA9YBuYkxoTPzbyNwVTClPHMLwCnFBWc=;
        b=aBT6HrA35kUYkPifCKZPrOd0qbuj+h8EzLtZKYpSl/5XW0LQ11pcQbPuDRGVVOESDx
         twj3vTvhiRXwG7GZCKOzBhJs/KW/2iZrutxMtPI9WxpMR5EGtCwybicswYm027b/BtZB
         v60k2f73zQeBad/thdXyBUu48VEXGqQOOYbqDMh5bXMGYo1Si3MDatOlQVaKiCLe+JFP
         xjgNmwLjFnyJyQfBvgjIV+FLkXu6PYYhtHqEg+CvfqjFbPxMcGTC1C4lTm/LKTS0AIkP
         636lwLsyK9vFTNOIrOBFfvgnkwt4P5X5Zw/gaESVNNiDt1uUGzwcXJYkIs+35VeMaNQs
         dr+A==
X-Forwarded-Encrypted: i=1; AJvYcCXx+Su8E1SVUki3plztHt8B0NBP829FwzPQykQyDP6sGke3m7EFY5O7KVVxm0HeFDrw5/fnfkc9/zfRGOSj@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/kTXPLN2QmEdC5fmrTGm8VV81cqUQi9SxShjWQnxks+JwpUu
	0KPKW+AvTK7xeJ+OXRxPXwP5mL9rhsXE3GHDiiMs7e7h38T8pECqB6SgTybCA5arttZCnAxTtkZ
	zFLDsxZ+ePGVlF7q9DNPCuut1zb+exLE=
X-Gm-Gg: ATEYQzwST0I1SzehDuLDzCdNhyZqDu964sdU5C/2w6MepcHouA7NwTzUsy3oRt1SsFi
	COrN6wCzdiXzLhyHZ7mMRkvtAW0Od/PQs/coHJicSBEi40+WhbzKtqNQ/j1Y4DOaeYc8J8bQByJ
	l4Bv7QUgDC5T2clYArfGXSBSe+AX+t3W6TU+ucyMf32ComSI5KC1yL7C0tTIxQAF6yCfYwpekBD
	D2T03xLX3ZTdopCLDxk3pfatQ6azd/QWroDaLosmgeNq2MqvsSyJZ9q4319XQY9/LayyxIMyvZK
	cT0N1SLXEF2wQ3v438N50FAiq1EHPh/yhnWfd/2YxFAjkfmT9r4KHvUGGMIdxVFQ2bkpwoOL
X-Received: by 2002:a05:690c:c50f:b0:79a:3cea:9153 with SMTP id
 00721157ae682-79a3cea9472mr55394387b3.13.1773648350077; Mon, 16 Mar 2026
 01:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306171815.3160826-5-rppt@kernel.org> <abe1FHyYinvfLYnw@hyeyoo>
 <abe15T7cA1B9lG4F@hyeyoo>
In-Reply-To: <abe15T7cA1B9lG4F@hyeyoo>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 16 Mar 2026 13:35:38 +0530
X-Gm-Features: AaiRm53AvxoTI5kbBO9SnbBGaJXcRPFivylwR41z7fGjYuzu7XmFh4zaFD0j-wk
Message-ID: <CADhLXY5ydBZL5gUQZCJnSTgc=8U0Xhaj_BtvgdBtPSmWh3NTEA@mail.gmail.com>
Subject: Re: [PATCH v2 4/15] userfaultfd: introduce mfill_get_vma() and mfill_put_vma()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	James Houghton <jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Edward Adam Davis <eadavis@qq.com>, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 1:19=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> > It seems there's another attempt to fix the syzbot report from
> > Deepanshu Kartikey [2], which I didn't take a deeper look.
> >
> > At first look [2] looks a bit wrong way to fix to me though,
> > because it allows operating only on a single VMA nothing should really =
split
> > or shrink the VMA if somebody is holding the VMA lock in read mode
> > (and the validation of the range is done while holding the lock).
> >
> > [2] https://lore.kernel.org/linux-mm/20260316070039.549506-1-kartikey40=
6@gmail.com
> >

Harry,

You are correct that once vm_refcnt > 0, nobody can split the VMA.
However the split can happen in the race window BEFORE vm_refcnt++
in vma_start_read(), and CHECK 2 can miss this if mmap_write_unlock()
completes before CHECK 2 runs.

Here is the exact race:

vma_start_read():

    /* CHECK 1 */
    if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.sequen=
ce))
        goto err;

    /*
     * RACE WINDOW: vm_refcnt is still 0 here!
     * UFFDIO_UNREGISTER can run:
     *
     *   mmap_write_lock()    -> mm_lock_seq =3D 11
     *   vma_start_write(vma) -> vm_lock_seq =3D 11
     *   __split_vma()        -> vma->vm_end =3D 0x4ca000
     *   mmap_write_unlock()  -> mm_lock_seq =3D 12
     *
     * writer completes entirely before vm_refcnt++!
     */

    __refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, ...);
    /* vm_refcnt =3D 1 now, but vma->vm_end already modified! */

    /* CHECK 2 */
    if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&mm->mm_lock_seq=
)))
    /*
     * vm_lock_seq(11) =3D=3D mm_lock_seq(12)?
     * NO! writer already finished and unlocked!
     * mm_lock_seq incremented to 12 (even=3Dunlocked)
     * CHECK 2 MISSES the race!
     */

    return vma;
    /*
     * returns split vma with vm_end=3D0x4ca000
     * but vm_refcnt=3D1 (lock held)
     */

Now mfill_atomic loop runs with split vma:

    while (state.src_addr < src_start + len) {

        /* iteration 1 to N: dst_addr =3D 0x1b1000 to 0x4c9000
         * all within vma->vm_end(0x4ca000)
         */

        /* iteration N+1: dst_addr =3D 0x4ca000 */
        err =3D mfill_atomic_pte(&state);
            mfill_atomic_install_pte(state->vma, dst_addr=3D0x4ca000)
                folio_add_new_anon_rmap(vma, 0x4ca000)
                    VM_WARN_ON_ONCE(address < vma->vm_start ||
                        address + (nr << 12) > vma->vm_end);
                    /* 0x4ca000 >=3D vma->vm_end(0x4ca000) -> WARN! */
    }

Without my fix:
    CRASH at folio_add_new_anon_rmap

With my fix:
    if (state.dst_addr < state.vma->vm_start ||
        state.dst_addr >=3D state.vma->vm_end) {
            mfill_put_vma(&state);
            state.dst_start =3D state.dst_addr;
            state.len =3D dst_start + len - state.dst_addr;
            err =3D mfill_get_vma(&state);
            if (err)
                break;
    }
    /* catches split, re-lookups correct VMA safely */

So both fixes are needed:

Harry's fix (state.len):
    fixes state.len uninitialized
    mfill_get_vma validates correct range
    in the first call before loop

My fix (bounds check):
    catches split VMA that slipped
    through CHECK 2 during loop
    because writer finished before
    CHECK 2 ran
