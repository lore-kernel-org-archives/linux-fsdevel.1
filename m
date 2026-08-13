Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C43955D8
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627963; cv=none; b=JxB/f8xpeOgK9yR2hXxVXaVcW4tAMPOTpyaJYrJ1zvWhl2JEyuqrE0/O3ijCvY3GEHxeO1yMkb+BMlxx6le16W9ibh726gowQxo6iH+joq6q+QY7X4tm7nuICBE1PRAP3L9NNr03NmwFeQHQe0cDqYgD35CONwF3fn5i2q108AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627963; c=relaxed/simple;
	bh=6TBz6du9jRfWlRN1bzlvYkO01O68+MK3Q9VPll/tzZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVKgqP0R7a6ZqWdH4usmfvD2qiT/2mgnAWHvyNQoW3TvhQ0P3qmszvNratIVw+FqXu/372D77QoK33k2sbl6gwlaAqZwIFGqG1cpKXzP++gedccNtngLwDMWJEJkgq98+K3E1xpU01aZI2VaJiq/JQ7wzsm68CqIIMoTCvJMX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVpa2g4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVpa2g4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4783C1F000E9;
	Thu, 13 Aug 2026 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786627961;
	bh=3t8Xb0YXKt1FxrUR+ySkGbvszp55d2Yp5AkViZUiMxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QVpa2g4OKNlEH0QzM5QgDjzW71l6ULJ1n6Xb4TfJx94YM8fCdRj/Bc2ADDk2jToCC
	 7SoEas0nc0i7WpbTMC4Wc4xpi5BBP5AlDog5epFFAFzDeoPgyYwXzGzlDv3XEIN543
	 AfkLcxL8dbYfEptYvjkLNv4dZRxrTQzIS/zR6LtSqZ++1Zfbn/NHqSqblznZR1jnPL
	 YWaLSQBi+d8vtO5dWgDRXkMFCB77C3bFVq6zSNQ3zofToMzCItN8wfQAnHTXyOhYDN
	 pSAkm4FS6Eb/zCVAk8gEqNUodPZ5+4GcpNkPx52ZuxlQ53pL/ar0NXa+NO4b+lmUjx
	 AujhvRFyXjlcg==
Date: Thu, 13 Aug 2026 14:32:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, geert@linux-m68k.org, daniel@thingy.jp, 
	Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to
 /dev/zero
Message-ID: <an3G24JX-ZE9Obbt@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
 <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh>
 <an3E-5BuWLgwzrd-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an3E-5BuWLgwzrd-@casper.infradead.org>

On Thu, Aug 13, 2026 at 02:22:03PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 13, 2026 at 09:19:47PM +0900, Greg Kroah-Hartman wrote:
> > On Thu, Aug 13, 2026 at 03:33:58PM +0900, Hajime Tazaki wrote:
> > > Upon a private file mapping request to /dev/zero, it calls
> > > kernel_read() in do_mmap_private(), getting a failure with the message
> > > like: "kernel reads not supported for file /dev/zero", which is because
> > > zero_fops defined in drivers/char/mem.c has both .read and .read_iter
> > > definitions.
> >
> > Do you actually use a no-mmu system?
>
> If you look at Hajime's contributions, you'll see they're far from an AI
> slopper.
>
> https://lore.kernel.org/linux-mm/?q=hajime+tazaki
>
> > > @@ -869,7 +886,11 @@ static vm_flags_t determine_vm_flags(struct file *file,
> > >
> > >  	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
> > >
> > > -	if (!file) {
> > > +	/* private and file mapping will be marked anonymous later (do_mmap_private()).
> > > +	 * and /dev/zero is marked by them at .mmap_prepare,
> > > +	 * which should be _before_ this point.
> > > +	 */
> >
> > Wrong coding style for the comment, which is very typical of
> > LLM-generated stuff.  Always rewrite the output of these tools to
> > actually be sane.
>
> A lot of humans write comments like this too.  Indeed, it used to be
> the preferred style for net/

Yeah Hajime is one of the good guys and I don't think he's a schlopper.

(I do want to review his series, as usual time is against me :)

I do agree with Greg however that nommu is something we should get rid of. See
my other reply here.

Am frankly fed up with people telling us that nommu really matters and giving
talks at conferences but contributing nothing (apart from Hajime, who deserves
respect for walking the walk on that!)

If nommu can be broken for a year with nobody noticing, then maybe it's time to
see if anybody notices us removing it too.

Sadly I think Linus won't share this opinion but as co-maintainer of mm/nommu.c
this is my perspective ;)

--
Cheers, Lorenzo
