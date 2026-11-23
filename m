Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456255;
	b=3u+2o0SWjESn0HqxSdm7FojDNruVRmbC9NqdKUUWZVLxHZdv1+IhCqDcetPd8CP//YF3
	 JJUg9C/IyOEKA7XIoo+Ofm3BjTHwXs1wA7LetyUQNBw1PeT7fy26SNHqgTvjhMKX+DjPl
	 vKNb7UZQfd9BBCkoGWxW1pQMwtQ/5Khh5jm+0kHATB0GdAnjQf56XxvU6uNw4H38LIIvG
	 6t/9Vv6xCP5dkmXjc3vevwUSHk597ldGFbWXVhtKrLqxTAmzNOExI2GAnyXMuF/6iKkqJ
	 PHi1xaj/37TWdHnzKgyQZ1kTW9FKyLOdFpZC3mCGh7H3jioaChAOxo+Q6cIU6pmwN5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ezlDWRMj9kmxxJBJDvLQDaV+rNJm+P/qJAKPI2Vbze4=;
	b=A9/EL44sYXuCT8n0fkIWC7Emv0BjSnoh4ktVpI6H1HAtpGfEZcpxxvyLNTNThlIpP1Tl
	 NnP0pHZCCKeb5IoB77BMY9MQQfQ08uMXL5Z5tC76I85/DOXGV6FSD66+L6jvQG5QOw/Ba
	 1Q4XY4VT88iJoMWNnefDKc7fc7X6QqV3jL209u/tbHLvETiN4zK0TeamfnzB+w9uNqnQM
	 jGOHomtHEETScJZJ3PRtUp7GX8pB2H1yy/ztDMvPZelyES+Zn0fu4hx8pQzqYDET9Ok7W
	 9SBuTmzKiQcDwYui2jTYQY0yxmS7nhz/BOfsrl7yqKs4RpLEr/lTJuztwQgXCBOUovA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BcrioLrM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F28606A32A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F28606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BcrioLrM
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb6860f867so102355e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 09:50:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795456253; cv=none;
        d=google.com; s=arc-20260327;
        b=TABKYwnELePErGv57/JtUOd4bvR/4nwRTZBn2bKa3T7cdau4RbDxKLC7r3JWYVROXC
         zcpAZj9sU7BXawR0mdVcLzhWt7zrha1uqrFlsCtJE/5CidvyanQknQ0fz28939SGY6bU
         bQO0gEcqk35wHLlMt7/UysDLP1bwHtHwKKqMcZzlzlnBTJf7DH6w8fe8R71he5GOc75u
         SO3XEnimBU8Om4/p11NtL85SG19U+z565c5ZBkboF+Ydk0UDI13wjMnWUfSWs+GkL2Dx
         Cyfc04ud3X43Xu3foM94b/JlW8HdZjSLI/pzXjGip9j4vQK5vHwNKxV/mFM6oRlE8DMu
         ke2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ezlDWRMj9kmxxJBJDvLQDaV+rNJm+P/qJAKPI2Vbze4=;
        fh=NoLkdiRnjLAGuDnG93RBeMvq0hWKsgehFAWF8C85GH8=;
        b=FxSgidHAzYE2U4xp39tJj3/pXuyWRyNwNzb+gC9Kl8zd1oPz2blPACPm6wUsY9IORL
         tya/bB1H86U0NFqvYFLlY7DT0wkflXW06srkPmU8+yF+6Yrq314ZHtgIInyBlPJj0kGX
         E1Vtd4oEyeFDwoTwfC5l8TuRyHX8lAvUvzLGHokBawm86u1Pra+mU5XS3kl/PCOlpX6p
         vgcoYuCROseka10wJYpz3HiOn1FnZOKe2Ly7+AnbPDSNG0qrZDHeDkRKF+jwLYSH7La9
         FaxAxGdfXiYDZcZJVn8GUHL25u6F+m5Pb57pOoW9wxtD5+u74NI72MrUbGaRTBFymbwx
         nxog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795456253; x=1796061053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ezlDWRMj9kmxxJBJDvLQDaV+rNJm+P/qJAKPI2Vbze4=;
        b=BcrioLrMpRc3jxnEpQZDLENPPk2F7XpFqHOBmuXqBzc5lqMsLou2gFVIzEsNEro0IO
         mPCO4M/3s90ZJ4jgOLjcckM7u2eMlkxd7o6lgScvYOgO8XTOiV4oPGEY1PdmUkVgq2wg
         T6uaJEljxWvrmad0D4mzeeVIDRap/DTL0Fv/T6HmdZZtl5sk6y37sdUGgaGhx5Now4Em
         bqsqggSmHmIac7uAwISqoYb0yT0ZuHukRVtA9RXQbBQjPFWAl/JVR4ZGgozJ6MZ4UbTL
         DIz3aRiCoaHMVjSH6NVCYY3Xo5xrXFdueOT6L9kT9R1RXs9KPSa8JWsn51H9hrHQqkF0
         0OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456253; x=1796061053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezlDWRMj9kmxxJBJDvLQDaV+rNJm+P/qJAKPI2Vbze4=;
        b=sTv6dSI/8Kjzks/1wt2EbcXHnstgmPxiuboYjrWlCpW/lxS3pxDBPB73mrUybCQE/h
         4TLLfNW52Ru9jBOKx6w01JK4eZRhf2g27H6ceS6QNPhEt1dkWvjs0mOab9/fRNAgXyoW
         +Zjy4mWGx72T/Nyuzt3mMc8J6ztCIi6+so2lJiF6vLUnM8zaJjjgmh4vsAH04xleDyQ0
         l3IVLXJ3Qjn9Reb/mZqB99xOrHoywQjnu08esFPLNnS6IJEVsPTClqxjKUrXelK9InHL
         QyGTESPMSqB6YYm9LbP4WUtJ6NtAjRfCXV6icTI9SBtdrvp/8NdjY/oiTDj9N03QfpAh
         H7pw==
X-Forwarded-Encrypted: i=1; AL+hErFAXtmlnJggNmkGwDKq8zuhOnwzuNXklqzHVqmtXj/eYNfeZMySbrzXNbibURRQgc3F1WPPiHiKEXhco6/3@vger.kernel.org
X-Gm-Message-State: APuU4Z97xXkEPTUCC9Wdv4Bh8JLbu1m44FqOkooFL2pxyYAnp1eKWhDH
	9IQMuXlOpqS9WnlOCiffJsHxHlibWB9TJfWj3ajvnbjxeWfVzNeR4yPDBHGB0paelVt7e28bGkp
	zlXythr0fr7SVDc2zMqnvXO0rq3qgPvXXgMST7qU5
X-Gm-Gg: AZFdTZcbwzJyN+QDwZeNVjS2B2jAubPbMY0IuhbzTAP0K92QMjznqCR1NF25owW+CX6
	1OYGHCFoG6YacsJigtK7jHbBvJ+hpUQ/u+ya0xdksV6A5NpBsdvHg6idkHo/nLsfqIVRX/3kooB
	UUjuVrDxen/mtLU/WalXL8v6T95KlKoQB9oKKUuPxKaX3FDz3w7GvHAfaj4pRya8wdUOf8wRLVv
	sG+paO24yljtwtVTTpsWLZFBU30C5fthR5MZpokaOmyNFXRU5Z5zDHRPGhtamneQuYhj4edCSdS
	N99j84o50eTGHO6WfLOJvjBszs0jGr5Pxwq3ANUAf+yXkaojr9ssEZZf9qPKkaKRvwgM9AFT2NA
	ddPrTlzU3fP6Xv4JQIIdE7lzym5oiLsOwt/o8UoA6XVnEXv2IQckTTql9noaiXRmJlEA=
X-Received: by 2002:a05:600c:287:b0:4a1:e368:cbf7 with SMTP id
 5b1f17b1804b1-4bb909d0619mr1867585e9.0.1795456253076; Mon, 23 Nov 2026
 09:50:53 -0800 (PST)
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
 <20261120135013.GO3115493@ziepe.ca> <CAMOZA0LmZ9PFzxLcc1SuS8piFyZu6P=vX_qR2jy-3QRUoNCUKA@mail.gmail.com>
 <1f10002ea9ee16a17087bd06e4a1685a973fdf6e.camel@linux.ibm.com>
In-Reply-To: <1f10002ea9ee16a17087bd06e4a1685a973fdf6e.camel@linux.ibm.com>
From: Naman Gulati <namangulati@google.com>
Date: Mon, 23 Nov 2026 09:50:40 -0800
X-Gm-Features: Aa3M54qK7IY8ZMBupflhQ8_7jK3YPX7yjpTGqvTp5f5henwr9osR6FHQsicVdiQ
Message-ID: <CAMP57yVZx=s-JXHfQfd_ouv2jV6MMsJXpxVLkQQHG=7qfFVJfA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Luigi Rizzo <lrizzo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
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
	Christoph Hellwig <hch@lst.de>, Dragos Tatulea <dtatulea@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:10=E2=80=AFAM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> On Fri, 2026-11-20 at 15:19 +0100, Luigi Rizzo wrote:
> > On Fri, Nov 20, 2026 at 2:50=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Fri, Nov 20, 2026 at 01:06:30AM +0000, Luigi Rizzo wrote:
> > > > This is v3 of the RFC previously posted as DMA_PMD [0], now renamed=
 PISA
> > > > ("Pre-mapped IOVA Superpage Allocator"). The text below follows
> > > > Documentation/core-api/pisa.rst (patch 25/25), which has the detail=
s.
> > >
> > > I thought the conclusion was to just do this stuff in netdev pagepool=
,
> > > now you come with an enormous AI series spread across the entire
> > > kernel?
> >
> > There were surely comments claiming nothing outside net/ cares or needs=
 this.
> >
> > I respectfully disagree, witness is the fact that e.g. there was alread=
y an
> > io_uring proposal which is smaller, but does not address applications
> > that want to use the standard disk I/O paths (libaio, buffer cache etc)
> >
> > Nothing has changed from the initial series in terms of size, use cases=
 or
> > subsystems involved. Large files are placed where they should,
> > the series covers the same three use cases (disk, network, CoCo), and
> > touches three parts which it has to touch: mm (most of it; it is a
> > memory allocator
> > extension after all), dma (it hooks into map and unmap, not a large cha=
nge)
> > and net (the pagepool change is a couple of lines; the tx path needs to
> > touch more places because the current stack assumes all paths have
> > the same I/O requirements).
> >
> > For CoCo, there are very fine grained controls so the bounce buffers
> > can be enabled only when they don't pose a risk, which in turn
> > depends on the threat model.
> >
> > Specifically, for network tx buffers or disk writes, the user-to-kernel=
 copy
> > is basically a bounce buffer provided it is used correctly and not leak=
ed
> > elsewhere (which is the design; of course the implementation
> > needs to be verified and possibly fixed so that it matches the design).
> >
> > cheers
> > luigi
>
> Hi Luigi, Hi Jason,
>
> I've been lurking but following this series since the start. I am torn.
> On s390 where the IOMMU is always enabled on our closest equivalent to
> bare metal (non paging LPAR hypervisor), and where we also default to
> an emulated IOMMU in KVM guests, the underlying problem is a real pain.
> We're also in the process of enabling large IOMMU mappings via the
> generic_pt API which are 1M and 2G on s390. So, the idea of making
> better use of larger mappings is very attractive to us and I applaud
> you for trying to tackle this very real issue.
>
> That said I do have to agree with the critique. This series is too
> invasive, too unclear in its layering, and most importantly it feels
> like you're trying to do everything in a big swoop ignoring advice from
> the maintainers just because it would limit the scope of a first step.
>
> I also don't think Jason's point is that nothing outside net/ cares, I
> think, it's rather that the IOMMU and DMA layers already offer the
> tools and each subsystem needs to use the right combination for its
> specific requirements. And if a tool is missing this needs to be stated
> very precisely including how the addition keeps layering intact.
>
> I don't claim to have a simple solution to offer, if I did I would have
> sent patches already, but let me state my thoughts. First I think this
> really needs an iterative approach with much smaller self contained
> steps and focus on specific issues. With that, I think this should
> focus on the network stack, while the io_uring specific proposal can go
> after the block layer. Also in my experience networking is where this
> hurts most.
>
> Now, I wonder if we can't start with something simple. What if the page
> pool could start by allocating in batches of PMD sized and aligned
> folios of contiguous pages that can share a single large IOMMU
> translation. The page pool can then still hand out pages from that
> batch without having to do sub-page allocation but would already use
> much fewer IOTLB entries and the locality might even help non IOMMU
> workloads. So, I'd even hope this could be enabled by default and this
> is actually something I don't like about this series, I really don't
> like having a tunable when we know that larger IOMMU mappings are
> strictly better when you have an IOMMU that supports them.
>
> I think that approach would also align with Jason's idea to keep things
> within the network stack and to work with the tools we have until their
> limits become very clear.

Hi Niklas,

I have been working on this idea exactly - extending the network
page-pool with a memory provider that allocates large pages, splitting
them into N smaller pages that all share a single IOMMU entry. I
breifly shared my approach in the v1 PMD series [1]. I'm readying a
short RFC to share shortly, would appreciate your feedback.


[1] https://lore.kernel.org/netdev/CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+=
BJRVYf3JB1g@mail.gmail.com/

>
> Thanks,
> Niklas
> > >
