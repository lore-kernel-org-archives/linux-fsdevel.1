Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769430BF6F;
	Fri, 20 Mar 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029887; cv=none; b=K0VYun5PXUJpt9yvYOdW/PsdqGbtrMg0847CN5HQhVWu9059lNFfPANvLFmI3hxOu+yQY9CF434MTNwk4ecRJnaD3RtrM81/MpV1wJ/Iohawcb6gFXG1UK0UER8KcIFdWlQuXOg6JXHp5eWkujr5r/tIVTcNgHtRmiHOBBcgUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029887; c=relaxed/simple;
	bh=unEPL0G7kl0V7ExcXjxu9/JvZIzmQqH2o3lcKsyYewA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upqz38afMu/42axOQ1BM3KtykPllqJ0asMSGUpOCU9GnT2loZIDzK9qzwg2ZS4iyURu6Nu536amZUxuzyCgY7JlPYhJyUhoeoXAFGkIrhkTV7kYc+YikwuW5RQTU8f9fzazQdxeGrGX98xbmqWSrLH6EW7i8uq0HZtH9TOVNh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ27rco1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ27rco1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72E3C4CEF7;
	Fri, 20 Mar 2026 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774029887;
	bh=unEPL0G7kl0V7ExcXjxu9/JvZIzmQqH2o3lcKsyYewA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZ27rco17AvaGnAfGjFv9fbjrnbNb/BfO9dekg+xvlPU72urVZEkIzQpheARdN7oX
	 Vs+NgmZp+tgmAcl/lUCr2UacLZ4Wxpf7npLq9DnOZT3HVnH5Yk4s4isbLmGzDB4MvF
	 oKCYhNOBcuUByFR8bTJ6KnUKKU5lIxVvKIpQfayYigwTI55RVHFL5ZQ4weHd7bGSqd
	 SygD3bA0+6GCLc0tbuV2U5dpwx1KjI2k0/7rKvD9CqKVfCZCWfWGU5abrkU1SRTj2u
	 4RkQ5sTSvE/IAINSi62Vr5lR00XN1qvOb+/BEVRBRspH02p8UXpvsau70MqGNd3rOq
	 T8IxDYaCzldog==
Date: Fri, 20 Mar 2026 18:04:40 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>, 
	Eero Kelly <eero.kelly@dfinity.org>, Andrew Battat <andrew.battat@dfinity.org>, 
	Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/mm: add folio_split() and
 filemap_get_entry() race test
Message-ID: <def912db-ea7e-4cac-afa2-8e0b9c279549@lucifer.local>
References: <20260319190409.294523-1-ziy@nvidia.com>
 <6b087c27-a5d5-4f49-81e6-1204209b0c89@lucifer.local>
 <D60C0C65-11E3-4060-9295-B67F90E9D774@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D60C0C65-11E3-4060-9295-B67F90E9D774@nvidia.com>

On Fri, Mar 20, 2026 at 01:58:18PM -0400, Zi Yan wrote:
> On 20 Mar 2026, at 13:53, Lorenzo Stoakes (Oracle) wrote:
>
> > (-cc old email)
> >
> > On Thu, Mar 19, 2026 at 03:04:08PM -0400, Zi Yan wrote:
> >> The added folio_split_race_test is a modified C port of the race condition
> >> test from [1]. The test creates shmem huge pages, where the main thread
> >> punches holes in the shmem to cause folio_split() in the kernel and
> >> a set of 16 threads reads the shmem to cause filemap_get_entry() in the
> >> kernel. filemap_get_entry() reads the folio and xarray split by
> >> folio_split() locklessly. The original test[2] is written in rust and uses
> >> memfd (shmem backed). This C port uses shmem directly and use a single
> >> process.
> >>
> >> Note: the initial rust to C conversion is done by Cursor.
> >>
> >> Link: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/ [1]
> >> Link: https://github.com/dfinity/thp-madv-remove-test [2]
> >> Signed-off-by: Bas van Dijk <bas@dfinity.org>
> >> Signed-off-by: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >
> > No .gitignore entry? :)
> >
> > (Just saw it flag up locally in git status)
> >
> > Linus says don't remove, but he doesn't say don't add :P
>
> I did not know about that. The fixup is below. Thank you for pointing it out.

To be clear I'm referencing this re: the .gitignore _removals_ ;)

https://lore.kernel.org/linux-mm/CAHk-=wiHK5_oBUdUiNAaevmN9f-ORe+QBqbRefAZaw-RbgEn3w@mail.gmail.com/

Thanks! :)

>
> From bd164a7090c0e8b6e3013502c64c161214e38714 Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Fri, 20 Mar 2026 13:56:04 -0400
> Subject: [PATCH] git: add generated binary into gitignore
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  tools/testing/selftests/mm/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 83ad9454dd9d1..b0c30c5ee9e30 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -61,3 +61,4 @@ guard-regions
>  merge
>  prctl_thp_disable
>  rmap
> +folio_split_race_test
> --
> 2.51.0
>
>
>
> Best Regards,
> Yan, Zi

Cheers, Lorenzo
