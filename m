Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012720;
	b=CSlTG5wZZbt0w2u4LvfUI7fc4H2iyyNpF0UZyx4zefT08MRIQc95iF8+V9kj1KMiSOJb
	 yZdAlQqj4igwWPHDySjM0iRhTZA0UhHrJNCsl0WdIh/t7YUsxUh8f5729TY/1t4iFhCEy
	 mek75GNy7PpmNK8ZxP0+5Igyj4oU+0nBa3rjLWaDAF80Ql9OyVTGkyfyVF2hQbacTEBH/
	 lZO4zFKiuQ2MGNjohh/crG74hZeWS+DGv9WcbrmJM2HSHCGX67S/3ZA90NYSQ3+HcOztA
	 Tx7IqiSz20z4I+2/IyleJ7wemCAijnZH1GdEPcV3LwmDHZK7oxlBGniFCzb0dXjB9wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0eSFRUxNp/7+gMqqEqt2trFE9S3TEcIfNW65n8uJu4s=;
	b=Cv431RQKrzApscfa3sh0qGIaHEl+l71+TJvUeqWxVU2vwHTkK8LtC0uP8xg4cyNMo4tz
	 XnwqfBfYrjITrjq8oJuCfmATqo5kjux1VeR/qJvNnKCBLahW/rz/iouHIic1U2hEQj8gM
	 GKm65UCDfYZg+Y1Xnq7SpTguMhbvRid74o0cOBrkXuUddchY8d/UE5k7kSXU2aa555eIx
	 G4zxhNQDEbVP4KOrsD9yXKAV8lRH9OJbyoAYAy3zt8bbOdELdoBbNpaYmy6+K9TWt5Cmr
	 ETZ7Cclc1QTySolnbN23IK40Q+p+WS/JM4da223NufuDaJJomXYWwg2jGzLTuXg1vNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH0OyTPs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6793606A325;
	Wed, 18 Nov 2026 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH0OyTPs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21511F000C4;
	Wed, 18 Nov 2026 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012720;
	bh=0eSFRUxNp/7+gMqqEqt2trFE9S3TEcIfNW65n8uJu4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NH0OyTPsYET+SG6a8MQ7AB6SuivmK3D31Odv4Mz5qV9Vxa7UCoLuM6lCqbI9VfRGu
	 4vdNtxmYCHKVbsdIzhQHoMsqN4BjqTE1o6hU+4Dnzbkpx5NJrGyjQNCyP2oCpLapwj
	 4PoaOsC4h5mrBt1U3dzstt+W6Ae3loDNa7H22Xp42jJq8pcrKnNWiB88USqBPcOACw
	 84tG5o+PkO5FpxJdEMb/yw2u7ye6ccTPuV7hze80ccDnq8oG1HkcUcbE4eU4SFyBGE
	 xdyEYvUFPxeGwx3RBAoLVBkEbewAfS7CVNF5uxg3AiYq8z2uOdczc/oZjqhitie6u9
	 syPOVIDqiuqIw==
Date: Wed, 18 Nov 2026 16:38:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrei Vagin <avagin@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] fs/proc/task_mmu: write-protect device-private
 THPs in PAGEMAP_SCAN
Message-ID: <av24YrE4rbg2x6c4@kernel.org>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <20261117-uffd-state-fixes-v3-5-b617009d1a4a@columbia.edu>
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
In-Reply-To: <20261117-uffd-state-fixes-v3-5-b617009d1a4a@columbia.edu>

On Tue, Nov 17, 2026 at 11:28:45PM -0500, Tal Zussman wrote:
> PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects a huge PMD through
> make_uffd_wp_pmd(), which handles a present THP and a migration entry
> but does nothing for a device-private THP. The PMD never gets the uffd
> bit.
> 
> pagemap_thp_category() reports a non-present PMD without the uffd bit as
> written. A user tracking writes with async uffd-wp therefore sees every
> page of a device-private THP as written on every scan, whether it was
> written to or not. This requires a driver that migrates THPs to device
> memory.
> 
> A device-private PMD must be write-protected like any other huge PMD. To
> fix it, pass any valid PMD softleaf entry to set_uffd_wp_softleaf_pmd(),
> not only a migration entry. It downgrades a writable entry and sets the
> uffd bit. When the THP migrates back, set_pmd_migration_entry() carries
> the uffd bit over to the migration entry, so the write protection is
> kept.
> 
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Sincerely yours,
Mike.
