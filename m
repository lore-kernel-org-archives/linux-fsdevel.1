Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBBE43B6E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314065; cv=fail; b=ct6Bm+6C8lp21V1n5+QybyaYMLAA/kE6WtABBsf9e6Magq2pV5pD1l7IqCuW9C2b2fh8+/LCJjxZ1rX36ntGMvRD+uF4Luq+mR5a13Q46Wkfr4a3fQ9iHUCGIakIQlyxdCBLC7vU+ve9NGVas1ui5B6LNPa7pBCzAYRBdiXDNAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314065; c=relaxed/simple;
	bh=Trtz2XPNLC7KoZV6jg2uWSprqh1Z81NyKjZp3w6DGEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8/fLC3VxQBNjHFkpCus3L4JBcD4ykINmNmFArJwLkWVLUpHy+nQ97AM/O4//EIDsXnWdf8WZOjHN45P2MYvgzsHJ6seq2okTEtlixEC+iYDdRiGixFHNBOiUFDKCDJHInPSdFy9VxEFiY/MHdXCmGJo+8CQUPZmhaS9TiQNzqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mfmw4weW; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mfmw4weW"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7axCT2834273
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 01:34:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Trtz2XPNLC7KoZV6jg2uWSprqh1Z81NyKjZp3w6DGEo=; b=mfmw4weW4jQy
	WoRdAxfmX5Q5nygSUX/2hoIKuMG//IV0hJ/EDU/elqsU5U56Dg5Ci8Is80mHenhO
	hIS77I/lqZAavXRIDgaLLiN/QpmrattOzgQB4tp3nuSRLRLxSQne2m88LxG/izNT
	pqwCIwRtMZKPbqBKPeamqsntpKWM8BqV+zBlNt9LlvhBPeVZLsffIVGYrEty0uR5
	woeocC2WpZbpUh5xXea+IlimxptkmTFExxjyyO8eFaTmki4UslEJjU41AEalJYPo
	y0f4Y1i2y+roMCiyK0Ckp3cCYomOLIQalrpFpZn3yLN7Xlps1nQZOnUMbKYJ2767
	Zjw98Qx3yA==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fps0xrthr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 01:34:16 -0700 (PDT)
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-698c181a258so796105a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 01:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785314055; cv=none;
        d=google.com; s=arc-20260327;
        b=j5I5+eFqOAoIR5DlbWWUd+ACiWIi2pCk+axt4FGVFt6HI2DGjQinJ50XP4JWsk1HdC
         fhVDojWU7znHOi2iY6ocamWrYev946ZYVQSGUzh0Q6ugF/qugKvDmeyaAohS4Z3VBOoS
         mnuO+SzseOkUv9UNf+iYvBaG2tebHZ3X9wY5GzfTsdLzA87mFhchutySnprh4A8t3KkG
         9Sss+vQNU5QylNciVjMKFaj6XzcgXz/yk6CTGbsemtrSAtY3KoGA6+X/rglzVQHoLJST
         D0L9aVOvTWwVn1jNXO8kKUvkpSszmQ2xgIQX4ZTf/FYgZfy2k5/iMFQiQEWddJIb8WO4
         nrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=fuEIQKIblYBIfpn443b/vHvFxKnCDuM2Hbu5e3yS3wY=;
        fh=bqIDlanqQ6YjpKVdUOU+WWqXIo/zz8mJSnWtdKOmCQM=;
        b=f435xGQzsFg3RZYi7Bydl2RIb640Iyt5EQEnniQywofeLT8Z6PHOKZDTc2UhG2x/cz
         D3aCiybbwuZbuquAmFVkXbAML5pm4d+yy78EWLT9w5r+uvx+C+PWIxw2sOuTdf4Cx5NF
         PeknId5DTTGl/zesRsjjXTUnPELgzMYHXlltEfrT+8oIX46T1bvXYh4uulQB0C1Fxc6V
         85kzBM3kmgDmSB02u4D3nZV7tRx+sx6QPZSYjagGNcZVTJYuXv23aQujSSGqg3rk3J1l
         1GEqhEobrlaDL9qSNi2dUhe52stvIqL+Ab0/hsYYoVSmcCyjV+9UUO8q901A9Kpo29iv
         a1qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785314055; x=1785918855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuEIQKIblYBIfpn443b/vHvFxKnCDuM2Hbu5e3yS3wY=;
        b=Kw3swg0UvX7Byh420C435F7oL2rRA4PGRTpbju8klve7tt5JSBFMZ0BN9Ii6bQJr2O
         ldBC2UkWHnrzJyray2CmfG7QeGj3W25khQnnD65GhWIeD0W7XKqS8E0Lnr9P7fVw/3jw
         FxI6LLYVPJWYRVTuQOZvekzQ/5OhvhG7jmOHxycduIPds3DHTTx25Iz3PEzqgE2jhD5j
         3RPBJ1/GZsvuv+LXOmHoIBmvJlfRI5K4X6o1l8p7gvWv0VoiQQUbZXXCu9yTmaVATQm7
         UILmkWDRMNGqU9x3c5faZNOObraGiOWKvgK81VoUroHoivxglgjZHupziPY0V8h6H8zp
         YCxw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9SoMKSpc1iq5HvBmW6QVyp9M4m7Pfik9+Ov3XavsshekKwOmoUwx8KGoIEhmJinbCYf+JwZt+7/S51XJR@vger.kernel.org
X-Gm-Message-State: AOJu0YzxU4EBD8cXG2uFxCGmNl+io+fwzqZp1LS6qkP6a+TcVEpMYh8U
	5bgQ0EHZHZ4wgu1/czn4zKL6rSYRnSkeWjW1IrXoPqacGq3Zope1d4+Bm7XvFtIQDKwznCZv8Fp
	gZNJQxuxtHSOm/NY09NKGUfRIHTzeX8mLTsirrcFsY6L3eGFbDgfVWHdRJEqvvPpLr7laHze3cR
	rkXVcJH7wjGkCmh+9xt5ZVzwY+koeWsNnsJXXaKdrP
X-Gm-Gg: AR+sD13YUCbXTels1bACh9A7NEUxqxN9bvllKOehUR48ZJPPh288XMxjPSB1y2IoZUv
	9H33x9noFVS94B7xuqtvNIMJis6GERZXdqQJ09AtszB/a/gGdiJKiWI3I6pc0rdliYtVUt5jAVS
	vBDqxxQRsaii14W1SOmsvO4xhXmvcDlApiOPpqR3pp7E/nuUjXefjH09YsS4YeUIBAhla9uc1zW
	BvR6eNjf1KVQOfBYg==
X-Received: by 2002:a05:6402:2b8d:b0:697:f6b2:a94e with SMTP id 4fb4d7f45d1cf-6a0349f8f61mr2915386a12.13.1785314055553;
        Wed, 29 Jul 2026 01:34:15 -0700 (PDT)
X-Received: by 2002:a05:6402:2b8d:b0:697:f6b2:a94e with SMTP id
 4fb4d7f45d1cf-6a0349f8f61mr2915363a12.13.1785314055197; Wed, 29 Jul 2026
 01:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727143618.1582318-1-alex@ghiti.fr> <20260727143618.1582318-4-alex@ghiti.fr>
 <CAO9r8zNJ1cfCVgxtpqx4Db380bjZ+Z0P842eAxPXw6Mh4XBrww@mail.gmail.com>
 <CAEmasaXR5EmGCv3T5AzM_2908R-VjfMcObrACyVGokY2U=+i+Q@mail.gmail.com>
 <CAKEwX=P5G=Ckafy6fm9ws3njWP_Zm_AHRKOFERScB9Pkd_KvGw@mail.gmail.com>
 <CAO9r8zNsZUvMknjmH7MvkQ=09DnB9YvtYoA0ei5Hj_cESQAVPg@mail.gmail.com> <CAKEwX=MPPEBBepeaJtvZUZBJL0KmP6zGevD9HqTiUCKO4Pt_Cw@mail.gmail.com>
In-Reply-To: <CAKEwX=MPPEBBepeaJtvZUZBJL0KmP6zGevD9HqTiUCKO4Pt_Cw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Wed, 29 Jul 2026 10:34:04 +0200
X-Gm-Features: AUfX_mylvwT-a_Iq9J_Pzrl5e1_Hilm_Ktb9JmucbbE5kH74CuZaqKgFv6dnS3M
Message-ID: <CAEmasaXKFkyo8q7Or7DEeLYacptozw4RtSBGrPLChbpQS8UMCg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2OCBTYWx0ZWRfX3vCzxvMSr6KT
 aQRbVVvDBOeJxxIjMt+nqVyFl55odJje8Tazcn/eJnLObzNxD+KJWPuYWbmvKEE5Z3gJMBBzfco
 QxABdlqmk7/P9+nZ3i2nNbcOo17XRnE=
X-Proofpoint-GUID: z4hxaEi2V0KZQqAzjpZQ-yOo6oDSFvLB
X-Authority-Analysis: v=2.4 cv=PMo/P/qC c=1 sm=1 tr=0 ts=6a69bb08 cx=c_pps
 a=CYpx6mtW7qE8U/l5VCnCPQ==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=AMAE7NpZmBqY-1WNrTMA:9 a=QEXdDO2ut3YA:10
 a=22KAYETGZJnyhCxlFjxL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2OCBTYWx0ZWRfX0YMp7tSU/WAI
 4eQJMmypjL4B/j2LLUdLeknxaM3e1qIRs9F+06maCMUcAhWKI1a8LPDhfjAAIxqk79SDXT8iAsY
 sj79gERqNVLk1tCozLbtPB48Vlh80gAFxQBc75NDTkqFqK0zM5k3BlA9OOAXvR14w7UWGnPCWUz
 iQJktLy/rTZRDQlIXFk/ozfKgxIDT4Nx3qpA5wH+WkffcDRZtTp7CcdAHt6QVqQuCs8y6cYd8RA
 dRzQTCsGBPFZgTBtbMbE7wdd9NnrxuaGZ1R9oJhtkufTcizYXMgyS03hkNjPXlcTL2NTPBXFEuB
 cCyDwxYz24sS5o1/rboM+n8CFdyP/q595GxwG4SWhSaL5PAzcC4Vmq1vr3X8DkGLOH4fwyDh6na
 TcfpeeuCqkt6qJk1EPiNjgIV7cIJGjrVbBAWzRtNd1954WDj++dO9VoJipuk5Y2bLXZX70KuiEe
 DCjWI/jfJTGMLl5f9Pg==
X-Proofpoint-ORIG-GUID: z4hxaEi2V0KZQqAzjpZQ-yOo6oDSFvLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01

On Tue, Jul 28, 2026 at 6:13=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> >
> On Tue, Jul 28, 2026 at 8:52=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Tue, Jul 28, 2026 at 8:48=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > I don't think it's worth optimizing zswap + sync backend tbh.
>
> Yeah that's what I'm thinking too, to be completely honest. But my
> mental model for sync backend is zram, so I'm not sure if there are
> other cases that are interesting that I'm not familiar with.

Thanks for your feedback too,

Alex

>
> Normally I just use zswap on zram for correctness stress testing :)
> That set up fishes out a surprising amount of bugs.
