Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224776;
	b=KxaveKgQXCoqekgs9mnKjgmklhYho//fxNlbl/ka9NYB87dcIemxEM8wtjBGi3gFXvuv
	 KSncUXPgXFIc8KKjjev3ispC2z5zg1PjibcjgIQYzCnn5Rm90egcF8XyhTFnVCN2pfmCe
	 2oaxOxVF9e8xmm5E4smQoNPg9fTPa/qDxDOpHKGPgrH6oJKaFd8/aMRXTEqNGcB6EcBiS
	 Uoo982sQdadkvDm5cHDEjKz5DICiAIK7gERicBqjoWM5aq+h/Fp1xpS/R0pPXEEs+rib6
	 fnAtI4EElCmM+G15NP88S2xTrtQ8X2vOgDvzPW7Ra4G7d0j2HvXBfLh6hArMdvOOD+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
	b=0BTRoE4AGUdy8FRtM3To3LHSzJ+9OJ0JpVFYgu3s3LRTuGR7ANhx5N+k6xWMf9BKaiiM
	 VJ4tfJbLAE7Q1u8dg4gNpVi8Zo8xYWT9Rw9SqWxtLAlQpkP7LsyL5lfHFtXbpPTUsG2mg
	 yVAmi+HAyhUfjRViX4lNfM/KTQlQV5RB5ZweK59hEhyIJovb49mc3SLun1ugM/G7Zb9HK
	 CN8KacFsnEQaWJZCArxgYvz/ocezis4Ecb8X2N63CHyWN+VQpftr8kM909QCShxJAdtDx
	 kip8WA7BoQXn1rmpncewq3D+82BlgQk0BoUF802aCV2ZtSymtqngplYlzjTaYFiiZLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=JJljicIu;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935D606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 21:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2935D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=JJljicIu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93ece7a73b9so157219185a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793224775; x=1793829575; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
        b=JJljicIuNc8c1hKynJqXX/VZCOPYs7Y9HJoAynJywjHK2yeTMkC3bqqzE7PEcLPD6A
         4HUuY3A6DGxK7k1KKDC3MjMltOvH2hnz5xHVGlKqKRs2wvllOMfex65kCIfA/Ud5ZuJY
         5CfIY42O8zl11oDwhrhAEk7nqJzdWGVX+xLfyMp3qho/XLR80ZGzg/jLaxW+lirQ+1XX
         0ZSSG6g37QoKqss/2s/69JJbOxfL25oWhGjX4HpEVH8sq12RNIiNqdxzuwAkEH0g/dEW
         gRXP/wSgQ2RAH+S68n6oHVT5kviIDSSPQ6GOz7LUsIw2+RU3+WY/zX965JVoT66OLw+E
         mMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224775; x=1793829575;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
        b=1R5mpyUyUbKGaGuZ4B7FNdkoWIJjZ6RDkrxHNzRGpYgx3k7Y2Ei/cvpdxqGVH9GTfh
         5cK78hyNVN0gWuGlEzwbT5zt6sRWpzeM906JfOLxmec+BYUTj2RE2sOq9LUNmLqcQAaU
         i09I8xWqrE4g8miruIXyP6l7rVykoZ5MB3Wuj+68lWp234DJPbbu1oqb3tuINaAC64ew
         /HKCjGvof/RqO8kIzGwuf6IyB6TWFgPUnEn1XKQQZ+gd10/tmW4GZ3vJ3483rXDf6pu6
         8C1c2ai/fzedSbWahVwM0kP/btgbCvQZolhdgrwN6whq+X3KWS2riF8tbGH1U31cRU3t
         pnjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTURgr/8AtmZLuOrFAFKAB764e2FkoQGp/RJ0PyecP3dr/+qeMSzuy4tDGbdXQ+gXcrrcfMQ2hrwy+iR7H@vger.kernel.org
X-Gm-Message-State: AFq9FYK+K3tL2XT1ssb5UZRjzzKgztr2I+GDHdCr0Xe75/5ntEIWXgHN
	Klbq+eIh8eTYNLS+/hFSlZCLJEgh4kUUKbOHcuCg5JvVztGSZcKNgGekhGgsH9rrmxc=
X-Gm-Gg: AYBFou1pZM63ej3Ms/rjiizhVXKjg7TPAyHCd3Ba8BLAnSLzS8uhLZjKSci3cGy+qS8
	wS7q3H4wqn5REESrOisYJCXd7oFNTrpGhZ6+bNTgamaigmTZoZ5HOaRC22PY+HQ+LWGkBIaSKPc
	DzxuCPKTE6JeF/rHoiLLNVaWmd/hdD4+D2A30Bm1jcGe1Tez85YQNOH28qj20lP5eMdVubvynPO
	M4flxc5JycqXGLhK3vEmCydTK/obMirTWoRXt2DET+J8wgmhP0rLpUZmSiwxUw2MJRB5HFEJiDo
	TeHHgsbh0Gvr7SzCRKPRDwu6uhkI0tXB2/8uxqKaV/RxuAQUbuqNo0Gb1RnyO7OKsRnPPHAcKz1
	xA+nr7qUOrsfbKkmJSHpoHe0M7MqJK2MNO/QNuf7Tbhr5fK6aPE0YlbbZaon7GIUSPDl27w6dlz
	O7UINXPK3kbIHdXpkcybXU3oBSxpJx2rwIgZcjEJwRFa5N/Yvi7sxpsYRAnA97bLcWi8188CNKq
	5pl+/CxnlWdXe7iEcoUeAZVuWmrfouQSHBNxCU3q+UK5SZsk3Q06yNydMaj9gOTihWjeV7+SZAC
	vzV63NBkxfN+Iu7wu5ahCoHtSGVEGVezqJpG3lryjkN8ONE20M/xsfkBwveN+4KbJ45nKIf6AwW
	/
X-Received: by 2002:a05:620a:460f:b0:93e:ce12:aadd with SMTP id af79cd13be357-94408db358bmr587757585a.58.1793224775119;
        Wed, 28 Oct 2026 14:59:35 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078ba99sm1374978985a.32.2026.10.28.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:59:34 -0700 (PDT)
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
Subject: Re: [PATCH 32/46] mm/memory_hotplug: avoid races in
 pfn_to_online_page() with dying pgmap
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 17:59:33 -0400
Message-Id: <179322477323.1935969.10540673116963281867.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> If ZONE_DEVICE memory shares a memory section with ordinary memory, the
> section is online and the pfns of the device are valid.
> pfn_to_online_page() tells them apart by asking get_dev_pagemap() whether
> the pfn belongs to a dev_pagemap.
> 
> get_dev_pagemap() only returns a dev_pagemap whose reference is alive.
> memunmap_pages() kills the reference first, waits until all pages are
> idle, and then removes the memmap. During all that time the function
> finds nothing, and pfn_to_online_page() hands out the struct pages of the
> device as if they were online memory. A pfn walker reads them while they
> are poisoned and freed.
> 
> The entry in pgmap_array is only deleted after the pages have been
> removed. Look at that instead of trying to get a reference.
> 
> This is probably not worth CCing stable.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

More zone device pfn-walk brittleness :\

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

