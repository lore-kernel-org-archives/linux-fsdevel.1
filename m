Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BE3E8683
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178809; cv=none; b=opkG7zpoTd6zB7k8ftMLrl/c9tfwbC7fQRL26J270zKLMQ/o3FOhfx5MHd0Y6nQJBTfZAauliTrA0XDDErdt36FFD701fSdq+pc6CdRpL2ocRqdzcP+98QdI44YuGX2rJ0hEhlEbHUfH4388LhggWnZ20w4sllSJl9y0rcgFjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178809; c=relaxed/simple;
	bh=MHeRXp7jWudyKWW5LDG/8x9GyvugF0IbBMSQO7eKVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUEomOhbWG78lbpb9POtowVDvrTGPVnBCNuCfzPfd3f27JbzUDrfbXrJDQWXmhTM1OXgS0XRLowiJbhLemWBhIilje56OzZ3iPsp2Yc/BI2o+1legPxsNHucRkBxwtsIvlCgQQgSxK92o+e+7u6RDheBUAJSB8ahFJIXzPL+Rwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leNYsSUY; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leNYsSUY"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dbcd61429cso2713068a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776178806; x=1776783606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HhNjSBI2VaOj0qFbdmW6uKns8Ks8XYfh0+PT8mKMJY=;
        b=leNYsSUYtU573OFGCWKt04bmvenwZ6cITupzuVlO/TCG7KEOjQG4HPFLMeWgC1Sm88
         WRVtpi+E0HoTuxY5yj51vLUKPG18HUB4DKi9ARNNiuVUCGAqt81nxaK4sEhiAMGDZ+VY
         xdETbdaDbxm/5K3T7+qnVXCQON9A8MQ7GsDHuEuis8gSLRurhmi1hlQDP2mAixHog0ta
         flK2x6ZP0sumaUTeF1cf4VNEBdCBSsNdX6jwSvkjbAl15uHHHoViK7JSj7Wg3xoLa4DU
         0S4Nex5JOUdiHKqoWte3p+uP7Vmt17DsjUJWfagoxlBFp5sHUShTZEXAZQZMR8jiTiaK
         ljuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776178806; x=1776783606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HhNjSBI2VaOj0qFbdmW6uKns8Ks8XYfh0+PT8mKMJY=;
        b=mA5/3lMm5xAoClQatY6lqsXGhDpeapQ2xmiMuM3Yco3wqepWgBBKIV0RpJPTrmiInj
         as70Np7ZUgwRS3lzlKoYmz2cgdiMMKd5aidLZw7bImZDBhrU8Z4+t3PjKgEl2QurJK/w
         ezosbaCMKB+SMhdVgHNtFjVi+kGfhtX7bjmyr/4bkXE1M89psgAIMKNVWjDLfuNqPw/5
         ffYPSHksH5eFtH/+r0sMWJNguc6Y7FzO4KS7d46beToKTM9Mi0i5AglZeIYEHZieSs/a
         GUq2oYHIRbkuh5/03QxV4D+6kXAvTa5oQPQL0R7i+QSYq9hKLXULsVDb8O5XJeQA+yby
         I8sg==
X-Forwarded-Encrypted: i=1; AFNElJ9PBAqt7Mpy//lcgAtHCz8rGOtXOjlGL481T+dyTHCQqyx89q+sG9e/ui151uY1CQRWsXcMrxudAKjrFL3P@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3leva1zZb9p0MkvpBXcBLnKbvX3hCtOW6CQa0iWXzIHrOS2N
	wPY6Qv+LwFqqNA6aWcrjuireIb3w1NgscV7n+jMVHddVB1CcXQK5QwhJjwriHQ==
X-Gm-Gg: AeBDievGlvzn+ksGFHtPmKTpHFOvj0/G57QhDpMGPcZQnRJZoe1NDXparxxB4tk1DAN
	zpwlghkj2kMIy7gGj6IuTrl0SKaliFcGLd+lA69EaDLmYhy+eBnPiAbU4e9Q+84V87xuWR8tqJI
	z0s0WhsL+mwm1ljUmU0DvscvtAeO/bZ7YDMGF9z/aC9JFlI5xG7SgwHZDz/ZSPvHJtht6wO6BhR
	bD1QH+uwWBEDqMZfpEPkyGR72bqAXr/qgfhDID7pGJHA7hcDuCqzQOEkSg1qstllg1O1stmA/7v
	g2DkHwURIfyEcnxAr0b1xgZUaLZiMaCw5DmzCHzlvBaPcGbzLH9ULXksidMC76ks9qbQmxigzMN
	oh1uFdR+rhUzje+TY1TyLO5vCJEyrL80riKnFwFGVZ4mF51GYaQZw3bxYg8zm4Hhyf8XNP5Nj44
	INxi86dELUt8/RKfZurOu+KA==
X-Received: by 2002:a05:6830:488e:b0:7d7:51af:4aa1 with SMTP id 46e09a7af769-7dc27db3792mr10373819a34.18.1776178805691;
        Tue, 14 Apr 2026 08:00:05 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc265c2babsm10705351a34.7.2026.04.14.08.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:00:04 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ye Liu <liuye@kylinos.cn>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm/vmstat: remove unused __node_stat_* wrappers
Date: Tue, 14 Apr 2026 07:59:58 -0700
Message-ID: <20260414150001.3262806-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414091527.2970844-4-ye.liu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Apr 2026 17:15:20 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the single call to __node_stat_mod_folio()
> with node_stat_mod_folio(), and remove the dead inline __node_stat_*
> wrapper definitions from include/linux/vmstat.h.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  include/linux/vmstat.h | 18 ------------------
>  mm/page-writeback.c    |  2 +-
>  2 files changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 3c9c266cf782..54da7d820f78 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -440,24 +440,6 @@ static inline void zone_stat_sub_folio(struct folio *folio,
>  	mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
>  }
>  
> -static inline void __node_stat_mod_folio(struct folio *folio,
> -		enum node_stat_item item, long nr)
> -{
> -	__mod_node_page_state(folio_pgdat(folio), item, nr);
> -}
> -
> -static inline void __node_stat_add_folio(struct folio *folio,
> -		enum node_stat_item item)
> -{
> -	__mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
> -}
> -
> -static inline void __node_stat_sub_folio(struct folio *folio,
> -		enum node_stat_item item)
> -{
> -	__mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
> -}
> -
>  static inline void node_stat_mod_folio(struct folio *folio,
>  		enum node_stat_item item, long nr)
>  {
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 6f9b7b081ab7..ed3301753e89 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2627,7 +2627,7 @@ static void folio_account_dirtied(struct folio *folio,
>  
>  		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
>  		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
> -		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
> +		node_stat_mod_folio(folio, NR_DIRTIED, nr);

Hi Ye, thank you for the patch,

In addition to what Matthew has pointed out, I also wanted to note that this
substitution isn't trivial; there are differences between the __ prefixed
version of node_stat_mod_folio and the one without. Even though the correctness
of the two versions might be the same, I think that a change like this should
be supplemented by a description of what side effects this change has
(i.e. introducing additional overhead from the cmpxchg loop).

Thank you, I hope you have a great day!
Joshua
