Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FD4477F8
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871393; cv=none; b=nNL12l9vVUjuEAi+QA2VYTeTPFEboxfcTSvS8BGvJvqO721fh5g2IBWxUH3AgT/LfPSgO2P1vUbxZNLO4psUIeEWZepcueKuh6AO/XHD8cvIp8mpxcgRt+EI7JvkIDPNXgnToZNSq/7Yww+OnKG/2eIWGwIpfE1PYL2G1v/npeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871393; c=relaxed/simple;
	bh=zEwsDd6i2FXM4LVV0Ytcxh5M7lMxTSJlcOyJmM4H1Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC+ucvSX1sRHoi9bmuw8PU7UjxOaXuvzzJq9HRSkdSEc6yaVLq/vBh2cJn7JrPeuhHM2MJZdxzQ5vH0xvARgDmR4V2do/V73nYJDt0GMf98MM7B+WYqJoEAnW2kA4T+StlbhlqsIuaSzPS8BmYJc0OrQBpR/czywsa84DZOxAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G0aDHau6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pGC0mHI0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gvPlR+Hd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9l91suue; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G0aDHau6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pGC0mHI0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gvPlR+Hd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9l91suue"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 33AE63E7F;
	Tue,  4 Aug 2026 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785871386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKD7xlXfwFoEwiwqHEV4Td7lXumlOXqIMagnoJLqgFA=;
	b=G0aDHau6+dIF0VH9t1gS8zo/PAE5MUYtI5NFSJa+igRMyfvazx08234PtrB5zhMSqvolUc
	ZRlNH6FMUsNtxJXHp9b423eoHcwb3mWs+HOhqhgA88b0NnBuOftLs9/PFg4+xpFZ3z5suZ
	3Vh14YFjPbLSry6q8o8XstVCgShvlKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785871386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKD7xlXfwFoEwiwqHEV4Td7lXumlOXqIMagnoJLqgFA=;
	b=pGC0mHI08b9pOWsQTxcNzgcuiKSFwx/kGcb0oreTd5YmdjxJwS/tXPSu07A9mzE5Xx4M8S
	UOfeAimDR6/I+FBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gvPlR+Hd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9l91suue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785871382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKD7xlXfwFoEwiwqHEV4Td7lXumlOXqIMagnoJLqgFA=;
	b=gvPlR+HddGLYBkCQFYlBjwm/5NDohTMacQIo4zdQY5wDSAMNKeIX6GQeE55WveZfb7EOlc
	h9ckoqyZ4MS0TeimEz1GyDiXqUswKlvAOpzQpzZ5vCOqLMRuye6vK7qyKAfuzSnUaoBAn5
	7kl2EZYltPAucG9K3qTn0uxRYtxiIaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785871382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKD7xlXfwFoEwiwqHEV4Td7lXumlOXqIMagnoJLqgFA=;
	b=9l91suueSJ/aZk3c7geSquvAlMvZDmI4qlaZrtRMZmI3pJWfN07iE4Cw/pIS9pT1bNtGWT
	cnVYkK+8J3MjuDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F36F779BB;
	Tue,  4 Aug 2026 19:23:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GVRHCBQ8cmofZQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 04 Aug 2026 19:23:00 +0000
Date: Tue, 4 Aug 2026 20:22:58 +0100
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
Subject: Re: [PATCH v2 6/6] mm: constify the pte_offset_map_ro_nolock()
 return value
Message-ID: <anI6BEyTJFzQY-N9@pedro-suse.lan>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-7-pfalcato@suse.de>
 <anHJ48Glq8EdHatd@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anHJ48Glq8EdHatd@lucifer>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arm.com,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL764437jfm1qe6abtk9nwyx8m)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 33AE63E7F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Tue, Aug 04, 2026 at 12:22:19PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 03, 2026 at 05:44:00PM +0100, Pedro Falcato wrote:
> > Constify the pte_t * retval from pte_offset_map_ro_nolock(), for which it is
> > already pledged that accesses must be read-only. With it, convert the three
> > treewide users to use const pte_t *.
> >
> > khugepaged passes the result right down to fault code (do_swap_page()). This
> > leads to a complicated set of conditions that, in order to be correct, must
> > not install anything into *vmf->pte. This is not trivial to work around in
> > fault code, and as such just trivially cast to non-const pte_t* in the
> > meantime.
> >
> > The other users are far more trivial and the conversion is equally
> > trivially simple.
> 
> Ah finally more words! :)

:)

> 
> >
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> With comment updated as below and nits addressed, LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> > ---
> >  arch/powerpc/mm/pgtable.c | 2 +-
> >  include/linux/mm.h        | 4 ++--
> >  include/linux/pgtable.h   | 2 +-
> >  mm/filemap.c              | 2 +-
> >  mm/khugepaged.c           | 2 +-
> >  mm/pgtable-generic.c      | 4 ++--
> >  6 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> > index a9be337be3e4..e29db41b6043 100644
> > --- a/arch/powerpc/mm/pgtable.c
> > +++ b/arch/powerpc/mm/pgtable.c
> > @@ -390,7 +390,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
> >  	p4d_t *p4d;
> >  	pud_t *pud;
> >  	pmd_t *pmd;
> > -	pte_t *pte;
> > +	const pte_t *pte;
> >  	spinlock_t *ptl;
> >
> >  	if (mm == &init_mm)
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7fabe6c66b4b..acf5a5e31d34 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3885,8 +3885,8 @@ static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
> >  pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> >  			   unsigned long addr, spinlock_t **ptlp);
> >
> > -pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> > -				unsigned long addr, spinlock_t **ptlp);
> > +const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> > +				      unsigned long addr, spinlock_t **ptlp);
> >  pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
> >  				unsigned long addr, pmd_t *pmdvalp,
> >  				spinlock_t **ptlp);
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index dc418553e57a..dd51e722c535 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -112,7 +112,7 @@ static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
> >  {
> >  	return pte_offset_kernel(pmd, address);
> >  }
> > -static inline void pte_unmap(pte_t *pte)
> > +static inline void pte_unmap(const pte_t *pte)
> 
> I was going to question this based on whether the contract holds for
> CONFIG_HIGHPTE but actually:
> 
> #define pte_unmap(pte)	do {	\
> 	kunmap_local((pte));	\
> 	rcu_read_unlock();	\
> } while (0)
> 
> #define kunmap_local(__addr)					\
> do {								\
> 	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
> 	__kunmap_local(__addr);					\
> } while (0)
> 
> static inline void __kunmap_local(const void *vaddr) <-- const!
> {
> 	kunmap_local_indexed(vaddr);
> }
> 
> So nice (CONFIG_HIGHPTE is going to go away at some point though, right? I
> hope... :)
> 
> 
> >  {
> >  	rcu_read_unlock();
> >  }
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 6afec636881f..af5d3fcd1b05 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3490,7 +3490,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
> >  {
> >  	struct vm_area_struct *vma = vmf->vma;
> >  	vm_fault_t ret = 0;
> > -	pte_t *ptep;
> > +	const pte_t *ptep;
> >
> >  	/*
> >  	 * We might have COW'ed a pagecache folio and might now have an mlocked
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b237f6e7662a..09efac93a8c6 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1170,7 +1170,7 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
> >  			 * Here the ptl is only used to check pte_same() in
> >  			 * do_swap_page(), so readonly version is enough.
> >  			 */
> > -			pte = pte_offset_map_ro_nolock(mm, pmd, addr, &ptl);
> > +			pte = (pte_t *) pte_offset_map_ro_nolock(mm, pmd, addr, &ptl);
> 
> Hmm yeah this is nasty, but you explain why in the commit message. Could you
> extend the comment to explain it?

Yep, I'll do it.

> 
> >  			if (!pte) {
> >  				mmap_read_unlock(mm);
> >  				result = SCAN_NO_PTE_TABLE;
> > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > index b91b1a98029c..2cfc6e608ef4 100644
> > --- a/mm/pgtable-generic.c
> > +++ b/mm/pgtable-generic.c
> > @@ -308,8 +308,8 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
> >  	return NULL;
> >  }
> >
> > -pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> > -				unsigned long addr, spinlock_t **ptlp)
> > +const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> 
> Can pmd be const too?

I was going to say "yes but then pmdp_get() also needs to be constfified" but
actually no, it can't:

pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp) {
        if (unlikely(pmd_bad(pmdval))) {
                pmd_clear_bad(pmd);
                goto nomap;
        }
}

so PTE mapping actually needs to write to the pmdp if the pmd looks bad.
Tricky stuff :)

-- 
Pedro
