Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B7375F65
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241575; cv=fail; b=gDCR8AB9qriDvsnKGA3Dd0WDHBYgKoDKcLRvk+cMG+pd1QatRpAQ0xsbxNrRS1MJOVyx6P5rk62X4m2wGTxORqKpdGHxS/MElazqXfX1ifKuXnt5sP9VwxXMvA5L02DwQbNJAutadaB+CqzvmE4JYAcdI84t2KRjYQZm0bFMKbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241575; c=relaxed/simple;
	bh=roxXU6Z74sF8nlaUP7Fv2tRIYGBB8OvYLUyAoWfgdYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGMs8wDc9jBqi2qyWpKCPLLEac79zZbRj+C8itFno8dPkpRzZpN8hN82KcVJzEowRGNp8MVOyix4/ofAYDDXGdm2Gyei/vjlwQbGiXwRKDz69cXs4tTOguUf6v56Dt57vyig3trsKmyDUPyltm1Q0BskSrcfz00a7zNahcSybL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kWkkaWuc; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kWkkaWuc"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5dbhs057641
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:19:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=roxXU6Z74sF8nlaUP7Fv2tRIYGBB8OvYLUyAo
	WfgdYo=; b=kWkkaWucyhVMYiRXWzHqqmBWBbtttD9KKpWrxiT25wt0v5edCwCyW
	yqwX6JcMNoSjyGD1TnxKqoY2HL4MOzdDGbv8/JVadZUf/lH5F2U/z/zPguz+2WvI
	PRmqIvk6iGjC5E+Gq9Ji0jMxWRJprVpk3eNHNp3Vo3WezYtNHKObxgCDUNHLlCG+
	274GyykPwxtiI1gS/lViAxKEKmOr8M72J4TMB5P891fVFBcifU/osustQu+HnHUX
	BE3ysvRpPKJk56v0pyISvMJbcVyjEpYttySp01KEq0TAohAOu9GC8ryOBCaz8tdx
	a16ZV1FUx4+zusTtAGbyTnZvU+4HIwCkQ==
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4guyr1g9tp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:19:32 -0700 (PDT)
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c25501f4aa2so97642066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790241571; cv=none;
        d=google.com; s=arc-20260327;
        b=om8tkM9d1GCJOeEpiWfGoYbR721o8IrNTXG2GsW9OvuxSdDncYyixZVsDhxFTdAoz8
         Rt2HySvF61cE0bptA7DJQu5bqSyICfEfsLnLMmRyMyOp9x490Sr0z4LLTPpLAPjJ1ivz
         LgJ6+BMWv5R5139z4H6p+w0KgnH/vFEoLH+gwpBEZ+srX0qW7JYfJw4LsYVGoj8gEJr6
         saQ4GDZdlsT5HbEGsxyjcvi3aGyYMgRlc+haufJcFbGUFx46GU7Ea711w8MOK6heX8la
         6jYbsj7qVPLDYt1xXJ3teMTVH1WL7/r6LKbBvjnM72bAFStoeJWCjA2e3IUqXKll40BQ
         P3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=YoGK7sXAdEPoXHsQQP3OSq8CcOrGesthSuPxxba+GjY=;
        fh=ZA2Tze9Ozxb8nzly6fS6YJaTdYBjFR2rgIRhog8L76Y=;
        b=Fi2DAXYXfcjQUPXJy8qfF/5XKG20dsT7lxa8+Yv/fsU5kU97X2nz75Bx+ndPtvhZIQ
         WmKUTKK0RGqAU/eG2IHFYRWASqoaVlq9ROj8oCLS1ylp9VxQjobee7C7WEw6wmGBXd/y
         goH0Fl1jD1znUwRPjvdFKjZUSYaBxUKfU11/Brq3YnqZvkYYehXUD1Qnrali25F4zLe1
         kuB+HY4n3xBl424V2/4cPKPpcXzCXLIGn1TFqbGunaKbr2IYAIwXmq2U2aOHDgPNDV2p
         4K3r61jgxjQD7V+fjZnTMEDVa2N6pFMNvONPmpvdnz11z6mgS7ilIWd9RE/vdSLNkbID
         SB+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790241571; x=1790846371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoGK7sXAdEPoXHsQQP3OSq8CcOrGesthSuPxxba+GjY=;
        b=jtQW6UtnFWi0QnD/E7RvUdlvTOZDdHZz86Wig3I9bne5hdzF06bX15B3/g0CYPik9a
         CysjYX+nOXyRe8iQJLkvGFtj+0TN65hbIZUT6djmZuF/CK7S27LpvI5uK/PzJQcv0Mz1
         PUGtUZPXGX/oP87bP4IJLtPn63UWeQetnJTDvbtR/7gEQvu2xGlP/FPOM2j7897xTiBN
         H/9QDToUhDpdeABMqtDV6A2vFSwzBcRRV/qQ0haAeR/BPioeeYnU3XcE7dIuY5Cc0w4V
         Vrzk+5Wakj4Pw9EQ4zLMxB+6EpHTs3aitQBNxNVXyjSwKcT9vOthY1yJphoJxVsodd48
         Wl/Q==
X-Forwarded-Encrypted: i=1; AKwUvBy9RtoOZ6TI0kPEggGvdVEd9dZAnnJQg3Ocebp/Neqh1tV6h9EpmIes/v6M5IWVPEx+Yqjvadu7N8O5jdKT@vger.kernel.org
X-Gm-Message-State: AFuF++lxPif/fBNTpJxa2Rt27EbCyf1J5NXAyOxQMla4ntqxa9zUTBgd
	HB3cFKhfl2N0SW/sAN9TzqdRkOh430Q4W5isZXJGkRV35LcCrgY9p4oE6eRA7L0R30oYkbo+MBK
	zdLNw7YwPHLeKSZ2N5ebT9oWmlHZUXQRMb4nKhZFJXgWdASdvywD6DIhiChAosMc+vV3nuaQaY0
	B68suyqS5DpIyUHOYQxxKsyyKSpj8/mmwvAttUNgAr
X-Gm-Gg: AYBFou2v9KKy3+Wnh7bI69L2WmBBmDXy/Egfu6kx1gJWgOmHorqC0T/HDgsRfU1IZ4f
	QzYA9XjC8nLWcN18sGdSIZjh6UyATfmwX2qQkgvPCkLu78JE9nrAIk8m5ybWmtgeW2uG8UP1PFC
	QoI1PCHbnC6BBE/jzpu4QQnozr29wdG1WhZ07ROQBvkPOmOo3alswA01r/xxx94+62chjMLC521
	BTYfc/giwQwRjYVTw==
X-Received: by 2002:a17:906:6312:b0:c29:40d1:5108 with SMTP id a640c23a62f3a-c2ac235cc72mr142732166b.19.1790241571042;
        Thu, 24 Sep 2026 02:19:31 -0700 (PDT)
X-Received: by 2002:a17:906:6312:b0:c29:40d1:5108 with SMTP id
 a640c23a62f3a-c2ac235cc72mr142730166b.19.1790241570673; Thu, 24 Sep 2026
 02:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921152449.629486-1-alex@ghiti.fr> <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
 <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com>
 <108487b7-0529-4282-b5f4-355804b4c0cf@kernel.org> <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>
 <2e695c8a-4212-42b5-bb51-fbe1aa162e1d@kernel.org> <CAGsJ_4z2nakqBCKd_uAn4bfub99r3NJt2spOUx-K0M7bHW3_-w@mail.gmail.com>
 <4c7c6ea0-84a7-45f6-989c-d1502b90694c@kernel.org> <CAMgjq7DeYsJxG_VCf2KnViV5nd10m-PPYzXRD1fi8QcGWwD0qw@mail.gmail.com>
 <d9a77381-cf88-4726-9223-c16a5c6608c2@kernel.org> <CAMgjq7CLGyLHi7Lb8WF_m9bWUHpMRp_uDrqYNRQsH2GkuVQ=Ng@mail.gmail.com>
 <CAN_Opa_PrLP7mpF7gRjQUKfoCJGP7KvZMB-23bPUG269QASHpg@mail.gmail.com>
In-Reply-To: <CAN_Opa_PrLP7mpF7gRjQUKfoCJGP7KvZMB-23bPUG269QASHpg@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Thu, 24 Sep 2026 11:19:18 +0200
X-Gm-Features: AclHuK_fFa8d65bD0Ky2JUPx_6IS1uipfriABR0dPRad5IHn5nWDjOjzkhYFNFQ
Message-ID: <CAEmasaVnJEaSRFAZn7ZCUH=dbocUjXvEy=ot8qGpCy_TAiMCFQ@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback completion
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>,
        "David Hildenbrand (Arm)" <david@kernel.org>,
        Barry Song <baohua@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
        akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
        liam@infradead.org, ljs@kernel.org, vbabka@kernel.org,
        jannh@google.com, chrisl@kernel.org, shikemeng@huaweicloud.com,
        nphamcs@gmail.com, baoquan.he@linux.dev, youngjun.park@lge.com,
        qi.zheng@linux.dev, shakeel.butt@linux.dev, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
        mhocko@kernel.org, yosry@kernel.org, chengming.zhou@linux.dev,
        tz2294@columbia.edu, hch@lst.de, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfX3EVQFepo2KLY
 4SNLXG02a1zcyJSD4DQo7RmAtMZSas6zOMa44e9zreSKato7VUFHNNVDYP195tO+9Ot2vuUBqaG
 Y1R2+IPJywn7r41nDRrTYIT+ZlJK1GOxEcrzx68MJgc04Cn1lGAsGvu4ecrFZzq/TXrp7cCniMV
 8tYsNfFfhZUFdv9C6fxPsFmvpPaF5l6gd/VkNh9unOQS+7GonoC17VSRVuOPY7dL3EFC0nPvygf
 aTspNlKhOigZi6BrFdehlDZQq0EhTmdnlkwGtXtBkmsyx3xwDmjxIQGehisATNgnk0WhC4p66z9
 Cutj1oSyVw6375M4Ovt7XXwMAW/mjVzYDKundpWFZfm5ToO8upPoi+qf1fxbov7NeF2JcQu7lmN
 Uam/tROg3rjqQOA0SOGSdH+6kv2J4CXdYDfXQcrDKlIMm00bRQoG+gKeG+XaESWDNy95IUp+BL5
 Sm2iqKZGi1FtSTfVfDg==
X-Authority-Analysis: v=2.4 cv=DNMacCNb c=1 sm=1 tr=0 ts=6ab4eb24 cx=c_pps
 a=edIAN7ErZTGbxav20d8A7Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=Nuu0otnvvFxtlZZjwoAA:9 a=QEXdDO2ut3YA:10
 a=nIuFr-8touD1a-RngYHT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfX1Db4UcXCn0ly
 twfnfz1nFKjL5NSRlb07JDMBvjneDGaPn7be2dN8vozbEhBOEhYlnionfIkfUhTs2C4cpN6Hs62
 oYQUKVsuAJ9j5BW9A9TmLQ62rmVpU/w=
X-Proofpoint-ORIG-GUID: XfwAVnFkT78wQawOB4m_o3iRk4EXgkPQ
X-Proofpoint-GUID: XfwAVnFkT78wQawOB4m_o3iRk4EXgkPQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01

Hi KunWu,

On Wed, Sep 23, 2026 at 6:22=E2=80=AFPM KunWu Chan <kunwu.chan@gmail.com> w=
rote:
>
> >
> On Wed, Sep 23, 2026 at 6:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Wed, Sep 23, 2026 at 11:47=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> > >
> > > On 9/23/26 11:35, Kairui Song wrote:
> > > > On Wed, Sep 23, 2026 at 10:46=E2=80=AFAM David Hildenbrand (Arm)
> > > > <david@kernel.org> wrote:
> > > >>
> > > >> On 9/22/26 22:55, Barry Song wrote:
> > > >>> On Tue, Sep 22, 2026 at 7:26=E2=80=AFPM David Hildenbrand (Arm)
> > > >>> <david@kernel.org> wrote:
> > > >>>
> > > >>> I guess that's because the LRU is not always accurate. There are =
cases
> > > >>> where our prediction of future access patterns may be wrong, resu=
lting
> > > >>> in refaults?
> > > >
> > > > Hi All,
> > > >
> > > >>
> > > >> Right. But these would happen in both the SYNC and the ASYNC case.=
 Which seems
> > > >> to indicate that making the SYNC case behave like the ASYNC case (=
keep in
> > > >> swapcache before evicting) could actually improve performance?
> > > >>
> > > >> Or is the SYNC case in general so fast that it is not a problem an=
d the
> > > >> swapcache is just not a good use?
> > > >
> > > > I think the problem is not LRU being inaccurate, but ASYNC case cou=
ld
> > > > overshoot the anon reclaim very easily. File folios can be simply
> > > > dropped, and increase nr_reclaimed, but anon writeback (swap) can't=
 be
> > > > done durig the reclaim iteration so nr_reclaimed never increase dur=
ing
> > > > the scan iteration. So the scan tries hard to scan and reclaim more
> > > > anon folios, more than it really needed.
> > > >
> > > > I think the real fix is some kind of different watermark, throttlin=
g,
> > > > or a different counter to limit the scan of async swap. I mentioned
> > > > this at LSFMM this year but I guess I presented too much at the same
> > > > time so few people remembered it :D.
> > >
> > > :D
> > >
> > > >
> > > >>
> > > >>>
> > > >>> Even on Android, which uses zram with very fast synchronous swap-=
out,
> > > >>> I can still hit the swapcache from time to time. So perhaps with a
> > > >>> slower device, such as an HDD, keeping the swapcache around for l=
onger
> > > >>> could allow applications to hit it more often?
> > > >>
> > > >> Why is that specific for HDD? It's the exact same app behavior ind=
ependent of
> > > >> the underlying swap technology.
> > > >
> > > > If you have a shared folio, you must use swap cache, and even for
> > > > single used folios swap cache is the way to do synchronization,
> > > > regardless of the device.
> > > >
> > > >>>
> > > >>> I don't know. Maybe Alexandre can share more details about this
> > > >>> benchmark. I'm also a little surprised by the 15% regression in
> > > >>> Sysbench OLTP. My initial feeling was the same as yours: we should
> > > >>> release the memory immediately after writeback completes, for both
> > > >>> synchronous and asynchronous I/O.
> > > >>
> > > >> Right. And see if we can identify why we are swapping out the wron=
g things :)
> > > >
> > > > I think we are not? It's about over-reclaim. In the worst case we
> > > > might put every anon folio under writeback, while no folio is
> > > > reclaimed, if the device is super slow.
> > > Ah, that hints at the real problem then? How confident are we that th=
at's what's
> > > happening?
> >
> > Given the fact that ZRAM/ZSWAP doesn't suffer from this, I think this
> > is the cause: the main difference is that ZRAM/ZSWAP frees the folios
> > after pageout() so nr_reclaimed is increased (reclaim loop just keeps
> > comparing nr_reclaimed to nr_to_reclaim), other swap devices keep the
> > folios under writeback, and continue reclaiming unless they hit enough
> > clean folios to drop.
> >
> > I can't say I'm 100% sure, and it's hard to verify but I think we need
> > to try fixing this instead. It's not hard to construct a case where
> > all anon folios are put under writeback due to very slight pressure,
> > e.g. a dm-delay (e.g. 500ms?), 1G anon in one memcg, very slight
> > memorey pressure could easily put nearly all anon folios under
> > writeback.
>
> Alex, One question about the `nr_reclaimed` accounting.
>
> `PAGE_DROPBEHIND` increments `nr_reclaimed` when the write is
> submitted, while the folio may still be under writeback and is only
> actually removed from the swap cache when writeback completes.
>
> Kairui pointed out that async swap can over-reclaim because
> `nr_reclaimed` does not increase while anon folios remain under
> writeback. Does the early accounting for `PAGE_DROPBEHIND` address
> that over-reclaim mechanism for this `MADV_PAGEOUT` path?

Unvoluntarily yes :)

>
> It might also be useful to check this with a delayed swap device, such
> as the `dm-delay` case Kairui mentioned.

Yes, I'm setting up a new experiment to check everything mentioned in
this thread.

Thanks,

Alex

>
> Thanks,
> Kunwu
>
