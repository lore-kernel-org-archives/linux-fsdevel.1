Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DACC47F2E7
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907501; cv=none; b=QtgekkMtkzE2McXfVFMRxj//aQTKo03mGIGQyIWYm+YcKGCv4KI8MMHnoYu82OJIBXf74uI0rZ0NaWbiVigjdBF0ZzzCy4ZZ+NKY7QLpIKa3qHrIXIlhmyjNlwTwUuacZOXu7udSOvxT8tH5z78zy7PlhzQSG9HqpUD+On2s2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907501; c=relaxed/simple;
	bh=M2BUN1D3Un75lO+OgkAjD+hyXwO98GzkNqPKpwvW5yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGrTumapfQLw5FeF+CcLOlQy7Gr6PoWWf+8IXT2XtybkiOZ8bplkRjLVJC6SrRIckxAB8U3Amhe4QGqc0ZLfCfQmFyAesGfPME3cT1ohXwi9jMLEWc47oPppTu9yCPh++vBe5UUJho03KSPt2hDszdUpUtwQ87SuHV0S+VfJ0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vXVifsuE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0ZSPYLM2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vXVifsuE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0ZSPYLM2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vXVifsuE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0ZSPYLM2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vXVifsuE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0ZSPYLM2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8625573A87;
	Wed,  1 Jul 2026 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782907497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4id5fjRmUwpHNxQihK2Flg7ASSDlcpvubHpyY4zbP0=;
	b=vXVifsuEykeck4AJwZB77cLwR6YJw0yhLqR+m5xRmsX8vq54XX5gra5wMueWQT5RrmrvpD
	/aOJae1W+TDd+fzKg7lylTCC6SBA1HYvMCKDTpKr6EFrGhAYPqup2YB/mUVPuzJnfl/mnF
	/5ygqQ6aga2lAh7t4mQGF5lZG6vux1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782907497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4id5fjRmUwpHNxQihK2Flg7ASSDlcpvubHpyY4zbP0=;
	b=0ZSPYLM2d+cLZqPDTeSjIa4VUFkbRqoThRELy++4mMn/9ECdBkBektt66UhlLhgs7MWGJZ
	FUQWBxC0QgnczVAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782907497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4id5fjRmUwpHNxQihK2Flg7ASSDlcpvubHpyY4zbP0=;
	b=vXVifsuEykeck4AJwZB77cLwR6YJw0yhLqR+m5xRmsX8vq54XX5gra5wMueWQT5RrmrvpD
	/aOJae1W+TDd+fzKg7lylTCC6SBA1HYvMCKDTpKr6EFrGhAYPqup2YB/mUVPuzJnfl/mnF
	/5ygqQ6aga2lAh7t4mQGF5lZG6vux1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782907497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4id5fjRmUwpHNxQihK2Flg7ASSDlcpvubHpyY4zbP0=;
	b=0ZSPYLM2d+cLZqPDTeSjIa4VUFkbRqoThRELy++4mMn/9ECdBkBektt66UhlLhgs7MWGJZ
	FUQWBxC0QgnczVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 977AD779AA;
	Wed,  1 Jul 2026 12:04:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZRmcIWgCRWr6MgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 01 Jul 2026 12:04:56 +0000
Date: Wed, 1 Jul 2026 13:04:54 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Gregg Leventhal <gleventhal@janestreet.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Eric Hagberg <ehagberg@janestreet.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
 dirty page cache
Message-ID: <akUCJvTLD-bPm0s4@pedro-suse>
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
 <akQIIav_zaK6RmIC@pedro-suse.lan>
 <akQO8JtTxmp89GS8@pedro-suse.lan>
 <akQekZUyoKadiGCH@pedro-suse.lan>
 <akUADHLWEetveHLp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akUADHLWEetveHLp@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Wed, Jul 01, 2026 at 12:54:52PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 30, 2026 at 08:55:12PM +0100, Pedro Falcato wrote:
> > @@ -2043,6 +2044,17 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >  	 */
> >  	try_to_unmap_flush();
> >  
> > +	/*
> > +	 * If collapse looks to be successful, flush any dirty pages
> > +	 * out the page cache. With the nr_thps incremented, there won't be
> > +	 * any new writers (nor new dirties).
> > +	 */
> > +	if (result == SCAN_SUCCEED && !is_shmem) {
> > +		err = filemap_write_and_wait(mapping);
> > +		if (err)
> > +			result = SCAN_WRITEBACK_FAIL;
> > +	}
> 
> Oh, the other thing is that this should be conditioned on
> !mapping_large_folio_support().

ACK to both of your suggestions, I'll send a proper version (once I figure
out the proper way to send a stable fix that does not hit mainline). 

-- 
Pedro
