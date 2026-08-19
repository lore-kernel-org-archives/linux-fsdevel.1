Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA54346E70
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145432; cv=fail; b=n+GFUHXD8MFywzpkDpP3afODruw/r6wNo03bkoY3wJ22o72el0gpVXOuaTUdXh/0iD+jPn873JpNaoiBvthI9pbBf5YXF1DdHKXRk3rgnUBGr5VtOUslspqlyZvCDNJxthmI3hl35iKVM6gPDRLs2CZK2G9uBe+hMTod9Y/gUnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145432; c=relaxed/simple;
	bh=Buvm2CZAY8fc6WQYOwkA57auLDgdAU6ZWwqvZfcVeps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czLNkR8YQvbsnNhJ6b47T/XQXeAagb+/DeBbTTvAwXeIRoR0GUHiiGl+Vcz2BiJYFTvaM42eX53G8tyCoMOmcgUQApBWbeKTvEgMB8feoSu9r4KZiZCymKSefmHudPaDpSlJB0iOgfPJBL6g02A5WACVLijZVRD14PBBa4y9jJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=R1kV/7hU; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="R1kV/7hU"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JCovtP2258793
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 06:17:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=RAhMls7II/EYIhhbxkSqLjlLaMUSTDEHyYBTx
	I3i+Uk=; b=R1kV/7hUUw1VvGvR3wZu4mbfQNZMBG8jYt73wBDW/b7fvoZA/sKtS
	33OlUc8gk6mEeTU/NyeUYB/KFNLCqReA4KRy2IUaAKG+X8e0fZZyqxhnQOL7bShc
	Yj1mHOysbRaOn3GzHfyb1vE7E6kgM6lgHk8ZB1j4N1AfkjyX3KIrk4zCnGxRtdE0
	e00q6pHzd/W1jckaBWc42xar9eLKois/5umijdZNmiEQB4rcKQ83kti7zHWSBzwE
	XDk5q6Ir2G12El1VP+YaQ6Qr91KUbMsU8+ia43BfcqWq9DvqWtHzTiBNYsBFcnCb
	RT/DPHn+sGfDF9rBWInWuna89L2HJD58w==
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g4yffmtd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 06:17:09 -0700 (PDT)
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a3ef31687dso958897a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 06:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787145428; cv=none;
        d=google.com; s=arc-20260327;
        b=HF7eHNbcBwjoGoM8tAFxiFKjz2Y9yzU0HY41GLJb8eHnQrKv1pxj03wkxTInI1ly6/
         dWXiEY6kyqdjb4k87zzl1+XkWcJi7h117v5f18y4Yrl1lTNCyqHdaFEBHqIPHnsSMEmk
         yZYn0teXuOO73cWo9rgF3ZqX5n6k/cytG+ERWtiGedta5p5VpybZ1wEwnTKivZc0ouev
         WW5J/h9PttWeh8LPfX9ElGzCUje9dzNtBDVugSJeflV6YPyLUtx4geut89Ww788rTnmR
         IxI5Wttcom9MVnlWegn4yMqasx6oI0hLQBLf1Vr3nrYHiiV1CDNECRL5suDvlYvLJ1kg
         afow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=amPDCjdDA7j5ak9IrHAc1f20HnHLVUkSfYRDZ1nWjas=;
        fh=+GY4AQwxflgcMgQOTQmF4+Ex90XFuRaYaXsVyvQgkUE=;
        b=LYi9wHdFnze4+nhARCrRJiUovTpNM3tqpI92Z8wdDWndza5AREkLx1N195pXywmtJP
         G2wYbV0g44ekX45L69c5h3rDHDH8DNfADU64zQsEn75hLYcDFxS9qcZ/N/eserTQ4QGv
         euFPfH5c5Q1Ja7wP0KDPfUPpDjZl/KA5vvBPHzz0hko5GLFKmthBBJsA2orwmfkWY21q
         h+5Ta+YaLdF4k/Cze4BmjXGTRiBt2XNIBR1viNWskAg0OeYPGimCgA5ExKJiK/B9GoTo
         l7kF5zjLIT1vzvB0oTZVJorjHK41q5+Uqxt9f7yWT+SX/THhNgKIn4RRE28nJDl96MX7
         xWfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145428; x=1787750228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=amPDCjdDA7j5ak9IrHAc1f20HnHLVUkSfYRDZ1nWjas=;
        b=iPco4zgftkF2bZkp+zuznywoz4boFnm1k8/9CROXgT3qj8iZYN6LPaGzy2+eO1bE6k
         Flm56np9mP94b8OVZC2M39lehoxjhlej6JUGnbzHWxzosGtdWcqt3VNkViINLww48Wzk
         Vz174uwzXPtPGhdOmCzuNXEhOuprI02EwYXGN83xfBulEyoVcRP0vlNWyMk3GtXAQuAe
         U4+aBUUZ0VBRnaivqtXlKLRqS0VBZL55OtFTCsp5MMMWNdO+iwbH4s3TzdREaoTpM8ek
         FkHXKb04CG0YDeKTJ3PFS8tRRv2KCnrh8SveWgJeEO3VK2iEuQB5L4lBg7QH+zG2xL6z
         T9TQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWtT0+Pga+5nNA7FPqmGm4m4VhFnFnOZF/dXMZTboWMw7IXwhglOQBPiijVhMFZR8o2x95Ks5Kf0bBWd5m@vger.kernel.org
X-Gm-Message-State: AOJu0YwpJuxcT83Zll02d+7sL2AFBtMiKSYo26d+Uf4I/fqEJ71ASDF9
	vxSdPR1YzMbhcsMwPuJArRunhMwyHG4uIu3oFrn0/xVqn5kgk+lEvjITfF8oaml3BgIiTIprYjs
	VlrlWq2xF6pRMqpBp1HurK4LOi24YHGUjZ6jbpn/61LmM4WiKe7vL78IHE6Ej2usA4/b441+bAr
	Ng4DiGbGPJzGpbjsD54EI5jnp1hwuCPXf+yXPRBeRP
X-Gm-Gg: AR+sD12g3maswPGVgp6JGrgmpl95KYfkxhTvQhJlSi9iARfnBiUnTT8HE6IsUfth87g
	pYadqb9kb7ccah0bI+dRN3zgd0KR8v+CIUfxWdEZ4wje++DIwK8IMI7ofDDk4BIuOnE233AXmKs
	lh3pt+wwlAjfZbvbMMDyPHhN3cQKlf63ewm2xKJLeY4Kc3x9kiPwX7mAQG0pmD/T611KsAYDvL8
	Q0WCSbxKw8T/kksjQ==
X-Received: by 2002:a05:6402:518c:b0:6a1:f092:3c1e with SMTP id 4fb4d7f45d1cf-6a4032fd452mr2041136a12.13.1787145427650;
        Wed, 19 Aug 2026 06:17:07 -0700 (PDT)
X-Received: by 2002:a05:6402:518c:b0:6a1:f092:3c1e with SMTP id
 4fb4d7f45d1cf-6a4032fd452mr2041066a12.13.1787145427040; Wed, 19 Aug 2026
 06:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818163221.589352-1-alex@ghiti.fr> <20260818163221.589352-4-alex@ghiti.fr>
In-Reply-To: <20260818163221.589352-4-alex@ghiti.fr>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Wed, 19 Aug 2026 15:16:55 +0200
X-Gm-Features: AcwNN1Xk5iqn17t42iniquZ7VKy0qOfjGpedBjI9eFDNjdHV7zpBK7rsdMnTXqk
Message-ID: <CAEmasaVJ_LHaa=yh+38OjeaaNn_OppsRdUXf+UzVDzu0=_bn7w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMyBTYWx0ZWRfXwmDPdxK0TrfM
 XvDSwmWy9Ky7ToVwVHNyAVLKJLIdG9xBg7/pX07+CsK6pY2+xW6gkQ9QBjL9UgRh0NUkl+nwEqF
 wWuuWiiwcBQH9mNYxTIoPeBkrCHeDa4=
X-Proofpoint-GUID: 1uyZAA2z2klplTYdzP1SaBBrwaCHBhSs
X-Authority-Analysis: v=2.4 cv=LtOiDHdc c=1 sm=1 tr=0 ts=6a85acd5 cx=c_pps
 a=DTy5UCxgudPLKrSn28m7Kw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=ufHFDILaAAAA:8 a=pGLkceISAAAA:8 a=LLsFW6RCn8ZTAUol39cA:9 a=QEXdDO2ut3YA:10
 a=VzYV69SsQLkmnS9OQLw-:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMyBTYWx0ZWRfX6CJA7d4kwFpt
 F4KRIHoMlpDRTNG1TCQT5d/eW4SabysbUo7lkDHf2laqTHMO9sqxy799YcAxBcr7U8qABiKEHkr
 mxVmSn/3aYVcDz8+z0BOjXN+LGNCtSrfJ8wux21vcs8RGAGAemFobRrsLbWNX/u1AR/e+l7dKoR
 u8F2NyZgzoaea+bw7MEvF2b15WNHJIPcfqnUDNzIhZp3m6Wdh4BMW29fBAYy6S0p/YTYYHHPj2J
 ozlUHR87Aw7j4S1BTWyuP0atO2SqDmVFXvtlx8S+6vU3BJK+49BtczZNjTX+ZNUeuTZlDxjH98h
 ZlcWB+aw+/Z50yYDtwZw1Z1z1F0TGRMKuAc4QrnZWeqIGvrtBq68ruVYOi/x6kA/iScTSmHXmeK
 t1wsHbJz55n5hQZsO8qEKrY+1quvJAzCKDNXiGNV6bd5slD66hTLSOoWTPTGGg+ZYRAhCldkaI+
 r3z6s6mononPry/49iA==
X-Proofpoint-ORIG-GUID: 1uyZAA2z2klplTYdzP1SaBBrwaCHBhSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01

I am pasting and answering Sashiko's review inline below.

On Tue, Aug 18, 2026 at 6:35=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> >
> zswap writeback decompresses an entry into a fresh swap cache folio and
> writes it back. The folio is cold by construction, yet it is left on the
> LRU for reclaim to find and free later, wasting a reclaim scan and keeping
> cold memory resident longer than necessary.
>
> Allocate the folio off the LRU and mark it PG_dropbehind so the swap
> dropbehind path frees it from the swap cache once writeback completes.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  mm/zswap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 8163e6c5f76c..a35671e837f8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1013,7 +1013,6 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>          */
>         if (IS_ERR(folio))
>                 return PTR_ERR(folio);
> -       folio_add_lru(folio);
>
>         /*
>          * folio is locked, and the swapcache is now secured against
> @@ -1046,8 +1045,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         /* folio is up to date */
>         folio_mark_uptodate(folio);
>
> -       /* move it to the tail of the inactive list after end_writeback */
> -       folio_set_reclaim(folio);
> +       folio_set_dropbehind(folio);

Sashiko: "When setting dropbehind here, what happens if a concurrent swapoff
(try_to_unuse) removes the folio from the swap cache before the dropbehind
worker runs?
Looking at swap_dropbehind_drop_folio() in mm/swap_state.c:
if (folio_test_swapcache(folio) && !folio_test_writeback(folio) &&
remove_mapping(swap_address_space(folio->swap), folio, true, memcg)) {
dropped =3D true;
} else {
/* Raced: the folio is now owned by the swapin; put it back. */
folio_clear_dropbehind(folio);
folio_add_lru(folio);
}
If try_to_unuse() removes the folio from the swap cache, folio_test_swapcac=
he()
will be false. The dropbehind worker will then blindly add the unmapped
anonymous folio to the LRU.
When reclaimed later, shrink_folio_list() will see it has PG_swapbacked but
no swap cache, causing it to allocate a new swap entry, mark it dirty, and
needlessly write the data back out to disk.
Could this race cause ghost anonymous folios to be added to the LRU?"

If swapoff frees the swap slot while the folio is queued for the dropbehind
drop, then yes, the worker takes the fallback and puts the folio back on the
LRU and that is exactly what has to happen: swapoff has just invalidated the
on-disk copy, so the folio now holds the only copy of the data. Leaving it =
off
the LRU would make it unreclaimable. Note the folio is marked dirty by
folio_free_swap() itself, for the same reason.

This is also not new: in the current code zswap's writeback folio is alread=
y on
the LRU when try_to_unuse() calls folio_free_swap() on it, so the resulting
state (unmapped, dirty, anon, on the LRU, no swap entry) is the same with a=
nd
without this series. Only the caller of folio_add_lru() differs.

>
>         /* start writeback */
>         __swap_writepage(folio, NULL);

Sashiko: "Does holding a reference to the folio until after
__swap_writepage() returns
prevent the dropbehind optimization from working on fast or synchronous swap
devices?
Because zswap_writeback_entry() holds a reference to the folio that isn't
released until it calls folio_put() at the end of the function, a race
can occur with synchronous I/O.
For synchronous devices (like zram), folio_end_writeback() is called and the
dropbehind worker is queued before __swap_writepage() even returns.
If the dropbehind worker calls remove_mapping() before zswap_writeback_entr=
y()
calls folio_put(), remove_mapping() will see an unexpectedly high refcount
and fail.
The worker will then falsely assume a racing swapin and add the cold folio =
to
the LRU, defeating the purpose of the patch."

Yes, that race is real but I estimated it would be rare enough since
the folio_put() call is right after __swap_writepage(), and the time
the worker wakes up, the window is very small to me. I haven't
measured the actual rate, but I can measure it if needed. And if the
race is rare with sync devices, it is even more unlikely with async
devices.

In the end, I don't think any modifications are needed based on
Sashiko's review, let me know what you think.

Thanks,

Alex

> --
> 2.53.0-Meta
>
>
