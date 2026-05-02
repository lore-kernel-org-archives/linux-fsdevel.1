Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5519C54E;
	Sat,  2 May 2026 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696739; cv=none; b=lgDWy5y1ZCUter1KBPsUh6GFr5JxDisOBh/Ze32varUYFk9Dut1HvDhj+qcUxUw9IDNPLoMVxO6noKqASD3HbE6F7d2ibHMjXnH3EH4X4QLh+oCDTYzkbUJcrGu1kGBHsjXWWAmZvlXR7oNax3p1Wz7XT8Pf6bDrcxHtF6q0OiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696739; c=relaxed/simple;
	bh=i3HcnCoFSh5VeBUTX60vz5hhURORR//pulP1rg20n9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAjrayFyCOi6+dSaCJ2t8uBK2FscyiLDQc9P5t4rda16cWy1tE5zJkwS30yFGNyqxmRcAcVWHHjCzlpMXfrlkVofA7UvkVMo7Ab+eK7Sc6WKfuZpwH3fOZe0GvWr6uTByQ7G3KNzAgDDuvggFz7tQTrFSQFnACKSykhjM/TrUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVKJ9QQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVKJ9QQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8719AC19425;
	Sat,  2 May 2026 04:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777696739;
	bh=i3HcnCoFSh5VeBUTX60vz5hhURORR//pulP1rg20n9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVKJ9QQWutEfe9rAD+mi+pF45Z+hx9zEJw+1jfpjjALUmVFLVPc+Bnd6N7BEaRh8U
	 QAmwKGNurLzdjVXegKoUIxh+qlfzEtZV5xDMUKHlaQCVfxd0hPiYW2bYKe/b+HwFck
	 ZkicFJK+o1uv0fhywnlKzvoV0zJPot+LU4FSCtOC9GdY2e+uwe0VXDEFw9ptR+6g2I
	 D/I4qE9yKdDvBiX99H6gcwVaUQaei5uAK2OzpiiHEpdz1nepKvVTzynTZpUmvNXYfj
	 qui4o0Vfj4fJxQV/0KPquo0ZXKStj0WahceE7D2wFsji+x0TnslildM/KwG+n7O+UV
	 ILn3tO03CuwoA==
Date: Sat, 2 May 2026 06:38:53 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Peter Xu <peterx@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] userfaultfd: merge fs/userfaultfd.c into
 mm/userfaultfd.c
Message-ID: <afV_3ZZ69cpeYmpS@kernel.org>
References: <20260430113512.115938-1-rppt@kernel.org>
 <d5f17a01-4504-4a7b-b58d-c183cedc37f1@kernel.org>
 <b31e1b5e-511b-4213-a8f8-d9721959d709@kernel.org>
 <afNtnXnU4J6syETa@kernel.org>
 <c2ecd0c6-fbb8-41f4-a7fb-2b1f15d1fa12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ecd0c6-fbb8-41f4-a7fb-2b1f15d1fa12@kernel.org>

On Fri, May 01, 2026 at 08:33:04PM +0200, David Hildenbrand (Arm) wrote:
> On 4/30/26 16:56, Mike Rapoport wrote:
> > On Thu, Apr 30, 2026 at 04:23:08PM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/30/26 13:38, David Hildenbrand (Arm) wrote:
> >>>
> >>> Yeah, makes sense to me!
> >>>
> >>
> >> Thinking about this, is it reasonable that the kconfig stuff stays in fs/ ?
> > 
> > But it's in mm already.
> 
> $ grep HUGETLB fs/Kconfig
> config ARCH_SUPPORTS_HUGETLBFS
> menuconfig HUGETLBFS
>         depends on ARCH_SUPPORTS_HUGETLBFS
> if HUGETLBFS
> config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
>         depends on HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> endif # HUGETLBFS
> config HUGETLB_PAGE
>         def_bool HUGETLBFS
> config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>         def_bool HUGETLB_PAGE
>         depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>         select SPARSEMEM_VMEMMAP_PREINIT if ARCH_WANT_HUGETLB_VMEMMAP_PREINIT
> config HUGETLB_PMD_PAGE_TABLE_SHARING
>         def_bool HUGETLB_PAGE
> 

$ grep -c USERFAULT fs/Kconfig
0

HugeTLB is another story.
 
> -- 
> Cheers,
> David

-- 
Sincerely yours,
Mike.
