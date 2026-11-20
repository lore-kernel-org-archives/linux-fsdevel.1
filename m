Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168460;
	b=PqylpGQtdIY2j3st4vYVT0YjR4SoEsbpA9rBbwCL/pL7WVTybxUUTFT3ic/e9k84Io+w
	 2a0akPo4nYu4BeZE1uPuw5kk1zl8s0qNdLasVIUTOri5jSZsSXd/B9MFs1XFI+0NIW6Cn
	 JLkvWnZKGSXkNI4nWhMf1AYJtac8BBbwTOyNHdhO1+p58zuT+miza3UK31a9EPT6FIgvG
	 tpa8xjEW2O78O7/3EcU2yRmaOgo4LtM8JQ82Zb/AXI+t5gjlVH/3tGyWrkkM14AYLY36M
	 stxCMQ0G0TV9mK/X+bnYwBlhC7ehmkfmDVIB8+1FHYGTXudVzNATr95NW/5p/hEII7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168460;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=d3D04tBr+eCbfuUo2ou5/gCrrIth6zAmWBOJCJ9S6kY=;
	b=hc57/UPqdlZIVLPGmp3riiJ7n7NGidPgzI/lvM7Ek5ZP0mOJuxiP+mwR8z6sPA1qRPEE
	 41jtU54xH3bt29r0bvNpCjr9YYC7YdW44o4TwUni8oU8pJpcLNWwiQEMTjDVgjpfpgpYV
	 Hz6uGGEEw3OVa+1dAJe8MBcQI90rvJQc57RsxDzGS1Wo4TxtWXY6a3LNvg408LSywOAL5
	 S906e+N6kLB9vVocuvKNOjl91VdwoMk4LxbGf0oj08L5lYItwhwSXccfBfvuKqxd3co7v
	 b/zxGXsoLC99PhjdLnMv0HM2rl1WpSpn04mKPr8iS+vFoKpCMFCiUtJlkem8kui+vWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YDnOWLrE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hl8aSTTs;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NuOn9MTZ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=O4Hv3Wo5;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915B60A2615;
	Fri, 20 Nov 2026 09:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D915B60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YDnOWLrE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hl8aSTTs;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NuOn9MTZ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=O4Hv3Wo5
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE2471FB70;
	Fri, 20 Nov 2026 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795168458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3D04tBr+eCbfuUo2ou5/gCrrIth6zAmWBOJCJ9S6kY=;
	b=YDnOWLrEQ1GyjOb7spHxMuLUiMbJWJ/9UZ7xRmZVW+ddDiPblnWf50j+sVNlQJl6iPwgC5
	layiTbgtvaJOieRADqAv+td+fzBzTPRoV2v7DoxRZZ22lJwF/61mA9jXL7uEuaB1YNwURG
	NHVYDupx3jjc32hzjNkDtxHYOX1Yn/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795168458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3D04tBr+eCbfuUo2ou5/gCrrIth6zAmWBOJCJ9S6kY=;
	b=Hl8aSTTsH8bxVNYcmdcTxg0jaz6qeFkF/7uA6Qm6aGaAfaSay7EDzOZLVs1+YJACdTwAi4
	6mdNl2GeliP6CXDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NuOn9MTZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O4Hv3Wo5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795168456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3D04tBr+eCbfuUo2ou5/gCrrIth6zAmWBOJCJ9S6kY=;
	b=NuOn9MTZ477iqxcuG3N9ne1uK4SAqYb2pvwxht77Qqlcesfwl9yk/j7ln/ypDyo5f+/iug
	jLY/ZyAaTH7YM30yU6pa89esewECTcsjBult1FTIVxTYOF/NWRbFTak4NbKKFcfRtr4zlP
	7Iwbiofe0Hsesgu3nFZN+pvzRaO6xi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795168456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3D04tBr+eCbfuUo2ou5/gCrrIth6zAmWBOJCJ9S6kY=;
	b=O4Hv3Wo5VUUtcaMg+nxx17Em53mfEpXzARyPUEFitAll7Y5BJ2kkNcSMYiWaFSS+BEjv/L
	45hj2bQVck0M06BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 972CD1348F;
	Fri, 20 Nov 2026 09:54:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NuXKG8gYAGt/EgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Nov 2026 09:54:16 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 2252025EF6; Fri, 20 Nov 2026 10:54:16 +0100 (CET)
Date: Fri, 20 Nov 2026 10:54:16 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v5 3/5] fsnotify: don't hold i_lock while walking
 d_children in  fsnotify_set_children_dentry_flags()
Message-ID: <ht3jmmlbvijg75kvpdv7rnjcytw2ndnlikg3n5qveekaqr55em@oivgxe27lhmu>
References: <20261119025942.2848130-1-neilb@ownmail.net>
 <20261119025942.2848130-4-neilb@ownmail.net>
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
In-Reply-To: <20261119025942.2848130-4-neilb@ownmail.net>
X-Rspamd-Queue-Id: BE2471FB70
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org,themaw.net,lwn.net];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,brown.name:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.01

On Thu 19-11-26 13:57:03, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Rather than hold i_lock across a d_children walk, dget() a reference to
> the dentry and drop the i_lock before the walk.  This is easily done
> with d_find_alias().
> 
> This requires that we dput() which can sleep.  Now that no locks are
> held across calls to fsnotify_set_children_dentry_flags(), this is safe.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fsnotify.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 8657bb94dfa8..58566e6b9679 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -71,32 +71,32 @@ void fsnotify_sb_free(struct super_block *sb)
>   */
>  void fsnotify_set_children_dentry_flags(struct inode *inode)
>  {
> -	struct dentry *alias;
> +	struct dentry *alias, *child;
>  
>  	if (!S_ISDIR(inode->i_mode))
>  		return;
>  
> -	spin_lock(&inode->i_lock);
> -	/* run all of the dentries associated with this inode.  Since this is a
> -	 * directory, there damn well better only be one item on this list */
> -	for_each_alias(alias, inode) {
> -		struct dentry *child;
> -
> -		/* run all of the children of the original inode and fix their
> -		 * d_flags to indicate parental interest (their parent is the
> -		 * original inode) */
> -		spin_lock(&alias->d_lock);
> -		hlist_for_each_entry(child, &alias->d_children, d_sib) {
> -			if (!child->d_inode)
> -				continue;
> +	/* Find the dentry for inode - there can only be one */
> +	alias = d_find_alias(inode);
> +	if (!alias)
> +		return;
>  
> -			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> -			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
> -			spin_unlock(&child->d_lock);
> -		}
> -		spin_unlock(&alias->d_lock);
> +	/*
> +	 * run through all of the children of the original inode and fix
> +	 * their d_flags to indicate parental interest (their parent is
> +	 * the original inode)
> +	 */
> +	spin_lock(&alias->d_lock);
> +	hlist_for_each_entry(child, &alias->d_children, d_sib) {
> +		if (!child->d_inode)
> +			continue;
> +
> +		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> +		child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
> +		spin_unlock(&child->d_lock);
>  	}
> -	spin_unlock(&inode->i_lock);
> +	spin_unlock(&alias->d_lock);
> +	dput(alias);
>  }
>  
>  /*
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
