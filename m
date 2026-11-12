Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509135;
	b=xWZR41ewLilerXJFTuHPlcBjKh2P7KOuwFIfawKCqTndBAYcRF+/tmQ2yhaUCYqJ+1c2
	 6WV15+VYroVWMAhmb4IOLhudW8XrUW1oAi8M9j5R/T1uZyKoF+9IdvaYHrQspBfTNP11r
	 4zeFn4SC8xuvjPlGe19ONPN4DPVyu8dv2y6dAre1eykwl8n4mcwoKBBiLeZHR+p/hTaaE
	 dXPxpzRRKV0d0tzllAhqqS4sBbmthcqq4YRV8TJjoAEUAuAWV2o4t0r9sWogBhcAb9bLF
	 JuwSjXU+bC6zLU6EX2crak9ua4BoaahLQav220CrthkieHAEo5zVUUNDnhStV6TupOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509135;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1QMrnQVo4O5SnIGabJN3wrTnW6MusZ0h5giYV4GIf1o=;
	b=n2RrhcIM1b+bN/r7scmG1JXgz0qe0bB08JeYCsIP/hhYngMY5eyg5+Tyx3Nr8VvKXi/J
	 0gn17o6kOMEhq3zyTsVH2QbK9co1MsDv5xEMvF5XvKp2I8X7jzcOsTmIe9ajmsvRXYEBZ
	 6YnyJS5Ard1Z+NnSCxxBPgpLAfF3La7hlqM7IqsiAukKArnVnC1A75P2DbSCJ8YEAiiOG
	 X3ZluiXVIY7HqXIvLFfi5+qw8MpUpN30vPCT51yAS8Ku+Yy0OMzTabY9HR8rsctDDUelK
	 QLf3b1W7eTbS7Fv1HPxTbZn+7jh9BoN5LQo4zFuUvz2SW/WBQDkzleUcPWKBvF0ShOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHTOA7me;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72629606A327;
	Thu, 12 Nov 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHTOA7me
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E451F000C4;
	Thu, 12 Nov 2026 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509135;
	bh=1QMrnQVo4O5SnIGabJN3wrTnW6MusZ0h5giYV4GIf1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IHTOA7mej2k1aqlGQe0o2vMpa5Gw7UtlZwRhFQLZhUTCPvjZO46VWVXtxm6J6aWPb
	 3DA2ss0NGpmaXuWwx3qDKIjM/7mIIpHQUFiHQ7rul2sbAYCgDUI/bRmUDwuzf6EvuP
	 9APyFHKZhwk3J4J7QsFpl5djiJQLpgor+vvJZ35Xmo8RtVotrYFuFGP8WmlO7kgFsU
	 8X4wJpKybcr5WqKLmdjUpPSVvmZv4My+ZLM1BpHQEc0/E/ehaBGmkKGVt/Vt1V711D
	 /4XVd6l+Os/5iSG4YtWxiiYY5FJ7ra3yGPlaTOAxvcFVzd0T1aJKMtBVEoGPFQqmlU
	 d2sk8BPTykwBQ==
Date: Thu, 12 Nov 2026 18:45:23 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 13/13] percpu: queue the balance work on an unbound
 workqueue
Message-ID: <avYJKR8fiETjd9sy@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-13-3d2454362e8d@kernel.org>
 <179450887590.482102.12180028123925629664.b4-reply@b4>
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
In-Reply-To: <179450887590.482102.12180028123925629664.b4-reply@b4>

On Thu, Nov 12, 2026 at 01:41:15PM -0500, Gregory Price (Meta) wrote:
> On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> > From: Chris Mason <mason@kernel.org>
> >
> > A burst of small atomic per-CPU allocations can fail with -ENOMEM while the
> > machine has free memory and idle CPUs, as atomic per-CPU allocations are
> > only served from pages that are already populated, and those can be used up
> > before a worker gets to populate more.
> >
> > Consider:
> >
> >     caller on CPU 1                     kworker bound to CPU 1
> >     ===============                     ======================
> >     allocates 8 bytes, which leaves
> >     one empty page and 4088 bytes
> >       schedule_work()                   woken, waits for CPU 1
> >     allocates 8 bytes, 1023 times
> >     next allocation: "no space left"
> >     gives up CPU 1                      populates pages
> >
> > The allocator keeps a few empty populated pages in reserve, and the work
> > item pcpu_balance_work refills them.
> >
> > pcpu_alloc_noprof() queues the work item using schedule_work(), so only a
> > worker bound to the CPU of the caller can run the work item.
> >
> > The issue is that the caller keeps that CPU - a task keeps it for the rest
> > of its time slice, and a softirq keeps it until the softirq ends.
> >
> > In that time the caller can use up the reserve, resulting in an atomic
> > per-CPU allocation failing.
> >
> > Fix the issue by queueing the work item on an unbound workqueue so that
> > another CPU can populate pages while the caller keeps allocating.
> >
> > Fixes: 1a4d76076cda ("percpu: implement asynchronous chunk population")
> > Signed-off-by: Chris Mason <mason@kernel.org>
> > [ ljs: tweaked commit message, comment ]
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Reproduced with a cpu hammering atomic percpu allocations with preempt
> disabled. Results are pretty cool.
>
> In about 1 second of hammering allocations with the full 13 patch series:
>
>                         Base       Patch
> Successful Allocs      1,188      131,072
> Failed allocs          4,097         0
> balance worker runs      0          169
> successful retries       0         4,096
>
> Micro-bench obviously, but pretty stark difference.
>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

Thanks, that's great!

I will include that in commit msg on respin.

>
> --
> ~Gregory
>

--
Cheers, Lorenzo
