Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93556C8EB;
	Mon, 22 Jun 2026 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147537; cv=none; b=fZEAOHWkTRRCmy8e4+YmD0sDv6ERvIFZCoVBRLDtoR7k+FV78ukjHWt2r8yf9PGeXumoOrLWZpYgd9+1riW6Hh4ruNHhyl4B9bMC/H8IeFEHuByci681NY3iuz7+zZBFtwmUglwWgX/yilSuBXiNOgXUWXeLNK1OzBCDK7RgINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147537; c=relaxed/simple;
	bh=O4ld3Ed/ANKDwwu2rF4byrNGabXvYM5AzQJsbuS5jQo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FtIe699bCBnvd2Y4Fm0spR7R0IgWsakZKujCLDYiTBsa3WE8uew/78rdMF1m7Y8juPjes/bGiBmm1XqE97p7UXCKAzQ4DN6D0hSpPPD/ySDuX/i9glKXvuYMCAcRPEVBH25qQlh2+jgKJsXz4+F1IWqu//M4pu7ti+sGxtPG5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=s+wGhbBS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="s+wGhbBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E5B1F000E9;
	Mon, 22 Jun 2026 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782147536;
	bh=wteg9KqRUVkfOS3mlSvn890zNUJTJ36A1pnkvMGAiZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=s+wGhbBSz8S4aE8ceJeNSjIq29b/XvV9182QDDz5gOQFHOktd0YKeAj0QaiKCxXHx
	 56JYfOHZP87mmKcBySns95ANIZL1UbcghqLb0790x1IC+N1VKHUPx3Ff/m1R1yDHB9
	 joFEFNYD7OxpTHOKhuGg5VaESvYXLRRUxKYmXhxs=
Date: Mon, 22 Jun 2026 09:58:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Pedro
 Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, Frederick
 Mayle <fmayle@google.com>, Kalesh Singh <kaleshsingh@google.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH mm-hotfixses] Revert
 "mm: limit filemap_fault readahead to VMA boundaries"
Message-Id: <20260622095855.50e4276e331cb2d01db7183a@linux-foundation.org>
In-Reply-To: <ajk-NMghY50F6Sli@lucifer>
References: <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
	<ajVz1nhMn2JwucMY@casper.infradead.org>
	<ajV0TbwEyaKMzoa6@lucifer>
	<ajV49Fyogfa6aIjy@pedro-suse>
	<CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
	<ajWAYBXHJniJAO4u@casper.infradead.org>
	<CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
	<ajWXEn7gECvgG7F5@pedro-suse.lan>
	<CAJuCfpFfr_SQ4ZDFojOkDKWbO2dKdL3pUPA06B2ZC-usUnYRgA@mail.gmail.com>
	<7ftrqtta2bw2xxtrzelrs46t7khr7tf2vmh2ur2mhdphtymlsr@rqbd3pfjxdp7>
	<ajk-NMghY50F6Sli@lucifer>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 14:55:14 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> > Anyway I agree with you using mmap-frame-by-frame approach for this usecase
> > is kind of odd but not completely insane and it does demostrate people do
> > odd things like this. For others the usecase of Android doing tons of small
> > sparse mmaps into executable might look odd as well :) So this seems to be
> > one of the cases where it's difficult to please everybody with the same
> > behavior and we usually stick to the legacy behavior in cases like that (as
> > much as I personally find restricting mmap readahead to a VMA a sensible
> > thing to do). We just need to figure out how to improve the Android
> > usecase.

Would a helpful heuristic be to do what 7b32f64bc512 is doing, but only
if PROT_EXEC?

> Reading the thread, I think we're all in agreement that this is a workload
> that exists and we are regressing it here, thus the revert is the right
> course of action.
> 
> Andrew - could we move this to the hotfixes branch please?

No need?  I'll send Linus the mm-stable batch #2 this week.
