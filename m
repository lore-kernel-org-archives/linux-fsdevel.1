Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60033EF
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779550433; cv=none; b=UqujvRn+H9ybuww2usAAeJ+rY6rnuVHBBVab+FgYBuyXw/2+cMdhIyQkj9agscqrVIS2FXP52XKY5hAhLQPEAa9J/5f4opItwVAoT/PCELCwEBIDp+GgA5MThxSsuceOMrTanaXfECqIsVm9ntks175idps+LYu5H8c3k0d73pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779550433; c=relaxed/simple;
	bh=eYOJqtCi/ycCUApWgZyAwLckP2zfH2rW5J8Q6wiQzEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npZp/OzCGujn1wcjLyYzIV+FeYmxmhcnMuNe35fWOPn2Sl6oC/idf/EiBq2/3NcivjbO/A6oYqGhMuGa4DBwqTdf0jBY6uEsmf0XDihfdRDRyl8c8WaOnhTVXxMmIps+oXLUHoasxmVDNIucm1QR125jijEUHs+6gwNAbfGuO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pRThBwlD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7YrUoGJV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zpzbkzgl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cKy6GzIY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pRThBwlD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7YrUoGJV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zpzbkzgl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cKy6GzIY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94C4468431;
	Sat, 23 May 2026 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779550429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGKQxEAwH4dlJ8onElX39ZhZhqI3pOsZmNd7bQ1rR3I=;
	b=pRThBwlDw4t6O/pzqIU7KaJWg1QG0qm7L1vLlxZG3k9CPYRk/AuoWY664FTNMwyCLgYxie
	lQCtwM9IljTMU90h6SemQw33FTwIERSLqUcvPVeXT1qhjBr6ptTc63g3EluYDWmlZImbt3
	P56a/nB53R2cC7dx65aJkRX9PdWX/AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779550429;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGKQxEAwH4dlJ8onElX39ZhZhqI3pOsZmNd7bQ1rR3I=;
	b=7YrUoGJV+61dftzRMXkXp/OydunTAOPE8TjBQC1FJxUP1NPCcxEPbYMagU4Unr5Xa9LXNz
	ymAQ+Zk1jEWQQXBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779550428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGKQxEAwH4dlJ8onElX39ZhZhqI3pOsZmNd7bQ1rR3I=;
	b=ZpzbkzglrgVGRLfPMAAw6Hic17jiUsPEWRMEHTUVi5T3yk4HBNWYCD7jUtVkq3gGUu5DWw
	WKX8SDApe6iJAfGETt+fhE/hTeyGAHj2NTMbWZBQRDRg1i1q8k+p5zIge4q+jyfaWgYPY7
	r+ruV02L9ZnpCoF4a+7/xnlIb4i1bhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779550428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGKQxEAwH4dlJ8onElX39ZhZhqI3pOsZmNd7bQ1rR3I=;
	b=cKy6GzIYYdhSW5PmQVpqa8xMFZIg2bSC4LXkHnBZYFG7aHOnkFj2yD7cdu2TUtca6f815j
	D0N+AZBdvf9gC/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BDB9593A8;
	Sat, 23 May 2026 15:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xYY6GdzIEWoGbgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 23 May 2026 15:33:48 +0000
Date: Sat, 23 May 2026 17:33:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bob Copeland <me@bobcopeland.com>, Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 06/10] affs: handle set_blocksize failures
Message-ID: <20260523153343.GE183694@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260511071701.2456211-1-hch@lst.de>
 <20260511071701.2456211-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511071701.2456211-7-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,suse.com,gmail.com,artax.karlin.mff.cuni.cz,paragon-software.com,bobcopeland.com,alarsen.net,vger.kernel.org,lists.sourceforge.net,lists.linux.dev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	internal_greylist_whitelist(0.00)[10.150.64.97];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:mid,suse.cz:replyto,lst.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Mon, May 11, 2026 at 09:16:51AM +0200, Christoph Hellwig wrote:
> affs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
> Without this, mounting we will hit the
> 
>         BUG_ON(offset >= folio_size(folio));
> 
> in folio_set_bh on the first __bread_gfp call.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Sterba <dsterba@suse.com>
