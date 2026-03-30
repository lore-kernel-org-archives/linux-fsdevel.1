Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429433B4EA0;
	Mon, 30 Mar 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868561; cv=none; b=eX1295iZD40dpATVl869fLGhCPLPWMJy5MD0pRFpoiliaSNQHgqwLXOod0nG9v3j6JLvc6ZqUAI396I+kEpnlFM7V9T/OLwuketZTgnH/CcR9/kOkshryHqb+hUqOiXbqZ5yrG3Xhao2dplgINPki65vOvp/BPZItGU+WZ70VdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868561; c=relaxed/simple;
	bh=FeqXF1tyWR6ThPSeeVbpdsR/5lpUq/ezrWjBvOfcVfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJFzn+waHxBzsTCh3h9ZlImRFvXYrdyH7jZngo3qQ/AZpmI03chaDYbLdkp+MLdYERFHs96XUfkKRdhj+1UMj9XIcEnXD6xMFu8n70ka3dDtVUPFPdtstC77+FDKQV2eO2RVoGgxpQTIRRVXJZDJfH4p2nId2ORZzMj0cQObb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=B/8uwKIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GW7cqoMA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="B/8uwKIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GW7cqoMA"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A1057A0373;
	Mon, 30 Mar 2026 07:02:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 30 Mar 2026 07:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774868555; x=
	1774954955; bh=g/67MWgGUdmljuD5f6QhqYFY+e0sYT43Y1m/UXREOxU=; b=B
	/8uwKIFVNngeNbOXk+XF89ixBFS+d4ZMeiPtTs226X1iogvmPMpKxQJnlfQy0CW9
	E+GjAPbjpOVc24bRdldwDe0rgudDErEQ+JSfX9p8OkUEPw0fDv9ZdnOh9U2XWn2L
	9jHxyaJ8UosG4nnVJleUOIpA5aPpMvCN8vIp18gXVfstGW2k6MihmUxqPK/z9pvK
	pvTOhd6DO0rOkH2TCKB3J1mZVDI/qFjAnMD64QKxXQD02kggrWOTyHMXLutCOXcy
	DDR9nu9eHcC0gN67PJvcoKhgyeg2dCLds/4xlXGCckQihkgP4fqjmtVB4liDoaF4
	CavXSmlQ+EX5fOH9MHYQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774868555; x=1774954955; bh=g/67MWgGUdmljuD5f6QhqYFY+e0sYT43Y1m
	/UXREOxU=; b=GW7cqoMAoAOvE8FIV5i068p6BVR65CPHidEdAr6Brfl+F0p7Lbo
	fAlTFdxqhqAy+OGfSzPXdlIlwXlmDZROaJZNdVSB/X3X0vHr3qmZozRBe6yJZ7xv
	JEMXQYN6fT3UG/HHojFNlVlAUEUIV0RtW4bIPxkpFvvOGrayCCMMtxwH2vb9Dmjp
	gtjw8M/BZDF6rCfRzFUS/UQqD44BhaqMuBKiV9fkZuBfaIl+OGcHeNqKCacEPb+r
	o01bsBSf7FPj3oHOjrM9a8M47Gca5nNAEREkqPb4H5Mx/qXseYwv+oMlI+DRP+Nf
	ddJsbQBYUqvFlCxVqHf1skQf38YqQFE+aPA==
X-ME-Sender: <xms:SljKaXqkn5lN0T-bEP-BiyPpjZkC_-6v1Ov47hPcjrkWZT3pWWMPxQ>
    <xme:SljKaQLivCKu2H3oTp8j8I6B7BfH1CEo_b7xecEhoTA5AAv2pzVqH5vJsUQYISwOq
    Yf1-Iv-lCtjzrP08h9J89KYPXkKbHtsPt33jXd8-XtjuGDL-zrPEQ>
X-ME-Received: <xmr:SljKabAiTgk7BSKaiZ8MxV7gPzLl3lT0un_TSG0UqD6cxGfpZfyX5G4UTO2NzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepfeetheejudeujeeikeetudelvdevkeefuddtkedvtdehtdetieeu
    ieetjeeugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrrhhgvghssegtlhhouhgufh
    hlrghrvgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopeifihhllhhirghmrdhkuhgthhgrrhhskhhisehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgvrhhnvghlqdhtvggrmhestghlohhuughflhgrrhgvrdgtohhm
X-ME-Proxy: <xmx:SljKaa4wFZV91l0PWEXN7tbF_OlkNNk_iFQqnmbX-F_jJs2L0UBZig>
    <xmx:SljKafFLKRjRD5o-5Ps6-VkKMA5Jk8qiCSFPx5f4GtdC2btsDo8FRA>
    <xmx:SljKadRZNKCeqSUbAQM9O81Z86DFmb_8Gb3RgmwlaQMMf7wLuiFgtQ>
    <xmx:SljKaRe9G8Wos7j3YSupnHQH9M0zLZtLFenj_3n_FjPBdpRj2u3BCQ>
    <xmx:S1jKaVIq5Sqk1U1NujGtHNPT7s8ys_eaRUqGBxgg9VZJ-DWvv6ye0_aw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 07:02:33 -0400 (EDT)
Date: Mon, 30 Mar 2026 11:02:31 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Chris Arges <carges@cloudflare.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <acpX8iUEjNT6Kz25@thinkstation>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
 <aasAo8qRCV9XSuax@casper.infradead.org>
 <aas06mfCrJuzZd0-@20HS2G4>
 <aas3E9P0BP03O8ma@thinkstation>
 <acFr4JJgaXsD9gtQ@20HS2G4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acFr4JJgaXsD9gtQ@20HS2G4>

On Mon, Mar 23, 2026 at 11:35:44AM -0500, Chris Arges wrote:
> On 2026-03-06 20:21:59, Kiryl Shutsemau wrote:
> > On Fri, Mar 06, 2026 at 02:11:22PM -0600, Chris Arges wrote:
> > > On 2026-03-06 16:28:19, Matthew Wilcox wrote:
> > > > On Fri, Mar 06, 2026 at 02:13:26PM +0000, Kiryl Shutsemau wrote:
> > > > > On Thu, Mar 05, 2026 at 07:24:38PM +0000, Matthew Wilcox wrote:
> > > > > > folio_split() needs to be sure that it's the only one holding a reference
> > > > > > to the folio.  To that end, it calculates the expected refcount of the
> > > > > > folio, and freezes it (sets the refcount to 0 if the refcount is the
> > > > > > expected value).  Once filemap_get_entry() has incremented the refcount,
> > > > > > freezing will fail.
> > > > > > 
> > > > > > But of course, we can race.  filemap_get_entry() can load a folio first,
> > > > > > the entire folio_split can happen, then it calls folio_try_get() and
> > > > > > succeeds, but it no longer covers the index we were looking for.  That's
> > > > > > what the xas_reload() is trying to prevent -- if the index is for a
> > > > > > folio which has changed, then the xas_reload() should come back with a
> > > > > > different folio and we goto repeat.
> > > > > > 
> > > > > > So how did we get through this with a reference to the wrong folio?
> > > > > 
> > > > > What would xas_reload() return if we raced with split and index pointed
> > > > > to a tail page before the split?
> > > > > 
> > > > > Wouldn't it return the folio that was a head and check will pass?
> > > > 
> > > > It's not supposed to return the head in this case.  But, check the code:
> > > > 
> > > >         if (!node)
> > > >                 return xa_head(xas->xa);
> > > >         if (IS_ENABLED(CONFIG_XARRAY_MULTI)) {
> > > >                 offset = (xas->xa_index >> node->shift) & XA_CHUNK_MASK;
> > > >                 entry = xa_entry(xas->xa, node, offset);
> > > >                 if (!xa_is_sibling(entry))
> > > >                         return entry;
> > > >                 offset = xa_to_sibling(entry);
> > > >         }
> > > >         return xa_entry(xas->xa, node, offset);
> > > > 
> > > > (obviously CONFIG_XARRAY_MULTI is enabled)
> > > >
> > > Yes we have this CONFIG enabled.
> > > 
> > > Also FWIW, happy to run some additional experiments or more debugging. We _can_
> > > reproduce this, as a machine hits this about every day on a sample of ~128
> > > machines. We also do get crashdumps so we can poke around there as needed.
> > > 
> > > I was going to deploy this patch onto a subset of machines, but reading through
> > > this thread I'm a bit concerned if a retry doesn't actually fix the problem,
> > > then we will just loop on this condition and hang.
> > 
> > I would be useful to know if the condition is persistent or if retry
> > "fixes" the problem.
> 
> I was able to deploy my patch into a set of machines and test from March 11th
> until now. So far it seems like this patch addresses this issue. While removing
> the BUG_ON means that we will no longer see the call trace messages, I looked
> for any lockups that would be related folio/filesystem activities and did not
> find any.
> 
> Let me know what else would be useful here, I am happy to re-propose my patch
> without the RFC, unless more verification/analysis is needed.

I wounder if 577a1f495fd7 ("mm/huge_memory: fix a folio_split() race
condition with folio_try_get()") is relevant here.

Do you have it applied on the tree where the problem triggers?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
