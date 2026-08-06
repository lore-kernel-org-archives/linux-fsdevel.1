Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7AF2C1788;
	Thu,  6 Aug 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029298; cv=none; b=GmhPxm+8Gljo5cyYKAl081R5sPKxfi++ZzOVw0A2Yq1iuIVgFXMTx2+iFQ5VTTp+KGz1rKztxSWXtwar12SzysUZ2rLQRYGYvIn5jAwyJZihp58COse9LtNUhUSmQ6UZPJFA0CLyVxDeJ6eigZ8kF2khmUEETfUMCSJyrkx7q/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029298; c=relaxed/simple;
	bh=0gz7suqV6zJwbzCJhWohHjNsiVLrtP7ClXSPkuB5PnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8oOsmZoRULQgMc9cadcLOzN/EiGP1EHUFLIrjEb+wILlphNv0aWby37zMwed3yA4Yt/zuMn360kZ6YHbfIewLt2UrHFQsc24p/DT9Dv/HWrqx0Neo+jG9TRkxtBRMUAldM8wKMbNU52qIWKUWd4YkmvmUXUf3YDDVuYAcO1s5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC2JGg+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC2JGg+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30B01F000E9;
	Thu,  6 Aug 2026 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786029297;
	bh=LNojBxIz0vThpBVl3Qav3XEH341Ryu1t4zQtn8G/oTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XC2JGg+7zYOmBa0UGt6iVeCJkX9jXPWxjSpNJo8xy1H2kumCT7sMgZ4NYGQHvlen4
	 catPcK4eznZOZgXnFIDGn59kb3/FeVSCRoNKJNNN1dKG9oplNy9BL0C51WuY8yPTvH
	 yU0OZw0Mi7x8D5Uk90VzypDrlP5ysqLDjKgleGOQkM+axue/IaMdKOXQpcsVK2uC2R
	 XDOsEJWT03bTwMZu53ZlHmnQg5iHkXHsiIVwzDohQhP4Hm18+NIkVLd04owHGPN+fR
	 t9cYsEfsWP8M5Qok+cfbT1XCzI/fNgS06PlSe28vw/D0G//MBXgEQnyPfmz0Px1ikf
	 0qYA/DwSRuVgg==
Date: Thu, 6 Aug 2026 16:14:33 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
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
Message-ID: <anSkIn1fMMN5Zibl@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-4-e8ecfefea812@kernel.org>
 <amrvgjPNfKqWPUU0@gourry-fedora-PF4VCD3F>
 <fec1be38-406d-4656-95eb-048729afec40@kernel.org>
 <anBqV9z6hVLIqoIn@lucifer>
 <anL0LEhb_bp_uQ1J@gourry-fedora-PF4VCD3F>
 <anL7eZcHnM5mPr_T@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anL7eZcHnM5mPr_T@lucifer>

On Wed, Aug 05, 2026 at 10:01:52AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Wed, Aug 05, 2026 at 04:30:18AM -0400, Gregory Price wrote:
> > On Mon, Aug 03, 2026 at 11:19:17AM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Mon, Aug 03, 2026 at 11:39:11AM +0200, David Hildenbrand (Arm) wrote:
> > > > On 7/30/26 08:32, Gregory Price wrote:
> > > > > On Wed, Jul 29, 2026 at 05:48:39PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > >> This is potentially useful debugging information and matches the existing
> > > > >> page offset provided.
> > > > >>
> > > > >> Use the raw __linear_anon_page_index() function so as to always output this
> > > > >> value regardless of whether the mapping is file-backed or not.
> > > > >>
> > > > >
> > > > > Begs the question whether we should mark the value based on whether
> > > > > it is file backed or not, but i suppose you can gleen that from the
> > > > > other printed values (anon_mem, mapping, vm_ops, etc).
> > > >
> > > > You mean something anon_pgoff_t or what did you have in mind?
> > >
> > > I suspect he means e.g. adding a (A) suffix or something? Like page offset xxx
> > > (F) or yyy (A) I guess?
> > >
> >
> > Yeah just an F/A in the print I suppose.  Sorry if that was unclear.
> >
> > If it saves someone the head-scratch of whether some bug is because it's
> > "file" or "true anon", given the ambiguity here, seems like maybe useful
> > debug information.
>
> Yeah will do on respin I think actually!
>
> I do think not providing that could result in some confusion like 'hm I
> thought this was file-backed'.
>
> (We've made our lives hard with varying definitions of 'anon'
> also... [shmem being 'anon in page cache' is especially lol] so it's
> already confusing but there we go :)
>
> I will add a comment explaining things so if anybody still wonders what's
> going on they can see what's up in the code.

Hmm actually at this point we'r printing a bad page mapping so don't have a
folio to know whether anon or file-backed.

So probably sensible:

	!vma_is_cow_mapping(vma) 			-> index: 0xf00
	vma_is_cow_mapping(vma) anon idx == file idx 	-> index: 0xf00
	otherwise 					-> index: 0xf00 (file) 0xba7 (anon)

Will do that in respin.

>
> >
> > ~Gregory
>
> --
> Cheers, Lorenzo

--
Cheers, Lorenzo
