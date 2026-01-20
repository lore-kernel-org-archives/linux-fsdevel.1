Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB92798F8
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942823; cv=none; b=kQc90vfZNJnpMgz/8lDWbXpYC+9tLY6VqevCfafPqmR4c2ILvl1nDE4aMyNafAaktCYDSb8uFBI75gUXaSLoTv3c8qLE/7ixMKGeB4Dh6YpfnV2610nvYTZbAseQKvQTvSlJaeZqHiYj2b8/8z5vo+94rOqvLhkShcCYMzTBC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942823; c=relaxed/simple;
	bh=LD78P2nHsX+u1qC1gWaNkU6jMSI5w6F6i6rvpwvIVlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfrAT8dazMqYdHCYjksvHuvPFZt0WtEZ5zWiI9kVzjn5sQ0Hyl7sdmdIfcax+Al1BrDrQPYRZ+82RLsHL3puyN8/LDhlg9ltWDFV93HHds8Og7T1Z/iAdMBcpQdgd7XcGRbcB1aA7db7Jvuvf2pPOJ7AD00YDZOPUwjcUs9+vd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ewA7A0lk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C2d8ckhQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TK5xvwpb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iT1FC4Oe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ewA7A0lk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C2d8ckhQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TK5xvwpb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iT1FC4Oe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E21AC33684;
	Tue, 20 Jan 2026 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768942820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3OUQL7gJPJlJHCXt3tpP7rt4MkrBr79AmohROWuwM0=;
	b=ewA7A0lk2r8FL8RklOvsE7ua+vrpsMAEJjK9/rTdG1azwGRktTYbz6PLzzI7SzeImIY6rR
	n4QdZqtuumAGZV2uoFfusArovT6AuesXuMKMLu7DoW5WZj0j2J9xZaixDQyd6u17pkb5Oj
	GGsydtxzJymnRMHJ9nvZZa0x9B/T0xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768942820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3OUQL7gJPJlJHCXt3tpP7rt4MkrBr79AmohROWuwM0=;
	b=C2d8ckhQccAXPP+OIEQQT+VONHmhduBWePc+1B38Fnaq4HYDxOpu8w5dG3G7igHD9nTZCH
	+0LmU2CrRy7beWBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TK5xvwpb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iT1FC4Oe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768942818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3OUQL7gJPJlJHCXt3tpP7rt4MkrBr79AmohROWuwM0=;
	b=TK5xvwpbEOetBJrFG9x2DeDouSqKW02qL98R+3s+DL9GGXjlVVwF22ZKowb70IsTkHeT+m
	wSrQIwnp1gaum541WCJTQ3/25l7rvE0nznyLeV4dBYKjoDTy6TTi50Ptb/f1iNUo/C80G/
	m0YiYCSpT1wfk5ZvoroQHry5u3fMh5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768942818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3OUQL7gJPJlJHCXt3tpP7rt4MkrBr79AmohROWuwM0=;
	b=iT1FC4OeDsO60CZ0I9cV08fAq7lVK52rjxjEBLVH2rrC4GzFipWey14yNnapy7/SVvlNni
	04Y13S2kiXymJcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DD703EA63;
	Tue, 20 Jan 2026 21:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a9oSIeLsb2miXAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 20 Jan 2026 21:00:18 +0000
Date: Wed, 21 Jan 2026 08:00:15 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/4] initramfs: Refactor to use hex2bin() instead of
 custom approach
Message-ID: <20260121080015.6aca8808.ddiss@suse.de>
In-Reply-To: <aW_m5eRzqRJzFWnF@smile.fi.intel.com>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
	<20260119204151.1447503-3-andriy.shevchenko@linux.intel.com>
	<20260120230030.5813bfb1.ddiss@suse.de>
	<aW_m5eRzqRJzFWnF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: E21AC33684
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Tue, 20 Jan 2026 22:34:45 +0200, Andy Shevchenko wrote:

> On Wed, Jan 21, 2026 at 07:12:50AM +1100, David Disseldorp wrote:
> > On Mon, 19 Jan 2026 21:38:39 +0100, Andy Shevchenko wrote:
> >   
> > > +	ret = hex2bin((u8 *)header, s + 6, sizeof(header));
> > > +	if (ret)
> > > +		error("damaged header");  
> > 
> > The changes look reasonable to me on first glance, but I think we really
> > should improve the error handling to abort the state machine on
> > malformed header here.
> > 
> > One further issue that we have is simple_strntoul()'s acceptance of
> > "0x" prefixes for the hex strings - any initramfs which carries such
> > prefixes will now result in an error.
> > It's a pretty obscure corner case, but cpio is really easy to generate
> > from printf(), so maybe there are some images out there which rely on
> > this.
> > 
> > I've written an initramfs_test regression test for the "0x" prefix
> > handling. I'll send it to the list.  
> 
> Is it specified?
> 
> The standard refers to octal numbers, we seem to use hexadecimal.
> I don't believe the 0x will ever appear here.
> 
> Otherwise, please point out to the specifications.

The kernel initramfs specification is at
Documentation/driver-api/early-userspace/buffer-format.rst :

  The structure of the cpio_header is as follows (all fields contain
  hexadecimal ASCII numbers fully padded with '0' on the left to the
  full width of the field, for example, the integer 4780 is represented
  by the ASCII string "000012ac"):
  ...

I.e. a "0x" isn't specified as valid prefix. I don't feel strongly
regarding diverging from existing behaviour, but it should still be
considered (and documented) as a potentially user-visible regression.

Cheers, David
