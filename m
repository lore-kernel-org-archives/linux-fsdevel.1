Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054AB412C1A
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923661; cv=none; b=HMIj+TRo2xJ8tI86QdeCcpkMHThGWdVWU4hUdvkQmLfNbnC6c+TnxV2YR7Afeg3TGJnIWKB2X9wyjOkom1KLdc9YjTHNv+zFvY5rSK/5EBWfzUULlnVfoHVf1ETfkR7lmiVbreCserM+R5zybMoEafzsDKInCqjHjwuRy2EUhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923661; c=relaxed/simple;
	bh=Ee04C6YOyTAFvgtqxzoAzySxH8fuwp/doP38lRemS8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/plqw1wpJMNh4N+SCou/aFz1mAk0Z8ziCQQ3XSXX1o2IvXc9kFVyBHB273r7ladqSdK/JUVrcWAYX3hXxLnuHh8YlzVXWnKNTb8BXuYLasb8HD/o2XogqEQb2cxjavhAKtP3KubII4BFRx8CkNo3bNhsVzLcA+5HOZr2PmBOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wzR+ohd4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0NO3IQ4x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sfuHkkSY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OyGd9H2+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wzR+ohd4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0NO3IQ4x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sfuHkkSY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OyGd9H2+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E35817FD43;
	Wed,  5 Aug 2026 09:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785923653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU4WpIubcpWK9hCH2PEh/5TTaHzVeki/xiz4teIymqk=;
	b=wzR+ohd4v+0lgQWsYVhJoHKuZEtEb3YNwJc3v7q8zHLgDVW4LNwaXDrXwWIpNBFvtlK4Mj
	TKoKJO3eGxFZFt+KE9G87nTZpQhcrz1VGNbvP2VnMvCS7Rs9WCoI3nygsN7hvZ2XNO9V/b
	w0zcXDOVtiV3ZIsR0/uj9pv0VbIowqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785923653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU4WpIubcpWK9hCH2PEh/5TTaHzVeki/xiz4teIymqk=;
	b=0NO3IQ4xJEXNmoj/S5jhj6eu/u4nn6+Hww7p8Rcaf6NIkFyJHxb5+ggX0+7QrXFe3cTYaZ
	BY/vkPKrr8vVfjAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785923648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU4WpIubcpWK9hCH2PEh/5TTaHzVeki/xiz4teIymqk=;
	b=sfuHkkSYBH/rMYK9Ymy4w/oFuE/D0G/iXwSNRfeVql/WBcnVstNmrxr04BS1enCpHmVVeM
	2t3u0+WlVHt1sG3GP4x7Yh9a4D3BVInpfVYmHLxHpBLQuBgvnFYLIAZItUdgpCmRDbP52k
	x780PSShWatmHhVTu0TKjUxoZm6GEIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785923648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU4WpIubcpWK9hCH2PEh/5TTaHzVeki/xiz4teIymqk=;
	b=OyGd9H2+JlMMeeivriHeQILv068qUPXI16OSZOsL+0ColwikZcoY/8I86KN0BqQvpuUhe1
	Vlk/VTgRxbyvOLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFCEE779C2;
	Wed,  5 Aug 2026 09:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wl97Lz4Ic2p2TQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 05 Aug 2026 09:54:06 +0000
Date: Wed, 5 Aug 2026 10:54:05 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] mm: constify the pte_offset_map_ro_nolock()
 return value
Message-ID: <anMHQn_mBs6DTrZB@pedro-suse.lan>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-7-pfalcato@suse.de>
 <anHJ48Glq8EdHatd@lucifer>
 <anI6BEyTJFzQY-N9@pedro-suse.lan>
 <595fe323-59d3-4f4a-92a3-ac5d67b7461b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <595fe323-59d3-4f4a-92a3-ac5d67b7461b@kernel.org>
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arm.com,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

On Wed, Aug 05, 2026 at 07:58:02AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 04/08/2026 à 21:22, Pedro Falcato a écrit :
> > On Tue, Aug 04, 2026 at 12:22:19PM +0100, Lorenzo Stoakes (ARM) wrote:
> > 
> > > 
> > > >   			if (!pte) {
> > > >   				mmap_read_unlock(mm);
> > > >   				result = SCAN_NO_PTE_TABLE;
> > > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > > index b91b1a98029c..2cfc6e608ef4 100644
> > > > --- a/mm/pgtable-generic.c
> > > > +++ b/mm/pgtable-generic.c
> > > > @@ -308,8 +308,8 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
> > > >   	return NULL;
> > > >   }
> > > > 
> > > > -pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> > > > -				unsigned long addr, spinlock_t **ptlp)
> > > > +const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> > > 
> > > Can pmd be const too?
> > 
> > I was going to say "yes but then pmdp_get() also needs to be constfified" but
> > actually no, it can't:
> > 
> > pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp) {
> >          if (unlikely(pmd_bad(pmdval))) {
> >                  pmd_clear_bad(pmd);
> >                  goto nomap;
> >          }
> > }
> > 
> > so PTE mapping actually needs to write to the pmdp if the pmd looks bad.
> > Tricky stuff :)
> 
> But if pmd is const, can it be bad at all ?

Yes, you just need a stray write or a bit of memory corruption and it can
go bad. And then we need to do clear_bad() :)

(it's unclear to me whether this is actually common or useful enough these
days; the way this was explained to me, page tables can be best-effort
redundant; but it's not like we know clearing the whole range is ok, and
the way pmd_ERROR, etc work they don't even communicate to userspace what
happened, unlike normal hwpoison mechanisms)

-- 
Pedro
