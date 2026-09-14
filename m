Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42A3A7F64
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372259; cv=fail; b=mW95X5MeScEqj0cIB/XTZweNvTCqcrfo4nfnE2jcnWbLCuo2wVc+O+yNTUq/jtBAD5nXQoon8/JHDimLahD1/22eLQuK9nQhHTcVis3rBDMHey+bBtDzlI+wdEzXHcdUjZEb9j5I4560uB4BOoXcE17LkawVqMNb0KklqIny/4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372259; c=relaxed/simple;
	bh=ja06hZRWozrjKmrBxPlahys/wkv+PRDbW4qJDRTZi8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfdCkHQb7BFOFsUQe802rKxp4uvTG6VQG1PH9Ktj9iL1lKutFsaLt7E9l66A2hKiPfBOGSPApELF0CR+mboQCzIdlfYbzXZ1mx7QjDCn6sXe2wYiVjYUk3MWwA5KzvFa1izxOuZIqxuDgoJJpu3iUFMEjxHV+zQq/QLYts3r4jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WCFguKN3; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WCFguKN3"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5iXq8318547
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 00:50:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=NDOIHgRCA92fBXr4xcQP2Sz2dW6sDDwTFYVMg
	oMYlcs=; b=WCFguKN3aEEwflv8ror5uZKo6cmU7rFOYUyrhkHaXhwbfgu/10bre
	/RIqLx6XQ+UfkHiamM4+KrEiC1lluU6TZHEe2VjYHcoaHewvVPaqDqon4tUihXRf
	DzKB4y/+twXTjzgrGKbAihp11yQ2bDHSASDcjU/v4pNk2XUQz8a1R5jkXJzefoeD
	7/DL8aTU7Uqc4PO15WwNgw72HZVFuBGWWDBixr6v6R0NIADx0h4A00KlL4dZEoR6
	PtDTyRr/V+9mKFbdX687c2fMWBJWhVVmg+yiQXPlJrpXIfi9KxmKWFqu0FP6N3of
	7J3S/+7uEydaQ6N+VnHXGaFVFF0Hc2/Sg==
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gnqchc876-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 00:50:56 -0700 (PDT)
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c25edb54d22so57852566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 00:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789372255; cv=none;
        d=google.com; s=arc-20260327;
        b=dK8klANnzmwng7xmdRuqc7wAWTcSRPmeqoWJTuSGdYldjmV8WGwjrHhdKVFb9i16xI
         O+x7VXY38d0KEj2gabGLFkLlATzJ4HzyA3Nyd08S/z80WMS+AVAJ9t/n/Fh/0QHYPl+p
         LTs3RMVKn5wIpy33/qqHP3Hf7JHSeJ4TOrB2TfyY7D+rMlLKZ4+tJ03l5d3IMCgrk18o
         iXFx1GzZmJxMS5gcrR9aFsLanvm1uqP/zLo/cCLD8ZshHbAC1ahBc0OnWm3LLzA5hxGb
         kVZI8PHaK9QGnuPVZjshGqkeT4o19AuKnnjs7m97bV7/Na6lQLQdYadlycdEn4a876B/
         F4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=b5IHm3fbXcJn7XNfv0FO+D+UbV/ZMp7hfv/7cooIizg=;
        fh=VV35e9ojY/7hULCNXN6dICGZWRIm+l8iQMrXGqFqPE8=;
        b=gu9e6FF5CZeufRs9jXVsE17nO5IEAWqhQQEmY4+OU80GY+NXfGR5WTmZKXQ/eizh9w
         VZAUmJ+8sBYn6u0b8UAYwZfsR5yWxJw05ma4MpswkjkssZHsooGakrqQbSmYc+Dv93Rk
         vMJx18c9ZtW7vDM465hTo/JTE/NEP73XhILvcdtjkvvF1JwmnIQ8nmo7vkiP1Kr6WyPb
         P0tZUVcoE9trSPGP+gq4Yv6YFYK1zyYgfIOa8AfAz2HpDaQVSdC6OPAejJJKKWwhiTCe
         Q2c7G1sysH5sBrDdCRAKCR9jcOE7Wwx3GFaXI3muep00ky9IJNvU0ZZXqSF13X9Qv+Hh
         0HDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789372255; x=1789977055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5IHm3fbXcJn7XNfv0FO+D+UbV/ZMp7hfv/7cooIizg=;
        b=Nxt8D+EiyIqql71V3jun+s+xO4G0AHm4sEq49AA5QgAhznj5nVtJnvfbkWZCpW9gBb
         bgObCrzxmXd6yxiBPyIKqEqO64sLbbtNFlEwMoAJuBbyIrqVb3dmZqS57uqLiUodI9sf
         JnAKZZrig5onqtQmx4cdV1YKI/dC3mNODdq1iaupZYS45CaEkkxaqdG/RXSYcG9fFN+y
         OHJJpuXADmg1mQRLCwp+OQah57T7i19cMR/WeIfQT9DJxCOTHA9i1UeXdy++QhjJpS5P
         Qup9Aa1Y0DPgzzSDBtiZwl21AOqy6kz0eTxpcvgkXasOYcNXuePGf7lc91Hv8c4q7dOc
         ra8w==
X-Forwarded-Encrypted: i=1; AKwUvBw/3L/ZkGjPFVQrjfddx9QD1I5WT315/ET5o9fCB0FCg+B5OiOyXgBGaNXTXBf+HnXyrDpea2MBh0+9WHsR@vger.kernel.org
X-Gm-Message-State: AFuF++mbWAXq5BTUg1c5YBFvSP/IEadWk15qaktG8SXgMMiUrMpLi9v/
	JqnXNxqr7XT/usgyzWuUGmVjfgCwD0CfKKaQ3u6JlwYmY4GB7ufFp2bT0SDQnsy1KLwlTWuoPkC
	ia+MySxAA2MHLC0Kvtss6QjHdPZpWR2mRZxEZkQ+WEyrTtn03OQkpw2c1jrn/N4BYK6+uJJSkZU
	qUGwXfMOYmVdpYowHyshzmmqYxecwdE0mhQT53aAqR
X-Gm-Gg: AYBFou2RrmjnP1Fzl3GSszG97wIJIia1zCDVnS6SzyRwTr3tA5Df22/fvxAqS7bPp9X
	df+gdyzLFIKGJh3x90Ptw1NYDL8enV6j7HuZXyer6Hpr08sprdXuI2pOjXfw2rxm2ajXHS0x4HN
	8Ukash/R+rdfVFBsLur4KE4v4KC9r7sYIy10H5xhS73mfMGWnyugAmut15ZQdnZPUhWSHqFRkHn
	2ksrBUCAf8aZGNn/w==
X-Received: by 2002:a17:907:c18:b0:c25:8e53:45ca with SMTP id a640c23a62f3a-c29b87655b6mr140822266b.21.1789372255304;
        Mon, 14 Sep 2026 00:50:55 -0700 (PDT)
X-Received: by 2002:a17:907:c18:b0:c25:8e53:45ca with SMTP id
 a640c23a62f3a-c29b87655b6mr140819366b.21.1789372254932; Mon, 14 Sep 2026
 00:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911121341.178028-1-alex@ghiti.fr> <20260911121341.178028-3-alex@ghiti.fr>
 <CAGsJ_4z3bSfMTKvkXsKAz=+dzhmdGOerSfL33t2RkN0CXZV-hw@mail.gmail.com>
In-Reply-To: <CAGsJ_4z3bSfMTKvkXsKAz=+dzhmdGOerSfL33t2RkN0CXZV-hw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Mon, 14 Sep 2026 09:50:43 +0200
X-Gm-Features: AcwNN1U5dS5EtcARkFGKnblzleHf1kNpbwhWpFFrqeypIiGrF-7Hdyx4M88AHOc
Message-ID: <CAEmasaX64UPFX=OTQ6pC_XqjMqiuj+fD76-7TFWBaZFE+LODew@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm: swap: drop dropbehind swap cache folios on
 writeback completion
To: Barry Song <baohua@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Kairui Song <ryncsn@gmail.com>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Baoquan He <baoquan.he@linux.dev>,
        Youngjun Park <youngjun.park@lge.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
        Wei Xu <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>,
        Kunwu Chan <kunwu.chan@gmail.com>, Tal Zussman <tz2294@columbia.edu>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: pk5rHvhkQRrJXUb90rbJwKJDQId4sh9b
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwOSBTYWx0ZWRfX40+LF23sUU4D
 am4Egnf8AtZWmSeYqAzLTvw4RSJK535+jTcxWbjemUl9JWRDlD22d1CibRS9yTD7rASZBT8XNWP
 Fyc6H99qPLlZqkmss0zlvIPGYsOu1Nk=
X-Authority-Analysis: v=2.4 cv=M6vYuCws c=1 sm=1 tr=0 ts=6aa7a760 cx=c_pps
 a=jJvPsHQLKLf2UdvVr97r4g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ufHFDILaAAAA:8 a=TYz18Bk7nizorY65d84A:9
 a=QEXdDO2ut3YA:10 a=q7aydO1c4wibL4nb3gNS:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-GUID: pk5rHvhkQRrJXUb90rbJwKJDQId4sh9b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwOSBTYWx0ZWRfX9uSTaf6dmWGY
 9wEgvMUlY4Ov0BBEJFDNeMIe26tVH6OLSQAE6M5jFwKwbYq3da/38jJsZOafb2TiJxdi3D9GVi0
 LXYSXoQtg9JOSb9Y7r6YFsjCWz1i3DVyHK0nPlHzf0UB0PnFJwIDLuqL8PYEJ6T5hNBBzkZ/ABs
 XPeo6qDE34Q55wglcFtnzU5rRQp9j6KXl7WMiUuBCYV7khbCEy4J1ZFEfqqCKmrho4NsCQ+JwFC
 kBtAHbIB/ZM9omcS1E8zY/3quH6C3XLbn+kg13KkuIpPlMdqab1Ex6C8tYVpq5bZvI8rkpHGiof
 pY0L4idajwuevlDuujuTprTTbq2WE/77DljbFJMg7Wcqvo2uE9n4uTuxfox907fHj9IYUtRY1uz
 5X2u5LefqtzzTBuK0dmegOHmW/BlFUGtOFfgu9/nr/wF4HbhCxF6YHffgLcZJ1Gj1e2fuv5wIRO
 aCeykGXReCyzFjO+Ntg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01

Hi Barry,

On Mon, Sep 14, 2026 at 1:01=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> >
> On Fri, Sep 11, 2026 at 8:16=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > A PG_dropbehind folio is dropped from its cache once writeback completes
> > rather than left for reclaim to find later; this is implemented for file
> > folios in folio_end_dropbehind(). Extend it to swap cache folios.
> >
> > The drop takes the folio and swap cluster locks and may sleep, so it
> > cannot run in interrupt context. Set BIO_COMPLETE_IN_TASK on the write,
> > as the file dropbehind paths do, and drop the folio directly from
> > folio_end_writeback().
> >
> > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > ---
> [...]
>
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index 88962571cb93..52eae99de6e3 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -602,6 +602,15 @@ static void swap_bdev_submit_write(struct swap_io_=
ctx *ctx)
> >                 submit_bio_wait(bio);
> >                 end_swap_bio_write(bio);
> >         } else {
> > +               int p;
> > +
> > +               for (p =3D 0; p < sio->nr_bvecs; p++) {
> > +                       if (folio_test_dropbehind(bvec_folio(&sio->bvec=
s[p]))) {
> > +                               bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>
> Thanks very much, Alexandre. I find the code is really much,
> much better, but I=E2=80=99m still struggling to understand why we need a
> sleepable context after Wenjian=E2=80=99s commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=3D=
848d2ce2fce15fbdc083fbf9691bfa72911033c4
>
> With this question:
>
> https://lore.kernel.org/linux-mm/CAGsJ_4wj6XvPB+QF+_X1BJ_8Y2sZEEFAw6RaJJz=
-cHaDWLkxaQ@mail.gmail.com/T/#u
>
> In short, it still feels a little strange to me that we need a
> sleepable context, especially now that we no longer call
> `folio_unmap_invalidate()` for unmapped folios.

The thing is the zswap writeback folios are not on lru: that's because
if we put them on lru at allocation, the perpcu lru cache holds a
reference and it prevents remove_mapping() from freeing the folio (I
measured that with on-lru folios, the freed rate collapses from 99.9%
to ~3%).

So if we use the folio_trylock() approach, we'd need to put the folio
back on lru otherwise it would be "lost". But I don't think we can do
that while someone else holds the folio lock.

That's why I use folio_lock() which can sleep and then needs the
sleepable context.

What do you think?

Thanks,

Alex

>
> Best Regards
> Barry
>
