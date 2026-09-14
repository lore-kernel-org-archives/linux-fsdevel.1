Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7645199D
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407508; cv=pass; b=eGopnXEqi5d7jwdNj1gSxSs7yFrPg89mwYv+PT4HaYdSBAhGLBqLWXNeEdrs51t+NWuWcyMKIhtm4R7Tuc4W7qfbtqndvMMyx1wO+ucOwUH0GGqBB/ERtJ0ShVF8H6vJksEDzTSTwI0UetoDDW6UdKd3JGkXYivUpEoi9GWEONE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407508; c=relaxed/simple;
	bh=sEeztLbuGFyF1dhhheCGiQ+SCiNVAWKx2wrJ88/WhXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkwQ4DQjHMrjTcm4e8PYZTNk2xJmvky242CU8cbUcHfkIBsCHMwDfUSToNZ9yEf9lNFQUYBTaezK3USrIeoHhmSqYJb5IavKVTnv7woU1GMnBkr4Q+Vr3MjMkxgwnDAt0TLSpauTVd6vsPEPX4qIQnhnCNjWRooEpriwZv9fPIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDygBD2R; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDygBD2R"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1365976f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 10:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789407504; cv=none;
        d=google.com; s=arc-20260327;
        b=XY3TQ3c6e94owcPwK3uH+mpRu5Lowa3kkeOMNslyYayNl2TEgJAgSuhxD8RoFizoUu
         ZNGiNutEgv1uBDPTGzuM6NMDwXgDbtBBHuW7I4t000q1FYUv7vT7Sn0tYHrLJpLh1J8P
         n0nVshm0VVvb9a0tzDYCc34etGiTwbYfwSWTkjrzMkDz+2kv5QDWyMwAGvgji40GLF6H
         tZdbyAQdzyFUtCTxLlpsys6IkZtJSR2GJgDuYewSa+tNfy1g+oskgq/BzAYxdavB6ZJw
         NczvauTyl2KkZoowQRGAL7i6uFVnqxi1ratCBjrhX/U2uBaPSCLxHgMqm9cJ7UVQWFQW
         rM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sEeztLbuGFyF1dhhheCGiQ+SCiNVAWKx2wrJ88/WhXE=;
        fh=ToZapcPAr6jhUwlzlv9YSD47on9bFNc1eSUAOvI33OM=;
        b=WfM12tyoiEsGPTyfkbEcfh1p+BrJYAbKuA0cb9NM2CcqoCdm2X081tvmfB0hxbhgxf
         3SiZSaYWTIn/zzV3AM2POaTnQly4jioF06BuClrF3SnCmuvWGM2YinsghX0SNi9O9tK+
         EK2+sBOdrt1vnKKH4gCQcZ9TYP77vA4v45duZ33L7lcVOdakvbSZUAiRn5DZTLHid3Zd
         ZFHYUDThBYUZ6+bfKLKvxraGQrLdkra9un+dngo1/HXIJZsBz4LNBTFEe9cFgHoZYwzR
         V/AeomYijV7z4lhWFn4edRzzgICEndQ+hI/OU/iOpjL2jHuJulWEHpbJu2IAG4n9jtol
         Estw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789407504; x=1790012304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sEeztLbuGFyF1dhhheCGiQ+SCiNVAWKx2wrJ88/WhXE=;
        b=HDygBD2RnIGBEFUkBnGQNxgr7HoHVNy+43GUFsz9zqgnrv/HxutFFfexWt4vGltbF8
         /qdG45CBlAUyPxPGruZXXPPgC6pNETH+IPX5LdeOCMhDPFhmY/ToLARtdRZa8DkBWU1/
         HF5v7bmoI1IEF9hFZA7MTCzkLzOBpGNWCT8q9tzMUi49+os5UxbGzCuvpGy+xuzmFLmi
         bkC1dAi1iDYVK+0q8gElQ2iG4gTzb6f/QVm6ikrnkb97EUTZx9udZdtEvONjKOXbpyZ5
         W8pEuZV+XYCnm/SE9E0cOd4h5S6SlQLkbk+X/axQnGYkQOzdb8258RF3eHXHwfS9hSaK
         /z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789407504; x=1790012304;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sEeztLbuGFyF1dhhheCGiQ+SCiNVAWKx2wrJ88/WhXE=;
        b=lE17kD37QTksWThxSj+cvQq0117cOR+tLpVdUk0sfa4cBjmQg2pJwF/rr4jR0wTlZC
         G+BKFLyA04+IwdwL//Gbiu5k9kYM98HN5lORaUkpG2d2M+zcieUJFrP/4ejhoQEqS8JC
         sbCotGHtMhcTJMEo2Pe/DiNZKKorSPfvQRhC2izAwOcpDOZ436mgfCBMeToGinm4yF4Q
         gLu6yd4blbUglQfoQ5gzvBz4hpsubrYyLZI/OrvguUGX9yNfxxvi1rZ+9fVG1H5kx7kJ
         lgRQ3KQXQ/K/taoDOqjyi5TwPITgw4k4GwLI0mRFYcofHL3hruKYqrATjjh86TLEbT4q
         y+fA==
X-Forwarded-Encrypted: i=1; AKwUvByR2bmbA5pXj/cQsILGCDN1axv+Wgas1vW7Gajm9ofezCKz3ZJyLKlx5ibvJRgsNiix9t7SKaUTPzkRbSRK@vger.kernel.org
X-Gm-Message-State: AFuF++n7Itbw67G33zZNHUsjQTDOnqXrzA+mkp+0j/PZkTgPcYdOUPbw
	4KDWOAOmSVulucWF/uY36MuX9VQzFMBW7egmr7OKHpnXvNtwTspRe7N7xpt9lhZqAAwLtMwRLtR
	RSwh1Kwq2ZW9MWwvaiTwPFZh0DRp7eK4=
X-Gm-Gg: AYBFou3pvaS870zY0OdWrW4KK7DUVIqUyjycS9xzcn0OilyFDRWeXexgnwygcjLv4j8
	paPPzRzdk6zYvRS30S9qV/dCYvxHMEgvJWURoLcXE1x7aDF3RaLhknYcS7n7mlTIfnHR6LNM7h0
	wmu7koZ/w3bwb6dAfd+LNZULFgSIMft0KBvqEXndav0l6cb19gA+KYe8VBW2SSGQSYL8e3xcavD
	kupeeHXLWrewE596AppaFhCDI7pMqEth5MzkhPb8ZDFhL3QCzg2IwA+aydvIHrEKlZxD0RYqDcK
	tBWOGKx8+Etg0IBiRV/3fYHwrWboPMMb8ccWjGMChjTujf67pDHV6msxJDUCGmaxczoL5hY/yof
	6a+WlXpU8doM=
X-Received: by 2002:a05:6000:41c3:b0:484:3310:710c with SMTP id
 ffacd0b85a97d-48702b30ad7mr9667975f8f.24.1789407504318; Mon, 14 Sep 2026
 10:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911121341.178028-1-alex@ghiti.fr> <20260911121341.178028-4-alex@ghiti.fr>
In-Reply-To: <20260911121341.178028-4-alex@ghiti.fr>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 14 Sep 2026 10:38:11 -0700
X-Gm-Features: AcwNN1VP2kc_faYmAYrbA6jzrQN4BV6EV-vGstKi49hd1f6QiPh8-BHVVwhcRhE
Message-ID: <CAKEwX=OpSG=fsw_7UsyA753cUTPTAjN3E8iRcfCzdO=Pw-xjAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
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
	Yuanchu Xie <yuanchu@google.com>, Kunwu Chan <kunwu.chan@gmail.com>, 
	Tal Zussman <tz2294@columbia.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:17=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> zswap writeback decompresses an entry into a fresh swap cache folio and
> writes it back. The folio is cold by construction, yet it is left on the
> LRU for reclaim to find and free later, wasting a reclaim scan and keepin=
g
> cold memory resident longer than necessary.
>
> Allocate the folio off the LRU and mark it PG_dropbehind so the swap
> dropbehind path frees it from the swap cache once writeback completes.
>
> __swap_cache_alloc_folio() evaluates a refault on the new folio, and
> workingset_refault() sets PG_active when it looks recent. Until now
> folio_add_lru() consumed that flag and __page_cache_release() cleared it
> once the folio left the LRU. This folio never reaches the LRU, so nothing
> would clear PG_active and the folio would be freed with a
> PAGE_FLAGS_CHECK_AT_FREE flag set, tripping bad_page() under
> CONFIG_DEBUG_VM. Clear it after allocation.
>
> That is a workaround: the refault should not be evaluated on a writeback
> buffer at all. A fix for that is on the mailing list [1].
>
> Link: https://lore.kernel.org/linux-mm/20260911092012.92399-1-alex@ghiti.=
fr/ [1]
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

LGTM!

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
