Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45C377EA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642085; cv=fail; b=tJN7nVZBaWHtk5tlNxnnFnJyEY7pUQ3HaQ6Vquonh5R43519p0V4KCfKZBmERPw21+ZcwMKCGLu7KuGTY1cWLNfPo+JP6uUpi2Aa89fRkYnSuztqFZePRE9gOWy7FDFS1UJYLkXOWoZRqz+sWXz/rnLVQrRwckbobtrZdzAzJGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642085; c=relaxed/simple;
	bh=gNEEHHXXDEY2XMKciUglS/CiQui1ZQtaaqVDp0KlLf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm39JkQuJKlMGBBo67Pb4l+3GiGtFdPy8E9pHqMGa/92LCCFL+uMPYVQ73kuqjvKwoX0j51xoWNrC9f8x5fhtkgGOUhTtBqo4e8E+lnWwuixkZmKGEiUyv9SUVpIkVyfDusR/69+BzELbM/uEPz0bbHrQap1nxUzZhZmMlQryss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=S7EOLnm6; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="S7EOLnm6"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDkt6v870418
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:54:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sx7+Wpg1cuNhbLRjLTJbDwoqoDdkVIIIbVtBxTNNKe8=; b=S7EOLnm63S4m
	IuPxTC/+11L3Zrj+hS0WSPIHDl/IdtjqJ4HBhMExfWAJqkqQSMFt4l5xrnsnS5Ca
	+mZCQN3U0iD/y/dcTu+JS4kkrVcP4LWfG1YoArC7j9vuuohn3Hmnc4cFBfPNxYdw
	vYQaWuyHhA0z8sBkTJjzq6As/iio1eNAAvSbCDdOSnTEFcK85VP9J/xfLXID8DA7
	xek81ORaffO1S3MBnkpzPJFHUkxnbtylM5f7+5G66oxeGZBRnuURXl1GHnra7Pa0
	KoAAmT62XYETf0BQz6kh7/qJqMFAPUM32JAHPscmW3Fl0gpRR8bgRpN20lwzD8ES
	X2GkwgNOsw==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fgu2hwbta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:54:42 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-698557ec1e9so7007876a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784642081; cv=none;
        d=google.com; s=arc-20260327;
        b=O0BbkeFb7yOGEq7jVzHJ2vYu6OlTvLknwYQ9q+mEcASiLKYMUtCZ+fuzqtlKM9i2ug
         1mTtNuEezBF/Nv11w37DvJZQdEt/QlmJp3yQd/pGa7URQ7ZjYqAJhIDm9AhqVEBargN2
         EXJZJGNEo3m2Fvwcv1HCjXEjwVOL3EtR9iHNhajsbdEBWKpJm7V+nm4gmW7oYB+8OCSO
         ikUcqJXZYaKafYcEAdU0rhOzP2y6VrsKudzyGfdCo71NN3mO7mRdKhVB7eue/Np9IK9R
         Aa22V1szqJx+DV2kjTkha4MClJ/5gSBl0Xn5MZ8vWui/D6IPX/3LGkEwLJmMh8ngM4Ez
         vwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=QXi2y4Ma+bwgvWfji+09XbTWAna/luqe3unBFGrfieI=;
        fh=RF5lhOWwNwzge2LmHr8S4bOOWzCNwcJHP3txyUZRNQE=;
        b=K1h4ujoliLiS1gp+ThR9VpWpodwPmQLHPp3SgYYfPdm/mS3Gfl/S4xlfiFz+3IqRL9
         k6wtvJmCxrfrnxO0nCggXA6D/n03Z4X6SDikI319MJV5dkd5wu12Xupd+mto6T/trx3c
         mbR/y4HdbctpNjARV0jx4p3yp3L60y6iqiDG3w4T7YPKf+N5tCuORwaXTLBbH2IHwKZ6
         pl0nkJQ47je5mt8DC9KKUvsgYq8zaXd7Gce18kAusxwpUm6JgU4q0dcmUPT0Bd1DGYkL
         w+yUAiqtmeZ4X5aP2IHQ1VKkIB9DTlRT8XS2RXDJuqeCelaFo+pZ0J0whOGBsCYQMVjC
         WPZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642081; x=1785246881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXi2y4Ma+bwgvWfji+09XbTWAna/luqe3unBFGrfieI=;
        b=r7Ey58rRdgt0J9cJ0MQwzmS8zrF8ged2z/6AZYUoByY4xKfzX4k02mgESp47flWOAP
         ALyYOrFBb14DSar/q+fryZ7ygsbV9hVZSc88v9lS8H6pwxi/LuLM9eojHm2AHFFxNE//
         TR9yrXXRHQmvfbh3XjWEau8MI3YdawOyLgjagd8BWsLYzF0pdI3pLvCXqpdzgsArMA9f
         a9amXKf5NcAEHeka0sTH2tlgJh/ZNTCNeuxJbpJFHdd02xk0UdCATerj3FbPhIeibFff
         N5SeobTH1UZb5ZP/g/xKkfHcC2KMquZvHzKrxQN62LRBQOYTAom+spqMf+iOupwzcpqV
         PZGA==
X-Forwarded-Encrypted: i=1; AHgh+RpE8LHxPPNmDXg/fMwWnB5Dytg7G2ov0mJJ25HEqN5fDMcFmEP7LUxm3sFZQbYZUaN3saYJkDbzvEsZ4q8N@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5ecQDtmfmvrnfC2gk0gUItx/7K4F4QRDMWzo6iN/Jwlon+/q
	3wklA9tAbGjfZqDHrMOoqfRThhiHi3am61nDezbROm75k9Bfx0/oqgV2ckxnorAwfRGOJ9metvo
	qpbsqZ3W2MTOKdin0eHJC86VhQ5eW6WREkDBfxbJ199VImBWcTAi+3C7a1oAt7DvY41hwhQxoSM
	xKCvdLTk9YsRq/IUwOYU5ymrV683zALKmpuJ0EpHf1
X-Gm-Gg: AR+sD13eccOs0lkSdZE2yXW2mTAm+gV4HUJoBwWlhDExuFkPLcInoRkw8f8BEU2GNG+
	+xwbgnptjLtMlJ2HWWD/TQo6PKxsXqNkmEB7wqKNNPGA3CrfyO+aJPQocOMsuz70RhKjGIzomLr
	9gTMPxAoyFB6SQvFbeDrBTClI6cMfOJW9T4GxBCkQP0nSnFJ/oOScp3J2RnnXRrQ6QgTBHTZ0r
X-Received: by 2002:a05:6402:5194:b0:698:4d33:b191 with SMTP id 4fb4d7f45d1cf-69e6525b70dmr6983601a12.9.1784642081563;
        Tue, 21 Jul 2026 06:54:41 -0700 (PDT)
X-Received: by 2002:a05:6402:5194:b0:698:4d33:b191 with SMTP id
 4fb4d7f45d1cf-69e6525b70dmr6983585a12.9.1784642081172; Tue, 21 Jul 2026
 06:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <20260718093723.153324-3-alex@ghiti.fr>
 <CAKEwX=NY=Uvcfm2BT-HGqu8B3OaoC0eePW1M7fW1qH4wpjQ8gw@mail.gmail.com>
In-Reply-To: <CAKEwX=NY=Uvcfm2BT-HGqu8B3OaoC0eePW1M7fW1qH4wpjQ8gw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Tue, 21 Jul 2026 15:54:30 +0200
X-Gm-Features: AUfX_mwF5Q9JVRQNfWQ5TsioDFCzg2oqxuYB2oNNQsm7BN-0LsnY5Qv5zLzHpko
Message-ID: <CAEmasaUs-1oHnnbP77hBt_02pZChjf5E5vt4nAQQsSY1BYZb9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: deferred dropbehind free of writeback folios
To: Nhat Pham <nphamcs@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosry@kernel.org>,
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
X-Authority-Analysis: v=2.4 cv=brV8wkai c=1 sm=1 tr=0 ts=6a5f7a22 cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=pGLkceISAAAA:8 a=ufHFDILaAAAA:8 a=rBto2jfJFEA7NFfjjzUA:9 a=QEXdDO2ut3YA:10
 a=j5kO0B45gQVIxiUYEfTy:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-ORIG-GUID: 7eJdSLihoNSE5iR5NjdD5HOk_Q2bHU9T
X-Proofpoint-GUID: 7eJdSLihoNSE5iR5NjdD5HOk_Q2bHU9T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE0NyBTYWx0ZWRfXyduelKigulA6
 T/V8S2c33PYkXKUJM3tiwnwJ3wP608SkUU4irV8ys0TdFdTRsgH9pcTVAB5+5EH+MIq9K78cOUr
 nWNxNDeTUrjpf2S67OcqkbwxtCsImr1728kYsN9WD8uuwE+53N53XZUsOJdZyUzC3C/S3D3WJWm
 COUKjNCS4y6GxDA90fWD/UJLvKaWmfDnGKcfz1rM4zvN8dYwA76jWjW80f1svnWzRkG3vPMh7jK
 qRMqxNuxQvc5NXRjBBDHb4jMQz9TBSbIM/ofW5ZSTuFXdptBDPfRPIiqcGNYnQ+0+LvGjRjlF1/
 LpVEYb6Y6XzDU//UZSVV1Kgz3h+xrLel3jbVzk9y1lUzGQL0De7lr1x4d5j7g6K33u0eKEV7oU0
 SifcW84GLu9MI7vjqOTYX8bK0MqwmAieuzC+lDahTDiQsK/a8geRvxgjw9qSctzeu0y6tP0jIiA
 /2jpWhGVlo00r9IDVJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE0NyBTYWx0ZWRfX5JfG4fwNR04l
 pkHSMG/lUjH8o2anDRl+5AtlDiOgvkxrFQmrcWw5JvuCi6lCJE6IR6TVazhERWzgu7kFit5xfRr
 c4di9tHVJ+21MPmrkMOEJgGfR8esd0E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01

Hi Nhat,

On Mon, Jul 20, 2026 at 5:57=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> >
> On Sat, Jul 18, 2026 at 2:39=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > The previous change frees zswap writeback folios promptly for
> > synchronous-IO swap, where writeback completes in the calling context.
> > Asynchronous block devices and filesystem-backed swap complete
> > writeback in interrupt context, where the folio cannot be freed, so
> > those cold folios are still left on the LRU for reclaim to clean up
> > later.
> >
> > Free them promptly as well by deferring the work to a workqueue that
> > runs once writeback has completed.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>
> No Suggested-by for poor Nhat? :(
>
> Just kidding, of course - thanks for working on this cool idea :)

Oh man I'm sorry, here is the story: while working on the large folio
zswapin, I noticed the swapcache was getting huge when the shrinker
was enabled. I mentioned this to Johannes, who suggested dropbehind
(this was the first time I heard about it). And then you told me you
had already tried it yourself!

>
> > ---
> >  include/linux/zswap.h |  2 ++
> >  mm/filemap.c          | 20 ++++++++++++++++++++
> >  mm/zswap.c            | 34 +++++++++++++++++++++++++++++++---
> >  3 files changed, 53 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> > index 30c193a1207e..23dcde274964 100644
> > --- a/include/linux/zswap.h
> > +++ b/include/linux/zswap.h
> > @@ -35,6 +35,7 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
> >  void zswap_folio_swapin(struct folio *folio);
> >  bool zswap_is_enabled(void);
> >  bool zswap_never_enabled(void);
> > +void zswap_writeback_dropbehind_folio(struct folio *folio);
> >  #else
> >
> >  struct zswap_lruvec_state {};
> > @@ -58,6 +59,7 @@ static inline void zswap_swapoff(int type) {}
> >  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memc=
g) {}
> >  static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
> >  static inline void zswap_folio_swapin(struct folio *folio) {}
> > +static inline void zswap_writeback_dropbehind_folio(struct folio *foli=
o) {}
> >
> >  static inline bool zswap_is_enabled(void)
> >  {
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index dc3a0e960b9f..548e465b5b9a 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/gfp.h>
> >  #include <linux/mm.h>
> >  #include <linux/swap.h>
> > +#include <linux/zswap.h>
> >  #include <linux/leafops.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/mman.h>
> > @@ -1680,6 +1681,8 @@ EXPORT_SYMBOL_GPL(folio_end_writeback_no_dropbehi=
nd);
> >   */
> >  void folio_end_writeback(struct folio *folio)
> >  {
> > +       bool swap_dropbehind;
> > +
> >         VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
> >
> >         /*
> > @@ -1689,7 +1692,24 @@ void folio_end_writeback(struct folio *folio)
> >          * reused before the folio_wake_bit().
> >          */
> >         folio_get(folio);
> > +
> > +       /*
> > +        * zswap writeback folios are off-LRU, so we must prevent a rac=
ing
> > +        * swapin from removing the folio from the swap cache and keepi=
ng it
> > +        * off-LRU: the writeback flag allows that. Afterwards a swapin=
 may win
> > +        * the race, but the folio is already queued and the worker put=
s it back
> > +        * on the LRU in that case.
> > +        */
> > +       swap_dropbehind =3D folio_test_swapcache(folio) &&
> > +                         folio_test_dropbehind(folio);
> > +
> >         folio_end_writeback_no_dropbehind(folio);
> > +
> > +       if (swap_dropbehind) {
> > +               zswap_writeback_dropbehind_folio(folio);
> > +               return;
> > +       }
> > +
> >         folio_end_dropbehind(folio);
> >         folio_put(folio);
> >  }
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 3c494c5a671c..d185da85bb68 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/writeback.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/llist.h>
> >  #include <linux/list_lru.h>
> >  #include <linux/zsmalloc.h>
> >
> > @@ -990,12 +991,39 @@ static void zswap_writeback_free_folio(struct fol=
io *folio)
> >                 goto out;
> >
> >         /* Raced: the folio is now owned by the swapin; put it back on =
the LRU. */
> > +       folio_clear_dropbehind(folio);
> >         folio_add_lru(folio);
> >  out:
> >         folio_unlock(folio);
> >         folio_put(folio);
> >  }
> >
> > +static DEFINE_PER_CPU(struct llist_head, zswap_dropbehind_llist);
> > +
> > +static void zswap_dropbehind_workfn(struct work_struct *work)
> > +{
> > +       struct llist_node *pos, *next;
> > +       int cpu;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               pos =3D llist_del_all(per_cpu_ptr(&zswap_dropbehind_lli=
st, cpu));
> > +               llist_for_each_safe(pos, next, pos) {
> > +                       struct folio *folio =3D container_of((struct li=
st_head *)pos,
> > +                                                          struct folio=
, lru);
> > +                       zswap_writeback_free_folio(folio);
>
> nit: I wonder if it's worth doing some batching here for the free step.
>
> i.e, after remove_mapping() succeeds for a folio, we can just add the
> folio to a batch, then call folios_put_refs() in the entire batch :-?

Did not think of that, I'll do!

Thanks,

Alex
