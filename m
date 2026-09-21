Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5554A3F1C
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006338; cv=none; b=Dnk+8AQVPfWZfebQBL51WOfLtV+BuDbruYXcluPOCTRCJNsZc6XHM99wZys+41IHLbTFnVeSKxaXQxS/la7ahty0bYGser7AWuul/hxki4tBc6+ysM5fMJ/vDTb13Rji9d2RgT9MRfyUr6PSritKoEpnBywBF6PoiDNPcmBfPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006338; c=relaxed/simple;
	bh=OLO+jzXikhFs7IArv/n/us8KnV/xU40MQ5N+CqeNGtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CthYSIaFiXrviWipIWniaTUEaDOV6/q1dabxCZm3jkJBJZKCkwuxK8ZSfHmwalZB72IG7tuDIbIo7uSQUtVTPtTDXEdn75AGr2Wbeg789XZrdqFZGFh3ZoIyTp4qhRuzOBiq05I/tfG1g3pJC/HAn8bWd+bVk84sBobJBagkdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ibkb26Pw; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ibkb26Pw"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9104649a5dcso28690066d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1790006334; x=1790611134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YMayVPzqy74wYsK2+s0iOp7Kd4xLwxOjegiyzaJMk4o=;
        b=ibkb26PwKeFh8h3IDEl552m7Km68fRBAixjECbFf2TEb7MPOhkmgX6cgYFnZI3DlQv
         99T3tzsPHJf/3lmRDRp3s4m6GA+SU0EwWOmoFTmvz/nyxHQjCDBf0dp23N6bdYsqLqJH
         c+E27S/+C7pJDAtWolMOufPFt3uKNuzqHeU3Ymlv1RUDcWRYK6/CIcM0cabhQbVnfu4d
         Q8bz3C6krLgVpU8fl+9aaQYDgP7gUf2S1alLVk8JPp9DEp7cRO7vlEpDv3GPMmaocugo
         qMwJJOsnK87RYmbi0M34KuAJ1WpR1G9HGWh8MuPMTCuo51e7M6PJ6DjdrQ1sC4AF0d4U
         l18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006334; x=1790611134;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMayVPzqy74wYsK2+s0iOp7Kd4xLwxOjegiyzaJMk4o=;
        b=KjeeE7lroPEADJKGpZVkv+sU58qVUQFMdncEqlC8ooBqKArLRmXwmhtzvbG/5bZzqz
         8DDBizb/KPuBLXw3J5epO23Y9Yn0C5ST7L43Uty/5+ETFK07xnOmQoXuv2iItKxKBxlu
         FRJSVgLWxkOYRe3THw0B3G88sECFoiRyD8joGpel/3mhvLtcEznYWvMy6seER0xsO8Ai
         qiIvwZDZYR/76OSC/3csIQiVkjHGg3m7h13DfeHP+TUinJC01z+PG1JvsvIXWMCtgEks
         k4OC3OQX6/U1n/bncJb0ZshCJRzTLia5dE/065nLkUFhVhUOdaZXAlOLZUM0TugVSikN
         lP9A==
X-Forwarded-Encrypted: i=1; AKwUvBzZ1uv1F9v7kGiPBR3Y+8/pzz4SbcWX/XiBneZzGeTApdg4fVLBNa+ztNz0luFofoF8n9zmsEEIc2OUiHS5@vger.kernel.org
X-Gm-Message-State: AFuF++m5UwrjHNhvHqox8m53JB0pb7ZsKeLfouq+Ffu5ZuOhV3Z0mR0x
	zp16kbdrlyn8t43qtRdP0LWVqPJAiT8LOio2BD8xIVQLJAHayUugfzGKid65W+dmyNI=
X-Gm-Gg: AYBFou2jkL7iBMk15U/p4721ViuGoGtnnaC2ibkLC8Jy70Q4wcCzZkdcCUlG+/B3bkv
	lVLb8aQ6igQGlbRBeobkKrgKk7wefORyrOGSYE7HnwxI9Ay1AIZbQgc2tJVkliRB/ox7VjJvnkH
	gYpf2DM7liZ0U/4fCFf2yHJxbw3T7+k81aFjcbxxjj/WffqGpkZja6Vyr6q5oHUA8znXFKW8VS6
	Arc0Iw5eoz7IiK5DR9A8VkGMT1qaiQqw07BGWjDp4W8XV322Q/20Cz2VBlg+uo+cD6fOrm546e5
	fT4920mmatYNODJ3Rb4Ra4hsbLJ4Ec9Pf5LTru8FTA+fFqxAHL340VgeMLCKtaui03ena9T7ZN1
	ecwBPwBc/iRKcWMS5gvt0P6iy9k32PO6F5aDUbsHlf8PYCXmgzVJP6yK5wIndTYFw7FyeDreNDO
	Zdu7oonDfuUYsnnP5oMqKfDOlm1qHs/5y68yAcmlqZnb1JNkgdvSduIu9w3lIP97DtjQS0vrhpd
	9MqqgY=
X-Received: by 2002:a05:6214:27ee:b0:912:6067:f517 with SMTP id 6a1803df08f44-913fc979c79mr11430666d6.46.1790006333775;
        Mon, 21 Sep 2026 08:58:53 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a86f62sm70283746d6.33.2026.09.21.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:58:53 -0700 (PDT)
Date: Mon, 21 Sep 2026 11:58:52 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Matt Fleming <matt@readmodwrite.com>,
	Salvatore Dipietro <dipiets@amazon.it>, akpm@linux-foundation.org,
	abuehaze@amazon.com, alisaidi@amazon.com, blakgeof@amazon.com,
	brauner@kernel.org, brendan.jackman@linux.dev, david@redhat.com,
	dgc@kernel.org, dipietro.salvatore@gmail.com, djwong@kernel.org,
	hch@infradead.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH 1/2] mm: page_alloc: do not give all non-blocking
 requests reserve access
Message-ID: <arFUPOi6gadAvD3E@cmpxchg.org>
References: <20260905174239.99e31515fabe220aa7d8e6fa@linux-foundation.org>
 <20260910114602.926944-1-dipiets@amazon.it>
 <aqQlUr-1h07G8JWM@cmpxchg.org>
 <8d6a8a63-4adc-458a-b548-a47bf5ff8eb7@kernel.org>
 <aqq8pWI0u1IZNWHT@cmpxchg.org>
 <9f415dc7-adad-4161-b20d-7c3173f50ff3@kernel.org>
 <arFBJdYaRx_iJNDA@cmpxchg.org>
 <arFBWvzXPYrKuIYi@cmpxchg.org>
 <arFFKGrpPwtTkoCi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arFFKGrpPwtTkoCi@casper.infradead.org>

On Mon, Sep 21, 2026 at 03:54:32PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 21, 2026 at 10:38:18AM -0400, Johannes Weiner wrote:
> > +++ b/mm/page_alloc.c
> > @@ -3246,7 +3246,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
> >  			 * reserves as failing now is worse than failing a
> >  			 * high-order atomic allocation in the future.
> >  			 */
> > -			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
> > +			if (!page &&
> > +			    ((alloc_flags & ALLOC_OOM) ||
> > +			     (alloc_flags & ALLOC_MASK_ATOMIC) == ALLOC_MASK_ATOMIC))
> >  				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
> 
> Would this be slightly neater?
> 
> static inline bool may_access_reserves(unsigned int alloc_flags)
> {
> 	if (alloc_flags & ALLOC_OOM)
> 		return true;
> 	if (alloc_flags & (ALLOC_NON_BLOCK | ALLOC_MIN_RESERVE)) ==
> 	    (ALLOC_NON_BLOCK | ALLOC_MIN_RESERVE)
> 		return true;
> 	return false;
> }

I tend to be hesitant with single-use abstractions, but no objection
if people think this is better.
