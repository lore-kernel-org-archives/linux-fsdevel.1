Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FCF367B6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641877; cv=fail; b=RCf/T43aP/XxYQO4WKzQyjXm8EZ1IAoEXeqKXRZk3iDU0I5JwpnmAKANHx1slKNyVDRClrjFOzTRyVa5lpNj1gMWsnzj2SAee6/e9aC+bnQlx/SIvKAuebhmTmEzpHU828MRYdZ75GYy5625fglTWc8+em3yvF6idnP+hSkbwJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641877; c=relaxed/simple;
	bh=Ial8MWYXCWGtEgz+jJfu3F5YlPNgbMgSlRVp7TyvSjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIA9FfIeoZ7DUPNXt8okzkZ1sMjSJ4yPaqYU8IyvITNJjGqOAG0YAmtgxiriiMpGKOiShBO3SVTur7CuroGJuJEDbDPTSwvVIhXXS9GVwzw2MwQUyKNxBL6/3zQR/xzdS46NdcJvAFG5E40rDHsOcWQBa4L8pQLk9ad+gkFEPfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=G+WERwPL; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="G+WERwPL"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDmKxJ944008
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:51:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hgKqNwI9zHLhK4AxI/VtHp9PGEUWLwuB1Rwu5NNgDlg=; b=G+WERwPLhiAe
	69s2vKEtmDv2qYfUCZ738zaPksZOw9QVXm7WvP2zwWMbSlLKR55jXkq1kz5tyvNl
	p319Jl/M+GPvDossNQVvKjWv4mTtIKG1dxu7NdVSVUmBZL6QsT8n5xM/n1jA2979
	LMdVmqrcOS20sRkHx19rcPPV0eMb9YZdRolUH1uV2hX5evGcPQRVmQc/JhQWmxcC
	wp5C6MSHqEqXbdbGGOQE5EnhOz96eLg3w9c+zPGG+buoV79d11Nr6XnKASF6ltkb
	NI0wliMXHrYcYV+VgfLUiJUWHVALCoEQoV54iSHlK1C0a7OZWwYKOIXpepKQncYL
	QltCu+Kd1w==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fg6k816xn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:51:15 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-69c20d12deaso8062839a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784641873; cv=none;
        d=google.com; s=arc-20260327;
        b=VncDhRubYaUrOEH0dlT1Eeh/CgWZoUnZ4ZIdFBt6TAfZZAh8chE+emr2rMDGKGBpCr
         wefK4ku9v8au2PaZCHJ3cSWIRVihCKCbqAqraMattvKvL0aDekRm8J/0g1uy4se3q0wv
         7p/kc+RY3z7iw20Oqlmlbd9XkDTkrJWz1uRbLkIEPItq2ucQUfTZYny+5BX2pdVspTyL
         YZBwnuHHXEkdxdQ/H27h0ccvbVvut3A4RhyhtFrAJyMF8i2J2SBO9/nP+Po7JFLqswko
         HMjurCiNkjK8q2t2aiWJuQPVkRWEcX+s/iwWoLlTuBKkJvhT8LbmiUt42mRzNj8N8mA+
         yiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=kgCqHqk6t/4b7ihE9C0Q1R3dMzn+0bCpulqcGqITNJE=;
        fh=XBm+M9bp7oCUcOTg0AtIsiqLDSIYPzhO4rkPrjhY/V0=;
        b=PQjoDBFnqLke+dRCWiU2YvyLwiZ+l6ys+DvHP/FMrmWRfHCORseahJq6Zicmaw53+x
         7/9sWVPirPHos+/T3iqIfeCJUo5oeyqX2s9uOuOJxGH17J2J7xNpESYTKzqyixktEoJ/
         IiWnEyHRetcOL+r9XM9FGQWu6qovZFgDOKo/XK1k5YffSmW7+dsYy/ceM2mtR42SoUK0
         MNdEyUMLmNRKNaMuxhdcwP8xLjPxvEMdfNq0wCH+MpjGr779W8ITFZemt9bugHe2sDNd
         SdlWfTubZs+SoH+MEjruqs49hzIy8irlR9iy8vIIADdwStuwUdtwQ0HgVbsnJSXZ+zKm
         cZCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784641873; x=1785246673;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kgCqHqk6t/4b7ihE9C0Q1R3dMzn+0bCpulqcGqITNJE=;
        b=fdvU+BVq8ey7+dYGieGhXyHxt2NTsFT4LrgrSx1JzFUpBPynq/dkTWYThTDldzd4Ae
         ZcioQCR9Y+KOvKLMNnDdRqgoOfLsOixAP1mlJp27VD11cAN44gtXGg4rvHaD/r4SIF3W
         Q8VcvHL/BaPT0fQEdDFb7jYCcHudQizdH2elIP/isSU5X3e8ODcn9V/k29ZvIb8bh3Ko
         rWc0j3hj7Jv/HLRtjzJU3RIKopyd3cbV+rssp/coI+DXX8sZoPUR2fLOMJtsOzhj2ogU
         7wD1hbXMP7/zjwCyzdHQfcz8LAw0LHGsPfDZHNUDdz8sEcULp6WWR0fk8UGLzTZ2yRxq
         ZZgA==
X-Forwarded-Encrypted: i=1; AHgh+RpwodjP+EnD3SViVgyURuAWG3vqs5y5mVRWJktUPme3CTfXGwQFSKukI5H5rlENOgk+4qBog61elN1Pjcvc@vger.kernel.org
X-Gm-Message-State: AOJu0YzXq4C3Fb5u/ddSn3WI+qzSo6oM/3Ml6o3BtRyLdEhLeJu6eyzn
	iD95vwnM1OKK6ew+UpOzMpkgdYCkft6nh+KucAPahC6kgIMldnLUHTG6YwyjTfZK1IqEmdA5DWX
	qBrx9BjggKD7fmSuLKEQJ64CTQfMGKHsK92MRsKNxbl/o//+SFdVVSlE0Vylx+i7tfBb0cQf0Wi
	0Czcbl+fA6v4Ha0o8XWAqso6Kk5EtGsrBOv9T8Q3mo
X-Gm-Gg: AR+sD13L+CYyu4Q2Bx8SF60gsQBb1QaKQ8W1zuaPUjQJnect1sPenK+v1Dhopt1fYFL
	rkzvDAmNDs8lFz/pTz8LgEvtIsu7tNGgHIGMKdKUM0m6va+cFK+CU8vmiUG1EpG8+GFz53gTX7b
	zb9WkHgpYmBn4QZOhNM7N31e301Mz7drBgZrno/ZNAgFoPouxO0Bwe74oknfpxDu3MncN5hjAH
X-Received: by 2002:a05:6402:40c7:b0:697:eb97:a4ed with SMTP id 4fb4d7f45d1cf-69e64dd54d5mr7267908a12.7.1784641873389;
        Tue, 21 Jul 2026 06:51:13 -0700 (PDT)
X-Received: by 2002:a05:6402:40c7:b0:697:eb97:a4ed with SMTP id
 4fb4d7f45d1cf-69e64dd54d5mr7267883a12.7.1784641872842; Tue, 21 Jul 2026
 06:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <20260718093723.153324-2-alex@ghiti.fr>
 <CAKEwX=Nn0dMc1K9drXFVMwt7wMZ2P6KToeh7T3rE1+Xq5yrCFw@mail.gmail.com>
In-Reply-To: <CAKEwX=Nn0dMc1K9drXFVMwt7wMZ2P6KToeh7T3rE1+Xq5yrCFw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Tue, 21 Jul 2026 15:51:01 +0200
X-Gm-Features: AUfX_mxqg_lic_i-cnpMMasc3XbCKh4ZvMOp6vx1fefhyR4VNBj1s0GHL0sNvB8
Message-ID: <CAEmasaWnp_pHEo2m=5GEo4r3YYWoRC20FNfWN=TtrPT070WUzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios directly
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE0NSBTYWx0ZWRfXwTR/eS4sym01
 Yjrp9+a0TlUipqGJQYeCF/nT6AkGBYSB0FwK5+bf1ait5iYhhzmnjU/aF3oAIs231X6Zw/0p2zO
 FauYX+r1aWan92L2Qp8NIzrFJD8zmIM=
X-Proofpoint-GUID: Ayn9h4MlvSWfGk-h16z002kp3Ki6Lpxj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE0NSBTYWx0ZWRfXxKx/oooNNwsb
 9Tvv88UMQriNpbwSq+nJzNCPNQsFN7k4lzyOuC3CetS5OzI++DYLVMzBW52oNKiBHwyKx2hBSTt
 +2uOPDuwETwPH4dLd7YNV6bqo7mASMmS7X3l3FIsJP0yPSQO+BOfQ0S60jQTFDdlsGaznbzycUg
 iUS5pRgq9MBfVQqbDYtS+V4YhIrHBCzEDVGkczLkNryRRSgGklS4wpSyHaSAoqzzqLHfMHVdffI
 pNDjlkOJMniOUrCgL3l/eblUAQLSndrrfDeL0rqzFBfJ5x5G4qdSh6O/LKUhCDb4LShteTMmZdK
 zqJAWPqE3E2BY64mxLgwkVnlJe2Zeifvixbx7LnLkzQQC45xGy/uxN2KUfOVPx8UI2ftcA6uwAs
 8wpqTSJZXaabJv968FcITPZn6pT/TWjXgIaWSJBDgytaSfJw0mbxkRldcluSBu4LoiqvWL7+KTC
 z57huConVMLgsPBkFRA==
X-Proofpoint-ORIG-GUID: Ayn9h4MlvSWfGk-h16z002kp3Ki6Lpxj
X-Authority-Analysis: v=2.4 cv=RcmgzVtv c=1 sm=1 tr=0 ts=6a5f7953 cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=pGLkceISAAAA:8 a=GXzu1mSckkvTQhgV4B4A:9 a=QEXdDO2ut3YA:10
 a=j5kO0B45gQVIxiUYEfTy:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01

Hi Nhat,

On Mon, Jul 20, 2026 at 5:56=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> >
> On Sat, Jul 18, 2026 at 2:38=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > When zswap writes an entry back, it allocates a swap cache folio,
> > decompresses the entry into it and writes it out. That folio is cold by
> > construction, but it is currently left on the LRU for page reclaim to f=
ind
> > and free later. This wastes a reclaim scan and keeps cold memory reside=
nt
> > longer than necessary.
> >
> > For synchronous-IO swap devices writeback completes in the calling cont=
ext,
> > so the folio can be freed right after the write rather than left behind=
; do
> > that. Because it is freed directly rather than through reclaim, it is
> > allocated off the LRU: dropping the last reference on a folio still on =
the
> > LRU would trip the free-time page-flag checks. A folio that a concurrent
> > swapin has meanwhile claimed is left in place and reclaimed as usual.
> >
> > Asynchronous and filesystem-backed swap complete writeback in interrupt
> > context, where the folio cannot be freed; they are handled in a later
> > change.
> >
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > ---
> >  mm/swap.h       |  3 ++-
> >  mm/swap_state.c | 17 +++++++++++------
> >  mm/zswap.c      | 36 ++++++++++++++++++++++++++++++++++--
> >  3 files changed, 47 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 77d2d14eda42..c617e5a0257f 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -306,7 +306,8 @@ void *swap_cache_get_shadow(swp_entry_t entry);
> >  void swap_cache_del_folio(struct folio *folio);
> >  struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t g=
fp_mask,
> >                                      unsigned long orders, struct vm_fa=
ult *vmf,
> > -                                    struct mempolicy *mpol, pgoff_t il=
x);
> > +                                    struct mempolicy *mpol, pgoff_t il=
x,
> > +                                    bool skip_lru);
> >  /* Below helpers require the caller to lock and pass in the swap clust=
er. */
> >  void __swap_cache_add_folio(struct swap_cluster_info *ci,
> >                             struct folio *folio, swp_entry_t entry);
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 9c3a5cf99778..048efc7ca612 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -403,7 +403,8 @@ void __swap_cache_replace_folio(struct swap_cluster=
_info *ci,
> >  static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
> >                                         swp_entry_t targ_entry, gfp_t g=
fp,
> >                                         unsigned int order, struct vm_f=
ault *vmf,
> > -                                       struct mempolicy *mpol, pgoff_t=
 ilx)
> > +                                       struct mempolicy *mpol, pgoff_t=
 ilx,
> > +                                       bool skip_lru)
> >  {
> >         int err;
> >         swp_entry_t entry;
> > @@ -484,7 +485,8 @@ static struct folio *__swap_cache_alloc(struct swap=
_cluster_info *ci,
> >         lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
> >
> >         /* Caller will initiate read into locked new_folio */
> > -       folio_add_lru(folio);
> > +       if (!skip_lru)
> > +               folio_add_lru(folio);
> >         return folio;
> >  }
> >
> > @@ -507,7 +509,8 @@ static struct folio *__swap_cache_alloc(struct swap=
_cluster_info *ci,
> >   */
> >  struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
> >                                      unsigned long orders, struct vm_fa=
ult *vmf,
> > -                                    struct mempolicy *mpol, pgoff_t il=
x)
> > +                                    struct mempolicy *mpol, pgoff_t il=
x,
> > +                                    bool skip_lru)
> >  {
> >         int order, err;
> >         struct folio *ret;
> > @@ -522,7 +525,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t ta=
rg_entry, gfp_t gfp,
> >
> >         do {
> >                 ret =3D __swap_cache_alloc(ci, targ_entry, gfp, order,
> > -                                        vmf, mpol, ilx);
> > +                                        vmf, mpol, ilx, skip_lru);
> >                 if (!IS_ERR(ret))
> >                         break;
> >                 err =3D PTR_ERR(ret);
> > @@ -643,7 +646,8 @@ static struct folio *swap_cache_read_folio(swp_entr=
y_t entry, gfp_t gfp,
> >                 folio =3D swap_cache_get_folio(entry);
> >                 if (folio)
> >                         return folio;
> > -               folio =3D swap_cache_alloc_folio(entry, gfp, BIT(0), NU=
LL, mpol, ilx);
> > +               folio =3D swap_cache_alloc_folio(entry, gfp, BIT(0), NU=
LL, mpol, ilx,
> > +                                              false);
> >         } while (PTR_ERR(folio) =3D=3D -EEXIST);
> >
> >         if (IS_ERR_OR_NULL(folio))
> > @@ -683,7 +687,8 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t =
gfp, unsigned long orders,
> >                 folio =3D swap_cache_get_folio(entry);
> >                 if (folio)
> >                         return folio;
> > -               folio =3D swap_cache_alloc_folio(entry, gfp, orders, vm=
f, mpol, ilx);
> > +               folio =3D swap_cache_alloc_folio(entry, gfp, orders, vm=
f, mpol, ilx,
> > +                                              false);
> >         } while (PTR_ERR(folio) =3D=3D -EEXIST);
> >
> >         if (IS_ERR(folio))
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 761cd699e0a3..3c494c5a671c 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -972,6 +972,30 @@ static bool zswap_decompress(struct zswap_entry *e=
ntry, struct folio *folio)
> >  /*********************************
> >  * writeback code
> >  **********************************/
> > +static void zswap_writeback_free_folio(struct folio *folio)
> > +{
> > +       folio_lock(folio);
> > +
> > +       /* The folio was allocated off the LRU and nothing re-adds it h=
ere. */
> > +       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
> > +
> > +       /*
> > +        * Gate remove_mapping() on folio_test_swapcache(): a racing sw=
apin may
> > +        * have freed the swap slot (folio_free_swap()) and dropped the=
 folio from
> > +        * the cache, and remove_mapping() must not run on a non-swapca=
che folio
> > +        * (it would trip __remove_mapping()'s mapping =3D=3D folio_map=
ping() check).
> > +        */
> > +       if (folio_test_swapcache(folio) &&
> > +           remove_mapping(swap_address_space(folio->swap), folio))
>
> Hmm I think you also have to test for writeback and dirty here right?
>
> After a racing swapin freed the swap slot, the folio might be dirtied
> and swapped out again. We probably shouldn't try to remove_mapping()
> such a folio?
>
> We also do similar check for zswap/sync-io devices in pageout handling
> (mm/vmscan.c, shrink_folio_list()), and the other dropbehind handler
> (filemap_end_dropbehind()).

Actually it took me some time to eliminate the writeback check, I
think it is not necessary.

First, we only call remove_mapping() at the end of writeback (easy scenario=
).

Then comes your scenario, the hard one. But it cannot happen because
dropbehind folios are allocated off lru. Which means that a racing
swapin can re-dirty the folio (that will get caught by remove_mapping
itself) but it cannot be swapped out (ie under writeback) because it
is off lru and then cannot be reclaimed.

But writing that, I realize I may have missed other "swap triggers"
(MADV_PAGEOUT for example). Perhaps adding the check is safer (and
cheap anyway), what do you think?

>
> When I was playing with this, I also tested the folio with
> folio_test_active() and folio_mapped(), but I must admit - I do not
> remember why I did it. Could just be me making sure we dont get rid of
> frequently used folio rather than for strict correctness. :)
>

folio_mapped() is not necessary because remove_mapping() checks the
refcount. folio_test_active() is always false in my case since
allocated off-lru.

So unless someone confirms what I said above for writeback, I'll check
for it, it's cheap anyway.

Thanks,

Alex
