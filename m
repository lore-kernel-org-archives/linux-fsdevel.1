Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34667081E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528206; cv=none; b=b+1OiigOqV3nday/qKw6MjpD8aQ5BeILrGHeDE854ThC9BDL6DZzQD7AyrC98WhtW8v8Vu8XNRAqusuUfA+Fz2wcDIFu0mV/K9750REbC1mLh3npwDJvOguDKbNMGOhFV4Ox0PSOM0NtVYT7cLdOj/LXwLhEFid3uY1Sw34T94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528206; c=relaxed/simple;
	bh=R791zzc4EYJDRyqWzYozpg6UUH7+X6oJn9PRW+0K7Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grZw9lCOlgyMc9Jwk13OkCsJUb8RcMyvzMGcpjpjTX8TOGhAY9+o/4lY72J9EwJrCpoHrROvoQf6OOuEngPqOWy1iYyVYbCl+CUuq6VllFvlSeKN6pzbFgrN/AEiifCEzJJ34+LzU/TUZhhFIqAV86xJjO/1eFqHd6zYUJgE/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bjva55xY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zzvbYY6c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z2c5/OSV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=waeQ1scQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bjva55xY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zzvbYY6c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z2c5/OSV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="waeQ1scQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0BC24D28C;
	Thu, 26 Mar 2026 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774528203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xDSPIOGYuSfEyYwRKdywdpRyFDsscT6N86/QzvLkdwA=;
	b=bjva55xY7GDDVjK+D70rbEe89oZM3zbIZAEsbVh1K8Z8WPVF3GI3aLUvAUSz572BhGqSBQ
	vlpnBB2PfJdEq0JV1mDi4Si2+RY09txXWchPIQC+JmDAAFfYMQzNQFmSTysz7jqBCyuii8
	ioEbsr9KbyJLEuuxl4TBwS+MD64cdcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774528203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xDSPIOGYuSfEyYwRKdywdpRyFDsscT6N86/QzvLkdwA=;
	b=zzvbYY6cWMrGPvt/2mgfIAg2Dp7vdNEOQ5gXSuKxIsyz1RF2t16oq7yO9T5uZQB1QxacAl
	pPHOymQYaANnA0Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774528202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xDSPIOGYuSfEyYwRKdywdpRyFDsscT6N86/QzvLkdwA=;
	b=z2c5/OSV+Rd2FSyKG+J3wTfRBD1A7GKPYk3wXILbeTNVyD4fPvMtPe6uc+YRjEaUhjRCdO
	nQKkvpmO/lvaaylPtI2nF2zd2L7L9tcqX7F6e94zqXAwaGM3H0hUbsqCuKF3ZDISrOURcR
	LBrrwiN0EAD6zRRRV+cxMAmK/2/6n9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774528202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xDSPIOGYuSfEyYwRKdywdpRyFDsscT6N86/QzvLkdwA=;
	b=waeQ1scQzDqO4Q6/wgxH6FNhFPBgLTnlqtUc6Rg5yiRv3B6b+Fyb+6p0AGW/BxHCm6iMP7
	4dlDdC6+SSx/XRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E4D4A0A3;
	Thu, 26 Mar 2026 12:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7juYOMomxWmuKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Mar 2026 12:30:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9B518A0976; Thu, 26 Mar 2026 13:29:58 +0100 (CET)
Date: Thu, 26 Mar 2026 13:29:58 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jianzhou Zhao <luckd0g@163.com>
Subject: Re: [PATCH v2] udf: Fix race between file type conversion and
 writeback
Message-ID: <5kwqkvqy3crz5c74j7ywd7m76swgaoql7ykwgvxx5ro565h3o3@k3k7vhuisaxz>
References: <20260325162209.29233-2-jack@suse.cz>
 <acTIfOuv3Ik-erB0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acTIfOuv3Ik-erB0@infradead.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,163.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 25-03-26 22:47:40, Christoph Hellwig wrote:
> On Wed, Mar 25, 2026 at 05:22:10PM +0100, Jan Kara wrote:
> > udf_setsize() can race with udf_writepages() as follows:
> > 
> > udf_setsize()			udf_writepages()
> > 				  if (iinfo->i_alloc_type ==
> > 						ICBTAG_FLAG_AD_IN_ICB)
> >   err = udf_expand_file_adinicb(inode);
> >   err = udf_extend_file(inode, newsize);
> > 				    udf_adinicb_writepages()
> > 				      memcpy_from_file_folio() - crash
> > 					because inode size is too big.
> > 
> > Fix the problem by rechecking file type under folio lock in
> > udf_writepages() which properly serializes with
> > udf_expand_file_adinicb(). Since it is quite difficult to implement this
> > locking with current writeback_iter() logic, let's just opencode the
> > logic necessary to prepare (the only) folio the inode can have for
> > writeback.
> 
> Still not a fan of open coding this logic, which is even worse than
> the previous export.  Inline data is a relatively common case in
> various file systems, and we should be able to handle it in common
> code.

I agree inline data is relatively common but as far as I was checking UDF
is the only filesystem using mpage_writepages() that is supporting inline
data (well, OCFS2 does as well but it doesn't bother with inline data
writeback - it handles only write(2) to files with inline data which modify
on disk content directly, they expand the file to extents in case of mmap).
So a special hook in mpage_writepages() for UDF looks like a bit of an
overkill to me.

> So having a callback in mpage_writepages seems much better,
> but if you detest that we could just export mpage_write_folio and
> mpage_bio_submit_write (and make mpage_data public) instead.  I think
> that's significantly worse than just adding the callback, but still
> much better than open coding more writeback internals, something I
> want to get away from.

I agree the callback is better than making all that mpage infrastructure
public. I still think exporting folio_prepare_writeback() would be less
burden than the callback but frankly I don't think it matters enough to
argue further. I just want to get that race fixed :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
