Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686937;
	b=IWdhUC5YYL/3iSaADpigF4IcN74DlBp4PJBbO0HWX3fCRxGNnH1/6S4qii5Z7rT3p7Sa
	 wtT0ZEzG0iBVEdTLeHh7IKJ6CXD00TEETqKugpQyeLikD0WG27awKelvq4GAdEWhCBziR
	 OzO89b7ImK3O9fkeIBOb6qIrvcYu9rSJ+yXIoQAl6EdoD95eqLCawkr3DgqBmVMIPcyeI
	 OOffLNUSKlXj+Fo4LYy9Mxfb4QTlNWdgLSFo3D/J7j5o0MU9q37CGJ8iYZZze15nkeoOg
	 hTCb5v8HCKeNPsCZKIxn6+rfKArBn+AvBkncb4RZMdxEOOc7it1i4HR8GZ4zwECHn5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686937;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zG6hcFBKaarnvsPjlDpXRoRvjH17xCtphvN+Zm9vGko=;
	b=kpXmUgOo/AjUA9NkkkMMvD38MqOFjb/LNyaLjobsgItjQ+MS0YT9+jCCmDRACX7HBrpk
	 dUI+dCzkEIohOPW5M+WPV95owJN1Xw1x8snMzLZ5i7B0UIP0/dMn5iY2Nu92uoG+2xn1Z
	 yy0iq+QOGsnEJZ65hvZOqj3t5Etf6nXEMhw4LLCUDFO9qVBfkrR7AtAzw1NyfxzOkO3CQ
	 Kv92Xc3hWik0ZgCyc08n3AWVjZBMLDiyHZY84AGaKcHqfKS+KwunfG0jSm0aOYbnwTLA8
	 4+l2U8QIpfrhRw/U2Cm7eXUX3M8di/sliiPUc0KYKhWcCsjmmI2/NooPuOgrozNnmfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQCyQK5O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31454606A326;
	Thu, 26 Nov 2026 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQCyQK5O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1558E1F000C4;
	Thu, 26 Nov 2026 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795686936;
	bh=zG6hcFBKaarnvsPjlDpXRoRvjH17xCtphvN+Zm9vGko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RQCyQK5Oq863s9k3aYw7AiGhCho+53i2v7J+kSej0aI/ocNQVdUq4lvFt6yS9wDZv
	 eCN9kR32v3YmlB/SCi1D7U1M3Yghd7ekpfHMVmDLJ8msrjkNmvWAaj900YHKs1hvGp
	 YnX6O6H4V9W/1pNJqxgzNl0xLKCS3U9TMe2E71AQzKN9QTE+sPrGtJJd1otT7qyw6d
	 1WR0AjIp4ETTblf/GUeArbyJo07h2JKtDDX5MXID8jJW5XoE+vZDJEI1sC1gAFkyzh
	 wzsEQxIclL9uLGe5CKnhkKSuyNpSFlgLP/eSEDgwJyAr1fkfLDBR5MgGx3D4lV2p2J
	 rl0qGXU1iXcDg==
Date: Thu, 26 Nov 2026 10:55:17 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jinmeng Zhou <jinmengzhou22@gmail.com>,
	Hongfu Li <lihongfu@kylinos.cn>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dave Airlie <airlied@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
	Mel Gorman <mel@csn.ul.ie>,
	Dave McCracken <dave.mccracken@oracle.com>,
	Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
	James Houghton <jthoughton@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>, Gregory Price <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Byungchul Park <byungchul@sk.com>,
	Alistair Popple <apopple@nvidia.com>,
	Wanpeng Li <liwanp@linux.vnet.ibm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kenneth W Chen <kenneth.w.chen@intel.com>,
	Hugh Dickins <hugh@veritas.com>, Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Sasha Levin <sasha.levin@oracle.com>,
	Guillaume Morin <guillaume@morinfr.org>,
	Wanpeng Li <liwp.linux@gmail.com>, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-doc@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 01/21] mm/hugetlb: charge the copy made at fork to the
 parent
Message-ID: <awgCBU9wSBa_mh1D@localhost.localdomain>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-1-db27fd2f71a8@kernel.org>
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
In-Reply-To: <20261125-hugetlb_fixes_2-v1-1-db27fd2f71a8@kernel.org>

On Wed, Nov 25, 2026 at 11:32:59PM +0100, David Hildenbrand (Arm) wrote:
> When copying page tables during fork(), the child is not yet assigned to
> the right memcg. When copying possibly pinned anon hugetlb folios, we
> must charge them to the parent's memcg, otherwise we can end up
> allocating more hugetlb folios than allowed.
> 
> Let's fix it by charging the copy to the parent's mm, like we do when
> copying small folios in copy_present_page(), introducing a new helper
> function alloc_hugetlb_folio_for_fork().
> 
> This is a hotfix for v7.4.
> 
> Fixes: c2deb1356d82 ("mm/hugetlb: charge folios to the target mm's memcg")
> Reported-by: Chris Mason <mason@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
