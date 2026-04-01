Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826638AC68
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035655; cv=none; b=tqGIqNiGnFbycMQy1INsMy5gie47BquI4kscVM6oHTNaDwZgm/JYyHLigrTrlgqfo6bYjaeUR/sw3eHzZNqgaJh55a2frTfikiv0cA4/8MycTnQQq6pMSvCg61pbbRAXSh+dCfW2B6JIeEJrJ8xQ+uSGBfAcQpgmoBMraM8eGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035655; c=relaxed/simple;
	bh=QX4XKvE7p9GUc3cofoWpfILzRibfe8FK7Ao7xD8YshE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhGJNbH9sZRi2bf4nvSSbSnZiIBvsRhQqr+PLK9CQDiRYkOCR71Riw0lKUKe9liCTe7QPInFlKZOvgoP72YduP/AF9VguMs3lS3seHI5+7sJJ+qwBT7Z9ZyFIJ60ZJhtyzJgUHQpnX06jh/3FB40kNsFZLk5sm6zIgjySth32iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HxLPC3MK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2SHkLZf+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TK+Y3WqQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GkfsvUeI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HxLPC3MK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2SHkLZf+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TK+Y3WqQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GkfsvUeI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D19DD4D2F1;
	Wed,  1 Apr 2026 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775035652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goYC6/inwgMq0LttWqVNvn1DMDVVWwbbQ9saCHaDa94=;
	b=HxLPC3MKgF0X6GZzq3RqKbNe/EMGxmjJmpoMfV1rQjehjZbeT1cPiR3S5youZDkcAGhlCb
	+UlbRWRl/ByMtqdEZxHmkQ0FLCO0+ZP4PY1OKm9JShtpKGr1dbAxltls+9Ul8Ml2i+cQOU
	+QuJ/VvMiEUX3N7EuS7upgnG0+AQlo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775035652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goYC6/inwgMq0LttWqVNvn1DMDVVWwbbQ9saCHaDa94=;
	b=2SHkLZf+UPv2fp9SP1PEvJUKXRKB9J+IJ6jaqPMT55ha49w5uytaBsAmKJidVcfV/LZ2yM
	cPrCZ3DpDpEqGTCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TK+Y3WqQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GkfsvUeI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775035651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goYC6/inwgMq0LttWqVNvn1DMDVVWwbbQ9saCHaDa94=;
	b=TK+Y3WqQbY+UBVIzXp8khexAJO/LeCojlIT654VTW72YQOWk0itCUDl8R6/05nWyD/j6uv
	lcLBOWrdFMr6IxmxRkN/bsWwNbcfe++q0ogKTN2TeoihzgIDI21+CoOjlL6jYCj/uolEXH
	hoXyx1M7kxo/A961rM1+Ptu1VCV2nrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775035651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goYC6/inwgMq0LttWqVNvn1DMDVVWwbbQ9saCHaDa94=;
	b=GkfsvUeIyyLcrrhqh/b8HU90nXD1r6Pibp6Bus74C5+S2U8DeuAeLFyM1d/Io7fMdpJglA
	4Ut3qyDBAULQVzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8E884A0B0;
	Wed,  1 Apr 2026 09:27:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KgECMQPlzGnVRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Apr 2026 09:27:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87571A0AFD; Wed,  1 Apr 2026 11:27:23 +0200 (CEST)
Date: Wed, 1 Apr 2026 11:27:23 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: add back TODO concerning printed info to
 dump_inode() and expand it
Message-ID: <4natbslv5enjgukekzr5cewvdzgw2drh3yas64tdcn7wnqjfak@bvmjc7xarrdm>
References: <20260331150701.3844815-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331150701.3844815-1-mjguzik@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: D19DD4D2F1
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 31-03-26 17:07:01, Mateusz Guzik wrote:
> I failed to notice the change which added get_kernel_nofault() usage
> removed it. It very much is still applicable.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

I'm not strictly opposed but at the same time I'm not sure about the value
of such TODO comments. Maybe better track it in some kernel-newbies project
or something like that? I know there are lists of beginner's kernel tasks
out there.

								Honza

> ---
>  fs/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 5e5cddd76a9d..912831645f38 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -3100,6 +3100,12 @@ EXPORT_SYMBOL(mode_strip_sgid);
>   *
>   * If inode is an invalid pointer, we don't want to crash accessing it,
>   * so probe everything depending on it carefully with get_kernel_nofault().
> + *
> + * TODO:
> + * - add more fields
> + * - pretty print flags instead of merely showing numerical values
> + * - consider extending inode ops with a ->dump_inode func so that filesystems
> + *   can print additional information
>   */
>  void dump_inode(struct inode *inode, const char *reason)
>  {
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
