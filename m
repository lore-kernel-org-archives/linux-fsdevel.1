Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425451;
	b=YzFtEzHNPsNV8Q2JbA1K6Pw4MPQhbT4uSTiVsZv8SKTQ3VyM88LRVSXshUKN9ayZA7G1
	 OuoI9zeIGWLHVqZhJavaZJwcDCQzOm+W3TyMiRyd5UK6XcXLYkT/+0NLDBKbRxJYVrX4p
	 Qt+Ab2/aIYdA1BGbP01EU2ZacQAnnDUyXvse85gqxdnyupYB+30zWodbaM9TdgBZ0qEZj
	 1DqwFrSXSUg9ibZmIAQPpn6QKO5bkIsFfr3mYUiL/PbZR5K0zCeKTobH1t7Wvi4/KeeJH
	 dmWGGMfGKvG6PD+k4dwZcHAm3m7u+brzNb1TNlWuhViutoFDoIPNMwUiYppM5DC/gpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425451;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zo5UI9hZIeOxlpwJeSrtbBHTLqLuJCLcw0oCrYMAP/Q=;
	b=S9ys/3EFF4SYtR0i58+azeVzzqRjTK9zXajm8Vlj8a+E5SML3jwPBVi7LRl8FyZOAWdn
	 6tX5nNZyE1S770xpwVUStp5UE4opx31bZLhAjKCl4jf1HYNRgC1p/MG1Dm5KWD/vY0ui7
	 BhQvMeeditrofiMDFk4p17P+Qqibhx7CbhoJGW4riKbS2AomV8YuWm2yXfsgOtfKc0CSJ
	 smQyfwrzbOoczfVgwOVDq7WRk9s/Xx7M3cWhcMe/QQ514aAJAQGcBAaVoItw5S2F4C8OE
	 9ZnodLhTdqJynMKz6x6tfoT7iB+gWehMd9qBE7hQhkTiBFMfTuXszyPLDMWuQQ/DchA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3bbySjq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268F606A321;
	Wed, 11 Nov 2026 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3bbySjq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274301F00A06;
	Wed, 11 Nov 2026 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425451;
	bh=zo5UI9hZIeOxlpwJeSrtbBHTLqLuJCLcw0oCrYMAP/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o3bbySjqkROLEWMWlRsCJRpMjjPfMzgor3woKAUM85Q0YATPXzDoeJ+emZSPXRFi4
	 XHvwXvzJEcSrxFJZmG62dRcGbidlKpX1eGKnLEVpDFM3GiAxRgMqgPsPRs2IcD2oh1
	 g+fYssA4UoDRlC4il3q84fIkWILpRWM/QR84LkxLyu5vWTc3o31Q4BISOKxTztfrfi
	 s4y+bJiZE9D5+aAmSUX/nqkbdlhZHvFS4e+aFnL5E/gMLNfgfM/tuMP1RZn12cM+PN
	 kEg3ti0U0cGzVmDQIp3J7QIJmTeu29s4RxJm2mSUWPmx4YLIyQiMXoeWLChKkjzEWb
	 amxKlhIZPbpXA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id AB9F41980047;
	Wed, 11 Nov 2026 14:30:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 14:30:47 -0500
X-ME-Sender: <xms:YML0avxQD665O9t1dOvEy_Pxn46EG6tbREK5G8GJxGZfToS-P_E96A>
    <xme:YML0auLI4IXUOOkzv4D8YNfzHgc6iyiOeUALj4E_vez_S7kQDHH5FiZDzY5x1nkSQ
    U_t87QDYdoRXHCu0bbBh9aIEyfkBjQvf3hq-ZPSvgx2vZTEf5kmZhwF>
X-ME-Received: <xmr:YML0ak3ycEJWZ42qb5nc47unXvlIQ1E2mffU1-LR5bQMjjrYNlMGrPHwn4Y>
X-ME-Proxy-Cause: dmFkZTFg5mDn7G1jsxtJADJ5cuZf2Omafa/3hQOhBIIimTDafnO5A24NJOlsqczvUj1SEs
    klbDFZa+cCJm+hNR5NlTtmFKeH16BjQ/ZxuKgXmvAvddkkJHCf4bAKhqrKCRIBAvA6Tc2y
    MAgurUAn0Ed38s3Jo4oTLdfx0+Uk0ey3+EK9sO/AuYl+Tqpb2jiu/k6zbVx08ECTcsFIev
    gGlrZCAYO+PEDo7Hr4y8X6VfZYUHqPPZCdOzMI+4T1F8Ak4yqSjPQhNtOvIzum4W6w4HgL
    pgD6LrrmuoxneLsUL9/IOgiboNNN1/jsaLXgUv1tvI/NokEY0SdNO13wgeLnX0R8cwrCE3
    8ehWPlH6fkdPishwD569Pod8+ltBECxeUJy8OPUjEiYWjNy+7Hfyh6uTZFZ88Tvkj8SMA+
    42NlQI6vi5L4LH3ctQoSboEOjgfLEPqpV0Dr7UXLEwvJluDcASfBTGZgbVuKqS1IBGMJq+
    af4uNR8qUNzw2wjsxhfOtj6oE7jwa9EYfRiocIwsTNRCr239Hzkr7sKdRokFLmb2WJ4yIh
    ZSiYW2UFfMMhZcH5Oa7HuJdFq4YU9JG/xU3LrFPD516cliTB5DQu1cXYv3Mc/fBpDg9RhM
    1aC1d0yqB4lnWjEIGpBELNP2UNsUbFNyTqu9DLQbN7Hf/CeIBSHGezzY5VxQ
X-ME-Proxy: <xmx:YML0aiA7eKm0J3ecc2HVJFcpHzQFh93AOUTveT7lUEnWMcd8kZ7thg>
    <xmx:YML0agRUnpPsSFdFFRoziPzyCDbyt7q0m55EeuYcBcaYNQtB_Y6ZaA>
    <xmx:YML0alVKBOCzq20d-Ry4IgqgXV3vGWOwSpTvYTxBnGIvbXry41I-Kg>
    <xmx:YML0agEbAxt22YRy2B3-CKdMA1V4gsug3S8mlWpvJeL8XPG4TA2iNg>
    <xmx:YML0auoFfbVJP5a-7819JT5NJRy1483hK0PwMYuYYAAy6lHRcUvwL1hK>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 14:30:38 -0500 (EST)
Date: Wed, 11 Nov 2026 19:30:38 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
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
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 04/13] mm/migrate_device: allocate THP deferred split
 heads
Message-ID: <avTB6h61nXfvCXUS@thinkstation>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>
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
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>

On Wed, Nov 11, 2026 at 06:13:18PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A THP that device migration maps into an empty PMD can end up on the wrong
> deferred split list when it is later queued for a deferred split.
> 
> This occurs if the memcg has no heads yet (resulting in a warning if
> CONFIG_DEBUG_VM is set), where deferred_split_folio() will then queue the
> folio on the parent's list.
> 
> Once a later THP fault in the same memcg allocates the heads,
> __folio_unqueue_deferred_split() and the split path resolve folio_memcg()
> to the memcg's own, now existing, list and take its lock.  They then
> list_del_init() a folio that is linked on the parent's list, racing with
> anything holding the parent's lock, and both lists' nr_items counts go
> wrong.
> 
> Resolve the issue by calling folio_memcg_alloc_deferred() after the charge
> in migrate_vma_insert_huge_pmd_page() and falling back like a failed charge
> if that fails, as __do_huge_pmd_anonymous_page() does.
> 
> This was originally discovered by code inspection.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: tweak commit message, remove unnecessary comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm-new already has this: "mm/migrate_device: allocate deferred split
sublists for new huge folios", same Fixes: tag.

Hm?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
