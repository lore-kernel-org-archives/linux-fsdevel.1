Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E9B36A379
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642056; cv=fail; b=h5xIqPALp5ioNsWI3WlF/RN5uF0ONqA18xaPQ06ycwgtTrN1TOS+IwbQ151/uBnwKjGo1Mn5MCqrdBsi5pHaV2ScvG9T5bkOnXLWH0jGg6/5igcjCXcvjupaTsv437+NDlQkJiYBRmg1Gbfzuoirsi28S0seGIDR8CGEbPCvhcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642056; c=relaxed/simple;
	bh=uQjH5hMWyz9O+GFYl2JZlamv5wv6cfL0qyNDcHOzOGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8InZk5eKBA8Bu7btL0PXbRVesIC2sGMt04YF46ea2gLQbGgTmLP1DMk/nL4dStNFAXLLLdsoGqPllytuY2R2B4+1IWYmbld2Ra1U5jaobAsY+mvVLDy2oqyntS18epLHR2sLsMBDA5dovpQSON9rPhhsx2JHwOjI6aXeuMhPjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YBD+2Dal; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YBD+2Dal"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDmk6o870342
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:54:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=LUQl8w/tCNZUmL6ORH+1PSjLkxbMu0iDqkOMcb+z7d0=; b=YBD+2DalN3fz
	5/kGwOBxcA62V2lOVTTPZWAE0381NX+BmCWKGpqrFlz4AUru9T5bpCpH5J3XhYZV
	nQ9WNhhLv8qGmjpYEx9Z48/y1cruBOlbsQEnj0/YAPiNBAEjx5OZrrnsYg06kOVh
	YgTR/klJD1Yxq+pR3+66ivQyp90Ynyo9hdLENOd5HYKGZ+oxQ1MdUd/lLg5b6wDV
	MghHOpSNu6LFQAtKkj30kJ1F1V7B44m0z64NPV0Hs4UlYYEy6gz/nIB+5xRGxeIc
	hRAyTWP3vsLTUclgdkqISWAvPU0D7WYUaQtyOCzCaKFK+wyvh3tgfhaOrMFvsRgX
	NPboe9Ajxw==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fgx3jw3rr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:54:13 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-69c20d12deaso8067027a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784642052; cv=none;
        d=google.com; s=arc-20260327;
        b=EICQM8Q1vvu+SEYfvBqFIMf1DiMUcSRGvdDkOOut1oAOD6sUXaO1CBJe13bKBrp8uU
         PTeRuHKIRwzJKdVOKA4nqzDsUMDwUqDdimtFiiDhHjH0Gi4GVoK5X8CH8kw87HjS6qnb
         haxZervq/SeOqvlMAsd2k4adVPP73m52mKzsLCLi38Xfp1+GYyHzWPo8i27Y1Wn7IRL+
         9CCk25PxJ94LBA/+TUMm5Xg7URIRhXeAGxtPJXvHNS20BAGyPmAmuEnUV61O0SxuN6eQ
         f+DFfGVsVeOmRA9is5PEEN3wRhHzZtMbYp3haxgiL3Ocbe/Qn+ZX0xs5i064V4m9xren
         QfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=nIDL80KtD6wnmPSqCXrQiaALT37Hkoclb/wbnqMQCZA=;
        fh=Fkm0ncSBRsj0Psj8/cwDGWUb7uCW7wRU5uhZqfD0eww=;
        b=d9/52eu2OTrU41vz+XXJ/U64hI/pKYsu4z7UCtFglLv5d82bb7eCEw0TE03r1varOY
         cMJ1JcSgVGwZLKxQZ0daWPiSzfYq2UN16XSYzeZDALH9GElMjaHbBLRsLAvk1FihGmHv
         a0xrNnqdtAICtVWt999uCib4cn8wLZYFSR876/6WkRnWVWGYPO0vKkpNJSf5WtKsV0xL
         VS7xhWgg7Ey4GSW0aKzBnC3uoqn6F9jdqk9+6AnUp+3PUR+Wf/piW72lAIHRPJiOGt4x
         g1KQ7xHSDjHp6XD6rDLZFebKP+moaPjVzzxspkri607z2LIxIGH1nrwLIwmPdqpTpkLh
         /baA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642052; x=1785246852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIDL80KtD6wnmPSqCXrQiaALT37Hkoclb/wbnqMQCZA=;
        b=AqJv6RTG4BaqggQ7rDQ1SbuHDfLEpvsB7Vh0c3RcwUBoHGqpfo3+IvXaWKYoe/zpQC
         P4JCcW7BKtTDC4EB3smpEGQl4hsMoK7NVZMQ0XKTcZuLOkgue3fDrEfuhVISRYnJI6NT
         9H+ObN8HccOxatlTI06bt0MuGwWNa+lrldFoNYg79Ti0UzSqgm1GVJtOBvWJjNr58v0+
         Xyioc2wzHhchWTFmMUjlu02mtOvhQU6B7QmrJqf5CkmfMPUVTRYiaNHJWi1Xdnwe+/nu
         oZFm5hZAwNsPv1Xt3Fb+gDIjc408rVtPFiR0dNAoI4dyHLpIj+M0SmVRbGCfDWoa3XD/
         bx8w==
X-Forwarded-Encrypted: i=1; AHgh+Rq0OCiUX14oBGlwcJmOmIgxo2qeHj5jC4MsepC+sFtCIeNF/T4q48MOv4PtmG1q3X14gK3fqpVrXVMx9y3O@vger.kernel.org
X-Gm-Message-State: AOJu0YxDl120Gp0I2oZUizOxspw1VRVrX9d48kxj/1JemYBDhSXm1ixP
	qYMLl1MVj9W+A08GLT3NNjQ/BSLeaf5HtPjUffKNtj525fLlhuoofKye1OdaCMDbRfsSoQzPoy4
	Uwv3l68SmamfRetZ70j4Vm1lhUBKCN/SRHtHvJ6szbMKDcoPv31DabG8a4pMPwF0Numo3LNWy+d
	vJXqUaQT8AhM7HMiBLaqy2SalM9iPBf0FRw4bprFfi
X-Gm-Gg: AR+sD12QZNym8m4ox0Au/ZQfmybrNXwn3khmylKurCjq8xTQSvjmPgV2CxMR9fs9u64
	MJgRCYkKbXGTHQc5SFKV42H+IePWGg64JJdbUo7BTX5rHSmVzFgRXYTnBdcgO1JeivNYWFbhqGx
	/H34FvqOtQGou/o2lLmclPEi7gSnw38yaOu+L1g7oOD+IIb8GvySm1OmDXzQXHuUYOb8ayLFIc
X-Received: by 2002:a05:6402:20d1:10b0:698:4857:da53 with SMTP id 4fb4d7f45d1cf-69e38d60f85mr6616489a12.17.1784642051920;
        Tue, 21 Jul 2026 06:54:11 -0700 (PDT)
X-Received: by 2002:a05:6402:20d1:10b0:698:4857:da53 with SMTP id
 4fb4d7f45d1cf-69e38d60f85mr6616475a12.17.1784642051593; Tue, 21 Jul 2026
 06:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <CAO9r8zM9SQR97cAJ2wLuJKjgi4oYatPP=3B6j=-hUhNFiGHDFA@mail.gmail.com>
In-Reply-To: <CAO9r8zM9SQR97cAJ2wLuJKjgi4oYatPP=3B6j=-hUhNFiGHDFA@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Tue, 21 Jul 2026 15:54:00 +0200
X-Gm-Features: AUfX_mwOdaiucsoBFvADdhFUV559YASJcxIW5cGawfUdA2jp8KNiQTFQmXojK88
Message-ID: <CAEmasaUxAy1LTtWwOvTurevGiGW5L4GHqDksiOT-XPN6_s=rjQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: zswap: free cold writeback folios promptly
To: Yosry Ahmed <yosry@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Fsk1OWrq c=1 sm=1 tr=0 ts=6a5f7a05 cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=VwQbUJbxAAAA:8 a=2e1iedC-D93VWRQiADEA:9 a=QEXdDO2ut3YA:10
 a=j5kO0B45gQVIxiUYEfTy:22
X-Proofpoint-GUID: 1j4vRqP6jS4BVxjcuWr6mjGodtTbMOpN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE0NSBTYWx0ZWRfX2OuxG4M9I4HC
 4JjrfOm8734BWRudRCpsHEt7QpNUKl39+4WAeuQhEBq1Z01xbCeCo4s532zQ6z3+4r/7/gXnhdO
 isvj8pCxGRRrCDTnxuihxu8cKpBMTvjlcNvX0GSI2Nwu0xuFXLUmmYTEodtfki/Zl/1hGVXLOul
 NkVKtSiixSBImmCLUvqLbMUA11ItQC1XZSq0BqaYbuBk3kFimhMbB2K2zUlCqx3+YK8e8o+iSWf
 DAsz53iUFdwNecl61bsOnLgVuVTuAc/rEi3gOgiBCSQ44v1Uh8QNQX+RH+71H8uI78LFg0Pmw+8
 MNRSlUdNNKhktmFX1HGCddwTC8JqTvd4lWzRifgeCAfRc97VVWM3635uHSWc5oGF7vOlUfPWLaH
 fqFuz3hQGeqp1heuWaIcGoZgTP4TisJOseuIS/GbkV4rVbk5gFCD4iCvW683oyF6NTqCvYgmAQK
 +vCP7zaM2pGHZu/d4Nw==
X-Proofpoint-ORIG-GUID: 1j4vRqP6jS4BVxjcuWr6mjGodtTbMOpN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE0NSBTYWx0ZWRfX0LvZ+MeexyRV
 nfQiE1MJVBqmNv4Kh4b1ZYkn3ZGQ1bEtB20dCb0I0cM5CAXFjFvs/sIkRWaKMvAihQPr4hESpP1
 xsVIgNmnIAbRAEOcbCW0dtnzwfoAkpg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01

Hi Yosry,

On Mon, Jul 20, 2026 at 8:26=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> >
> On Sat, Jul 18, 2026 at 2:37=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > When zswap writes an entry back, it allocates an order-0 swap cache fol=
io,
> > decompresses into it, and issues the write. The folio is cold by
> > construction, yet today it is left on the LRU for page reclaim to find =
and
> > free later. That wastes a reclaim scan and keeps cold memory resident
> > longer than necessary.
> >
> > Free the folio as soon as writeback completes instead:
> >
> >   Patch 1 - synchronous-IO devices (zram, brd, pmem, ...) complete writ=
eback
> >             in the calling context, so the folio is freed directly ther=
e.
> >
> >   Patch 2 - asynchronous block devices and filesystem-backed swap compl=
ete
> >             writeback in IRQ/softirq context, where the folio cannot be
> >             freed (that needs the folio and swap cluster locks and may
> >             sleep). Allocate the folio off the LRU and defer the free t=
o a
> >             workqueue, which folio_end_writeback() hands it off to.
>
> I took a quick look through the patches and the implementation seems
> too zswap-specific.
>
> I am not super familiar with how the drop-behind mechanism works in
> general, but it seems like it's currently intended for file pages and
> not swap-backed pages. From a high-level perspective, it seems like we
> should add support for swap dropbehind in general first (regardless of
> zswap), e.g. by making folio_end_dropbehind() properly handle them,
> and then have zswap opt into this?
>
> I guess one of the challenges is that folio_end_dropbehind() only
> frees folios in task context while we need to support interrupt
> context, but this also doesn't seem like something that should be
> handled in zswap.
>
> In theory, there may be a use case for doing dropbehind for swap in
> general, right?
>

Yes, you're right, I have been focused on zswap here but that should
be extended to swap in general.

I only have performance numbers for zswap though, so I need to verify
the impact on swap in general first.

Thanks,

Alex
