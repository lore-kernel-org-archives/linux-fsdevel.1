Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA63BB9F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867179; cv=none; b=t7WDEeeE+A4i4uNXBZ5wpKyDyfPGRv0KQjVw8KG1WkrHPUt4GW9l8TXAg2rcUMCP03KYii95jxILNpzmPG42gpOPgNIxzqgeYSr7HKA1/P5yRsxdAQGhwjv/8yxMSg6/M7O978UHsdCFfaGSUF0diWaoTd7Rt0Mzmh4Nt7rTLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867179; c=relaxed/simple;
	bh=5rdJpg2rd3INlVyfuQwfC0dcnjPdcIh+JUqOe+Z9Mx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHrxYhtPU0kzhKe4+BVN8YNJulaBE1+KvRp2f1A3LCdqt+W1LSYYPZ5joFuQx8NMP9C8ST5thjiVt7CnfGuAAOTQHYkbS+zfiVhldBweSzr+/MtmrnU4LA8V3oOQDr389NZHcvPwNYUZFO0yKaNVPFhGoPk9+qoLyVIoCsH0vug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xHSj7LXx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BLiLxuYM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=crg4hc4l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WFX8EDIY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xHSj7LXx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BLiLxuYM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="crg4hc4l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WFX8EDIY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECF0F5BD39;
	Mon, 30 Mar 2026 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uEEkodjNTdUvr8AqOI3IonwicgnzCa08Bw0QF+PdbY=;
	b=xHSj7LXxvYrSKlGzf2OqIOMVESBsz1YlfGXx3AzvwrAZcL40/fQV6yF9IDw9Gs7eXTMaJI
	KpYGG5GWQyCG4ypSkQmc8VCWdhp1Z1qLAKVKwicvZImb4xO0HEYcFG234T/1jIBdfP0fu9
	kAXNEfz934RNb3BVh/2sz6+UhqRTz0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uEEkodjNTdUvr8AqOI3IonwicgnzCa08Bw0QF+PdbY=;
	b=BLiLxuYMuvGJRJrPoF3mLgK7t5ufRJ/+pGOX0Ao6wB5AOF3iHLn92icazomma9VXgdKiQ7
	w3E6K74tJK7LOpBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=crg4hc4l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WFX8EDIY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uEEkodjNTdUvr8AqOI3IonwicgnzCa08Bw0QF+PdbY=;
	b=crg4hc4lzl4fqa/OOj2zqmIslTbtnEmTuzgHh0ol2Xk17JUXjnqvfR61NfuTjq46yIXD8F
	ASaJO9JHt4su7TW+4aE0hpzeFKxuH4pr3DDgd2hRMuus4PVeX+vjuc1cvkt/aKizaSZ17c
	AGVzCtUUZMfoSUo7zuoK0Crh2l8kYd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uEEkodjNTdUvr8AqOI3IonwicgnzCa08Bw0QF+PdbY=;
	b=WFX8EDIYXHyFR9S5YstocoZh6gmykDhZUhJAzEV7wsCt+oiHxNFaH2qbzPLfkTHskro4zL
	YyzcntyUZx0cWtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 427B84A0A2;
	Mon, 30 Mar 2026 10:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1gr5OuNSymkqawAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 30 Mar 2026 10:39:31 +0000
Date: Mon, 30 Mar 2026 21:39:26 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/6] initramfs: Refactor to use hex2bin() instead of
 custom approach
Message-ID: <20260330213926.1a3587e4.ddiss@suse.de>
In-Reply-To: <acpIhBT22b2H4rfr@ashevche-desk.local>
References: <20260329105307.2876-1-ddiss@suse.de>
	<20260329105307.2876-5-ddiss@suse.de>
	<acpHYPiOy-S3PUNT@ashevche-desk.local>
	<acpIhBT22b2H4rfr@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ECF0F5BD39

On Mon, 30 Mar 2026 12:55:16 +0300, Andy Shevchenko wrote:

> On Mon, Mar 30, 2026 at 12:50:30PM +0300, Andy Shevchenko wrote:
> > On Sun, Mar 29, 2026 at 09:30:26PM +1100, David Disseldorp wrote:  
> 
> ...
> 
> > >  /*
> > >   * bogus newc header with "0x" prefixes on the uid, gid and namesize values.
> > > - * parse_header()/simple_str[n]toul() accept this.
> > > + * parse_header()/simple_str[n]toul() accepted this, contrary to the initramfs
> > > + * specification. hex2bin() now fails.
> > >   */
> > >  #define CPIO_HDR_OX_INJECT \
> > >  	"%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s"  
> > 
> > I think this change should be in patch 1.  
> 
> Hmm... Re-reading it, seems the both needs to be updated.
> 
> For the patch 1:
> 
>  * Bogus newc header with "0x" prefixes on the uid, gid, and namesize values.
>  * parse_header()/simple_str[n]toul() accept this, contrary to the initramfs
>  * specification.
> 
> For the patch 4:
> 
>  * Bogus newc header with "0x" prefixes on the uid, gid, and namesize values.
>  * parse_header()/simple_str[n]toul() accepted this, contrary to the initramfs
>  * specification. hex2bin() now fails.

Looks good to me, Andy. I'll wait another day or so for any further
feedback and then send a v5 with this.

Thanks, David
