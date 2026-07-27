Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC03372663
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165785; cv=none; b=Ho8D2/bsurFeGi5JX9glzXjf5jU2WpVYtQD/szxeu6aDjzI9/SLTbJSJo06PxQD3Dyp4zty6Ng8BX3mhaSS6Ms9TTZPcitj98V5GCKLjJRGDGzFLayiWJIzqDWk5eg/kJMdpXqoqFGa2/ev6yUTMU/K3lXLwIBZbx7d0hyBnJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165785; c=relaxed/simple;
	bh=tZuxlVkcw2bTg8UDsl0YoMCu4AwKBaK17YXFXxiSxS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id2iOtmj1Y9SRnzbmH1TmZ3g40OpywCW/1UWVs6threwIvgahiAs7AOlA7S0T7UGNr8fgSfj5Kd4tDCjWivQPO0So+gNwSHGSQjkVkOwKKpGk1E/u5B+nzaMdl1VJ6ckPn9DWtX7gDIsdyxfcepgUYgm+beOkjX2m6p7xuzu5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tr+KKJm2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fM8tYPnO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cmxI0rqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JwyG7GwZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tr+KKJm2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fM8tYPnO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cmxI0rqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JwyG7GwZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51D7C7BACF;
	Mon, 27 Jul 2026 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785165777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAIaG9zAhlFFVrkNW5grf40YuF8+Vz27T8DkfSLCb9s=;
	b=Tr+KKJm2BmEjYNZfCWyoZUJJulymhUQi8kRf2Bqq1COx7y3g1at43NJ6eL5I7oQuTWumo4
	QzyHuFZqhcq/O3PxErOq3yX0wnaOKfDNtedkJI5yOVSj6eQQQXiDVvBdtLiuUV9XJMYdvR
	UjmONggySAKz3jxP1rOQ/ztl9Mnitx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785165777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAIaG9zAhlFFVrkNW5grf40YuF8+Vz27T8DkfSLCb9s=;
	b=fM8tYPnOboPED2OsVNc/1yS3IDjlAOhx9sYsPjKBj3pJUIOe639tfs5n7oO+ivMKKOWTwR
	JRhBGM/3WzpijzBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cmxI0rqy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JwyG7GwZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785165773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAIaG9zAhlFFVrkNW5grf40YuF8+Vz27T8DkfSLCb9s=;
	b=cmxI0rqy9AAMAMVBb0xwZrizyM7HAyF2Af+QAyJsyMj29UpSewCp1vADACfMCQNotKuC0u
	5sSUDSU97MqMZ4vCudjbN4/4HWWmoXJ//b6kehTlf6NMJl+R8TynVaSPd5BvRutQooWVXR
	DqwlKv5hVuvenYJuKu2QmYM+K/Qskfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785165773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAIaG9zAhlFFVrkNW5grf40YuF8+Vz27T8DkfSLCb9s=;
	b=JwyG7GwZF9H/MG/PelW5VFS0yVpwhGX4h83WIqjxMOEvyfcs90VwPf8rHDZbULVyXNOapf
	ghNgXaO4DtBDZzBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46CE4779C2;
	Mon, 27 Jul 2026 15:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pUtFEc13Z2rIdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Jul 2026 15:22:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9F19A0BA1; Mon, 27 Jul 2026 17:22:48 +0200 (CEST)
Date: Mon, 27 Jul 2026 17:22:48 +0200
From: Jan Kara <jack@suse.cz>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: validate directory records in NFS get_parent
Message-ID: <h422u6iqz6faysofnomlcqizkqjrsgqw6ooo4jdhfyjuttkqou@p6frlkumlpmd>
References: <20260721101318.1453108-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721101318.1453108-1-chenyichong@uniontech.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 51D7C7BACF
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Tue 21-07-26 18:13:18, Yichong Chen wrote:
> isofs_export_get_parent() assumes valid "." and ".." entries.
> 
> A malformed image can provide an invalid length for the first entry.
> 
> Validate both records before using the first length as the ".." offset.
> 
> This keeps the NFS export get_parent path from accepting malformed records.
> 
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

This looks sensible. But for maintainability, can you please move
isofs_dir_record_valid() to namei.c and make sure readdir and directory
lookup functions are using this function for directory entry checking as
well (and remove the duplicit checks there)? So that we have the same
checks everywhere... Thanks.

								Honza

> ---
>  fs/isofs/export.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/isofs/export.c b/fs/isofs/export.c
> index 78f80c1a5c54..bffec45bb274 100644
> --- a/fs/isofs/export.c
> +++ b/fs/isofs/export.c
> @@ -16,6 +16,26 @@
>  
>  #include "isofs.h"
>  
> +static bool isofs_dir_record_valid(struct iso_directory_record *de,
> +				   unsigned long offset,
> +				   unsigned long bufsize)
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
>  static struct dentry *
>  isofs_export_iget(struct super_block *sb,
>  		  unsigned long block,
> @@ -83,13 +103,21 @@ static struct dentry *isofs_export_get_parent(struct dentry *child)
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
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
