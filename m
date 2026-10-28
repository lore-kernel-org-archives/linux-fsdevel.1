Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179193;
	b=Wk0W0QhCGmkHNM5yfoktoCvbytXbrAYUJK+HmfH4e8LB3d0dsipqMq7FkC5TfZb94yOK
	 u6bwIvX4sEsf+Dc2w+44uyyj6v651X+hmtodQzIx/OMgT9jv6sIX2FKmxAVa1h6iGnWeg
	 nZ2uhK9XnYx+MIV88FV4c5sfmQ9EkpEPjWbTIqyTBJGkY3zZdYS2DG2JAOXyFfoudv109
	 FLTK55P80xUtffEb4tPYFqnbcMuNybBKJ7g4NZAa2uXujZAIcM1AhyPqrnJbGlagZ6EU0
	 XsKdjhDZlAgx1N9HoDpna8DzO9MLy6Au9mAMBIQXzPB0t7hPARQcXYU10WAhOksh1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179193;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dIQYEI2EXBN3ZRTF+vP2Ww75sjtd+SHDiG1ARLFc8yU=;
	b=sRwF/sFzLjTWxoaIEmRZgMVqiNXr4AKRpgy+R1a5fI9VhjLKdh6J3SB0fhCtKmffWsTz
	 RjpXn60nX9xhuUyNqJrQmJRg5SLl4lkyQt4flb8edSPVIDv8BIHAKy8TObP3QKWfRKtTC
	 xZMlonByR5rd8cyCWpT37iix/+0IZVjclygFqg8AXzazqjrCkhrknZJXqYD6Hg1K/p6Xx
	 vbyIMh1sbc+QEaYFyXr4RKNfPRiSeIrWbfSpjusz5sb2CF1+62bYVrASWD81/SXkxFpSP
	 vVZWyqcunILqofNT2dOWNyHsvJ8imtP/SS/uOAOE9NDNuJI7HWcsYXsTKAW+vtq56jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XM6ZOwO4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE7606A31A;
	Wed, 28 Oct 2026 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XM6ZOwO4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A155B1F01825;
	Wed, 28 Oct 2026 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793179193;
	bh=dIQYEI2EXBN3ZRTF+vP2Ww75sjtd+SHDiG1ARLFc8yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XM6ZOwO4JL0qURt+r1Tt40S78pKBud1WZEdBrmgnRYO1IHQx0nw0QpogbIOKyGmPe
	 Km3z6nNDakO14FRuEqVD6fltowQlZ7IgPD5kjEDVcYIT1DkJWmyClJk0abCib41owt
	 ySqTJ4L0jCS75jvustKWciug4KaYB90KVfbHVKFjON78MKKpMEI32cl6UGp/XSzUII
	 Kt+zseF0qDmtZCYGqCVS+eiWZXxUj2/KE/n3JtTF2FAHW9dMBKdWWQ6H/zFUAAGvXn
	 mIlgh8GMe/IxdPt8AUsOnaUV6MHtzeNJ/Fh2zHVde2ypPbt8fSQBCXfsZPFDK7ZnEF
	 8MYy195BPQYgA==
Date: Wed, 28 Oct 2026 09:19:46 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, david@kernel.org, jannh@google.com, 
	liam@infradead.org, willy@infradead.org, paulmck@kernel.org, pfalcato@suse.de, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
Message-ID: <auG-BfTvZo1Ejxmm@gremlin>
References: <20261028051312.1505295-1-surenb@google.com>
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
In-Reply-To: <20261028051312.1505295-1-surenb@google.com>

On Tue, Oct 27, 2026 at 10:13:12PM -0700, Suren Baghdasaryan wrote:
> Pss metrics can be affected by map count even if VMA tree stays unchanged,
> therefore test checking VMA tree integrity can't use them. Use Rss instead
> and pre-populate the VMAs so that Rss changes if a VMA gets skipped or
> double-counted.
>
> Fixes: ca5480fb53fa ("selftests/proc: add /proc/pid/smaps_rollup tearing tests")
> Reported-by: kernel test robot <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202610271934.fd287c3f-lkp@intel.com
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Seems sensible, I gather in general PSS is a less than ideal measure in these
stats anyway :)

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  tools/testing/selftests/proc/proc-maps-race.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
> index bf4c5073f6fc..b6d88afb252b 100644
> --- a/tools/testing/selftests/proc/proc-maps-race.c
> +++ b/tools/testing/selftests/proc/proc-maps-race.c
> @@ -528,13 +528,10 @@ static bool compare_smaps_rollup(FIXTURE_DATA(proc_maps_race) *self,
>  		struct smaps_rollup_stats *actual)
>  {
>  	/*
> -	 * Clean/dirty metrics might change but Pss-related ones
> -	 * should stay constant.
> +	 * Clean/dirty metrics might change. Pss depends on map count and might
> +	 * change as well. Rss should stay constant.
>  	 */
> -	if (cmp_smaps_rollup_stat(expected, actual, Pss) &&
> -	    cmp_smaps_rollup_stat(expected, actual, Pss_Anon) &&
> -	    cmp_smaps_rollup_stat(expected, actual, Pss_File) &&
> -	    cmp_smaps_rollup_stat(expected, actual, Pss_Shmem))
> +	if (cmp_smaps_rollup_stat(expected, actual, Rss))
>  		return true;
>
>  	print_smaps_rollup_stats("Expected stats:", self, expected);
> @@ -759,7 +756,7 @@ FIXTURE_SETUP(proc_maps_race)
>
>  		for (i = 0; i < mod_info->vma_count; i++) {
>  			mod_info->child_mapped_addr[i] = mmap(NULL, self->page_size * 3, prot,
> -					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +					MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
>  			ASSERT_NE(mod_info->child_mapped_addr[i], MAP_FAILED);
>  			/* change protection in adjacent maps to prevent merging */
>  			prot ^= PROT_WRITE;
>
> base-commit: 39274b454e9993cea319f4ac342a8082a9ee1730
> --
> 2.56.0.307.g5fe7bd680c-goog
>

--
Cheers, Lorenzo
