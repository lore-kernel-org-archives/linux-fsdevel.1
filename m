Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA03BCD37
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305631; cv=fail; b=MeolvRTUF2SmgPW4He96LOu4RbDETLL1Y4i16+OJ5x1+uBw3z/E5Rn5mi/tikWAmsr0t9H+Hq4LraaJS4r6Hwyv58PqeqqDmLSyk+7iKXWk7Lepj7B7AEV035IqWn+S3zsWPLxm+uG5JxIkwj0/5p9pkLAn1a0V1SpVaZFkLWFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305631; c=relaxed/simple;
	bh=fviS3Vs11g99Ubp8acHCjI/Ckf0JMT1UrgWtoLzHHh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfx6MkYbh5DC2MzuO0uibmVZcjfcEazuqPjxJVyrcPSS6530FX2SNyway4rqIgxILxx4mYco/ScShPswPu7EtnyJBckqCu2WT+se9l1+CK4fmqdsTmpJYW+cBmB4+t5JKuwpJt3+Uf/+3bGQtGvdhfPFwKNfjfOMULxS9apSLcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aS+VXbnl; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aS+VXbnl"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9LlT82733744
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:47:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=EWPICfmisuXNhOObQX5MJ7az+uKvgkfEFOnr0
	vRIyL4=; b=aS+VXbnlWPrTOX1n6dVZVi98Dd+PZthKSZbPoEShqzYnyUIxg/cP8
	+42LAR2gGgRPudP5EUyHzYVnQ3k7ZFdQq8SYiomjZPzXYUDv6TnugtzLEGrWOAk3
	5tjLvHQCDZTC3zYsm41E94ptYEHx5X73XH1FdSqCMDPnefqK6SnkOQCYfAM9LP33
	elxW9o/cin/BzIut8HV/ct3n1i6Hgm/AtAgdGevxe6l7DvCeCPZLWo2sIIqI10IK
	SRD/UEnBrkLBsrabc9HEBIfNRvPBeZf4au3TsmxQDVMpiU6ESRbncjeL5i9SHyiq
	Tr6xN4ZZMGp3MP3pjlXJE2pHjnKvlIRtg==
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g671yvr9f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:47:00 -0700 (PDT)
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15fff01a30so49322666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787305618; cv=none;
        d=google.com; s=arc-20260327;
        b=AeIf5WrifyIJlBVuGxSzF2EebRn5wJPcZiGqRJO7Wwj362weK4yZqeVyL7uTUXhfdt
         FG/Xso7UXL2bEKV1CYxQEuxEATpJ1jzMplvd0cVAATuXD/ADsLvWuoilbZewAjtgKqIz
         i7yoT5HwRjjmFPYJUz8tYJS/ADzF004LqIIvQoelJYQzRdOGWNQCwlSBbm16Rn3tyr66
         r0GCwA4+th5JgAMsnbSZdtEh7YdHAaVf/amS9y0Gd4H+wl3Pdvdz87Ma4hxj3zAYuk7C
         kzgjx8vBrpWPqe/dyluRkfbQUpkwc9O9kzs4yguDrRG9MwPFHOUnQc9UN5PbNR1ZwRgD
         MmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=9HkVIzWd5Q7EoAIhoiC25FGWtLTwPi27Z7RdtMF5NV8=;
        fh=Z80PqtzHx2BGmbp2o61/ACYuOb4rFIwvLEbLal2ktas=;
        b=OZtmIDZ0cY5XflX1QN6ib0bfTRgyLZGkTyKPGO1BIQBm1DnAvZVX2HVrpqFDUEDIaP
         UE8xOM0gAuHPBtiQ7LU6jFEG3TlvpuQgRo64w5i0bvXmIovEciUIbVWjIQWt8GjlSQb+
         SdRpR3iPjUs9vMnOvOUBBEueZmMDhUl7eBYdq3ZWVx+gdhzfl/E50H4Xi9NBO4pAUOqt
         I84vY8qDrx5kQ75nD13JAF0fO7arUFB1nztnRhgpRCcpc5JeGmrxmTkfWQq6LLrM/uWg
         CWai4IpApbQazDs4+FVz2SOjRD7zAI2i8e47Os+0sOnC/b4lZaXo40752VkEFanBshxP
         92Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305618; x=1787910418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9HkVIzWd5Q7EoAIhoiC25FGWtLTwPi27Z7RdtMF5NV8=;
        b=XMj2x8u4lUxSbsn69gYvfWf8ImhvgmB61eru4XxWs3O3oKJ88kjcrqmAPLfLVSg5BJ
         OIfSRFjPg0I4POK8h83kr2TCs8zK04ZZRbzgwvOFd8KnlTVGmLdu3DyaXULuxPI4clLu
         hqC86XSrj2EP0UpIGr6FJOj4Oj5UY3pL3jGEkaqNtT5I8bgSpIORMGV2bsYUY8Zm035u
         Xgz+qLEyoed4vd4v+DwbxyhL+Zzdt6UADCO7REVlrCWeJvpiUaObENX+ylWJESQ3ZaVj
         ae9zBXkgbMT1wu7QHTUBHWZj+ozzy/Hx8CN2ID4Bdab/bYKxnYbMr36h1i8djvAJ7pIV
         K/tg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7RLSz0Zg8Kk1aLYl1ngby9Kvqmf+YkMo+EOEjmUiUaIfF4X8a3k1ardOkOJn9UlAS+RF0d/ppIa4pxsvt@vger.kernel.org
X-Gm-Message-State: AFuF++mPvkXlEP8pC/XrCulSL86j3mkfk4mU6Vqe0g4jCEmsF3tkOTtx
	rlqO1D07DSSpKVDWsJT5+tD5BLQy0m73+BRHivkeMLcTNEGWUTNui+hcjub5Nvrh7d96/rMqM0T
	MlhEL18QqypQPKdDF6tnPfRuRaKZbHlS52MU1yXj8O8d4pCjWMUxyUSm+40Yh6c9MJHw3SNoZih
	1skR4UrPLSfZS/tDZr3r6Y0x8D9k1QCWecwbw3O+fv
X-Gm-Gg: AR+sD13LlrWkWQsc4G7HZ0afXKQDnfKitPB9HmP+Hrl/TLkrq/tTtC7XYGvPffX/GO8
	jnRnf5yhCeQFyVvDpxVSA47Y3TbgaK+9lyxHMZK6bLtOQn2RNIwCcAPehxkiUwsEds78RLk9La9
	eeWV/IsmYttXflwW6+neCO3BUAqDYHP+LbPCSbSNhnPemuGfyuYGVo9ZeBF047P+wIITsZDWnVi
	JWjhTgYCLCildEvMg==
X-Received: by 2002:a17:906:fd8c:b0:c21:960c:ec23 with SMTP id a640c23a62f3a-c246a2ebbc1mr501771566b.1.1787305618458;
        Fri, 21 Aug 2026 02:46:58 -0700 (PDT)
X-Received: by 2002:a17:906:fd8c:b0:c21:960c:ec23 with SMTP id
 a640c23a62f3a-c246a2ebbc1mr501462166b.1.1787305588569; Fri, 21 Aug 2026
 02:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818163221.589352-1-alex@ghiti.fr> <20260818163221.589352-3-alex@ghiti.fr>
 <CAGsJ_4zC+wAuevG+i5y23rLPGXn0P=D7JpMECnZ1OuP1BsyYkw@mail.gmail.com> <aocfZSYFRvP7_vEG@casper.infradead.org>
In-Reply-To: <aocfZSYFRvP7_vEG@casper.infradead.org>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Fri, 21 Aug 2026 11:46:17 +0200
X-Gm-Features: AcwNN1U92tbMl3QMGUITXTu8dg9Y8CfgfmciuQft7EBeY9k3ATLBAj1TjTK2Aq0
Message-ID: <CAEmasaUmA0Z0j82jF_VnYBM6gsrtDiWSf_ev-2pdYH3xPJ8Yfw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: swap: drop dropbehind swap cache folios on
 writeback completion
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <baohua@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
        Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Kairui Song <ryncsn@gmail.com>,
        Chengming Zhou <chengming.zhou@linux.dev>, Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3MiBTYWx0ZWRfX/PunAhi0pkPK
 3exumLJKZ9ZJbazkD6C3eEskzroCF2hMpg+XhlSBTVhpftzWqPYTEMxZb9HgQaswzNmSobC8DzZ
 A/w3X+u5AGVhThtrxZtii8d7Vgd54E4zMAjrIleepkj3EmRqQbYH6pFX4i9ttzhnrmOBB7KoTWG
 AkAVcB4uAvw8FTSUsk1mXLLfI93z+mXKeShjddBIf5HEPEdfLIOM1jl3J5udVvxtwXwqdzMGINv
 jL61B/VJrfx2X1cBKMM7On9PSnZwroWGBj8i1Z+PzUGawuyCPj7aNHHFVP9WW/mBZ5q7z9ALoLZ
 pHgPcBZr791BRgx6HlpI7AjoAJ8/weje5xmI4gEL64jizj6U2bSUz00ECi+ScvdPPOBs8Jd4Lok
 JuoD9nQ1QN3yUCVgeu2Q1sHLH+vLCQfu8EZUhA50mX4SgFs+ys+Nhmnr7xosyL5Ug2evq/7nYJs
 uroHzuvuvyyV5tjZANw==
X-Proofpoint-GUID: SW5nH8zOxF6c_RxZ4Hw1iG20arZCBv8o
X-Proofpoint-ORIG-GUID: SW5nH8zOxF6c_RxZ4Hw1iG20arZCBv8o
X-Authority-Analysis: v=2.4 cv=Ve7H+lp9 c=1 sm=1 tr=0 ts=6a881e94 cx=c_pps
 a=jJvPsHQLKLf2UdvVr97r4g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=JNZ-dC8AXez8hvWtwcUA:9 a=QEXdDO2ut3YA:10
 a=q7aydO1c4wibL4nb3gNS:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3MiBTYWx0ZWRfX6oeAkzja64fk
 2XkCmKooJDQbhsyRo3hQb9ObAz1/mfJpZx8P5Xp+oSa8hiv4iy/8PNsIwYFbtCoiishBP27b2Rn
 KeCyg6Hb2ty0wRPSDMCHggCEGgpbcG0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01

Hi Matthew,

On Thu, Aug 20, 2026 at 5:42=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> >
> On Thu, Aug 20, 2026 at 07:36:42PM +0800, Barry Song wrote:
> > > +void swap_writeback_dropbehind_folio(struct folio *folio)
> > > +{
> > > +       llist_add((struct llist_node *)&folio->lru,
> > > +                 raw_cpu_ptr(&swap_dropbehind_llist));
> > > +       queue_work(swap_dropbehind_wq, &swap_dropbehind_work);
> > > +}
> > > +
> >
> > This is good. For file dropbehind, I see both F2FS [1] and block
> > devices [2] reinventing workqueues in their own filesystems or
> > drivers, while folio_end_dropbehind() simply benefits from its safe,
> > sleepable context. This seems a bit odd.
> >
> > So I'm really curious whether this could be extended to file-backed
> > folios as well, so that those filesystems and device drivers don't
> > have to deal with this themselves.
>
> You should probably both be aware of Tal's series:
>
> https://lore.kernel.org/linux-mm/20260730-blk-dontcache-v7-0-3e8e6850068d=
@columbia.edu/
>
> In fact, I'd base this series on Tal's.  It would be considerably
> easier.

At first sight, it seems so, yes. I'm looking into it more deeply
right now, thanks for letting me know!

Thanks,

Alex

>
