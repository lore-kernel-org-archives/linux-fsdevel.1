Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C282F90C9
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751309; cv=none; b=KxKx3piHzcLIFpMRXBRvB/08eEiOozxbuTKyQsrrPWGqHleaWfs4ViCT/kDakG4oxOfQ84/DKF0V6G6SXy2ePH/BObdZ4AwbVuyQMJadNHR5EC3/l0eOEvZY4cd85uB8kHGlaAgR+uzBaDAUBlg+mbyqRagKS4hZ03Zn7O1rXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751309; c=relaxed/simple;
	bh=UW5AhAZhoH85etcXTz2LKT5ghBA53GtHpamgxCu7n40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCjNU/b+nbwZh2ucjmxDKjqKEIgDj55Qb/oEI8KuHqhfExP3Arivo6INolccD3cC+75j20GHC1eG8OidywScKTSGQ9P4tbyHVq6dE4ijFY9d7QX2VgJlsr9/ap7Ehfu9/b2vHFaOpkNLPCWvxgIPl9azfAq2XiA1bnCQ03ZNh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=toY1cCKV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJajMJ5y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xhjY7GI2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGCEI498; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="toY1cCKV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJajMJ5y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xhjY7GI2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGCEI498"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD7907EF96;
	Mon,  3 Aug 2026 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785751302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgO6jz3qjS+T2v+veVw/DUPKZy2RtUhPxcfTHBVps/0=;
	b=toY1cCKVdV+Oz5BIcQLz1xfKtAbqG4RxWg2ntfhNHhPnioOKWAVXzWONKUV6WoFmUggvlc
	cPi94AskSnodC2XLe+cygWfwDr1r69VbAsJ/6OyoZaXB9IH68n71wD1osXH2VvDYvRB/F5
	fH7L7g+RwNepq2UW+ZTomce3rjiobM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785751302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgO6jz3qjS+T2v+veVw/DUPKZy2RtUhPxcfTHBVps/0=;
	b=PJajMJ5yUOLdpG23Kep65NgXAcYoLOByB5cTnwgzlCM1bQDeBLGJV943wx5T8pz+aelJLo
	4RZpcQQ8ep4zg4Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785751297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgO6jz3qjS+T2v+veVw/DUPKZy2RtUhPxcfTHBVps/0=;
	b=xhjY7GI2QS8orS5e8OGEOHCSBMD6lq0wxeE+7bIImQfGtNb222qc/YxhnlKX6qlUKboTbW
	OaLhva4Clib7apYLXkCNBJ3aZ/mgPTAkYds7h9CO0WyYpakx0kBWebIUqLsOxgSZGcV+Ub
	JR58U+EJlYlZRBM9/HguafHa7e/bs+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785751297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgO6jz3qjS+T2v+veVw/DUPKZy2RtUhPxcfTHBVps/0=;
	b=fGCEI498vZVLzDUuPnSAEoO6L/Mwk85CJYf05pyvb31QdDL3QgVWXR5Po2bDk4lwvcTPB+
	KKpjhngRiBJjQkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5596779A1;
	Mon,  3 Aug 2026 10:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DOYPNAFncGoBOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Aug 2026 10:01:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A748A13A4; Mon, 03 Aug 2026 12:01:29 +0200 (CEST)
Date: Mon, 3 Aug 2026 12:01:29 +0200
From: Jan Kara <jack@suse.cz>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs: do not treat unreadable directory blocks as empty
Message-ID: <jub6jswxsoov3ytgo2ga4m7pa7yjraltf7vznyvc4pmfzeuexh@vstvw6p7whsl>
References: <20260801013942.279992-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801013942.279992-1-ali@iusegentoo.com>
X-Spam-Score: 3.70
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Result: default: False [3.70 / 50.00];
	URIBL_BLACK(7.50)[iusegentoo.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iusegentoo.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]

On Sat 01-08-26 04:39:32, Ali Ahmet Memis wrote:
> ufs_empty_dir() scans every directory block to decide whether a
> directory is empty before rmdir() removes it. When ufs_get_folio()
> cannot read or validate a block it returns an error pointer, and the
> loop currently skips that block with continue and keeps scanning the
> remaining blocks.
> 
> If none of the readable blocks hold an entry, the function returns 1
> and the caller unlinks the directory. A directory whose contents live
> in a block that cannot be read, for example because of an I/O error or
> corrupted directory metadata, is therefore seen as empty and removed,
> losing the entries it still holds.
> 
> Follow the ext2 behaviour and treat an unreadable block as a reason to
> consider the directory not empty, so rmdir() fails instead of
> discarding data that could not be verified.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>

Fair. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ufs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index e62fe5667..ce43cf20b 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -590,7 +590,7 @@ int ufs_empty_dir(struct inode * inode)
>  
>  		kaddr = ufs_get_folio(inode, i, &folio);
>  		if (IS_ERR(kaddr))
> -			continue;
> +			return 0;
>  
>  		de = (struct ufs_dir_entry *)kaddr;
>  		kaddr += ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
