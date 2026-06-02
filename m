Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8F30677B
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780374257; cv=none; b=jvDlBK96xCHsteN5iYgZhvlFPlKuyNQoevnjuMq7ZythaboN29x2rQOzJNz6H+CJ9Ab2wyHz3HAZ5JCtCtJvJfteJhZk52F4MfHt2SWSOuOKD2GfJ/w3vj5HuKd6gzIMx0cRjjM4ypOvuJisMnrUqvlgMqlfiaGbUoHBwpIT4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780374257; c=relaxed/simple;
	bh=5trq4NLroc+sPTPNdDihMxSz/1pvZ/2KHPe4Oy1H8tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1OHEyM8VlfyOgjrN/oSG0sxmuh5HmpNoFAbvCWnCho0z21mZjY1a5jBy0wzYUGXxohhfoE2CjEi6QZD//aOoyJQldWyuFVyGPCwwA9s/9au7mjjktTx/ecgXaZCWlkd8rKvrNQWB069UqI5nU5aYZEL0NwjX2CWFPXiuCvt4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U6sEhaIM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U6sEhaIM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2iyHGUuJYmgv8gJflD2sBc8RMlLF6Y8NWc96mwDPsgM=; b=U6sEhaIMAIyl+ik1kCikwYfrBd
	wH71Zhc/1L8FYctvNWbHR9Kf5GQ5w7VzeRGzbQkiIxxWOT6Ppaoaiv98/ed6OMjAH8e3Pup82r4RC
	jRsjYmflrX0LxTTrTcCnwxfP9oO+GWLrZ1pNcMAuIwOvRx3o2diSjGg47eHUS47uTnXefpdGjZnYN
	8XsUEaMW3VY31FzqE5gc5M38Y4iwcXc7Ww+MM6gkFeIBkr86ztZWeqS+1jxEkZ+i/XzhPmzKjFIWT
	aD7CnhSc+mSFicBU9mrUNuCQPZ9DVxKnct+9OHzZQiKnxGzn78Z6cVx6eTiI3vNON31Fnk/qLHX7a
	tAMwXTiw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUGfk-00000001Ihx-0wX5;
	Tue, 02 Jun 2026 04:24:12 +0000
Date: Tue, 2 Jun 2026 05:24:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 3/3] mm: Remove __folio_index
Message-ID: <ah5a7PCNAcFF4l4o@casper.infradead.org>
References: <20260601192626.150804-1-willy@infradead.org>
 <20260601192626.150804-4-willy@infradead.org>
 <20260601170502.a3328023425ca85409c77957@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601170502.a3328023425ca85409c77957@linux-foundation.org>

On Mon, Jun 01, 2026 at 05:05:02PM -0700, Andrew Morton wrote:
> On Mon,  1 Jun 2026 20:26:22 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > People have been abusing the existence of __folio_index.
> 
> Patchset is rather amusing.  Perhaps you should have called it
> __folio_index_dont_use_this_or_ill_shoot_you.

Yeah, I've got into trouble for things like that before ...

> > -			union {
> > -				pgoff_t __folio_index;		/* Our offset within mapping. */
> > -				unsigned long share;	/* share count for fsdax */
> > -			};
> 
> `share' went away?  What's up with that?  Unused?

Oh, I meant to mention that.  Yes, it's been unused for a while; all
users switched to folios.

> > +#define DO_NOT_USE(x)	x ## __LINE__
> > +			unsigned long DO_NOT_USE(_pad);
> > +#undef DO_NOT_USE
> 
> Sashiko says this doesn't do what you intended.

Bleh.  Arnd suggested:

                        struct address_space *mapping;
-                       union {
-                               pgoff_t __folio_index;          /* Our offset within mapping. */
-                               unsigned long share;    /* share count for fsdax */
-                       };
+                       unsigned long :1;       /* formerly index */

> Sashiko also might have found a few existing issues in ntfs which the
> maintainers may choose to examine:
> 	https://sashiko.dev/#/patchset/20260601192626.150804-1-willy@infradead.org

Yes, I was aware of most of them.  The kmap -> kmap_local conversion was
clearly done without any testing (and I'd suggest a lack of understanding
of how kmap() and kmap_local() differ).  I'd be tempted to revert it
until it can be done properly.

The warning about shadowing a variable is well-taken though.  I'll fix
that.  I'm not sure I'm signing up to take care of all the kmap-related
issues though.  And nor am I doing all the folio conversions still needed
in ntfs.
