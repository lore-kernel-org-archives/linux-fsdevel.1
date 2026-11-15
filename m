Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746474;
	b=VF21v5JH+MkH3wD4HhcJc9Eo1I3rr1uHV47ur1LhD39ClRAs2PLZJtrUUpYcr+UTqtgY
	 vFMqspM48qCetWrEyso7rhavXjQbAxPfW+Hre5kqwloZF9wwHUVKE1WVwzvXw/ODkPyI4
	 odSDMe70bCt806IwQZN0ZqWFD6Zu0qbgFD+Bi5nRHqOfwtSNRsj+kG4geFSYJKJRV91wd
	 rgJGWTSEdhCLqgPXXloBFbVP6lMBRD7Mwh48B1obeTe3xzgYXg41b1XrMnY9Lke34Zra/
	 IuPXznEN0kdPjRd1dKDJTDDDKqdTDJjUmMZHBOejuWoI0QwAZ8B/czoEhYF398CPR+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746474;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NXtroqdbZDSUMhOwEwsYTqFg91OmWZQCdis4JspG184=;
	b=ZLagVcRPJuzw9x4640Cd2LE3dxgYnTOjjj4QFfcNSdX8CD2HWPgJOY4Tg+EcTXuC7SQK
	 YzrcaTqSzUj7ypKXqTzn8tdjOMCnbXB0jCj+MGrh7qPaz2ePbgBW6APfzExpRJ1Sj3HYR
	 n0tpb5KtgnYLc4V53wXq/uD5EMlehdoM+eYJ4V8UE7Nv57jE+rhd79C+g6JH4U/qIyzA4
	 4MCKtoSgb+46wkBEzm1NTKIo83wqmKowkMl/FsVERdEiIJdJWrdz0XAOn4ZVz0/X3ujvV
	 Dmguij6sss3w8AiGWzlB1zPhAvEEubhfNt33M//bvnRNb0bzyNJebc/dpLrjYo3xVRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K/OCxnlp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8B606A31D;
	Sun, 15 Nov 2026 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/OCxnlp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF911F000C4;
	Sun, 15 Nov 2026 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794746473;
	bh=NXtroqdbZDSUMhOwEwsYTqFg91OmWZQCdis4JspG184=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K/OCxnlpA7BjbTwl4rQMyhh/7Mi5ySWd2222bSJjRsGsi0Cy69Rf/KEYVHtPWDkJI
	 Pj2ZKHe3mbI8oauzlpf7zu+TwoC5I3XGaeE8JymmiRptIwSwJTpI+SdX/qR9wmHokE
	 tHxKiqIh1LSylq+IGXKkUSjmnZARLD1t/LpSjuANsVsdq2I7m/phddbYvH5lYzpdtQ
	 YDMxXusO7zfwtVGJMHEwpeY5xQWDVlxcefsZ8XthbdmH8x1Tp4btA4IleG8dhTjyto
	 BNhHHjmmoBdYbuFGy6jd4t+rWekKnCOGKVQfVlU2RNo3VJI6pmZ3jHPVVdKIauW6XU
	 8t9MbfxS74Img==
Date: Sun, 15 Nov 2026 12:41:02 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 13/13] percpu: queue the balance work on an unbound
 workqueue
Message-ID: <avmn3pzKWeKXCCZ7@gremlin>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-13-50a2ed382b61@kernel.org>
 <avjn4xuxUmtTfMWu@parvat>
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
In-Reply-To: <avjn4xuxUmtTfMWu@parvat>

On Sun, Nov 15, 2026 at 10:07:15AM +1100, Balbir Singh wrote:
> On Fri, Nov 13, 2026 at 09:45:31PM +0000, Lorenzo Stoakes (ARM) wrote:
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
> > Gregory Price hammered atomic per-CPU allocations from one CPU with
> > preemption disabled for about a second, with and without this series:
> >
> >                            Before     After
> >     Successful allocs       1,188   131,072
> >     Failed allocs           4,097         0
> >     Balance worker runs         0       169
> >     Successful retries          0     4,096
> >
> > Fixes: 1a4d76076cda ("percpu: implement asynchronous chunk population")
> > Signed-off-by: Chris Mason <mason@kernel.org>
> > [ ljs: tweaked commit message, comment ]
> > Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> > Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/percpu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index f87813e6ad73..39cba1710383 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -200,8 +200,9 @@ static bool pcpu_atomic_alloc_failed;
> >
> >  static void pcpu_schedule_balance_work(void)
> >  {
> > +	/* Unbound, so another CPU can populate pgs if caller keeps this one. */
> >  	if (pcpu_async_enabled)
> > -		schedule_work(&pcpu_balance_work);
> > +		queue_work(system_dfl_wq, &pcpu_balance_work);
> >  }
> >
>
> Can this run havoc on otherwise idle systems? Why not choose a workqueue

I don't think so - this doesn't change when or how often the work is
queued, just _where_ it can run and it only happens when the allocator dips
below the empty page low watermark, an atomic alloc fails or there's
something to reclaim.

Also unbound workqueues default to cache-local affinity, and obey the
unbound cpumask so stays off isolated cores. So that's actually rather an
improvement on happening to run on whichever core allocated :)


> with WQ_POWER_EFFICIENT, which becomes unbound when nohz_full is
> enabled? I guess it still leaves open the case when nohz_full is not
> enabled and we get a burst of atomic allocations?

Yeah exactly. We'd just end up not fixing the bug otherwise.

--
Cheers, Lorenzo
