Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD81F1932
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870294; cv=none; b=E2kxoUOx0yyzxsZEwaGuwJiFyOsZLVA4a42gB+hQaVCKBmMkec8trPPEVHSt7hQivQPBlEFctppg/hIo0dRlIJDG8bJ5Qpry/9UtNSjDCtXwro/VpyTtnb1Z1ybZWgij6gfy6wzZKcJvwHu6RA4CNTUramHbNYIaWEUPi1m/KTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870294; c=relaxed/simple;
	bh=Cpes2frEqf2OQ7depjrYTkeG7fOB4l6pR/5npJRQBbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0OocLXT+H6577VXx/D2puuNzPIEoR7sRqVLJQjaC8JaEeSClIYU/rs3LWIwPBra6/agis20iXfLJpXu/6hEPtBRToilVa+uU4CbJJ4JBiUnntdCKQRfPflP/ei5k8H4ZxE+P/sVdv7QLWn3K02mHHsZFARdxJhbm/r6IgI+Fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xcG3Mp0c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JtD485uw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XZ0i9o1H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jm3/gCzH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xcG3Mp0c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JtD485uw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XZ0i9o1H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jm3/gCzH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB811760DC;
	Fri, 19 Jun 2026 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781870291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOTWgH3E4efc1DupZXjdNhTQSV74w9qLI0tTsa0YRXM=;
	b=xcG3Mp0chCVY3q97c2+ASVvMLOv2ytxXf5DiYRpiCCeP0vByIZuRBQk4S1Le8SsO4j9WHg
	ZlC8Imrh4AG8o/0Te8lzHu/1zGLxRczeVj7ubpc3bwrqkuWV7X3FnKg4OJ7yvSMlfvxBEg
	HUDIigaKtTZmZOuBjNG6/OaIL7FRB+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781870291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOTWgH3E4efc1DupZXjdNhTQSV74w9qLI0tTsa0YRXM=;
	b=JtD485uw0ODNLUc+pAK1o0gU/G9U+50Ja5ITBvVHV/WW1EgIw4wJwZM7feAC3a9mhR0zSp
	I1TpWbMK9BNMMDDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XZ0i9o1H;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Jm3/gCzH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781870289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOTWgH3E4efc1DupZXjdNhTQSV74w9qLI0tTsa0YRXM=;
	b=XZ0i9o1H6UuMo4I/zn7EcsBePI9wPDcCAIwJnosYZD1FFOGwdJGxlj/Ik7oUDWvgVKQenf
	8EZbSvAQOMuWj/8UnLyzGrsoylCYyU/s+U0y9qRECr1dFyTQGE4kbVegAlQwKpHIo+xIRo
	jWYjmlcx1Whd4iuzpyp86/QYEvT5eeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781870289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOTWgH3E4efc1DupZXjdNhTQSV74w9qLI0tTsa0YRXM=;
	b=Jm3/gCzHE0tCe1rhtXeHiX5IcIkL9Nr5YtH19aZgD4qySbwBNlizfNpdzht03A/wbrPDGz
	EaMRX8UBFpGb2/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38890779A8;
	Fri, 19 Jun 2026 11:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id koXVCdEuNWp3BwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 19 Jun 2026 11:58:09 +0000
Date: Fri, 19 Jun 2026 12:58:07 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Frederick Mayle <fmayle@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajUuprlNICagBYHB@pedro-suse.lan>
References: <20260619112852.104213-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619112852.104213-1-ljs@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DB811760DC
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,pedro-suse.lan:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, Jun 19, 2026 at 12:28:51PM +0100, Lorenzo Stoakes wrote:
> This reverts commit 7b32f64bc512b40b268776c5ac4d354b325b3197.
> 
> This patch caused a significant performance regression, so revert it, and
> we can determine whether the approach is sensible or not moving forwards,
> and if so how to avoid this.
> 
> There was a merge conflict with commit de97ae6222c1 ("mm/readahead: no
> PG_readahead on EOF"), care was taken to ensure that the revert retained the
> behaviour of this patch and cleanly reverts commit 7b32f64bc512 ("mm: limit
> filemap_fault readahead to VMA boundaries") only.
> 
> Fixes: 7b32f64bc512 ("mm: limit filemap_fault readahead to VMA boundaries")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202606181547.617a6967-lkp@intel.com
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
