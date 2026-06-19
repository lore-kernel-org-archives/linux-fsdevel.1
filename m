Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC82936EAA2
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863614; cv=none; b=cdDlyQ8hq4ZrmLwE2N24y187gDlLGReq/26by3PodmbW0YMPbYrHPffwC4CvsINR2kU0uvG3GNTnVSd7rftXf8bESx+ejrnjoB8lp/SjAJamGUtCO6AoOrEZaVh1sX4GUIFk7/XiftD+zMr4Tp0ynwAge0+ol6BMPSano8yonJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863614; c=relaxed/simple;
	bh=cbFUlrFvBn4xxrrvwpXVbJDJvLV8XCZZwP+zlynmBIQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjyp1K7kM0B9+ppMwX0XhZLuLJ0PY7YNNGvWlzmerfVaHi8R1rGPdpEDcSCnJ6/UjgSwJRNGPZ9cLfmByfvG89ix3OvS1eRRHfWlHwAErUUJhH7ojJbzrhLQZI6nr+2sRXN6X83JRfqihe9vvhc2d7TgWD+VbuxhTPJ3naacJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PbQ3kB26; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2yR6OnBC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PbQ3kB26; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2yR6OnBC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PbQ3kB26";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2yR6OnBC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PbQ3kB26";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2yR6OnBC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D1DF760B5;
	Fri, 19 Jun 2026 10:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781863608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RnDf1fvXLzrEOjsqU+rTWPIujettJ5D7GMcaGB4wko=;
	b=PbQ3kB2633CN1UsX1y2KkiQd6mG0Q0v5uN+gGBIjHSYZ1eXaVdChQu8GhICme7+dbxQtKn
	ubYLfPGKqUzNEA3tgmWNIyOFz4z7vm/vOsJeGPocnj1Oe/fqlod8pas/iRb3haMDZDt9Mc
	L6ghVEDynaTmZKC6acDKjM9QtHofE1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781863608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RnDf1fvXLzrEOjsqU+rTWPIujettJ5D7GMcaGB4wko=;
	b=2yR6OnBCDDqpw4z9wyV+JCRd1qaczwrjdJXhKTbQw3vzc35gSEVCinqBKanNGoDU7mhN6R
	4DZH9b6HMFdAgvAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PbQ3kB26;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2yR6OnBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781863608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RnDf1fvXLzrEOjsqU+rTWPIujettJ5D7GMcaGB4wko=;
	b=PbQ3kB2633CN1UsX1y2KkiQd6mG0Q0v5uN+gGBIjHSYZ1eXaVdChQu8GhICme7+dbxQtKn
	ubYLfPGKqUzNEA3tgmWNIyOFz4z7vm/vOsJeGPocnj1Oe/fqlod8pas/iRb3haMDZDt9Mc
	L6ghVEDynaTmZKC6acDKjM9QtHofE1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781863608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RnDf1fvXLzrEOjsqU+rTWPIujettJ5D7GMcaGB4wko=;
	b=2yR6OnBCDDqpw4z9wyV+JCRd1qaczwrjdJXhKTbQw3vzc35gSEVCinqBKanNGoDU7mhN6R
	4DZH9b6HMFdAgvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA29D779A8;
	Fri, 19 Jun 2026 10:06:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F73fKbcUNWrWGAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 19 Jun 2026 10:06:47 +0000
Date: Fri, 19 Jun 2026 11:06:46 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christian Brauner <christian@brauner.io>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] efs: Remove EFS
Message-ID: <ajUSQ30oi-fyh0NH@pedro-suse.lan>
References: <20260618211822.3599089-1-willy@infradead.org>
 <ajUIMvi5Nyjp6t2v@lt-jori.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajUIMvi5Nyjp6t2v@lt-jori.localdomain>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[xs4all.nl,infradead.org,brauner.io,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1D1DF760B5
X-Spam-Score: -4.50

On Fri, Jun 19, 2026 at 11:28:03AM +0200, Jori Koolstra wrote:
> This seems like a good idea. A couple of thoughts: should this maybe be
> CC-ed to Linus? He has in the past been critical of removing old
> filesystems. There is also something arbitrary about removing efs, but
> not minix for instance. It would be great if we had some more objective

I'm fairly sure minix is staying for the same reason alpha is staying[1]. I
don't think it's productive to unearth that particular debate at this
moment.

> criteria for removal. I have also been thinking whether there is some
> use to keep at least one old simple filesystem maintained and up to date
> with modern API. It could function as a reference.

We already have one - it's fs/ext2.
(modern API? maybe not so much. still has buffer heads, uses mpage, etc.
alas.)

[1] or that our old simple reference filesystem is ext2 and not e.g fat[2] :)
[2] i may or may not feel sick after suggesting that
-- 
Pedro
