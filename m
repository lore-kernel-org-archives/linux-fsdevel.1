Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49E1AB6F1;
	Fri,  5 Jun 2026 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659122; cv=none; b=B+Uq99cdKPDNn1nwgZwQj8QM00qcrYaybJ8KXo+qEK0PLZ1V0nFDWIiqcsWR/F6nwwk/b4KttDuAfw3l8W+Y5B4oxRDavvI+4i/Eqw2twVLWwkr7ubuzxhWx13bZist6cnq9udKMs5lXPkyIsHR9Te232k3lpGFPpKUzYmdNAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659122; c=relaxed/simple;
	bh=L8KMyoRzOG62/thuh9mBHzCevn2S+M9JoPnrBCKOMEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJbClaiz+2xnivFkIxrI8pAL67bDXoDR7DSs/DnQ2yvjVHgFZhI8BXKub6Y3+huvmQGpOzyV63ZEV4lED3QRHVnzhetvkktKVBQ2b543IDtNIRstvOlT7UfhiYGs/DJg0LOvB+3tEkAIQVwXEelSD/duMtj0NgScA9xwo5yOjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpgVnwBS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpgVnwBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FA61F00893;
	Fri,  5 Jun 2026 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780659120;
	bh=Fc9vcaYFGx4VJWN/qkM/ZED/XUOAhAtzfGEMOALwC10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LpgVnwBSDBMv2ZCVDsEcjfQRjXldbcrdFN6YWC0rquZ76JA4WLAVGYdrU2Hg0J0lu
	 b9l48jH/dtdOxXSdPpiNOqWudkX7H+Dmk6Tu9z2LXgLyILK31qQOLW7KZ2lLLYAx3I
	 fUYlaYaQdJ3iXTb1M1TogOngIKpo02yqpbd2QnvxpVH038t+JW9MFZDkhAV1DQCDii
	 dOyl2XK8+BhGI4nDZpgsWPVpoFWUOyBIbuadfyTaVSYMIvySJTlLYbadUiM4xtF7KN
	 8RLN2HjeI1uJyOM2NAk8ouza4Wv8Bl+HS7G4okRB0cqcK7sKPLJJVHjh9v1hcoxnp2
	 dAjEYyWjWwq7A==
Date: Fri, 5 Jun 2026 12:31:52 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, jgg@ziepe.ca, 
	leon@kernel.org, david@kernel.org, shuah@kernel.org, vbabka@kernel.org, 
	jannh@google.com, pfalcato@suse.de, balbirs@nvidia.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, linux-kselftest@vger.kernel.org, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, usama.arif@linux.dev
Subject: Re: [PATCH v3 2/2] selftests/mm/hmm-tests: test pagemap reads of PMD
 device-private entries
Message-ID: <aiKdccWcgUaWCMes@lucifer>
References: <20260604055308.1947679-1-dev.jain@arm.com>
 <20260604055308.1947679-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604055308.1947679-3-dev.jain@arm.com>

On Thu, Jun 04, 2026 at 05:53:06AM +0000, Dev Jain wrote:
> To cover pagemap paths scanning PMD entries, add assertions to check
> whether a device-private PMD entry has the correct pagemap information -
> the PM_SWAP bit must be on in the pagemap entry. Before that, we must
> assert through HMM_DMIRROR_SNAPSHOT snapshot that the leaf entry is
> at PMD level and not PTE level.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM, and confirmed this triggers the issue locally so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  tools/testing/selftests/mm/hmm-tests.c | 34 ++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index e1c8a679a4cf3..46e0c8c921c3d 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -2276,8 +2276,11 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  	unsigned long npages;
>  	unsigned long size;
>  	unsigned long i;
> +	unsigned char *m;
> +	uint64_t entry;
>  	void *old_ptr;
>  	void *map;
> +	int pagemap_fd;
>  	int *ptr;
>  	int ret;
>
> @@ -2300,8 +2303,6 @@ TEST_F(hmm, migrate_anon_huge_fault)
>
>  	npages = size >> self->page_shift;
>  	map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
> -	ret = madvise(map, size, MADV_HUGEPAGE);
> -	ASSERT_EQ(ret, 0);
>  	old_ptr = buffer->ptr;
>  	buffer->ptr = map;
>
> @@ -2309,6 +2310,9 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>  		ptr[i] = i;
>
> +	ret = madvise(map, size, MADV_COLLAPSE);
> +	ASSERT_EQ(ret, 0);
> +
>  	/* Migrate memory to device. */
>  	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
>  	ASSERT_EQ(ret, 0);
> @@ -2318,6 +2322,32 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
>  		ASSERT_EQ(ptr[i], i);
>
> +	if (!hmm_is_coherent_type(variant->device_number)) {
> +		ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT,
> +				      buffer, npages);
> +		ASSERT_EQ(ret, 0);
> +		ASSERT_EQ(buffer->cpages, npages);
> +
> +		m = buffer->mirror;
> +		for (i = 0; i < npages; ++i)
> +			ASSERT_EQ(m[i], HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL |
> +					HMM_DMIRROR_PROT_WRITE |
> +					HMM_DMIRROR_PROT_PMD);
> +
> +		pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> +		ASSERT_GE(pagemap_fd, 0);
> +
> +		for (i = 0; i < npages; ++i) {
> +			entry = pagemap_get_entry(pagemap_fd,
> +					(char *)buffer->ptr + i * self->page_size);
> +
> +			ASSERT_NE(entry & PM_SWAP, 0);
> +			ASSERT_FALSE(PAGEMAP_PRESENT(entry));
> +		}
> +
> +		close(pagemap_fd);
> +	}
> +
>  	/* Fault pages back to system memory and check them. */
>  	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>  		ASSERT_EQ(ptr[i], i);
> --
> 2.43.0
>
