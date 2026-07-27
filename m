Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4719E839;
	Mon, 27 Jul 2026 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153897; cv=none; b=RE56QlBVXwd03Beg7U68QoBOueZp1t/LT4Kt6Ekj9yxR5/ZIrBpPxBjV59/ZRTrYdI0dVGpGg6SM8n6Ui2BzmvxOslJN8LcrC3tiFZLk6iikfkya3bctPRpq9VxwbsHF7NyNXd87/2p7zpUt1hI4PrFq/+FhUQcX1Prd/ZAwAn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153897; c=relaxed/simple;
	bh=d3rWVDe6+XYIBaNbVaW3m/jShZa3zVRSDhJenH98a34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX1s0fqdtmcswsjtG2OBMyid5TVbUy2UOa021+uHcg/5YeUAM4LFYtwGd0rws+W74YXPRfPAwjAGQU/ZYpqbnnAoOXZxddndi4fS1kK6OYYI4paZzBnvAIk4nHfjMtgX46QLQ/kkIRqnOqzEXGhSOq/TVwJt7qBWvvKJI00mnDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo4Rpc5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo4Rpc5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C13E1F000E9;
	Mon, 27 Jul 2026 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785153896;
	bh=r/Y4BMKQ7cvWOkrCWMFKBxy8h6yza/pHmvLf8+MWpC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fo4Rpc5XZE/gO7ztNgbEH/pgiIOPr/zvBxaoQr4BSg1RSpCdgvR1BqCMiVo1vnn+p
	 BNt2HreMH4K90PYfv2tC8FtD7a050B8K9yKCxsiLzjaRVHw0nq+lioDOLHraXJKj2L
	 gmzEsWNAEN8i8jTiZHhn3ozfLum9UNBed8Tr4PWmgVQRPqIBGLkiVe0qa2G5geMXdT
	 3u2lL4F+vFvb6TDUKi5dMHS7ltztpsh9E1f0rEVvmWwisGnjlpd5cPNxoSPmUql0AN
	 JcIR/yIDKpAm1+4ZcAxz4nlNdlAhQxEW+JzN8k4CM1O58zuRkXFcKpr66D+SgJrzc5
	 ECd0XnkJVmXow==
Date: Mon, 27 Jul 2026 13:04:35 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, 
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
Subject: Re: [PATCH v2 00/15] mm/rmap: index MAP_PRIVATE file-backed folios
 by virt pgoff
Message-ID: <amdJPSyAEnF8g8qM@lucifer>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <20260720124812.30e04cc81a56dd6f0346cdf6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720124812.30e04cc81a56dd6f0346cdf6@linux-foundation.org>

On Mon, Jul 20, 2026 at 12:48:12PM -0700, Andrew Morton wrote:
> On Mon, 20 Jul 2026 15:38:26 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > In memory management we've managed to manufacture a great deal of confusion
> > around the concept of anonymous memory. We have:
> >
> > 1. 'Pure anon' memory - anonymous VMAs whose folios are anonymous and
> >    swap-backed (thus for reclaim purposes, treated as anonymous). These are
> >    simple enough.
> >
> > 2. shmem - file-backed VMAs, file-backed folios (from rmap perspective) so
> >    present in the page cache and mapped by an address_space object, but
> >    whose folios are also swap-backed (thus treated as anonymous for reclaim
> >    purposes).
> >
> > 3. MAP_PRIVATE-mapped /dev/zero - a strange beast whose VMAs have
> >    vma->vm_file set, but whose mmap_prepare callback clears vma->vm_ops to
> >    satisfy vma_is_anonymous(), which results in VMAs that were mmap()'d
> >    referencing a file, but are in every other sense anonymous, including the
> >    folios.
> >
> > 4. Other MAP_PRIVATE-file backed mappings - These possess file-backed VMAs
> >    and have file-backed folios until CoW'd, at which point those CoW'd
> >    folios are anonymous.
> >
> > This series fixes issues 3 and 4.
>
> Thanks, I'll add this to mm-new for review-n-test.
>
> AI review seems overloaded at present, might have found a few things:
> 	https://sashiko.dev/#/patchset/20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org
>

Thanks, will have a look through the sashiko stuff and see what's valid.

Cheers, Lorenzo
