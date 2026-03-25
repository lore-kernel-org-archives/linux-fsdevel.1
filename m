Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407873BE63E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440795; cv=none; b=Hq3WaUaI+Bnv/83ah4rseE4VLNhnmFAwdyKkTMqWxf2mDs9y08FwrTw2kZ0wnU5CHbnd58XFym13hK1WKzaFgqLKFxZMMx11bTBTtgi4Bw/JHv9e0HULzCOmriZKtVoDcZc8qNNhegABeOVhkqcaMvLo3H7f6uz1H/stUNkkqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440795; c=relaxed/simple;
	bh=Byk3PGuIK/Pp6u3RHirneKA7lSVmroDh+Gy/iWLjCBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSwU4LpnwtRjRvPbMQxe9DxBB2Mu4pxp6gn7y9BNM38wq2E72cqKuM+dxE+59dePUwQB4snSbEkbeH3YlZVmzVzl6QD3ofPmQpYU7sO8b8FQCgnXNX9qfrXa1dTPA5VIZAbEESsMi5Vsoxe6WNArRlN16/BHYydtq5H8cSHNsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DbJmX3Ou; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B7snjmLb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DbJmX3Ou; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B7snjmLb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DbJmX3Ou";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B7snjmLb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DbJmX3Ou";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B7snjmLb"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AF7C4D233;
	Wed, 25 Mar 2026 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774440792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxipox8xrIAAKB+KOZvCQwwKM7biKEEDtysBYiy0+DM=;
	b=DbJmX3OuZ6Svo8SK3SNDM77wAYdzzq3vxw/i/cPeavss0u6ffRhF0ksX55x5Pj8kLk9yCC
	b2RhcH6Mz3AUznwUtW+5hjm7MJ4xDWfIMfGiIu+KZ+8xBjW7avD+D1RLJeOlMyQvJaHFYy
	uIqOtV2G0BiRQQwuP+CopNLXYgX/148=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774440792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxipox8xrIAAKB+KOZvCQwwKM7biKEEDtysBYiy0+DM=;
	b=B7snjmLbBkQFmZICpsq//4/xOzV5ygq4gBkR2kIxgU3vSEuAptHjKoWqYa4+ueYw9d2OdW
	2E6S4LFUgdJUXXDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DbJmX3Ou;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B7snjmLb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774440792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxipox8xrIAAKB+KOZvCQwwKM7biKEEDtysBYiy0+DM=;
	b=DbJmX3OuZ6Svo8SK3SNDM77wAYdzzq3vxw/i/cPeavss0u6ffRhF0ksX55x5Pj8kLk9yCC
	b2RhcH6Mz3AUznwUtW+5hjm7MJ4xDWfIMfGiIu+KZ+8xBjW7avD+D1RLJeOlMyQvJaHFYy
	uIqOtV2G0BiRQQwuP+CopNLXYgX/148=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774440792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxipox8xrIAAKB+KOZvCQwwKM7biKEEDtysBYiy0+DM=;
	b=B7snjmLbBkQFmZICpsq//4/xOzV5ygq4gBkR2kIxgU3vSEuAptHjKoWqYa4+ueYw9d2OdW
	2E6S4LFUgdJUXXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEBEC443BF;
	Wed, 25 Mar 2026 12:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t2lxMlTRw2kwOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Mar 2026 12:13:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8E7F9A0B32; Wed, 25 Mar 2026 13:12:35 +0100 (CET)
Date: Wed, 25 Mar 2026 13:12:35 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] proc: rename proc_notify_change to proc_setattr
Message-ID: <lvuxxvdx4b7ymcls5gkd2o45w6wpersxxfmtuyfvd6dsgftthq@mlebl24p55ra>
References: <20260325063711.3298685-1-hch@lst.de>
 <20260325063711.3298685-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325063711.3298685-6-hch@lst.de>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,lst.de:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Queue-Id: 7AF7C4D233
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 25-03-26 07:36:52, Christoph Hellwig wrote:
> Make the function name match the method that it implements.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/generic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 501889856461..8bb81e58c9d8 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -115,8 +115,8 @@ static bool pde_subdir_insert(struct proc_dir_entry *dir,
>  	return true;
>  }
>  
> -static int proc_notify_change(struct mnt_idmap *idmap,
> -			      struct dentry *dentry, struct iattr *iattr)
> +static int proc_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +		struct iattr *iattr)
>  {
>  	struct inode *inode = d_inode(dentry);
>  	struct proc_dir_entry *de = PDE(inode);
> @@ -151,7 +151,7 @@ static int proc_getattr(struct mnt_idmap *idmap,
>  }
>  
>  static const struct inode_operations proc_file_inode_operations = {
> -	.setattr	= proc_notify_change,
> +	.setattr	= proc_setattr,
>  };
>  
>  /*
> @@ -364,7 +364,7 @@ const struct dentry_operations proc_net_dentry_ops = {
>  static const struct inode_operations proc_dir_inode_operations = {
>  	.lookup		= proc_lookup,
>  	.getattr	= proc_getattr,
> -	.setattr	= proc_notify_change,
> +	.setattr	= proc_setattr,
>  };
>  
>  static void pde_set_flags(struct proc_dir_entry *pde)
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
