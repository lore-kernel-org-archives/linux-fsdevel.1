Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2063C1977;
	Tue,  4 Aug 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847449; cv=none; b=fBD8bLsiUSGG/7YABhcupeAa6QtGTVs8FOszWW9TE4BhYNNsYBv/eQJdpwtC/Dg6+w93OawyQNj/EEgsmVPCn8g8ffXlCxA9+M6TZUVFFriY+N7A8Wc7smdxdISyEYi9ogSkRXlvnYlAVFWzMVJqSQXe83WipJTQJ0X//NgG8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847449; c=relaxed/simple;
	bh=Ffcc/x6DAj/Y1ENB6vgLES72vzmjuYEgE0m5wp8ZL58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNDlXrogFKtAmSOpRftGPaUOgi8Xoe8T4c4Vaxtfc6WxDuxNbGRrlkQgSGi7Tvg4pTTgUxb3j/GzJNOv1PCIkYCPjRbupCAoZ/s8aJjiVDbKayIXoZlyqje4rzU8lLgzsmGLfoNq9ZBAGt2DPp2F+qkdb2P3PfNKFBswrg00qlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+v+kmdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+v+kmdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034D81F000E9;
	Tue,  4 Aug 2026 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847447;
	bh=GKB4l2IZdbP/Q0kXwbUuYXowkK37syxnhhgXnRPRqN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T+v+kmdgCi3T4UxR1mhAPlH3L3GeQtz+35K3qNK/vTqxJ2yOhaKoAVspBfOMxLtsn
	 FIWPLNKujn5Olk6Z1+BnoEkDpCRSlRtCDxuydX1h9GeE6Eo2MOGwzDqGMneFaBwi/s
	 k1oHBA1ZQ6LyPgdPLKQitX4rEDVnEILfBvI9RX+oJ2Ihm42LEJmI4EzjPJ+9HlvHfA
	 kAMfGranFVW0VA+QEd5XUJV+yYuDvEayQq7xHv1OcCe6lMi7yMbcz8Nt00EWijb0Sc
	 z41BRatoKPG4RoVOTuLaS2r3qLW8wT6a0YEEg0Aik0zKahizkE1Pp51jHOmksup38v
	 HLAh1qHJ/KsIQ==
Date: Tue, 4 Aug 2026 13:43:45 +0100
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
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mm/powerpc/8xx: constify ptep_get() argument
Message-ID: <anHeZx6Gg7waNWjL@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-4-pfalcato@suse.de>
 <anHI4B-lMu6AJJfA@lucifer>
 <anHc4aUbwxWx9YJF@pedro-suse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anHc4aUbwxWx9YJF@pedro-suse>

On Tue, Aug 04, 2026 at 01:38:52PM +0100, Pedro Falcato wrote:
> On Tue, Aug 04, 2026 at 12:13:13PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 03, 2026 at 05:43:57PM +0100, Pedro Falcato wrote:
> > > There is no need for write access to the PTE.
> > >
> > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >
> > With below addressed LGTM so:
> >
> > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > > ---
> > >  arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > > index e2ea8ba9f8ca..f2bab31040c7 100644
> > > --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > > +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > > @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
> > >
> > >  #ifdef CONFIG_PPC_16K_PAGES
> > >  #define ptep_get ptep_get
> > > -static inline pte_t ptep_get(pte_t *ptep)
> > > +static inline pte_t ptep_get(const pte_t *ptep)
> > >  {
> > >  	pte_basic_t val = READ_ONCE(ptep->pte);
> > >  	pte_t pte = {val, val, val, val};
> >
> > Worth making these const too (that {val, val, val, val} horrifies me btw :)?
>
> This is PPC code, so I don't know if they have any particular opinion here,
> but I could definitely do this.
>
> (FWIW, it seems we're more aggressive in MM in doing this than other places
> in the kernel?)

I mean I can't see why there'd be any objection given you're already const-ing
here :)

>
> --
> Pedro

--
Cheers, Lorenzo
