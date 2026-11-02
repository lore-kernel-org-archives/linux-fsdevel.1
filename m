Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656025;
	b=T8Fu64guxxGptJ0b7ct2i7yeghQr3JWfZz58fDag2oVYt22TlKjHDqhRSc+bLxLLw71W
	 8JErEgEE8MdPWno/njAIbng1y0M3XgrF7CkXrgTl6PMQD1X+B0AmUPyc6XmrlX6q9rsHX
	 xsiqKTzcUFLQfqRHVOEcYGoRAMUK5c71jEOBdJz0OEurYA92LWQjV41/Se9TYq7VDCHNK
	 OcrlxOH2uy5tohQzdCjFr+RrgbDGJIaPq3l3avtP4mUHbJpKf0nRG9a2cSScGgTUEyLeA
	 Xjo8IaYwQ2Q4R81AvOH2AgNY0/5bKOpRQMlgkfXsx4XtH2e5yg1QkF2XyZISJveNwWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656025;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=i5HuJ6wlzqnm5PAKxcHqNPUgyKLe7g7pH4Aq4cQgHI4=;
	b=V0xPjcKKMi3uiEcljhGF1LbG1hUp9Jd956p62kySVDmodz58m/hIeMTvHDKLhBUPltZc
	 e3sCCb4qFcu/K4FdjR337Dfn/9dZxDzGv85L93HqqIxMllI5t090jotjWdPXPa8hnLoQN
	 qHy/00pDB8hzNveCuu2hAqrglQAo2LgR1xQ88u6VHiURmGLhw0Y8qBlAqBtLJRGYR6zMC
	 nLgg+W84l5ynBFRGDMIIGnIDyKSrjC8gEZYh+cPwak6Rs9dG6eJrLBjhkuikYvZRZE0TF
	 8GrRbQ+2g3ovsBlRAg2Rk/CYZ4xRRq0ZOSV/QPF5Jn3EsjeDo2PziCQWy6b5k6pAvcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zRSZ7JVx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KiE4Yqhf;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zRSZ7JVx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KiE4Yqhf;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC38606A338;
	Mon,  2 Nov 2026 21:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FC38606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zRSZ7JVx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KiE4Yqhf;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zRSZ7JVx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KiE4Yqhf
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C934E1FB28;
	Mon,  2 Nov 2026 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5HuJ6wlzqnm5PAKxcHqNPUgyKLe7g7pH4Aq4cQgHI4=;
	b=zRSZ7JVxIUt4LEZrOfepP6Efnx2ItlGJjoRUtpidWEWtyd8bxdqBtiqqxTVOKlP71MBmU4
	02vYVL8XRrlfDdHSKQNkWRqYNZkdZVgBAGblUnQ0ynZO2FgiNE6qewR74qD3nL/CQWwdo1
	0DiEoQcO/uitQS/uGUxM9rb0fOFPpBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5HuJ6wlzqnm5PAKxcHqNPUgyKLe7g7pH4Aq4cQgHI4=;
	b=KiE4Yqhf8IoHz+HMLLJH/edDuF8avhb6M7xdwW5mS5jIxFntZ9zhwIyNvQc+zlrdX+bmYO
	altBuoyJMtHveOCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zRSZ7JVx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KiE4Yqhf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5HuJ6wlzqnm5PAKxcHqNPUgyKLe7g7pH4Aq4cQgHI4=;
	b=zRSZ7JVxIUt4LEZrOfepP6Efnx2ItlGJjoRUtpidWEWtyd8bxdqBtiqqxTVOKlP71MBmU4
	02vYVL8XRrlfDdHSKQNkWRqYNZkdZVgBAGblUnQ0ynZO2FgiNE6qewR74qD3nL/CQWwdo1
	0DiEoQcO/uitQS/uGUxM9rb0fOFPpBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5HuJ6wlzqnm5PAKxcHqNPUgyKLe7g7pH4Aq4cQgHI4=;
	b=KiE4Yqhf8IoHz+HMLLJH/edDuF8avhb6M7xdwW5mS5jIxFntZ9zhwIyNvQc+zlrdX+bmYO
	altBuoyJMtHveOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0DB0134B3;
	Mon,  2 Nov 2026 21:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uqNKIdYE6WqQAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Nov 2026 21:47:02 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 5019DB173; Mon, 02 Nov 2026 22:47:02 +0100 (CET)
Date: Mon, 2 Nov 2026 22:47:02 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statx: don't leak STATX_ATTR_CHANGE_MONOTONIC in
 stx_attributes_mask
Message-ID: <yxnngsz2x5zyg2wjknlsyfkrtok6yow5wieky6jl4zkitjfybw@fze3yg7b5cbg>
References: <20261029-statx-v1-1-9600cdb896b3@kernel.org>
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
In-Reply-To: <20261029-statx-v1-1-9600cdb896b3@kernel.org>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: C934E1FB28

On Thu 29-10-26 12:20:27, Jeff Layton wrote:
> STATX_ATTR_CHANGE_MONOTONIC is kernel-internal. cp_statx() strips it
> from stx_attributes but copies attributes_mask verbatim, so it leaks to
> userland on filesystems that advertise it (nfs, ceph), e.g.
> stx_attributes_mask = 0x8000000000b03000 on NFS.
> 
> Mask it out of stx_attributes_mask too.
> 
> Fixes: a1175d6b1bda ("vfs: plumb i_version handling into struct kstat")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

OK, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index a2e63c6c45b7..787c13f378ff 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -719,7 +719,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_ino = stat->ino;
>  	tmp.stx_size = stat->size;
>  	tmp.stx_blocks = stat->blocks;
> -	tmp.stx_attributes_mask = stat->attributes_mask;
> +	tmp.stx_attributes_mask = stat->attributes_mask & ~STATX_ATTR_CHANGE_MONOTONIC;
>  	tmp.stx_atime.tv_sec = stat->atime.tv_sec;
>  	tmp.stx_atime.tv_nsec = stat->atime.tv_nsec;
>  	tmp.stx_btime.tv_sec = stat->btime.tv_sec;
> 
> ---
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> change-id: 20261029-statx-3f1d8cd8d877
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
