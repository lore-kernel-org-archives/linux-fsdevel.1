Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E1477299;
	Mon,  7 Sep 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798554; cv=none; b=gi9kpV75IFRAHUFRuAFwnrepuI9CDviA3XItRLKZAY/NlXi3ErP1D24fLzNASmEYAt1s1xuPnXsugI8T1n3XZruTw3S27yQ78MFm8wRhLuvQCdQ/PGVbXPpk/87IjT/NzngifpLFXnxt4IZzrkN1AtMrR1yM0IzqJ/a+FGI8AgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798554; c=relaxed/simple;
	bh=6Mi0KexjACT8EM1oYAJ+w+kZqAp8kzJ2mApTUd50940=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doKGXMS+ezM7+Gzj3wOEYWLrsvyxgaGp2eCk2IcRHXPIbH7KA22osRgxc8kSesMxHEUEB/O9DEw51d73au2FGOIxpA6lo2YfVKZtWkzRVw7s0KxEwfvRwzAHOAfrYNhI3GkiFylClzcmXQwRR560f3LRxjoRYPwMA3pKYlNF990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA9jvqee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA9jvqee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F52A1F00A3D;
	Mon,  7 Sep 2026 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788798551;
	bh=6Mi0KexjACT8EM1oYAJ+w+kZqAp8kzJ2mApTUd50940=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AA9jvqeelrtgtADkk5mv9JMok2q4G/kVWhwLejDCvh7k6Bjosp16ast2eQbe8z3wZ
	 32Jq8QsukZsY6MQEnZXPOrmXS1S6Gz4mRLAd0yCXI322sqt7HacOuSQEuoQ9Cby0q4
	 Dmt6Z3Mr4zOK4ejpTbMgDIjkWmh9oM7y22gbIwFDLlAfoz3qjh46jLWvdQFuLC3sWG
	 pI68lEya2SWOP9mM3qUldcXe9u+fiVXEre9AsJ0BDUIni2CL+AUGL18eQkIlyqkmAy
	 GB49tJWtBs46+5TjG9ft7p1HGBBc0FzrEnhdIGPOMYzsSuOPma6Dy9P8sz0/ko/HuM
	 Jn0ywdYBjHvUg==
Date: Mon, 7 Sep 2026 17:29:04 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: implement file_is_dev_zero() to uniquely
 identify /dev/zero
Message-ID: <ap7mL02N2lPZuqB5@gremlin>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
 <20260902-map-private-dev-zero-v1-2-a578c730cec7@kernel.org>
 <292b27a7-94d1-4a2e-8346-a53e80fd2ed0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292b27a7-94d1-4a2e-8346-a53e80fd2ed0@kernel.org>

On Mon, Sep 07, 2026 at 06:21:27PM +0200, David Hildenbrand (Arm) wrote:
> On 9/2/26 20:00, Lorenzo Stoakes (ARM) wrote:
> > To lay the foundation for a future change that converts
> > MAP_PRIVATE-/dev/zero mappings to be truly anonymous, add the ability to
> > uniquely identify these mappings.
> >
> > With the memory character device now part of mm/ this is trivially
> > achievable through a file_is_dev_zero() predicate that simply tests that
> > the file operation hooks are zero_fops.
> >
> > Also update userland VMA tests to expose file_is_dev_zero() and provide
> > a stub zero_fops for testing.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
>
> yes!
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

I thought you might like these ;)

Thanks for pushing back last cycle, this is MUCH better. Struck me that
actually that it's trivial + requires no fugliness the second we have it
mm/.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
