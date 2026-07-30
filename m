Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5343A6F0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387510; cv=none; b=jE9fBPs89nF70i1XOMToi9Kkl/StDIYyJKAZ1ffbLKu3/oZlqSwRXP2wOcDgLf4GlIHV6Bw90OVF7IL+xLAjQ6qPVvunJd6HbUgUkJaXB+VZl6UqhAZaLB7Y+3+IysWx/q1VoxEMxUBYzvLNQ8V7vZqKZqHy0YgheYjeXg882aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387510; c=relaxed/simple;
	bh=6EKgm8nuEG6R+AQ20jjnZXhzmrZkg1EifUJZW9092GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVudnNbdxsD+q53boi4MM3PWsrQCTxjnOoD+QkZmvLskggbfgq+T4Vb7f01fgHcv2hjJOymv57SXxHl0YYXp3D+Y2NdrYulFrW7+/XFeHSKsYRFOahbTd1b0/bXAMy1xStRa+zDQ0oGjghcYxJEr4/nAy2zr1YJD8O+ALW8R3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Zgr+uHwZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Zgr+uHwZ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c16ac21acso11002351cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 21:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785387508; x=1785992308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xIFNfpu9gmD/EDvYhBb6eSwchsbOBYYW3f9ffk0DLHE=;
        b=Zgr+uHwZx+4ITvHiYBh9Qa8KDJP6qDAapn3BuVDzwPzLza0c/r4b0c/lF9NC++oCVX
         ag1bkpzDt4VsgWbF/T0ZDf2YBbAZlvuKuoAzqZ6fRXk+GqLtj0Jx9fql6DxqiyBquuo6
         FuXF1KJpjGuJBcGLUiorZQflwv738+KY/vSH49lAGpusbofZLMUh9H2vRnolNXkrsYxO
         0vKN2IRNALffXpg8lfx0tWowJ6XbB18l7cskv9GIrOAm9bAdVhGoZzVD/hAux4phZrfR
         gNx61MBFdGM2cSoFnsgFlVzcq9afpEUOYMGUzXcoOFTb2oPP3dKzGqJapQKdit/RPQCm
         m6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785387508; x=1785992308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIFNfpu9gmD/EDvYhBb6eSwchsbOBYYW3f9ffk0DLHE=;
        b=FeqXWWGwJEhjYKDkegv9bq0Tx46hOFsSLoVngOE1+NEyGqYcP9v+8JRelzqEnur7vo
         LzRHU7S7bQc7iZickE/EttxUfdZNZfCRjEI+bCopjqXU44oJ4unoQ/Stm3g711m5XIXB
         DxBYWS4qo92talXORDoXIDhHIcc3PENcZCJ+6DWYfefwoJcmwjTh3NZkS2Xka9tjJfO0
         Zk9gUUfBb3F2o6omkqiNHAAPmvwG+AwPM5TtSdqZdIMW3lsEZOUapTLeJ97ZBEg3EFUw
         3iEFQMgBe82nbeEx4+Lj78g3+lbatbtblT7zvWbqhzuPcEy3wTsuFGtm1IcyeDWFlesP
         MTkw==
X-Forwarded-Encrypted: i=1; AHgh+RpCIolxXy8YlaIPcVSQ0vBNcrql/RKXavq8IOWMuaahnLsNcRj2PzfJi3i6Zlc4K/AF2Vc0yHhevhHt9X0z@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8LicN1g6zQcjLyC333TM1vFVIN1oIvD9IdNYKGsGM99MP5qC
	4LxgJtXug9DrkfJUuFrjncCDQ97wGCPZu3uW+0nJgJGyXcO4Y7SMXlcGmZZ5dq73iDE=
X-Gm-Gg: AR+sD13kbtUpaJU9JxCc6NCOjRIxEMCK9716Q0Kt0RSR3ckVcZwcPqY+dt+FpybKSmD
	lrlxqtUA7mK+9QtFCKrcG1c/vgMmPPpJfl/9rhJ+CMhXs6WvjbIBfjESOq/Ig/O2Qy4fly0dCVM
	CKyZukqAri+lDybg3P1znkKXwVQTWs8F+bW4gkr3zht1ydz9BlqjiMD7gKPuj/Z+JXzK4JPqffr
	x5d3ULXxOpXvQCH6WZNyobzDTcPqBUTfYnrpsL0N9Y4Z1fYmicNOXLw8HSlFGbE91acr8kDbi4o
	O5dG/etR4AOswsFiLBQX6gOfu0JGk5C5Zz5canWOsRRhuy9z3Czio7L06Yde4dP21SJf2p4qzVn
	oUJMLDVPOz0icwYImLRtLoQGSus9Xx5UUXSYDlqelwmurqMQIAAt6vMffJ1dLA+il258a7VBDUS
	J8tGFFGuf45AaWEY17LUyzDTkE1V4frXcj4IqE2Tz6SxtDkJ/YZXkZy4uzfLEZnyvf+wVyrSKv3
	rYvlsfgq9ABidvrlxb9FGwLiqKXS/QK6eEXdD+IjeTX
X-Received: by 2002:ac8:59cf:0:b0:519:51b1:e764 with SMTP id d75a77b69052e-52b38662c5bmr13461711cf.47.1785387507988;
        Wed, 29 Jul 2026 21:58:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e733a27esm338204685a.34.2026.07.29.21.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:58:26 -0700 (PDT)
Date: Thu, 30 Jul 2026 00:58:22 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 03/15] mm: abstract vma_address() and introduce
 vma_anon_address()
Message-ID: <amrV0Y7ZUtihiB2B@gourry-fedora-PF4VCD3F>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-3-e8ecfefea812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-b4-scalable-cow-virt-pgoff-v3-3-e8ecfefea812@kernel.org>

On Wed, Jul 29, 2026 at 05:48:38PM +0100, Lorenzo Stoakes (ARM) wrote:
> 
> This will be necessary for determining the address of a folio's index
> within a VMA when the folio belongs to a MAP_PRIVATE file-backed VMA but
> has been CoW'd, and thus is anonymous, once the anonymous VMA page offset
> field is used for the reverse mapping.
> 

This is a doozy of a sentence... 

... determines the address of a folio's index within a VMA when
  - the folio belongs to a MAP_PRIVATE file-backed VMA, but
  - <The VMA> has been cow'd
  - thus <The CoW'd VMA> is anonymous (as well)
  - The original VMA may or may not also be marked anonymous?
    (just clarifying, could be original mapper or a COW that COWs)

Ow, my brain.  One question below

> +static inline unsigned long vma_address(const struct vm_area_struct *vma,
> +		pgoff_t pgoff, unsigned long nr_pages)
> +{
> +	return __vma_address(vma, pgoff, vma_start_pgoff(vma), nr_pages);
> +}
> +
... snip ...
> +static inline unsigned long vma_anon_address(const struct vm_area_struct *vma,
> +		pgoff_t pgoff_anon, unsigned long nr_pages)
> +{
> +	VM_WARN_ON_ONCE(!vma_is_anonymous(vma) && vma_test(vma, VMA_SHARED_BIT));
> +
> +	return __vma_address(vma, pgoff_anon, vma_start_anon_pgoff(vma), nr_pages);
> +}
> +

Why make the caller have to know anon vs not-anon if you can determine
from the vma bits which vma_start_pgoff variant to use?

(I suppose this is probably the entire point of the series, just trying
to get some clarity on the increased API surface).

~Gregory
