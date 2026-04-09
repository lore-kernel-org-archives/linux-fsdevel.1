Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C835A383
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722942; cv=none; b=MOI0IkbsCmPFYtJs66FFJYk0O2yD+i6BElFpPWGPbqyYjocCNrMMSX9Go9B7hEZ/4mcbmb/NIQZxrjvacs+jExbUBDigVte+wB4O3wA4ob8RLsV+QbwVRqXjbhtnCoUPsdhcghEEYAcsS1pGY/c9eIc3dgygMc4DtQaPROQdIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722942; c=relaxed/simple;
	bh=js8+zszlJkmBU/jF8a2Og8HnkG79FlUw+10D/e+FbjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHRUS7RvjvXj5zWT6LQg7OzjLb9+vbRYIgcgJ4KRfsaqC2ZDFoZC8DwiaUWFNywjo1eD4l3VlzZG2/+Ew8hTzuedTw6JkbbQhxbrhl2ceWR6yn275h0+yebEc/T612Z6waHyUragy2hVaynStBye8Otzy+CnmSUb+yYPnKSpO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YqguWJig; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YqguWJig"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso462446f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 01:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775722939; x=1776327739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tOlZqbKz0soyeFsp+SRDEq8smfLI1S2gYBgZ/02VudA=;
        b=YqguWJigr9b1aMkVhb0RxpJKZ0UBsMgNKg8XoMNiw0NylW3h7GIublR6rWk8iT2Mgn
         QViQCXyvKpEJNIRHkN8tG1vMFP2tKnfbxMFWC/wqDAS20rq390n6eVn7uUiEnqIkAlWK
         7/rG+FrEPEU/IUPlRVeKy6Ctpr4E5T2UOQlJsImWeR+58erwt5GMxG2bnpg+7Y/OtO0C
         BbGw/xeMxPKF+4F0vYqQZMb5j+9sLQu/CjH2ASGBkhsWpS0hNuEy2FOKVJNKd1+WkBWN
         WSROdubKEdpkdPivFWFqXwKZebGaxlCeHNplSav0DPmBExrGTy4S+SadGN4jVuZA8V4u
         tdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722939; x=1776327739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOlZqbKz0soyeFsp+SRDEq8smfLI1S2gYBgZ/02VudA=;
        b=EOdr9+UQuRL0DlH6q9tklMa18EA0/nwBcy/ph5dr20Ns7aUm4CSjK9tlsh9VvD3nHD
         HLoAUzVreQ9XuwkNQaMV05pMFbOLIgKlr7DPKabF4Z4atgk2sbEb0mgolLg6Il+GmG53
         WgJPDqWnM6E337KVRB3EXs+zFtJxmamTCokO6Vz+WL3sO6lq91PBv6lwO1UaLrThQA1n
         aej/ElHnMcUAhmcLOBRPkLFzIquFIeKI2sKU4siZjpmI20Y06D50tNQtd99gJqHOaVWD
         FtqZJUCynsxsG/jMczr7XVzRp3wvK37VrrAusCc1BiRHN/V38JrhAuuehz49F5rBU7bV
         2s9g==
X-Forwarded-Encrypted: i=1; AJvYcCWh75IKO8C6bLC2p+IXC0BFZdSwEdEnmWAns7lf+rfVbYgbPfhu0z+8regSEUWuqKw8U5aJF3xbcAhkOORW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqkb3Nbt6U73p8aS9+6+MEqZSzbUp+axZOBxYZdDBSPSmAG9b/
	KbXoshdwcGv0u5Aijrgquds+Y/5IlN4GMu7qyFnQgx0eQcqc0IZgi5B2jJLvndVY0y4=
X-Gm-Gg: AeBDiesOs+V+unbxWGs6yq81dy0MkkrLbWvk8Neul40Pr8UTfI6rOKJCSISpoqHs+v/
	fpz8LXpkqWmPR5SDFpCbqx2gpPe/p6GGot8tIDf23HTzi/eB9RSQFJkibXdpkkunp6u0zCLjYzx
	7Gz24jqqABQc+KuhXFXoiOaBXb4UoBvE+WfjVSX5Rq2bxMxXmltK0KfVEC2SEtWCnpjZtLudAtA
	mmN5Ndr6tG/P756FpUjQUOBAau9T4+TD8zJvAmhdUaB79LyLtDfss1xR8PRW542lpUNd3ObV0bk
	UCNmV4Hw8wZLwMz/dRIdsRUMWItuQB86iFiZrNvvpVwtOwgZZmL21ILKENpw1HO01yvjWb0hFvS
	Kyjk49DR4JptKGfWuTQNc1qLxHLlgzkPA8Y8zhw0nBlqv8dQ3IsalGV7MNJvqYkGiL9rNTD9DDf
	Bca3N7u0IIry6bEex8zEAG4KHlkBRR6J/gLQ==
X-Received: by 2002:a05:6000:400e:b0:43d:1c39:534f with SMTP id ffacd0b85a97d-43d29295ef1mr36340143f8f.11.1775722938997;
        Thu, 09 Apr 2026 01:22:18 -0700 (PDT)
Received: from localhost (109-81-92-28.rct.o2.cz. [109.81.92.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e52a0sm62165656f8f.30.2026.04.09.01.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 01:22:18 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:22:17 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
Message-ID: <addhuRqrB-u7oDp8@tiehlicka>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
 <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>

On Thu 09-04-26 16:08:37, Kefeng Wang wrote:
[...]
> To use the reclaim interface, there are two differences,
> 
> 1) we need to input the reclaim numbers and swappiness, this is not a big
> problem
> 2) for reclaim, it supports swappiness=max to only reclaim anonymous pages,
> but cannot only reclaim file pages,

Why is 2) a real constrain?

-- 
Michal Hocko
SUSE Labs
