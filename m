Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB043502A7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847147; cv=none; b=vAsvBcsQ+7es197060Ejdu+fIawpPtmch+cXz1l5no/DwrkmU88K/3izEcTjzoW6o6DedK+ZcxP/s73OTvYDu8DmqY+8kiHaPZqzzIaZhsPQr2jlC8tacAHgnbjiWwRyJkc4fSyG1hc/As2KtzhCdPnlaPEPQl0onK24VffgTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847147; c=relaxed/simple;
	bh=Pakr3dVd7O8Bn4NaR0FsqHGeusu9eS/2ho6Vmlz9t50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNCYQmefFarnX1dnmCMRWYt8q4+TkBMZW/04ceFItGLnMNvt0Jy2agGvhb7THJqi7/0Ex8hXGjKyV2lyweoUS1xp3VJng7jIvGPWywFRurzcTWyE4fnRRM4ywLJ9jQ2CckOI1XFSCmxCihQSYxwqDJgDxLa4J4dMhX1T+3ghGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wvohMkIs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FdK/Fa76; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xKZL/gF7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XetrqBDd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wvohMkIs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FdK/Fa76";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xKZL/gF7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XetrqBDd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A11CA3DFC;
	Tue,  4 Aug 2026 12:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785847139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnExphRxEzIlDNvgZ2NHF0WSmLvuvWvbQz3FoCApmhE=;
	b=wvohMkIsXd9yQZOEekufv+/wSEoE0QTrBjCrlfQYXnFoFALgKBzvEuxp3xXMEXb6j+zLGT
	YKOH3SuD/auYha4F/6h/WYQKLo6gtbFJU8bM93k4q3o2IOGc4bl/ES61KRfnQ32p/Hf1cE
	Tg3JYIbE8n1oLduDNwRJJwlG1V8GySk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785847139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnExphRxEzIlDNvgZ2NHF0WSmLvuvWvbQz3FoCApmhE=;
	b=FdK/Fa76S7Y0zeOrDlmk0JnV3bWdjkzcl8zDqN60TgNmCBiJdCcSBvDNKOzuZtQ4ftLHlf
	dfJ02+I1SoIfkACg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xKZL/gF7";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XetrqBDd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785847135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnExphRxEzIlDNvgZ2NHF0WSmLvuvWvbQz3FoCApmhE=;
	b=xKZL/gF772XFr5IDL1R1+ZkyiJvy1ndS1SlYygAYzd4LpDZsZnWu4Cu+5txRQdWkDh6evs
	TndXSrXQcouBd645DhWI12pePPM1Q83nU1lLHpmaCt2+IXigp1Eh0LIM1rNZTt4GiuIaso
	oTJAU/8oBNr4dhpWpZwd3k8NQ+9rEjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785847135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnExphRxEzIlDNvgZ2NHF0WSmLvuvWvbQz3FoCApmhE=;
	b=XetrqBDd+RmJqSJ5wEA+hJsLUFtVId7SVDz7ajG6/wu5rJhGfE5RSzqYcRApPVZG+qfYlH
	O2K/mufrSfRt9YDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFE3F779BB;
	Tue,  4 Aug 2026 12:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JWakL13dcWrDVQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 04 Aug 2026 12:38:53 +0000
Date: Tue, 4 Aug 2026 13:38:52 +0100
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
Subject: Re: [PATCH v2 3/6] mm/powerpc/8xx: constify ptep_get() argument
Message-ID: <anHc4aUbwxWx9YJF@pedro-suse>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-4-pfalcato@suse.de>
 <anHI4B-lMu6AJJfA@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anHI4B-lMu6AJJfA@lucifer>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arm.com,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL764437jfm1qe6abtk9nwyx8m)];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: A11CA3DFC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Tue, Aug 04, 2026 at 12:13:13PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 03, 2026 at 05:43:57PM +0100, Pedro Falcato wrote:
> > There is no need for write access to the PTE.
> >
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> With below addressed LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> > ---
> >  arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > index e2ea8ba9f8ca..f2bab31040c7 100644
> > --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> > @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
> >
> >  #ifdef CONFIG_PPC_16K_PAGES
> >  #define ptep_get ptep_get
> > -static inline pte_t ptep_get(pte_t *ptep)
> > +static inline pte_t ptep_get(const pte_t *ptep)
> >  {
> >  	pte_basic_t val = READ_ONCE(ptep->pte);
> >  	pte_t pte = {val, val, val, val};
> 
> Worth making these const too (that {val, val, val, val} horrifies me btw :)?

This is PPC code, so I don't know if they have any particular opinion here,
but I could definitely do this.

(FWIW, it seems we're more aggressive in MM in doing this than other places
in the kernel?)

-- 
Pedro
