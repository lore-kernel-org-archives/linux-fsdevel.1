Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E929B204
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754782; cv=none; b=rRKxKviDvWK9Wu+MDCcgXr2N6Tqf9Zd6765Gb/FAWhDbtDM4JOVI8+HilJxHc4eb5f2YOPZhTq9Iik8cXCa6DIqxjoFuDdeoXbIDfRssqiZ7LAh5hviHCyP8wbojuOzQnvNJPHXpfvMdi06CvI740iPywMnTaKZ3Wqwo+4BREyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754782; c=relaxed/simple;
	bh=nk+THvhX2/r0vEDVgmClra0+FdplWLplJdOiKI2tCOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7ojMvMdfu1HpQMdqvOS+EIkVVYTr3LsHUC7gmJ1r5NAS+kaiIuByUw+YZOc4ob3r0D7uuucRF4vT7J9SbMXAmj2TEB5oXO06FXOWVseL0+XPBuHq7Ibw/vZOoejYMsHqieOTdHdScYJ9SigIomtQgGvpVA/0vINJnM4oPjNtg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmQngAVx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iGTgBNa8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmQngAVx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iGTgBNa8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmQngAVx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iGTgBNa8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmQngAVx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iGTgBNa8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 466914D33D;
	Tue, 17 Mar 2026 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773754779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bs1V36bcBkXnymhlBz4+QuriBhH6J3v1hv2mXDlJhBk=;
	b=HmQngAVxDUZR/WfC7ZiNQOtUXn5Ev2JU+QCOHORKg6ynVN8m8n+rkfj63ulgALuh+Aq9Kp
	VfB7Egitf6KnKrDZuHgCXYWFHVnh5n++85VMx4oVsTnpU7SFlgwgSfKK51b9CdSizR6ppZ
	KxiRYAlGoAJnBDpv+6heFvuFAVpZ82U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773754779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bs1V36bcBkXnymhlBz4+QuriBhH6J3v1hv2mXDlJhBk=;
	b=iGTgBNa8Q5WpXWILdh80ayXO332RbZUBqT6yh8iJmPoBuGBV7weclTcUHU/nDY+baspPP6
	ispt+59y8PaLaLBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773754779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bs1V36bcBkXnymhlBz4+QuriBhH6J3v1hv2mXDlJhBk=;
	b=HmQngAVxDUZR/WfC7ZiNQOtUXn5Ev2JU+QCOHORKg6ynVN8m8n+rkfj63ulgALuh+Aq9Kp
	VfB7Egitf6KnKrDZuHgCXYWFHVnh5n++85VMx4oVsTnpU7SFlgwgSfKK51b9CdSizR6ppZ
	KxiRYAlGoAJnBDpv+6heFvuFAVpZ82U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773754779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bs1V36bcBkXnymhlBz4+QuriBhH6J3v1hv2mXDlJhBk=;
	b=iGTgBNa8Q5WpXWILdh80ayXO332RbZUBqT6yh8iJmPoBuGBV7weclTcUHU/nDY+baspPP6
	ispt+59y8PaLaLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3589A4273B;
	Tue, 17 Mar 2026 13:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WESUDJtZuWkGTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Mar 2026 13:39:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8519A0A5B; Tue, 17 Mar 2026 14:39:34 +0100 (CET)
Date: Tue, 17 Mar 2026 14:39:34 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Lai, Yi" <yi1.lai@linux.intel.com>
Subject: Re: [PATCH] fs: revert insert_inode_locked() eviction wait change
 and explain why
Message-ID: <6mknq4cxnf2dhix23gv4wqxy3vnzmhy5opxwpd72ncnpdgnnxr@omhnt5rktvir>
References: <20260316103306.1258289-1-mjguzik@gmail.com>
 <yojtdduvndkyez7mzyah2fznxtztf5boonyxwicp6zb6zw52ao@h6g6zcxhvz3w>
 <CAGudoHEMpe6r+g8OOhFPDAiHtVDraPxA4kSmVLp469g5YZgzYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEMpe6r+g8OOhFPDAiHtVDraPxA4kSmVLp469g5YZgzYA@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 17-03-26 14:12:48, Mateusz Guzik wrote:
> On Tue, Mar 17, 2026 at 2:01 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 16-03-26 11:33:05, Mateusz Guzik wrote:
> > > It causes a deadlock, reproducer can be found here:
> > > https://lore.kernel.org/linux-fsdevel/abNvb2PcrKj1FBeC@ly-workstation/
> > >
> > > The real bug is in ext4, but I'm not digging into it and a working order
> > > needs to be restored.
> >
> > I can dig into that. I expect ext4 ends up calling find_inode() from its
> > ext4_evict_inode() handler or something like that? I was searching for such
> > occurrence for a while but I didn't find it so can you share where ext4
> > blocked? Because the stacktraces from the original report just show the
> > journalling machinery hangs but those are only side-effects of somebody
> > hanging in ext4 with the transaction handle started... Thanks!
> all traces attached

Thanks! OK, for reference the inode has been marked as 'sync' so

ext4_evict_inode() -> ext4_journal_stop()

ends up waiting for transaction commit. However ext4_new_inode() calls
insert_inode_locked() with started transaction handle and thus waits for
the freeing inode with the handle started. Classical ABBA deadlock. I'll
think how we could sensibly fix this in ext4.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
