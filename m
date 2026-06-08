Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546841A6838
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922558; cv=none; b=oqtxphhIirktzekesD2sMmHramdk6tGSs2I6tFMFqkiMMPppDOJHm5OdVJXm35A2HJN7ZtD8G6vKfkOVKiToIw6noFoigX26GqZKvlQvVyjUNllEuvwOvB+wfeJrCCLtIeIjEXIidB9pw1L2NLsozMXiEHi+CdW1p0Au9Ye86eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922558; c=relaxed/simple;
	bh=xII1WDlU29RDVCfNYKSal7G1AeFofvkebxA0pMKoTtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhgh/Ie9dVojBHhHPWliqk0xBKO7abFq0CbmkgVAf8B8ixCmNV8Cxzk1woueNGJqaxi8mXoQx7zzi5/4DG9TBRXEMulWo85DAzq4II7v8Q4SHBKuKVv9FyzTGPWWM0Evk2gLOYqB9enAKhEMeo3H7889uF5MzVpH/RUz9cbBFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IeMYmXRD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FQ1IoOR4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YGNCjfPy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=10AWCZys; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IeMYmXRD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FQ1IoOR4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YGNCjfPy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="10AWCZys"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 633DF6AB17;
	Mon,  8 Jun 2026 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ7NMglnj2Jxw2qK0TxVOiphXudQ4605Z0sGz9XhG3w=;
	b=IeMYmXRD0gaDJy4Sf8riK//rlAxN9dEbMHEHSt82Itj+RrDau5w8Dgu/ywzrXQ/sAQ2ITe
	7hCmRAUR1LcsEHyLLLTMIS6rnxU7X9N8wFIs50BJFkDyNSUwXEQFyC1Zeqxpx++JZWhpI9
	LvlYvz2RgiLt7tHH1VP2/J8y7vWu3gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ7NMglnj2Jxw2qK0TxVOiphXudQ4605Z0sGz9XhG3w=;
	b=FQ1IoOR4Qc40ThN+0H8L2cVPj93+IO6zK7WzHCQul6Br0RKGbfVXWouau/qzwyk8rzSWnA
	SlT9pmL/xJg8AYCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YGNCjfPy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=10AWCZys
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ7NMglnj2Jxw2qK0TxVOiphXudQ4605Z0sGz9XhG3w=;
	b=YGNCjfPymMbNT4d0oPHZuxBXByHtayOvAwksyGt7C2xk3sb3XtHwQaxQBYSjnFkMDBdEGs
	dcsARxrwm9N11D7O0z/WUxLdz3I7giTTEYb/j6cqeMvsZ4SxwUY8ZIQp8BGmA1e56KvmxE
	04BmLtriwcCz/pNYBRZ2Tlq88MJ9zGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ7NMglnj2Jxw2qK0TxVOiphXudQ4605Z0sGz9XhG3w=;
	b=10AWCZysPOS4AqrHalnXypk+R95nrKWoHzg1ScLBO49DtqJMDl43xbMBd/9udD5QdzIRUN
	FTI8AW4uGbWyquBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A7C4779A7;
	Mon,  8 Jun 2026 12:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M6YRFri4Jmr7TQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 12:42:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14F43A0923; Mon, 08 Jun 2026 14:42:28 +0200 (CEST)
Date: Mon, 8 Jun 2026 14:42:28 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 16/18] configs_attach_item(): drop unused parent_item
 argument
Message-ID: <rcf5ftjphvy4zdn3h46stsktrkhvciutzdsxz7wyfh4hxzy4a5@jimmcg5g3mti>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-20-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603074815.3033766-20-viro@zeniv.linux.org.uk>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 633DF6AB17
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,linux.org.uk:email];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 03-06-26 08:48:13, Al Viro wrote:
> That argument has been unused since the initial merge in 2005.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index b382d60e7ebc..2f3f3f504e2c 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -856,8 +856,7 @@ static void configfs_detach_item(struct dentry *dentry)
>   * clean up the configfs items, and they expect their callers will
>   * handle the dcache bits.
>   */
> -static int configfs_attach_item(struct config_item *parent_item,
> -				struct config_item *item,
> +static int configfs_attach_item(struct config_item *item,
>  				struct dentry *dentry,
>  				struct configfs_fragment *frag)
>  {
> @@ -899,7 +898,7 @@ static int configfs_attach_group(struct config_item *parent_item,
>  	int ret;
>  	struct configfs_dirent *sd;
>  
> -	ret = configfs_attach_item(parent_item, item, dentry, frag);
> +	ret = configfs_attach_item(item, dentry, frag);
>  	if (!ret) {
>  		sd = dentry->d_fsdata;
>  		sd->s_type |= CONFIGFS_USET_DIR;
> @@ -1426,7 +1425,7 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (group)
>  		ret = configfs_attach_group(parent_item, item, dentry, frag);
>  	else
> -		ret = configfs_attach_item(parent_item, item, dentry, frag);
> +		ret = configfs_attach_item(item, dentry, frag);
>  
>  	spin_lock(&configfs_dirent_lock);
>  	sd->s_type &= ~CONFIGFS_USET_IN_MKDIR;
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
