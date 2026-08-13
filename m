Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39247AF42
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629961; cv=none; b=r3A5+UsPCxqtzk/AJWnynMlifshNOm+oAzm3UrTB2SUv+Gcjj7gBEZEd78gTtjq/zGe4g0iC4Ifr6rWN956Zs3ytpEP9QjhdffITzgk16wdjthK2Nlc/slkDqGHbPymH1ih33+tCsnBUG4jY/birLm7NQYl3WBvPiXgE/pEIHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629961; c=relaxed/simple;
	bh=Rjrk92tOtX+NuCaYAxIuJ7+CzdVnNz19UxXo6fEwKbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZbGjntQFrl08axE5+URJQfQerqBtvY6g4aQtueVSStPVj0e2NDZbBhK2g946detaS4u0vVSh5c5DOdSgDFLBodBRkJXx3fRiwLEC71ROwmn3pMoMCtlodZAu3sI+wD58HINXtXGV5jAFg0rEjFi+xnGAdPrzsW67xLWWpWqWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tqB3xWDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tqB3xWDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5EB1F000E9;
	Thu, 13 Aug 2026 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786629959;
	bh=aEYWS270K59Ox4tUaRT3lRn2hLg74twP6msTkfS+Pzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tqB3xWDezE1LwSz+0bKaNH6xsJMSj5Y1HTz9b+hD1+mufvVsmG1QxrkrpvtQ6PQOZ
	 3T5EXSBwisyEGRYcEiCeQYuWP/FdTnBIQFRNrFnSp4QMLSurTLF0lZb530rOj/mUF0
	 2da8sgzIjM29NlgtQeYHl0ydstkdDOF72Li2eP5c=
Date: Thu, 13 Aug 2026 23:04:25 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org,
	geert@linux-m68k.org, daniel@thingy.jp,
	Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to
 /dev/zero
Message-ID: <2026081330-music-peso-26c2@gregkh>
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

That's not what I asked at all.

This patch is fixing /dev/zero which was broken in 2020 for these
systems.  I think my question was a legit one, I was not casting
aspersions about any slop here in any way.

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

Yes, but it's not for anything outside of net/

thanks,

greg k-h
