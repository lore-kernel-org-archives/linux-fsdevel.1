Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305A3E1201;
	Wed,  5 Aug 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914741; cv=none; b=XHDKEuPiDmYHdvCJ86TMExkKK5bqt8+qP30KZH3wx5+vwMTKQybBayKnlVQ+D9WSXKOqC4hQUuX48m0PC+DkgOyFeyuvqQ/Zh/S5VsZyLnAWJcxGq7QactHkBSufAbB931kjHJrFsTErRnpXBkRFLTFBbKFlR1Lkuyf5zoHdKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914741; c=relaxed/simple;
	bh=/5b6tlFlpfTYD65PcPgqOjl3ImUqCtxBn6cQQ3Qvnv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF9YF3iiZHWOYf+nM6RcRStueGf40c2oCWBVjQ21o1BMCLCsl9MRIU9Cw80PcEjtSuj1VbK9ILeEM2aIk9uztrkusKUHBk5WYeeZY+AqJIz5utZXBOWPuHfJmOTlIIUWUQjupNhv8vV6kvfGKZyifRn5qaCociIDdz4xUKZ7iwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJAnyke/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJAnyke/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9F31F00A3A;
	Wed,  5 Aug 2026 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914740;
	bh=2JXqpQV0NjLsf1xiQKEbDdQ70WObdlUyTlYYy/kTGrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JJAnyke/EwYDi87GOHBCKaeCVp0G7y3cs8S/wZaXXAdTXu4eFCW9jV8bXyJz0XTBp
	 Y59DjAkbYzgJR4Xbn3ijJuOyURRlH2G5QYfD1m/Q/By9/3RR5IzjY3exP70+Lsbr+O
	 7xfVSGK5+uj8M14+m1XFsPsZu8gb8JRzNUB5Z7Qg1W1pXWKOJocwSBn4muyILbctXe
	 VnoyaZpBK1wGiQ/B4OBec11Pdl4X7IKTcHnM7rO1RcGST1MZrePAAZ9YROj1oivOBH
	 kD8eT9e6sBWr4f8t9GuWcPCV7ENYta78+GVmp7jWuRUqPMnoSJc71VBYDTYD/KcwP+
	 2Mf6eTPlQJzKA==
Date: Wed, 5 Aug 2026 08:25:18 +0100
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
Subject: Re: [PATCH v3 07/15] mm/rmap: track whether the page VMA mapped
 pgoff is anonymous
Message-ID: <anLlVomkachZWbk-@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-7-e8ecfefea812@kernel.org>
 <1b48cf7d-8906-43d4-a85d-5cfad10a12ac@kernel.org>
 <anCcMvnsux22LaWU@lucifer>
 <007258ed-3fd7-4d90-b909-6fdda15e0485@kernel.org>
 <anCmQdKzZFRMqcxs@lucifer>
 <f31fbd7d-2e8d-469e-ae8d-abe5b7f6e236@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f31fbd7d-2e8d-469e-ae8d-abe5b7f6e236@kernel.org>

On Wed, Aug 05, 2026 at 09:17:26AM +0200, David Hildenbrand (Arm) wrote:
> On 8/3/26 16:32, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 03, 2026 at 04:02:45PM +0200, David Hildenbrand (Arm) wrote:
> >> On 8/3/26 15:51, Lorenzo Stoakes (ARM) wrote:
> >>>
> >>> As per commit message:
> >>>
> >>> 	This is laying the groundwork for eventually using anonymous page offsets
> >>> 	as the index for all anonymous folios.
> >>>
> >>> 	No functional change intended.
> >>>
> >>> I cannot enable an effective change here, because if I did I'd break the kernel
> >>> and introduce a bisection hazard.
> >>
> >> You can just throw in a patch that cleans that up and avoids messing with confusing pgoff?
> >
> > You mean do a separate patch for this change?
> >
> > The existing code is already very confusing :) it becomes worse with the
> > anon stuff added, hence the change.
> >
> > I will separate it out assuming this is what you mean?
>
> Right, if the vma_address_end() is not required in this patch (and does not fall
> under "track whether the page VMA mapped pgoff is anonymous"), just have it in a
> separate cleanup patch "prepare vma_address_end() for further changes" etc.

Cool, will do!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
