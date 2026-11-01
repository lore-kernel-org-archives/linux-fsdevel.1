Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564578;
	b=l7onJcysyw9zl55az0atfy/KcZ7LmCNctPn72+2Urpsc838XzhefYcwuRk5UgAN59NgW
	 ETIABjMBY13ygBI7Zz/bRXOhNj2UNcrncw8scOSw8M8jAtLSQUMAFhLvv9rbAcrvKF02X
	 QmNLGQmDxj0JSGvvSp8lGIsQKSxfRQZisuzLN6cF0aN87hBejnChai0iu0nIwUDO3mExV
	 64rz22K0h1/8PwXPj2ZSn9aPsr3ElYfFEW3iz6yMRp2zS2ROpvOEZm2BLRJLpOZRXUfOG
	 yLtObNOnpgVo6L3cVg3kVlgJZhOr+I74upwxtZCNTd8oiCQ2fA279PlaaJSNGFyUmxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=9AqbH8327lnwvg1LioWgbD9Tcq5AbImAQbsNTXyY7Tg=;
	b=BOYuUTRNSl16m7jtIp0nPrEJwGqk7tAqnLT9PJiZFdMT7dpUIDGbIVj/wEUCzW6YY1qz
	 s5lDCd4+KOuB3zraVcpDHTimH0DxI7ODyewCREgg2P19Dy/2tp6MUPkTLD9XvFoj7qgqn
	 S0ri+/jYclnJ9xm72Pk40fAY7Y9yqeBA/kIrVN8qgKBCB2V0Q0OWdPvpvm43tyagJeKqt
	 CQBSz1iAZXaQ2qktuIHl7uJZql/VSl/8IPRLQeghhXrJ8SZsTdDtIXTOHwFupl55vgucD
	 k7F8OK6LIj1M6rH0Emusx/uOoU/f9gEzHEh81vf6t8w0yMbigKNbBjBt8L/dRftX6AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JGACffg8;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCE606A324
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 20:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DCCE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JGACffg8
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so41865ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 12:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793564578; x=1794169378; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9AqbH8327lnwvg1LioWgbD9Tcq5AbImAQbsNTXyY7Tg=;
        b=JGACffg8Tpdikw02Nnu2yPrM8NYotsNDadMtp0vyGPK2kLoNqmVH5fbKastYjZZ5P1
         hUVx4fu66JrfwA4MbJsfpeY0DZEYU6jubdfK8hVUQbd0sCnvOqlaV+I8fBjofl3sjGPM
         Gse6cnFSejx7IfPnqPQi56DVbYZJouav5QEvnGLaQVx8HrI37rgIPwEjtlfLYPSggqoG
         m+ilaq6EAXy9SC6BUvD+kjtLSr1ZcFTO7V4SY0GNKkYlF/ZR/x4sSnCStW7GWEKJMh9q
         EbIDZ0AJL3RT4jvy7UjKrSRBefOd22r4X7HO9bsPdbilTpC0x7ImZKjg5J7acuHmr9tR
         HlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793564578; x=1794169378;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9AqbH8327lnwvg1LioWgbD9Tcq5AbImAQbsNTXyY7Tg=;
        b=YwFz+d5gBMmZVdyR+zi5m2Btkh4MI1C9xpStvOyj0chIKxhwBBDqU8O3nAChfv8w+u
         8V7EJoKUC6p9NGHmERGkvEuVlYVdJ5nZBxBwdrVeaWU5XcDuCtu9nxSS/M9mhMTMBcfR
         S/38t/+diGJZqcVu/ghPWxkZBeG/BH0J/4XlSQm/tQ86y4/MJuBxrUj3eMp/GX4h0Gxq
         yC5Aklp4r5amOO9uBVyOWs0MBLPtfEhSV0SfO4TIaUQgx49WoUffsO/QEMY/X3BJ974t
         OVtwg2k3ACQ0Fg/5XHWotuvcJ7yGtHJBcge/D7haboqkIK6BzEdc5trz5zDLZnPEsjCA
         q4Mg==
X-Forwarded-Encrypted: i=1; AKwUvBy5AgeeEXjBOCd36UUdkWDnRWsrysJ/19OWbQ1hrQW/CO0BlYhXwCHyEOEQ5NJm792nRsIkRhspJd2If2T1@vger.kernel.org
X-Gm-Message-State: APuU4Z97xzmIqw3x+Rd8/3cyx0yq4xNExG6rDz9I40lhFGssoJbJRgKc
	2Xql8/0z5PBLcd04mF16xOUv8jVlVodSjBE9DNkN3WGw7pi/Rci6JZDkjYoc/Vroqw==
X-Gm-Gg: AYBFou1FfTidVcnh4MipIDEvwC574cWSB7cMZz/hIO6LoBqy78yEfaJOHliWgpJJD9i
	Hciq2dXQrPR6ByppApsa5cT4NI7EnTAe8qyqj6WxySI4k2ChfAAyA3NF1LpQFFZvYl30KqzpEjt
	qtc41Ok4U04lOW/GWyxlr2zFYfDD0V7Tj1boU2uISC+fQHvacHSATDMkMdT4ini2uuhJ1o/BvaD
	tmXIMp2NYLZB3KuH6v9D5ZeH4G5a/FMJLifcGhxoyuukMJAUX0l00dMdH+xd9QFacxXEXahabOf
	Ix7z1nGR+axLYXqrGrWUDf7MFqoeDVu2lzr//xeZT7k6hyHVKznPPHrdvAWU0c+KC+Ezyq4Rqtv
	+RtR0JiBD9NcqXMSTgNYZiJheM48Qj5by7wwlB6nppwpQUiF5UjyUKJ0KVnZp/1DaLqNy+44482
	pWD6hXoFuaIGBVIaM8f+mg0minX1QT1sf7cjFW+vcDjpjXpf4U4IfL88bpvN3UBgg0+e5y2b5vQ
	4FQVFY27ngOrzhnoygJwfgKK1GUWRxXFxaN/yJtRf2/Pnk1QSq5Fhc5ppjbBNicKep03U3hO6yq
	1twdMunyYzlWWkyJ234Rh5X+kqZL3egdQ/bW9Zie1paHO59bBrUZiniCQOLr6H/l/zgx64uqTY3
	c8/2TKLsTJRO7C3i5iZ7AuAoX6/5+5Lt4EVIonvPWCKt3eEyNr5wvy/9UBg6tNIgUHrokdFc5c1
	jUc1ziURNZmNINjviXzbAjaYPvtnpHLViclAIHyjEBFFOn
X-Received: by 2002:a17:903:2acc:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2eb019ace41mr24556695ad.17.1793564576851;
        Sun, 01 Nov 2026 12:22:56 -0800 (PST)
Received: from [2a00:79e0:2eb4:9:6dde:d2a6:8d93:5cfa] ([2a00:79e0:2eb4:9:6dde:d2a6:8d93:5cfa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a5ecsm11128450a91.2.2026.11.01.12.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:22:55 -0800 (PST)
Date: Sun, 1 Nov 2026 12:22:54 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry@kernel.org>, 
    Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
    "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
    Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
    Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
    Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: move SLAB ALLOCATOR under MEMORY
 MANAGEMENT
In-Reply-To: <20261101-maint-page_alloc-update-v1-2-27e8c246b13d@kernel.org>
Message-ID: <2d819627-1f3e-140f-81ba-626d58ff917e@google.com>
References: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org> <20261101-maint-page_alloc-update-v1-2-27e8c246b13d@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 1 Nov 2026, Vlastimil Babka (SUSE) wrote:

> Following David's consolidation of several other MM subcomponents, do
> the same for the slab allocator.
> 
> Rename the section to MEMORY MANAGEMENT - SLAB ALLOCATOR and move it to
> remain in alphabetical order.
> 
> Remove Andrew as M: to signify he's not the primary person for picking
> patches in this subcomponent. get_maintainers will continue CCing him on
> most patches via the catch-all MM entry. David prefers not being added
> for mail volume reasons.
> 
> Indicate the primary integration branch (slab/for-next) in the T: entry.
> It will now be integrrated via the mm/linux integration tree.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: David Rientjes <rientjes@google.com>
