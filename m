Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF635E930
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814002; cv=none; b=KfUzmvOq/iC/DP9Q8riCuBIpLTL1yTNZRmPRrLKT6Qo2Qx1ipLYTyD8pVen+fAF6PB7zzGbTuc8xFfjUlSPm5o7LI1V/2zKva5F5Dr27Z1lACSn9zfXFV9gKNE6B8bFYjgm78npOF4FDaHCG+C9Cc7oaURR6xA7s6EN8HxON1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814002; c=relaxed/simple;
	bh=I8LhLJQGKlLzmSUfdTmlxio2Ouv1yW2nz0ZGC24SFaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1Truur7qMnRsqFeFPj6fQOwoLrY6gkIPMarwNqxoRPyEFcOXaExCBcoo3Zb0QeRFIh+RfXaEP/7DA8WQ0YqTWdqTeX3TrAmyyDiEduX8ALwFa9NpLcRzH9IKDCmcrsj8HQMOW14p53O8jiATkSJ5iCiH0LZaqxwny7BwlmggYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=tUXLX/VJ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="tUXLX/VJ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52192509869so4760531cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784813994; x=1785418794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5OXNEFjRCaitHQKe2wfBmPOWIET8WKaJvN/RgwCYDNw=;
        b=tUXLX/VJdwZmnyCn1KtQ4aINMkwFrSTzYVRnHJBscaYGWzw24DPCdrIHdahlmbebtK
         Ud0wBPD/AcW2AY9xBeO7Lqcn+0C5fPOroriMAEtQ6QFf4I/KPxm2pZW3V4lXM3fDnKba
         /Nb7E/XX4SGRLInI5Jtt9v7ef9GSEolxNxMi2/OpxdYUC6WbHfEXKh8ZkZCT0tkDq6US
         debzQy8BanKUVltY9opXvW8TzAsNgRg7POBZ+b0jpEFE2EuyMRXagHDVb8E5pGB05RyN
         ez6cgJMSjKE7GSq0naF0c4EXZaRljmpr6XcouVklCgnzDZ24vG2b2VjhZKYOh0OxCtfU
         6X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813994; x=1785418794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OXNEFjRCaitHQKe2wfBmPOWIET8WKaJvN/RgwCYDNw=;
        b=XNFujcMwBm2vl6MN2GXQPRUADejTwXjkBAuGfDXZaMnu3U4bJqd/JI8TgP7b0aWg0g
         DeZcnoFS+FO/81Qj68tPBjDsRztltbBGl5NcEBx6DByJeWSWE4p3iATuty5tkDaM2PxB
         BYkz+W51O4xr0JC+3WwKkMzpzhKpLhm4aCJ7DTOEuDe+qfBX1YQOsHzd0Xllb1nHci2T
         HdKECuHty2YrnnJl97UO8FGsJrXChavKEw2/C1bY8X1jiQ5JlPmj/XAQyg499N/VDONu
         LYSP8HHcBdtUoNRZG5j/z5kfowssVIri911YJPogO9hXyJgQ39kj9U/6iG9BcQneqbZj
         e2Zg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7r+TRCDdSMUMH9TtfRzqjIHhbLUVO/iTxw/aqZ/pqAKd1MowJ4tW5Mj7NB/XMzT8IG8kOHH464/OirsYh@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHpXPr+BFh220Rmqg3RLp43wxi8+RwIseHkBSeRz2zXYvJl4G
	2DByGKi/a5VHFMjwX+JCZG/AqlSzIi7bQ4PZmdqt111z9p2afQj5iRtkPsDiom6fWKo=
X-Gm-Gg: AR+sD12tWWGV3LBACbblt4g+oiVpCKpTlj3k7u47wTjY0uxt0KlJQLPGl6EYdtxINdh
	kUbbPN8LaNyScTZyCIEXFfj570JgWoLpEFutXQVbPN4o/jJ8wXLBNOML3DpZYVFdJkYTeZ+IX0K
	4hADQT9UhRJQfgL20cZ2BTvh7l2RzhebAZ2Mgcedym2hbgFBwjNHc37lG1guEW9noOxmYu6FQI/
	wOR7BJaDlrti0/WtCVboiAMOiELlJ39rRUD+oftsc1gOYNo6EybGb2ymrYtJ2tvr7Za51KZdTHN
	2Z+6IJEMV1VKvj/jDLZjWuk8u1G59zrRor5FWsTVjg/BmEqlpo0XuZ08xoEO0wYIkVDQgD5KX0I
	bU6pwPAluZA2NOFNWSKARflo23HkA8aBN6l+fzWMPI2oVsMOJYi6PmPp/Op8rKj3aj3YXr5XGIx
	fp
X-Received: by 2002:a05:622a:5906:b0:528:30e1:b5d3 with SMTP id d75a77b69052e-5283e0419fdmr25761861cf.84.1784813993716;
        Thu, 23 Jul 2026 06:39:53 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4ce60sm35155751cf.7.2026.07.23.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 06:39:52 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:39:51 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios
 directly
Message-ID: <amIZp7Ual_6Gu86T@cmpxchg.org>
References: <20260718093723.153324-1-alex@ghiti.fr>
 <20260718093723.153324-2-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718093723.153324-2-alex@ghiti.fr>

On Sat, Jul 18, 2026 at 11:36:39AM +0200, Alexandre Ghiti wrote:
> @@ -972,6 +972,30 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  /*********************************
>  * writeback code
>  **********************************/
> +static void zswap_writeback_free_folio(struct folio *folio)
> +{
> +	folio_lock(folio);
> +
> +	/* The folio was allocated off the LRU and nothing re-adds it here. */
> +	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
> +
> +	/*
> +	 * Gate remove_mapping() on folio_test_swapcache(): a racing swapin may
> +	 * have freed the swap slot (folio_free_swap()) and dropped the folio from
> +	 * the cache, and remove_mapping() must not run on a non-swapcache folio
> +	 * (it would trip __remove_mapping()'s mapping == folio_mapping() check).
> +	 */
> +	if (folio_test_swapcache(folio) &&
> +	    remove_mapping(swap_address_space(folio->swap), folio))

I just chatted with Alexandre off-list, but this path does not store
an eviction shadow like the reclaim path does. That means no refaults
are detected from dropbehind pages, which can fundamentally alter
reclaim decisions, zswap shrinker force, and pressure detection.
