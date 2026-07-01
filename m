Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0F31B82B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900558; cv=none; b=eoSNnm11JEt2Rd9QY+LQQkdxYWJQY/d6dBMxNZ4JQe344+trjxsMw+bhmwOXOfMsGTkZQfVFpJy4dh3M20fDWDk1nEjKbNjdYLr2YOq3QpCNT6EzR5riD+qPeorhK8QHMuXi6/N9KYPBYiFPm0OrMU1+F8uJ9DQ1M5cRLd1a88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900558; c=relaxed/simple;
	bh=CaxzkC2Ryrc59KHX86sHpuD7Exie3L5Fca0/dKyuA1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkIQ1nLoDlupL/DJzwERx8xutIUMQJdJLBfnBWNB8hh+C21iDokyd2xwnD2iuyyR8XSg5n47ORMTgvZ6b6gYZvnpxgjL/0G2yC2l2yxHSbGHkQ53e9uUwy3Kaj5iY8yGfhwokAU97YBsYjCoq1kxI6fdp9qeUsjJJywhn9N77kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G+gEOWVg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCT3ixsk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G+gEOWVg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCT3ixsk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G+gEOWVg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCT3ixsk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G+gEOWVg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCT3ixsk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B89B172019;
	Wed,  1 Jul 2026 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cKi5PI0CAmYFVbiwZ7FsE2xOK4uD8zjy0xJjeoQJS2c=;
	b=G+gEOWVgnTgp5IdAseQnh5MhxbPDDnqnh2J0VAqUsF+WVDWAkf54BEDU/9xPYpCB5Im7MU
	+CgRiQMR1CqroIEIAQnc1XBPPonSqPU+9AmESHbzXelwKwBu9yFhFqs5mQs14vQ4lV/Sxy
	aM6UrbsQV60004wREANoXuWidD5W6p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cKi5PI0CAmYFVbiwZ7FsE2xOK4uD8zjy0xJjeoQJS2c=;
	b=yCT3ixskiL8MvJvobXuDF16UaJ1KpLppTVL3fVN+FhYaNK3dBDDuh6l2Swc18R+8OwGe4K
	fdL9Kz85tMKqxtAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cKi5PI0CAmYFVbiwZ7FsE2xOK4uD8zjy0xJjeoQJS2c=;
	b=G+gEOWVgnTgp5IdAseQnh5MhxbPDDnqnh2J0VAqUsF+WVDWAkf54BEDU/9xPYpCB5Im7MU
	+CgRiQMR1CqroIEIAQnc1XBPPonSqPU+9AmESHbzXelwKwBu9yFhFqs5mQs14vQ4lV/Sxy
	aM6UrbsQV60004wREANoXuWidD5W6p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cKi5PI0CAmYFVbiwZ7FsE2xOK4uD8zjy0xJjeoQJS2c=;
	b=yCT3ixskiL8MvJvobXuDF16UaJ1KpLppTVL3fVN+FhYaNK3dBDDuh6l2Swc18R+8OwGe4K
	fdL9Kz85tMKqxtAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95ABB779AA;
	Wed,  1 Jul 2026 10:09:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7RGIJEvnRGqZPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Jul 2026 10:09:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06D15A10B7; Wed, 01 Jul 2026 12:09:15 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:09:15 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/31] ext2: drop redundant S_IFDIR from mkdir
Message-ID: <65lk7g6zs276iqwlofgbxat3uoutzzuxrmhiaqmexync4jdgbv@mozjik23lbuk>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260630105400.68459-9-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105400.68459-9-jkoolstra@xs4all.nl>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,xs4all.nl:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Tue 30-06-26 12:53:37, Jori Koolstra wrote:
> vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
> ->mkdir(), so OR-ing S_IFDIR into the mode again in ext2_mkdir() is
> redundant. Drop it.
> 
> Assisted-by: Claude Opus 4.8 (1M context)
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index 0d09d22fe708..411fd09c3c7e 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -236,7 +236,7 @@ static struct dentry *ext2_mkdir(struct mnt_idmap * idmap,
>  
>  	inode_inc_link_count(dir);
>  
> -	inode = ext2_new_inode(dir, S_IFDIR | mode, &dentry->d_name);
> +	inode = ext2_new_inode(dir, mode, &dentry->d_name);
>  	err = PTR_ERR(inode);
>  	if (IS_ERR(inode))
>  		goto out_dir;
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
