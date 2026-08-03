Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACB3793AC;
	Mon,  3 Aug 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752131; cv=none; b=NqGZLgce8tduEIK1jumpcCWQ5K8QSA14TyDOv0hMyjsOIpmQ0yX4nAL6gmA6n+n/TIpt1MDzPbxCKELL/GBnrGoi7p9hR7fiugKv+C1Ci5Zs4rbDuW12Jc1LE3emlQ0y/1F5nH0l7qWOL0/3AYDuaHxIz5nIMagIWPGzIq3Pr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752131; c=relaxed/simple;
	bh=v71BYkAHIRI8Q8frz24K9WW9baJGdIZiJra6zVG9U4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd05je45ipkivU/Q1YCL1CqIdbIbi0SSWQGul1H38IWTl596aCRj7ipZvD/1F77/OYNiGnip4rntqGAD1TgTy2+tRKKAoH4mYMbcSTQmPkbgE6EHkBWOyWVlUqG9BQE0E3P65JHmnM7yQbyDFSI6rsayN+XFiGrxTzjFJvTMBVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2TVK2uX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2TVK2uX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747321F00A3D;
	Mon,  3 Aug 2026 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785752129;
	bh=v71BYkAHIRI8Q8frz24K9WW9baJGdIZiJra6zVG9U4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2TVK2uXiY0cFJv633nAghYxOTtWj4WoRxazTyou1qgggoZymwvopm2LYCBg2kGds
	 ymnEUF629L7pEfyiNWowUOOSJQuuFRFGV0mUPgZhuLD0CLW+vIr6c7Geq2Pma137YW
	 7OE4bzALZg01VNZS4/a6HHR0z4/2doG6N70QflXd/8HfBF5LxlbDxZHougZiJEavRk
	 UPdaWF+jiInQXa4aETFFy0RaM5skKQ+gkvmOLWR3CfSgtF+rR82OhQEep61xeS09aB
	 dz9eVzhUmkqmOXcqJfvphbCw7TqLCjh3jYOIQtdjIp2vHvzAJ8qyVFEMto2DgiH17d
	 n2cE1J7UNfRQw==
Date: Mon, 3 Aug 2026 11:15:08 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 05/15] mm: introduce and use vma_filebacked_address()
Message-ID: <anBpy-uFv7Ghdr1q@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-5-e8ecfefea812@kernel.org>
 <73adddc9-4321-4f6d-ac67-470c8f515fff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73adddc9-4321-4f6d-ac67-470c8f515fff@kernel.org>

On Mon, Aug 03, 2026 at 11:54:31AM +0200, David Hildenbrand (Arm) wrote:
> On 7/29/26 18:48, Lorenzo Stoakes (ARM) wrote:
> > In cases where we know that the VMA is file-backed, use
> > vma_filebacked_address() rather than vma_address().
> >
> > This lays the foundation for using the anonymous page offset via
> > vma_anon_address().
>
> I was briefly confused why we can't do that immediately.

Because everything has to be switched on at once or it breaks things. Obviously
you could use vma_anon_address() for pure anon but at that point you're only
confusing things.

This all stems from the existing situation where anon folios might be indexed by
EITHER a file offset or an anon offset.

In the end 'laying the foundations' makes the actual 'switch it on' patch (9/15)
nice and (relatively) small :)

>
> >
> > Also add an assert to ensure that the VMA whose address is required is not
> > anonymous.
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
