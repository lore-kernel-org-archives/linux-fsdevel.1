Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373140;
	b=RMtrkMMdK4CSwjGIk6G4pK3tR/KGGg7oEm4PlMHkW95gE0h9rqVdmabbk/pC2s5Jn6NU
	 n4JsuZT8EvLa9HwzoW6k4IFfO6N/ETgwe04aW2HPVqCxoKwwW67YrZKCZYOXxHxgIguJv
	 qvQUtAgIT6B82JLbVrO7oqHzTeOExpn6iBC5r2P0M4Oz5Biy272UAl51FXfT+OK1y8bpy
	 1vXG2oy6fDx5NtVom1tSpe2S01z5nTKsALdypLUiC5Be3WOkgLgLcVTrLzL2O21UmrSmC
	 nHbS8bgcQI+XZ8JP4FQYTiivFbUexEjA3GhpaKdQPKBtALgg71yeSbbw5oJpwVKHGBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=QIe+i9eK2zr3QCsqOe2BUenoQBuWEgVrfsYe7q090kc=;
	b=T1X/MzTmjFzJGxlJuXaFMtW0aOBCN59kcQZjzqkapQyLnKz9QF3k0rMkVOh58GJ+lnkH
	 VfQNcF4B5JNGx56F10X5nfc3RzNwrCL8s2pY7PiKtBsqRkI/x7BPkG6Cqf5AxVqvEHzwo
	 921MfpyNjXAZYcBuzZRwEdgStGcfveNoFXuV9oGKHPjZvJsgx5ELhRv3W9mAQpdjTRj9f
	 lkoPm01sIoEwtBl3ModrSrHIoJcQqg7lspHtfsywKZx3hcJYYfjfIQl6hOGabiZmo2aOy
	 Otosol7KKbAkfLzir8xteXf+zxK7X0goZU3RTJvG6VIv0wuHyn0shvUoCNJ2kwoxlLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="JQJ/bQ7w";
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC59606A333
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 18:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC59606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=JQJ/bQ7w
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-921375f52b8so28593456d6.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 10:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795373139; x=1795977939; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QIe+i9eK2zr3QCsqOe2BUenoQBuWEgVrfsYe7q090kc=;
        b=JQJ/bQ7whZZ8pRH0qgCbemEQuwTE9M2X1Z1KoUUoCoVJ5reyA2kkqKxf+3cETokC0p
         Ve+glie+x+BFdRYbILK+RsZ/Lx/5L7wEth2pt+bNkF63ygZMRs05CP/z0EWXv8fN0qUA
         PTzOjuvpYzhCb8acuKndY+Cf1iGrW7slHR/PRvcYkIizxAYfwQXgkswTsq5iON2SQCdj
         e7ua7Agax+K4/iJijuVu5HPY2W//ItOX2z8fxYx1PXHsWywu3+tgNcLMqIxUTmPx3/5t
         QObcYcgKQY/Tdg0hH/6vUql/AkLfkfXjzquIhKVlZ/3MOWnZdDPQNbZbb4OPnCOF5hOh
         LMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795373139; x=1795977939;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIe+i9eK2zr3QCsqOe2BUenoQBuWEgVrfsYe7q090kc=;
        b=n08flWcxBCt/JH3nQdWQthOXh4vqZR+Cs+aMXNY+I7WRIkNf9UZpXCniOgjgNBzFOm
         W03bu/Z23Zl/bbzPmTj+6gjx0vy1UNO0qlTY8zk7xgYL0nxGkjXI4r6aBWItLZV5xGNe
         DluaPs+UUixrn12wuyuwLk+T9zF9VuO1xqbcyn9wr33xGq+x4mvWpGBl9E2Dtsi8kdNS
         UHy95H0rZ6mMnUlsjvQBLODMsponnoeDeaunoP8Sc/9jqfu12M+QlBsnuWInUc+fn5/p
         ckZGMmMxbPGfLGNqVwgRlf7tf2bDvzCctm2lIF6R87W96+ax2AQxgwnxb6CN9s6zEvoB
         BXnA==
X-Forwarded-Encrypted: i=1; AL+hErFG2+NJ+8870EYXXcN68LqTSmzRB+MeZfHTTTgYXQvk9HkZAJFEIqB5vZYs2SlUgAvXylAYd2iAnLf4IhwT@vger.kernel.org
X-Gm-Message-State: APuU4Z/8NTD/fFOuK3phK7VkFuLgpXkqciQEf5s/4SiCbzKNlCmnNYNN
	jrisSDAELOz2w6hgL0Lgp2KJuQ1dvLPUyQ4QNe2o1d2Ubyo8kG+dsd8KI8ThLSS5rrg=
X-Gm-Gg: AZFdTZct0azbC1OK63NntVCrN8cArdZOuOUamewLTbbNKC631Aq43dPeh2Gw1HC+Wd3
	lKozgaTmTFKgK+or5OiTZi92l8Vj5SOq0pgazs7pd39T1J9fCQDLlGg5wfdI8oYFQjxQYES+kG7
	aneOss6Pt69lwpMfwv/uX5xVwdKpg99qrHuhsrifFiDvVH1v2IV2c8H/YnmdJ0F9DS1O2FBWzrR
	Q2QjnTkXhNg3/0/APcCx4MgA3ELjm4Dk6o2KkKoxkcbWQXv21HAdC6dZLvZAIcamWCSXUiUXzbG
	Rb42JbJXPf4uyxKnZRSERxLg2dcSTX8k3pK8FEVFR+ryjJ7DFnP/QQslFrgYy7BqbpECIX7J6Fa
	iB20Pssy4cLawu8cvQdHvOh01gPb4p/Ygzg238QZPq7fgmE79B+s2qLd91YnVnnYouF9aKuEj0Q
	93FvvTDyEmgaz7Jf2AJJLD7Dg5OUAhB8BWzi2sI4Qy34kdRCDSe75cL3+hwZNXDLPiAd08Uuq5t
	uIrqFH/HWiVZW71cgQJh9QsysENOk6aT+FV2NfVgJbRnV2N2ocn1mYdvxP6VMfCgf5JGQxJs0s1
	hmKpwo/D0vNjPWF8bxefwtyTWo7A08KVMh+bdUdXy7iNtUiqI+A0r8MW5WSnGG2k5Jjy/bvuNqD
	VCVE9Uxg=
X-Received: by 2002:a05:6214:ac3:b0:921:3a0b:673f with SMTP id 6a1803df08f44-9213a0b67admr141234506d6.7.1795373138655;
        Sun, 22 Nov 2026 10:45:38 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cd592sm86571036d6.16.2026.11.22.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:45:38 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
Date: Sun, 22 Nov 2026 13:45:37 -0500
Message-Id: <179537313704.412063.6683001223228002260.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 13:42 +0100, David Hildenbrand (Arm) wrote:
> Various callers (migration, memory-failure, s390_wiggle_split_folio) split
> locked folios without holding a reference on the folio's inode.
> 
> Splitting a file folio might allocate memory for the xarray and call
> filemap_release_folio(). If either ends up in direct reclaim with
> __GFP_FS, reclaim can evict the inode through the dcache shrinker, and
> wait in truncate_inode_pages_final() for the folio that we hold locked:
> 
>     try_split_folio()
>       folio_lock(A)
>       split_folio_to_list(A)
>         xas_split_alloc()
>           try_to_free_pages()
>             super_cache_scan()
>               prune_dcache_sb()
>                 iput_final()
>                   evict()
>                     truncate_inode_pages_final()
>                       folio_lock(A)
> 
> This requires that nothing else holds a reference on the inode, and can
> be triggered most easily with FUSE, which evicts inodes on the last
> reference.
> 
> Further, xas_split_alloc() charges the XArray nodes to the memcg, and on
> cgroup v1, memcg reclaim waits for file folios under writeback if
> __GFP_FS is set. That can deadlock if writeback waits for a folio lock
> that we hold, for example with ext4.
> 
> Let's fix it by splitting folios in a NOFS scope, so callers don't have
> to care. A NOFS scope also covers allocations that filesystems make with
> their own gfp flags, for example in filemap_release_folio().
> 
> On NFS, splitting folios with pending writes or ongoing writes to
> fscache might now fail slightly more often, until these writes have
> completed. On netfs, only folios that are being written to fscache are
> affected. All fairly irrelevant.
> 
> This has medium urgency.
> 
> Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
> Fixes: eef88fe45ac9 ("s390/uv: Split large folios in gmap_make_secure()")
> Fixes: 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reproduced the hang determnistically.
Base deadlocked.
With patch 1: -ENOMEM (safe)
With patch 2: split succeeds

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

