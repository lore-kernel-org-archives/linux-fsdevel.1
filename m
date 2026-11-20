Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169325;
	b=loa9m54gGIOZWL+DXSThMAI7gadlVx6oVmqw9XJD6qpQlQRE4sZNuj0etaC4jW8cRxbb
	 ysjFBmBtc/PKOp7uKD795fI8iCcPFPrN8oJuU20ZuUjLBmbpP1FQOPCqJR4nLgqMXELx5
	 bh19RPjXJ4iqpICrJM/1QwRKszHAeNiJKLtActeDgl49I0U+gRUk7KH1LsVLxFniZhrbQ
	 9dI23RYBXNGkj2I+ZkzME95hGLJBvmiLgtvbAvzQ+68W6R7GmxkiZPCyR3aTFAcSickFb
	 uyBPvy+mLUOTz0DSMtRe4h3yz4hjjkD4rSia8ySK8w2cb4V8fJjy/2EgKqbwB7AQMAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169325;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Jab+ND4zeJqFHCVgOsrMnfzPNlB/A24GnLYC0BcAzXA=;
	b=32jw259T9mghIyo7PxENOxpGUz+W5K2ctsyV5Nn6lfMNq8nwoXGKMYQXO1RoIMezQTGZ
	 x2ScztWM4TLSa9LVYteWGCJU2knBQM5uD3ybRSPUo7nBPRIDF3co18/y3ifxkvks7yOOw
	 Au9mLnoHmt7oia4WK/qF7b+++fUddTjFzbC+X3el/YRf3NhF8x7sUwZeaxPJC6WqbPxjm
	 vu2NHUzySm9ywQGJurwMNUNe2geGYyB5D0lEojIs/3ZrBl0Xe28DWTyxeWxBBnQwp1nmO
	 CetzH2pV53Mes4qtcbzVIeLaPOT75mIqKdp3A70SH5iUmgTGml2QnQZ4crNleJMpv5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wOV1nd9x;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Jfdc3rqw;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=jDFZVkI7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=evlyqQen;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A98606A326;
	Fri, 20 Nov 2026 10:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A98606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wOV1nd9x;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Jfdc3rqw;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=jDFZVkI7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=evlyqQen
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73A052260B;
	Fri, 20 Nov 2026 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795169317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jab+ND4zeJqFHCVgOsrMnfzPNlB/A24GnLYC0BcAzXA=;
	b=wOV1nd9x4ghvKw2YrlFx/GvHlzkKef+o3Sez8q4OSJUQZtrrkPRT5Qr9aBEFpMZFGX11Qa
	A37UJhC4OUMgj2xDkFyO9PtS0qYA1tJkrn8lv8Ee4RQlpb0eKXaxHpONJPS+QyD9xjByNI
	cs/SESIpAAHWwl7Zrw84f21OdnZJZAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795169317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jab+ND4zeJqFHCVgOsrMnfzPNlB/A24GnLYC0BcAzXA=;
	b=Jfdc3rqwGp17QL0jkLMZW4Z595emOBJwEUjKhelfegEDWsY+ZURYr4HYsDlw5rNfakL605
	iWcXtxMFbO41EYCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jDFZVkI7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=evlyqQen
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795169316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jab+ND4zeJqFHCVgOsrMnfzPNlB/A24GnLYC0BcAzXA=;
	b=jDFZVkI72lK00s3bMYIixM6m8aPPlTLxDaEiWuk5GPR4nkHPskuwNIg66oqzDkOcA6ukn3
	g7mmTKVVnYHaRcRTvw6UA2kdY9nrtATGrWgfkMwGm/KMxERz/J4IthM1ol1NUdy5e8pUd0
	+FIC02q4LH1teCIqEYP/taQDhzs4zj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795169316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jab+ND4zeJqFHCVgOsrMnfzPNlB/A24GnLYC0BcAzXA=;
	b=evlyqQenFg/k0xdZNIIl/hKEw/giz3oLTovgfq3bquBeRojnmSakMQ70edXhnDplRD2VZ5
	VE/02YblrUj4KuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D7671348F;
	Fri, 20 Nov 2026 10:08:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2GbNCiQcAGsZIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Nov 2026 10:08:36 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id D6F5325EFD; Fri, 20 Nov 2026 11:08:35 +0100 (CET)
Date: Fri, 20 Nov 2026 11:08:35 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v5 5/5] Use d_for_each_positive_child() in fsnotify.
Message-ID: <coiaib34jrxy4ja24zeqn5xq644yk6dhrxud6rtrdnecno5mnq@ew6enlw6bi5b>
References: <20261119025942.2848130-1-neilb@ownmail.net>
 <20261119025942.2848130-6-neilb@ownmail.net>
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
In-Reply-To: <20261119025942.2848130-6-neilb@ownmail.net>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org,themaw.net,lwn.net];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 73A052260B

On Thu 19-11-26 13:57:05, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> fsnotify has been reported as source of soft-lockups when iterating a
> long ->d_children list.  Change it to use d_for_each_positive_child()
> which will call cond_resched() as needed to avoid soft-lockups.
> 
> Link https://lwn.net/Articles/1079407/
> Signed-off-by: NeilBrown <neil@brown.name>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fsnotify.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 58566e6b9679..33c5d10f78ba 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -86,16 +86,12 @@ void fsnotify_set_children_dentry_flags(struct inode *inode)
>  	 * their d_flags to indicate parental interest (their parent is
>  	 * the original inode)
>  	 */
> -	spin_lock(&alias->d_lock);
> -	hlist_for_each_entry(child, &alias->d_children, d_sib) {
> -		if (!child->d_inode)
> -			continue;
>  
> +	d_for_each_positive_child(child, alias) {
>  		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
>  		child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
>  		spin_unlock(&child->d_lock);
>  	}
> -	spin_unlock(&alias->d_lock);
>  	dput(alias);
>  }
>  
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
