Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4533F59E;
	Mon, 22 Jun 2026 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148288; cv=none; b=fe4XVznKPEh0kb716XFdPe/6MOnh82U5T91ghEoCzCr5k1+JZ1xBZsnEOGTnK4PbU2pKHxDkYZTIOMYBtcDmT+EzJGU3erd15bKVjy5lKTUDnzU0kIRJ8kDzgf+f0ZUDBy4N0cDDhNaeOwo4JY3RThlZSOVErD2NT104UPckC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148288; c=relaxed/simple;
	bh=PO9bH7as9Lfckat71NFCHlf43Tg26onzj9hIRC6mQvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4ZmJIW1s8I92ZnnpjX/N0YWQLTXzAUPhEf9RXkTm386Omx2SSGy/FcPKV58615bo5Bcg4iMi0V5N1UqWsfBtIuhkB0ubTG8SI8NBDDqX5PpJTwqJD1y1/FYkqN0TgS8+t2pKiqVtVBGy5Yq4ibYuinufhYKjOyQwCL7gnU7JVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=erB7xUSe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erB7xUSe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6Ob4n515gwjUACWmJ3PEmGOd7nhYBm2e6boWfItYT/o=; b=erB7xUSeC1VU5j7O3O4Dd9QPaI
	+Q3OSYWIPxsxt/C9U1wyrVC3FWoIzshmgw5dy5Brh2q9nPsbxaEFYoOMnjoN4UyeGQ3NsR8ZGdl6q
	Y7HX4WrENJjfKbcTznAl++DBjHOV7Omzl5/k/gu/K3xt20MIr2g+oqR9qLLo1FjoxG9XPX8D76Vxs
	jLwhTzEILHFWDtobbQZOib1/ybqikxLSbhobg4ZmZxlijjbaIo/8B/CGOoasm+v3cSErUpKRtPxO6
	KzNNPDnEEcxowK6CtNxZXpEP0GWk3liMGeAg8sB+9++YIvhgCg/ar7ldMaSfniFpyJ+kIHqeItjlH
	ydu+JrNw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbiB8-00000004bnx-22CY;
	Mon, 22 Jun 2026 17:11:22 +0000
Date: Mon, 22 Jun 2026 18:11:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Frederick Mayle <fmayle@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajlsum91zeh-oRz6@casper.infradead.org>
References: <ajV0TbwEyaKMzoa6@lucifer>
 <ajV49Fyogfa6aIjy@pedro-suse>
 <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
 <ajWAYBXHJniJAO4u@casper.infradead.org>
 <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
 <ajWXEn7gECvgG7F5@pedro-suse.lan>
 <CAJuCfpFfr_SQ4ZDFojOkDKWbO2dKdL3pUPA06B2ZC-usUnYRgA@mail.gmail.com>
 <7ftrqtta2bw2xxtrzelrs46t7khr7tf2vmh2ur2mhdphtymlsr@rqbd3pfjxdp7>
 <ajk-NMghY50F6Sli@lucifer>
 <20260622095855.50e4276e331cb2d01db7183a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622095855.50e4276e331cb2d01db7183a@linux-foundation.org>

On Mon, Jun 22, 2026 at 09:58:55AM -0700, Andrew Morton wrote:
> > > much as I personally find restricting mmap readahead to a VMA a sensible
> > > thing to do). We just need to figure out how to improve the Android
> > > usecase.
> 
> Would a helpful heuristic be to do what 7b32f64bc512 is doing, but only
> if PROT_EXEC?

I was wondering the same thing.  But I think it's right to back this out
for now and try that after -rc1 so it gets some time soaking and
bot-teesting.

