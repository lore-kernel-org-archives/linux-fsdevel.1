Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795184413;
	b=rAtiaNBF8p0wOr7iVh+1BXoK9S/gLP3qM8vCyw4ZA7oGBhRr1ZApxMydV8x1ZO6vkjMT
	 UMZ2wANfuAg73/gJQDKLjFLW6PBu1WrcnlkucBfhivZFAS2UkyqZN1Wzt4R2A66bWfsz5
	 q6bSgNtdQRJXrV03RkivEexU9g/45ugjJZ5Bv9wdNuL4Uk8qeWjC/IwU+hsnlP+kN6XxQ
	 aGuLg8Fbmy+JiIZNwSz8KYYj25J9vYahIl7KXvuFpXajnMYa4900yh1aFSKyjMeRrZf7x
	 e0o4X+wHfB5agwj6WMhIviA26/HfHEpu3tjq6gkuDwmJN9fx61aD1kq4h/GJNK+/WuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
	b=HwxkO52pSdjHSgxJziggZZJpHn2g+Us2rQ6TOlSok0Xpb6/YbRbs79OHnNh4YU0ssWGb
	 hhdgyKKyMMRX9QS3nP/mB1h/zdzLAJ4ovdJxoGcd05tIGlbnSvC04WF170aiE9QTawv3I
	 MoYve3oBEjUhY07opni/kCrDB94f5sGnWYPpA8qwbWy2wOX3L9wN3ici6ZMA/pdTVbKI9
	 thTs2EpRG26zXsTbvoKstYer05uudfdRQnWpVEiPZQNP1gCenxrimH7JoCv+Ofx+kkXzt
	 f8KiEdCfZAVYhdYBG4NRmnqxFLd0RRnehsRdf3UeTSae+IdxH7y7uXwKqFtmyAzsTDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aPrxrTV3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5D606A333
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD5D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aPrxrTV3
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-54492d8a988so289261cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795184412; cv=none;
        d=google.com; s=arc-20260327;
        b=Fs1PKVc0uJRJy4nzyT6G1Xak7QP+mDZNb9vdysrnpGxcV3tklr96MS4cyiRpk6UC+y
         A5dKtmslnXM0Ha9u7l5AGM58aDfYwRO4xxjK04ihUMpTqMrbAXJlBTCak2CtWFP5KHfV
         m5S8se8hep+H2IVMh6NQRzZ+VE9w8tUWdYlWkGEjx2rr7VGEqHLv5ff7rDSx/5mhNBHr
         vtkMViNyeXp8cFTucQJ3ahOyKlo9f+GvbfwZ5aQ+smiAFezihqtUKxY8KxGLX4Z/Y+34
         3RrFbXHxfchwy/Giwjo5Tb+SP3Z/rZl5IpGpjmJw8dt/GiUXv9JTDblu52S/6QtvBcfI
         mw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
        fh=SKNs+NU3hPRdCesvk0Cuh5SXZRMzOGvu4q9xp0dFO/A=;
        b=pLYYlYWaKBs1SSfAWUIS/LOGAx3GavfpuAGaA8NE0cANQ7SLqf3xK8wJluo5yLuvQp
         DqZFwmnMbBIQaTOFEAD5uIQf3xIFlYez+JvnKk11iyEY1FAD5oDICxsZf/EYloz/nVbg
         WfPhwc9jXy7pT2Un47sReE3aFf/k5oACX3sBxaEdYkKswNLy5NykOFm2eYOkLaOSCDYU
         XOntFZTxmaRADU7mVNRz9UivyZigpPSi6WOkD8KmlJom1Ah1rRanbec9sY9yja1Ov0Iu
         3oOYiXDuyLf+CGn0vHmIlLdzDaOZ5bMSqh/eI8XSn1HRcAOtz1dh1vQclB9+Is7mx98f
         3cGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795184412; x=1795789212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
        b=aPrxrTV3tjNKVZRe0o/QZnrHtJ88Cq0pnVQFh7mHgAvBJzDrEJpUWOT7AK49X/t9t1
         p7Vunzt0X2Jci5rymoMAfsIElmpqm511Q1t7p8xn1jTunsDcwP+6GaXxEB2IFTgFyMZ9
         0iof2il/XdRNNVwakcxSw0onlzvNI9i3hcQnJoO5i5GHUKuFzFtrzC3+IMt6INHHgjGk
         xqTd0Wgb4Ec0WCLoQA1db0uoMdVOIYDq9ySwBT+7Mn0wwGKDTjTrt/aa7XbbUc+3QID5
         2e3M416nZRs+/ass9ys+Ro5LBwyHkmnva3YwUsJ7NnD60k9CYZmdfaxSg5dN/4GGjxa8
         eNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184412; x=1795789212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
        b=HGlQzlVvPEGsbqZh2b2cakcT8lgnnyomW6395a8sl+Kii8Lmuxs1XibJH24ocs3nVI
         1rF1wiGfbYz1PCL718e4+Dl2HkgtGXe4QzcA6/Jy3QSo8sTq/8cAyztH8/ks4XP7zvU3
         fb/fV0Xsp/JkXFgLz37+NBBVvL4Kwa3zs7FR1vJI/zI7tdddqvRW/9boZSedQsU6HhYQ
         QbbivqQt9OJPXlfeMW5rLtZj11cx7lfH6iE4AqW1mAa7lc7ejxgKKaZ+BK8/HCMlWeFR
         HgcGyxNd2xDOh2NJTlLdHnkbGbUG6qZHtoomLtTYNvxQh9LsKxqwR8CTIwnPPs43UZ8u
         4dNw==
X-Forwarded-Encrypted: i=1; AL+hErFQVRRcly81qMSm8EMXr3coRBj4fRXUgET7HDGk8xE1Drzsqw6ZvvIMVyYlt3HsKmfLK8C8bjdWTiCVZh9u@vger.kernel.org
X-Gm-Message-State: APuU4Z8/CSS2dtMxPdydlhFzxbw3Vq4vCfzR811h57ra1Ul35sTyAnQA
	9EnvqDXTdJn7auUTR52osDH9aWpuy9RsJB4y5QBn9Fu2+Bg1yIWXE+9KpVgSrGWqFB8puNoQHJf
	bUWW+Ht5rL4QRxVc3UCEfNDaneMR4BP6jccjQCQ1K
X-Gm-Gg: AYBFou2ZUAZFilSP/7ggbTYJl7nJS2J08MN1Hx5PfXN9clFN4d+K+KYtIHO7fsyB274
	FgnXVCwHgTaH8QxQp5QoFiUXZhvkkPIbWsyeJANX1eb6hZWUOlDBb1ykF5/bJdoy5FGMC8qeuzJ
	uqG5Ehzo3wCGmNzvaLmcmfP+UL8nYa/HkA/pumzfEGRrl3Nwi6GYAGvvb1zBNiS7nZmYbF8+7TR
	u5zuKfhA4SXMcPOLUMXe5QBzrXj/w6Ny1TLIjKo7gxo+Xj+Th9rdcziE5U2AplVulFSlX+s++t0
	C1elV8+AVuwzDyZ8/Qbo9ksEgput/umUAPZwjjMcYPYqEwPSmWKcwcm7/26+oHd5uyRA3Lc1aSX
	FOei0Qy28caXZJfX+HWhS1J5awPzGGqM/EFOBew==
X-Received: by 2002:a05:622a:8c8:b0:55b:ce7e:e65 with SMTP id
 d75a77b69052e-55d7a37902amr16973301cf.12.1795184411359; Fri, 20 Nov 2026
 06:20:11 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
 <20261120135013.GO3115493@ziepe.ca>
In-Reply-To: <20261120135013.GO3115493@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 20 Nov 2026 15:19:34 +0100
X-Gm-Features: Aa3M54r79-wonm4abHk_49DjjJPxLMhPkMzG33LcM6yDH6fwirGgzaIY398cqTc
Message-ID: <CAMOZA0LmZ9PFzxLcc1SuS8piFyZu6P=vX_qR2jy-3QRUoNCUKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Dragos Tatulea <dtatulea@nvidia.com>, Naman Gulati <namangulati@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, iommu@lists.linux.dev, 
	netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:50=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Nov 20, 2026 at 01:06:30AM +0000, Luigi Rizzo wrote:
> > This is v3 of the RFC previously posted as DMA_PMD [0], now renamed PIS=
A
> > ("Pre-mapped IOVA Superpage Allocator"). The text below follows
> > Documentation/core-api/pisa.rst (patch 25/25), which has the details.
>
> I thought the conclusion was to just do this stuff in netdev pagepool,
> now you come with an enormous AI series spread across the entire
> kernel?

There were surely comments claiming nothing outside net/ cares or needs thi=
s.

I respectfully disagree, witness is the fact that e.g. there was already an
io_uring proposal which is smaller, but does not address applications
that want to use the standard disk I/O paths (libaio, buffer cache etc)

Nothing has changed from the initial series in terms of size, use cases or
subsystems involved. Large files are placed where they should,
the series covers the same three use cases (disk, network, CoCo), and
touches three parts which it has to touch: mm (most of it; it is a
memory allocator
extension after all), dma (it hooks into map and unmap, not a large change)
and net (the pagepool change is a couple of lines; the tx path needs to
touch more places because the current stack assumes all paths have
the same I/O requirements).

For CoCo, there are very fine grained controls so the bounce buffers
can be enabled only when they don't pose a risk, which in turn
depends on the threat model.

Specifically, for network tx buffers or disk writes, the user-to-kernel cop=
y
is basically a bounce buffer provided it is used correctly and not leaked
elsewhere (which is the design; of course the implementation
needs to be verified and possibly fixed so that it matches the design).

cheers
luigi

> > - Needs bounce buffers: in Confidential Computing VMs, PISA allocators
> >   pre-decrypt 2MB pages in place, avoiding swiotlb bounce-buffer copies=
.
>
> It seems this was ignored too. We want the bounce buffers in CC. They
> serve a security purpose. You cannot loose control of the shared
> memory buffers have have them leak into SKBs, user mappings and so
> on. It is not secure.
>
> I don't see how any of this is valuable or necessary for CC,
> especially when we really don't even expect to have an vIOMMU for CC
> very often..
>
> Jason
