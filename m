Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9227B357
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335817; cv=none; b=iZqNaKxldSRR+/gQ93z4v2ukzeYMs6l11GoWBExxdLBKXlj6TNO5+MgJhuZw5R4Eo3gwdk6UEbLXuiZ0zS++OuvC+AyM9KXj/3Ve9xF4TE/caPi2IMzy+qN8mqolMoI6pU3NQSPfmsKanhfYwtrOPz7yZHf1oSBbnTMHycUDKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335817; c=relaxed/simple;
	bh=i35fMIjI+GJSvgr8Y+6o9mvnHTjvflBOOS+KOqACJB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz2BMVq36Aal563oICTytDwwrfByizPCdJ097rZYDtRN130sO4OtEDaJno03bblFUzOn2riII+LSCm5xDZJcbbLqEHW1KKxzTGfvppXaF/ZlPDVF1oCAHVqDiIC1g+KmIy9RviyaserzuvmMIQIoRhw2WV4V02HqUq9MGFWt9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aLYZN35a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ryu1iQoe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aLYZN35a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ryu1iQoe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aLYZN35a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ryu1iQoe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aLYZN35a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ryu1iQoe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CD725BD03;
	Thu, 16 Apr 2026 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776335813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3TNXGmv3XfCUlO2uv4IODT1dmjM17MB4GLCCa/pNFg=;
	b=aLYZN35ahDPXwc+zUPwYWdFfyQdNk30JBk+Tf2Vo1p0iJyYPXOv3CM6s4exJ9ai28ekd2Z
	fsGzW6owYx/CYyyDCma4aOS413C3vp98jSc122eP1X89dt9xPj0tZSh30jJN96mUQbinGv
	PFGzFKW16eEPXSWfEH4YMXvEfxu1YwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776335813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3TNXGmv3XfCUlO2uv4IODT1dmjM17MB4GLCCa/pNFg=;
	b=Ryu1iQoe1zIj6ybMOtbybWNr9Wz9yE6oYT0VG35TA++i3FpiAsHPKffo+9gxlXA2qp0mSj
	EGtF7gJlf+/s5MBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aLYZN35a;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ryu1iQoe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776335813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3TNXGmv3XfCUlO2uv4IODT1dmjM17MB4GLCCa/pNFg=;
	b=aLYZN35ahDPXwc+zUPwYWdFfyQdNk30JBk+Tf2Vo1p0iJyYPXOv3CM6s4exJ9ai28ekd2Z
	fsGzW6owYx/CYyyDCma4aOS413C3vp98jSc122eP1X89dt9xPj0tZSh30jJN96mUQbinGv
	PFGzFKW16eEPXSWfEH4YMXvEfxu1YwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776335813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3TNXGmv3XfCUlO2uv4IODT1dmjM17MB4GLCCa/pNFg=;
	b=Ryu1iQoe1zIj6ybMOtbybWNr9Wz9yE6oYT0VG35TA++i3FpiAsHPKffo+9gxlXA2qp0mSj
	EGtF7gJlf+/s5MBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71A574BEFB;
	Thu, 16 Apr 2026 10:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id STG3G8W74Gl2LwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Apr 2026 10:36:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03CC1A0B30; Thu, 16 Apr 2026 12:36:48 +0200 (CEST)
Date: Thu, 16 Apr 2026 12:36:48 +0200
From: Jan Kara <jack@suse.cz>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: Pedro Falcato <pfalcato@suse.de>, 
	Linux FS development <linux-fsdevel@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/5 -v2] Add support for VMUFAT filesystem
Message-ID: <uvsbcmnyucl77ir3dvrwzt42kdw6saja2r67m7e4khw637e5hh@xe7dxerauc6k>
References: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
 <uamj3cggfd4fdvah6jjfbyqmffxaib7yj4upbnkxzudaos6ig6@xz4rhorxkufp>
 <CACwZE5QpR-ZSk=cinLBuuPtLUMnEiEx7UArtZxpbPmGFccOEkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwZE5QpR-ZSk=cinLBuuPtLUMnEiEx7UArtZxpbPmGFccOEkw@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7CD725BD03

On Wed 15-04-26 21:08:21, Adrian McMenamin wrote:
> On Mon, 13 Apr 2026 at 16:09, Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > On Sat, Apr 11, 2026 at 04:11:34PM +0100, Adrian McMenamin wrote:
> > > SEGA Dreamcasts come with a "visual memory unit" (VMU) which contains a slab
> > > of flash memory to save games playable on the VMU or data from Dreamcast games.
> > >
> ...
> > >
> > > These patches implement VMUFAT as a Linux filesystem independent of hardware.
> >
> > Isn't this filesystem a great target for FUSE? You definitely don't need
> > super high performance here.
> >
> > Also, you're missing the fs maintainers. Adding them.
> 
> Apologies for the long delay in replying - I was hoping that maybe
> someone else would have a view rather than my rather inevitable "can
> this go in mainline, please?".

Thanks for your work and the filesystem driver but I have to say I agree
with Pedro here. A FUSE driver is a much better way of providing access to
a filesystem like this. Each filesystem in the kernel adds certain
maintenance burden to treewide changes as it needs to be adapted as well
and over the years the niche filesystems that have accumulated in the
kernel make the treewide changes rather painful and we are rather slowly
removing such filesystems from the kernel than adding more.

With a FUSE driver you get very similar user experience as with in-kernel
driver - you can just mount the device and tinker with the content - while
keeping your code in a userspace library which removes the maintenance
burden for the kernel and frankly makes your life simpler as well. The
performance is somewhat lower due to additional communication and process
switching but for cases like your filesystem I don't expect it to matter.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
