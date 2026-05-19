Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428023EAC84
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180313; cv=none; b=TFoUEFa9TejMh21qzPENTJPK5nKvmy5f2T5bWDKvTnDJdeqk6wkXjzj/qgn59J10GCjdQC6HR/pzoOHrAGdqGNpg6/UDOI4Ik05HQ4eMHUGn4QiBSox+JsP65YNErzqmLSaO/GSnwhH/YOBTb4Z21+9Gosc6btTSrOPWlMfa/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180313; c=relaxed/simple;
	bh=XDP1fY549TYDvl03vsmX/Cl9vu/6yPcUFkdIr1jX+Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwn/0bdXx3+44aomlBvHR20NzcY4eunfnr5Y/ZjpRQlnW6O2batyMcu9dg3Xg9N5aYc7eaNHkwTl2x+rGZzbofT8QieZ2+rU26sw1VTdBK7I/5FfhutSERXQyu82NiLBRrP/vbEjFca9LMbnVCUgQILPXoik++57xREkCRKX1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PqwLcI/m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xkUFEZX1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PqwLcI/m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xkUFEZX1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PqwLcI/m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xkUFEZX1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PqwLcI/m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xkUFEZX1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 579385D68A;
	Tue, 19 May 2026 08:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779180310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJFJUma/ZTHC3w1sDcmLeoMBS4NsPZRd9YgMW1oWErQ=;
	b=PqwLcI/mUQreelUgHEq3UAcKmdGdQ5In2fDxkg4VaVoENEK68zRwTSL3bPzZ+o10C+wBAG
	aMjOUOg9kvBCD7dKJKV1GhkSjBiq5mibmJQYq1ATuQawT8W6fRZymauxgvLkWpo+ldT9p/
	Tty/28+Aj05K77LJIcUb5AbwAzk9aps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779180310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJFJUma/ZTHC3w1sDcmLeoMBS4NsPZRd9YgMW1oWErQ=;
	b=xkUFEZX19eGGDj9fUAasJzBQ3s2HULj8kbz7JedYPsDv1lxH75Fq+Kdkkj0TiyRGpsyAV9
	RTrMB+KX2LdX+yBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="PqwLcI/m";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xkUFEZX1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779180310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJFJUma/ZTHC3w1sDcmLeoMBS4NsPZRd9YgMW1oWErQ=;
	b=PqwLcI/mUQreelUgHEq3UAcKmdGdQ5In2fDxkg4VaVoENEK68zRwTSL3bPzZ+o10C+wBAG
	aMjOUOg9kvBCD7dKJKV1GhkSjBiq5mibmJQYq1ATuQawT8W6fRZymauxgvLkWpo+ldT9p/
	Tty/28+Aj05K77LJIcUb5AbwAzk9aps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779180310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJFJUma/ZTHC3w1sDcmLeoMBS4NsPZRd9YgMW1oWErQ=;
	b=xkUFEZX19eGGDj9fUAasJzBQ3s2HULj8kbz7JedYPsDv1lxH75Fq+Kdkkj0TiyRGpsyAV9
	RTrMB+KX2LdX+yBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E25F593AA;
	Tue, 19 May 2026 08:45:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 348HExYjDGpgHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 08:45:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6523AA0ADE; Tue, 19 May 2026 10:45:09 +0200 (CEST)
Date: Tue, 19 May 2026 10:45:09 +0200
From: Jan Kara <jack@suse.cz>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH v2] dcache: add fs.dentry-limit sysctl with
 negative-first reaper
Message-ID: <mptmd2qxgqwkhfrq5dgwomysdnwoy6fnztr3ibrvbbsb7hvrv3@peg7mojzfucy>
References: <20260516-limit-dentries-cache-v2-1-c733a78e603b@ddn.com>
 <agj5JkPZ7eNbFueR@casper.infradead.org>
 <aglh7SrXWbYgD3nA@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aglh7SrXWbYgD3nA@fedora.fritz.box>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 579385D68A
X-Spam-Level: 

Hi Horst!

On Sun 17-05-26 09:57:41, Horst Birthelmer wrote:
> On Sun, May 17, 2026 at 12:09:26AM +0100, Matthew Wilcox wrote:
> > On Sat, May 16, 2026 at 04:52:54PM +0200, Horst Birthelmer wrote:
> > > There was a discussion at LSFMM about servers with too many cached
> > > negative dentries.
> > > That gave me the idea to keep the dentries in general limited
> > > if the system administrator needs it to.
> > 
> > I feel you should link to the dozens of previous attempts at this kind
> > of thing to show that you're aware that this has been tried before and
> > you're doing something meaningfully different.

<snip>

> As a conclusion, I think I have an uncommon perspective on the cache entries
> since I don't usually work on vfs but argue from the perspective of a fuse server
> Where the kernel makes us waste resources. This hurts way more in the FUSE context
> than in a 'normal' file system.
> I have taken the look at the dentry cache just because people told me that this
> has to be solved in the vfs (and I agree). I actually have a somewhat hacky patch
> to do this from fuse and only for the fuse sb.

So I'm a bit confused here. The changelog speaks only about negative
dentries (and that's what the change also concentrates on). OTOH you've
mentioned multiple times that you are not really interested in limiting
negative dentries but rather positive ones because you have a problem with
cached inodes. So can you perhaps formulate what is exactly the problem
you're trying to solve?

Also you mention that cached (positive) dentries and inodes are a wasted
memory when they aren't used. That is certainly a valid view, OTOH you can
never predict future so you don't really know what will get used in the
future and thus will be useful. That's why we currently side with the idea
that memory that isn't used for something is wasted and unless there's
something to use the memory for, we cache dentries & inodes & page cache in
it.

If I remember correctly the discussion we had at LSF, the problem why inode
caching is a problem for you, although there's enough free memory and no
memory pressure, is that these cached inodes pin memory on the other end of
the FUSE communication channel and there we are getting short on memory. Is
this what you're trying to solve?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
