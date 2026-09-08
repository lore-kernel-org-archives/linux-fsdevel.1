Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04C530E01
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892794; cv=pass; b=b9JjPnoLdVTx4poy+jwperB0QAsThpK2veV9qvPHrJyx0YQPPul9CWT5sDV+sEiYdPqTUEtFycpkMQKy+fVGSZ0k9WkZqjHjeX+1ZBGL/o41Fi59zKnuppQByBOAvjdCIExEunLIqGB7YyUXtHaQV1gGgCF+BvfSSUiiKKVldUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892794; c=relaxed/simple;
	bh=oDK1zDg/oSey2EOVLolfzuplOiYAA9At+21vSxpayKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcLQG5BG3z2SZNS/VlA12efp7EC5Tne2/uIbY8PDGPJi2Jq5ZIV6k2g3H3F/mqNS+hScK0tqHyAXzwoVBUtk5KC6Y41Vt8veGBE4w1G2+hP92iNff8Vuw4BViZYomWSFy442hex56bhbZXIIpgPBAx5OeSwQD/IqnP6ReSQcWtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Csj5J8Wx; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Csj5J8Wx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so47131185e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 11:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788892791; cv=none;
        d=google.com; s=arc-20260327;
        b=Lv9t308yf0z45er1j8TEqcj3FH2M6amcuEQAU2EkoZ/D/vCib6G8EpBWa43DBSqUbP
         om1TjNPqLUdN+QpTipn2ixhXpHpsTxtsKozx8YVQrysoSHRyMaTyGdunhQUq6lG73Ecz
         uAQ1KUfxFAG+6HyQ36RFngEJa/d4gMEK9pgkAOqRdR2feY/KfC2L8bW08U3s/o3mRv3C
         cEI9e1N15eTatYMertIut+A3CcojYyQqcYhMmE7M8cDkv+pDXle50Q0Ds7FqSQ9C0/KE
         yYx3xnCGwWhBn5ErQ9PoD4P58Y1IGM6egQZc7nlONcgXihL19gZ4qb4gFY9Ogmykv0P+
         m7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TRHHPtqnAHNoNBtGQy93BNsOG6GDWejrubjBMOtK5uk=;
        fh=9ZPDcrn3qFdZ6NKQR41k3tYct6wWDm5Sm+M+SqnNfOk=;
        b=hmmlO+UPe5j9FKvJwUinaETVcsgghnn8ZXxRX51zcF5IJGvGAN17CDW8wEGktr9C1e
         JCVNSXus0xUME3q29Q5jK+YFBJ754rjDxvInM/4QHGbuEZO8/8XkGXCmFjiRYYC++Hmq
         pBpc4SQjL2HSFQoUE7N7GEW5T/hDOEz5sAc/wqXKgAQF6icKPNDlqpB/irO1bis8Uzdt
         Q1xZb7k5tVvRZwBo+xphhzMCT2v15uixwkZodvXb/b9/SJ8VKdy82qlHCAEONKbpcPqe
         cC6DDHm2We8mP+HXtdS5XuHNQn4NmeE87aEn41yZ/gamz6/clq6WuUXinn23mX7HWrJW
         Z0aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788892791; x=1789497591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TRHHPtqnAHNoNBtGQy93BNsOG6GDWejrubjBMOtK5uk=;
        b=Csj5J8WxkMm8R2EqCFomh0kAcCdz+sUYZPIFzdUKf0fykkQVUjgBPs2M2Syg7zCJYv
         s+Tkp7iaiUreUtraHsYnEBupFh3MECX/3g3IthYWrAQfPcMpH+QMf+IdfeKFGCwWvPMQ
         15VYir/ackzr08xgllwWQEmCumeNW5hmGy0lE9lKEWRB9ijtDirK32spxN0m628YjiPR
         EUm7R8QG0XFp8xoQABPrz5w5tkmcHSSU7m+v9Oo/YapoXC0s1MjncEZkDyEzhIF6IP2B
         4LRNCULlZHz6y5ifUHqb0FrOke7dRTF5y8CFfdgkVKqmc+fRkmz6kF+uLMenEexGQNU0
         htsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788892791; x=1789497591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TRHHPtqnAHNoNBtGQy93BNsOG6GDWejrubjBMOtK5uk=;
        b=WIbdKJMeeQRPvU7/RKBaCpNTSL2RMo/Ds+ZcyvSqE5j3yd5w2Xqd1xI/Qkj1rS0FaH
         hwnc1SY54azqyycSTYiLMISXKiuO799Okj0m1JPI9l9r5lXwEEms07pkwhLIDmuDx0EW
         4JsL+rom7/5OfT7CXVkmNgQnb5pPxodHnTTzcE0wwlNt0/1vAD4lxSVqSvC30tyTyRbS
         KGJQL6LkDLDTRp84k+KoMmsOQOuPAkY7Zr0ZV/XJTv0co/seCLHSOqZcQr+0/X5tHOkH
         tjVj+EftKGQ8pR4Jq0GndpkHYfWu9O9i24hU6QqFCcXft2pnfdxRto9m0T1sClBhO5I6
         N4+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxd4Mu+gi3x9MSnhO36XUMu6/Jxp/h9KF++zfIGCzv7qzJg1e+kL/Pp+fQyfXmdSjpqM/LqpTw/FQSkweUT@vger.kernel.org
X-Gm-Message-State: AFuF++kxcZNmNKIc+Uy1if0ochvm4TK1TjpzzorhIG91D1RbQzEl6mKr
	raX3TnZ5NOcL3VvWTPsibFa6aAFHsBgxeX/qYs9dQAaJ/Ne4/qR10VIM3cXkfJ+Xex9HqslQEUl
	dnfQ0TjOYz2dniA8VL4t88pZPtNMBWn4=
X-Gm-Gg: AYBFou1iP/sN1s15/PnVa55k8GJ0b+LYjNrY9AgdaW+FK0gvC4zVviWVadxhQKRF04Q
	ywYOH7nPL5wvPqeeU9Uh6poGuMCUbwU6oTarVfpEvXuLBq4dFAVXF+5RJlsSAX0aVnkAYmw5fel
	xQunNEZYE5o5rijRSWWuKU1SAPUiZLOhmdlK78mo4wNQFDkWlCrxkezB66tFLvrM0qAmm74aGxF
	79EjlmxiZSbhPSAawqju65WvA8FfMmFWbWpmExIUOF5CuMKu3pssta2E1DySEkqElhRNlNMXIR9
	P92cTf2njKHfsM0blpnd6sb32fFkT3bVM1gSADrrs0K4/lWk4BbgDPpZaerOrXzz+pchuiygr99
	m
X-Received: by 2002:a05:600c:4f89:b0:49c:e1df:79a4 with SMTP id
 5b1f17b1804b1-49cf822c827mr275918375e9.5.1788892790894; Tue, 08 Sep 2026
 11:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825135209.3135169-1-alex@ghiti.fr> <20260825135209.3135169-3-alex@ghiti.fr>
In-Reply-To: <20260825135209.3135169-3-alex@ghiti.fr>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Sep 2026 11:39:39 -0700
X-Gm-Features: AcwNN1UgwciD1I-qE2yD_ZK2P3jH-A8WPIpVEy3cs7LbzeEfivAviywv0_QerXY
Message-ID: <CAKEwX=NUFMjHHbeeRnUm0Ex9YQaesYTM-22WMGRJMXSKTkc6uw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: drop dropbehind swap cache folios on
 writeback completion
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Kunwu Chan <kunwu.chan@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:54=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> A PG_dropbehind folio is dropped from its cache once writeback completes
> rather than left for reclaim to find later; this is implemented for file
> folios in folio_end_dropbehind(). Extend it to swap cache folios.
>
> The drop takes the folio and swap cluster locks and may sleep, so it
> cannot run in interrupt context. Set BIO_COMPLETE_IN_TASK on the write,
> as the file dropbehind paths do, and drop the folio directly from
> folio_end_writeback().

This BIO_COMPLETE_IN_TASK thing is really nice! I'm glad we have a
proper infra now and no longer have to roll our own solutions :)

>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Mostly LGTM FWIW. Just one query below:

[...]

> +        * Gate remove_mapping_reclaim() on folio_test_swapcache(): a rac=
ing
> +        * swapin may have freed the swap slot (folio_free_swap()) and dr=
opped the
> +        * folio from the cache, and it must not run on a non-swapcache f=
olio (it
> +        * would trip __remove_mapping()'s mapping =3D=3D folio_mapping()=
 check).
> +        */
> +       if (!folio_test_swapcache(folio) || folio_test_writeback(folio) |=
|
> +           !remove_mapping_reclaim(swap_address_space(folio->swap), foli=
o, memcg)) {

remove_mapping_reclaim() and the likes seem a bit confusing to me, but
I don't have a good suggestions for the naming...

(also I'm hoping we're fixing the weird shadows behavior of zswap
writeback soon :))

Anyway:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
