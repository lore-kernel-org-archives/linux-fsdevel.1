Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442718;
	b=xE3sFY0QWW4xXmOJw3osB9PWA3PELB6fQjrQg0er+8RVsKoOGnC/dj98vedQSdESxmmo
	 50TGaTXG3HK1IhWtNosKt+JbQNr6042yRQVLPkXsXyRJr2cAai4SZmJ0/9GMamYPJNBJL
	 tWjraDGijS4ee5BiUwGWwPiHXPmz+elt96L2Aky0kTwdolY+a1BWixMmHiZYF3Z+VTVHN
	 5X9U1k2o+04BgmTWoVBF031lB308qLKrymCY7tL1QaOYkLupDacDdspKZ8AGNfvTw/Gpt
	 OL0gexuNmEhTMBEWPZDBY3jlGyCkeM+dBPZ1LaxrDHQ+qvQbewIiphU1g0QR33xrt5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=njozbmbCn9bcbYemCFYN4fFcerXn8LRoys/sYPRNDos=;
	b=jPXX4B1Jg6xI5RMPDL1Um079fBOfWQ5v/VnXIjwZxJlLZtXGl2D9L3CUipgcEVMqHI1i
	 80Nd1tjDz8giOstCYt7lJsrww9XRXbGXrSv1gHkhPIX0ANmsRYIxKUx6U8mxM7iq4sXJz
	 PMKQ1YgySjVCz2kXBP6BqZkGFEv76YUjm/qSPeIsiCWoyajvL/sRPvivbjeXhmaHdfVVg
	 qeCztfC1FPPOu9wBKTVtqzvWZHCEjXV/r95rFek0OjTOtQm8k7WplrZuwGF53lzMP3xQe
	 SEDUXD2DiUihDLXktXVmwNwDyehEMklWxJAUjq6F2fpqzU+DNIu369IRmRU1cJBqGBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=igq0rNBf;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB52606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FB52606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=igq0rNBf
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67db763cec7so3368374d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 06:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795442717; x=1796047517; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=njozbmbCn9bcbYemCFYN4fFcerXn8LRoys/sYPRNDos=;
        b=igq0rNBfR5HbxAZkN3J9ZVhbsB1qEA961sp/d7IqeNGyTiy13BYtzWR9s/RamaGEgu
         kc4sU+btJ7XNLZ5KXBxvURVrVQTw+iIpKNkheMbVp3xGacR1R1kfOolkY9OvEfyDy2WU
         t8c3MRu8Ph/FVIkYBtPSoZ4kr+2q46nvdG4OkaZ8HKw2uHjsXYgGlmshpBuDHEEM6Ue2
         CnIWmzY9CuCkfe/LjkxDPgvTI37B5eL8NNhGF5PzhFOodXssf4pgSvAhXFcLZzhsXatI
         zvry3mYpF+760cfsuTrJwWemnN2NLrmMWr51jTqFRXg7TtEf6JJSY0VorkioDqKLVzoA
         4mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442717; x=1796047517;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njozbmbCn9bcbYemCFYN4fFcerXn8LRoys/sYPRNDos=;
        b=s67TtAzL0tGCxnpH/YfqkTIT5MF36EdeLa8XRRJ31D9CIMmpWl1lWHRuGuxFcfqnJt
         oFn+zb2ruYAT0QuIIv97dwv9J5WMVrUolg9HopZNNz4tGPAffOQ+ihU4/DNQgiRPT3vL
         psU7PF4+6/boQxEsUzsa3syWJ/ipV88GVwjDVsqu2a7bWblQOhII3uzpEKBxxiHas15I
         sys2i59Sy8VSQ7ZSyHflJWUEIqXDGyHiXfiuRHJgUVE1FgN8SqGSeyWRadgJhHDthUGJ
         fG9qExAKQP9AvSRoai60xVfWX4EIZHLsBDmUYuLcjIs8wB7LUvrVpQ9LLWbn/KqMcbNv
         VEVA==
X-Forwarded-Encrypted: i=1; AL+hErH3jxcizPQO7hD9e/DoB/U5WQ9Kpz2GwEtUdN55TACoRlMT9Bvq4WeXoTcqaxwuat5r7F5lhhse0H7YdGoa@vger.kernel.org
X-Gm-Message-State: APuU4Z+NfUcAADg4AdZhp6pppNeaIcDml6xkge2bFiMGZGBFlRg4AeLW
	P7BBGO0YJGP/R3L/guXjzgMZjqD9m+y5lDRaVDfYCEGZc5Lsby9s5VBxF28Lcm/YOK4=
X-Gm-Gg: AZFdTZeJcX4jI2LC+tRTuwaJwao2EmV4uazG03yV/JiDAKoX/O4uPupnVkdWUz2+dYM
	TsFVaxZDd5PF3dp5G6Fqvj8CWmzfvPixSmJzDYgLpaRxMO6cLTpE4yOBiZOgJUvl6ensqOKZBhd
	3mrK6/W6qwuNcL1ASvmoxaG6qif35USg3iz+oX0DB4wpBpaVo+IqtPvvg11jqO5hFZ/CSyVGFe+
	xTOMrDWVQfgEilWmV0WfI/S1fq8Pqo5hHSMINmm0G60acTukTBUklbrfT9MNko4LE4jag5Z3vYV
	XNA859PttHtkVpU/L/mZ8KjjQ5rQxlG/yuTIfm88XClnDxLwg3FEFoC7WYnyop9AnZ9eU9OM8hI
	dpZIXf+LcYoIjO+68R3ODcd4oUGVED+EPRreUVa0lG8G0X9q78toVnSMY2KlKiInHG+wLiP+ZFY
	H26dRVWspxRlnQ+CAJZYZeHcA5wBRkS7/NxYe3zVMo2SpNQDj993O/KGJX2DTH3IGqmnOB7MjXt
	0gkDOso4BvkU1eVURzO4VW+naWPlkEZ86k+DrfM9LVoT0cacktVhw0+DLETnJM60ugDC7trC2w8
	Xwyao4Gwa4hiCRpBPVDw5F076CppfDVCQs7rW/9/PFTR58gsQNAZN+zrG9IepIweQdnNEhV10vD
	EXodUVtKkzPl/+uUIcWWK58bxLoYo
X-Received: by 2002:a05:690e:4881:10b0:67c:efb:636c with SMTP id 956f58d0204a3-67df4425656mr2221811d50.51.1795442717363;
        Mon, 23 Nov 2026 06:05:17 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a08552sm106091806d6.34.2026.11.23.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:05:16 -0800 (PST)
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
Subject: Re: [PATCH 23/60] mm/damon: restrict DAMON-native folio operations
 to common memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: gourry@gourry.net, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, SJ Park <sj@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 Jann Horn <jannh@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Youngjun Park <youngjun.park@lge.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>, 
 Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 driver-core@lists.linux.dev, damon@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <awMcsTqyCgQ0dISw@yury>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-23-74f5f9a115c2@gourry.net>
 <awMcsTqyCgQ0dISw@yury>
Date: Mon, 23 Nov 2026 09:05:14 -0500
Message-Id: <179544271490.412063.3555696768623975197.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 11:47 -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 01:09:14PM -0500, Gregory Price via B4 Relay wrote:
> > From: "Gregory Price (Meta)" <gourry@gourry.net>
> > 
> > DAMON acquires folios to age them, check their accesses, and apply LRU
> > operations and migration. Treat these as general-purpose MM services
> > and restrict them to N_MEMORY_COMMON.
> > 
> > Memory outside N_MEMORY_COMMON can still hold ordinary LRU folios, so
> > it would pass the checks that keep ZONE_DEVICE memory out of these
> > operations.
> > 
> > Treat these folios like ZONE_DEVICE memory.
> > 
> > DAMON cannot acquire such a folio, so it never ages one and virtual
> > address monitoring reports it as accessed, and DAMOS cannot isolate
> > one for migration.
> > 
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > ---
> >  mm/damon/ops-common.c | 5 +++--
> >  mm/damon/vaddr.c      | 2 +-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 15cabc79613b..57201a0c5e3a 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -17,8 +17,9 @@
> >  
> >  static bool damon_folio_acceptable(struct folio *folio, bool monitor)
> >  {
> > -	return folio_test_lru(folio) ||
> > -		(monitor && folio_test_hugetlb(folio));
> > +	return folio_is_common_memory(folio) &&
> > +		(folio_test_lru(folio) ||
> > +		 (monitor && folio_test_hugetlb(folio)));
> 
> Can you minimize the diff? That would also improve on readability IMO:
> 
>         if (!folio_is_common_memory())
>                 return false;
> 
> 	return folio_test_lru(folio) ||
> 		(monitor && folio_test_hugetlb(folio));

that's reasonable, thanks!

-- 
~Gregory

