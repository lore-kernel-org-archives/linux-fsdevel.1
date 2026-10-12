Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F73B0AE1;
	Mon, 12 Oct 2026 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804422; cv=none; b=D4zlNOd33T78Vd782bxei35GUOSDE5NXirZdUQP5S4zTL1nqw9t29MJpL6sRJ4G9J+Pnkrk9nPdw5Dxf6v7eZNjxzelT1NExb5M8pWyXA1dVTKjZM3eGzRgLstioz1y9iZlOdxvIykxpUdRQKDAePLGhQfpNUkdHSBUwsxY+BNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804422; c=relaxed/simple;
	bh=RCQe9WodeNQiFzVtnhMu+Pk78+m+cpv3g3U5fihjns8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKeV1WVcXjirL4cQKeEig3lbIG5yXO4aO7g3S+jNbj/GMVmqQne3icf6FmZ9PLGcpf0tSA2uYUJu3iJxLwJfkaYe/Uo6Ub3MHiTTx0NkPHW/YAaQXTmbGiMn/RvGmvRlOXhmOhMODd4EmKvRbfUEnNgKH36sav38c/GuNQYYMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KY0YNbfA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gog4BZLQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VCVLTZ6y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5/adXDLk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KY0YNbfA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gog4BZLQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VCVLTZ6y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5/adXDLk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB2E51F45B;
	Mon, 12 Oct 2026 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791804419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFX1eU+mh/9ZnC7vvGdjy6ewiLFYyuAGo66NsgTTBWo=;
	b=KY0YNbfAU+TkWJ+9QildhcfQtXrhzcBa4iVyFVh6YF1GZM5aTH8su7hFAhecqQszWTUTLU
	CC9WfnoXFnP4EcMakcaN9h5HZgKgpSYgVqhHic+t0Vl7bTdDteL3TNpvZh5wNQLM90k7t0
	/YdFd/Zju5liTkYcYWb7OauZFjbEzus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791804419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFX1eU+mh/9ZnC7vvGdjy6ewiLFYyuAGo66NsgTTBWo=;
	b=gog4BZLQOz+Cs/fsIWe5gCweQmKzZAOP7Q9Y/bJ8TCYgP6YtNknOwGC82Erh8vxsdaQs54
	ZQm6gJu+WPBtfmBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VCVLTZ6y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="5/adXDLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791804418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFX1eU+mh/9ZnC7vvGdjy6ewiLFYyuAGo66NsgTTBWo=;
	b=VCVLTZ6yrHHCbUivf2nPpGMpxy/91T9Qfa7vt+edacVdWBEMBL8uIqXur0QYV+6LX3EXpj
	rSnYfVObehbyOoiAkDd6qb1zfhcapUcMsKdRM2j+Vxi5KjBVe3MMvBsHwXrGxxy6v4INqO
	B7njoYWkB2+odAwwLDTxsI/GxqfWrtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791804418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFX1eU+mh/9ZnC7vvGdjy6ewiLFYyuAGo66NsgTTBWo=;
	b=5/adXDLknDKHUuWXCvdMXjckBvQ49lpEq4dKhF35JQ0eZSIOtrbXU/MDYGfbIpZTySvNTd
	NHK7ymZOOYOmuuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2E4913314;
	Mon, 12 Oct 2026 11:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z5iFJwLEzGrMaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 11:26:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51CEFA1403; Mon, 12 Oct 2026 13:26:50 +0200 (CEST)
Date: Mon, 12 Oct 2026 13:26:50 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Neil Brown <neil@brown.name>
Subject: Re: [PATCH 16/21] fsnotify: let a filesystem refuse marks on its
 objects
Message-ID: <q2wgtm7eheeg3h7aanbmn7f64tchyieqwzx4qdltlizknbybnb@56rqglxb2ava>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
 <20261002-work-mount-fixes-4-v1-16-dd44b89d44ce@kernel.org>
 <CAOQ4uxh9O4-sUpN5mT-GHriGQ26R_n++mELNh3wOPKSrMYDSRQ@mail.gmail.com>
 <ktwf3k6arjrcezb2ah3fmj7q7qu235ri4yau5c6hmwithutl3l@3xk6vqisfjhj>
 <20261009-zinssatz-hinreichend-havarie-9cfa89532412@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009-zinssatz-hinreichend-havarie-9cfa89532412@brauner>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EB2E51F45B
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,zeniv.linux.org.uk,kernel.org,google.com,brown.name];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 09-10-26 09:48:37, Christian Brauner wrote:
> On Mon, Oct 05, 2026 at 08:02:59AM +0200, Jan Kara wrote:
> > On Fri 02-10-26 16:26:19, Amir Goldstein wrote:
> > > On Fri, Oct 2, 2026 at 3:54 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > Don't let nullfs be watched. fanotify refuses mount and filesystem marks
> > > > on SB_NOUSER superblocks but inode marks of inotify, fanotify and
> > > > dnotify go through. The one inode of knullfs is the root of every
> > > > kernel thread and the following patches make it reachable from
> > > > userspace as the directory that stands in for an unmounted mount. A
> > > > watch placed through one such directory would report the opens through
> > > > all the others, across users.
> > > >
> > > > Add FS_DISALLOW_NOTIFY next to FS_DISALLOW_NOTIFY_PERM, refuse a mark on
> > > > any object of such a filesystem in fsnotify_add_mark_list() where every
> > > > backend ends up and set it for nullfs. There's nothing to watch on a
> > > > permanently empty and immutable filesystem.
> > > >
> > > 
> > > I don't particularly mind this custom opt-out, but
> > > shall we perhaps instead deny marks on SB_NOUSER directories?
> > > IIRC, we already wanted to deny marks on any SB_NOUSER, but then
> > > it turned out that some users set inotify watches on pipes, so we stepped
> > > back and restricted SB_NOUSER only for fs/mount marks.
> > > I think that the same logic extends well also for directories, because
> > > I don't think that any existing SB_NOUSER fs is supposed to be
> > > exposing them atm, so no regressions are to be expected.
> > 
> > Yes, I agree that placing marks on directories of SB_NOUSER filesystems
> > should be denied as well because it doesn't make sense which would settle
> > this case without a special flag AFAIU.
> 
> The problem is that we're introducing a file in another series which
> doesn't work with this option. My proposal would be that we do the flag
> now to get this fixed and then we follow-up with another more
> comprehensive approach.

OK, fair enough. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
