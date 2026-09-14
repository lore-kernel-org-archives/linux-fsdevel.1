Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079640EBB6;
	Mon, 14 Sep 2026 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376015; cv=none; b=cWOW+apMp09nS1mAUWSBlahqglQAr9UzphIc7aGMhCNNBINTpQD1zdAGsiRgEIfRw4tXFun82ZS8TRIBr4I3EAvv/i1CBUY98hBro8JNe2Gc4prculjbgsbQXSF9+VQQUlaODVfogOAdUppXQ7NtOtRnrLgw75S/qPp8cITWdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376015; c=relaxed/simple;
	bh=2/QPqyyGci2C3ahz4RkgnHjD5wDyxAb1g79QR0gXQNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujfo60XT2j3hxNa3EA9b43HoqRigO7VMOzlC7GwljZ4MnGKtQXDHECNajfkc6fLfVhi/Aht/nhKDFcN5V3njrRQWgquNUcewTfxRWuimz2f2oWdfrRbXSiM8jKYkqDVVvnpIzjtZcVXBGota9VVKth5biOy8ZxRgJoZNHXMboPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IN8+8F/R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DFMTfNGM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OFM2Wc2L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M9A/G52L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IN8+8F/R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DFMTfNGM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OFM2Wc2L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M9A/G52L"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D472E21B03;
	Mon, 14 Sep 2026 08:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789375999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fkfs27SEfag3YWNxjnmJi7blS0vIHEFAEl3bfsZExw=;
	b=IN8+8F/Rcy692g8YziViPLkzwLLFsJDWZeKrQlObOLNin3UOPy0LQ1khHfmGqlQRPhqJM/
	7nSFhBBm96FJxhJPWToSxR2I9bDZ8NMHACTTlDwUgm4AJ8rZGL74LyvgJRG7ESZ19sEw65
	LYa3NAkzs0KKaU/BtV2i65Tvn4N/I9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789375999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fkfs27SEfag3YWNxjnmJi7blS0vIHEFAEl3bfsZExw=;
	b=DFMTfNGMtqLBjzSx95f2WPLejkPSgFqATIxLwjCCngnI+NhC+qKoQz/7ZfNYfE3bPZDKIG
	BWoyKBmmN7kvAQDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789375994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fkfs27SEfag3YWNxjnmJi7blS0vIHEFAEl3bfsZExw=;
	b=OFM2Wc2LW/F05zo+8WP3oMBPVpsn4eRK62uRx0Pt+KwmsczdVCH759Oy15iJhe8rj9n+F6
	4hry47T0Ybfu9wQTq+m/Gv3yeP1+ToTbJGhwlP3a39PO/nB413+VnqEhtC9nA3h9Ttj+Xl
	Yt2Nw5ZzLaaoN5GwHGD+3iIpMC10UTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789375994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fkfs27SEfag3YWNxjnmJi7blS0vIHEFAEl3bfsZExw=;
	b=M9A/G52LiKgaciRSQhrLjz0OFI7OcghoIZ614oIexmApg3nfQmT5F9Dbz8o3mIRJprKGS7
	wdld7qqeK34R39CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE6E5136A1;
	Mon, 14 Sep 2026 08:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J1WSKvq1p2qyLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 08:53:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 401F4A12E4; Mon, 14 Sep 2026 10:53:06 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:53:06 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/10] Towards safer path_* API
Message-ID: <pm4tszxmbzodnxbsc3paaaogobweqlgbnleyoeukzs23rdnzr6@caobahbhkrl7>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913144918.1606123-1-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Sun 13-09-26 16:49:07, Mateusz Guzik wrote:
> Currently the handling is highly error-prone with consumers allowed to
> arbitrarily manipulate references, notably with path_get().
> 
> In the past this resulted in preventable bugs.
> 
> The end goal, not yet achieved with this patchset, will provide an
> invariant that a populated 'struct path' has precisely one set of
> references on it.
> 
> While consumers can still cause leaks by neglecting to path_put(), the
> footgun of path_get() can be eliminated.
> 
> With this patchset instead of hand-rolling a path copy and issuing
> path_get() on it, callers can resort to path_clone() instead.
> 
> Almost all path_get() consumers get converted, most of which with
> coccinelle.
> 
> Few instances are left until I figure out a nice way to sort them out.
> 
> Overall almost entirety of this patchset is a NOP.

I like most of the changes. Just the changes to path_init() kind of leave a
bad taste because they leave struct path assignment there for the RCU
lookup mode. But I don't see a nicer way of dealing with it.

								Honza

> 
> Mateusz Guzik (10):
>   fs: unexport backing_file_set_user_path() and make it take the ref on
>     its own
>   fs: add path_create(), path_move() and path_clone()
>   fs: use path_clone() in path_init()
>   fs: use path_clone() and path_move() in vfs_open*
>   fs: use path_clone() in backing_file_set_user_path()
>   Coccinelle-based conversion of path_* consumers to use the new
>     primitives
>   autofs: use path_create()
>   fsnotify: use path_clone()
>   proc: use path_clone()
>   nfsd: use path_clone()
> 
>  drivers/block/loop.c               |  3 +-
>  fs/autofs/dev-ioctl.c              |  3 +-
>  fs/autofs/expire.c                 |  4 +--
>  fs/backing-file.c                  |  2 --
>  fs/devpts/inode.c                  |  6 ++--
>  fs/failfs.c                        |  3 +-
>  fs/fhandle.c                       |  3 +-
>  fs/file_attr.c                     |  6 ++--
>  fs/file_table.c                    |  3 +-
>  fs/fs_struct.c                     |  6 ++--
>  fs/namei.c                         | 44 ++++++++++++++++++++++++------
>  fs/namespace.c                     |  3 +-
>  fs/nfsd/export.c                   |  6 ++--
>  fs/nfsd/nfs4xdr.c                  |  8 +++---
>  fs/notify/fanotify/fanotify.c      |  6 ++--
>  fs/notify/fanotify/fanotify_user.c |  3 +-
>  fs/nsfs.c                          |  3 +-
>  fs/open.c                          | 10 ++-----
>  fs/overlayfs/params.c              |  3 +-
>  fs/pidfs.c                         |  3 +-
>  fs/proc/base.c                     |  6 ++--
>  fs/proc/fd.c                       |  3 +-
>  fs/smb/server/vfs.c                |  3 +-
>  fs/xfs/xfs_handle.c                |  3 +-
>  include/linux/path.h               | 14 ++++++++--
>  kernel/trace/bpf_trace.c           |  3 +-
>  security/apparmor/task.c           |  3 +-
>  security/keys/big_key.c            |  3 +-
>  security/landlock/fs.c             |  3 +-
>  security/landlock/syscalls.c       |  3 +-
>  30 files changed, 87 insertions(+), 85 deletions(-)
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
