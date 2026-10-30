Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373081;
	b=25K23RlVQSjjmo8VXCXNao1Tpw5i3xAlKljQTkdmMV/xQJq4Wo9tn//jbY9qOQ/gUv4k
	 GIKp+GNTiGZ+IIfwWxEPAcmi3xnxe8Kf113rpSDU4SXq+/G2LWGE1ySq0KY2K6U0nuLcj
	 OOJJzVhCLKKO+Lrhoax3o5A8MZdA0UaGid3FcppAQAog7V9vgQJW8vvdEXxiVv9cMfWHt
	 lLPIlVoj4d/Zi0ooCGY/dmT2ewxuTeLtcOVddtQ60y6uqzwPN3nz4hrYLgPGkrDcF8GWN
	 7VQDftM6JeKOXZXIzHzEkxNt06MZ5WBGy6lHOSyD8P+0q7sGsE4rZFF3Dn/aY+tFZzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SknYW3+pVsCwOENllYU3jowrrCPEotGjBjq9wVk1tW0=;
	b=jkYYjn4/UJHZBknX4VEFqYF9o/4mPoon2aRd7EJ0PqRGSxayVCqrArq1nvdUPnGGYMtn
	 5k3FuCTnwmWv/Xb6sj0iQeky6DeSWj+onpfPLlESPMq46x1mHtu+Ol7mUCqyIgty6GlXm
	 C6Hd8VO7AJyhdkCfKZ529wT2i+XnpoLlWv+l/fHiJhCf94ybM1ulbbySiRMx1oUiqBLKX
	 Xy5LhOYmQyM9jPnGYP3jPmjOpGFklF59hvryaZ0pN3HgB0pSLZSNy9eZf18mEb1wvXJSB
	 d5DyoThuhNyd0l2hyOm6xJ93yRVslr8baXc0kVsI/IKiruV2HDZBWHHQ5Z2+D+hN8mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VAnxgq+X;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E397606A322
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 15:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E397606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VAnxgq+X
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91c8fef5ce2so10281056d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793373079; x=1793977879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SknYW3+pVsCwOENllYU3jowrrCPEotGjBjq9wVk1tW0=;
        b=VAnxgq+X4QCFTDu9AfTIw48AdlrmXvNeSuIaONQhqFkWoVPXZBz84mze+bQQdrgAhR
         Yb1qIjdcTWGrZL1vyxFrdGovjWe0C1rwpn88C7tgXg3BW1x/vT+4lppONNZ8N5T4dIZF
         A86w3AiVzzJlHYHoWjb+ZBekF/EkxgqB5kFZzSlRgpVyxvegFwpmbFlwECZi5LehdbEw
         fPlvuM+bv9BCs3E+qbixvAbLVr2hTUtX7fpfDGGuE5hdiG5M5JPOPvHVD91ix6/f0At2
         dnlRKLnPnupUvjaDpJdUG/mHdwTGSxDI+PfrEZRHaKDbgB1fY52C8lRrarj8WAIdi77C
         HTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793373079; x=1793977879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SknYW3+pVsCwOENllYU3jowrrCPEotGjBjq9wVk1tW0=;
        b=IGNEkC6h0mqYeK0mAqO0kTtBkrCypPHZWHCKgzESbRgUfWSDpIt8nT2W8ryyfQBDYp
         AqDF+XlAnOpcZyvyZxVtvjA9/CmAWm4EPNnHf3NFRz90kkPBd4IyeOzFuIlC0tz/jdWg
         6OOX6QpIKXfJK9TMyKVJnbeJZqD9Su9oh47Q+kz3UbZcNBYleWb0Op4MaFF9AEzTqEyK
         3Xjp2CDZMUYapX/4pk5kCvZkZbZ3VWnwy6FrLNU4ELhx83o34IDMJy8HFWL4iSQL9Lw3
         XwwkQu8lqFGxtaMjOSf/H94VwUukX2qSlJRjh8NjYo9p9LitKhfJYEF7u/xYlsRyoj6m
         fBng==
X-Forwarded-Encrypted: i=1; AKwUvBzvTPQpSy79ZCbw8jklVxbTN9YFstapenViumO8bBsSPQOh8j+jRcsky+I7cSaQRIvD/jg7PBqlwXnePDkA@vger.kernel.org
X-Gm-Message-State: AFq9FYIuBHJm/ml4AzLxbIHCI7A4OIS5YXd2jkTaKD8BFWhE/nEXxyKO
	rjyne5e3GHuLlVLmiBvpoSPgT/YHirYqb94mkr5fFUbsuk3kmnqekKrX2Ut0W4mTdLQ=
X-Gm-Gg: AYBFou2hN7iM+cweudtAUbdRkZVePsYcM3RmukGNFfqiXIndn/gnAebUe7gCikQmbOi
	654tpBC8aJoiZD59CWJEMP6r8bMw6TtNaF6Un1fHzcPDlhqHvngxyGWCRziuf/e2l3vY2lQ8JDA
	OKULn0IzKKVjTeLNoNzOk4yYi5/+rtS5BGSumECJ2zoq4Go9GiFlZ9/0kDTCFiqjhB/DYQgbmrh
	YQf0FD9b8O1HSgZ7L3leIcCGFx4EsxSntYYhEZAqhQAJD80niXFLrY/Zrz/kQW79wYxFCbIoezP
	dA6TKoRTuf0X1FowQpkBVALmOq6cRNHJTXqRXtBp9/hzJwJk+sowbrvjrllCfeXVqnmzf/i6keO
	7hZD9tf+ZYsKwCH34mIhpXNceNmZ+h2FzAIY667p6a0a0skqaFtn3PWV9XyLnGMBbcy3oQktdvt
	aU4EdOQisUP6vrKFqzdzosd+UbvMzcq1wGMaMpyzlbyoCLCcuoCR0jU+FafmY92JVCNdpyMlG6X
	vpbyyK1ne1i28qyPplVLQiPofUIutlH4xi8ugWRggv8zbNrQg0udURpW4eODXncVf8J8MQuVXIz
	fsNqryrut0zoZkX8NIfPT2f2z47cfFg3pomP2O+TVQz7dO3QHqzvedbKqtxwI/qpNs9xg/Hn9YK
	riaNZJjh4XYg=
X-Received: by 2002:a05:6214:29ec:b0:91c:5fc4:ec2f with SMTP id 6a1803df08f44-91ca4b0dc32mr40691666d6.26.1793373079235;
        Fri, 30 Oct 2026 08:11:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca807047bsm17117606d6.39.2026.10.30.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:11:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMoGB-00000000v1Y-0kVg;
	Fri, 30 Oct 2026 12:11:15 -0300
Date: Fri, 30 Oct 2026 12:11:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
Message-ID: <20261030151115.GD3889730@ziepe.ca>
References: <20261026220546.3114241-1-skhawaja@google.com>
 <d4891333-43ea-4d74-9fb9-6ad8dac1a446@kernel.org>
 <20261030121113.GB3889730@ziepe.ca>
 <2c7aa5c1-3af3-4654-b244-1257d05c9d45@kernel.org>
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
In-Reply-To: <2c7aa5c1-3af3-4654-b244-1257d05c9d45@kernel.org>

On Fri, Oct 30, 2026 at 03:39:40PM +0100, David Hildenbrand (Arm) wrote:

> >> I don't see a reason to make userspace (that should not shoot itself into the
> >> foot) a kernel feature it must activate itself to not shoot itself into the foot.
> > 
> > The issue is live update doesn't preserve those background punched
> > folios and now we have created an UAF attack on the kernel across
> > kexec if you don't do something about it.
> > 
> > There was some notion here that with the right sealing flags we could
> > tell if everything was 'live update compatible' and then know that
> > these attacks are impossible.
> Just remember that there was any hole punch and refuse to live update this instance.
> 
> We could likely implement "we saw hole punch on a pinned folio" as well, but I
> don't think that's required initially.
> 
> No need for more shaky seals.

Ah, yeah that might work out. It has to be checked really late though,
after userspace cannot change the memfd any further.

Jason
