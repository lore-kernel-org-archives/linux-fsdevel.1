Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA141438022
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243535; cv=fail; b=eO8BTFVDus0H32y7vt5ZEFhnQt1wCOjSmtGcvACArrxWAaLTsnQHSYrxDjEtYeSTW8Wk+gOLksKF5k2qDo09XYVMMNfUanzgk4IY3+2KKvWJJFsUjftDEyfnkGSVJCCBwFKSaXz7R0sLQR02vyPl4WqpStlkiSrQKhMGgvKFnxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243535; c=relaxed/simple;
	bh=afd67Ll2ZQZV+M4hQsnw/Re06enrvjecEG9Xk0E7ieI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1G0LPbXHpiClyy4RcDspGpwYLuBQ49gJmkxOrbqDlUd1VYYdQ6g8lPj+vR7A9iV/cnPRyTQq1SwkLYRGMkrhKbWoFEmLs4OvSCoFfcnoJ25k1egd64ITbc7N205ZpCaMrVPKSTQKW1FXG1A68bLIrWpeTfw9lZkdGCuDuU4d34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Od6U0Lca; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Od6U0Lca"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBGsG4314692
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 05:58:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=SXl3Dygthf2hrndTRS/55sXaTkDWj3llKR8jZYjv2Q8=; b=Od6U0Lcawfj7
	nyAmUZX7J8TEJjSp9OoQjhRwGJuGj3EIgBEVGlv+H2SpGDF9qK/F2R/ENWb8zOGh
	OJOsFuH5mD+fRR22GH73n1w7jqQrb9t5YhhfuCJjggGHGGERMBlaXOhPS8hwtWvO
	4fyMfy1x+FwP1ugAC9AUqUhSQI6fYGO847UppJNhljTpSz1ijkb11IrnWn7jM4bU
	FeJ5xHckd+LucTRbAG7FNyO4sbhIyiwyObgp7I7/IZqXlewynDRqtczCQRqfS1JX
	bQgGQVLw00Nmydf/+yBxDP76WpV3pql47axpi/J0xEm91AyECxlxsAKWdlx1sRek
	Cp2T33JePQ==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fmv03gaaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 05:58:52 -0700 (PDT)
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69e3aaf5ea3so4460628a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 05:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785243531; cv=none;
        d=google.com; s=arc-20260327;
        b=Fy+aG8nUN5gJq6cwAS4Q56Q6iOFD0en322uv9wTWQ9xH94r/laosubmB2BoVjn2Zlm
         UGh/Kk5qM53Djo4WtHM5hTADlWx2nsmEHBM/6+QLavsqUDqBg1wOzAwBB9qT+jCHHSgE
         AFI5i7W7fjM2+l1Rb2do15WxbP7g8GcjyHLfNY29r9nVt4+MVwkrAN1v9+Hyk5smUKMz
         ++fXHV7CsTACAtjpkKr0beo5BErHooBCGY+tvtnePO5YBjBEHGuY9LXYnslSlWK3xYvJ
         IfmejWdoxZI/DwHebShXuBovwCFVPHf0ZxPCAAE/wevYOOWrAM35f036diRl7fGbWIUy
         bepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=QhugU40GjKcu4+9ufgNH7Pw5kuHqIDfQcoIE+6xGOXc=;
        fh=NU3gZCL69FElhmlQXz5S312TnAwiOtt2IwaNEkKwO+g=;
        b=KggEzncDrwIdDhu3A4bAFuaRr5cYAOsZW5BfAZ5qM5vsc14xp1DZ6yQf/zrVQ5hLHI
         on/p2qZqL6GrYrGg6zBeR/GCf2846O5Bqxxm+ynw4/fVvxjL/XLIdgSPp5aO6FBuvOAI
         P3XvA4/pLwmLZ/Eqr5KR8cPqVbEgC8y6H76/+3Uxn7kSQ4cxE/qrAl4fDMBUtPm3N9wz
         vUVgrfSiT3QqNsJM0AMJGxAfO4ZmMcctxZo0jMDSKmS4VHp6fVEi3IIC9JxpTmijrpA7
         y3qVGPJCiTc/bkZ99njMQN1ou8+bsAWShvO9ITcemx8q+qrYv1FjoYjWMaNexkI6u1/4
         Oxbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243531; x=1785848331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhugU40GjKcu4+9ufgNH7Pw5kuHqIDfQcoIE+6xGOXc=;
        b=cPi352lKh5wd7ttcbstliy2BxCOBWpPcwofqN0octRS0YWcG0XY8fjmjUfEkLPAOMz
         KRYyveLnb1buFTiRpMCILsi7DiSWYplyqqsOTTKS/tSdXI8jmWMnCPdej2mDtGYj0ngP
         0NsHnN0BN6tK7to6gKK1PcwGQIzU01mNgmVz8r0ifdE50RsGuDbxHRpk465BmVqy4Vot
         yPS1p8uRzAEVcfTm7dd/CEw9nm6T0izZm7bwFZT1fVifgMHl5v5lCoVULHVoz4LIRcMO
         czZ5PMz0NWP7Q3qDkcDKrDEO0Ny3AqD2k0T0ub0aNh9jJMWISEtfkf2f6sdZwLiBUwWt
         TlBA==
X-Forwarded-Encrypted: i=1; AHgh+RqJGotQlfuzrO7cEk0ikHrECOIpe0NPNLSGzBgR0DgiiqzA9kh5NGPtxTMTT4UQV2u+FFH9T6QC6Ak8PPH8@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqI+5dJ21du92px1f76MacCR2hTPVP+E03Prc6MvGloBXmVD9
	linDo2kJbZvs+fTY2ArohGwujTCLFNnCPxx6yAS7/MRJE0UbL9D/i4wpl4uL38JFV8Ya4CShsrh
	FPlKmdJBep4YcNNBZ4H23ysBxtMvGZgW0J99YEiWiT11c7hgh3ffCdwwJn87nD4ZQVO/M/wDNGk
	Euqwj1Gn7gGQgqdKYjpPV3ew5a895j0NUXLP0jtD/M
X-Gm-Gg: AR+sD13fkwwDqqkMjqrifqOJkuDN/U4pBxJoCLcK0LNXrbfx5/K5IDXo5JFRik2P4br
	jxKR1rgEWOzpcvPX1Z8JzvUWVCtOtbortBmzbTxmY5vVgmHzXbfv7kVemuzDfyktdiZ1AHQAP7S
	vyd8ANnyShTMxfJ/n99oC59rHPMb3XLuXjoZMtZ99/qkRGcovAbUGdS44nOVksIV1s5063YiUer
	9mvEL0ZgQ/jHbtGxA==
X-Received: by 2002:a05:6402:2b8b:b0:69a:a9a6:61e4 with SMTP id 4fb4d7f45d1cf-6a034af6478mr1087029a12.39.1785243531255;
        Tue, 28 Jul 2026 05:58:51 -0700 (PDT)
X-Received: by 2002:a05:6402:2b8b:b0:69a:a9a6:61e4 with SMTP id
 4fb4d7f45d1cf-6a034af6478mr1086992a12.39.1785243530773; Tue, 28 Jul 2026
 05:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727143618.1582318-1-alex@ghiti.fr> <20260727143618.1582318-4-alex@ghiti.fr>
 <CAO9r8zNJ1cfCVgxtpqx4Db380bjZ+Z0P842eAxPXw6Mh4XBrww@mail.gmail.com>
In-Reply-To: <CAO9r8zNJ1cfCVgxtpqx4Db380bjZ+Z0P842eAxPXw6Mh4XBrww@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Tue, 28 Jul 2026 14:58:39 +0200
X-Gm-Features: AUfX_mzjKO3uJ7rF1H8sSacugSHiH37kgZqfgEB2G31tBk8Z2Cqkag1XvoujA4Y
Message-ID: <CAEmasaXR5EmGCv3T5AzM_2908R-VjfMcObrACyVGokY2U=+i+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: YQGD1JXaOP5yabr3Cz9a3q2la4zEKZHR
X-Authority-Analysis: v=2.4 cv=VP/tWdPX c=1 sm=1 tr=0 ts=6a68a78c cx=c_pps
 a=CYpx6mtW7qE8U/l5VCnCPQ==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=VwQbUJbxAAAA:8 a=ufHFDILaAAAA:8 a=pGLkceISAAAA:8 a=m9DhMxF7bdjla8aEOqQA:9
 a=QEXdDO2ut3YA:10 a=22KAYETGZJnyhCxlFjxL:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfX2ahDGSqBrMq3
 0/Q/HJ3CMqUPIkPdTHMik6KqHTTHu2fIP9oK0nUhXLyIoTpV/te37++YILZpzv70M4cUHjf4SJq
 pCdR8ta+OUzIdja+r1v916ygFqo1nck=
X-Proofpoint-GUID: YQGD1JXaOP5yabr3Cz9a3q2la4zEKZHR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfX/RFLYHvfqs28
 agSoB+kH9VmmlpXaJuiXAjKSZmgwrRZQng9Ku3MQbmUln875JwZZpu17GuNj/yvmNwBqb/EGyNY
 tQ2wR5aNJvqOozQPXjCplZ9DVnijk2AwQ5ktL/QvwDc4zVPstpjiUUxoCzQGxxq+TBDpUt/Plo1
 gHjD5mcXOzD9UdCvLLnQXep8MKLjqEGC0JeGWdynDKchzWBBwqWGdzaQ2XzIlx+0joqYyg3MdhY
 9f4QBAt0NBJYwdNpw44hBbL/576j+9JYc0wS1cDzZYKQA8Ubd7O1jGdzCiTGEh5XclEBEQVPFtd
 BZnrC+bUxT81nNIEnug6VVBr43QeHG3wXG59GKDan0v8zS1BAw2fU8wtKa/Qp5UECPtowE8VWrO
 dj2zZVtDw/hA/GCb9OVg4B6rwO5nxmc91bOlr5t4qtmwjxMhlpTs3y1QmXfbky5/xzRpWuyehLJ
 8SLqBpuy5hHOrM8fMMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01

Hi Yosry,

On Mon, Jul 27, 2026 at 7:05=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> >
> On Mon, Jul 27, 2026 at 7:39=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > zswap writeback decompresses an entry into a fresh swap cache folio and
> > writes it back. The folio is cold by construction, yet it is left on the
> > LRU for reclaim to find and free later, wasting a reclaim scan and keep=
ing
> > cold memory resident longer than necessary.
> >
> > Allocate the folio off the LRU and drop it as soon as writeback complet=
es:
> > mark it PG_dropbehind so the swap dropbehind path frees it once writeba=
ck
> > ends. Synchronous-IO devices complete writeback in this context, so the=
re
> > the folio is dropped inline instead.
>
> Why does this need to be handled in zswap? Doesn't writeback from sync
> devices still call folio_end_writeaback() and do the dropbehind
> handling?

That's an optimization rather than a real need: since we know we are
in a sleepable context, we can safely drop the folio from the swap
cache here. And since we don't mark the sync folios as dropbehind,
they never enter the list handled by the dropbehind workqueue.

But maybe that's not worth it? I don't even have numbers to back the
optimization claim, so I can drop this in v3.

Thanks,

Alex

>
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > ---
> >  mm/zswap.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 8163e6c5f76c..e37828e02938 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -992,6 +992,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
> >         struct folio *folio;
> >         struct mempolicy *mpol;
> >         struct swap_info_struct *si;
> > +       bool sync;
> >         int ret =3D 0;
> >
> >         /* try to allocate swap cache folio */
> > @@ -999,6 +1000,8 @@ static int zswap_writeback_entry(struct zswap_entr=
y *entry,
> >         if (!si)
> >                 return -EEXIST;
> >
> > +       sync =3D data_race(si->flags & SWP_SYNCHRONOUS_IO);
> > +
> >         mpol =3D get_task_policy(current);
> >         folio =3D __swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0)=
, NULL, mpol,
> >                                          NO_INTERLEAVE_INDEX);
> > @@ -1013,7 +1016,6 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
> >          */
> >         if (IS_ERR(folio))
> >                 return PTR_ERR(folio);
> > -       folio_add_lru(folio);
> >
> >         /*
> >          * folio is locked, and the swapcache is now secured against
> > @@ -1046,12 +1048,17 @@ static int zswap_writeback_entry(struct zswap_e=
ntry *entry,
> >         /* folio is up to date */
> >         folio_mark_uptodate(folio);
> >
> > -       /* move it to the tail of the inactive list after end_writeback=
 */
> > -       folio_set_reclaim(folio);
> > +       if (!sync)
> > +               folio_set_dropbehind(folio);
> >
> >         /* start writeback */
> >         __swap_writepage(folio, NULL);
> >
> > +       if (sync) {
> > +               swap_dropbehind_free_one_folio(folio);
> > +               return 0;
> > +       }
> > +
> >  out:
> >         if (ret) {
> >                 swap_cache_del_folio(folio);
> > --
> > 2.53.0-Meta
> >
>
