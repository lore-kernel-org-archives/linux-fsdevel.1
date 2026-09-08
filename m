Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7452B1F2
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892029; cv=pass; b=qk5OYG2KYUd2bpKXdkUZuAxais+NAaVjV+s5XUyKOfmjFyi8lLNrGOemcSbz2NQh0fiq3FlYfAjb0HSnWaXezAPgq53Yg7FB1lDjX0VkkVcO2kJoU9mFkaSbKWs4sBgu6U7K1XcnohCXpHKjdBm2TEMMXul6sN8ACXArAKlHjvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892029; c=relaxed/simple;
	bh=/edzti1+6WAlEVmYxG0FqqQ4ZuFKkllgKBweZCBdkNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBTwNS2q4iyjFwY3p0h/utEjM8MQxTITwpiUVwmbL9AEIegiaVXDrAB/roZ2eXZ5P5ioHfx1IkjMRMytzubFUErDZUhIrionw9GpCPYs5AIKkZw2PrGUs0kTNZQg6jgfQ7gFvCTvslJ+imPxIGw5rJRYYfqRoCNuKcg/zhBpUEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWS5vjOc; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWS5vjOc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so39163435e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 11:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788892026; cv=none;
        d=google.com; s=arc-20260327;
        b=QzBDr+GoT5i9JVCwUAXMJRxixHK0Hs4pZZXX7zJc31ouBu7ePUXkkLBFj9HDVYLKUl
         ljEuBwdn9e4+nndN6+A2vaxmb00mhF/4gNJI9XC9aXm39OXuYC9PB2Up8IRlCkv5kLrD
         tyxSrIFUGQ9LnCSalv1cCb9xtpSH4C4CJTKU7+8OA6EMU+wiJ0LgBjz2ELVaSQQ+tWWQ
         YN0P1yZwvla1tL9etOUWrvwdlninAwn5QqwTjMj4AeubOJZmuIwrkpQO/qzp+mpXufGf
         LN/CKaICiawq9Qg6KsPtNorGvtYL2hcZ90fHb57URfYCggtKQ59DpbIRTjPzAFeNyF82
         0gjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/edzti1+6WAlEVmYxG0FqqQ4ZuFKkllgKBweZCBdkNc=;
        fh=Zd4+d1ACR0/PFqOwsnEBK11xhL/Sk7phH9QzNfbCYMU=;
        b=XYQn402hDdtnsRV8spYrMUU2PNMbhwtE/YbPD4rlHbRLk68kcDSqls2z6Vbxt1wwuu
         67EBqYdlWZv0y+FNioDpzbJT4Ro4ipZDL0P/Sog9zkcRYJLaju+/MidmtWJaC98mRhXS
         J4EZDF0quzcuiFONNSTsbYKxFO9iYPlADbioz1tPGmA4wTXVU9RQt66O4I5DGIpNbRR5
         VZR4QtRzl0W78K7rd8KAhf5WezynmjcxbclOmzG4kueGM0gng5YrTYhieWJz1S0CD9s0
         icUCt4UO8t4Er0EnJJ2GGNpNEeotfOWNw5IVJVUVQQ4wTT4a7qt5QbEQY+JByUqkk7PL
         5Y0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788892026; x=1789496826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/edzti1+6WAlEVmYxG0FqqQ4ZuFKkllgKBweZCBdkNc=;
        b=QWS5vjOc0kk30Doc9anLU6JtrjNMJPr10mvMvvIq84rDka4F3qUdvxANTQBVi6ewFP
         FMnC0Mg7ZzijBvsdwcc1MoUalM8ll24oK90jK+lp96RedFshv0nB/NNFHGz4JFNn764X
         /u1pPjC02fw40scBuRurQRs2xhwOlUD8gjGzARmUijrtR4QbIGF4usXWYT/Y6KuK1B2q
         gS8+fSGXTM9XIcPKdPg/Hv7BZQqxFR+SIx/6IFXTPxvtTCjjo8YBMh/lUtWysS20UHe2
         HOmwUfnA92kbEMEeBBAM/hdDCR0zUWjwHrPqNJRGHZoNvppWmQzA+NjmyTYCwTE8ZDMi
         8XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788892026; x=1789496826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/edzti1+6WAlEVmYxG0FqqQ4ZuFKkllgKBweZCBdkNc=;
        b=EJWffEJ6kkK+NWvjIOFZhHQOYYSAq+toi7eZXgwMHCJirLnLl65CIVWdOm73Uz8bA6
         ciYKZ6W7MEO/8sUcX0jiSGDvUDr9dflG9fdzIDCUPpINY+73IAodBJot2WsMuEUrJhmj
         gOFBmkNYLPfbiML5DJXNbAGb6orX0tU/uaoCalkM4XooJ4PBoztvcVJgZ2tfiwygqwmz
         RRwu1/IaRKgQcrQz7SZLHqrdez/wHVyf3Ytggb4OLHAwwEaTtAbu7B7dcbqD7t1SyBhR
         I+DiuoepLiHR6ib+5jrepFcdEB2ApxUbMLba7rL/rJWWeJLmyEEznV8zelarzgm+kKli
         UI6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwkNxSTXY1GV1gH/WhXxOfCYYNfNIOulIXEQ7QMsOrZvaXWijr4Xt8X/jILF1+NNtObAEmM7ChLYsn26pZw@vger.kernel.org
X-Gm-Message-State: AFuF++lrSCJBDY9uUdFNsv9lPP56VJUQviMgHVQv9THiRUktSSe/bjOD
	Y2jr/1kPQU+DahVTkCGQXowTR1bQE63rqaVQcpzGjXrqDueq5boDOA9D2rW3ydBNVGeEV0TqutK
	m+GvWTRZhcs2uY9PCL8BhTPJ55UYj6vA=
X-Gm-Gg: AYBFou21SR6rqZ0Y+tsWRRrO6snYV01pd0WWTpxODiSeoIkfsf2XJpREe8cEbGdwTCX
	2leQpV0EEOPbfGMOuOjvxxZWQVxLvg4/P7hIjBL5lRx67UObVy7Ol5+aoeenjFIxHlHspEgSFC5
	VmwVwkftEs0H/lEDY8xV1hBJsQPke8dy8wFtPt6AcL6hdV4KFQfHAF1u7Yi3hB5tTA26oR8WRB8
	SPFFTVC5on35QuVAGFMHVAtZfVhmMqsi67WlCCqRxjt8pxDxTd/Ea5h3eT9nylo05nW6FcquDHP
	k8LumKh5SIRMjf/ubhyLELr6lzfyte/SjICHbFek5fKOX3CAnJ1IvaYs+HWwWAEIPp65zO+f15C
	M7pbiXC2HMF0=
X-Received: by 2002:a05:600c:1f8b:b0:49d:797:83bf with SMTP id
 5b1f17b1804b1-49d07978531mr204052715e9.21.1788892025845; Tue, 08 Sep 2026
 11:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825135209.3135169-1-alex@ghiti.fr> <20260825135209.3135169-2-alex@ghiti.fr>
In-Reply-To: <20260825135209.3135169-2-alex@ghiti.fr>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Sep 2026 11:26:54 -0700
X-Gm-Features: AcwNN1XWAUvG-23xtpJbnb_GPrsgTTZbDcBPWqZeCmut1kbtZYtODFU3-vLodh8
Message-ID: <CAKEwX=M0o3SRiX1bQmqQq3RMAUL7pAskjRgtmFXw5kWyu8Uerw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm: swap: move LRU insertion out of the swap cache allocator
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

On Tue, Aug 25, 2026 at 6:53=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> zswap writeback wants a swap cache folio it can free directly once
> writeback completes, i.e. one that is not on the LRU (folio_add_lru()
> stages the folio in a per-CPU batch that holds a reference until it is
> drained, which keeps remove_mapping() from freeing the folio on
> synchronous devices, and likely on asynchronous ones too).
>
> So defer the LRU addition to the callers of __swap_cache_alloc_folio(),
> no functional change intended.
>
> Suggested-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

LGTM.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
