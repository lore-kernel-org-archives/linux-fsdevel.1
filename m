Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26083F1042;
	Fri, 28 Aug 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907921; cv=none; b=kguarD2oU66nFwTc1RICLporXfziWEL0gw2718OI+Deij6QBHJklNTKIJ/0DDDXYQoF+XhYnJylkmV4e3g34EXlOXxPAqpKbXqp7wQS6RtQhnjmGYHkjSvOIrl4jotM8IsZY4IXn3E1G/jh1cfBldwU2S6zJoZr3y6TQrwkiH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907921; c=relaxed/simple;
	bh=2a2sdIzPJbx+Ry0BurugAGUPhNNXbx56efia+D8m1IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSv/S6WAMJibgkRBdewNdHrD9/O15XwP1ZvvKUYZ4XFAzHIJAhA4ipLP6UeTEnU8K/WX9l/m3J/nLESGJrFL0rvZJssNWv+tYkjdT1qqfVFWsFRMNgULC+cAyYLttEw0I7GMdLFuuuHlXnLEQ49UEwy9UyBqKfzrgEr+CBFREpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RiCKupJ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e2YmM9NZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZQjOS1y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zULHN6LT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RiCKupJ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e2YmM9NZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZQjOS1y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zULHN6LT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9CBC21E7D;
	Fri, 28 Aug 2026 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787907913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KBa50P/OlE629LKQjDL4uvNc/yEe7VUaxk1pMOAkLQ=;
	b=RiCKupJ4HEUVzKqsrnhbm/SnOaLMrLbOKY/+385Jz/L1QLyNHC9wuWCqYpwLqxv0j2QJdz
	aTaCwxk3ie6Q5vVx0zXpnaEfuhZt9yrZIE19Q9maUc8hSuhXhifb033xVuLc20LMoarrxd
	9VHv0Gs9BX6RymJKwgOKeAPGpBFTiwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787907913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KBa50P/OlE629LKQjDL4uvNc/yEe7VUaxk1pMOAkLQ=;
	b=e2YmM9NZOTeTx4DJUuQ0+ck2FUEuGMZh1KLsH2EbtT+i6Ksoy15FXCTsGC+vXl7sz7vizz
	Y01OAqoLkyEtEBAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gZQjOS1y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zULHN6LT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787907909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KBa50P/OlE629LKQjDL4uvNc/yEe7VUaxk1pMOAkLQ=;
	b=gZQjOS1yaYTjA1rS1C1qV7ehsBve2mYTGQhUPN0wMAWoaEO06r/gY1583GHhquGPmrcpqQ
	LaLq+yBtExrmkqlNEOVivcxX3sm6x25goIpuMjIuPVyYIXv303WZDHH6hkxcq2/VIBzZTp
	0twhL4G1mbZ7/lqMzG8aurgzfbJ+8FM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787907909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KBa50P/OlE629LKQjDL4uvNc/yEe7VUaxk1pMOAkLQ=;
	b=zULHN6LTQ3NTkHF/USahm39otpfUaGDbriGQG7757ECqhjh/1+uMNoItOYGiznpORrdq+Y
	xuPoDl8yxyt72+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6359E13687;
	Fri, 28 Aug 2026 09:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5c4+GEVPkWrfYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Aug 2026 09:05:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D7E22A1324; Fri, 28 Aug 2026 11:05:08 +0200 (CEST)
Date: Fri, 28 Aug 2026 11:05:08 +0200
From: Jan Kara <jack@suse.cz>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached
 connector
Message-ID: <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
References: <20260827045007.3831259-1-4ncienth@gmail.com>
 <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828042421.964822-1-4ncienth@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A9CBC21E7D
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.01

Hi!

On Fri 28-08-26 13:24:19, Daehyeon Ko wrote:
> You are right that an fd-held dentry cannot satisfy the count == 1 check. I
> was imprecise in the report: the fd and the final unlink refer to two
> different hard-link dentries for the same inode.
> 
> The setup is:
> 
>   1. create A/x and link it as B/y;
>   2. open B/y, add the old-group inode mark through that fd, then unlink
>      B/y, leaving i_nlink == 1 while the fd retains the B/y dentry;
>   3. race these two calls:
> 
>        unlink("A/x")
> 
>        fanotify_mark(racer_group, FAN_MARK_ADD, FAN_MODIFY,
>                      victim_fd, NULL)
> 
>      where victim_fd still refers to the already unlinked B/y dentry.
> 
> So the A/x dentry checked by d_delete() is not held by the fd and can have
> d_lockref.count == 1. Its unlink drops the inode's last link and reaches
> dentry_unlink_inode() -> fsnotify_inoderemove(). At the same time,
> fanotify_find_path() gets the same inode through the fd-held B/y dentry and
> adds the racer mark.

Thanks for explanation of the reproducer. Now it makes sense. The
conclusion from this is that fsnotify_inoderemove() can indeed be called
for still fully alive open inodes which should be (think of permission /
pre-content events) still generating events. That could be actually
breaking some assumptions of userspace although I don't think it's a
serious issue in practice because users of permission / pre-content watches
tend to use filesystem / mount watches.

Also I think we could generate FS_DELETE_SELF twice for the inode - once it
will we generated as a result of d_delete("A/x"), and finish_dput() ->
dentry_kill() -> dentry_unlink_inode() will generate it for the second time
on the last close of the open through "B/y". That should be mostly harmless
but still it's an oddity to keep in mind and preferably avoid if we can.

Now there's the question about the best fix for the problem. I've realized
we cannot just remove the call to fsnotify_inode_delete() from the place
where fsnotify_inoderemove() is called (and rely on the call from
__destroy_inode()) because the connector holds inode reference and so
__destroy_inode() would never get called. Hrm, this is a hairy issue and so
far I don't see a good place to reliably trigger detaching of connector
from the inode. One reliable place would be iput() but that's really ugly
and would slow down every iput() user. The cleanest solution I can
currently see is to stop holding inode reference from a connector as I've
proposed in the past. Then we can reliably perform the cleanup in
__destroy_inode(). But that will be a rather non-trivial undertaking. Amir,
do you see some other option?

								Honza 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
