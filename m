Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E3285041
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439564; cv=none; b=L+icA8SqePq7KMe1mlJwXUWTxYKVHKMtgfcLJK0K0doVAwCskZuHUH422lSRCbs+qC9ZK4gBFkExHZfLPxNwLu3TiO97O9gHtJQAqxzXG+97cFchpTcBhJ6XPExnGK8zQm/CnM/5nhwZWPmIaji7clYfTHTqkziWLILiLayIxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439564; c=relaxed/simple;
	bh=d+yma0A/YjHQBZ+BhgAG0N5SGX6UDJh9Y4UZARPKxNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWqaogdPvEx82sauDzNMNn/YytOngM7M9Kt9jz227RlpnrENhLs9U/PdzqkbK7iovceTX3bHWSwRFZq++Xi8tm0/AC/uL2e0sNEOozV2SBgEQeslGOcasiRyb9eNkIsQ0J681KCaWbWGUI2Q95llM2lkcVYMfSZakPs7s5jgmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HSrIsErA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7IK+P0br; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HSrIsErA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7IK+P0br; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HSrIsErA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7IK+P0br";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HSrIsErA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7IK+P0br"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5485E4D1D1;
	Wed, 25 Mar 2026 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774439561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDmP/Qyhk3ifA1CcOmUfkNeKjvCG2N8NovWHPmwTEvM=;
	b=HSrIsErAlcc0UkHO3c1Y/QrrxFWxlRoJUHgEH4z5NLaknufEVbOh4CBbAyFKBnxn5/Xs+M
	wsXIeV7YEOgrRCmJnG+pMo/B4mjCotaaRPv21gDRESsQFnMcQTwBlGFuBiLZgcL4JDpaf5
	VjsLxuclNwEPPs137h1JFhVdr4cVZvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774439561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDmP/Qyhk3ifA1CcOmUfkNeKjvCG2N8NovWHPmwTEvM=;
	b=7IK+P0br9nQgPbN2TLmsgIOLm5Jv+g8RB3b7Q1+nKtIsFjm4BgiBl00F8re2TWeRmBqyjd
	GqdlBiGib/pWkcBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774439561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDmP/Qyhk3ifA1CcOmUfkNeKjvCG2N8NovWHPmwTEvM=;
	b=HSrIsErAlcc0UkHO3c1Y/QrrxFWxlRoJUHgEH4z5NLaknufEVbOh4CBbAyFKBnxn5/Xs+M
	wsXIeV7YEOgrRCmJnG+pMo/B4mjCotaaRPv21gDRESsQFnMcQTwBlGFuBiLZgcL4JDpaf5
	VjsLxuclNwEPPs137h1JFhVdr4cVZvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774439561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDmP/Qyhk3ifA1CcOmUfkNeKjvCG2N8NovWHPmwTEvM=;
	b=7IK+P0br9nQgPbN2TLmsgIOLm5Jv+g8RB3b7Q1+nKtIsFjm4BgiBl00F8re2TWeRmBqyjd
	GqdlBiGib/pWkcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 484A4443AC;
	Wed, 25 Mar 2026 11:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BH6fEYnMw2n/IwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Mar 2026 11:52:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03EFCA0B32; Wed, 25 Mar 2026 12:52:36 +0100 (CET)
Date: Wed, 25 Mar 2026 12:52:36 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] hfs: update comments on hfs_inode_setattr
Message-ID: <x55spdwyhlsqy5aybokpy6ffmsv2jpyp5kypshv4vt4c3y7tlm@76qv5tqlsibs>
References: <20260325063711.3298685-1-hch@lst.de>
 <20260325063711.3298685-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325063711.3298685-2-hch@lst.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,lst.de:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 25-03-26 07:36:48, Christoph Hellwig wrote:
> The top of function comment about hfs_inode_setattr is severely out
> of date and reference a previous name for this function.  Remove it,
> and update the comments in the file to record the still relevant bits
> directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I agree the comments seem really outdated. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/hfs/inode.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 878535db64d6..72948eb2fadc 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -622,23 +622,6 @@ static int hfs_file_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> -/*
> - * hfs_notify_change()
> - *
> - * Based very closely on fs/msdos/inode.c by Werner Almesberger
> - *
> - * This is the notify_change() field in the super_operations structure
> - * for HFS file systems.  The purpose is to take that changes made to
> - * an inode and apply then in a filesystem-dependent manner.  In this
> - * case the process has a few of tasks to do:
> - *  1) prevent changes to the i_uid and i_gid fields.
> - *  2) map file permissions to the closest allowable permissions
> - *  3) Since multiple Linux files can share the same on-disk inode under
> - *     HFS (for instance the data and resource forks of a file) a change
> - *     to permissions must be applied to all other in-core inodes which
> - *     correspond to the same HFS file.
> - */
> -
>  int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		      struct iattr *attr)
>  {
> @@ -646,8 +629,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
>  	int error;
>  
> -	error = setattr_prepare(&nop_mnt_idmap, dentry,
> -				attr); /* basic permission checks */
> +	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
>  	if (error)
>  		return error;
>  
> @@ -663,6 +645,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		return hsb->s_quiet ? 0 : error;
>  	}
>  
> +	/* map file permissions to the closest allowable permissions in HFS */
>  	if (attr->ia_valid & ATTR_MODE) {
>  		/* Only the 'w' bits can ever change and only all together. */
>  		if (attr->ia_mode & S_IWUSR)
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
