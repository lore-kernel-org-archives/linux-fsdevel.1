Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A235C183
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530182; cv=none; b=guFluZ42TpBDkrhJgeUoaNnG5Q3fkD1ygVMB2GKqDEsJoENbnVc3FkxUgdtNBp6X7RnEmNgtRCIcpP5ctTRobBZsJ3yjUbbEZCe/maHCGehXDeUJfbnYn8Nb/Buym0G1aB1PUH/20vjd6AlIGPsgU45CpPsVmPxIDc2jnGoWMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530182; c=relaxed/simple;
	bh=Z5WEcTbnw8dJFQALBDyGdbb8qPes1CMPzIDC3IEn7EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmXi5AQbuJpiDUf8Gayx1CTLYuAyGojFfMnZzkHhCKHyh1Nm8QY232wg9bdHDjgxNAgirmFDj6bS5VnxbJg+BDYsd/oz1Sk3kOFm3VR1GSopU/PtVusEMp5jv8Btu0NMzVN0sCOT+nIgZfAIoju7e4W/+5+rFTn5kkUG1iyTQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=naDyi8Lp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WaLzVvls; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=naDyi8Lp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WaLzVvls; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="naDyi8Lp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WaLzVvls";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="naDyi8Lp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WaLzVvls"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC2346BE34;
	Mon, 15 Jun 2026 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781530178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AKzzaIUk6q+RoR55mBvAuMO81At1sdvUsJ55ZSemqt0=;
	b=naDyi8LpBkykzyfrTm+hvF0VoKuM30HcDkj0sDTYAOnSu43vXbva7H0LXFdf1v3WS4ICue
	1nLquzqMyVqsH33wDGIlOr2tMAWc+9bU/kOEb179/GYeAHA94J7KLqHEhIuuOFghuuAtNl
	QSq++4xdfE32Tfe9VG5N+yMU1oHyQ9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781530178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AKzzaIUk6q+RoR55mBvAuMO81At1sdvUsJ55ZSemqt0=;
	b=WaLzVvlseN/TyIFDfxKdtsJCJYMlSiKn/MXGUMQwoeoME6s2X8i/qbFdLULSgjbwgzY/4K
	Mx3UXWUd2Y/JGiAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=naDyi8Lp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WaLzVvls
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781530178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AKzzaIUk6q+RoR55mBvAuMO81At1sdvUsJ55ZSemqt0=;
	b=naDyi8LpBkykzyfrTm+hvF0VoKuM30HcDkj0sDTYAOnSu43vXbva7H0LXFdf1v3WS4ICue
	1nLquzqMyVqsH33wDGIlOr2tMAWc+9bU/kOEb179/GYeAHA94J7KLqHEhIuuOFghuuAtNl
	QSq++4xdfE32Tfe9VG5N+yMU1oHyQ9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781530178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AKzzaIUk6q+RoR55mBvAuMO81At1sdvUsJ55ZSemqt0=;
	b=WaLzVvlseN/TyIFDfxKdtsJCJYMlSiKn/MXGUMQwoeoME6s2X8i/qbFdLULSgjbwgzY/4K
	Mx3UXWUd2Y/JGiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2235779AC;
	Mon, 15 Jun 2026 13:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id si94K0L+L2rYMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jun 2026 13:29:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B4E0A12D2; Mon, 15 Jun 2026 15:29:38 +0200 (CEST)
Date: Mon, 15 Jun 2026 15:29:38 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fs: refuse O_TMPFILE creation with an unmapped fsuid
 or fsgid
Message-ID: <mql62afhd3dsdz3xguzqvuukye3oyz42yhcbkwb544xtg5sn5i@vstfaw4irqlt>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
 <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BC2346BE34
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
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
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon 15-06-26 14:52:18, Christian Brauner wrote:
> vfs_tmpfile() never checked that the caller's fsuid and fsgid map into
> the filesystem.  On an idmapped mount whose idmapping does not cover the
> caller's fs{u,g}id, the ->tmpfile() instance initializes the new inode
> through inode_init_owner(), where mapped_fsuid()/mapped_fsgid() return
> INVALID_UID/INVALID_GID, and the tmpfile ends up owned by (uid_t)-1.
> 
> Every other creation path already refuses this: may_o_create() (O_CREAT)
> and may_create_dentry() (mkdir, mknod, symlink, link) bail out with
> -EOVERFLOW via fsuidgid_has_mapping() precisely so that an object cannot
> be created with an owner the filesystem cannot represent.  An O_TMPFILE
> is no exception: it is created I_LINKABLE and linkat(2) can splice it
> into the namespace afterwards, so the same guarantee must hold.
> 
> Add the missing fsuidgid_has_mapping() check to vfs_tmpfile().  On a
> non-idmapped mount the caller's fs{u,g}id always map in the superblock's
> user namespace, so this is a no-op there and only takes effect on an
> idmapped mount that does not map the caller.  It applies to every
> filesystem that sets FS_ALLOW_IDMAP and implements ->tmpfile() (tmpfs,
> ext4, btrfs, xfs, f2fs, ...), and to overlayfs, whose upper-layer
> tmpfile creation funnels through vfs_tmpfile() via backing_tmpfile_open().
> 
> Fixes: 8e5389132ab4 ("fs: introduce fsuidgid_has_mapping() helper")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..c11fdd196b41 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4735,6 +4735,10 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
>  	int error;
>  	int open_flag = file->f_flags;
>  
> +	/* A tmpfile is I_LINKABLE, so guard its owner like may_o_create(). */
> +	if (!fsuidgid_has_mapping(dir->i_sb, idmap))
> +		return -EOVERFLOW;
> +
>  	/* we want directory to be writable */
>  	error = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
>  	if (error)
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
