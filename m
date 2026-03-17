Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E362F7AAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736283; cv=none; b=MqL4BWD5dvAx3HfwBa/vrfbtQ5OFSU1SM1uB5TQZoaHlmXwFh6sApKpebxF7cv4U6qUEEFHPsO+3HawpYd5fdZ9zMaN8cExzn+xIp7A1Sw8MgUtHFAmnwScyHTL5gQ4iK7rAZBZKlp70ZWfVAPJ1lO3FOO429DAxk99thU/SGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736283; c=relaxed/simple;
	bh=Tk1+CNW1WvAd8xUt5sogC/zaEnFGixvU0EvVAN2F0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrAjt6BG108uvclvw+I4kcLPWDecGlUWwDOaZD1A52ZQNViEoYm1sCNUVG54R/Sg9hth6RRvoqXjtxExDtNqxOGNnQn2QVJcXlgQZT+WHaIQeLb5kzI0p2P5iqj4mp1vS2raxTA7LRT/KZ5y6E6ca+qyP/NQtX8kFDocpmaC3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cIiwWkXN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/VDI3U1X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cIiwWkXN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/VDI3U1X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cIiwWkXN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/VDI3U1X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cIiwWkXN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/VDI3U1X"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90C104D250;
	Tue, 17 Mar 2026 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773736280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T/HaoeaocrOEUc2/ZAvTarHcpoSwLFGVmTyYJ5Xh5Is=;
	b=cIiwWkXNZ8d+9yxBfcEJmuOFkIBRT6CB5koOCHWJ6I75Z2aWlxGMam6gATcWJQLuX7dEav
	RFljt6lR9xK+SgRDyNHhKWDPtgv2aA4WNMdYPv8S9xOo/Jo/NBz3y+PqV4WsH3NtxH975W
	Jte4lJxi3cbgUu2Mwn8vn9cUJ4AzVSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773736280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T/HaoeaocrOEUc2/ZAvTarHcpoSwLFGVmTyYJ5Xh5Is=;
	b=/VDI3U1XTINsItftReo0PQ+I+uJcDRAkwTMEabIsAGKHyGges7zbT+TkywWr9f6easZVyr
	3OugwPs9zdTAJHDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cIiwWkXN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/VDI3U1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773736280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T/HaoeaocrOEUc2/ZAvTarHcpoSwLFGVmTyYJ5Xh5Is=;
	b=cIiwWkXNZ8d+9yxBfcEJmuOFkIBRT6CB5koOCHWJ6I75Z2aWlxGMam6gATcWJQLuX7dEav
	RFljt6lR9xK+SgRDyNHhKWDPtgv2aA4WNMdYPv8S9xOo/Jo/NBz3y+PqV4WsH3NtxH975W
	Jte4lJxi3cbgUu2Mwn8vn9cUJ4AzVSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773736280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T/HaoeaocrOEUc2/ZAvTarHcpoSwLFGVmTyYJ5Xh5Is=;
	b=/VDI3U1XTINsItftReo0PQ+I+uJcDRAkwTMEabIsAGKHyGges7zbT+TkywWr9f6easZVyr
	3OugwPs9zdTAJHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 874414273B;
	Tue, 17 Mar 2026 08:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D8L9IFgRuWnNagAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Mar 2026 08:31:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C516A0A5B; Tue, 17 Mar 2026 09:31:20 +0100 (CET)
Date: Tue, 17 Mar 2026 09:31:20 +0100
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: VFS minor improvements policy
Message-ID: <pjfdjimwb3br5wtut4a5q4xdys2mgf2d3hkajvinyphhoziaum@u55pnnlrfmgz>
References: <1046306323.1691628.1773494663411@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046306323.1691628.1773494663411@kpc.webmail.kpnmail.nl>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 90C104D250
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

Hi!

On Sat 14-03-26 14:24:23, Jori Koolstra wrote:
> I submitted a patch a few days ago about fixing the docstring of
> hash_name().  This is not a reminder of that patch, but today I came
> across something else in the VFS code, while trying to implement a
> mkdirat_fd syscall, that I thought might be slightly improved. We have
> this anonymous enum:
> 
>    enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> 
> but it is also used as an out parameter in filename_parentat() through
> int *type.  Now you have to look up what this int might hold, so I wonder
> should this struct not have an explicit type that filename_parentat()
> uses?

I guess this is a bit matter of personal preference. I personally would
prefer explicitely named enum in this case and use it where appropriate but
Al? apparently preferred brewity and used 'int' everywhere. The borderline
between "useless typedefs" and "documentation by types" is blurry. I'd say
trying to "fix" this would do more harm than good.

> However, my question is really this: what is the stance of vfs
> maintainers/reviewer for submitting these kind of patches? While going
> through the code in more depth I've noticed wrong/unhelpful docstrings
> here and there, and other minor "issues". Now, Greg KH has taught me to
> be really conservative with what counts as an improvement, for instance
> to not sneak-in white-space fixes in a patch.

If the documentation / comment is pointless or even wrong, that's
definitely worth a fix. They are just not treated with particularly high
priority but they are definitely needed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
