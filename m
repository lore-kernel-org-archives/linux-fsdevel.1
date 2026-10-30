Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362278;
	b=chlXItTWHbWWgz9SzyL8D1ZKF/mAjUXvj6DnVPZx6OdbWUmaHmNL/b97PUJlXqeBCnLX
	 jfR0/YBGB8SbCoNldjLAH3XpP9Au2y+om3DZIHyzIcFUVvURtubb+vDEvuyVJIewgX2vV
	 FTORE+obUy9Wd1TS3ZqQ2KvUpPlf6PAFA+BJ2PAbhmmiNAeGbFuPu8ziMQ1k+96fM0cvs
	 j6Mva+5eC2XcNYWfU1/wf7J8kR14WGr1aLQJnpJqAj98KKS09rjDxfRvQ1ggnYvA4ffQu
	 rsS5Ky2Ctz5asM+9vdmcjzbpTW9FVrclVTjffs1a2eCVYV3HHFltuRYnENNQj1P6QaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=G/h51dJLYeoxkjlU1HlBvF+u6DEcazEkF7G3j/5sadA=;
	b=2ef2oO8G0cqlerZGCqCVqV6GRvicveHQlrfvgPOPHECeiYyaizcXhanmLSZgGL4f2u/7
	 WCjuOqieLv9Od4TGBVGJo0o+u0jEpJS91ZzT+ENRP+gzfljFP59lfTdyAy1WEm+b4BPpe
	 iVSojEEK8MH5PBQBTfzXQmKXmtQpAZuCis4AFpr0MC3NCCep2Z8j+EcUtpheyzc1L91hq
	 o7raRJskwgH+c4q1wGlFidDGfU6HpYi7t6q5eHzth4KZb4zKkC9RRynrHboIRg/IVLkHQ
	 TjWoaXzNFBQ/Bhljqx+5oRSxm0W6mGfetlE91h4+Dnx/A5F1BoHvAIGeFDp+4HlK1iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oA0v8sIN;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBD606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 12:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72CBD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oA0v8sIN
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91b52ba422cso8991626d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793362277; x=1793967077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G/h51dJLYeoxkjlU1HlBvF+u6DEcazEkF7G3j/5sadA=;
        b=oA0v8sINgPPBKIONlsdYbjsJ87rAJ5i6eE5Q3YCIsLvFbiQJhGexz0GbyEDNCCZD6a
         p0MV5c3Uczdjv1XhsiIbQTtQi5Vp2z9yQeVX4ao9fyJVBycBF5kXx6/mTl70TjzMnCok
         G05SbrF0c9k6ZAJLXKzphYMVEDDK1GKw8OzgWBjmFyaaEHgwUvrNLYQr0skqHxH3T6Yc
         OVQx4BFegmIqmLOk6yQ05bXf4dIWwIB1X0cX+CWl48PDaxZ4x/cigd0Ch6rsN8lEPgGi
         dYcgWMLfovRlIlaP8ltfoaB26Jl6NCQ4kppLz5tTRxjKHm2+76osmnaM0MUb41a3+Q82
         f1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362277; x=1793967077;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/h51dJLYeoxkjlU1HlBvF+u6DEcazEkF7G3j/5sadA=;
        b=ChLWPjWjxWWJsohHX+3Df5yzxZLYFz4n1gv5JkhpFIuPNDhCfazC6+W1Zr5U5dsSoW
         8o3hRZYITrJhRKzH67f+xFtPMtMzjhd3AnWjLu9HuJzEUFK+BCTgxSEnLwI0KrC7J+GF
         XkXxOuIi+GLejdYD+15zJDJyZdoqERoazDkl3NecGuuEX9blTNBhunue1bFzLyMfD3aM
         0veXepgximR31zP7slJZ/DFljrwI+Fz5bq1xEHV7g1oodeV7n+3Iebz6Ce9XbpgLh9s+
         MEqTo4nQ0aS6OZY2vVnnYThaAlt3piPRdAczjpb6912VC8mQaFLe7rMiW16XHpYYFO7f
         OPBg==
X-Forwarded-Encrypted: i=1; AKwUvByq8USDrKJ2nBeSlYn/DbEr2KaSjU8kk+svE+sCS02d5gpzr3uwk2BN7xtjpNl0sCC5Uhx3DRY8tV3mpIap@vger.kernel.org
X-Gm-Message-State: AFq9FYJBTfF8eynfjXFjGtAx+duZ4GwGdMbfKcCD4jRktXa2wg5hs4wX
	WAlAC6eMwV/1c+K8bG2pROi0V77gSye0a1t0frOG1jcanit9ZwbEsRd8lKjJ6zQiRzY=
X-Gm-Gg: AYBFou2JXzwj9DTt9bt0N2VeDp2UE5Hz+od0cOrglxcKgk9cIcTO0rDNKFx1BqZEIRr
	uuvA2hAtSjLwMJMXKlqd1Oqz8SUVwh5diXSPd22YUgDkmIgxKPV6s36axNsVQLawe7VlSaWITi3
	4RlMsVP06v55g5Y/GFEHYlBwjZmH2hWL0ONF4MR9uIaKkNGZpCmh55ZyF2c8qQpidKI06yUmKLj
	sIz4IJ5zKXXL/ZVklVwI0brJoRY8eoIOm8JiDNFlEhyA4t0UQ+tlhqFf1ltDzXZWzOxDPsfBKcq
	9nw+yN1RsopJzvtqpyaI5dBB1jjSlqE6ynqiSNYKaCtP35QUhG1rzWPXRdgwbaKev4qsb58jHFc
	Z3naXHJ3PNJ7+22bApXJ2jAho7Mq8xnH414t1Wj6Vy7x5ONzpNUu/qOM6c3CQvPAZvKhN7hGdXi
	QZ5GcqaVC9lnuMsKoyNsD0n7BKv9YAPGOVY5CyFOuxu6ETFyg8p9UpDtT8FvS0Jh6B3yuZLvLbW
	p9byF04VfADGwCTgg1wtCyIifLpU+xUWp3Al9klm4qnCEiWEs/PvsF5qGnZMtng/rZkBTFmhXoG
	Gdw9b1lUCSZY8Qm55qO5QJqwx2du6CLpO3ogEv8iFubmb2Mb9fJ6oG/vnqroXtJwf44lCi8Ebpj
	YlpejWXI7n+XG11HjwTY9rRgUll8UhI10
X-Received: by 2002:ad4:5aa5:0:b0:917:848a:43de with SMTP id 6a1803df08f44-91ca49e9300mr29477496d6.8.1793362277155;
        Fri, 30 Oct 2026 05:11:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca804ee76sm14028506d6.26.2026.10.30.05.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:11:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMlRx-00000000ZRR-0Qze;
	Fri, 30 Oct 2026 09:11:13 -0300
Date: Fri, 30 Oct 2026 09:11:13 -0300
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
Message-ID: <20261030121113.GB3889730@ziepe.ca>
References: <20261026220546.3114241-1-skhawaja@google.com>
 <d4891333-43ea-4d74-9fb9-6ad8dac1a446@kernel.org>
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
In-Reply-To: <d4891333-43ea-4d74-9fb9-6ad8dac1a446@kernel.org>

On Fri, Oct 30, 2026 at 11:20:30AM +0100, David Hildenbrand (Arm) wrote:
> On 10/26/26 23:05, Samiullah Khawaja wrote:
> > This series introduces F_SEAL_PUNCH_HOLE, a new memfd seal that prevents
> > holes from being punched into a shmem or hugetlbfs memfd while leaving
> > the file fully writable.
> > 
> > Background
> > ==========
> > 
> > Drivers such as udmabuf and iommufd (via IOMMU_IOAS_MAP_FILE) use
> > memfd_pin_folios() to pin the folios backing a memfd and hand them to a
> > device for DMA. Pinning keeps those folios allocated, but it does not
> > keep them in the file. If userspace later calls
> > fallocate(FALLOC_FL_PUNCH_HOLE) or madvise(MADV_REMOVE) on the range,
> > the folios are dropped from the page cache while the device continues
> > to use them. The pin holder is never notified, and from that point on
> > the device and the file silently diverge.
> 
> We have the exact same situation when userspace maps anonymous folios into vfio
> and then desides to MADV_DONTNEED the pages. Or any other memory backend that is
> used for such purposes.
> 
> User space must not zap/punch things that might be pinned elsewhere.
> 
> That's not specific to memfd, udmabuf, iommufd or anything else.
> 
> I don't see a reason to make userspace (that should not shoot itself into the
> foot) a kernel feature it must activate itself to not shoot itself into the foot.

The issue is live update doesn't preserve those background punched
folios and now we have created an UAF attack on the kernel across
kexec if you don't do something about it.

There was some notion here that with the right sealing flags we could
tell if everything was 'live update compatible' and then know that
these attacks are impossible.

Jason
