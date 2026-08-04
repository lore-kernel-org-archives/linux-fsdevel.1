Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067993BCD29;
	Tue,  4 Aug 2026 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847397; cv=none; b=jCXKCbsY11QKHDo2ttvwq3wM23BN5L7xOQO7yTIeN9Ip4ZBMD9pvp0z5F9v5hbmqSMSFJTDxYssAN2LUsdR4ZLJ5s6tjB+JimbMx0jFmGR1L7A9iWXwr7BUXkheBOQhgDGmGSmkPp0vf8DjJvEnDxsKzOuqRSeN80auGw4eGr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847397; c=relaxed/simple;
	bh=84QprRHwhrz+Nkiqha49/PA9CxYa6FBg6w6noEz86g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEv5hUisTNNOUJcv8JH4UMY+vpWzSkMaUfinqITRXcR60xZrrlmf+MKIUO2kdh0DsgIi9tnxPC43Cy4ojonw76qd1mqeL4Gemywoxi0aPWPCw1B6BZXo6kpy2a++qDnN4+curbj7YJfAEM2DH9vNCXeI4TiliLJeHQMX/vtqCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWOdWAkR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWOdWAkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F3F1F000E9;
	Tue,  4 Aug 2026 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847393;
	bh=84QprRHwhrz+Nkiqha49/PA9CxYa6FBg6w6noEz86g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UWOdWAkRkJHZkJxmRSHFZYlpGkORiS1kGH2fYisI2uada2AxRE+GeYyHciAVPQr30
	 MNZd6q6kuVhstTX1GSsaMMzewptHToT1kUH0WuveZ7i5IRR9AZFh985L1e0HOxs32H
	 wXbHaoX6vi/rrkSLGy0movwuGO/cWJNMbN6vwTmSwcxFllPwoOqPNM4CgVKNryMIWa
	 OEW9DeHljNMC9Hvnie84zgLGzjIjuFDoip29CmY7iUbIDxnCzqtPygXPJBrUyyRV78
	 YpoweashigOAa2jiQFa9l0ujqRtV9rDaln9png6xRNUr3jCjFaCfpjuh2tbsAOeuHv
	 zbwT/VJNUydlA==
Date: Tue, 4 Aug 2026 13:42:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH v2 2/6] parisc: Drop own implementations for ptep_get()
 and ptep_test_and_clear_young()
Message-ID: <anHd7ho3daZFZ-4r@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-3-pfalcato@suse.de>
 <anHHyiHqYf3yLf2K@lucifer>
 <anHcJZYyz9Zrshdm@pedro-suse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anHcJZYyz9Zrshdm@pedro-suse>

On Tue, Aug 04, 2026 at 01:34:41PM +0100, Pedro Falcato wrote:
> On Tue, Aug 04, 2026 at 12:11:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 03, 2026 at 05:43:56PM +0100, Pedro Falcato wrote:
> > > From: Helge Deller <deller@gmx.de>
> > >
> > > Switch to the generic implementations, which are identical.
> >
> > You sure do like succinct commit messages :)
>
> I didn't even write this one! See the From: :))

Lol well then feedback addressed to Helge ;)

>
> >
> > Maybe worth saying by dropping the __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG and
> > ptep_get defines you get the generic versions from include/pgtable.h which are
> > functionally identical.
> >
>
> I can touch it up though, if you insist.

Yeah, I'm being pedantic here it's not vital to have this change :) but be nice
if you could, I'm sure Helge probably wouldn't mind too much? :)

>
> > (Being pedantic, they're not quite strictly identical as the
> > ptep_test_and_clear_young() generic function does some weird unnecessary
> > indirection with a local variable and the single {} is dropped etc.)
> >
> > >
> > > Suggested-by: Usama Arif <usama.arif@linux.dev>
> > > Suggested-by: John David Anglin <dave.anglin@bell.net>
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >
> > Nits above notwithstanding, LGTM so:
> >
> > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Thanks!
>
> --
> Pedro

--
Cheers, Lorenzo
