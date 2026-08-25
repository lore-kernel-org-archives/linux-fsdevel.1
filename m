Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4E345740
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677082; cv=fail; b=NIGh3ayeuvTvKyzBMsnaxbA1wH45IZPTZF9v3k8qtDwDzaBmDGnfeus+CPDbkrK6vK9dGYuh7GVhWH+fbJwbwl4sK2XPrJak1Fy0QOU4jWqfBkMeSD0kHz99WJn4O6JtQuu1HE2lmVXJhsS/U4CckaewYtChcTmhvy10VI4Szco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677082; c=relaxed/simple;
	bh=7WqFDTGQQXTHeUIYvKkNH8mbKuPoOLp1fAp6LEBqBfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5Y1qIh/26kIKm/4qSTooWkl9LfrQ+cU2s6+V3j2+osKwbkqxWHesTkFNdEk2ydMlkJylpussXBJBgMYRcz4AqP71mMxCqTRIXzSRBbab7S+AAnXBj/8VuQj4/slwjy+T1DCocpHB4ZzGKnQTsepztww3OeoKsQaqe/LcKKL/Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UYo/pK6O; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UYo/pK6O"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEaLA73408149
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 09:58:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=loWudOev40SaMy1gWOxNzMQ9/yXEiAhMPQP2s
	1OUbAQ=; b=UYo/pK6OQrzN9pDz924Eea1oQAKLPKglyIsf/4Z5EKtFnDRcd3dnl
	DC6nBKUMFY3Y4SO+9pNsBEtIVKlOunHZo9W3uZ/MevlaUXUcjSUoSXf3iZagWNX+
	tELBntBQotYgyW8daOzfrCwgAKs9mZ3IFIkYsiCsoFrtmbyjb4GJL4EhR7Ua9gpT
	EM1+jCtcmr1/f8JJe5kf3e8a/SFgIrqueSi+HgYEs+RwRiiD6IhnlprCl2aImAKY
	7aXPY2Bftkw5BkFMqfN05PeqiYcf29dFPOuSLzhXDqYY85EMn2inO7HxEUPp1eEq
	JSE8Hw4y8dNGFkblq66pNQhzxdSrue0Cg==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g9cens7vv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 09:57:59 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a14f2e8c47so5927744a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 09:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787677078; cv=none;
        d=google.com; s=arc-20260327;
        b=fnRJeByS/zkdiJM2elZP73jCeCcxHj0PMCVWWd4gOCW6RNTzA/CDfnXsPj00LsF9dH
         RY2eaQk83FAfN7ykWx4gccmDFhrg+Ahd4s68/EtSpNxms7ykIF/pBRq4AqNA3HkzrkBI
         Jj3J/KxNsnU7d8bOO4XmEypH5sJpyf7AVAoidxubH2heqWVoTHQzMBq8Ivp0AqxIk2NU
         uA1YiZt3Buvw/YlMb6+rgWCT0p0FPUIBWhjJAwR8lMGnGcxMEYQLESnunhpYYga8+7XD
         Qkv/Ko/TW7Ngq2m1rB/hcDHefsOH0NJUIL1TfADSFzodnnZrj3QnizAUX17KG6JCmRsl
         HKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=mN9rywOUvztkO2ESvsNFKcV47QutDX1+/ahyJs+xJwo=;
        fh=kQI8vesOIvPwAWo8QZ1OZKD5sg86qNNXZnmeMKvbz/w=;
        b=lHicVtYZnJUdeO7yDMKT0P6k+srRmh90XqzH38khmvYBjcJSjZytduc2m4Lh0lFxxr
         MIq/mYfFl6TjgFvLx+0QmrxvjrtUJekaTNfYGEpxHd6hqIsf1B6Xyo1MX9CmAeR3eIVV
         3wl4vUN0iE8SqaAaF0VHuywkY5dkIJ5wMZuXi7DN+DigMrsun9qoC6Jg8pqoeSE7tMHv
         NEKstSgcJklkKMWph8IvdYdJpbWyp5nLUjAA5KijPzQ4x33qF0POuz1vsuhM/aocInoC
         DALrq4BH99gnbHbIMYx4CuZbxkYW21wCq87CcQ/NxDhadBr1H/LMuakm+5ru1VhVDbl4
         jSUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787677078; x=1788281878;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mN9rywOUvztkO2ESvsNFKcV47QutDX1+/ahyJs+xJwo=;
        b=OuHZJ+xYr6T0r2dp7N31B1mPDJQ5V6IeYe128jeD1OXNGIbrB4dKEbc4QLMS8WbvOJ
         cudRUjPeHHvxdXd+lOsrT/BaUs3UdVqsylNl6bi2pRgG3TAD65WnQTjdLq5aHCPR78PL
         bO5/D+6tblOnoq/mki62d69HQnaelfVgKeIodLRAO+3TaZmaZWcD7D/f0q8T9QjSnlGQ
         eM4khW/vvoGfabBygcbyBcI0Eg2v9vfCxL8IxsmcW34UFpU557gRdGch/5juaci56Mr6
         rBlo5LBtf7tnYy5z+61QM4VnnRhhHRTu/8nb9ydstmtZ4g7t6FH7prY5uvvc3ZwTleAu
         X0EA==
X-Forwarded-Encrypted: i=1; AHgh+RrHyOQzYT90qW9SB68Cab4dLdrvd1hVZz88ALtR8i35sldvZgx0o0evCR38tvm+0UFPhpS9qMIDQ73UTWwv@vger.kernel.org
X-Gm-Message-State: AFuF++kcpTQ56r/qkXfQx7/VLiiYN8ziIIeFwsn8kDR+FjCFI/wj4Sa+
	Yl032dN70vOM/FOmk+K+L+2SbENO5adYdsv2rD0l59GFXm/JX4/bSba7dntTGXG+NlbNkVbhkIx
	msOrbMmQTxoUHlFQgYgv1mIe6Z8KmVCx2uQUmmwJn5LdFynF0UZtF1MnU6dpWx3rVVLiHear8+1
	d8uDAR3uaURQtOn6qZlCgJzWpYjtjL+cL5nnGM/8nL
X-Gm-Gg: AR+sD10sfS1gDqZa327UY+pCLIujeLVEarF7I1ZWeTL2TJncPnOVtQMlG2ii29Zg07m
	ORVYomrglGNcJfdqOXl+cbqSPOnBwzTVtADnyw/sTfJGwinJaaoCzfjAZRDOPBxluShFRPD/e56
	tYHxy8uzggCQs3wWFngo1vsmcCt+TBzJfUO7MN+Ny7pw6ftiWUv7G9EPCugAgQHO2uMAhBzTSh
X-Received: by 2002:a05:6402:3811:b0:6a1:7825:5230 with SMTP id 4fb4d7f45d1cf-6a5df64f1bbmr284105a12.16.1787677077836;
        Tue, 25 Aug 2026 09:57:57 -0700 (PDT)
X-Received: by 2002:a05:6402:3811:b0:6a1:7825:5230 with SMTP id
 4fb4d7f45d1cf-6a5df64f1bbmr284000a12.16.1787677077319; Tue, 25 Aug 2026
 09:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825135209.3135169-1-alex@ghiti.fr> <20260825135209.3135169-4-alex@ghiti.fr>
 <CAO9r8zPsQ9J_mL-eYiNEZNu1LdxoVXL-mQ+=QMUvcT_71cf7cw@mail.gmail.com>
In-Reply-To: <CAO9r8zPsQ9J_mL-eYiNEZNu1LdxoVXL-mQ+=QMUvcT_71cf7cw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Tue, 25 Aug 2026 18:57:46 +0200
X-Gm-Features: AcwNN1XA-bGiBg4PQPCXw-lD0CMT8QITJ4O8DKFXilDnbFGAZj44avzq3h930NY
Message-ID: <CAEmasaX6L5Rghr0QSkv_x7kiJ9U-MaXwNBntePCkQBoyjOtP5g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
To: Yosry Ahmed <yosry@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
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
        Kunwu Chan <kunwu.chan@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NCBTYWx0ZWRfXyv7Uj8H5JXwi
 rM5Ss5Rn2VvZ1ukKxNuWZHpKMc7ORuQmUQ3de1EDiSPYCmYrcm8ACXS3dVk/y4PZy+LgvgpRqGb
 WhZmDDccmHCupwleUz1KfyHOr63CpQI=
X-Proofpoint-ORIG-GUID: 7mgkUKJqMm8eIV8GdbURpX2cZjTUlLE0
X-Proofpoint-GUID: 7mgkUKJqMm8eIV8GdbURpX2cZjTUlLE0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NCBTYWx0ZWRfX25yFgMVDeubz
 K5QEbPOvQ0v3Qj4JK3UEZyYj2pFWxF0uMEnyY+dOBR/f63ZnUYjStUbyFjf+T1vq4LTeeoAnYfZ
 +RTOpoEp2q6XmsSBfavGwLlM6vLVJjnSPlY4z1Ub7WjgmhsavVX8hCxprRKrnJtRlcBQ8pwTBJH
 ckruptpJOlCqqKmVvK8zoczkpfYAaPStqoytThIg0Qz3SGJa9kLd+mUGEZB+/0eZtUEHzcZS3Jy
 EJqiwM9XhNGFGP1/K/JdRm4dAU76Iv5GO9UFUfMyOgjb4Tgqe2AFkx0C8mka1AhGBe815g6aM8j
 1DUw5GsQCrP3w8FFnE1jF/jXTeSH7V1IixuGdoeb54AZhY4Vja9JmtAaoeL3vuIUBXXcNxI39pM
 5bzL37eFz2u93HYktdiocMhZf3kmccIlEbs3HPspQuSIkoHDKCFb52XiazNDIyjhGlNmp+K5FnM
 ExzrEnn62F1DTaOEZYQ==
X-Authority-Analysis: v=2.4 cv=Kb3idwYD c=1 sm=1 tr=0 ts=6a8dc997 cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=ufHFDILaAAAA:8 a=pGLkceISAAAA:8 a=hKD1uaKRyuBWxXnh-LMA:9
 a=QEXdDO2ut3YA:10 a=j5kO0B45gQVIxiUYEfTy:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01

Hi Yosry,

On Tue, Aug 25, 2026 at 5:52=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> >
> On Tue, Aug 25, 2026 at 6:55=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > zswap writeback decompresses an entry into a fresh swap cache folio and
> > writes it back. The folio is cold by construction, yet it is left on the
> > LRU for reclaim to find and free later, wasting a reclaim scan and keep=
ing
> > cold memory resident longer than necessary.
> >
> > Allocate the folio off the LRU and mark it PG_dropbehind so the swap
> > dropbehind path frees it from the swap cache once writeback completes.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > ---
> >  mm/zswap.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 8163e6c5f76c..d16822a516e8 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1013,7 +1013,6 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
> >          */
> >         if (IS_ERR(folio))
> >                 return PTR_ERR(folio);
> > -       folio_add_lru(folio);
> >
> >         /*
> >          * folio is locked, and the swapcache is now secured against
> > @@ -1046,12 +1045,26 @@ static int zswap_writeback_entry(struct zswap_e=
ntry *entry,
> >         /* folio is up to date */
> >         folio_mark_uptodate(folio);
> >
> > -       /* move it to the tail of the inactive list after end_writeback=
 */
> > -       folio_set_reclaim(folio);
> > +       folio_set_dropbehind(folio);
> > +
> > +       /*
> > +        * Drop our reference before starting writeback so the swap cac=
he holds
> > +        * the only one: the drop in folio_end_writeback() needs that f=
or
> > +        * remove_mapping_reclaim() to succeed, otherwise the folio is =
handed
> > +        * back to reclaim instead.
> > +        *
> > +        * Nothing can free the folio in the meantime: we hold the foli=
o lock
> > +        * until writeback starts, PG_writeback then blocks swap cache =
removal,
> > +        * and folio_end_writeback() takes its own reference before cle=
aring
> > +        * PG_writeback and donates it to the drop.
> > +        */
> > +       folio_put(folio);
> >
> >         /* start writeback */
> >         __swap_writepage(folio, NULL);
> >
> > +       return 0;
> > +
> >  out:
> >         if (ret) {
>
> This check is now unneeded as ret should always be non-zero here, right?

Yes, I missed it!

>
> We should probably also rename the label to indicate that it's only
> the error path. Maybe "error" or "fail"?

Sure, will do in v5.

Thanks,

Alex

>
> >                 swap_cache_del_folio(folio);
> > --
> > 2.53.0-Meta
> >
> >
>
