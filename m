Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DC3F1AB9
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563863; cv=fail; b=IsjMsZIv1/w6YzvEThtu9Qa13CEK2jeYb1iqB+ZKXkFKbgbdy3lOP2v/HuUAXRpD6MmK03F023++XNZRKtr2YbhYcTKZPEzKgOVha6RwKM9YM6KkSyduG3bB5orqBQmPyevToI6bin9PEdZP9cymhhFtY+/f/8qFxD763aCKHWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563863; c=relaxed/simple;
	bh=zypUTHPlA/q7uIPBIoYXCptEGPZN6whAepusbDKEtLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1AbO8Kh0NpWpMZDmqg8RB0XTpn/AC7UqD7N0oOAia4gRzuPKr/1T2ZxxC2YD4sVv4G0ubxZGxuWhE2JCNS+uPxgPsBjG04G0thgogF+125izJCuX/A0YOEhuus1XD+63VMJ7s60KnqhIKi0SNj3Z+pw9pmD1kddZXyUFDsUyjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dI+6kXI/; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dI+6kXI/"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O9DfMP3562330
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 02:30:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=M8DZUU8ws4G48jL7qrLg2Wb7OYzN6HftqEYSY
	KuUsMs=; b=dI+6kXI/kI9/KL41RJv5l1fMuKcdyyJvzNjCrXD4BzVev9ZDDi7z6
	OG/vIlJtGFkA18TaU1Ll9XR4WBd5mZNAo5Msygm1xzO3MKCzpMzv3WKxwTEwIFJS
	mKfrvsoqxI5+/foBGfneWDdiRAO97u3oCZqgG9PqRXtS4RqP6i//DMVeFUWaF0ZQ
	Vbk9q3mlDD7611LdGvfmJ5V7wFxiueKed11ZeMgFkrzJb3ioaRCsmbMSgZni+Obq
	bkmoX5DetSJKGkUuwHeLGjVcJ86JHE1Mg7OwW5pQhcO8YQy0Mpc+kdLKk0BcCj/R
	jrewLn2Z6drNxGGVJc8wPJVgMQvM8aITw==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g7wbhvwpx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 02:30:56 -0700 (PDT)
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a3ec8718e2so343916a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 02:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787563855; cv=none;
        d=google.com; s=arc-20260327;
        b=hRF7nY/PA7WkIdUEqubvmTMWRF+iti5AITO1hhWt6p60l1AgAQ9KwOIzqgJJFIrBX3
         rPRtbxfB/vqp+bE9XEp80SzD/rPLZVtBwSDLdssZXRvDKjVmMRjkbkdffkXT56RZDpsk
         oRIhUBXmxImeAzQsP5woRYhA6A3Q+Llb9331qSp44eYRa2F3FLnpzwcRqT1/cIQSp1h4
         QU9vhjN9ANOZUy7EYMTTSU0W2lF8AERZ8oUnlPOAfv120VPc3mBnmwOebemjUsYpQqBl
         Oo3K9IxzUCgapC/62qf7J5ztFoOznRKpzUfvroLctAerWpE3uUVfA+VNEQ8V8LDsr1ny
         vjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=XyGahnowQGCugdhIYAolZHV0Y8fYfsB6zeG38EzMKGM=;
        fh=F5QWbomZUfwt/Bt+yGS9TRH3j0cOoC8ng7pR8+f3fUo=;
        b=o+w9xgCkAaj3ZEyiPCnARoLs9AU1N1ChbFeNx3lyunZIYCfdPvS1qaZMPYCcCnqGjn
         Ifv7CXlawbawsMwFfQmR76W7kuUDegmRDQrTuK2N0z9wn2K6f5v0FhG4ocvFTzWNBGGo
         CIXMJwU04qtmP+SYMpgM8Oc/ui1p/C0TqZqZhMC3mqB76yPEZ7DJDKBDb/P0upIq0Zhq
         X32ZE8/9wxgwGJTt251SN7x84RYtTejViu+kU19w9BMrFBEQiMi+RLT5rcvNN590rl4+
         mhAGA2Dc4MrfKNfJoGXTG3loKbXE57IXsjX+yACtH/gxhJENslz0vJpbLHUB/IB+TvCY
         AiEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563855; x=1788168655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyGahnowQGCugdhIYAolZHV0Y8fYfsB6zeG38EzMKGM=;
        b=VMe1AoD+K/ygJwVFFo2kANX24SbnPlIygEmBP401KMTPiCvypaDtVOY2t6zHnjyAOk
         2D8atCEO8oyVjpgk2ET2c9nfvQdIkWoEAJuggzrP3Ipi3hhrBUMc6E97ZZfyFWUtMPWr
         Qoo/QGySO070JZ1b9OdwGUtshECGeeX/cd9fc/HF3AQaU0U/z6xzSVplWdf2UmLMMx92
         lR0zjj1oOy7swqiqwUJ6nFt939+tUt3OQz1n2HjQru1GVqQeIhGmIxF532DyFwpR79Ow
         t71V20tGLJfAzum56/W9Heec/nGGW20srYuba0d06QXFxTuRPUZPkGBNC8Y5xeJHyOIG
         5zew==
X-Forwarded-Encrypted: i=1; AHgh+RoROSXW0dCM1xEy8/wAmgLQ/Qb2oNzeX8EV6PyOqO8ShBI2WFULPiw+EJEu4g4ROSoIGP8V2wYduvVsMnX1@vger.kernel.org
X-Gm-Message-State: AFuF++mYT0pWMP5ZEVTkbi0ZEQlOqvO9NZM1UhzlMnx/R3QvOSvbE7LK
	dprvoY9mJh2Edp6izRUAeFP0SIsyOz6nq1MnGpZZYNvGHoVlFI1AvRKS3sTa8DkymfA0RMgX5tA
	B0MoUHKCMti7pkgr4kJuTnoM+VMfT2t4ds3lzROMzZQO3oVM0o6iG7T74R4MzT2qRpocYPMrrYA
	3U3MhBSrJAmZSgixPc6WlU5u6sSD/5HpwjaD2bvbXA
X-Gm-Gg: AR+sD13As+ogJFmajR7F1A+gV767bVArKiwpmeX+l+8SHlaR1iv5hu+jtvUr0+fGgGR
	FfiA19VJAY0bVch2O6pjdNY9D4UxsaLxep4pTqRscRnY0tfq4KZkoyd1eLdtW4jHSA4B+hgxa8v
	dHRnyFcsl2Zwo9aRuuOny0Wc1/1GwyyoL0mb8eZokpirr7cgqW8NZgUqS275VJY5WFccRqS2Su
X-Received: by 2002:a05:6402:3224:b0:6a0:a492:1f46 with SMTP id 4fb4d7f45d1cf-6a582b2851dmr22005697a12.8.1787563855561;
        Mon, 24 Aug 2026 02:30:55 -0700 (PDT)
X-Received: by 2002:a05:6402:3224:b0:6a0:a492:1f46 with SMTP id
 4fb4d7f45d1cf-6a582b2851dmr22005657a12.8.1787563855140; Mon, 24 Aug 2026
 02:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818163221.589352-3-alex@ghiti.fr> <20260821083500.856970-1-kunwu.chan@linux.dev>
 <CAEmasaUzCU7r7DzJfMFbQGZCJvA_wOJifPywQmy8mOz0efWn8g@mail.gmail.com>
In-Reply-To: <CAEmasaUzCU7r7DzJfMFbQGZCJvA_wOJifPywQmy8mOz0efWn8g@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Mon, 24 Aug 2026 11:30:43 +0200
X-Gm-Features: AcwNN1WLw_SK3mjZC7TcCkXWM6DR-za3ljlbeP98cJL-kpMZlruczFTOc4z7ZSk
Message-ID: <CAEmasaX8QPPNFjrTWn4jn+hoC_q9BrRhia9Zz5FYHyzbMjN2SA@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfX6MNhoPqAr6Kt
 /6yt0qfHMKlk8sawj7ek1PTqko2FGdqzD6XcfuQF/0KluxjV8zkYB15jzzIk0y5rDKOIHZY+2ga
 IJ9lTMoV4wzsWq65g0cEN+PZiHyMNR/QeuISYYw+irVdqpqwQWnutYg5BgsFTgOFAQdqLKDJq6P
 0zhKiW8+4qELdPwrLHG8hVRc0kOQh2bMVUWBW1xx390Ca1p0jP98BhbbCSn2GaGwjU6GaiUp5D+
 avWyLCu7E10QAir9alRrn+VukURymeSOSdBppprhP7VZOOvWnmqz5D42j/1QtiQubnMnewgLRBU
 dzeOvsJS4Y+XBwjVbZHmwRhYUDNGvSnQ2/qtCR8N+bB6tgYKieF6j9ylOov6tBMd0VMYZd4/XgW
 HmqO89OXtFgJ3jU5iUFGpIv7yXg7BpfEabmiCA96424IHbyyfElE3GTrKiPuDl9HC5o5Biqbhhw
 5MHyzqtjdK4gfT49/ag==
X-Proofpoint-GUID: cF8VgJRq_IlNtbTle_E0l_YpAFlRS6IS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfX9uXhgU31qmC9
 q6EXGjoOijIy4N9Walu7cXZKUfJOTPXT8gXSgi4zb/A3hmCCSWuAGmH6xot4NvMGX+O7CNlXcbX
 FZzPF9sVnUwTvsWf2zDzlMOvkmMoc5g=
X-Authority-Analysis: v=2.4 cv=cKjQdFeN c=1 sm=1 tr=0 ts=6a8c0f50 cx=c_pps
 a=CYpx6mtW7qE8U/l5VCnCPQ==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8 a=N_ursDZ4C-M7ivIJBeMA:9 a=QEXdDO2ut3YA:10
 a=22KAYETGZJnyhCxlFjxL:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: cF8VgJRq_IlNtbTle_E0l_YpAFlRS6IS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01

On Fri, Aug 21, 2026 at 11:53=E2=80=AFAM Alexandre Ghiti <alexghiti@meta.co=
m> wrote:
>
> Hi Kunwu,
>
> On Fri, Aug 21, 2026 at 10:35=E2=80=AFAM Kunwu Chan <kunwu.chan@gmail.com=
> wrote:
> >
> > > >
> >
> > Hi Alexandre,
> >
> > I have a question about the reference ownership/lifetime model in the
> > synchronous-IO case.
> >
> > Consider the synchronous writeback path in Patch 3:
> >
> >   zswap_writeback_entry()
> >     folio =3D __swap_cache_alloc_folio(...);
> >     ...
> >     __swap_writepage(folio, NULL);
> >     folio_put(folio);
> >
> > During writeback completion, Patch 2 does:
> >
> >   folio_end_writeback(folio)
> >     folio_get(folio);
> >     ...
> >     swap_writeback_dropbehind_folio(folio);
> >       llist_add()
> >       queue_work()
> >
> > With synchronous I/O, is it possible for the dropbehind worker to run
> > before zswap_writeback_entry() drops its reference after
> > __swap_writepage() returns?
>
> Yes, totally! The window is short though and in that rare case, we
> would fall back to the initial behaviour (almost, since we put the
> folio back onto lru but not rotate it). And for async devices, I don't
> think it can happen at all.
>
> >
> > If so, the worker will attempt:
> >
> >   swap_dropbehind_drop_folio(folio)
> >     ...
> >     remove_mapping(swap_address_space(folio->swap), folio, true, memcg)
> >
> > while the caller's reference is still held.  Looking at
> > __remove_mapping() in mm/vmscan.c, it expects a refcount of
> > 1 + folio_nr_pages(folio), but the extra reference still held by
> > zswap_writeback_entry() would make the actual refcount one higher.
> > It therefore looks like folio_ref_freeze() will fail in this case.
> > Is that the intended behavior here?
> >
> > If the removal can fail, the fallback is:
> >
> >     folio_clear_dropbehind(folio);
> >     folio_add_lru(folio);
> >
> > This appears semantically safe, but it means that the dropbehind
> > optimization is lost for that writeback: the cold folio goes back onto
> > the LRU and has to be found by reclaim later.
> >
> > This seems particularly worth checking because v3 intentionally removes
> > the synchronous-I/O special case from v2.  The cover letter describes
> > that special case as an optimization that was not worth the extra code,
> > which I agree is a reasonable direction if the generic path is
> > sufficiently effective.
> >
> > Could you measure the corresponding fallback rate on a synchronous
> > backend (e.g. zram)?  The 99.996% success rate in the cover letter is f=
or
> > asynchronous NVMe, so it does not tell us how often this particular race
> > occurs with synchronous completion.
> >
> > More generally, I'd like the reference ownership across
> > __swap_writepage(), folio_end_writeback(), and the deferred worker to be
> > made explicit.  If the caller's reference can overlap with the worker's
> > reference, I'd also like to understand whether that is an intentional
> > and acceptable trade-off, or whether the overlap can be avoided without
> > reintroducing the synchronous-I/O special case that v3 is trying to
> > remove.
>
> I need to look into the patchset that Matthew and Barry pointed to and
> check if it's still relevant with this patchset on top of it. If so,
> I'll add a debug counter to confirm we don't fall back too much for
> sync devices :)
>

As you noted, in my implementation, a race was possible between the
worker and the folio_put() in zswap_writeback_entry(). Now with Tal's
patchset which *only* defers atomic context to a workqueue, the
dropbehind folios on synchronous devices get freed inline which is not
possible because of the reference held by the zswap writeback path.

But it's cleanly fixable by dropping the zswap reference before
__swap_writepage(): the folio is locked (when it is allocated) until
writeback starts, then PG_writeback prevents the folio removal from
the swapcache and right before clearing PG_writeback in
folio_end_writeback_no_dropbehind(), folio_end_writeback() takes a
reference! So remove_mapping() is happy with the refcount :)

So there are no more races as you pointed out, since we drop the
reference before the writeback. I'll post the v4 today.

Thanks again for your comment.

Alex



> Thanks for your comment!
>
> Alex
>
> >
> > Thanks,
> > KunWu
> >
