Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3D3C1403
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283750; cv=none; b=VkgouorLBGUmD8LAQTc/62AujFbZsH2uvTqwgNRy/UW4yz2MTl1ZuuUM/DX5zMzmBiqHi8YEdhX7gajq14zsGDqcW3kcHDBbsS+3dIEdnlGllKgqw314riQEQ5YqFAcdcrs5Iq06+sxtg+fQ2QfGH2xLBqLQIXIJp5xT6Tzr8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283750; c=relaxed/simple;
	bh=geQkxxCjtfkm9aOeDchp0R8fqi7bTJFGurZPlUQoqqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n23K6l4sZyDMWkR+IO4ZMKk3GfXxV7HAb7MfCikiYmzlsqaFHfpiMoKC+sIg+gYsSOVne+gMFFa31AbHMApt6ijq+BHASVQp00508dNRLLzsYhVHGq3DcR5t/3K1/J2fytn9zeb7bhj5SzrXf//8mFo6EvQKtYrxUzkXWztCfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=O834Oco4; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="O834Oco4"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-467e044082dso885752b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774283747; x=1774888547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=au/DBt4TsnTCso1YPGCkQuN+bqByYyQKJLWa66VyrXc=;
        b=O834Oco4lhx9/IOthVK8Uc93bxpnFyeL7jE9Id6YdwluiHFaRju+q8DweZs4SNg51a
         71neU9MlQhbkf/9RlQFnp31iP1MRGD76wi/HukoAW1OQNUqCiWbXVjXBMHvQWV1g+inP
         lagcw+rr63lG5c8ztmbmTnHr/W1Mk3/jqTnK/8qIubImsAyQLsxwIQVtUgUVfMwNtOnd
         qUD0Jgp3V+3xCXpYRJfYK/gzdTNhFt1eyvkz9cDUF3DnDEkXeTtX8IybwfiurPCV36rM
         vw6VBdhAqPMNA9al5ACOtjLflJTxoixQwtWzrxgOa4IIbfG30xOFWzOXG9PM++K63OZN
         gQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774283747; x=1774888547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au/DBt4TsnTCso1YPGCkQuN+bqByYyQKJLWa66VyrXc=;
        b=rjSJGTllGVvOjHZy/oCwtyMLvRwGmzMH+t31GUPTEbfToPYFToL33KjjIhhctvakvT
         yyOVte/IOQxoyp1Oqz+7JnjDqomO2fiuW8O/vX90xNEdbpRJgCTQhGlap5wdiEjnHB0f
         VeiOyW/ZfxJj4Zbc6/KQlhy1VC8TCPdkToWn1c5eLV+timOAPAe5sl2oFZI8WAsN0upx
         n31mGXyrUQcWbvRv8T3idrAqJJtIQG3urgqroJ6TVoIcO/+4ETFRxK29uSCPxkc+Gsvd
         a03+bCt5BYZYoPs1o41LI5KMMNadAHJXxjgm5dJ3B8oIxAiRgzfAP0v+QoNUjxaEx6Kn
         rg2w==
X-Forwarded-Encrypted: i=1; AJvYcCWAT+DHlD9AF2/9b7C5y12keK7+i8cMQlDxR4GnHdBHvyqvGvwmsV1c6jMlrhmUp2lGZKF2phhnG96ipQRy@vger.kernel.org
X-Gm-Message-State: AOJu0YwvlKxAHjW4gp7b74v+1fnmrdGXmv0RJdDG5dT7KGz5YKH8mJlW
	CVIBmR6Y/6mKqo/BlnNMIv0dGe4i3qnkHJf7gcPeaMBR8iZkZJncbAi1vvDi4zgGvKoggSZIJFg
	g1FEQSco=
X-Gm-Gg: ATEYQzzFeZNIxj1XlZSM/4rll7UFNsStGe7FYOzSHGx9DFkWunGfAxeDARcTqptr8Xy
	xDRFZzEIOJO9CP2mxSMhDLHszDjvgnY6VKq53hdcBFdCr/C7OFthf+JBKRPbcpx+5IvBbzWqz+o
	YAzXsxPtfk1V8ko7HKz7NbLif2FrVJFwDTLpAmkhW/XhtXLLl43KgcbdSPjw/t9KqIkVrSoB+ZU
	/KNpNVh3iFl0Vi6aohs6cne/ZcWlkv2RcXmLKGfcVYHJ8oILXJs0JV6YI/yGaRdkq5qWIn2NUcv
	5Fm86r4oVDMGqIWKEpul5izKiL6YlqC48VboIo7bc4Y4vdWNoKTTlqAmT/TNcV6wCPS97MW3X5N
	i2VVRqcizFu475YA6N7PFsEPKnWMAQLhVHgRiOwwaXbLHTsPwhuS/tQGotR4CEBl9YlWia73LS/
	Tzcg+uJg==
X-Received: by 2002:a05:6808:669a:20b0:463:8fba:5e00 with SMTP id 5614622812f47-467e5eebfe8mr5354383b6e.30.1774283747596;
        Mon, 23 Mar 2026 09:35:47 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:2632::3ce:1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46811e5164esm3658248b6e.0.2026.03.23.09.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:35:46 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:35:44 -0500
From: Chris Arges <carges@cloudflare.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <acFr4JJgaXsD9gtQ@20HS2G4>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
 <aasAo8qRCV9XSuax@casper.infradead.org>
 <aas06mfCrJuzZd0-@20HS2G4>
 <aas3E9P0BP03O8ma@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aas3E9P0BP03O8ma@thinkstation>

On 2026-03-06 20:21:59, Kiryl Shutsemau wrote:
> On Fri, Mar 06, 2026 at 02:11:22PM -0600, Chris Arges wrote:
> > On 2026-03-06 16:28:19, Matthew Wilcox wrote:
> > > On Fri, Mar 06, 2026 at 02:13:26PM +0000, Kiryl Shutsemau wrote:
> > > > On Thu, Mar 05, 2026 at 07:24:38PM +0000, Matthew Wilcox wrote:
> > > > > folio_split() needs to be sure that it's the only one holding a reference
> > > > > to the folio.  To that end, it calculates the expected refcount of the
> > > > > folio, and freezes it (sets the refcount to 0 if the refcount is the
> > > > > expected value).  Once filemap_get_entry() has incremented the refcount,
> > > > > freezing will fail.
> > > > > 
> > > > > But of course, we can race.  filemap_get_entry() can load a folio first,
> > > > > the entire folio_split can happen, then it calls folio_try_get() and
> > > > > succeeds, but it no longer covers the index we were looking for.  That's
> > > > > what the xas_reload() is trying to prevent -- if the index is for a
> > > > > folio which has changed, then the xas_reload() should come back with a
> > > > > different folio and we goto repeat.
> > > > > 
> > > > > So how did we get through this with a reference to the wrong folio?
> > > > 
> > > > What would xas_reload() return if we raced with split and index pointed
> > > > to a tail page before the split?
> > > > 
> > > > Wouldn't it return the folio that was a head and check will pass?
> > > 
> > > It's not supposed to return the head in this case.  But, check the code:
> > > 
> > >         if (!node)
> > >                 return xa_head(xas->xa);
> > >         if (IS_ENABLED(CONFIG_XARRAY_MULTI)) {
> > >                 offset = (xas->xa_index >> node->shift) & XA_CHUNK_MASK;
> > >                 entry = xa_entry(xas->xa, node, offset);
> > >                 if (!xa_is_sibling(entry))
> > >                         return entry;
> > >                 offset = xa_to_sibling(entry);
> > >         }
> > >         return xa_entry(xas->xa, node, offset);
> > > 
> > > (obviously CONFIG_XARRAY_MULTI is enabled)
> > >
> > Yes we have this CONFIG enabled.
> > 
> > Also FWIW, happy to run some additional experiments or more debugging. We _can_
> > reproduce this, as a machine hits this about every day on a sample of ~128
> > machines. We also do get crashdumps so we can poke around there as needed.
> > 
> > I was going to deploy this patch onto a subset of machines, but reading through
> > this thread I'm a bit concerned if a retry doesn't actually fix the problem,
> > then we will just loop on this condition and hang.
> 
> I would be useful to know if the condition is persistent or if retry
> "fixes" the problem.

I was able to deploy my patch into a set of machines and test from March 11th
until now. So far it seems like this patch addresses this issue. While removing
the BUG_ON means that we will no longer see the call trace messages, I looked
for any lockups that would be related folio/filesystem activities and did not
find any.

Let me know what else would be useful here, I am happy to re-propose my patch
without the RFC, unless more verification/analysis is needed.

--chris
