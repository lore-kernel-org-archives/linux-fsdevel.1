Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508866;
	b=qVwEo7tvciiypbUgzklBT2AZt0e94wg6VKPp/cNWz73X0Z+V7pJZkBf5kgkS2dqUIEoh
	 Bc0f+Ov0rnUNui/68y8aCIEe1PTPglZjUdJmTzZDW2uQvUmIwKXGehZRk1EPQG92mZn2R
	 mNadKSXU0HErK2pTZfHiRONO1kzb4hdiy8CcPrWumboWOPath6Xdzw8+ahphnJkw/2DWd
	 PXA9b0VbJXToR2yLeAqWuAtFo5Vr1slmaDkhEXhRTBjodRxkY8f841awEqL6GKEhN8hsb
	 TrY3kdUMa4GwPrUvxOryDvBONjdbBIv19VRleycZcndnie3OLsJsNC5t2ZAvOhc4d+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508866;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=znMZ7NR6/YszQuPkJzBKuINXsXo8b7XNMf7NgTqswQM=;
	b=jsVJWVOFPNT+xfCXWOcxfUmCbQ6RRHp3zl2vdIXLjZbWu+vZN4CvJCJCI+czSqG3w976
	 BXK3tLw85Wfgo4rSGdEh4CsvINRei/Zq1CqlYEAo0p+NiWxP+eONmyNjnwcVkU4tOPhHm
	 tbA9qDmr22VQbYXW2UyKRKqY5GH6h9Z+etfIDYe6RhU+LKS3qSXHYXZGe2qyCkDuPUFu1
	 LGcZWLTZJpMQwzVX8PAyTcAcSCfdkSMRlXb3kzUp/xi1swOChOIhfb5/EJdfXy1SvfvZu
	 XVd8XIAobVC8KhUpCgwo6Vv9WV7i+3XogSQcuC56PH6txPY/OVbhJAosH/6Co3I9hzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Xer+SKnf;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="ABAXOl/I";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=n2Uq6tBL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/IYPJ4AW";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D807606A31C;
	Thu, 12 Nov 2026 18:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D807606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Xer+SKnf;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ABAXOl/I;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=n2Uq6tBL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/IYPJ4AW
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16EE321F6F;
	Thu, 12 Nov 2026 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794508864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znMZ7NR6/YszQuPkJzBKuINXsXo8b7XNMf7NgTqswQM=;
	b=Xer+SKnfXtKA0r2HBJMEwYrkKmiTMQlvHLYwnj7DWg7E639+BPuNRUj6xja+KuuiDKEtiQ
	iRVToRsEy0XZ1+nbrIGT/DkfxtRvAZXEGferZBlSCjI/kAtbHwYICgjvD6d8+NrHogs8T7
	6To5ZO3HSUP7ONT/pGVd0g5Sm02LDQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794508864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znMZ7NR6/YszQuPkJzBKuINXsXo8b7XNMf7NgTqswQM=;
	b=ABAXOl/IBFMv8A6QcWIqId6viw0hK4qpYIOTYUS8OFeUKJw694QzNLqBGaoYfv1zHWK2Zh
	hFYccdVV/wxWFGDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n2Uq6tBL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/IYPJ4AW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794508862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znMZ7NR6/YszQuPkJzBKuINXsXo8b7XNMf7NgTqswQM=;
	b=n2Uq6tBLVztNF4B/wsNj0QDn8VmW/gpUgKe56S+ix8oOenI3lvIfQtsgN7pALFLOUOGfUY
	DXFG+rvwCr/1DbtiLNl/USvtb/oIfi/M+5pCZNRa+QLiWGs3hk509kr6dYTzW6RvG7S4Ml
	L0bW0y6ViRwxSQtJbHYZaGZcnKoFahw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794508862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znMZ7NR6/YszQuPkJzBKuINXsXo8b7XNMf7NgTqswQM=;
	b=/IYPJ4AWbcndQSjG1CUMvpOXlmc0P4EgiEOWcieSTerKH3MlaTda6rEmL9pQk3RDY/Pmyv
	Zhq4z3ZWPft5GWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD25413432;
	Thu, 12 Nov 2026 18:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Ub7KT0I9mrURwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Nov 2026 18:41:01 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 3ABCE22B88; Thu, 12 Nov 2026 19:40:53 +0100 (CET)
Date: Thu, 12 Nov 2026 19:40:53 +0100
From: Jan Kara <jack@suse.cz>
To: mohamedalibouhaouala@gmail.com
Cc: willy@infradead.org, jack@suse.cz, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: filesystems: update VFS locking documentation
Message-ID: <3aaboixwh6lpo4s67dv7lssqj2vwlp4qp5cq2ysimqi36r3bm2@fb5lmoo33ktf>
References: <20261111160516.30458-1-mohamedalibouhaouala@gmail.com>
 <20261112162129.77610-1-mohamedalibouhaouala@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112162129.77610-1-mohamedalibouhaouala@gmail.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 16EE321F6F

On Thu 12-11-26 17:21:29, mohamedalibouhaouala@gmail.com wrote:
> From: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
> 
> Update outdated VFS operation prototypes in locking.rst to
> match their current definitions.
> 
> Add the missing d_prune and sync_inode_metadata callbacks,
> and correct the signatures of existing operations.
> 
> Update the locking table to include sync_inode_metadata.
> 
> Signed-off-by: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2:
> - Use the contributor's full name in the author and sign-off fields.
>  Documentation/filesystems/locking.rst | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index f7363ad770c7..a6a011858ada 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -26,6 +26,7 @@ prototypes::
>  	int (*d_delete)(struct dentry *);
>  	int (*d_init)(struct dentry *);
>  	void (*d_release)(struct dentry *);
> +	void (*d_prune)(struct dentry *);
>  	void (*d_iput)(struct dentry *, struct inode *);
>  	char *(*d_dname)(struct dentry *dentry, char *buffer, int buflen);
>  	struct vfsmount *(*d_automount)(struct path *path);
> @@ -80,8 +81,8 @@ prototypes::
>  	int (*getattr) (const struct mnt_idmap *, const struct path *, struct kstat *, u32, unsigned int);
>  	ssize_t (*listxattr) (struct dentry *, char *, size_t);
>  	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start, u64 len);
> -	void (*update_time)(struct inode *inode, enum fs_update_time type,
> -			    int flags);
> +	int (*update_time)(struct inode *inode, enum fs_update_time type,
> +			    unsigned int flags);
>  	void (*sync_lazytime)(struct inode *inode);
>  	int (*atomic_open)(struct inode *, struct dentry *,
>  				struct file *, unsigned open_flag,
> @@ -173,6 +174,7 @@ prototypes::
>  	void (*destroy_inode)(struct inode *);
>  	void (*dirty_inode) (struct inode *, int flags);
>  	int (*write_inode) (struct inode *, struct writeback_control *wbc);
> +	int (*sync_inode_metadata)(struct inode *inode, struct writeback_control *wbc);
>  	int (*drop_inode) (struct inode *);
>  	void (*evict_inode) (struct inode *);
>  	void (*put_super) (struct super_block *);
> @@ -196,6 +198,7 @@ free_inode:				called from RCU callback
>  destroy_inode:
>  dirty_inode:
>  write_inode:
> +sync_inode_metadata:
>  drop_inode:				!!!inode->i_lock!!!
>  evict_inode:
>  put_super:		write
> @@ -255,7 +258,7 @@ prototypes::
>  				loff_t pos, unsigned len, unsigned copied,
>  				struct folio *folio, void *fsdata);
>  	sector_t (*bmap)(struct address_space *, sector_t);
> -	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
> +	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
>  	bool (*release_folio)(struct folio *, gfp_t);
>  	void (*free_folio)(struct folio *);
>  	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
> @@ -265,7 +268,7 @@ prototypes::
>  	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count);
>  	int (*error_remove_folio)(struct address_space *, struct folio *);
>  	int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
> -	int (*swap_deactivate)(struct file *);
> +	void (*swap_deactivate)(struct file *);
>  
>  locking rules:
>  	All except dirty_folio and free_folio may block
> @@ -455,14 +458,15 @@ prototypes::
>  	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
>  	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
>  	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
> -	int (*iopoll) (struct kiocb *kiocb, bool spin);
> +	int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *,
> +			unsigned int flags);
>  	int (*iterate_shared) (struct file *, struct dir_context *);
>  	__poll_t (*poll) (struct file *, struct poll_table_struct *);
>  	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
>  	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
>  	int (*mmap) (struct file *, struct vm_area_struct *);
>  	int (*open) (struct inode *, struct file *);
> -	int (*flush) (struct file *);
> +	int (*flush) (struct file *, fl_owner_t id);
>  	int (*release) (struct inode *, struct file *);
>  	int (*fsync) (struct file *, loff_t start, loff_t end, int datasync);
>  	int (*fasync) (int, struct file *, int);
> @@ -475,7 +479,7 @@ prototypes::
>  			size_t, unsigned int);
>  	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *,
>  			size_t, unsigned int);
> -	int (*setlease)(struct file *, long, struct file_lock **, void **);
> +	int (*setlease)(struct file *, int, struct file_lease **, void **);
>  	long (*fallocate)(struct file *, int, loff_t, loff_t);
>  	void (*show_fdinfo)(struct seq_file *m, struct file *f);
>  	unsigned (*mmap_capabilities)(struct file *);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
