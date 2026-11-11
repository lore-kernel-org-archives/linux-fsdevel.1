Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425141;
	b=30bkAXvzd/+nhsRDiciyeuxCO9bJxCrtMjcMNdz4snbRjf6cIYrz0wKo6O/0pelXbvxR
	 yRGQLqNGXFwgulhGXcYa4NgJEDoE6xxjevtB8H0PtmyQmK1G111rweRPYwMJ6cQBjYHoX
	 IBqPutEHVQ8x9mi2Vwbt8GQQr2eWm4UDhUn2YroCZkExoSrvbx/ldzDnQnkU7PMwjUpiC
	 G+6gnXCKgg5TMOn4TbAAWtj6DKFz4CJqkDxQJhlqnMomjaIU6BJ8aJZ6MvwPQQ3u4AisU
	 v3j9jVox5emrEyxPC7IUnlDJNgZIYoUMt8ORwcFRiaX4Ne97bfLBzqjLeDBw1HuLokw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425141;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nLrVl/k3KgLHzXmtBoOIZdPXNZn+ttWx65joOkMlZPo=;
	b=fltTcomAvoLLenjxafiOr4jPwW4mZP99g5KZ3KYXhavJSDHeXywA0TMLVh/w8z7MldH+
	 zPoQmHwV+5QcYbyt6qrSPOEr7lgH26qU75cknxkPtjFf1vduEmfqYTWHdtD2eFK50fN7N
	 A/TYgoqu+R/Wv8tbVwJcssBrzZ1PMf4++kXMGGJT3SSl0ZfjDcXpK0TbPLQD2SGAXdUQg
	 wjzc5RovoKSicMr4wJlOub3g1KtRie8olPyem2t9oG5Mrkg0zh8TK7+XC143VlAnjYtjI
	 nI8ALSlGDhLdZ3+y+ZletGn2SW5W/Mn+RPr+zdf0oBT7K8crkvajXENmHzzAMiKKweA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gadnwvYG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1090606A321;
	Wed, 11 Nov 2026 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gadnwvYG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F79C1F00A07;
	Wed, 11 Nov 2026 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425140;
	bh=nLrVl/k3KgLHzXmtBoOIZdPXNZn+ttWx65joOkMlZPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gadnwvYGYHAXYYVGk1JbKh/JDgeU8CHZAAEHkxHMQYEAdjkvpD8GlA+iOgSQ1gHaL
	 2WzgFZY6dMZD32ET9fMNrWhfaCiiC4Y34HIpRimS6mMDQa+GnhVjYmWL0criR6mOtK
	 zgJJQ9YNM5t4J8cc/PQdZCvMpwY+05M13mf7H+QBNj6lYRfha3d3soNYgfiFNOolqF
	 VYJoG90Garjxk7cNd08Ew9nNK6lpJvaAyiecaPHkl2rgqsykZnNfbzF/DGjbGZM8m+
	 5qPOW61uhkaFVNmP1xkqi8Y9uKTeB9BtnxR6ewQC9bAdsv6tH3LqBSnOTHgYav5hxB
	 IehLsKRBtSjyQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 28E98198003A;
	Wed, 11 Nov 2026 14:25:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Nov 2026 14:25:36 -0500
X-ME-Sender: <xms:KcH0akBuLsxUavrAsIs6NxQG55-wDLmQDqxgoT0hHBepF8UnAiZSeQ>
    <xme:KcH0aqs-jZwa7Qx5qtAF6J6d_EYjkpJrHlD-J6XSJ9ah6Bhk6l9Opreu5nh6zox7g
    05Qbwf7W_s8mcVxEo1MvTLOUWeb__Z-Ky_kPZ_YkdZoO9UbwBrjVlIv>
X-ME-Received: <xmr:KcH0asPHhMRC6GJyUYQaU_FufK1SRqQnikEBJtKQgnI7YZ3L_HNdvZ6EYe0>
X-ME-Proxy-Cause: dmFkZTGVCwJi64G/NFk0BwzEnaSuCMVZAMzOi2v2VfdLLUWVfoxG0mAp0ULnNCJcShF2US
    zpqvkUUooMNrb9VT5bI+vNxuhwJuht9BnZuyP6D7bvZpoK8a5uikkJGwYKWB4heRQ9E8Qp
    8sFCVqzwGTCEaJn44LCyasSmVXfeqafjx/O0DiPO5mcDIuboMSbr92WRN5tGZf5rQpFY31
    06/Afv0VFlX+JK/uyhMP0CiVCN8q3iMXiYF4dq1x7GZLlVF4MqhHo0IfHCmyrD1YpPu8fo
    03njvV/FKfclnNsctu4TRqpZ7QfV9E18C6DC5sQImJkZh9i7ypzb+El+NDySjRQo2OVLmI
    GM/Jd7JhmF5Y9hVDkKokHMQIA4bJVVX0aPReG+1uGfuFZd8dJ5WNxaQuO1dD5m/6En8RPK
    fUMhgFo2c7IxI+em9h58OsEervXa2F08mHxIEqGlCjYMUwpIC7K970CUfnPFsukHH/piiy
    lCPIsBlh5O0aJWIWnYjPobC+oObXpKCZLinZ+jw1aWP1N+wt7+9ur7cXHwegSBM2LUJ8s1
    yyfVCMVinA/PEJWsRAk+M0qK5itVdjSu/G85tdlBzL/yO3fxabKkS3ayTaNJDQ1MoTPQGb
    OuCHDUZmlNpKRYpF7Unv6Ca2ihvDHAJ43ZIC3u5t/aMPRgDoWkE6i8PBRRXA
X-ME-Proxy: <xmx:KcH0ahXb3pDaG-egTgcyFVKal5e5UJWmwA1XCxDAJeDBi3hTpotZwQ>
    <xmx:KcH0arUxJGgpq3-DqS4au7fqAE9HdioSg8Jej7YolRZKJZHet3H6tQ>
    <xmx:KcH0ap5Iz5xKUdVTI4f5hOAPXNy9NechvYgzaz-UPcVSLyQ1L5azBA>
    <xmx:KcH0aoL0yRAdUIWxNF1_p7NySAlNl5Swaox8JtCcvlugxxWdBLVD7A>
    <xmx:KcH0avLoZVlC1P_az5xw1K8JfENI-Sr8XNvn7CujOffJIHpVDW_DeoTl>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 14:25:28 -0500 (EST)
Date: Wed, 11 Nov 2026 19:25:27 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Chris Down <chris@chrisdown.name>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/12] mm/madvise: send UFFD_EVENT_REMOVE when installing
 guard regions
Message-ID: <avTA58zlxJZ69TB8@thinkstation>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:19PM -0500, Tal Zussman wrote:
> On an anonymous VMA, the zap drops uffd-wp and RWP protection along with
> the pages. Writes and accesses to the range after the guard is removed
> are then not reported, and the manager cannot know that it has to
> protect the range again.

For RWP this only holds if the range is registered without MISSING.

The zap frees the pages, so with MISSING the first access after the
guard is removed is reported as a missing fault. And there is nothing to
protect again: RWP only covers present PTEs, and a page faulted back in
shows up as accessed in PAGEMAP_SCAN.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
