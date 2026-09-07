Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47B3F1052;
	Mon,  7 Sep 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798374; cv=none; b=WDBv3aB4hb8VdnjB+amnSe2U874OiQAkWbarGSdcqz9zYI9T2RG1PhNNunGu/079tdAuvsZy5ALGk6bK9xVK6FQmCWknbt9CqHBNkveOv8ZaWSPJvRmYKkzV1/pWfKR2h76290Y7ckZER4isogT+nRt2wYZaOIEaumlk8kceWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798374; c=relaxed/simple;
	bh=D1YPlPwYgvsfOBk9qcE5W6wORwbxsAFHsEcbppq9aVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONA/euzWWfgGjTG3ga4CArDUoYaZgssMK9K1XZcoFPi0CJy6mr56GCeKlXGG0NNmVVcApu9Eb9Ke2CcVSnTrRyvQPxsZnc4kdc+0MpFxhMoKuOu/IH1mmz8GjRM3emMZFyXALqodKG4IaqupxJLngMPhPemNhuq+3+KHYmAGdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETrQgNG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETrQgNG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296EF1F00A3A;
	Mon,  7 Sep 2026 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788798372;
	bh=7haBIfiIGhaU6/yfncxk2nIKY4oDyz2vAsQkjP7Gxfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ETrQgNG9R9OzQbrJlawv+3W86A8+IGTjRL2itbtyPn9PnaRLrc0POdBtnDb5FZgf7
	 /6MD3X4z7nl6ZkA+yuGN6YJssbv+SfPmSuDPs8I4pY6b5bZg2JBwmbTXgztr6wDR2c
	 edz8zWT8uJV5MZDxbV94aBQKG7Rlzk4NFLmoTPLfpWtV1DYVc5KbyxROXhy2IcTWXW
	 tWoYDybnoP3HUh2UQgYKUOq0w6KZP8mtmS5KIzQ4n5/jBMxsHua5H+TkN4XvDgZ+1z
	 ypB0E6SA07qKMKuNz3VGo34RenSMcMjZsvVeKDi+C4StNn8ByOX2Db5iFJBmtL8BNN
	 c9DDSyF48VPVw==
Date: Mon, 7 Sep 2026 17:26:05 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/6] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
Message-ID: <ap7j0oVf_ZOzX6pB@gremlin>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
 <20260902-map-private-dev-zero-v1-3-a578c730cec7@kernel.org>
 <ap7fOu5DHkKtqlkg@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap7fOu5DHkKtqlkg@gourry-fedora-PF4VCD3F>

On Mon, Sep 07, 2026 at 12:04:50PM -0400, Gregory Price wrote:
> On Wed, Sep 02, 2026 at 07:00:20PM +0100, Lorenzo Stoakes (ARM) wrote:
> > In order to use mmap_prepare() with MAP_PRIVATE mappings of /dev/zero
> > without the success_hook hack we explicitly permitted mmap_prepare handlers
> > to set NULL vm_ops.
> >
> > However this is dangerous and we really only want to allow this for
> > MAP_PRIVATE-mapped /dev/zero.
> >
>
> "this is dangerous" -> can you expand on this?
>
> I had been experimenting with mmap'ing kmem dax devices as a way to test
> generating a driver-defined efault mempolicy on an anonymous region, and
> this exact pattern came up for me during mmap_prepare trying to get rid
> of the "fileness" of the VMA.
>
> Basically looked exactly like the /dev/zero vma.
>
> I understand this is a hack, i'm just trying to better understand why
> "this is dangerous" and it shouldn't be a supported pattern.
>
> for clarity:
>
>    fd = open("/dev/dax0.0",...);
>    buf = mmap(fd, ...);
>    /*
>     * mmap(_prepare) callback marks the vma anonymous so it takes anon
>     * fault routes and sets an mbind mempolicy installed on the vma to
>     * prefer the node the dax device is registered to.
>     */
>    buf[0] = 0xDEADBEEF; /* faults an anon page from the node */

Well firstly it's a contradiction in terms as it has to be file-backed for a
driver to get it :)

This exception is just a historic artifact.

This kind of edge case VMA is a real footgun too, there's been bugs around it,
weird behaviour-by mistake and in general it's safer, more maintainable and
easier on the old noggin' to eliminate weirdo edge cases.

It's also probably a good idea from a security point of view, especially now
that can be LLM'd endlessly :)

But also the driver can't properly ensure that everything is set up correctly
re: rmap, mapcount, etc. and also drivers cannot be and should not be trusted to
do this.

The right away round here is for userland to allocate the memory and have a
driver use GUP to fiddle with it.

Finally CONFIG_DEBUG_VM warnings might go off because you set pgoff to something
random. We kinda tolerate pgoff abuse for file-backed memory, but now for anon
it's established as an invariant that it's what we expect (vm_start >>
PAGE_SHIFT if unfaulted, or if faulted from first fault time).

--
Cheers, Lorenzo
