Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4CC8CE
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774217065; cv=pass; b=FOpi/O8BERxDi4Hlh+pR3BJpb1CsN/pizViJOHk2owlpm8lHR/IL1Ev7PYh0z/l0niMcmOUFVzeQdBK6NXO4kHNDvUYwVs5fsukInPuSqPFpBsp1T4IOvJOfIV4ovfuTMM9rWdYBtq2oP8BPazmZK8KgM5DCUwQKAjRWlHZLnzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774217065; c=relaxed/simple;
	bh=MLCxEQ/b8VgVfmVLghOwkZQLgpaURmzol5lerp53moc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNddVAuVlE2mkkMkSfgPUX8ghGpY/nZKoXyNsm4hebixulilXyVDZK1fH8RQytMmhmn9AeaMwN+nsTxHqPDoxHPYuigAfKhKRz5aVU5xst8H1zzuaMisOqDlaToKCEaCJ13aAkdKh5s/Rl1hZx6jyP7QNhCYzIyMBT00mChaRTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TMDpyd23; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TMDpyd23"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852ef20fe8so93295e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 15:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774217062; cv=none;
        d=google.com; s=arc-20240605;
        b=FVUqdL3xpb+k8UmUb25D+8t/DtIp7LhuI+mlvLWTud6urDjZADwK5s/Hhff7A35t+5
         YVgKgec9zqBF7eh9VqUZLKcNCNkILoTZTEiRVIiEg7lU0ArfY973v5Zhv9SjkgLcJat7
         lS7aBT8meVSDQ3kfuquC2AImylWBaJi704cItdDFTpjNlHpHkkv1hyIStRlvPhznfDPt
         RpfnZFkbUfBxQ9egXSjXwMvQyLd44uGWJItV+rv5rTmi1cUZQLkLgt2gFWSbiLPK/Gbw
         mYCqthcCCfcRmq8bgPKWNx5G9R5UtJRFINWk9bVBVfnp6DbrPoGk0fPaw2zWJx9GBqZG
         XD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ri4lHYfJVw85l/96eAcQUjigQAVRnpKam0B4k1gAuzo=;
        fh=Hqk6/pevAIgDC3dFlnZHNSKmDY25Y/mkls1p40q3q1E=;
        b=PDRm4bVWh10btmq0owsEJwGXbcHpzwjToB2HuAy9KkQZ/BdmJuRp+q9Q7KUpo2s3qS
         oQQMOPzz8GwzaZfPeqbtQw2S7nsKYEIjP+uzjZxP6o6a4FdT/EyoNooFEQP9eLj/nZKv
         bOvjDP4y2MLu7DFeuoWhVmbOmmIV69N9fn+fWy656cwvBOkV+wRoMN+wZ8bx3s+b5Sog
         Y3mGWD7wn9bfAwHRI7pfHHNGnmpK0kfi+3XRAsvRP5d3gNOoKFeUFIGARBEn2yA0VbXF
         4SywoU3NWXyUVD1hzGlx0ZxMOE9JtMM8i2VrNoyjdfULEuLVoaDVBJ0ANRWmGOK79nfw
         rhoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774217062; x=1774821862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri4lHYfJVw85l/96eAcQUjigQAVRnpKam0B4k1gAuzo=;
        b=TMDpyd23JuI2J9UGmkbXjQngFk/zNawnGS7d0J88CuDg5oSQvcT+CDY2EPGcwYckmv
         TLrO8ZWYxMkZgZLsrD07F6vNZ1drG8URqKm13mU2/GgEzrVGXhmxztX6MP0uwkCMPh7F
         QlIh7mCCL2tS75Kdad10SPTdNIMWYggDr3+ilxyxVqaRHmlO34uDIIv5qlbIOun4cKS0
         met+IELBwoVDnm8OLBLknivUdLuGxXoF6ndHdyiCsXBeHEznlblpUmYgZJzShyW9/WRW
         UP4ubNRIYfVvKwI6tYmnjETcW/O1yUb9mb8XLbvYwDetwXMU7ypuJRRuPKGgNRbNNDmM
         sQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774217062; x=1774821862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ri4lHYfJVw85l/96eAcQUjigQAVRnpKam0B4k1gAuzo=;
        b=NVSQQdzyv6Uvr/enTAGSpg9DXtyA5dpj40ofWnEjjNzRM4145t4la9MzYHTYuheh+p
         j9/2cxy95XEY+nlleIYdPZWbBW83v2GxD4dnIJxR9ot/X0R7BCxP9U4r1sfBlmJp2nE+
         Pqr5VsOXDyl9ggqJlqDpJcENMQkzBb9zmpCeMLbjp/pS3UsbiZi0h2JnR+giLFJZDsK1
         3HPuaVwM3j3IfrX3pZTGYoA2KedbI6NQSHsxG8I5kRF+nevhMBK4a+NjukK+XBOWcsjK
         JZ6jFta96Cn1Dm57xOMjLjt74zT+hrlAoByfK9ME2x8A12kZ2NxfPAOczmLGPflQHjch
         imMg==
X-Forwarded-Encrypted: i=1; AJvYcCWYe4SSXjCancAtL03IWOBzxUnXpNnO/juRK29TYha95Q08vw+fI0dfkOZyiwh+78aKnrSXbf7pGCnyv7Tp@vger.kernel.org
X-Gm-Message-State: AOJu0YxVI1R5h35H9OjGwa5oKRLT9oAUd/5bf5xsNINHn+yATOmdxYzK
	uxfLvev24rCsnL1ftv7Gf/QegaUQQhlQSjoTo1nvgTIB+mbdrpvJkk3tQdjBpeq1pDz2KTWiwsm
	+dKbd4WkcKJ3AAuwFDY5qC2NoXV5BGDD8KER0tz3b
X-Gm-Gg: ATEYQzzSp/9PXwpRnJa7Kdtfo0kTVx5VhwRIi0iRrSwfoycsPRJnCM1uv/ukkrb/huA
	mv3GQFzyiNsXzpjX190YCVSSWQivejHHFLiyLQHm02DixzLpe5dq9j5kxUmP/qiXYrOOnwG30jh
	RcaJ04lSiu81Ru/M2/WiIM3iwgIur+E7inhoVtnKiMPYpR2YhDrg8J1pm5nVC99aJhFWLdrMuN7
	wDLREQAQkQJlxVvEzOkKEgLALgmGQRokQTFwkm3+XsVcN8Wa9xjaB2H4IUcb5O0RQqvoTAIvKkS
	GSd2MnbZ/TkqDcLF7Tzuz0cLbWrUTHNXKJOeU71l
X-Received: by 2002:a05:600c:3f1b:b0:485:b6e4:9808 with SMTP id
 5b1f17b1804b1-487037d0152mr1453745e9.1.1774217061445; Sun, 22 Mar 2026
 15:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com> <20260203192352.2674184-2-jiaqiyan@google.com>
 <7ad34b69-2fb4-770b-14e5-bea13cf63d2f@huawei.com> <CACw3F50PwJ+sSOX0wySQgBzrEW2XOctxuX5jM37OG0HS_kHdbQ@mail.gmail.com>
 <31cc7bed-c30f-489c-3ac3-4842aa00b869@huawei.com> <CACw3F50BwnLJW75EXgz0t5g+eUhr+wKgJ3YfRFq5208N5KfaiA@mail.gmail.com>
 <a0d25caf-a18b-e3d8-e74f-fc18fa85252e@huawei.com> <CACw3F51+bAm03nvucV54bkThnYc-4ewgqGzq_c5i6oMmnGdEtw@mail.gmail.com>
 <a3ff8c7b-69c1-fecc-3564-ecaa3e8a7e67@huawei.com> <CACw3F53qr1Af=r__SNxU1ohr69s8apHqHz9tcEHg1hDSLsk5TQ@mail.gmail.com>
 <6b304954-f3d1-5581-5937-1464caf85ab1@huawei.com>
In-Reply-To: <6b304954-f3d1-5581-5937-1464caf85ab1@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sun, 22 Mar 2026 15:04:10 -0700
X-Gm-Features: AQROBzAlS6RIdu-V0p3Jh22np-9jp8KFNc2vnNHVizPj2auHNAlaES0cJT1KD3g
Message-ID: <CACw3F52K3TTjtmaEsWLcei_ThKwHyn8xj=_4-vpiZhd-ciFU2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: memfd/hugetlb: introduce memfd-based userspace
 MFR policy
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	william.roche@oracle.com, harry.yoo@oracle.com, jane.chu@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 7:21=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> wr=
ote:
>
> On 2026/3/9 23:47, Jiaqi Yan wrote:
> > On Mon, Mar 9, 2026 at 12:41=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.co=
m> wrote:
> >>
> >> On 2026/3/9 12:53, Jiaqi Yan wrote:
> >>> On Mon, Feb 23, 2026 at 11:30=E2=80=AFPM Miaohe Lin <linmiaohe@huawei=
.com> wrote:
> >>>>
> >>>> On 2026/2/13 13:01, Jiaqi Yan wrote:
> >>>>> On Mon, Feb 9, 2026 at 11:31=E2=80=AFPM Miaohe Lin <linmiaohe@huawe=
i.com> wrote:
> >>>>>>
> >>>>>> On 2026/2/10 12:47, Jiaqi Yan wrote:
> >>>>>>> On Mon, Feb 9, 2026 at 3:54=E2=80=AFAM Miaohe Lin <linmiaohe@huaw=
ei.com> wrote:
> >>>>>>>>
> >>>>>>>> On 2026/2/4 3:23, Jiaqi Yan wrote:
> >>>>>>>>> Sometimes immediately hard offlining a large chunk of contigous=
 memory
> >>>>>>>>> having uncorrected memory errors (UE) may not be the best optio=
n.
> >>>>>>>>> Cloud providers usually serve capacity- and performance-critica=
l guest
> >>>>>>>>> memory with 1G HugeTLB hugepages, as this significantly reduces=
 the
> >>>>>>>>> overhead associated with managing page tables and TLB misses. H=
owever,
> >>>>>>>>> for today's HugeTLB system, once a byte of memory in a hugepage=
 is
> >>>>>>>>> hardware corrupted, the kernel discards the whole hugepage, inc=
luding
> >>>>>>>>> the healthy portion. Customer workload running in the VM can ha=
rdly
> >>>>>>>>> recover from such a great loss of memory.
> >>>>>>>>
> >>>>>>>> Thanks for your patch. Some questions below.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Therefore keeping or discarding a large chunk of contiguous mem=
ory
> >>>>>>>>> owned by userspace (particularly to serve guest memory) due to
> >>>>>>>>> recoverable UE may better be controlled by userspace process
> >>>>>>>>> that owns the memory, e.g. VMM in the Cloud environment.
> >>>>>>>>>
> >>>>>>>>> Introduce a memfd-based userspace memory failure (MFR) policy,
> >>>>>>>>> MFD_MF_KEEP_UE_MAPPED. It is possible to support for other memf=
d,
> >>>>>>>>> but the current implementation only covers HugeTLB.
> >>>>>>>>>
> >>>>>>>>> For a hugepage associated with MFD_MF_KEEP_UE_MAPPED enabled me=
mfd,
> >>>>>>>>> whenever it runs into a new UE,
> >>>>>>>>>
> >>>>>>>>> * MFR defers hard offline operations, i.e., unmapping and
> >>>>>>>>
> >>>>>>>> So the folio can't be unpoisoned until hugetlb folio becomes fre=
e?
> >>>>>>>
> >>>>>>> Are you asking from testing perspective, are we still able to cle=
an up
> >>>>>>> injected test errors via unpoison_memory() with MFD_MF_KEEP_UE_MA=
PPED?
> >>>>>>>
> >>>>>>> If so, unpoison_memory() can't turn the HWPoison hugetlb page to
> >>>>>>> normal hugetlb page as MFD_MF_KEEP_UE_MAPPED automatically dissol=
ves
> >>>>>>
> >>>>>> We might loss some testability but that should be an acceptable co=
mpromise.
> >>>>>
> >>>>> To clarify, looking at unpoison_memory(), it seems unpoison should
> >>>>> still work if called before truncated or memfd closed.
> >>>>>
> >>>>> What I wanted to say is, for my test hugetlb-mfr.c, since I really
> >>>>> want to test the cleanup code (dissolving free hugepage having
> >>>>> multiple errors) after truncation or memfd closed, so we can only
> >>>>> unpoison the raw pages rejected by buddy allocator.
> >>>>>
> >>>>>>
> >>>>>>> it. unpoison_memory(pfn) can probably still turn the HWPoison raw=
 page
> >>>>>>> back to a normal one, but you already lost the hugetlb page.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>   dissolving. MFR still sets HWPoison flag, holds a refcount
> >>>>>>>>>   for every raw HWPoison page, record them in a list, sends SIG=
BUS
> >>>>>>>>>   to the consuming thread, but si_addr_lsb is reduced to PAGE_S=
HIFT.
> >>>>>>>>>   If userspace is able to handle the SIGBUS, the HWPoison hugep=
age
> >>>>>>>>>   remains accessible via the mapping created with that memfd.
> >>>>>>>>>
> >>>>>>>>> * If the memory was not faulted in yet, the fault handler also
> >>>>>>>>>   allows fault in the HWPoison folio.
> >>>>>>>>>
> >>>>>>>>> For a MFD_MF_KEEP_UE_MAPPED enabled memfd, when it is closed, o=
r
> >>>>>>>>> when userspace process truncates its hugepages:
> >>>>>>>>>
> >>>>>>>>> * When the HugeTLB in-memory file system removes the filemap's
> >>>>>>>>>   folios one by one, it asks MFR to deal with HWPoison folios
> >>>>>>>>>   on the fly, implemented by filemap_offline_hwpoison_folio().
> >>>>>>>>>
> >>>>>>>>> * MFR drops the refcounts being held for the raw HWPoison
> >>>>>>>>>   pages within the folio. Now that the HWPoison folio becomes
> >>>>>>>>>   free, MFR dissolves it into a set of raw pages. The healthy p=
ages
> >>>>>>>>>   are recycled into buddy allocator, while the HWPoison ones ar=
e
> >>>>>>>>>   prevented from re-allocation.
> >>>>>>>>>
> >>>>>>>> ...
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> +static void filemap_offline_hwpoison_folio_hugetlb(struct foli=
o *folio)
> >>>>>>>>> +{
> >>>>>>>>> +     int ret;
> >>>>>>>>> +     struct llist_node *head;
> >>>>>>>>> +     struct raw_hwp_page *curr, *next;
> >>>>>>>>> +
> >>>>>>>>> +     /*
> >>>>>>>>> +      * Since folio is still in the folio_batch, drop the refc=
ount
> >>>>>>>>> +      * elevated by filemap_get_folios.
> >>>>>>>>> +      */
> >>>>>>>>> +     folio_put_refs(folio, 1);
> >>>>>>>>> +     head =3D llist_del_all(raw_hwp_list_head(folio));
> >>>>>>>>
> >>>>>>>> We might race with get_huge_page_for_hwpoison()? llist_add() mig=
ht be called
> >>>>>>>> by folio_set_hugetlb_hwpoison() just after llist_del_all()?
> >>>>>>>
> >>>>>>> Oh, when there is a new UE while we releasing the folio here, rig=
ht?
> >>>>>>
> >>>>>> Right.
> >>>>>>
> >>>>>>> In that case, would mutex_lock(&mf_mutex) eliminate potential rac=
e?
> >>>>>>
> >>>>>> IMO spin_lock_irq(&hugetlb_lock) might be better.
> >>>>>
> >>>>> Looks like I don't need any lock given the correction below.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> +
> >>>>>>>>> +     /*
> >>>>>>>>> +      * Release refcounts held by try_memory_failure_hugetlb, =
one per
> >>>>>>>>> +      * HWPoison-ed page in the raw hwp list.
> >>>>>>>>> +      *
> >>>>>>>>> +      * Set HWPoison flag on each page so that free_has_hwpois=
oned()
> >>>>>>>>> +      * can exclude them during dissolve_free_hugetlb_folio().
> >>>>>>>>> +      */
> >>>>>>>>> +     llist_for_each_entry_safe(curr, next, head, node) {
> >>>>>>>>> +             folio_put(folio);
> >>>>>>>>
> >>>>>>>> The hugetlb folio refcnt will only be increased once even if it =
contains multiple UE sub-pages.
> >>>>>>>> See __get_huge_page_for_hwpoison() for details. So folio_put() m=
ight be called more times than
> >>>>>>>> folio_try_get() in __get_huge_page_for_hwpoison().
> >>>>>>>
> >>>>>>> The changes in folio_set_hugetlb_hwpoison() should make
> >>>>>>> __get_huge_page_for_hwpoison() not to take the "out" path which
> >>>>>>> decrease the increased refcount for folio. IOW, every time a new =
UE
> >>>>>>> happens, we handle the hugetlb page as if it is an in-use hugetlb
> >>>>>>> page.
> >>>>>>
> >>>>>> See below code snippet (comment [1] and [2]):
> >>>>>>
> >>>>>> int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> >>>>>>                                  bool *migratable_cleared)
> >>>>>> {
> >>>>>>         struct page *page =3D pfn_to_page(pfn);
> >>>>>>         struct folio *folio =3D page_folio(page);
> >>>>>>         int ret =3D 2;    /* fallback to normal page handling */
> >>>>>>         bool count_increased =3D false;
> >>>>>>
> >>>>>>         if (!folio_test_hugetlb(folio))
> >>>>>>                 goto out;
> >>>>>>
> >>>>>>         if (flags & MF_COUNT_INCREASED) {
> >>>>>>                 ret =3D 1;
> >>>>>>                 count_increased =3D true;
> >>>>>>         } else if (folio_test_hugetlb_freed(folio)) {
> >>>>>>                 ret =3D 0;
> >>>>>>         } else if (folio_test_hugetlb_migratable(folio)) {
> >>>>>>
> >>>>>>                    ^^^^*hugetlb_migratable is checked before tryin=
g to get folio refcnt* [1]
> >>>>>>
> >>>>>>                 ret =3D folio_try_get(folio);
> >>>>>>                 if (ret)
> >>>>>>                         count_increased =3D true;
> >>>>>>         } else {
> >>>>>>                 ret =3D -EBUSY;
> >>>>>>                 if (!(flags & MF_NO_RETRY))
> >>>>>>                         goto out;
> >>>>>>         }
> >>>>>>
> >>>>>>         if (folio_set_hugetlb_hwpoison(folio, page)) {
> >>>>>>                 ret =3D -EHWPOISON;
> >>>>>>                 goto out;
> >>>>>>         }
> >>>>>>
> >>>>>>         /*
> >>>>>>          * Clearing hugetlb_migratable for hwpoisoned hugepages to=
 prevent them
> >>>>>>          * from being migrated by memory hotremove.
> >>>>>>          */
> >>>>>>         if (count_increased && folio_test_hugetlb_migratable(folio=
)) {
> >>>>>>                 folio_clear_hugetlb_migratable(folio);
> >>>>>>
> >>>>>>                 ^^^^^*hugetlb_migratable is cleared when first tim=
e seeing folio* [2]
> >>>>>>
> >>>>>>                 *migratable_cleared =3D true;
> >>>>>>         }
> >>>>>>
> >>>>>> Or am I miss something?
> >>>>>
> >>>>> Thanks for your explaination! You are absolutely right. It turns ou=
t
> >>>>> the extra refcount I saw (during running hugetlb-mfr.c) on the foli=
o
> >>>>> at the moment of filemap_offline_hwpoison_folio_hugetlb() is actual=
ly
> >>>>> because of the MF_COUNT_INCREASED during MADV_HWPOISON. In the past=
 I
> >>>>> used to think that is the effect of folio_try_get() in
> >>>>> __get_huge_page_for_hwpoison(), and it is wrong. Now I see two case=
s:
> >>>>> - MADV_HWPOISON: instead of __get_huge_page_for_hwpoison(),
> >>>>> madvise_inject_error() is the one that increments hugepage refcount
> >>>>> for every error injected. Different from other cases,
> >>>>> MFD_MF_KEEP_UE_MAPPED makes the hugepage still a in-use page after
> >>>>> memory_failure(MF_COUNT_INCREASED), so I think madvise_inject_error=
()
> >>>>> should decrement in MFD_MF_KEEP_UE_MAPPED case.
> >>>>> - In the real world: as you pointed out, MF always just increments
> >>>>> hugepage refcount once in __get_huge_page_for_hwpoison(), even if i=
t
> >>>>> runs into multiple errors. When
> >>>>
> >>>> This might not always hold true. When MF occurs while hugetlb folio =
is under isolation(hugetlb_migratable is
> >>>> cleared and extra folio refcnt is held by isolating code in that cas=
e), __get_huge_page_for_hwpoison won't get
> >>>> extra folio refcnt.
> >>>>
> >>>>> filemap_offline_hwpoison_folio_hugetlb() drops the refcount elevate=
d
> >>>>> by filemap_get_folios(), it only needs to decrement again if
> >>>>> folio_ref_dec_and_test() returns false. I tested something like bel=
ow:
> >>>>>
> >>>>>     /* drop the refcount elevated by filemap_get_folios. */
> >>>>>     folio_put(folio);
> >>>>>     if (folio_ref_count(folio))
> >>>>>         folio_put(folio);
> >>>>>     /* now refcount should be zero. */
> >>>>>     ret =3D dissolve_free_hugetlb_folio(folio);
> >>>>
> >>>> So I think above code might drop the folio refcnt held by isolating =
code.
> >>>
> >>> Hi Miaohe, thanks for raising the concern. Given two things below
> >>> - both folio_isolate_hugetlb() and get_huge_page_for_hwpoison() are
> >>> guarded by hugetlb_lock.
> >>> - hugetlb_update_hwpoison() only folio_test_set_hwpoison() for
> >>> non-isolated folio after folio_try_get() succeeds.
> >>>
> >>> as long as folio_test_set_hwpoison() is true here, this refcount
> >>> should never come from folio_isolate_hugetlb(). What do you think?
> >>>
> >>
> >> Let's think about below scenario. When __get_huge_page_for_hwpoison() =
encounters an
> >> isolated hugetlb folio:
> >>
> >> int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> >>                                  bool *migratable_cleared)
> >> {
> >>         struct page *page =3D pfn_to_page(pfn);
> >>         struct folio *folio =3D page_folio(page);
> >>         bool count_increased =3D false;
> >>         int ret, rc;
> >>
> >>         if (!folio_test_hugetlb(folio)) {
> >>                 ret =3D MF_HUGETLB_NON_HUGEPAGE;
> >>                 goto out;
> >>         } else if (flags & MF_COUNT_INCREASED) {
> >>                 ret =3D MF_HUGETLB_IN_USED;
> >>                 count_increased =3D true;
> >>         } else if (folio_test_hugetlb_freed(folio)) {
> >>                 ret =3D MF_HUGETLB_FREED;
> >>         } else if (folio_test_hugetlb_migratable(folio)) {
> >>
> >>                    ^^^^*Since hugetlb_migratable is cleared for the is=
olated hugetlb folio*
> >>
> >>                 if (folio_try_get(folio)) {
> >>                         ret =3D MF_HUGETLB_IN_USED;
> >>                         count_increased =3D true;
> >>                 } else {
> >>                         ret =3D MF_HUGETLB_FREED;
> >>                 }
> >>         } else {
> >>
> >>                   ^^^^*Code will reach here without extra refcnt incre=
ased*
> >>
> >>                 ret =3D MF_HUGETLB_RETRY;
> >>                 if (!(flags & MF_NO_RETRY))
> >>                         goto out;
> >>         }
> >>
> >>         *Code will reach here after retry*
> >
> > You are right, thanks for pointing that out. Let me think about more
> > how to handle this.

I was struggling to find a good fix, as I really don't want to memoize
into the folio that if memory_failure has elevated a refcount.

> >
> >>         rc =3D hugetlb_update_hwpoison(folio, page);
> >>         if (rc >=3D MF_HUGETLB_FOLIO_PRE_POISONED) {
> >>                 ret =3D rc;
> >>                 goto out;
> >>         }
> >>
> >> So hugetlb_update_hwpoison() will be called even for folio under isola=
tion
> >> without folio_try_get(). Or am I miss something?
> >
> > Just a random question: if MF never increments a hugepage's refcount,
>
> MF will hold hugetlb folio's refcount unless it's freed or isolated.

A random thought. For an isolated hugetlb folio, if it becomes
hwpoison (after __get_huge_page_for_hwpoison() failed with retries),
and then `folio_putback_hugetlb()` is called, should we block setting
migratable and putting it back to hugepage_activelist? IWO, make it
forever isolated and just decrement refcount:

 void folio_putback_hugetlb(struct folio *folio)
 {
        spin_lock_irq(&hugetlb_lock);
-       folio_set_hugetlb_migratable(folio);
-       list_move_tail(&folio->lru,
&(folio_hstate(folio))->hugepage_activelist);
+       if (!folio_test_hwpoison(folio)) {
+               folio_set_hugetlb_migratable(folio);
+               list_move_tail(&folio->lru,
&(folio_hstate(folio))->hugepage_activelist);
+       }
        spin_unlock_irq(&hugetlb_lock);
        folio_put(folio);

(Maybe the event "become hwpoison =3D> folio_putback_hugetlb()" can never h=
appen?)

If so, as a side effect, I can use folio_putback_hugetlb() to
decrement the refcount even if we are uncertain that the residue
refcount is whether from memory_failure or folio_isolate_hugetlb().

>
> > what does the folio_put() in me_huge_page() (when mapping =3D null) do?
> > Is it dropping for something other than MF?
>
> For isolated hugetlb folio, MF_HUGETLB_RETRY will be returned and code wo=
n't reach here.
> Thanks.
> .
