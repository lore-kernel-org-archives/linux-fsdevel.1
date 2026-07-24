Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395D40860B;
	Fri, 24 Jul 2026 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902463; cv=none; b=oa/H0k+ZHM8cZMNbnMuxDQT1P3U4xSihaZOPJttWt8TIcnV82iCJVYyKMeYm9ccvZIImUDK9fS64zXeSh1+tBv40i7rR4UiAwq/IeUroUXFcsPX9RidD0P6Qxtw7Go1ujQT1iqEnGaFgQMCYhrOrZHMJvy5hbwLUSVf2BD6JYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902463; c=relaxed/simple;
	bh=ruN4HRMRiA/tyx/52QmIhzZu8BUYUZZIoI2bKpg1hUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbUyaE0AgoRmAkmwz/wwHowAIx1B69cOckr937+qlk1vdvKZHKU85+JAGeYSvQOfFHqWZW1PabydmvltsMgdktbTCEpkOLzJ7f/7nRmEjBO2jJV8vz3gG0+KsPx3hbtJsh+71aeO8H7b5WIuQbdV9IvZMAEdvBerHkQ7Cdh5eOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b3FaE/15; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b3FaE/15"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sqQq2Owm1obwOGEA9eotW/m1MLzuoJQfAmp5HBaVcd8=; b=b3FaE/15gGHycdVRSEH7kk8gXg
	ziED/cLtyY3G9U83si7GAn5Ol84senjYN1m4jLjO0UtBZIPJDA8wUFOchOARYzauL2VUm0k7nZpzN
	K07SPvCGF24b8xDHwesu9/XXFOC/xHyVYN0uSucmDm+HCF3RUQvxf7WqMkuuVnzM1qoNRsMjxDcj9
	uhiGquYmGmqrNAnYWz2mPt+rVVhLzVIZYA3vpLT1TxNs0sooD2gummR7OMhrl7SLQIfux9q544RXB
	8pK5bJXka726CjSXoWptNMLW0fFoYyvvcYKrkavP6fm72xKjr3YlkbnKKrHXHEs0HDQz3K+4Q60X8
	AYR/0EFw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnGf7-00000003fU1-11AE;
	Fri, 24 Jul 2026 14:14:05 +0000
Date: Fri, 24 Jul 2026 15:14:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
Message-ID: <amNzLXuwflIZFKtI@casper.infradead.org>
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
 <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>

On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
> 
> 
> On 24/07/2026 11:20, Pedro Falcato wrote:
> > ptep_get() does not need write access to the PTE.
> > 
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> >  arch/parisc/include/asm/pgtable.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> hmm I think you might break build bisectibility if
> you separate out the patches, you should squash patch 3 and 4,
> with patch 1.

I don't see how this breaks bisectability.  Can you elaborate on what
you think would break?
