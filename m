Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723044;
	b=z94vvsVMva5I/OdTiQUG7g/Gz/ir4luUKmV3NKCxmTc8zUBzL/r5UjGCCFmB9LHVYQtE
	 +I+p5fZX7niIwkSdEYqKvqq5wCNZn16AvyfuFZBa07Scx1T2ZEdHMANIL0gJjij89uoRv
	 f+i7jLQDrYL2LhLlqLqKr0b0s+F9H0f5c6ij3Nam1NutWdMfWOi9q6HwA3cfCikYMZ+uk
	 FJLKkSGl7yvNtyVylfSI6nIqkcNSn6pR6Po6hpAxYwbpdN5WYygQAx9+Ms2By0gC6BYc8
	 zUIk9sz01WAlqKU+wew/NHqNZx9UwrmFZ/iCu/33vT1Ij3IOcfTeFTjgKtZuQDDzC/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723044;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=4r3GXE7D/VKsxdrJGYislD9zQL6xUFs08TL6iBbCuDM=;
	b=D0uRFhO6ZNppCD7UjAbhIMyuMGzNM2x/MnjvS8VUHdEFPvg9FK+NDv770Z9dDFsvE3Wl
	 3uWC1B+YM0VS3eulzbtshZMPVTRS2SErTV+7IjHsoRB5xIhwF9ZEvv8hbyHoOxY0Waf49
	 grOiy6IigjUMmWs3WsPS6tIQLWMvca/mrP7ZW4aW+FqHc3i0XyMkzMuLWHTZ4Y5ECvPoz
	 Rcv9EUKCDldDPeJpMbn4xz/8OCDo7y4CyfO0yaj0jImLnNhFey8IC+VZ4YEIouOLCEWMm
	 1PYr/1WJl+VFoctIj0KuchjoxTfVVf01+G+HdDZfVOdgbWtcBZ4urHyKywg+z+/x3fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZlR1E54;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591E606A324;
	Tue,  3 Nov 2026 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZlR1E54
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF38C1F00919;
	Tue,  3 Nov 2026 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723043;
	bh=4r3GXE7D/VKsxdrJGYislD9zQL6xUFs08TL6iBbCuDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aZlR1E54tj2woQj3u+lfcauS14uPIk5Y4waaTpwy/h5JtRIw0M8zyPKu2+XCopiVW
	 FWKAPPbZfynqufPMwVIYF/JwMsZiNRrXdELsOBouaU+n24Bl9xkfzpX5aHDIXcOQfC
	 DWGUfY77RnkwdaS4kRZjR/+27KxjBFeF8JBZVnA2Ph6e08xVOf0D10cGircBXwpWy6
	 dD7NH/UqSVVOmma3z44OCdeji4ZBF6hyB0WruIuto78ghdjjTgKe14AlFo6VoGIlPR
	 4i3gVVexpORJHU0i00/lkIiLWdhtGKnSgahrixF6rWi3Dm3cfQBkh02D6gp8p3umB6
	 sMKi7fCProX2Q==
Message-ID: <c301fb04-1144-4ec9-a41e-3c98fb569e0b@kernel.org>
Date: Tue, 3 Nov 2026 17:23:40 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] MAINTAINERS: TMPFS (SHMEM FILESYSTEM) updates
To: Hugh Dickins <hughd@google.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Byungchul Park <byungchul@sk.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, Dave Chinner <david@fromorbit.com>,
 David Rientjes <rientjes@google.com>, Dennis Zhou <dennis@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>,
 Hao Li <hao.li@linux.dev>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 John Hubbard <jhubbard@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
 Nick Piggin <npiggin@gmail.com>, Nico Pache <nico.pache@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Pedro Falcato <pfalcato@suse.de>,
 Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Qi Zheng <qi.zheng@linux.dev>, Rakie Kim <rakie.kim@sk.com>,
 Rik van Riel <riel@surriel.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Usama Arif <usama.arif@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
 Xu Xin <xu.xin@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>,
 Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Manfred Spraul <manfred@colorfullife.com>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261030-maintainers-v1-0-97278f8a5f54@kernel.org>
 <20261030-maintainers-v1-2-97278f8a5f54@kernel.org>
 <b04d8d01-b42d-d948-b7b8-c360f8ec6002@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <b04d8d01-b42d-d948-b7b8-c360f8ec6002@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 09:27, Hugh Dickins wrote:
> On Fri, 30 Oct 2026, David Hildenbrand (Arm) wrote:
> 
>> I am not really the best shmem/tmpfs/memfd expert around, but it should
>> be good enough to judge when something is ready to be picked up, to then
>> pick it up. I'll have to heavily rely on Hugh and Baolin on judgment
>> for the more involved and more controversial bits.
>>
>> Rename "TMPFS (SHMEM FILESYSTEM)" to "MEMORY MANAGEMENT - SHARED MEMORY
>> (SHMEM/TMPFS/MEMFD)" and move it accordingly. Add myself as a MAINTAINER
>> so people know whom to CC.
> 
> Thank you for taking this on, David. And thank you of course to the
> unlisted Andrew Morton, who has been uncomplainingly filling in for
> me year after year; and thank you to Baolin too.
> 

Hi!

> "SHARED MEMORY": should ipc/shm.c be added to our list of files below,
> as mm/memfd.c is? (Though both can also go off to hugetlbfs instead.)
> Or do you prefer to regard ipc/shm.c more as a client of mm/shmem.c,
> rather as drivers/gpu/drm is?

I would consider it more of a client indeed. memfd started out as a client as
well, but things escalated a bit ... :)

I see that Andrew is assigning it its own section, is that good enough for you?

> 
> We don't often have to touch ipc/shm.c, and generally ipc/ is well cared
> for by Manfred Spraul (but I couldn't see a block in MAINTAINERS for it).

Agreed!

> 
>>
>> Add mm/core.git as the target git tree. Once shmem becomes a high volume
>> component we can dedicate it a separate tree and have dedicated people
>> pick it up.
> 
> Okay: but do keep in mind that tmpfs is a filesystem, and often the
> FS folks make small adjustments to it, which usually go unconflictingly
> through Christian Brauner's tree. 

Yeah, I think that's just fine and expected. I know Christian, so that's easily
dealt with off-list.

Thanks for the heads-up!

> That generally works well, so please
> let's keep on working in that way (just once I remember holding off
> intended MM changes to shmem.c for a release, while FS were busy there).

Jup!

> 
>>
>> While at it, add some more shmem/tmpfs/memfd related files+directories
>> we missed so far.
>>
>> There is also "kernel/pid_sysctl.h", which includes some of the pid
>> namespaced sysctl vm.memfd_noexec. But that's really more of a proc/
>> namespace thingy, so it's not a good fit here.
> 
> Agreed: if I ever heard of it, I soon forgot.
> 
>>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Acked-by: Hugh Dickins <hughd@google.com>

Thanks Hugh!

-- 
Cheers,

David
