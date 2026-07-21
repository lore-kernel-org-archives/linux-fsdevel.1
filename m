Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F73101B2
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634458; cv=none; b=kZKvP4ggB21e6QK4RHUPkcqax+FG+dE36f7H0khIlzaD9V77WAbOB8zDBuQDPxTBC66vULMgTCnQ5o59UjAtQ3PkSxvYjTbRyFpcFIz7SViQWlk+TI8QI/LI0qmmmheFY+NLYUNjzn7uS5/p1qRE8ImuVwCZ9Fi38mS1p5H5xrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634458; c=relaxed/simple;
	bh=d9nzsQKkA4gvGxpJizz2CGlvAPHH1WuAdZg7iqIPuMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCFISpEpP7ToOvhhyLhhp5yYfz0YZdDTKVYbkv+/tONf+PzGxq/1p2Z3oXJU0HDd9TiI42r7422IpMqRqjroQect80DqAFtchJ1jq3p4PwHfaeN/WBT4uEO7P1B/O+ZUjDVVGp/jd0VIlZ5fT87NIkrgtND6i46F4SgeUnqcVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ATWflK16; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ATWflK16"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-902fc790cd5so105085006d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784634454; x=1785239254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YoIW5uJnX3Jm2AAYIiYFvjSsneOztfm3z4wi+PXAoGw=;
        b=ATWflK16AhbQIx2+r7AxHOehU2e/eEyRjw56+EAIaFkyOXQ0YvqkDvb5BzvSXm1PdT
         2p4PJQiTR3mtW4QHMDVV2jZBE0yTpSNA74dRxVtJAAC4cRDlrMxscosgZs2CP/DNdN5R
         U0LnWWCQPYvissSBPHYRSw2ESAJ/J/YeV9gZ6z0HawzGdKulfq8UYycArfg4R4MhJfHo
         s4aA+LRjAJQTC/v/fpU/ef303wBpUuo/ydFDvs7+UXKp9BdoA3dz1LGwlen9xMlgQrd4
         gz/fdOTV358v8cO4y9BwE27Sirv5oFMNidbzP2VWEwa3aEhF54mN4AZlE5Blesnwu2hb
         p5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784634454; x=1785239254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoIW5uJnX3Jm2AAYIiYFvjSsneOztfm3z4wi+PXAoGw=;
        b=fnhM44SV4Abxkb586htmmibnl1mRLUa+gwzcudkkueeHqT7YyF/scX4mGsiuXTEZPb
         LNPVFswSaBBJpaz8E1OsmiJrKq1bloaRNfWAqjSPW/mZinOgJyraUaAMXY6Vyj3lIj5f
         Na4BB64Zyvw64xUGDltLFmcSgy8ri5QBsRkoZf2UofAd1YLYqRmLue5p/JLwzeGdSHEE
         5jgc89DILjro2oFqBbOdcfZRgq9ZuXqEaXWPrwZsxQkCXfTHR9gmo5ko+n81Eigzx7kx
         dd+bVqEzhpfrgxyt40a5NfPycd4zwzFd/L81ktvdTzJ/9n5fmrJPnnNknHzCjParcB7b
         iJaA==
X-Forwarded-Encrypted: i=1; AHgh+Rp31YKBKxqLeLYQFeRiJIe2vhtPPfeZNdWS9ufEbPxyqJkVy6ll4y/RmWuehlTNHzBACr0Q9AuXJMH/hINe@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIGuSIVUcdrzj7WMYn8A7/XZRCU9ZMIg9rZ6h7kpPwVp+m0N4
	Zccnl5zfRAgJ4W2IW3d92iLkxohDFiKhSyPSZlPh57oixMLxTCP8kwPy5fKjglHwp0w=
X-Gm-Gg: AR+sD10oWNMwAT6WNEyf7yM5r8c4N+hKcTGHxfpraTjOIBPg3hA8tAbhOC49EM7F1mD
	JSSxprsdkkws1HA3yeoSPGRaBDWV2RFWQfedQ2Brs6PCd4MzgZ5EATIdCktxLnVPP/GgG1Hmkbk
	PxRecEa+nK8U3UTSCTtTnAeSktG+PQTYawsG/yN/URSw0MGwus5mhC7pn20qM53nqcbnm/luduO
	9505ZiNBxEq6zyHlh1eHBeivABPfiEFdHnz3U13AMS5+RSCUKfOJeevCdfwi7dCYybYrysigAO3
	P+VQkUuNBeRj6o51cFuaBS+Fpaezda5dnBGQ2/ziaQs89rVKmwSLf9qBW7qqemo2aN2aCejmTXw
	t6v0SKup2SZLegdrahaEcymmEcQZ74iOFeq+RYFPeNI4QnYCXpC+hxokSWlRq6HCHweuADLBPOz
	w3
X-Received: by 2002:a05:6214:3a8c:b0:907:7635:44c with SMTP id 6a1803df08f44-9077850a1demr207255106d6.63.1784634454505;
        Tue, 21 Jul 2026 04:47:34 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077853f481sm118204966d6.2.2026.07.21.04.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:47:33 -0700 (PDT)
Date: Tue, 21 Jul 2026 07:47:30 -0400
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
Message-ID: <al9cUqWH-72HUAG_@cmpxchg.org>
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
> +		goto out;
> +
> +	/* Raced: the folio is now owned by the swapin; put it back on the LRU. */
> +	folio_add_lru(folio);
> +out:
> +	folio_unlock(folio);
> +	folio_put(folio);
> +}

Is this actually zswap-specific or should it be just swap code?

Both this function and the dropbehind queue in the next patch seem
like they could be reused if we wanted to make the generic swapout
path do dropbehind as well.

It looks odd in the next patch to have a generic swapcache &&
dropbehind check and then call zswap code.
