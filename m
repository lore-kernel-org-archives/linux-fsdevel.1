Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA923A561
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314031; cv=fail; b=nTFRNB+8gnDheqYjHjUYmPt42tPH8wC2tKNm5EFzpJ4Q5VNO8IrTTYnbDOYr2VXiQeNsVC01MBVJYARdLUYeeGlqWBinEql8M+2aX2HtW5z6PRC+6XA6eJ6JN8o2EO+nh0ulZH1kSBQghzf5OCZWOeZXYh8rosIDT/jno9Cjnrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314031; c=relaxed/simple;
	bh=xHOHSL7wIqwENHkVCRXYLATmzjW2mTiWLA1DQi0LJeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsDgf/7imvIWqb73G07UOfD0U5+XwePN05aIN/Skp+TLXX2muUFBwVNPY/WspjCyR01g5e0xXSqxSiB/QLnM/f+BK3n/et3y9ewu6UCk8Z67gde6WtKEikC3okqinBWAH7xhgq5jZ4t24Il52iH8RNpwTY8W5cAbWka1WdV+5kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bwMntoPE; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bwMntoPE"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7b35e2812193
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 01:33:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xHOHSL7wIqwENHkVCRXYLATmzjW2mTiWLA1DQi0LJeQ=; b=bwMntoPEGCfZ
	vLb4jl8esaFbW07FRkY+W4ZRxYySZM2TSnAelvAW4Obp7qdVv7Wj5Lm1CAlD3UBj
	VsHaobQLAmMjES+2B68Wgn4PUFXLLeHwgRIw0Bwk/UC7j/NjyLpDmCcX8uMqkvRd
	f5vzokZz45XYYCOWGrlM1SkhPTQDfeD6WYuMUmV4L7vmvzgztz2hwFgwqIQPwbl4
	bznkX74FdH0ApZlqNnoER1lLp3W/bBvXRdGWoMWJHhh69iEHsU3KL1C5k5+FJ5tj
	LxEP7WlZERreotV3oH3hp2XLhJPmpNJu+F00T93pysUrkBDxOeX7wbEXpbMys6h0
	q7EEcGJvJA==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fq2jqc80k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 01:33:41 -0700 (PDT)
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69e3aaf5ea3so769904a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 01:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785314020; cv=none;
        d=google.com; s=arc-20260327;
        b=QclSmc/oEDiomdU1mUkPU2pJAzkaD6Rr0thgol/nhSFv8RrTUINpgZDanIOjpNSo8F
         71VsnfVTQ57BlCFx7VneqhgT9K4tN+zY12cW2CYNEAZ3Za35gxqtrZ4xM8outo2HJWdS
         3NRCARs0HZg8NKJToCS1ppBWFNGAQVfruSjHf0vZeSX6SMjAWPHXMArYET3NKC9XHjfX
         +QQmTFT5+sgCddZe3ppsyUfd9y8E2M6cU6i5DBY52Jl7JkL1iIx/tdkBbZtFqRO54zsB
         vJXXeqvAAny6Ryw/HCn04OQr0dOr5L18MElvHkyUKDNq7sz+vPjkOhyvQYPRfL3uRgfc
         /Ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=0m8FfkqDL8jxVw6MZ4LNfm2sDk6OhFIjZr8urbPEdTc=;
        fh=WsERLRSsdIuJhumFPT/5fENDcNopQ6HBRcFBkJZwhv4=;
        b=C9deWTIN0I9TbUU4vBhI1MwXorjtFlutBl7XOTUH+AdCpfPqRN45H0JiIP1TbAWMJF
         G7vEzlUzDk7498/lx0S1XYyTHqvqH4Ucp2v5CxXc+uawg8lxEVwvetUI+h51zO/66itE
         x4YV7ICWUDVwm/b9k+KodvxRJOqnlkDIgMwUrtRuu/jy2JA2xkb1HxgkNdZ4f4uhp31v
         Xmd2B63S7shbzNWCvsz99L54msg9ZBsgGwibSNP3YjK2qDWHcVuVCDiyFzaGHU2cwSHh
         mUM40x/eTWdvKEyPUWObxSwcLd8Xx52L+7qpUnsaB02CROaIeGm3DYB0pZra6IVE0nyH
         Eplw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785314020; x=1785918820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0m8FfkqDL8jxVw6MZ4LNfm2sDk6OhFIjZr8urbPEdTc=;
        b=qBrIs1gpb2yZ/PWqTdWVn9qxGX45qIO3fmsgXrI3dhU9avo2Ak6E528xE1QAIM2ftf
         gH6xOEhwxAYDIeCKlmC16XyUo/jaJ75WvQ6Btb2Q/3uis5X2EwxEHSdE/tDL9NKVjSny
         fmcZyYCnngEwnK7tu0Exw4DhqbmHSHM8pS1f4AqT6NFxvU9uVTY5UaQbSuQ9ZbKqA5Q/
         FCPne6FvH9bRw6gKPPHiRjtV/MEv/MdbzQfN+f+iaVricbXb/Axa59xoBuiwyTFsWVZk
         5mhcfvooghL8p3ba86+A4aglCqHN/ZYsskYjc/5CxkzQSgDxZzCttVC71bRNiUsCQd1+
         1vUA==
X-Forwarded-Encrypted: i=1; AHgh+Rol976mgoMEKZAjlBFQBDG9lzJivvRZ/cKS0UO+AGZ1fsKqT+ezxHo4pKphd2/lNBAZuGyxWOM23yX9qnj6@vger.kernel.org
X-Gm-Message-State: AOJu0Yybklvslfs/LGqXMQEHRhlTSMBhXZBhZPVxkq6pQkYUSeyCDF73
	lwipCoRKMPafSgT4COX1VkbN+YayGNvS8L8/dHX8NS89QHZdGOsF4LAw/DEFOQh5yYns8wdn909
	IKmiGRnlkXxd6fUDYscpdC1uQlvTNGvceBZTERZv7/SAAy9CVDqwRpwZcQWc8ziuki3ut24p1zV
	i7RbNIOFK4jks/l1ZS34TMYzyM7gw5z43aHM5y+5Bs
X-Gm-Gg: AR+sD10cZ68VQMJXCXCYH9F0EspGIoy9bCmXP0Adf6WKKjAOwHlwsG2liwXz0wpWASX
	Ferpt/8D+wpz/qYiu0vj31JXripEodL0I9pYCjoH4pF0/sv6gWXzWBsDjGdDdQ4GAhF6PlaqJbW
	J72TFlLvnxKbU0cOyJ0TLUI+VrMbGLcvkbg/1p0jgG7kdeKBBmprSz2laBNp3b/hTDXOBDYBOEr
	uNcr9+yBxF8sA25/w==
X-Received: by 2002:a05:6402:190d:b0:698:663d:d7bd with SMTP id 4fb4d7f45d1cf-6a034a5289dmr3073076a12.11.1785314020028;
        Wed, 29 Jul 2026 01:33:40 -0700 (PDT)
X-Received: by 2002:a05:6402:190d:b0:698:663d:d7bd with SMTP id
 4fb4d7f45d1cf-6a034a5289dmr3073047a12.11.1785314019553; Wed, 29 Jul 2026
 01:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727143618.1582318-1-alex@ghiti.fr> <20260727143618.1582318-4-alex@ghiti.fr>
 <CAO9r8zNJ1cfCVgxtpqx4Db380bjZ+Z0P842eAxPXw6Mh4XBrww@mail.gmail.com>
 <CAEmasaXR5EmGCv3T5AzM_2908R-VjfMcObrACyVGokY2U=+i+Q@mail.gmail.com>
 <CAKEwX=P5G=Ckafy6fm9ws3njWP_Zm_AHRKOFERScB9Pkd_KvGw@mail.gmail.com> <CAO9r8zNsZUvMknjmH7MvkQ=09DnB9YvtYoA0ei5Hj_cESQAVPg@mail.gmail.com>
In-Reply-To: <CAO9r8zNsZUvMknjmH7MvkQ=09DnB9YvtYoA0ei5Hj_cESQAVPg@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Wed, 29 Jul 2026 10:33:27 +0200
X-Gm-Features: AUfX_mzrgjxQdJlYQ4l0vfOQ58v9c5M3PN-13He29IFXJZCQQKJaLgNVSTbMeMg
Message-ID: <CAEmasaVfZqXR36JoPkGnNDTW3qY9wni1+5Qt4-Xs8a+tFpdXrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Kairui Song <ryncsn@gmail.com>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
        Wei Xu <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Fdh49-aizkFvYC1Mom5eN-GHdLYueTjE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2OCBTYWx0ZWRfX/9BAtYCc4YYz
 19WblJWsZMsehG0lOY1BLMm7DUgse6VcEO3O4e1IR5o8PHNCn3gMB/qY1SJMN1c/RDdNtLEj+ow
 7H1dCF0Nn1oYbrQvwa+ZVt/RWOLmMcMeaYJXelRGuyBkDl42jdCl7JT5oJPe5gbZt+3Fnko0fdx
 P7qSuQLv+h5MheRD/oGF5QvKNGxKv7z8abjysGlZsehKO5ljPbOE77xnrRyUxFIJwNagHR0G4V+
 E+QQ2LcMz8x+bq7W3sXgt1fz9YpXDOj8OvqJp869uGfuEllOYiwvYAQk619xBQ7muh9JtXj/Js1
 ORjQwO/bzrNlHSbvCAb2J6Cc6YOoGHGZU9rFDrWe9AOF9V02ksR/f6DYh0ypMAC9YjoDwqYu1kp
 D3NIlnohOFWXlT8MXHXv+yMJG1WT2Gzn86peYwPP6gA5qfbQEG55tOtsusp5/kwiityN4vdUytQ
 AKLrzuP/J7Ett07cJuQ==
X-Proofpoint-ORIG-GUID: Fdh49-aizkFvYC1Mom5eN-GHdLYueTjE
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a69bae5 cx=c_pps
 a=CYpx6mtW7qE8U/l5VCnCPQ==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=4VkJNWZG4ZaRP7SAU3UA:9
 a=QEXdDO2ut3YA:10 a=22KAYETGZJnyhCxlFjxL:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2OCBTYWx0ZWRfX0+vznPK+Hxeh
 G6hkc7lQjB32RwiTLz2awEjtHEtuicMDbifFT3ZZOAVHM1qWZ0lm3U/bCzDu7b/UWadSuzPZYn4
 v7IH1iHQFhfRyNptv6mGSucCvV7EhPA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01

On Tue, Jul 28, 2026 at 5:57=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> >
> On Tue, Jul 28, 2026 at 8:48=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Tue, Jul 28, 2026 at 5:58=E2=80=AFAM Alexandre Ghiti <alexghiti@meta=
.com> wrote:
> > >
> > > Hi Yosry,
> > >
> > > On Mon, Jul 27, 2026 at 7:05=E2=80=AFPM Yosry Ahmed <yosry@kernel.org=
> wrote:
> > > >
> > > > >
> > > > On Mon, Jul 27, 2026 at 7:39=E2=80=AFAM Alexandre Ghiti <alex@ghiti=
.fr> wrote:
> > > > >
> > > > > zswap writeback decompresses an entry into a fresh swap cache fol=
io and
> > > > > writes it back. The folio is cold by construction, yet it is left=
 on the
> > > > > LRU for reclaim to find and free later, wasting a reclaim scan an=
d keeping
> > > > > cold memory resident longer than necessary.
> > > > >
> > > > > Allocate the folio off the LRU and drop it as soon as writeback c=
ompletes:
> > > > > mark it PG_dropbehind so the swap dropbehind path frees it once w=
riteback
> > > > > ends. Synchronous-IO devices complete writeback in this context, =
so there
> > > > > the folio is dropped inline instead.
> > > >
> > > > Why does this need to be handled in zswap? Doesn't writeback from s=
ync
> > > > devices still call folio_end_writeaback() and do the dropbehind
> > > > handling?
> > >
> > > That's an optimization rather than a real need: since we know we are
> > > in a sleepable context, we can safely drop the folio from the swap
> > > cache here. And since we don't mark the sync folios as dropbehind,
> > > they never enter the list handled by the dropbehind workqueue.
> >
> > It's a bit artificial, but you can try testing zswap writeback to
> > zram? :) Likely you'll see some small tput win there?
> >
> > (TBH I have not seen sync IO swap backends other than zram though so
> > idk what's more realistic. We don't have pmem device available for
> > testing etc.)
>
> I don't think it's worth optimizing zswap + sync backend tbh.

Ok, I'll drop it in v3 then!

Thanks for your feedback,

Alex
