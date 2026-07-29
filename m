Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30342C50B;
	Wed, 29 Jul 2026 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345144; cv=none; b=b0rnDZ2esOW97AQ3Mb//Wrx0RMHtgN5+SqV2mrv8lhT2XRoy95cEpmFPBLtwXs78btK0hEcv138bp5tjRECqjOe0GBSTFfePkfSJe4VQkkXAnyF1zBTkKB6oL27QabFJbjeOes0FGyzQdw6ap0pYK4/MCSaUPDWPLK9HX2gG1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345144; c=relaxed/simple;
	bh=ydzhtkpxp5BQwBhGox1Nkoqh6PfrK9kxbIuBs5y9N6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpN8b3EqiUP9eYQcylgei/J9pCXaa0pfifQsDHYWTfx0/2SVXGB9c7UGi6JMgZMSsiuC012kxOT9eorP6qoV3xeYTKXX3nALBjy+G+en6U9dM2G17f+yvFrGHeFXkwGT4AIA01mmT5AZAMPnsQB4vOOgye0aIhDSup46PWPeUFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Arj5dKsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Arj5dKsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E102D1F000E9;
	Wed, 29 Jul 2026 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345138;
	bh=ydzhtkpxp5BQwBhGox1Nkoqh6PfrK9kxbIuBs5y9N6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Arj5dKsiADp8nzEpUb2nTNNXinho7z4KB+KTxpgxU3M3yvn60+RFOmnNHG5ecfqAJ
	 UQ5o7ZZJ1dBuhIe5OQAvmNXX804KdLEqbcExYpeFPsKkoliynK1brjrpy8v8wuVNAj
	 9tsdNB9T1AJ3pPoagVRqpo6EY7IIkwOzio0o/hV19or7vSRjVCruI+SX9wHjpCpWnq
	 3EVAHecRj4333tJh3roqqmzcBe0I4jHe1JIFXeEFLRONNo0TQ602dozpVVFamqGigb
	 v9VRmlJMbiQHnQnkwOZdOjZN+AHhn5XH/rHEPDgAnTOiyDBTaFAU4M18N0KZlIcwPZ
	 qX4IkiEsH6+6w==
Date: Wed, 29 Jul 2026 18:11:56 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
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
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 01/15] mm/vma: introduce VMA anon page offset field
 and add helpers
Message-ID: <amo0FZFM238Xd7BT@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-1-e8ecfefea812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-b4-scalable-cow-virt-pgoff-v3-1-e8ecfefea812@kernel.org>

On Wed, Jul 29, 2026 at 05:48:36PM +0100, Lorenzo Stoakes (ARM) wrote:
> This patch establishes fields within the vm_area_struct type to store the
> anonymous page offset of VMAs.
>
> The anonymous page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT
> if they are unfaulted or were not remapped, otherwise it is equal to this
> value at the point of first fault.
>
> Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> file-backed VMAs are tracked by their file offset. By adding anonymous
> offset as a property of VMAs, we can now track them by their anonymous page
> offset instead.
>
> By tracking this, we provide the means by which to eliminate this
> inconsistency, and more importantly lay the foundations for future work for
> the scalable CoW anonymous rmap rework.
>
> This patch simply adds the fields and some simple helpers. Subsequent
> patches will update mm code to make use of these fields correctly.
>
> The fields chosen are packed in the VMA such that, for 64-bit kernel
> builds, no additional space is taken up.
>
> The first field is present on cacheline 0 containing key VMA fields, and
> the second on cacheline 3, which contains file-backed reverse mapping
> fields.
>
> Given the relative time spent accessing reverse mapping fields as well as
> updating them, there shouldn't be any performance impact here from false
> sharing.
>
> Update the VMA userland tests to account for this change.
>
> No callsites are updated yet, so no functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sorry I forgot to run b4 trailers -u :)

Andrew please add Xu's tag (thanks Xu!):

Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>

Cheers, Lorenzo
