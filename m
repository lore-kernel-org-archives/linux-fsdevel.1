Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EEE446BF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319072; cv=none; b=Soyj/Qv+CZ3U2ud53cK9aZ1EpFpyubtuK6atcAOShmB+3ohGl14O3T5+e5w4n14FF9N1BIX/GgA3A2+uZWa0mXHiuVGrtK2goi9Y6lsntpXvTt8DJVcHfNrsSf1YVY8Ey/iTxO5Vy9zR7h4hV8LvXOV7jfUspebLaaRP3C6lN8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319072; c=relaxed/simple;
	bh=7X4LCubkf4qICV9L/QScmDIsBLZqaUQq6SZC/Jx5VUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNo1QrN+c03kbWUlJ1irUaE9g2d8VJ6xTZhmCMtxrbgyfOKzKxobdEdLl3FLlp91qHyAOApIJh9/3VydotjzkMIT3HD9wepVmb+rLzBjQd75wPuoxgZU8bGPMnvVy4vmzEmfhAxla7nflyvYKJtCd8jn3taOwZ/gEFh1OyLJxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BMOYxe4Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HyQJ9wf4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2f/SBpsE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zkuqGP7d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BMOYxe4Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HyQJ9wf4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2f/SBpsE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zkuqGP7d"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B55053E16;
	Wed, 29 Jul 2026 09:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785319064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpqm3qXNMEEYU33pegSYP4qns9JRmr0RwOBLDBlH9AE=;
	b=BMOYxe4ZOMx7A9Umer1Jei/NJwRNmHtd4MJF3Ytytf5aC/45cBwSNCKSuXD3wZjUEYDZJB
	YRJ7Xrr5xn+pdvspEJFo9fo5XJuzyH2LrlowyB+45uITlH80o9XXxHP4YLD+ec1oI4YtK+
	7wsqHz/RoEt1sv4oQuNOI+nxwfrhxvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785319064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpqm3qXNMEEYU33pegSYP4qns9JRmr0RwOBLDBlH9AE=;
	b=HyQJ9wf4f7xPE7SpMy7fcOowQN3nmEHUzvWe33NyWzO3lhEWCPQUz1WlmgHiaYbfPX0SPn
	kynuuziz+szwdSCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785319060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpqm3qXNMEEYU33pegSYP4qns9JRmr0RwOBLDBlH9AE=;
	b=2f/SBpsExr+x1qlk84aEp9G1GTtCEf4FsHH205mXjMsizcqaWCPwFW/+Vqxu2J7KPyQK8d
	iMWgBbb9uS3YRQVWqFstxMhSEquxGdMmU+T2cMks4IjGcyO7ZCwkMbsUX3D6vDeKUsnb7L
	MHuLadXNxwvtH2QKgE+Gu+LO7ou3ILY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785319060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpqm3qXNMEEYU33pegSYP4qns9JRmr0RwOBLDBlH9AE=;
	b=zkuqGP7dit6pemP7Udz0pDxCy2xwsP3bQhg7KdmlNJBMcQzI0SMp8kZSkuU+hPzh+P1Sqe
	X2CoVWJSJiTTWyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD6E5779A1;
	Wed, 29 Jul 2026 09:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gJtMKpTOaWo4JwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 Jul 2026 09:57:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5996BA131F; Wed, 29 Jul 2026 11:57:25 +0200 (CEST)
Date: Wed, 29 Jul 2026 11:57:25 +0200
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <xiang@kernel.org>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org, 
	cyphar@cyphar.com, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5] erofs: accept source file descriptor via fsconfig
Message-ID: <7kgp355d25csimg5txuxhp33zmc5onxpyxdtkarmun62rblp7j@etbql27573dl>
References: <20260728160619.853924-1-gscrivan@redhat.com>
 <amlaIt8jjy_mSK-j@XiangdeMacBook-Pro.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amlaIt8jjy_mSK-j@XiangdeMacBook-Pro.local>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]

On Wed 29-07-26 09:40:50, Gao Xiang wrote:
> On Tue, Jul 28, 2026 at 06:05:32PM +0200, Giuseppe Scrivano wrote:
> > Allow userspace to pass an already-opened file descriptor as the mount
> > source instead of a path string.  This is useful for tools that already
> > hold an fd to the image, such as composefs reusing an existing erofs
> > backing file.
> > 
> > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > ---
> > v4: https://lore.kernel.org/linux-fsdevel/20260717134147.1602735-1-gscrivan@redhat.com/
> > v3: https://lore.kernel.org/linux-fsdevel/20260714154917.489993-1-gscrivan@redhat.com/
> > v2: https://lore.kernel.org/linux-fsdevel/20260711071137.4130824-1-gscrivan@redhat.com/
> > v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/
> > 
> >  Documentation/filesystems/erofs.rst | 15 ++++++
> >  fs/erofs/super.c                    | 73 ++++++++++++++++++++++++-----
> >  2 files changed, 77 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> > index 4230884fb359..774e8b236d09 100644
> > --- a/Documentation/filesystems/erofs.rst
> > +++ b/Documentation/filesystems/erofs.rst
> > @@ -139,6 +139,21 @@ inode_share            Enable inode page sharing for this filesystem.  Inodes wi
> >                         page cache.
> >  ===================    =========================================================
> >  
> > +File-backed mounts
> > +==================
> > +
> > +When CONFIG_EROFS_FS_BACKED_BY_FILE is enabled, EROFS file-backed images
> > +can be mounted directly without a loopback block device.  The backing file
> > +can be given either as a path, or as an already-opened file descriptor.
> > +
> > +When a file descriptor is used, the kernel resolves its path and records it
> > +so that /proc/mounts and similar interfaces can still report the mount
> > +source.
> > +
> > +Only regular files are accepted as backing files; to mount an image that
> > +resides on a block device, use the traditional block device mount path
> > +instead.
> 
> Reviewed-by: Gao Xiang <xiang@kernel.org>
> 
> Hi Christian, Jan, could you ack this (`fc->source` filling when
> `source_fd` is used) if possible?

Whenever I see a use of d_path() (or file_path() in this case) I'm a bit
watchful because its result is inherently racy and unsafe. But in this case
the result is only used for alloc_vfsmnt() which uses it for mnt_devname so
in the worst case we'll get an unreliable path in /proc/mounts or similar.
I guess that's acceptable. So feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
