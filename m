Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EBF30F7FB;
	Mon,  3 Aug 2026 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752380; cv=none; b=FUlXs6cW3MZDbmGmisgddaUWat9kzYKf1Rlg8CHke6SXuzSXPi/6koCqvQdKy9ukEyo2TuBoqj2t5B9V+rfqA3ec63RD4neeIHq5p7GnF6CkzTMNoiEz3KXEXSwwsxncQCb+YUAt6+xCnMA1En6Oh5H/0YkKWaeXbGBZq0rDCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752380; c=relaxed/simple;
	bh=8Calt/307KNtJWkdgXAaLvbQuXAUY9A61wZewMbZh70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv0SOmsRCFjuGNafaaO30wLCdsVGTBWKlMpDfs2jn4JJiA+150d3x6MxqZVdSN2zULtWX4HlqPVVyEu5KfpZEGRB9QvgkYaQWoLhIst9H497VwBIXzURuJqpTC7w5Zhp1GvUgg7RXqjW7RM41RW8R4YWX5cGbGxiDLVa53PeVWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng5+8DMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng5+8DMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC771F000E9;
	Mon,  3 Aug 2026 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785752379;
	bh=8Calt/307KNtJWkdgXAaLvbQuXAUY9A61wZewMbZh70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ng5+8DMZLWORmfsZsD86xD4jesgzvb9X5altilrjo/7i9jmsg7xuKWjOJ/gfRV5tO
	 8fzVFdM1AIWECwrfdrJ+TXz2wZLM+iclMvXu4n30Ls6HFiva8ZNxrp4gyqEilXbqnZ
	 6BAZcBS/dOD/8BPCwmOigxUn9lQIrS2VqYBNXPqfOMVmS+uRPQ01Ve9VdV/ZfP3E6B
	 ts3Tw7GIIWTaJQTeTaSwKDpF6lLcECWEXdqN2Ml3JxMKEEC5KbJajQYO9otNUffjEw
	 DpyBexfE3thgwcsqwEriB9WeApPb4CMgalZLCUSwtevtR5O5x4yU8qqhqcqZUSo0ys
	 bVC7pGX6AxNXQ==
Date: Mon, 3 Aug 2026 11:19:17 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
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
Subject: Re: [PATCH v3 04/15] mm: update print_bad_page_map() to show
 anonymous page index
Message-ID: <anBqV9z6hVLIqoIn@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-4-e8ecfefea812@kernel.org>
 <amrvgjPNfKqWPUU0@gourry-fedora-PF4VCD3F>
 <fec1be38-406d-4656-95eb-048729afec40@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec1be38-406d-4656-95eb-048729afec40@kernel.org>

On Mon, Aug 03, 2026 at 11:39:11AM +0200, David Hildenbrand (Arm) wrote:
> On 7/30/26 08:32, Gregory Price wrote:
> > On Wed, Jul 29, 2026 at 05:48:39PM +0100, Lorenzo Stoakes (ARM) wrote:
> >> This is potentially useful debugging information and matches the existing
> >> page offset provided.
> >>
> >> Use the raw __linear_anon_page_index() function so as to always output this
> >> value regardless of whether the mapping is file-backed or not.
> >>
> >
> > Begs the question whether we should mark the value based on whether
> > it is file backed or not, but i suppose you can gleen that from the
> > other printed values (anon_mem, mapping, vm_ops, etc).
>
> You mean something anon_pgoff_t or what did you have in mind?

I suspect he means e.g. adding a (A) suffix or something? Like page offset xxx
(F) or yyy (A) I guess?

For anon_pgoff_t it'd have to be a typedef struct { pgoff_t val; } anon_pgoff_t
to be meaningful and then you'd have weirdness with assignment to
e.g. folio->index/other calculations, and especially linear_folio_index() which
returns the right pgoff_t depending on file-backed/anon :)

So I don't think it'd be helpful, and the asserts already prevent incorrect
usage.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
