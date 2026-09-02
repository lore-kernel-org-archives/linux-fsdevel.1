Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0A322B6D
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 04:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321918; cv=none; b=fcsW0KwJaYgirf4FYhz9Kkx038JWccRKNo0If9fI5Ufy90enTWN/lhl3gN9rEPIJrf8DlrRa4oE+y4PZpszUlrb+UPqNWgTuA0zKIE8oWZQL4NN+9lz4CE4lo2QAbz4aZDJw3nKSL70oLchD6NZeu7zi04j1ujtsN91+LDt9L0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321918; c=relaxed/simple;
	bh=GbeRlDFB/Ojrth/vw1XdAvxwKBOubQN4yOMhkl5AS1k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eBBGXHFug/6jXEajVXVvwTgaUy35EhuRBeFNqxFIzP3hCP8yh832yLSJwR0DwDjbiPGcbtI6mkRH5TP0KOd1ivjW4BI3tUNlVOI5CwR1Z4zjobr3yS0bgTaPeoG7ihMoS656MoqzBqLhz+2X0IIglLvDpyWhc/vng62j3Yzk91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FI1wlYKf; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FI1wlYKf"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8630c1503f2so7588637b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2026 21:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788321916; x=1788926716; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sggsj0swIY6SNlhR5Rlr4w6l9mVN7Mj25L4G93WgJu0=;
        b=FI1wlYKfN53Wio/ApNAn6RfhcbQCUb768joMa8jOJ+HJPQ8RjAdwiRahHvsdBOjYju
         zPai/FrDdx3Uv2DmDheUcM6HK6tw4AhxRfYCNQsLuKUsWh4XpfATHslFGihpSUnK12Xu
         jx8huc+ICZiM3+rhqETzjaMC4Nh3C+8rtRHsLmbaLVfPQZR0WGMWGZx8Se7VebJfFVa5
         89xdiNPdDG+g82ijxefNi6+Feer43rQU6knkf71KihgxgHrknnS3TsMkmRvMU9dtmBKn
         bUI6M5EX/lw5WsICBGpk7MWrXsuqxzKhi71D0XfugOTD6brie6V8iIrqS5zz/RnZgjT6
         WRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788321916; x=1788926716;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sggsj0swIY6SNlhR5Rlr4w6l9mVN7Mj25L4G93WgJu0=;
        b=X7kzOF/Uw1Jst87vEs407NIQAxDplMNGggE41co1kmEogKtyL2bL39FlVoXoaJAjSx
         omO5832MvgWVhUsFiNJOBy20ua0jawLqmeJ/K2bey16FFiGWzUIoVcjCDaMGhPW3l10d
         iz8+ZG/evvSRRenbot3LycH6r8KO9vuK95jw+X5wU0tDPfM1BqEAFeN1LucOHik2ekFf
         ylqRu0zqkzz2IyNnkNFqKw3YNDKhvokkX7xntKnVclt2QXEUOXAZXvoZ8t806D6sIOuj
         /nPbQrIhssmucKfLW5U9Z3qK63edpl7urHxvS1NT+4EbxvwyxRGim4Pyp8TpFLZ5jqPf
         2XGw==
X-Forwarded-Encrypted: i=1; AKwUvBw+ms1oiNqiHkfH21AeK3kVreWNlBH81rV9EsuRYpAQN6mmH/WLg+cjR0K8+XAqvBec52bRuFsw+u5thgpu@vger.kernel.org
X-Gm-Message-State: AFuF++lX8j10oQPSsRLIP19hmWvzh5TzDrR+A2LM1ulRZG3tBcw91Kr3
	7LKWPvBBq8kVF+BCLD3jeGQqG/vvQJAhQNGCzei5mWZWoEkzl06C6IT/fNY6aZvDEg==
X-Gm-Gg: AYBFou0sM/Se5eLJm9895G7WRpVLyt3D0zf8qq1C1kgT0I5tOn23WvPVhQlsdzsXIJR
	Oq/a8Io/1p7/CQkagg5XLyHTw2GeSgq30SiTRsf2UYyTJ741yEq9KvghPi2y4wUNtP6626j4wsf
	Fs6OBD0OQdqUnXc9vJiHhZbWTqUtJbTdls1fm0Fj5WrSsv/odEFMkL/CtBZA2BLG87QmSf+78+A
	Wkhz89iCLjomYe2+Z+eba7NWDJmfZn9sTqH5R7TkkCEvlcxxyHlTnc/Jo7VE6TOssh1VeN6jY2z
	VAEG2+ki3XAYeTof+ik+jYqPWQtHfhHwRfvArfTf/aPUTLU2Tftt0bu5kZtlWNJQGD9dVYJfuRI
	SZwV70XEzqyGu5+F1fF1zTO6xDJvUM7Cn9psJUkbVKLqkxj8hMrz9ktCy988sL9q5hquX+0VxVt
	KaDSgAO7DUovZSGpLOo3ZmHKOacQ1jAu9BNge7XjqPNtLsE7FELicraTKe8eBtvEyg3253oje8t
	wlzrMUpTujIZSvL1PxoglSv4ndH7bmXOlLcHffK0AOmzLdF
X-Received: by 2002:a05:690c:81:b0:80b:9f4e:a70 with SMTP id 00721157ae682-86c526f66dfmr8698707b3.26.1788321915018;
        Tue, 01 Sep 2026 21:05:15 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1975dd91sm8720547b3.49.2026.09.01.21.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:05:14 -0700 (PDT)
Date: Tue, 1 Sep 2026 21:05:09 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/25] mm/fbatch: lru bit set, no extra ref, while folio
 on per-cpu fbatch
In-Reply-To: <e0887417-85a7-453e-e733-561dc11db08f@google.com>
Message-ID: <04101fb5-a723-1fe0-37ee-5e62b5fbb9d7@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <e0887417-85a7-453e-e733-561dc11db08f@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Aug 2026, Hugh Dickins wrote:
...
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -343,6 +343,23 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
>  }
>  #endif /* CONFIG_LRU_GEN */
>  
> +enum {
> +	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
> +	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
> +	NR_LRU_NEXT_FLAGS
> +};
> +
> +static __always_inline
> +bool lru_add_del_folio(struct folio *folio)
> +{
> +	/* BUG_ON(folio_test_lru(folio)); */

That was a good statement of intent, but clearly I never booted
a system with that BUG_ON uncommented: it actually needs to say
	/* BUG_ON(folio_test_lru(folio) && folio_ref_count(folio)); */
because once the refcount is 0, __page_cache_release() chooses to
lruvec_del_folio() before non-atomically clearing lru flags.
To be fixed when respun.

> +	if (!(folio->lru_next & BIT(LRU_NEXT_BATCHED)))
> +		return false;
> +	folio->lru.next = LIST_POISON1;
> +	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
> +	return true;
> +}
...
