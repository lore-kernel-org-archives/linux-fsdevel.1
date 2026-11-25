Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607528;
	b=yNCuNHikpQ8e0ysyPBrjAP0urlK3y7z+RdMZ7wYW4Hi6/QzBQpDulzBeeMjpWRgVOUdB
	 1qluf45KloQRQ2noebkNJm/T06uXIDKX0zh5IJ4Q8JwVD4eP2TIy6eVX7g7/ekxStSVCx
	 hsT0AIOAxdKPvhrzemsGatJhHeQzGpcQetz7LFaNCTjp08D49Rs77fj79QI0MpcW5nmAe
	 UnYwvzfrIaXt/NVAy3ej9K/zzysYcnSwS2Glp8NJ/m0LQ+1b+JrM29fjdVYkDdG2XImGZ
	 TotVXn9nuR2WR471NMh8z/wYB9cUj0qPyKvlicyW70UBWK97o3rrLF34hT/Re9rgAkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607528;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=swZ2OrHGAAmdjGMDFDLdMlqudI2Ll9Z2QVb1W7XWNWo=;
	b=Z8xYp5DCxXIU4COpIHAxsjbPUK1XE9yr8/vbreLNf3LGKS0B/SyMe21QA2wRsvdqY60d
	 KSS4xEDsZDsbwoGy5WbJSMp5cW0CLpGnGiB66UuK7eLL81YhoBaeq9I9CqM+d1pdBYAhc
	 4yFwyExAZxkpjf8d09CX/GZCRkLxFEkeIn859s4Xh2fCAQwzpA7Icfe5NaFwZNWgWmloM
	 wMXWs7F8V6b5rFrXsTZJf+bnsoDzZN/Ob3VwBQZqdzaISNPN6yUsBAmrRFQeP4Smdqtx3
	 5qJ9GOmkDvdQPxDSVHltny0B6RAZJEc71tYX2UirVU4ybzsQwQ12/TyL5/MEi5ym+Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ot9hk0RB;
	arc=none smtp.remote-ip=95.215.58.48
Received: from mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81A606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 11:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C81A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ot9hk0RB
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eh4UV9rsh+mFYHPXJEN1V//9HTkB9IJyjcQyoK8DCDk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795607525; v=1; x=1796212325;
 b=ot9hk0RBBCKyVkXHa56fM6RHLe+3tIU8056ssw7/o9Fjnsw95Fa6BJVjSlSVuDOOefjq1YAs
 xVJiOXknWLRlhmO5FGQ9KgKTn6zZWZHpSbWzilByNUBUqTTChB4jfmTu+lTcdN0TEnLLGgfDnMs
 n7jA54GSnc/UneC0C5ZZZ5bo=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 2c3d09998e88645b;
	Wed, 25 Nov 2026 11:52:04 +0000
X-Mizu-Trace-ID: 2c3d09998e88645b
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Subject: Re: [PATCH v3 3/5] fs/proc/task_mmu: read the PMD once in smaps_pmd_entry()
Date: Wed, 25 Nov 2026 03:52:00 -0800
Message-ID: <20261125115202.4085587-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <031b595a-376f-4848-bfd1-ea85d273db13@kernel.org>
References: 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Nov 2026 09:25:14 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 11/23/26 18:55, Usama Arif wrote:
> > 
> > 
> > On 23/11/2026 09:24, Lorenzo Stoakes (ARM) wrote:
> >> On Mon, Nov 23, 2026 at 08:32:09AM -0800, Usama Arif wrote:
> >>> smaps_pmd_entry() dereferences the pmd pointer six times. Read it once
> >>> into a local with pmdp_get(), the way smaps_pte_entry() already does
> >>> with ptep_get(), so that every test sees the same value.
> >>>
> >>> No functional change intended.
> >>>
> >>> Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> >>
> >> LGTM so:
> >>
> >> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > 
> > 
> > Thanks for the reviews!!
> > 
> >>
> >>> ---
> >>>  fs/proc/task_mmu.c | 11 ++++++-----
> >>>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>> index 540c936aad4714..105c4998eef48f 100644
> >>> --- a/fs/proc/task_mmu.c
> >>> +++ b/fs/proc/task_mmu.c
> >>> @@ -1022,14 +1022,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> >>>  	struct page *page = NULL;
> >>>  	bool present = false;
> >>>  	struct folio *folio;
> >>> +	pmd_t pmdval = pmdp_get(pmd);
> >>
> >> NIT: Can this be const or are the helpers not safe for it?
> > 
> > Ah yes, good point. Its good to have const here.
> > 
> > I think the rest of the series is good to merge. Should I wait
> > a few days and send a new revision with the const change here?
> 
> I'd pick the fist two directly. Can you resend the other 3 such that Andrew can
> pick them?

Will do! Thanks for picking them up!

> 
> -- 
> Cheers,
> 
> David
> 
