Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E143BDAA
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241066; cv=fail; b=OV/LZH4xcicQYlW2IUKlYgJb46QLFzvF8ppV1GW2QrM1I96mubRPC7OppUjxgaT71jqmMc+oKuSrRzHYbyKVfaI9jS+7TBZsUn+fhp5+ecNt1EQR6VKBtqfIPGWPJyeNO0s/dQv6LA6Q35ciNZN1e6Og/9QgqFYKhFoueNQqPEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241066; c=relaxed/simple;
	bh=OkxRH+q+0DEgZUuWgxACk6KXAXfbkWPs9mgxMAe0PGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWFRgW02m8oW3viMPbAr5/K4pdRlm7ZIkpor+t4/8KyJeiUCEyy9BLbbk0ZYNhPTyEX4LsstSeRTImFxFQC5UcfDWp5ja8RyuRMwJKTWyj1TxECCzad8ZDG0vNsuNhuiZHmveRSDbkozA+DLStH42tewzZxG4r9nItStSmuwpFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fhwlflLg; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fhwlflLg"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68O5e7X83021632
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:11:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=OkxRH+q+0DEgZUuWgxACk6KXAXfbkWPs9mgxM
	Ae0PGs=; b=fhwlflLgduNKqEWjlZgv6ytWrRGy6UXFW6QLYOsAQwcSPTUl990qk
	DWuDAfZ8vZf3Ac+6QNkF8VZjl46oJmxGagOMv6DsAD7CPBvSv07La4IQ+oShs0v/
	UKGx0nxo/PfbnLXUP9sh06hHNyvK45ucVgMYYa+5iwoYtMxaRVtxteCwTN6fU5TR
	6r5po9MGRUKpIAOXulJ0id/EIcDjpzCrhzlxwugWOoFHum22YGXAmUUvEtszM1A5
	t+Nr8/oh+nL7Exeg0iu49MDK1j8W2ld3lMQ3JDYJ/kv7IUIQE8gPI0d3Oz01z9Rz
	CgctQxCRJJVg2C+Xco/q0cIjVOU7em/Cg==
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	by m0089730.ppops.net (PPS) with ESMTPS id 4gv0jup9vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:11:02 -0700 (PDT)
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c251c140b41so161284866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790241061; cv=none;
        d=google.com; s=arc-20260327;
        b=hpDJ/k0plCyliJ/xU7+t2qXYUHYkFlUd+LAg3bIn9WqCRnTnG5XsqU8bsfLEgR48u2
         FefIpjZCOwkml9Utgt+uAtD+Y6rVPI2uWyxxaWtTTio/Jwe5CscxS8XYesg6hem5/R06
         Ko9A3SwOseRvqalStmhE/3y1gjE2joMIf3ybxUviVchLfL6ZM5Z+Vd6P1oFRI/QPOz51
         bDNLRtN4PC/CWPwS4quQHPBLaXryRkwpfOl1oOswNIPaAV9CwtPkumJ3HRt1eWo9cZo/
         9I2ikiHwkFp4t8syR5kS124SN0mL8OK9M2riv0QbhLVtO5Nnnkxs7M/R0ULUA8uVw+a7
         qnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=M2souLhMloQ4pmmyrj3ZcxjVddtdbXDXplB5Ku+fTnM=;
        fh=lNU/e8jOhlg5e1UvV81bh6TPFtRrbL4tDiCa6HN9LJI=;
        b=Zt+Gdasq1YM51p3UCMHcj+uF+sDZ6tCzigMGMfg9GVTiWu0JMxClI0cNqKDiB+dwVH
         IVs+EvFyg3BUjkzMOyLfSfpXaQXei40gR1iEW2pH6lKJoA3Ej3owJ3SFJFOtt0yPrV3l
         /irCJu0qmfbQ1rK4qRG1UhW8aU72695ipesHd/w6VH1re1OIgw8QiIiaotKw3RaX9FCV
         p/v865umwx0aiB47vkNzSHgRsckwJi332l/GnD4rrdaelg2o/M/AoPr8uCAkWRe/Z0hw
         nISMehwUleKSGnxvQIAspZ0BkssSPxWeX6SkUdY5Zo7opSJKP0QdRa5E6CPn5ty+qtc7
         YqQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790241061; x=1790845861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2souLhMloQ4pmmyrj3ZcxjVddtdbXDXplB5Ku+fTnM=;
        b=zdZG8DpeYX+w+BluOHIC16umeXZaDAZWF+99et5bF0jdgWGezVYF5SJbXMf8K/91uG
         Hmh4RS/5Le/HKfwIR/fV66bSS+5rbLbKZQZcKwMnFB7KlkAPRqabRSg4X1r5CsFZtire
         q2UOo4eXQSTlwhl5sblJiB9H5U3tuca+x8YnlrZFkAQw8/BCoX+APwXfD/yVSuYR7w5M
         CjYG+teUp6i2sL/olSubzYOQh571nCKt5+GK0VkyuNaqgRUXuIqACa6QbFqHzBx5zXU0
         QmS79unJB546MAUzhbJslmKHyfamFxvYOayBWAEyMXK1hk0bzY8JOqVZW/XxVbKpKg1F
         urYw==
X-Forwarded-Encrypted: i=1; AKwUvBz35dLZn8iibrjPLihuRDQtNRQ4UPJ6XULLj072ej7uIcQuGpeMCLDfQLli2YJroMHnFfy7disXL6lYwsfa@vger.kernel.org
X-Gm-Message-State: AFuF++litdX+15/EsRNijQKhYRtpQMeTMKuy9EenbuUzDfOPpi7sE9Nl
	oJjAj3A7DQdmKTH5MqU1CRsCUNLGlvLaDeV91tpVAAV3Z43kUbqO6oYu0EM5YGgP9PZf/OqJupm
	1AyvlTsi4EV2TMKrVWEpnupkHe7c0JAuSrQZat+o8ioeZE02EOdNuQ5izU/g0OpxJ8hIwl/0eW7
	Omk5fh7fVr+AsaXK/AcNWtW5oygNhZg0fgH0aVglqy
X-Gm-Gg: AYBFou2pfc8NBlL/xD/Il1hIe4lAUE1qTqdbb7YWfM1kF31QiCrpOSsHwtnAL4MNtBp
	exk76TgjNp0VIOivMqmllqtdfWRFx0k6IGla2vHZK2ezYsqISufB/CwNG9RIdnwwD9Q2VREHD0+
	OrO/X7+8IZpZ2CuVDPsvOfZSGWCGPE0AbUvztcnDiNh0PVEmSkvZt50gvBqc1yFWeshC7bpyYW9
	BmCXD73768BpCodLQ==
X-Received: by 2002:a17:906:7947:b0:c26:1649:47ad with SMTP id a640c23a62f3a-c2ac53c3f15mr97803466b.35.1790241061090;
        Thu, 24 Sep 2026 02:11:01 -0700 (PDT)
X-Received: by 2002:a17:906:7947:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c2ac53c3f15mr97799466b.35.1790241060652; Thu, 24 Sep 2026
 02:11:00 -0700 (PDT)
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
 <d9a77381-cf88-4726-9223-c16a5c6608c2@kernel.org>
In-Reply-To: <d9a77381-cf88-4726-9223-c16a5c6608c2@kernel.org>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Thu, 24 Sep 2026 11:10:48 +0200
X-Gm-Features: AclHuK-UOq_6vRlLv2UYnifr0HoK5SGeCN1wUDEcA3fAollzIZ7bOBDjISbGN1s
Message-ID: <CAEmasaWxkfBj91ye+kr2hwaAin1rFSTWrXCbntV5vjuqCG=54g@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback completion
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, Barry Song <baohua@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org,
        willy@infradead.org, jack@suse.cz, liam@infradead.org, ljs@kernel.org,
        vbabka@kernel.org, jannh@google.com, chrisl@kernel.org,
        shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev,
        youngjun.park@lge.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, yosry@kernel.org,
        chengming.zhou@linux.dev, kunwu.chan@gmail.com, tz2294@columbia.edu,
        hch@lst.de, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfX+BU3u3y0KYnr
 QcdXneRKs6z/NX8p2zBk+XaQchw2U1e4ihmX1aQrXFvMlnntfOpJL1wYSes3rYFOiUfvfj08LQ8
 e+mbb7CeC9wz08rd7fIOfbI+ouTTHwo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfX0VpQZoua1YZc
 B/SrT22maOw59ni7OI7KCL6pMgApq9YLkooJrmhVEapJoBvHWC4Nvt7xXUDRdrgJ8iS18/cqa/c
 yBtpS3rHdeNHaSvqaxjeCEQLruaUH6hZEfaH9bvFRANQ093ovFWSqNhT9qcj7Lp0z7yHctdSY2c
 AUKhubTyaeT6SGjcqxsGcr229xfNZoJEiN7wROJ9lfkDQ49FBCY7mrI4temUh6X87+rPPF1YihC
 4l5faSKvRaw7bomEloFKHPvHxqBVAKqdakyWlC5uKzjVdrOT//X0x2+rI59kQX7/JS3L6O6g5cf
 FerPS+spDbb/ngSn6OHEjR2UqfgcnlpcJZQfMmGKWIT4ijE6lpnwcqhahZxGCMH6uVFtlH+/0jQ
 O8HFtC33ODl8vFXyZ+P7OT7Hvz40IYKxJWsFUIaOgAWGYYQ28FOzGPF22d1CRJwOKDJAt1yeZBM
 fBEQAbqHNHBB5whhbGg==
X-Proofpoint-ORIG-GUID: 3rEjKTvzMzLi8MJZHnCMEKrLEC1frFfm
X-Authority-Analysis: v=2.4 cv=Is2L47/g c=1 sm=1 tr=0 ts=6ab4e926 cx=c_pps
 a=edIAN7ErZTGbxav20d8A7Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=vvh9Qk1aVFpNxidmG9UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3rEjKTvzMzLi8MJZHnCMEKrLEC1frFfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01

Hi David,

On Wed, Sep 23, 2026 at 11:47=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> >
> On 9/23/26 11:35, Kairui Song wrote:
> > On Wed, Sep 23, 2026 at 10:46=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/22/26 22:55, Barry Song wrote:
> >>> On Tue, Sep 22, 2026 at 7:26=E2=80=AFPM David Hildenbrand (Arm)
> >>> <david@kernel.org> wrote:
> >>>
> >>> I guess that's because the LRU is not always accurate. There are cases
> >>> where our prediction of future access patterns may be wrong, resulting
> >>> in refaults?
> >
> > Hi All,
> >
> >>
> >> Right. But these would happen in both the SYNC and the ASYNC case. Whi=
ch seems
> >> to indicate that making the SYNC case behave like the ASYNC case (keep=
 in
> >> swapcache before evicting) could actually improve performance?
> >>
> >> Or is the SYNC case in general so fast that it is not a problem and the
> >> swapcache is just not a good use?
> >
> > I think the problem is not LRU being inaccurate, but ASYNC case could
> > overshoot the anon reclaim very easily. File folios can be simply
> > dropped, and increase nr_reclaimed, but anon writeback (swap) can't be
> > done durig the reclaim iteration so nr_reclaimed never increase during
> > the scan iteration. So the scan tries hard to scan and reclaim more
> > anon folios, more than it really needed.
> >
> > I think the real fix is some kind of different watermark, throttling,
> > or a different counter to limit the scan of async swap. I mentioned
> > this at LSFMM this year but I guess I presented too much at the same
> > time so few people remembered it :D.
>
> :D
>
> >
> >>
> >>>
> >>> Even on Android, which uses zram with very fast synchronous swap-out,
> >>> I can still hit the swapcache from time to time. So perhaps with a
> >>> slower device, such as an HDD, keeping the swapcache around for longer
> >>> could allow applications to hit it more often?
> >>
> >> Why is that specific for HDD? It's the exact same app behavior indepen=
dent of
> >> the underlying swap technology.
> >
> > If you have a shared folio, you must use swap cache, and even for
> > single used folios swap cache is the way to do synchronization,
> > regardless of the device.
> >
> >>>
> >>> I don't know. Maybe Alexandre can share more details about this
> >>> benchmark. I'm also a little surprised by the 15% regression in
> >>> Sysbench OLTP. My initial feeling was the same as yours: we should
> >>> release the memory immediately after writeback completes, for both
> >>> synchronous and asynchronous I/O.
> >>
> >> Right. And see if we can identify why we are swapping out the wrong th=
ings :)
> >
> > I think we are not? It's about over-reclaim. In the worst case we
> > might put every anon folio under writeback, while no folio is
> > reclaimed, if the device is super slow.
> Ah, that hints at the real problem then? How confident are we that that's=
 what's
> happening?

I'll set up this experiment again and return with numbers so we can
check what happens. I remember that at first sight, I was not able to
understand the cause of the regression so I'll need other pairs of
eyes :)

Thanks for your comments,

Alex

>
> --
> Cheers,
>
> David
>
