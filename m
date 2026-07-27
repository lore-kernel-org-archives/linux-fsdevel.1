Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2A41D62C
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163634; cv=none; b=a4Siz+Y3QhLjP2PtDGW4wQhWdrSoHuDG13XzWU6OrweDrCnPIDbuZuZfSl8EYfae6b5nEuKJtQFKcYbMZJZTKkfcZPCaljqOjy5TaBhnTyr462Hl9SSXQT4aX5Mvdtib40p6/gEC0II6Fsoc6AEA9UcLdboPJhSyV2IkTk8NeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163634; c=relaxed/simple;
	bh=muPX7iuRvJbzKVBJEnGeSScT947qOmkM19xfGrWzKHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZffgTrHm8enrYsAb/9GJ5UNMUsQBteauNDxKBX0aCQNw/23n32+ggbUFCKDu44rdJDO+CdBqWXvzWEfgi+yNN3EsbVA9YuTueq14P/RkCHLc0tRnAJMb4tpSN4vkAYqdQ7qGvlimT5y5nz5x66tMGuvstAIzEP4tjB44eD0VzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mbMI9lhK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5JkuAZea; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ulNUzruO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JYY/xZq2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mbMI9lhK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5JkuAZea";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ulNUzruO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JYY/xZq2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C67777B7AE;
	Mon, 27 Jul 2026 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785163625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bmeje1d76LhZOkvFJIAbMG6Yy/XYcyJxHSnHhJv9R80=;
	b=mbMI9lhKVkAT/kf+JZkT1WY3ihtKgC5SLatp+Glt+wGkagmxEEsmtOEtt4FMBbURML0vSa
	csbMsaRjLoIBVPAG6ohyVSbUImXOLnFJfDNbJ3PBE+1o0639PLXELkydhkCZxRHw1AbWRw
	aBayrDfNPOvI0vPJZFAMJT/666K3O3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785163625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bmeje1d76LhZOkvFJIAbMG6Yy/XYcyJxHSnHhJv9R80=;
	b=5JkuAZeatsJOIvr1g4SjpaS4gWz4xRqhosYIyiPfl4Wc6P/Vix7BsG/tZ7Ly5h0iqGaXb/
	oTVVksJY/7CHRkCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ulNUzruO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="JYY/xZq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785163621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bmeje1d76LhZOkvFJIAbMG6Yy/XYcyJxHSnHhJv9R80=;
	b=ulNUzruOckbNKaiYPunPv3yxSDceb5azkTFCwlnEOgnNPaZ9Bu9bRiAh8A7XTvBz1ile/v
	L1H7KIFhYuGyGcgl1AR465the/+OavAcWUxsyT8y13R7GBpN4OA8sjQVWpPh4jeh4RZOTK
	KxGEOrkc1OoH+uTgss+An2bKV9hzTXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785163621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bmeje1d76LhZOkvFJIAbMG6Yy/XYcyJxHSnHhJv9R80=;
	b=JYY/xZq2OBu0FTp3nHxsrgmhRft5XcyozwKGl6EdL4csmmL22uIWyEn8apeDE4bBKMnV3v
	aenD4cJiM0kCPVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD97F779B9;
	Mon, 27 Jul 2026 14:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ry2cLWVvZ2ojVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Jul 2026 14:47:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5C8ACA0BA1; Mon, 27 Jul 2026 16:46:53 +0200 (CEST)
Date: Mon, 27 Jul 2026 16:46:53 +0200
From: Jan Kara <jack@suse.cz>
To: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs: make file_listxattr and file_removexattr
 helpers non-static
Message-ID: <dyyz25zraphwgpgyrfes7uunepxcsswok4z3qpnggivd3bjjzk@l3nwvj4utuib>
References: <20260721103514.2716-1-aditya.ansh182@gmail.com>
 <20260721103514.2716-2-aditya.ansh182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721103514.2716-2-aditya.ansh182@gmail.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: C67777B7AE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Tue 21-07-26 10:35:13, Aditya Prakash Srivastava wrote:
> In preparation for adding IORING_OP_FREMOVEXATTR and
> IORING_OP_FLISTXATTR support in io_uring, we need to invoke the VFS-layer
> helpers from within io_uring.
> 
> Make the following helpers non-static and declare them in fs/internal.h:
> - file_listxattr()
> - file_removexattr()
> 
> No functional change is introduced.
> 
> Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>

Looks ok to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/internal.h | 2 ++
>  fs/xattr.c    | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 355d93f92208..ee86b24db79a 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -297,6 +297,8 @@ int filename_setxattr(int dfd, struct filename *filename,
>  		      unsigned int lookup_flags, struct kernel_xattr_ctx *ctx);
>  int setxattr_copy(const char __user *name, struct kernel_xattr_ctx *ctx);
>  int import_xattr_name(struct xattr_name *kname, const char __user *name);
> +ssize_t file_listxattr(struct file *f, char __user *list, size_t size);
> +int file_removexattr(struct file *f, struct xattr_name *kname);
>  
>  int may_write_xattr(struct mnt_idmap *idmap, struct inode *inode);
>  
> diff --git a/fs/xattr.c b/fs/xattr.c
> index d58979115200..31b8a5eeec1e 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -953,7 +953,6 @@ listxattr(struct dentry *d, char __user *list, size_t size)
>  	return error;
>  }
>  
> -static
>  ssize_t file_listxattr(struct file *f, char __user *list, size_t size)
>  {
>  	audit_file(f);
> @@ -1036,7 +1035,7 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d, const char *name)
>  	return vfs_removexattr(idmap, d, name);
>  }
>  
> -static int file_removexattr(struct file *f, struct xattr_name *kname)
> +int file_removexattr(struct file *f, struct xattr_name *kname)
>  {
>  	int error = mnt_want_write_file(f);
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
