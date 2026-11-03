Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695539;
	b=s4NNX8VzFgIIRvP3AysnCmu+GBHeUOEwTRdvVw4+Yy24MVuq3N/6m53J1blNggHRyE8a
	 cVHMBhFtWtfU1VINfUUmxFYTQVpCmhlFuHtXSWnSLSaGTLDp5sSPFZ+AjkBujyb4ochVM
	 xKzsRANbYHLFNO5S51iK5pV0HwrZZXcnsaxI8VjBc8Y8+FYD8jO7NbV9SljBi/9IUrv98
	 06sVTye5INK2I6tfGwq9wHu3yVkZzdB9+TxnP9s5dDC43Q5pX+NrbI51Ks9O0/dx/VC2d
	 4d7lPtBlbAdNIh5YQ/k0QWZ3eng7Mi02PEvuinZRQRUtKd2QQ/SiE10Ed7Gu4njoKEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695539;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HTgGh75AKF7JtZw7sCDB/mISauV2EyQCWjbc+0T+Gms=;
	b=jJts6FhafLC+OBw1Zeas/1+GLMzXo024wwYOazVeQmOOiubJY5uSRjBEQWA8dsmXtr2i
	 kDTkhCHbgi9MlnmYphQfTwp1rf2+es24z5uU/fqPg4Rx2/oZ/ISUeffhuev/Fua15ALRo
	 gsHFqwfwsl8MG7OdmIyDb1dNfmS7Xn09BKUn0BMb0UR2RAellgEkDWAz40SaYGWy8bkY1
	 uvtTwIxF9m4ACcQlVRl8J53HaOElJXeTtS4YoLL3lEGRYWq7UJoDzj5zSvay/pUhYCbwO
	 GAqdRsQKGrwnyUuh/XrKqy7ISesHHUmSPCtR145zeG1hc1b9VEI+E3bnQsghNrrIRig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1P+xjqX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A751606A326;
	Tue,  3 Nov 2026 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1P+xjqX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569511F000C1;
	Tue,  3 Nov 2026 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695539;
	bh=HTgGh75AKF7JtZw7sCDB/mISauV2EyQCWjbc+0T+Gms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C1P+xjqXf/TXroGZhiYgYA0PrR6zo+kHIQkXIH4MJ9CRJ9tQyDRQC1xHaxX8NFpub
	 vYu2U7a4xQFnToTkslUPRO2TaaA36eDdyfkYuwLOAMD3GtSxwIY3TpsG+j1NpzweDg
	 t+8dn+tEAT80zamJNPIQ6Wk0TVVxB+hDgkf3VYDyJIz897kEkMjZK1uhSTlZYnVAhb
	 6zqw2u6NYc8zdZ8xIJIHuhMf5OeWcwWPzngaemYDl+vS2F3WW9M/M0LubRBHngAELS
	 WJXeyi/y0DmHjCLe8SPg1HmUXXFTKDQgTd9vkMhFw2jHKfy/huwPappK5UtknXyypP
	 rzqNjMsl3FMLA==
Date: Tue, 3 Nov 2026 08:45:22 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Byungchul Park <byungchul@sk.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Dave Chinner <david@fromorbit.com>, David Rientjes <rientjes@google.com>, 
	Dennis Zhou <dennis@kernel.org>, Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, 
	Hao Li <hao.li@linux.dev>, Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, "Liam R. Howlett" <liam@infradead.org>, 
	Matthew Brost <matthew.brost@intel.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Nhat Pham <nphamcs@gmail.com>, Nick Piggin <npiggin@gmail.com>, 
	Nico Pache <nico.pache@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>, Rakie Kim <rakie.kim@sk.com>, 
	Rik van Riel <riel@surriel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Usama Arif <usama.arif@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, 
	Will Deacon <will@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 2/7] MAINTAINERS: TMPFS (SHMEM FILESYSTEM) updates
Message-ID: <aume40GKpYIoqEkN@gremlin>
References: <20261030-maintainers-v1-0-97278f8a5f54@kernel.org>
 <20261030-maintainers-v1-2-97278f8a5f54@kernel.org>
 <b04d8d01-b42d-d948-b7b8-c360f8ec6002@google.com>
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
In-Reply-To: <b04d8d01-b42d-d948-b7b8-c360f8ec6002@google.com>

On Tue, Nov 03, 2026 at 12:27:22AM -0800, Hugh Dickins wrote:
> Okay: but do keep in mind that tmpfs is a filesystem, and often the
> FS folks make small adjustments to it, which usually go unconflictingly
> through Christian Brauner's tree. That generally works well, so please
> let's keep on working in that way (just once I remember holding off
> intended MM changes to shmem.c for a release, while FS were busy there).

One thing that's useful is keeping certain files in multiple sections at
once - we do this already for some mm/fs boundary stuff and it works well.

That way you can make sure the right people are cc'd on it but not restrict
fs's ability to do what they need also.

--
Cheers, Lorenzo
