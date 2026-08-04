Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5031F99B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846680; cv=none; b=bFT8ZTbCqivV44XSFWo85TsjuZpUqln569LWjeJ4foEyA2P1x24qG6PDByFuwSRNfGWAibPpcnK98akES57JVPPkQKBjXB6yoPSQGjgGl8kIUzuTfL97c0/yxOufzMrmuAdHkLdtIyU5LjeTIKMDqa8bbuy9dmPVssF4I7xeCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846680; c=relaxed/simple;
	bh=J82kAWnZHpM2owoeX77yoHGrQIq7bWT11K/TvBPnWKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdqxj9RdBgm3CTT6NcKeJsq02T9ApbzRG+0PQuKgT2ZlCCMQxBuCWYJi9XpEqDwFK7cj8Dy+WMzsW2otXXHHU/o2QYAZaTLfikBlfxRQsVL6lrHKg7ONnLAiM0kutkVF4nGzXVQutdVYkEvIBsk67Q0zolXxQByWmKvcZFGTLEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=INOo8Pi7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KjTIjm4l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OiI/ovxm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CyvccDZ4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="INOo8Pi7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KjTIjm4l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OiI/ovxm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CyvccDZ4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87484401B;
	Tue,  4 Aug 2026 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785846672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CLBRymNfVFWu6X+j8MY/IjaNlkgGacJIUxb7cW/jNJA=;
	b=INOo8Pi7o9J+7NSiyKnmooZGGAiILIdyyA1IZW74eJ87AIS2aj6S4rUaa+NiSs6KzgmFsw
	2JhHsbVViOWZyumrkj31kKfmjn2zwRKVzAh0sycNKCdWVIKOYsOLKzulB+Pd8s9wpKz5Ds
	/RipcHhlu+wP6kCMrF6i8hRG8gtDCEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785846672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CLBRymNfVFWu6X+j8MY/IjaNlkgGacJIUxb7cW/jNJA=;
	b=KjTIjm4l5Yb84upwgVb0oa05ddJforSKET8NJH6vs3hU0/bVfWoTA2jTORjsa73/BYUAsI
	D23B0UWuq+XgDFCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785846668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CLBRymNfVFWu6X+j8MY/IjaNlkgGacJIUxb7cW/jNJA=;
	b=OiI/ovxml9BYqkGH3dllP2tLNwyqszuu9FeiJi6uw5gBrMvbDNbRAnsnbq9gZ9n7yFSoPF
	dsO74IWril+tl3szzYarowGo2sA3abzXFIMQ5QZNViflqLOCn6KrZFt+d1fxfgnuGMRWxF
	heMPgxCD0tK7Il4B3g3eW4zcclBh8VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785846668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CLBRymNfVFWu6X+j8MY/IjaNlkgGacJIUxb7cW/jNJA=;
	b=CyvccDZ4aue95TSNHIZm7CxNGL3IYi/oPQ49q1miOPXmZZ925WrLiI675v2w/ko4+3de5x
	eEOo9/GqHjsYsRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0183779BB;
	Tue,  4 Aug 2026 12:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uBDfJ4rbcWpOTgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 04 Aug 2026 12:31:06 +0000
Date: Tue, 4 Aug 2026 13:31:04 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
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
Subject: Re: [PATCH v2 1/6] mm/arm64: constify pte_get*() and contpte get
 logic
Message-ID: <anHYoPMRt8hr1l8m@pedro-suse>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-2-pfalcato@suse.de>
 <anG2V7KpvIHjNyVq@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anG2V7KpvIHjNyVq@lucifer>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arm.com,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Tue, Aug 04, 2026 at 11:55:09AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 03, 2026 at 05:43:55PM +0100, Pedro Falcato wrote:
> > None of the contpte code needs write access to the PTEs.
> 
> This seems like a very broad statement? Is that actually true? I see a bunch of
> ptep's that aren't const-ified, so you should explain why those couldn't be
> converted.

ACK. FTR, I think it would've been far clearer with "None of the contpte get
code". There is of course contpte code that needs write access (e.g
contpte_clear_full_ptes).

> 
> Also you add a new contpte_align_down() macro, you should mention that it the
> commit message, explain why it was needed.
> 
> In general more needed here :) it'd be ok if it was a truly trivial change that
> was all obvious but you're changing some pte_t *'s and not others so it's
> clearly not.
> 
> >
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 10 +++++-----
> >  arch/arm64/mm/contpte.c          | 11 ++++++++---
> >  2 files changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index a2681d755358..043bc0649cee 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -378,7 +378,7 @@ static inline void __set_pte(pte_t *ptep, pte_t pte)
> >  	__set_pte_complete(pte);
> >  }
> >
> > -static inline pte_t __ptep_get(pte_t *ptep)
> > +static inline pte_t __ptep_get(const pte_t *ptep)
> >  {
> >  	return READ_ONCE(*ptep);
> >  }
> > @@ -1652,8 +1652,8 @@ extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
> >  				pte_t *ptep, pte_t pte);
> >  extern void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
> >  				pte_t *ptep, pte_t pte);
> > -extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
> > -extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
> > +extern pte_t contpte_ptep_get(const pte_t *ptep, pte_t orig_pte);
> > +extern pte_t contpte_ptep_get_lockless(const pte_t *orig_ptep);
> 
> This is (very) nitty but - not sure on the policy on extern's (Will/Catalin?) -
> but in mm we drop them when we touch the code since you don't need them these
> days :)

*nods*. For what it's worth, this is new code that never needed extern.

> 
> >  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
> >  				pte_t *ptep, pte_t pte, unsigned int nr);
> >  extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
> > @@ -1732,7 +1732,7 @@ static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
> >   */
> >
> >  #define ptep_get ptep_get
> > -static inline pte_t ptep_get(pte_t *ptep)
> > +static inline pte_t ptep_get(const pte_t *ptep)
> >  {
> >  	pte_t pte = __ptep_get(ptep);
> >
> > @@ -1743,7 +1743,7 @@ static inline pte_t ptep_get(pte_t *ptep)
> >  }
> >
> >  #define ptep_get_lockless ptep_get_lockless
> > -static inline pte_t ptep_get_lockless(pte_t *ptep)
> > +static inline pte_t ptep_get_lockless(const pte_t *ptep)
> >  {
> >  	pte_t pte = __ptep_get(ptep);
> >
> > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > index 2de12656b4d8..3a5d6937fb51 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -26,6 +26,11 @@ static inline pte_t *contpte_align_down(pte_t *ptep)
> >  	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
> >  }
> >
> > +#define contpte_align_down(ptep)                                                       \
> > +	_Generic((ptep),                                                               \
> > +		 const pte_t *: (const pte_t *) contpte_align_down((pte_t *) (ptep)),  \
> > +		 pte_t *: contpte_align_down((pte_t *) ptep))
> 
> I really hate these _Generic() helper things. So ugly. And it's a pretty horrid
> cast now :(

Me too!

> 
> Was it not possible to const-ify further to just be able to constify
> contpte_align_down itself?
> 

You can't do that because some callers want a pte_t* out of align_down,
others want a const pte_t* out of align_down, depending on the param.

In A More Civilized Language(TM):

template <typename T>
T contpte_align_down(T ptr);

:P

> It also seems to contradict the claim that contpte doesn't need write-access to
> pte's since you're going to lengths to allow non-const pte_t * here.

Yep, I'll admit the commit message is confusing and crap. I'll flesh it out
here.

> 
> You should cover off why this was necessary in the commit message as above.
> 
> Anyway PTR_ALIGN_DOWN() is already const-safe so couldn't you anyway just
> collapse this to:
> 
> #define contpte_align_down(ptep) \
> 	PTR_ALIGN_DOWN(ptep, sizeof(*(ptep)) * CONT_PTES)
> 
> Then describe in the commit message why you need to handle both cases?
> 
> > +
> >  static inline pte_t *contpte_align_addr_ptep(unsigned long *start,
> >  					     unsigned long *end, pte_t *ptep,
> >  					     unsigned int nr)
> > @@ -310,7 +315,7 @@ void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL_GPL(__contpte_try_unfold);
> >
> > -pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
> > +pte_t contpte_ptep_get(const pte_t *ptep, pte_t orig_pte)
> >  {
> >  	/*
> >  	 * Gather access/dirty bits, which may be populated in any of the ptes
> > @@ -367,7 +372,7 @@ static inline bool contpte_is_consistent(pte_t pte, unsigned long pfn,
> >  			pgprot_val(prot) == pgprot_val(orig_prot);
> >  }
> >
> > -pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
> > +pte_t contpte_ptep_get_lockless(const pte_t *orig_ptep)
> >  {
> >  	/*
> >  	 * The ptep_get_lockless() API requires us to read and return *orig_ptep
> > @@ -386,10 +391,10 @@ pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
> >  	 * because it is not part of a contpte range.
> >  	 */
> >
> > +	const pte_t *ptep;
> 
> Nit but this is breaking the reverse xmas tree isn't it?

Yep, seems like I mistakenly broke the coding style here and in the
contpte_align_down macro above (the \ is misaligned). I'll fix it up.

(I think Andrew isn't taking more material for next cycle, and while
this should have no functional effect, it is very late and you have
pushback, so probably no rush here...)

-- 
Pedro
