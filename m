Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208087;
	b=nM93Qgcxo/HfPjOP1+TJUonTVqrqaVVuM62P+OEulmY1Wk1xA/U9/tulE4zcVgEQWnk+
	 hLk45xjNiswxdhL3MghUw29zVBYmSq80rO0086Eq2Bz35puEqdkdt2ciDZFjrWIkwN5VL
	 QyrADkQjRuAKBu+TVAtZ13VDl9ztMJB/U9FMZ68NH6YEVlTdqd+cRkyKRTpQnKRfiAju/
	 W9KLkb828/wKZ8jl+BtzrDaCSBPmIeJERgxSUqNDAPAicFuBBiO/j/b72jB/Jwx9dl6+Z
	 Zn93WO7AJ1g1IvSLkNIs0le3XFLVo4uyM+fHg6wluMjFXtUCmLKsdOEJqbgcgHN8w5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gKWv/vfGN+v0zoryVVsOrqbU4hq0g1uoOUtfYF5rLd4=;
	b=neEboHWeU5vy+KAXN5VqE38bDHrOxteBxp6ez9AbEE0sJG1n6lIJe/vIH49XQJ1AgsXd
	 iwwW+/1QLDugOh/oAmmQYog3u5ycBZRRfwZ05YuwhWQcVKazV1SM5F9ZvODFBDXq8Qya4
	 y62jeUZMXokZHCCs4QWp1sG1/JSg70dRbpnT6dZDZpsOmO3QXKvdsKSn3DspSYNlHDLWh
	 2rhbrcOTdfZgMO//hDeXaX2ZkbXCc6954I5WgkpT16egx3sO2XcyDiZHjvCxOx7fKwFYS
	 Jb3/5LHg56fcCCACPojpblNM8JsBvVCUQMCPOas4eEnjyKfWYfCYLjVsxBqMMXw3mDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=SQlFBLtW;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185D606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 17:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2185D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=SQlFBLtW
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-679965fb848so1408392d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793208086; x=1793812886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKWv/vfGN+v0zoryVVsOrqbU4hq0g1uoOUtfYF5rLd4=;
        b=SQlFBLtWetvrAOGwtD51xhjKHJMBmuVVhKXJUHggsefbsTBeA9lSUtBHLEvFQVQpwk
         5rxgza6m/fEullx3LCe/5EOf9NitilOHi/ZmD+JZoZrLhue8TEStDNUqIv6MnHIQn4BL
         ASJwtOkabzww4BdFogItYgHjFyEYahE+mlqAedNSjHJcjtmSyL93pQIFRzgVKyVw/q9Q
         81abU0Nq7hvVg258F3rlDeN1MY2edyUC5XbswXKuXMO7fBepqm0oxBuoEywcY0tTHB7W
         viLo1aeiP6zlrKoB9h1bFeSUMb6NEqE315HFQ0S5k0SQT/BxI3ijsPyYAnSyXqISjRVX
         A9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208086; x=1793812886;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKWv/vfGN+v0zoryVVsOrqbU4hq0g1uoOUtfYF5rLd4=;
        b=pqmL4MGl9VwxJWP0Nf5B7wHHZIEkzpRCVK/mip+i0RQ5M6nWInX7be7OIbojfHF55y
         m1tJti6fm/KOVXYqHKGJDqjtgZ+Rmu0AqKNdFW3JQEKOKUm/Srp9aDdQFssCT789A+d5
         SLOFGneOyvNWUnGbvkQOQnaYY0981CE0wZfiD3Yi+oyzabwTfJq5pUJCRZdY9zlkhj7J
         SiAdsP3TyIO/Qr+vOc1rF6wdfo84y5BbQOHS9QP8yQf/Pag8zoHRzkrIx+CsJ94gWHQU
         Q1vyHmIFua7C61r2/S9qsNNPDhX6qlOUNfLybUCeUnEnuaSOGVlHSQX7JdkyCjllqRSg
         RdZw==
X-Forwarded-Encrypted: i=1; AKwUvByvHQ0jkUCmJseGYD5UIFLXRDdfS9UvqwHzKakBgKnux7MESQ8sd/tTILFZyI4M6P1/nLVbI+lfFVEAuxQn@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/kek9P0/6lEDCOTLDCHqqBEOsdTOa8bhtSCNlOkOfPLQjceQy
	0EqYw3GdsmRc9GYZxFGlYeEspMSLZJ5ZWQxJ0B2XSx6TKpIkIEb2nZswxs34u8vmKzo=
X-Gm-Gg: AYBFou3Cm5F+FcoZwYIIsRyxL7h6IMHoctz8a+Gut7eQj8WDCE05JWRSNAKOYnos9Ln
	smzicCVhLEHiFNKEG9FlRVt7YXYmjMmB+Clt0M/3/IEi+Rxaqo29tzzEe0jdT8qnNYmrfZKpAQL
	5hzSu2P+uZiwpetA+XsKReG9jQsfKWm7Vu0Ya2xBW2xbFMGNiclizuSoMoQIlmqP5VUljITrd2c
	fKwT/5fzr/0YadlipDL2X+4pHFURHQbapIzGwPpGNEVXPPJv9u+Ch4rJUQ8hKVUthYhhkuYnAe4
	VmArafHw0ZgnooCoBAk1du7Pqq5nYSp4FTWyy044ur4Q+YMkDYB610SttS/nsH6OllVz7rcH6c1
	r3iwVrLT0uGszG7lXyWyA3GC/fUA+RnHFiOCnvVWzRwwM6RD0HQIJVkCcqK+41mICQ8UsteQYu4
	soZVCE/bNPU3tfiLYdoIQjzLGgK3xVAXYKsTFM9jZWKR87Q3ACaaE85xhC8rkBKciJtGsx13Sh/
	DZLnp9ra0XDL7Ebu+hQxdT+vJStOwlubSJIRuQvL1uDicDCd7xdH48Gzgq/lCWa/n2iT5YjUgBW
	6OMAuBHkOhGi2tMjewU871ZLdS6B
X-Received: by 2002:a05:690e:1183:b0:678:fa71:301c with SMTP id 956f58d0204a3-67a7b992b9amr1910178d50.7.1793208085931;
        Wed, 28 Oct 2026 10:21:25 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a0c31cfsm2144554d50.9.2026.10.28.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:21:25 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:21:24 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: abuehaze@amazon.com, akpm@linux-foundation.org, alisaidi@amazon.com,
	blakgeof@amazon.com, brauner@kernel.org, brendan.jackman@linux.dev,
	david@redhat.com, dgc@kernel.org, dipietro.salvatore@gmail.com,
	djwong@kernel.org, hch@infradead.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	matt@readmodwrite.com, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	vbabka@kernel.org, willy@infradead.org, ziy@nvidia.com
Subject: Re: [PATCH 1/2] mm: page_alloc: do not give all non-blocking
 requests reserve access
Message-ID: <auIvFBlNU5N_PVyd@cmpxchg.org>
References: <arFBr22V60BMmVpl@cmpxchg.org>
 <20261027150002.318916-1-dipiets@amazon.it>
 <auISZ5w318zwUZuc@cmpxchg.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auISZ5w318zwUZuc@cmpxchg.org>

On Wed, Oct 28, 2026 at 11:19:08AM -0400, Johannes Weiner wrote:
> On Tue, Oct 27, 2026 at 03:00:02PM +0000, Salvatore Dipietro wrote:
> > 
> > Hi Johannes,
> > 
> > Vlastimil asked that v6 of my page_alloc patch [1] not go to mainline
> > before these two patches land, so Andrew parked v6 at the tail of
> > mm-unstable and dropped its Cc: stable until then.
> > 
> > Are you still planning to work on 1/2 and 2/2, and if so, do you have
> > a rough ETA? Or would you rather post them as a separate series as
> > they are? If anything is needed on my side to move them forward, I'm
> > happy to help.
> > 
> > For what it's worth, I ran both stacked under v6 on v7.3-rc1 and saw
> > no performance difference on my benchmark with or without them.
> > 
> > [1] https://lore.kernel.org/linux-mm/20261001082152.2879289-1-dipiets@amazon.it/
> 
> I'll work on this today, will have patches before EOD. Sorry for
> dropping this.

https://lore.kernel.org/all/20261028171719.2043421-1-hannes@cmpxchg.org/
