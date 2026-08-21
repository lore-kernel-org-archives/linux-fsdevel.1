Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9F45DF5B
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305532; cv=fail; b=iG4lNuTWsx+UZS9PTD5KsDOv/ZWSdCcw0m20qjVIjthZfXLevR9AN33GlqCedOj4Zy3OgSVCMbMpXkih8Kcu0/X1VFC+Dk6YUxij5DcovmLtqHPoCp0ZBfGCe4CrU9b9uU2z1ydxDuIQw4g0JolDg7YQG7KmtClMKwCcfyQ7Nyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305532; c=relaxed/simple;
	bh=5zSh6GMGulAsGwmYi6TlbvXzaG9RG0GNdcKuajZowww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BM3VLQfY3S9BHHYZJQsHXLqQyoen1oFLhMepU0KXPyaYX8zzabvQ0PHx3spabTdovMWmFbw5p7ZnKvjOV1AK/3yTAnb3yvFHW5t9v4NJSs2RJM2JjdCOwnnk5QO1KX52C6iVB9qufWqInExVg9XoW1XB3p3Ir+vmzYHBaTqrMBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NxCGu8eJ; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NxCGu8eJ"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9LrLK3789837
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:45:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=67xWBhStUlEa5ZCxXGQASV+DpM5l8oGPnwA7u
	XJMVYs=; b=NxCGu8eJ5CmY8xTc+8eRhlNpHC6TWP3eL1KkX0I0K2H2qCBm3fwcd
	Rip6LSwpSngQggQBw+qTX2hc4+k3lLrzR3PpauZI5VhBCqhA3s3i2U3qxGNs0fJW
	QYE9sVmZNrHICVa91aFEHfwcul1jJTu3IMJDXQrfrmFvvyHTUt3K2YhwP+wEEpmO
	FlCaA/bkTaqeioWMGa3Sz6TIT/0AgkrSsNJLdaPjFCw6ooNxrAoIOgDMFQIL486b
	Qg89AdKgkluLSkb8AjDlA1BND6aGW4Hc5nU/WB1n2uxctvufTf5faygCvNE2RKsy
	/SpNnJTb5cenrXxCXi149HsM1YQh2/g9A==
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g6atp31tv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:45:23 -0700 (PDT)
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a36683ee94so903034a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787305521; cv=none;
        d=google.com; s=arc-20260327;
        b=K1IP/BNFtOW9Ag/aKHuvA/fK+/8IATwsGNCxEY2+wg4c+9EckNd1PUj0xWuTqdyFU0
         SkpCpCkzJOuZKG9Yg+rKUcVPSP2qobFZFCmbig77rU8O347DxYMxdg9fRYnJDPm2S55N
         wu5yHgCOsADdbw7e0VCMp86777GSqNTH4b98UEa3106SGQCE1I2cmcrYBGKTrjtyKqKy
         2P1178PAJ8yS0TeDwNIgymSOfQFEl4gmS5sFQEqKHtSKH96yohED6dHekmncbbgUf6tK
         +jug2sxButlZsC+5xgIyOfZ8/6xZYSs23XJ2pH6xK7AoSf4jxIqpkRo7WUmup2vlrt5g
         sVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=40W8wfxklkZeQ+jKlByOaxuR/jIsuDaNHmF/e7+vztg=;
        fh=nSRqbxx0GjAwgrR0pAoQ3626zK0IWNsyFHYF+3Em1TA=;
        b=kKvxu6eInmeYj2ayZ+b0UJQbHhT/+fSY5p4tlSomKSxHjrx3kAkM76ps+Ab59uCTsi
         JRRwr89Q+ZEs1NqZraIwpaIBBJfHZQ5VUJHAYG5HcxV2Al3QhVlzw74Sjb0+/92WZ5Lo
         N6t1utXA2euECjVjG0tFCbvMDdtij4DYkYMZCA8PZf+49ClTrbHpwbsoUs/nAEe0y8sW
         dL28XOfte4ciFg2oIAo4ISMdfocJCfe/BN79bbikUg0K3WxIuFPuc2cUaKjIkNWPZiBI
         PSLriCZDM4uCJ0ZgL5hP48eGT2m/T4UkEHFR00DO9tSXJIe5tOCu8zC7fx9ELnYAcHy4
         1PAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305521; x=1787910321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40W8wfxklkZeQ+jKlByOaxuR/jIsuDaNHmF/e7+vztg=;
        b=s4vf2BYX0ZxzXtdHbjfLghsSX6OzR9chNi0qlUS9bVSou5ewpjfuRmrlIe1pzU0C+b
         Zh/7Tpfou/HcrO2e6piFUVlVAT7Yw3fZ/0t+ffkkqua4jEsqWaBLl6WRBxiG4Uks05Uj
         GawYtkm+Q7uJ4++QTdmo7Lc+HeKbcTb8t/vPCfFQWewKzjqoYmlKHUELeYXSEW+xfkja
         6cnZvXBQpIdGBVhcRKhv7llPvAXSIJFBc+gyygz7nTGMWmo9w1meQ+7SbioYIYEr3PZv
         XAyx6uUWttXAqrlWJkRBYt+po36vP+7LglutWi83T0BygB22CdVsQy0p8aKvb9g6LEGW
         talQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkCRdjCqAF15fOVVDIgMEHI/Uz/n8Wa4bcsqlRQiUbY7Mc3uutM4LioumqX9CQm/6Q87ydOJMJJN+sHg2u@vger.kernel.org
X-Gm-Message-State: AFuF++nWa22KKb3RIVgljC2+2l/MHRUapdslC/GPKTnBuge+hPgmW3NF
	pH8qpMQ7lv2v+7M+yjhvU/roQaPsD8IlqmwE3pv3szENe+Ahy9//OGTZZp0ZbUvlbq/RVUA+QKZ
	OmjiMFFbhl//WbHvhLiT8Fr/fCjUtVrODD0mnR+OfIDOLzSbayvCBoN35J1v42s5kdOmyVnWTNF
	BruIfMw0ePb6QSj7auyZl30NjNSx+F6RCITjdHcsEk+X397+R7x2k=
X-Gm-Gg: AR+sD10VycLVvBE+KCqy3iZYrqKs2BQYT9GbsB//4nwUnyEGZ0u3gv5WpP7frc53yo7
	nm3+7owJQQlswARJyMi1wVVJhXVP9CDvcwQwWguzM3rnHMV/euRLXbRpTmElD8n956TNP60aGp5
	JsKd17dN0sIEqbFamEFrq+EL2lyUqvVQQ200UqAUurcm87eByl7Q+/PRa2z4nZv9r4buh2xd6KV
	hT2Pwe2EwtBUU1vYQ==
X-Received: by 2002:a05:6402:44cf:b0:6a4:cc9:e32b with SMTP id 4fb4d7f45d1cf-6a42f23958dmr4744382a12.9.1787305521577;
        Fri, 21 Aug 2026 02:45:21 -0700 (PDT)
X-Received: by 2002:a05:6402:44cf:b0:6a4:cc9:e32b with SMTP id
 4fb4d7f45d1cf-6a42f23958dmr4744295a12.9.1787305520648; Fri, 21 Aug 2026
 02:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818163221.589352-1-alex@ghiti.fr> <20260818163221.589352-3-alex@ghiti.fr>
 <CAGsJ_4zC+wAuevG+i5y23rLPGXn0P=D7JpMECnZ1OuP1BsyYkw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zC+wAuevG+i5y23rLPGXn0P=D7JpMECnZ1OuP1BsyYkw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Fri, 21 Aug 2026 11:45:09 +0200
X-Gm-Features: AcwNN1UIrj5zAkato_eWA3fSuUoLbRh0fjctNdO3VB249rMLFedXk0i2OTg55Iw
Message-ID: <CAEmasaWsSqpN0VwnepBs3TcGydG_C91RNfRnX8V==LSS0mwoqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: swap: drop dropbehind swap cache folios on
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=UfhhjqSN c=1 sm=1 tr=0 ts=6a881e33 cx=c_pps
 a=Tczdrg5if7+wQeIJmxD/XA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=mpaa-ttXAAAA:8 a=IeNN-m2dAAAA:8 a=ufHFDILaAAAA:8
 a=pGLkceISAAAA:8 a=XUwypK8endxQsPoB_R4A:9 a=QEXdDO2ut3YA:10
 a=1oAhN8tkTtOBK6_UvoHx:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3MSBTYWx0ZWRfX3nH47c2CXd6L
 yfLiqBGlFQ3KMhbwW/xsWpUg9WsEzDLJWBTgN6sJYZMoFm0Utl4kCMCglIzcMXGtkcEoZmmPjbX
 s8lPMxbhKaF56G1M89SJyPpqNVjPkh5r1sPLd1p/m7fXO4JZNmq5oAFUxl8zRZxjm6uNY01pSa1
 0np6Kc25dlQA9LheDGzppVC+X/GNzk/N3P0DGojV/1KHRkf8qWiF5PoeIsjHzr2WCLVIJSmpBrq
 aY3QJfnHqEixf1MHGXlY2rHyqZLGWroktpD5oVDpZiFiZvYpjrLf53ivGVRl8NuBF7l9cfLV0Eb
 UGLZJUYMqCC55z5IRQWW4OXEu3WnY+WEapY6iCLOYSh2Gu8djxdb7qlFJoGvPuJBUEGf5h1nesh
 SHEJJJNtSRdS3D49PFanI314ccHLd4McNkqmJ6qcDaOdl3MnJpdE5vmHRC276zGCYbG1dLIh4x7
 g6RyiUEL7eRmvAFGZXA==
X-Proofpoint-ORIG-GUID: diVGVTuw3zLnz5X1vXJb4YkgJo8LYLwb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3MSBTYWx0ZWRfXyRr9opu56wDR
 FLgXh16cPJ2P6v7R3QpItIUDJes2fkfOgbNH3csU5GOe77I02ApRFadKh4kkndif9D1Q2PE8DKX
 3LUiiLd/4vUo/uvCudRve+Zx8OZEhYU=
X-Proofpoint-GUID: diVGVTuw3zLnz5X1vXJb4YkgJo8LYLwb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01

Hi Barry,

On Thu, Aug 20, 2026 at 1:37=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> >
> On Wed, Aug 19, 2026 at 12:34=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> =
wrote:
> >
> > A PG_dropbehind folio is dropped from its cache once writeback completes
> > rather than left for reclaim to find later; this is implemented for file
> > folios in folio_end_dropbehind(). Extend it to swap cache folios.
> >
> > The drop needs the folio and swap cluster locks and may sleep, but
> > writeback can complete in interrupt context, so defer the work to a
> > workqueue that runs once writeback has completed and frees the folios in
> > batches.
> >
> > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > ---
> [...]
> >
> > +static DEFINE_PER_CPU(struct llist_head, swap_dropbehind_llist);
> > +
> > +static bool swap_dropbehind_drop_folio(struct folio *folio)
> > +{
> > +       struct mem_cgroup *memcg;
> > +       bool dropped =3D false;
> > +
> > +       folio_lock(folio);
> > +
> > +       /* The folio was allocated off the LRU and nothing re-adds it h=
ere. */
> > +       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
>
> Hi Alexandre,
> Thanks very much for your patch!
>
> I don't quite understand why we only support NON-LRU folios. Does this
> restriction prevent potential optimizations for madv_pageout?

In the current implementation, I re-use folio->lru to link the
dropbehind folios for the worker to free, so folio->lru must not be
used, hence the folio_test_lru().

But that does not prevent madv_pageout to use dropbehind at all,
folios are isolated from the lru and moved to a private folio_list, we
can definitely prevent the latter if the folio is marked as
dropbehind.

I'll give it a try, I had only tried setting dropbehind on all swap
folios which caused large regressions.

>
> Also, zram might benefit from your patch in the future with
> asynchronous hardware compression and software compression such as
> kcompressd[1].
>

Thanks, I'll take a look.


> [1] https://lore.kernel.org/linux-mm/20250430082651.3152444-1-qun-wei.lin=
@mediatek.com/
>
> [...]
> > +
> > +/**
> > + * swap_dropbehind_free_batch_folio - free a dropbehind swap cache fol=
io into a batch
> > + * @folio: the off-LRU folio whose writeback has completed
> > + * @fbatch: batch of folios to free, flushed when full
> > + */
> > +static void swap_dropbehind_free_batch_folio(struct folio *folio,
> > +                                            struct folio_batch *fbatch)
> > +{
> > +       if (swap_dropbehind_drop_folio(folio) && !folio_batch_add(fbatc=
h, folio))
> > +               folios_put(fbatch);
> > +}
> > +
> > +static void swap_dropbehind_workfn(struct work_struct *work)
> > +{
> > +       struct folio_batch fbatch;
> > +       struct llist_node *pos, *next;
> > +       int cpu;
> > +
> > +       folio_batch_init(&fbatch);
> > +       for_each_possible_cpu(cpu) {
> > +               pos =3D llist_del_all(per_cpu_ptr(&swap_dropbehind_llis=
t, cpu));
> > +               llist_for_each_safe(pos, next, pos) {
> > +                       struct folio *folio =3D container_of((struct li=
st_head *)pos,
> > +                                                          struct folio=
, lru);
> > +                       swap_dropbehind_free_batch_folio(folio, &fbatch=
);
> > +               }
> > +       }
> > +       if (fbatch.nr)
> > +               folios_put(&fbatch);
> > +}
> > +
> > +static DECLARE_WORK(swap_dropbehind_work, swap_dropbehind_workfn);
> > +static struct workqueue_struct *swap_dropbehind_wq;
> > +
> > +void swap_writeback_dropbehind_folio(struct folio *folio)
> > +{
> > +       llist_add((struct llist_node *)&folio->lru,
> > +                 raw_cpu_ptr(&swap_dropbehind_llist));
> > +       queue_work(swap_dropbehind_wq, &swap_dropbehind_work);
> > +}
> > +
>
> This is good. For file dropbehind, I see both F2FS [1] and block
> devices [2] reinventing workqueues in their own filesystems or
> drivers, while folio_end_dropbehind() simply benefits from its safe,
> sleepable context. This seems a bit odd.

folio_end_dropbehind() is not always executed in a sleepable context,
that's why I only add the dropbehind folios to the list for the worker
(which executes in sleepable context) to free them.

But anyway, as Matthew pointed out, it seems like this patchset would
be way easier on top of [2], I'm looking into right now.

Thanks for your comments,

Alex

>
> So I'm really curious whether this could be extended to file-backed
> folios as well, so that those filesystems and device drivers don't
> have to deal with this themselves.
>
> [1] https://lore.kernel.org/all/20260820071438.695893-1-qiwenjie@xiaomi.c=
om/
> [2] https://lore.kernel.org/all/20260730-blk-dontcache-v7-2-3e8e6850068d@=
columbia.edu/
>
> Thanks
> Barry
>
