Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A64746AB
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306036; cv=fail; b=k2HpcOjkdvNUOkLoaxoX+tlWj9jZpVhvHZ7f9rjqwuY+ZllL1rOJinj04s+yDZd1WGn8FSbu1/7D8JIa0vob2Uy2QQL+NPmcQ0I2v5nplthMrSHnfpGJ+qR5KwQGM10r7cRs0HWef5uHdoikz1IqldBNWDjs8/wBf1P9FWE5Rek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306036; c=relaxed/simple;
	bh=6Vx1p37HyOgM9/Km0onzoptT8hUj9y++bwsQHXraWkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqXMnlGxy1mxwXXzaa0k9JGlG9/AwkIpGN14QEQfUA7Ym4pFfYBzrrUsd2DvrvvuQeDfLDycJjhvr3R4766VWEOfydLTsoAqd3E1hSH44XyeGUOc1OBk/UhPayWN0ghwPAgLykvdrehYzKYXxXvdbR60a0HjJbfqNcdUVRnkDsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LY0XSeJr; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LY0XSeJr"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9Lc9S3524177
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Q/b5fVo2WxJIZnLRI3/yvoL8jlPSjpb9T+ok0
	n3ErCQ=; b=LY0XSeJrzaoLLXHaa1OQZqLoVbsuZvyCQJzBJI6Bpc3zYPsHyyQb6
	1CP2XY8YkUqy5NDqVQ3sW3fxmFq8KcAOlGof/gV6uD5oQsmqaz79YSlFeiEjm2oG
	GyaTI6R9M0qOadiiEf3vd3xeNijttySRR7Nbcru0uxWEsAOqGoKfXrtDzEc6Q59s
	8KYgDS57nWWyN9yNJw2mQPOAxch6ASz8ZjT29MSq692FcoF3Dk3cU6W0Zw+wLI7e
	x3jBpNQ9H3t1bIjZqnkG/drNJCYVXeQqew0h5ONCDwxZEJ4ExwV+6CBQAdjUlhi+
	fzFk3uW4BG9nuVSWbRMbblA545jPeFltg==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g6a8gu9jd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:53:42 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-69843ac68d0so824374a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787306021; cv=none;
        d=google.com; s=arc-20260327;
        b=puNGfsJMM8VRo5jnV5rvdy23jjoJXaatTz51IIf0kkOMiRl1pb0fnsKoifjhS1I+r4
         a9HwxmL29vn9E9YVQKaF6PDgrNDlcirfN4D4a/gPsNMvg3GNj1l6k8W9Ojhn+MMpTqCy
         ja5fHDf3rEJir1Kj0kCxutbQ/RPcB6KQIXlmrvwb4sBHKAwuHULSC8/qxl7Z8lCfUvk1
         dNmGvKI+yauyHbaiL8b26G5so2sSxoPCQi2b0kiVTq5c+O4DiAaC12xRhMgfPx0YbFSL
         p2yEJjwSEUXDZ5LZE92mwQSzTz+M3KoRXfZKiA60d37Y65vGnmAzeww4n8j5z8yS3hiS
         hvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ej/zOQeAlckNdnxilgVX/wASDqQzfo0LnhQaPbJcOkI=;
        fh=lxyIkDbJPtn+orYhxYqGjtnmPsIDi1yeVqtPlUnD21M=;
        b=BCefTMwqA9i07LFlL7vFgto1Pr3eJuA/jqpHmiCmONxm8dn7jW3M3nnev3MkXBHpCD
         JIym86DDnm12+uS2djhEE2//Y1i/cWaOJxxhwxJCBMZfpKiXW8fu4ydM2/ZQVZc8r2C6
         pnRqouHc9U4/eHUUIK9aoyETJ/PFldjZuzrazsm+Phs+ZUO20yHmSipVWpyFLxz0/Too
         r1zGfdpSZullFfws/hE+DQDKPGkmkA6KEvbAKSB1GHcSoriFVxo4zyqU2Ch62LX/sEDG
         M6sYBmSZfptPjv5J2NQQbSCKtQy0zRG29ZauIYvAcX+MXMgNzQiInjpY/7FzQtBRXuoM
         L7Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787306021; x=1787910821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ej/zOQeAlckNdnxilgVX/wASDqQzfo0LnhQaPbJcOkI=;
        b=dxY/K45xg8zNQ2YEgxGTrUFMD9nWn5N9GS1aplXMlzwVCETttO00YH0DF9eTscfpd8
         APvS3lA2RhNMJGXbBWtRna1t7WVFUaahBKJqFTp/8oDgdMKqpJrQFcjoAbouysk78YtG
         40R4TFOJ/B1xnBPjYJ2i+9qz86+besOtzZL4EbHck1ihczeU1qZpgyOuUK5l96u8n1dF
         L9A4eXnyr7R+yem1RSDe7dvxp82OM5HYqlmW8mtDgDCu71PsH6u5FUlx8oPbraM+pMmH
         0WOJQrOCTgpL36VxZNgZ2L6zYm5Ri0b2tAVHp9txCLlAuGtGg8yr7Gqa4Yt+12OiDchH
         lEQw==
X-Forwarded-Encrypted: i=1; AHgh+RpHzFLmiaq7ANMPU7R3I5y/M8bU+JzHLTwRoftQ8He2qDCJv0q4t6YP1ZGQBPmoGtjL80ynCyv4iMmMyrvD@vger.kernel.org
X-Gm-Message-State: AFuF++mVXKBFyTQoXCpmQYu897o+d1StHMhrG0EHon2nJ9dNWu0lS8E0
	FuQUd2XqvcecBYDsuwpReJtsMHc/EEf4inVoNA3IONbweU7hEROdfPai4hfrRRopwmKCUx34guA
	Y9lxzktVXVJtt8XQr8mWuRBzJAqIFiUxc7IOZI3og+XP5AeefA0PlxjBtw6UVbsaGRr6c7iTQLb
	s2VGfR6GKf/V6fjWAUMAei8xp1t4zizF/aNvy7xiKi
X-Gm-Gg: AR+sD11mlxEtyJmc0pTIM+RwM87zlMEzfiJWfq4/ZA9QhVj69IjpCS+hdU8gg57Zyhp
	WfsnsIWRcSKUv9rMrK8DV3lmZm37IqdHPqp76250bsEmlYVQkmWGsuNCSoiFCHuAciIjFzCOhGn
	mRq4hnUDx7Uid3xPpfOW9UopxDXUqzdtjEvJn7i50hdw/3Ue1daJh79Xu2rsrUyNF4Zqf6ysp5v
	67yuMiIwTSuihIdyw==
X-Received: by 2002:a05:6402:2353:b0:6a1:f95b:8cef with SMTP id 4fb4d7f45d1cf-6a42f179014mr4703999a12.4.1787306021567;
        Fri, 21 Aug 2026 02:53:41 -0700 (PDT)
X-Received: by 2002:a05:6402:2353:b0:6a1:f95b:8cef with SMTP id
 4fb4d7f45d1cf-6a42f179014mr4703944a12.4.1787306021163; Fri, 21 Aug 2026
 02:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818163221.589352-3-alex@ghiti.fr> <20260821083500.856970-1-kunwu.chan@linux.dev>
In-Reply-To: <20260821083500.856970-1-kunwu.chan@linux.dev>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Fri, 21 Aug 2026 11:53:29 +0200
X-Gm-Features: AcwNN1VwPpnVY928RhWmXd4qrgisMWDu8nlBflGB812tXUe-FhICPDNcvqK498w
Message-ID: <CAEmasaUzCU7r7DzJfMFbQGZCJvA_wOJifPywQmy8mOz0efWn8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: swap: drop dropbehind swap cache folios on
 writeback completion
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Kunwu Chan <kunwu.chan@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3MyBTYWx0ZWRfX6jvjfO1CL09+
 7lvnx0FI0l0DYlIsgVfgvpx98NyTw05xRUKTFpD79Xpo8zcOgLzJP19u6dQQRXStsQifS1968Wl
 /oXrFfG4HlvolSY7ULD3pf4O8I7DIUk=
X-Proofpoint-ORIG-GUID: MhweWNStfkVc1BP2w9bz6MCyUxQmIID4
X-Authority-Analysis: v=2.4 cv=PbHPQChd c=1 sm=1 tr=0 ts=6a882026 cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=pGLkceISAAAA:8 a=aLlJzFw6OyoQ_NU6FLYA:9 a=QEXdDO2ut3YA:10
 a=j5kO0B45gQVIxiUYEfTy:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3MyBTYWx0ZWRfX0UArbquZA+eE
 AGiGcpffJfEFcvOuefM58/YiVuBlYrk232/UXk0INap/SmqP42CbpVdrkBselQadNpIhRqsYGMU
 TQT4dx0+4PELfMaFFkh01dfmgSh8hor9e7/ix31aeVjerOHYyCENNKv0vTk7iPV1vJYH3028iN/
 muuLQ/P1Njpc5cM6YcJMgNJkKxDJCM230mL45juup/88r5ktQi8zRsbZH2Q0rJjfippSCny3De9
 ZNwqlk8weK5Hg1POCoEXPaU8tpAwQGZIyZk/NMEi3hEz4bEcxRYVp6wJ9JrFRa5Vg+aygB3Y8Xc
 VI7w56jNgx0rSWga+jgDAFK+eQtuiywxCrQ41zgr+Bt8mzdOcAPNb0C5fY6gaEtqjkizGQjNESF
 7SagBnKkIeHWYG7/QFcyMEwHJ9QwDszSCKHdQIcSdRlMR7QkDJ84byY2fmhSbEpX2AfCUBy4stR
 rnDl6fEnXr1Uu8PK8Hg==
X-Proofpoint-GUID: MhweWNStfkVc1BP2w9bz6MCyUxQmIID4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01

Hi Kunwu,

On Fri, Aug 21, 2026 at 10:35=E2=80=AFAM Kunwu Chan <kunwu.chan@gmail.com> =
wrote:
>
> >
>
> Hi Alexandre,
>
> I have a question about the reference ownership/lifetime model in the
> synchronous-IO case.
>
> Consider the synchronous writeback path in Patch 3:
>
>   zswap_writeback_entry()
>     folio =3D __swap_cache_alloc_folio(...);
>     ...
>     __swap_writepage(folio, NULL);
>     folio_put(folio);
>
> During writeback completion, Patch 2 does:
>
>   folio_end_writeback(folio)
>     folio_get(folio);
>     ...
>     swap_writeback_dropbehind_folio(folio);
>       llist_add()
>       queue_work()
>
> With synchronous I/O, is it possible for the dropbehind worker to run
> before zswap_writeback_entry() drops its reference after
> __swap_writepage() returns?

Yes, totally! The window is short though and in that rare case, we
would fall back to the initial behaviour (almost, since we put the
folio back onto lru but not rotate it). And for async devices, I don't
think it can happen at all.

>
> If so, the worker will attempt:
>
>   swap_dropbehind_drop_folio(folio)
>     ...
>     remove_mapping(swap_address_space(folio->swap), folio, true, memcg)
>
> while the caller's reference is still held.  Looking at
> __remove_mapping() in mm/vmscan.c, it expects a refcount of
> 1 + folio_nr_pages(folio), but the extra reference still held by
> zswap_writeback_entry() would make the actual refcount one higher.
> It therefore looks like folio_ref_freeze() will fail in this case.
> Is that the intended behavior here?
>
> If the removal can fail, the fallback is:
>
>     folio_clear_dropbehind(folio);
>     folio_add_lru(folio);
>
> This appears semantically safe, but it means that the dropbehind
> optimization is lost for that writeback: the cold folio goes back onto
> the LRU and has to be found by reclaim later.
>
> This seems particularly worth checking because v3 intentionally removes
> the synchronous-I/O special case from v2.  The cover letter describes
> that special case as an optimization that was not worth the extra code,
> which I agree is a reasonable direction if the generic path is
> sufficiently effective.
>
> Could you measure the corresponding fallback rate on a synchronous
> backend (e.g. zram)?  The 99.996% success rate in the cover letter is for
> asynchronous NVMe, so it does not tell us how often this particular race
> occurs with synchronous completion.
>
> More generally, I'd like the reference ownership across
> __swap_writepage(), folio_end_writeback(), and the deferred worker to be
> made explicit.  If the caller's reference can overlap with the worker's
> reference, I'd also like to understand whether that is an intentional
> and acceptable trade-off, or whether the overlap can be avoided without
> reintroducing the synchronous-I/O special case that v3 is trying to
> remove.

I need to look into the patchset that Matthew and Barry pointed to and
check if it's still relevant with this patchset on top of it. If so,
I'll add a debug counter to confirm we don't fall back too much for
sync devices :)

Thanks for your comment!

Alex

>
> Thanks,
> KunWu
>
