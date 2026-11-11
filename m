Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406802;
	b=GODrinKW41eFS2nw2VQI0tzozY1V/Tq0XoC+TATplRD4vb85KesfQqZ7to6L6PvRGHS0
	 q7/8XahwWx8otPUV4nVzAWopJWqjZQmaqfQKduLWIoiaV4tjoDGym3r0UdDQJfV2v+jH6
	 Maa/ZpNPVler+KAm1q9LkgBZZxjFMWYOslsU2PpEujWQgO8UHOKkTKjxB7ALZVKyFoiYR
	 hwzqXvUwhPYI0XC9A5+pYMt3B1Z3X2RpsFCwZLArm3yXAGJDQWB0pZ398pCSI55Dj7IV0
	 Rm3Wf4G+iDSNlsGsdcIaG1b2G5XT3NonaSUoWgZm9fgB8N2vmAMdYgxcDWDuWuvMPPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406802;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=84+y3bW6H2hYLwU+MkZkozndSM4iRA5oreEclsvyGgI=;
	b=Ii5VvaX+e/BU1z5HQGymcMPWF1uxoCNwyDvY8+kaIl0addOcSl9qLNHoT3ltmRF3cICI
	 FKj+Tz3W1H/mctqDjUskW4HRuiK2sJ5ku8mDlDXVRnWDDaHUtA2uhuA/OFT8NZ7UMOYP2
	 JEpJQ2qZ3mXwDFqm5+HNuYx7rFrIGL1+/BhZLMEInNAvkBqwHTqcHtP9t7mqAiiFeq1sS
	 djpDmULpLvLPR+q56QeSILcLm6EiP0FppaPBZ7IXxfx5Z0HgxyxGbGUqvNq+zVOOwhpDy
	 2DasEdQlDqyPPJGo0VZRjx9tD44kftH4tA29A9UZU/mk8y/FnqCdYX0jgQB27QO2KTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="iyu/pdrU";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YPM3E9vZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UjJXvVx8;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lVT9Bu+v;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD26606A327;
	Wed, 11 Nov 2026 14:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD26606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iyu/pdrU;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YPM3E9vZ;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UjJXvVx8;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lVT9Bu+v
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF2C2221FE;
	Wed, 11 Nov 2026 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794406800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84+y3bW6H2hYLwU+MkZkozndSM4iRA5oreEclsvyGgI=;
	b=iyu/pdrUWHYRn5lmwphgvd8i/YVst8HYctZDEzNn1VYkuUZ8sxsGBUWxWDy+zJ10BjJDum
	wUVo2khefGd8N7vCQ1uLG2ovfLwGFRugFOfy0qyOZbt8E1fKTLRiJX39LK+dYAf/7WTcHI
	HWXEJ9yDe+exiPsHJIZ+wpVkGitxu0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794406800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84+y3bW6H2hYLwU+MkZkozndSM4iRA5oreEclsvyGgI=;
	b=YPM3E9vZii0Cj5U6Duz6h35Cuwks0fxpyULI7o0SwuB8u/QDij3pxptijviw4iHIPAc/iI
	REAKFFWE61j+0ZBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UjJXvVx8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lVT9Bu+v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794406799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84+y3bW6H2hYLwU+MkZkozndSM4iRA5oreEclsvyGgI=;
	b=UjJXvVx8EhOzfs16eYYmGf0Not2Ho5iqUVkHq7n6rcl9REAmCaPDNdmF2GyfDYviUijwvE
	eRQICLkL64nOHW2Oj6OWNDP8eN81U78U3X2vUXwcLrFQU7E9O05Fp2L5ZrWMX1KChAOSsY
	Y8UlazE+wuoVqSYu8ZlnlKfwaBbN69w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794406799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84+y3bW6H2hYLwU+MkZkozndSM4iRA5oreEclsvyGgI=;
	b=lVT9Bu+vV1Tn12YgIA2ikfgN+gDhLk+VlOHCLYPlpfL5FBZTpLroFkBqFkVfgh3r4rsKej
	/8atkClqKpZincBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B304F134E5;
	Wed, 11 Nov 2026 14:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SEahI4959Gq6BgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Nov 2026 14:19:59 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 451442293A; Wed, 11 Nov 2026 15:19:59 +0100 (CET)
Date: Wed, 11 Nov 2026 15:19:59 +0100
From: Jan Kara <jack@suse.cz>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a088f9d6bf95dc66a923@syzkaller.appspotmail.com
Subject: Re: [PATCH] stat: annotate the lockless inode block count snapshot
Message-ID: <zvjlvnwf2bq3msqzxe2jghn3vqfx3t25mr3w4izihinufyirvh@4dreau3sqkiy>
References: <20261111064731.17214-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261111064731.17214-1-zhujun2@cmss.chinamobile.com>
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[a088f9d6bf95dc66a923];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -11.51
X-Spam-Level: 
X-Rspamd-Queue-Id: DF2C2221FE

On Wed 11-11-26 14:47:30, Zhu Jun wrote:
> generic_fillattr() reads i_blocks without inode->i_lock, while concurrent
> space accounting updates it under that lock. KCSAN reports the read
> racing with inode_add_bytes(), for example during a tmpfs write.
> 
> The block count returned by stat is a snapshot taken while file contents
> may change. Annotate this intentional lockless read with data_race(),
> without marking or weakening the locked space-accounting updates.
> 
> Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/stat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index a2e63c6c45b7..6e6f99aaa628 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -103,7 +103,8 @@ void generic_fillattr(const struct mnt_idmap *idmap, u32 request_mask,
>  	}
>  
>  	stat->blksize = i_blocksize(inode);
> -	stat->blocks = inode->i_blocks;
> +	/* The block count is a snapshot and may race with space accounting. */
> +	stat->blocks = data_race(inode->i_blocks);
>  
>  	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
>  		stat->result_mask |= STATX_CHANGE_COOKIE;
> -- 
> 2.51.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
