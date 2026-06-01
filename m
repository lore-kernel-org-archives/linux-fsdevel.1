Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E714A62B;
	Mon,  1 Jun 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302910; cv=none; b=ZF/vUBWR4atSvndavNjS30sgNqIOrM50C/lPDzxKc5U+S12rLsqiaV4pmLHhNGmSkkfEUjb1TdNK0zPkdb/qhxMofJI+dc4wVIAz7Er8ndROfeTo9iUZ6F2Gg4VZYJxV8/621JvpkYoM2VLfigS1v4BZ4uQpgnU8whOccczBclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302910; c=relaxed/simple;
	bh=7qIZ94fwyarOEIYhxdn6d8BHBpOVWkVbQ57Fwh3IZT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICg1RKC7Yf7hOlpHb1ySFzAK26TyKtWqTb125d7DePMgwCtZhNh0teCuTkvQHA+dKfC8/WKgAyN2H2NkSKtvurhk+PUQGi06VKhzxmcnzYp9yPYPjPl2I9TkR4vYlI89yxVOlSw++zHYho+Vu/3Oww/xVPbejT+cbnBRFq1NOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuqXDHST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuqXDHST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6C01F00893;
	Mon,  1 Jun 2026 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302909;
	bh=9lDbQeKLavZFIEOh/CkUOUIvMQqnzPuvTdfWQRXAjQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VuqXDHSTvMpQFKI7KSl1aqVO8mINRprGN9VK5lUG2VU8Ww3vKfBDSmWFtvv6k21sD
	 TaxevY6IVRKCqJsGi7U3D+UvH2idaNRUj6mqc9Uq/x/vnnJEhntZNT8CEOSe/NjDrd
	 0tbukliX6py74YT/0bsXvRAcipY7vwFycxesA4iNJRMPcxH3WIAcWrXO4J3xnWJOvK
	 5nJFQpjt7ankRRWAyAVnYgK4xCpXkHH15zu1sqCAwWrClnvu88KdV0qyZDKNdwq+b7
	 ms3vkIZD2ZEX4qo2drY08GUi6G9clbW7rHWN3mTok83U3ARC9Lfthrv2DVl2ZfhHlK
	 iVcOSRuSLzvDw==
Date: Mon, 1 Jun 2026 09:35:01 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Balbir Singh <balbirs@nvidia.com>, akpm@linux-foundation.org, 
	liam@infradead.org, jgg@ziepe.ca, leon@kernel.org, david@kernel.org, 
	shuah@kernel.org, vbabka@kernel.org, jannh@google.com, pfalcato@suse.de, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-kselftest@vger.kernel.org, usama.arif@linux.dev, ryan.roberts@arm.com, 
	anshuman.khandual@arm.com
Subject: Re: [PATCH v2 2/2] selftests/mm/hmm-tests: test pagemap reads of PMD
 device-private entries
Message-ID: <ah1EI_JfZYop7VF8@lucifer>
References: <20260530085413.1270139-1-dev.jain@arm.com>
 <20260530085413.1270139-3-dev.jain@arm.com>
 <9d8bffb5-bb07-4cde-8a20-8b9b9996f8cf@nvidia.com>
 <7750de96-44c6-47b0-b0a9-dd948fca2e90@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7750de96-44c6-47b0-b0a9-dd948fca2e90@arm.com>

On Mon, Jun 01, 2026 at 10:40:48AM +0530, Dev Jain wrote:
>
>
> On 01/06/26 5:39 am, Balbir Singh wrote:
> > On 5/30/26 18:54, Dev Jain wrote:
> >> To cover pagemap paths scanning PMD entries, add assertions to check
> >> whether a device-private PMD entry has the correct pagemap information -
> >> the PM_SWAP bit must be on in the pagemap entry. Before that, we must
> >> assert through HMM_DMIRROR_SNAPSHOT snapshot that the leaf entry is
> >> at PMD level and not PTE level.
> >>
> >> Signed-off-by: Dev Jain <dev.jain@arm.com>
> >> ---
> >>  tools/testing/selftests/mm/hmm-tests.c | 29 ++++++++++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> >> index e1c8a679a4cf3..d09d4a9081de1 100644
> >> --- a/tools/testing/selftests/mm/hmm-tests.c
> >> +++ b/tools/testing/selftests/mm/hmm-tests.c
> >> @@ -2276,8 +2276,11 @@ TEST_F(hmm, migrate_anon_huge_fault)
> >>  	unsigned long npages;
> >>  	unsigned long size;
> >>  	unsigned long i;
> >> +	unsigned char *m;
> >> +	uint64_t entry;
> >>  	void *old_ptr;
> >>  	void *map;
> >> +	int pagemap_fd;
> >>  	int *ptr;
> >>  	int ret;
> >>
> >> @@ -2318,6 +2321,32 @@ TEST_F(hmm, migrate_anon_huge_fault)
> >>  	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
> >>  		ASSERT_EQ(ptr[i], i);
> >>
> >> +	if (!hmm_is_coherent_type(variant->device_number)) {
> >> +		ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT,
> >> +				      buffer, npages);
> >> +		ASSERT_EQ(ret, 0);
> >> +		ASSERT_EQ(buffer->cpages, npages);
> >> +
> >> +		m = buffer->mirror;
> >> +		for (i = 0; i < npages; ++i)
> >> +			ASSERT_EQ(m[i], HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL |
> >> +					HMM_DMIRROR_PROT_WRITE |
> >> +					HMM_DMIRROR_PROT_PMD);
> >
> > madvise(..., MADV_HUGEPAGE) is not sufficient to guarantee that the allocation
> > was indeed converted to THP. Might be worth using the kpageflags interface (but that
> > requires elevated privileges) and then KPF_THP? Otherwise the HMM_DMIRROR_PROT_PMD
> > can be a miss from time to time. One other option is not to assert, but to check
> > and inform?
>
> I'll then use the existing check_huge_anon() to assert that a PMD THP got allocated.

Would MADV_COLLAPSE work here?

>
> >
> >> +
> >> +		pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> >> +		ASSERT_GE(pagemap_fd, 0);
> >> +
> >> +		for (i = 0; i < npages; ++i) {
> >> +			entry = pagemap_get_entry(pagemap_fd,
> >> +					(char *)buffer->ptr + i * self->page_size);
> >> +
> >
> > If this is a THP entry, do we have valid pagemap entries for offset of i * page_size?
>
> Yep we do, see the populate_pagemap label in pagemap_pmd_range_thp.
>
> >
> >> +			ASSERT_NE(entry & PM_SWAP, 0);
> >> +			ASSERT_EQ(entry & PM_PRESENT, 0);
> >
> > Nit: You can use PAGEMAP_PRESENT()
>
> Okay.
>
> >
> >> +		}
> >> +
> >> +		close(pagemap_fd);
> >> +	}
> >> +
> >>  	/* Fault pages back to system memory and check them. */
> >>  	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
> >>  		ASSERT_EQ(ptr[i], i);
> >
> > Balbir Singh
>

Cheers, Lorenzo
