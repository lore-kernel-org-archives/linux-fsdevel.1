Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3AD33F588
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254716; cv=none; b=shrVZGgh8xSlypVP7sRaPTcYctKSLBZL1Jil3j8iUsyMK8a7KofB8aXNGXXDwpNnSZ+81qBp5+NMUk3H8hIC6WGtb9+mfsNS709R8S7kGBCocc6Fr677y2gcg62VAVRfU75Wn8d6dfIMkFzMsYM4pUOa3/9TxZIp9cgZv0tLyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254716; c=relaxed/simple;
	bh=3E9FAtquV+6O+JVfzxx6C/MgIRRHryYmtnWAb1YxWOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pk/g3Wsj1u+EbrnNGKrjWJqbeyd/34u0Ja7fhGuqgcAiMBxeyeGj3GK06PVvTvxulb747COKODmUXk2VTdAxebetolE6HbgUtGhpT41tGIg9lNBuLOymRmxYfWz+ZbNtp18r6HYBdr+zZKbrmhQUi6+CILjGq1b25/PpI6DOkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LsMAFJkK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IsrpBWhB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dhjJdQX2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdk64M4G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LsMAFJkK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsrpBWhB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dhjJdQX2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdk64M4G"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A42817C41C;
	Tue, 28 Jul 2026 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785254708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eVUCV1DppfbR6TXIE0HqqXtnqrgriHXILR6KfVMSog=;
	b=LsMAFJkK8k4MJPAncPy1i9otGGVa4M537ZeLPaa2a39UN0+oDaz+mcu+n5djN+vvgtQRpt
	/LNmozpiigx2IX80AyRVab8jIgseQK9jD/frO1yT45jOLB1qzTKb7w8RmBRvnDcARa/R7s
	HtZTEt2c5Hv0uQeyWzCTEVpETM0UiO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785254708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eVUCV1DppfbR6TXIE0HqqXtnqrgriHXILR6KfVMSog=;
	b=IsrpBWhBEJp3dJXlDHnqdqgjoJ945vktjEWKrJwRqqYI3wYz3a3T8ryf3YKs7D0daC12EC
	KHD5FXkADLXVyCCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785254704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eVUCV1DppfbR6TXIE0HqqXtnqrgriHXILR6KfVMSog=;
	b=dhjJdQX2ulIwzQRIcY6o1DTAziwmqZD1IrckqZ4K2RtY/IIH3hgGNWhemNsP/6np29ZLMg
	vAx6W3bNRIs+5tMBrRB6OA9YcoEoMs7G6y70ZuiyTuWsdqL5FEE4IPu4/O2y1/aEPwA8TJ
	qHlM2kO3rx2diKuMyEElUXXozNenpKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785254704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eVUCV1DppfbR6TXIE0HqqXtnqrgriHXILR6KfVMSog=;
	b=wdk64M4GpgZOC97+sztB59HHSMqEPzJ25JJq/zwFeMr5fySEHAm4o5x2sEW/GirJE5/6On
	SJnGDS+1D4sv3+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FBA6779B1;
	Tue, 28 Jul 2026 16:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ctAUIzDTaGoqcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 Jul 2026 16:05:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5451BA10B6; Tue, 28 Jul 2026 18:05:04 +0200 (CEST)
Date: Tue, 28 Jul 2026 18:05:04 +0200
From: Jan Kara <jack@suse.cz>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isofs: validate directory records consistently
Message-ID: <s2xkosrrjjw4eqdoguitc5xnzlbcxamzw6ylpplolkcs5jixgc@jlpqavo7c23u>
References: <h422u6iqz6faysofnomlcqizkqjrsgqw6ooo4jdhfyjuttkqou@p6frlkumlpmd>
 <20260728074349.417508-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728074349.417508-1-chenyichong@uniontech.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 28-07-26 15:43:49, Yichong Chen wrote:
> isofs_export_get_parent() assumes that the first two directory records
> are valid "." and ".." entries.  A malformed image can provide an
> invalid length for the first entry, causing the computed ".." offset to
> point outside the received block.
> 
> Add a shared directory record validator and use it in NFS get_parent,
> readdir and lookup.  This keeps the basic directory record length checks
> consistent across all directory users before they consume the name field
> or use one record length to find the next entry.
> 
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

Thanks! I've merged this patch to my tree.

								Honza

> ---
> v2:
> - Move the directory record validator to namei.c.
> - Share the validator with NFS get_parent, readdir and lookup.
> - Replace duplicate directory record length checks.
> 
>  fs/isofs/dir.c    |  7 ++-----
>  fs/isofs/export.c | 10 +++++++++-
>  fs/isofs/isofs.h  |  3 +++
>  fs/isofs/namei.c  | 28 ++++++++++++++++++++++++----
>  4 files changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index cc587cd25162..a96268c9ca41 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -149,10 +149,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
>  			}
>  			de = tmpde;
>  		}
> -		/* Basic sanity check, whether name doesn't exceed dir entry */
> -		if (de_len < sizeof(struct iso_directory_record) ||
> -		    de_len < de->name_len[0] +
> -					sizeof(struct iso_directory_record)) {
> +		if (!isofs_dir_record_valid(de, de == tmpde ? 0 : offset_saved,
> +					    de == tmpde ? de_len : bufsize)) {
>  			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
>  			       " in block %lu of inode %llu\n", block,
>  			       inode->i_ino);
> @@ -300,4 +298,3 @@ const struct inode_operations isofs_dir_inode_operations =
>  	.fileattr_get = isofs_fileattr_get,
>  };
>  
> -
> diff --git a/fs/isofs/export.c b/fs/isofs/export.c
> index 78f80c1a5c54..4f7fa1d508a1 100644
> --- a/fs/isofs/export.c
> +++ b/fs/isofs/export.c
> @@ -83,13 +83,21 @@ static struct dentry *isofs_export_get_parent(struct dentry *child)
>  
>  	/* This is the "." entry. */
>  	de = (struct iso_directory_record*)bh->b_data;
> +	if (!isofs_dir_record_valid(de, 0, child_inode->i_sb->s_blocksize) ||
> +	    isonum_711(de->name_len) != 1 || de->name[0] != 0) {
> +		printk(KERN_ERR "isofs: Unable to find the \".\" directory for NFS.\n");
> +		rv = ERR_PTR(-EACCES);
> +		goto out;
> +	}
>  
>  	/* The ".." entry is always the second entry. */
>  	parent_offset = (unsigned long)isonum_711(de->length);
>  	de = (struct iso_directory_record*)(bh->b_data + parent_offset);
>  
>  	/* Verify it is in fact the ".." entry. */
> -	if ((isonum_711(de->name_len) != 1) || (de->name[0] != 1)) {
> +	if (!isofs_dir_record_valid(de, parent_offset,
> +				    child_inode->i_sb->s_blocksize) ||
> +	    isonum_711(de->name_len) != 1 || de->name[0] != 1) {
>  		printk(KERN_ERR "isofs: Unable to find the \"..\" "
>  		       "directory for NFS.\n");
>  		rv = ERR_PTR(-EACCES);
> diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
> index 0ec8b24a42ed..dacb9cdae4fd 100644
> --- a/fs/isofs/isofs.h
> +++ b/fs/isofs/isofs.h
> @@ -115,6 +115,9 @@ struct inode;		/* To make gcc happy */
>  extern int parse_rock_ridge_inode(struct iso_directory_record *, struct inode *, int relocated);
>  extern int get_rock_ridge_filename(struct iso_directory_record *, char *, struct inode *);
>  extern int isofs_name_translate(struct iso_directory_record *, char *, struct inode *);
> +bool isofs_dir_record_valid(struct iso_directory_record *de,
> +			    unsigned long offset,
> +			    unsigned long bufsize);
>  
>  int get_joliet_filename(struct iso_directory_record *, unsigned char *, struct inode *);
>  int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
> diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
> index 3ace3d6a55e7..a161b28893d6 100644
> --- a/fs/isofs/namei.c
> +++ b/fs/isofs/namei.c
> @@ -10,6 +10,26 @@
>  #include <linux/gfp.h>
>  #include "isofs.h"
>  
> +bool isofs_dir_record_valid(struct iso_directory_record *de,
> +			    unsigned long offset,
> +			    unsigned long bufsize)
> +{
> +	unsigned int len;
> +	unsigned int name_len;
> +	unsigned long min_len = offsetof(struct iso_directory_record, name);
> +
> +	if (offset > bufsize || bufsize - offset < min_len)
> +		return false;
> +
> +	len = isonum_711(de->length);
> +	name_len = isonum_711(de->name_len);
> +	if (len < min_len || name_len > len - min_len)
> +		return false;
> +	if (len > bufsize - offset)
> +		return false;
> +	return true;
> +}
> +
>  static int
>  isofs_cmp(struct dentry *dentry, const char *compare, int dlen)
>  {
> @@ -88,16 +108,16 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
>  			de = tmpde;
>  		}
>  
> -		dlen = de->name_len[0];
> -		dpnt = de->name;
> -		/* Basic sanity check, whether name doesn't exceed dir entry */
> -		if (de_len < dlen + sizeof(struct iso_directory_record)) {
> +		if (!isofs_dir_record_valid(de, de == tmpde ? 0 : offset_saved,
> +					    de == tmpde ? de_len : bufsize)) {
>  			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
>  			       " in block %lu of inode %llu\n", block,
>  			       dir->i_ino);
>  			brelse(bh);
>  			return 0;
>  		}
> +		dlen = de->name_len[0];
> +		dpnt = de->name;
>  
>  		if (sbi->s_rock &&
>  		    ((i = get_rock_ridge_filename(de, tmpname, dir)))) {
> -- 
> 2.51.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
