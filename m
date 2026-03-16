Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D41381AEF
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651176; cv=pass; b=ZxtCMc6cvgkXsfjSfTqTNXa60pYqYzmFtdFtJW9yIrMULPL0z6ZAU1WUcqCabzzjR4tMxz1I7BMpfrfZeuEBTlTKSY0lCzXC2+DQhXEf4v4MNhB6nhIH6pHTf1vUDjNwBWp9zxjYFcZx6mNCpMokyM6MeGR/C9mKKkSQoe0IoEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651176; c=relaxed/simple;
	bh=Mn82pVDcs90w9AUEhGMoN/Zt7NOLFw9sdvlXd4YJrjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbJdbrVkTEj3g9Tp9Kd7RDXEZISAcA6PdUItwTnvHo77xccODPmN3v6nTElh8XqLIg+Q484ry+j2IxOXi8iuYfh3e9yDxTRL7RyPKLOXI6eey2LQz65SIyBG2EoO9kVzEvPtIrhP03F0vfu5dlLfBa8xbh70VOZQOg1F5AglgjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+14yXpB; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+14yXpB"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a535e7c00so4351647b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 01:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773651174; cv=none;
        d=google.com; s=arc-20240605;
        b=W6GdlIaIhnAa4ICARdHUBTlOCPDqM6Fpi++UM3n+swzYr5OX3sghOHVv9RLre/cpdf
         N+ZAr36Se1vkPpbGZdXMxZemTdktkfzPaduAs3Bp+NTh/yiT7rLnMEwBNFsk7hURrJcG
         Phs0Kp4Ll7aAJ6pQpcylS50Wt8uumXsaQtdOyj9FW+i3o07+LgIUqgUufPFSsJdlCnQD
         Fcn3fhdT/TZEIQXoJD2VtwL9xJ1sLp4q0rOfY+AXUYmI42FxUnst/oaGEGpyW/0HagT3
         sojQby5tCCmuhEQLjipWoNyADWMbfu79hDnRqEKOEs/Wd3Qb25uXjJqfmWEy8qL5IPu+
         YPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQaSu+BjQS/9yOvHvEB6hQChFTLVczOI9UX4qDJfUaQ=;
        fh=Gf5RvXKgrIWcE8l1yArovQ1fPIsAt25Klxp7QaRFYew=;
        b=ChCpdOb1I/6jhvhVSH9CvahSyfTJlIqbnkTddj1U6bCF+cChB5UiYAcS5VPNvZTSSD
         6KNd+X+SzYRVJdvzK75iLOrI4bbvJV+ebRKtpEqh6hlua5z45No7HuaENV+nsYHxZBxV
         4n3BJqYkB6pVkBCAeQpdxeaTi1ADaR2DafoX4Nv3j9Y0kokTJw6bo6hroNoEWDKKSnw2
         /8n822qchDp3YlLUEKbCa7dVbNtIh5KKbrFIb9IBHRPGZ/w3PAg1qeF8WE8O7V5uJ3/T
         A5ulanTZhEMkJgRHseFCIy6YK0LuwKDVNmcI2hUBZoRcRiP6f8t/6zADgBfXTPbz+bbF
         oTsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651174; x=1774255974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQaSu+BjQS/9yOvHvEB6hQChFTLVczOI9UX4qDJfUaQ=;
        b=K+14yXpBq8hobOqq5LP3BUmHpuLPBWWBpstiVwAZDkSWymcuO7mbfeOw6pMm503Asq
         hSbic78VaZi8HDLJDlOWT6cQHnB+mOzcs552uqxgAjqJFS+azeXiFdATMjt1TGmygRgO
         Ua2zcF3dOMicWcYepp06qK62t02XbhK8ujWpm+m7K1ROVLTDY8GSmN8jVShcVVQNVL8p
         upjjmyG6mvOy09feZoEurY3m3AcouNz/rZjdWywcNuOQH4p23VSj89iamz8mBWornIlY
         XPO6qw5no/rhyIOdGgYGnhnqZ3zJnKg/PhY6G4OKStAEjW0PpacxMK7TXwkoAeVhXkHF
         aYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651174; x=1774255974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQaSu+BjQS/9yOvHvEB6hQChFTLVczOI9UX4qDJfUaQ=;
        b=rnc+ajIltiHIRDGllw9tB1z68x4xyvVwEDt5u7PgIweNS7Dk2oQRvvj1zQuyc/J2b0
         b/vZvjn3FwrKeqAKhtOuav6JSeCiTEnSdnJVtiUZFRi/rwRbJMbPkD9h8YqNVbXqw2qa
         fzHBNstb7ssmUYYgmn4+uk9RTZqFzo4VFj8CvzjmGj6iI0Ob7qZzljEFBKie90U+rbeX
         n9UeR3xV3/NQaAi04cusaLGdY5cyur+kR0szjqR1gbv9ZrDpedQHcfxGXnTvA9Oz/Bh0
         ITLWouByXbyS2Jt9BpBnMqVms/p8/1DDfSeehKI+56MpR/Nc6giu+2G/Tta24Vwqp5Ta
         qMbA==
X-Forwarded-Encrypted: i=1; AJvYcCVA/7IrZGeGvEKNpJDTpxZK6lwRqqT5I5es0dIIu51VnvcdsdPHbWIDckbvmlc9bs1K6gsmkED9IM3+vOZx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kc5YqJjvlj4MRKWnSevugabQYcWXCCCNGt2jVbhKGAbhi2Jh
	GNZaKjmS0/51OH3gA7rjYTFf92RyiCCIij5w/rDjhtSo+wy6IrFa/cjf3hmMk4/aGOY4xz0bYq4
	0vAaTtckem4TtGWMfwATl9aoLLelqnKM=
X-Gm-Gg: ATEYQzwmD5TtGAaMH3MQQr8gO8vsNTyeR0C2JQepkWgethOfMr+r9xJW7wfsiCtOI2M
	5OlpS1i4pNTRgLarQ7ddGrmicL9ObsSyQT38lIT3623hMGqrt4L0IBpzKZcpT6Jo/IC1He5C9HH
	4ScjHGIR/HdxfhUnxxHyCnH1G/ABQsx0YHcaYF1jsAo1dsx72BgZM42wL/7sFJx3iKuIHyPXGHw
	vapZMgoDxxXsHBWcA4woECji5etgylx8hj8x36LrjfuVshoGCk6t+XhYy/vSgMUh8BZDRz2Gwg1
	n+EGhnk8y1uRWXCps+G5admgfSt4fJ1w9B6rJFcTDmJ3eZLqJLGqARks1tOKjcwyH52//dG71Hg
	aaPTKM5s=
X-Received: by 2002:a05:690c:13:b0:798:6756:31cd with SMTP id
 00721157ae682-79a1c1dd661mr125880507b3.53.1773651174047; Mon, 16 Mar 2026
 01:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306171815.3160826-5-rppt@kernel.org> <abe1FHyYinvfLYnw@hyeyoo>
 <abe15T7cA1B9lG4F@hyeyoo> <CADhLXY5ydBZL5gUQZCJnSTgc=8U0Xhaj_BtvgdBtPSmWh3NTEA@mail.gmail.com>
 <abfA-AR--cvpcz5v@hyeyoo>
In-Reply-To: <abfA-AR--cvpcz5v@hyeyoo>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 16 Mar 2026 14:22:43 +0530
X-Gm-Features: AaiRm518IFBKe3PCGNQ5k_DQwitYZlzdh5gs0YPek1tk1O9KIu8wqr_ZBBDSHBM
Message-ID: <CADhLXY5h4fNVXbxP7ZU3Jq+Yjwtm8t9mkSyRC-uOwRvSdQYJ7A@mail.gmail.com>
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

On Mon, Mar 16, 2026 at 2:06=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Mar 16, 2026 at 01:35:38PM +0530, Deepanshu Kartikey wrote:
> > On Mon, Mar 16, 2026 at 1:19=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com=
> wrote:
> > >
> > > > It seems there's another attempt to fix the syzbot report from
> > > > Deepanshu Kartikey [2], which I didn't take a deeper look.
> > > >
> > > > At first look [2] looks a bit wrong way to fix to me though,
> > > > because it allows operating only on a single VMA nothing should rea=
lly split
> > > > or shrink the VMA if somebody is holding the VMA lock in read mode
> > > > (and the validation of the range is done while holding the lock).
> > > >
> > > > [2] https://lore.kernel.org/linux-mm/20260316070039.549506-1-kartik=
ey406@gmail.com
> > > >
> >
> > Harry,
> >
> > You are correct that once vm_refcnt > 0, nobody can split the VMA.
> > However the split can happen in the race window BEFORE vm_refcnt++
> > in vma_start_read(), and CHECK 2 can miss this if mmap_write_unlock()
> > completes before CHECK 2 runs.
> >
> > Here is the exact race:
> >
> > vma_start_read():
> >
> >     /* CHECK 1 */
> >     if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.se=
quence))
> >         goto err;
> >
> >     /*
> >      * RACE WINDOW: vm_refcnt is still 0 here!
> >      * UFFDIO_UNREGISTER can run:
> >      *
> >      *   mmap_write_lock()    -> mm_lock_seq =3D 11
> >      *   vma_start_write(vma) -> vm_lock_seq =3D 11
> >      *   __split_vma()        -> vma->vm_end =3D 0x4ca000
> >      *   mmap_write_unlock()  -> mm_lock_seq =3D 12
> >      *
> >      * writer completes entirely before vm_refcnt++!
> >      */
> >
> >     __refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, ...);
> >     /* vm_refcnt =3D 1 now, but vma->vm_end already modified! */
>
> It is true that vma->vm_end might have changed before acquiring the vma l=
ock,
> but it doesn't matter as long as you verify the range after acquiring
> the lock, no? (that's what uffd_mfill_lock() does)
>
> You're not really supposed to read vma->vm_end before acquiring
> the vma lock and use the value because nothing guarantees that
> the VMA is stable until the lock is acquired.
>
> Or am I still missing something?
>

Harry, you are right. The real bug is state.len =3D 0.
I withdraw my fix.
Thank you for the explanation
