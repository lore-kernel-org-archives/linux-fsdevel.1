Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182618;
	b=rj7KVoW59SbRKEwUmuq3TDGW4wQaxVvyisnRH6RZ27jsf0lKuRt49goi1adWr/xaKq8z
	 r8kFk7blWUAA6VGIZUjhC5Q6q4cjvPKbNSoqwpTwRsW6XaxemPBUuvjN9SruaoVU2pijO
	 tGP5+0KJfcF3OLekm+N/IpIyYKk+3AoxkJ9zNoLZ+ZYWmXKI+o260n7QdoQnBrTDQOCo0
	 nfdNqtJpFF0s8LLQzWZeyGk+5xDD4fTgJiixkRcZPqdfolOF1lNrPG+CJaIjnk6gbeEOf
	 VuSECQrGuO6pRI9E/Ib+jzA6X7fK/HP+Ks2N2H6mqzg6cdBbD6ycgzZSv7iMsC8wkFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uU+g78pFe3woDmujMNPfhZ/0Qi8mHsxDvK4Ws3nTpkw=;
	b=Dz187h/AhmT/5vbciIlXm32fsL2Nc/t55wJHvXqHz2k5fBSIt26QhQg15Mvw2w84X7BN
	 6yyTVJ1FLB0Wr0aIJVFqSYBASXx+lyjJGYywsvA3cCXk18LUtQc4w5zmhgbVbfnuwuiSW
	 UtCarN4Clm3+xZQn5bImcNsptMNeHFQXyXsFt6a/E/mBxXm8OFTX0bSz8/+IiKVQm35+t
	 prdJlrBPF/Wg4a2d03O5e8VMBY+uS7Ahoy4dMO2OchO7jHAXlTH4fmKcdZ58pjNRaHg0V
	 qT9n/Mv+WLCTjQo4h2j4JF3OOSdYNIL6ey/kYe2/rp/P2liRSXEBjVFK0bQusxNeulA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ehz6mMEB;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2F606A333
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 13:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DC2F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ehz6mMEB
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-92123f02faeso5824456d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 05:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795182616; x=1795787416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uU+g78pFe3woDmujMNPfhZ/0Qi8mHsxDvK4Ws3nTpkw=;
        b=ehz6mMEBp7FU9O4IkG6ucYOPrN/2FptPlSVzAMegQhkSAM21Hz39XQX76haUWfk977
         A2S7LqWAyzQ/MMpQcJ9hlw5/i8t5QmFoKEbwfS2++6OthszxDFhEwhu48SFckK+V0pvW
         ZrB7pLti4QW/zlyDdG0NHqvUQqc55WcUlTDasvdx4/7cbllh7O44dOopIvf3GjZWbJGD
         Hp2pPFYqt09CILTVYoO85olovSxlw20uhMs3fEFAaJjWsbuz4Ruyjz74FAK8xTbPsjJm
         YNZjjLR6Muw2SduJu6y83jD/L3yp3ZXbUhG9xHOIQjqowZufFq2KjlStO23Q1v2+do05
         Ehqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182616; x=1795787416;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uU+g78pFe3woDmujMNPfhZ/0Qi8mHsxDvK4Ws3nTpkw=;
        b=XmWcBmmYVq77biLZ4cUtmnVEHNtfwvGcX9rbYKV/998gADuJV0EqhLeh5psr/mByG1
         h0CCaRz7ks+iJLTOmX59F+KBV92s8XrwVqPyqMOomG2wG46aA97eiXGyY51qwplue556
         QZgBk5pZSKiRljx6fxOQQyjGQAJwNNydB3gN6Up4meQjmhC8wfHV7O9irDLA7pbmRhGP
         trh0Mh+us48hT1EM12PGiRY3xglad1+DUsw2usD2ZWgD8YEkoKlYdgBQamy3ofdRFxGT
         iphd9xeR0e2aLagJGBFs0EBsTIfVpDlTKRiG+bPQJaFTeOabxj6AtUA1JkY2pkZf3JRl
         zGog==
X-Forwarded-Encrypted: i=1; AL+hErFWyEA4GEkggD+sgH3GKS0DqO10tiavc09Xk/Sd7O8NInaj+EcW4eoklrX700gHcIexZsc6c50zE94MP1ZR@vger.kernel.org
X-Gm-Message-State: APuU4Z/JMrLhXrVQGcpqF6HKQQSXrRyIcKe3I6bl41JUsfsSNueX0l2p
	4rjxfnrGyFLV64yFOCiJ9VAzEDeT4vdhIBsqmuLUePN3WG3GUYYplRCf+vxHo/bt1Tk=
X-Gm-Gg: AYBFou3fOxKXXI7gBIB3xOFjY00WCz9Ng8zO49HsIJFWIbOaIgl3Nx9iLxGW51Jyf/i
	F0AJvw0YSPz720TMpMWXmrgAU1acGpzIcCQsxUxsWag7Jz+FEriSCYFg73iPQAdIOFT3tUDkGK0
	iflcacesiqHuYfhobFiPn2ZS2pN2dX634m6aCcFdaI048WjqSGGYkvBdw8k5XPdi/Vdn5NHzvNS
	poXB3F0oPg38DGR6Gc8SpRcQ41lw0et9PZQ7PrtEgHEO6JIB3h3vvmI8Fv7duzR6JLYXFGx57O+
	IHcNDqqgdmwww8pq7lPpkZYW8Pl03YLZgYP6oBQb/JNzNNprkqCehbIVFV2O+m7+cQzOmkmq6WD
	/9X34IeudtGLEtzVkc+KHCLPx+j81qkqTFKWzPSEiKJBWfKZwbXDj4w4duna2VbR2fHK2uoyb+M
	XMauyjkjWLin6BYrEO0D93c1vAVL+E/yvnhiWBV6IJ0kPOJN9sSDxXCCxdqs3+52yNwzgL6QNt/
	gB+N9f7kd/BZkZU7yC+OBAv0ca/82/gBNZgwUaEbI+8WJjXn5hQPI6HQKnxyDKl/6IyqZlgCDQ5
	K7+1dA==
X-Received: by 2002:a05:620a:4111:b0:939:5cd5:e243 with SMTP id af79cd13be357-949ba80f8acmr491343985a.6.1795182615989;
        Fri, 20 Nov 2026 05:50:15 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f7cf3sm190597085a.31.2026.11.20.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:50:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUP0H-00000003hHG-3ovL;
	Fri, 20 Nov 2026 09:50:13 -0400
Date: Fri, 20 Nov 2026 09:50:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luigi Rizzo <rizzo.unipi@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Naman Gulati <namangulati@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
Message-ID: <20261120135013.GO3115493@ziepe.ca>
References: <20261109182533.3594984-1-lrizzo@google.com>
 <20261120010655.467825-1-lrizzo@google.com>
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
In-Reply-To: <20261120010655.467825-1-lrizzo@google.com>

On Fri, Nov 20, 2026 at 01:06:30AM +0000, Luigi Rizzo wrote:
> This is v3 of the RFC previously posted as DMA_PMD [0], now renamed PISA
> ("Pre-mapped IOVA Superpage Allocator"). The text below follows
> Documentation/core-api/pisa.rst (patch 25/25), which has the details.

I thought the conclusion was to just do this stuff in netdev pagepool,
now you come with an enormous AI series spread across the entire
kernel?

> - Needs bounce buffers: in Confidential Computing VMs, PISA allocators
>   pre-decrypt 2MB pages in place, avoiding swiotlb bounce-buffer copies.

It seems this was ignored too. We want the bounce buffers in CC. They
serve a security purpose. You cannot loose control of the shared
memory buffers have have them leak into SKBs, user mappings and so
on. It is not secure.

I don't see how any of this is valuable or necessary for CC,
especially when we really don't even expect to have an vIOMMU for CC
very often..

Jason
