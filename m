Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593823;
	b=0EL/NKxv0M80wPMr37L6tVXOklQnxjQwkzJEUcoWhzB9mPm1KJn2rNQxUWAcUZFBQzzD
	 XAZ4SIYSaTRIANYN5CUps3igBzPTJv0D8FsrgtkRqsDkcaMIPUOvNODYGVSsaxS83G//3
	 iSe8X5ronZOpQz8ufMD4pwj78NtRgoHC5T/tOxUxh7N3STAMlYG/gm+G2AfMAUD0+BnZ3
	 gixXbrQt72wyJdpXmDATwfIzIyBoVfrsvuZbIIy8nmbryBfx9TyZUCiNBd8/YLxr5Xqsy
	 xWgHPmxuCeWf0lln/x5LxR7wHZK7eHLzxKoztGSbJR4eeSw0gYJxVCftHtlzYhwKhLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593823;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=7paClLlEK0u0d6tYoqVOf1wINTZNt6WIxFEjCfo/0DE=;
	b=mpmrGLkgnTwVGIyHJBkuJ4P5QhdUD6c0ed/bn5hDT5uLLhFp/8cBoLPrjDc09mWnjZT+
	 9dOeGQ0KfDYtMXLM8LBMyojpNXQQyZNemAAwGc5a5e5JaxeMWbWXO3DhB8nnGH83ZCRrk
	 WiWJ2R4yGeA3op7IcYF/qijjkDLFC5+3lWwUKZp2tcokrPDBUsLxiCv1Q7NJmf57FsZaN
	 MJE4x6P96QJKXBjlYyrzHPzN+BbXSrw8gf2nagiqbCBxS6m0jx0nJUmp6fZLlYdJ7TX90
	 nNcOmEfrdu1fcn3jR50lcuOXLHB5i/QBXKHDfebmjiMs4O84BBt8kO/ANjQnt8YCemg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3Tw9TX1G;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JMSWRxbV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3Tw9TX1G;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JMSWRxbV;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3A606A31E;
	Wed, 21 Oct 2026 14:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A3A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3Tw9TX1G;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JMSWRxbV;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3Tw9TX1G;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JMSWRxbV
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0B5921F3A;
	Wed, 21 Oct 2026 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792593820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7paClLlEK0u0d6tYoqVOf1wINTZNt6WIxFEjCfo/0DE=;
	b=3Tw9TX1GO8XS/vDoexb96kYzF9CIO20Poc9D6Ugp3xR8PozcbzAQh07KIROjJFFB2TfsDH
	4cCsUB1X736qMoytldb9/JNdObaF4YU1d0lO6lOh+BcMJw9HTSMnR3VfqTKmqiAScsLMH8
	1ykjN0SU9WAJnVCr+XmTd6wQhJwA3fA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792593820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7paClLlEK0u0d6tYoqVOf1wINTZNt6WIxFEjCfo/0DE=;
	b=JMSWRxbVZEeZvpgm253YsQctmbqaX3YbaSCWJe0Gjd+HqBE65AnCkW3SDT1cch/Br1XA8P
	+TpIQvQoZvhaulDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3Tw9TX1G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JMSWRxbV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792593820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7paClLlEK0u0d6tYoqVOf1wINTZNt6WIxFEjCfo/0DE=;
	b=3Tw9TX1GO8XS/vDoexb96kYzF9CIO20Poc9D6Ugp3xR8PozcbzAQh07KIROjJFFB2TfsDH
	4cCsUB1X736qMoytldb9/JNdObaF4YU1d0lO6lOh+BcMJw9HTSMnR3VfqTKmqiAScsLMH8
	1ykjN0SU9WAJnVCr+XmTd6wQhJwA3fA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792593820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7paClLlEK0u0d6tYoqVOf1wINTZNt6WIxFEjCfo/0DE=;
	b=JMSWRxbVZEeZvpgm253YsQctmbqaX3YbaSCWJe0Gjd+HqBE65AnCkW3SDT1cch/Br1XA8P
	+TpIQvQoZvhaulDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 975FC134FD;
	Wed, 21 Oct 2026 14:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nEGHGZzP2Gq0YgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 14:43:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 25C1AA13C6; Wed, 21 Oct 2026 16:43:36 +0200 (CEST)
Date: Wed, 21 Oct 2026 16:43:36 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] fs: make freezing for suspend wait for superblocks
 being shut down
Message-ID: <7flacjipfmk454jglgktob4u2xxzgxjmnleyixqfjjndszpwqx@ezeufjuntr6f>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
 <20261021-b4-super-lock-dying-v1-2-2b35e86706ff@toxicpanda.com>
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
In-Reply-To: <20261021-b4-super-lock-dying-v1-2-2b35e86706ff@toxicpanda.com>
X-Rspamd-Queue-Id: C0B5921F3A
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
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,toxicpanda.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.01

On Wed 21-10-26 00:56:36, Josef Bacik wrote:
> filesystems_freeze() freezes the filesystems ahead of suspend and
> hibernation, so that none of them changes on disk behind the back of the
> memory image.  A superblock which is being unmounted can't be frozen, but
> get_active_super() sleeps on s_umount until generic_shutdown_super() is
> done with it, so it has stopped writing by the time the walk moves on.
> 
> That matters.  The freezer doesn't take care of it: the final mntput() of
> a kernel thread is handed to delayed_mntput_work, and the workqueue it
> runs on is not freezable.  Were the walk to skip the superblock, the
> hibernation image could be taken in the middle of that unmount, which then
> carries on after the image is written, and again from the middle after
> resume.
> 
> Wait for SB_DYING explicitly, ahead of super_lock() not sleeping on such a
> superblock any more.  Suspend goes ahead whether this task is killed or
> not, so this gets a wait of its own, super_wait_shutdown(), which can't be
> killed, as it can't be today.
> 
> For now SB_DYING is always set by the time super_lock() fails, so nothing
> changes yet.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index c33981d3f7c0..76101307da01 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -157,6 +157,20 @@ static int super_wait_shutdown_killable(struct super_block *sb)
>  	return wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DYING));
>  }
>  
> +/**
> + * super_wait_shutdown - wait for a superblock being shut down
> + * @sb: superblock super_lock() failed on
> + *
> + * For callers of which the rest happens whether they are killed or not, and
> + * must not happen while the filesystem is still being written out.
> + *
> + * The caller must have acquired a temporary reference on @sb->s_passive.
> + */
> +static void super_wait_shutdown(struct super_block *sb)
> +{
> +	wait_var_event(&sb->s_flags, super_flags(sb, SB_DYING));
> +}
> +
>  /* wait and try to acquire read-side of @sb->s_umount */
>  static inline bool super_lock_shared(struct super_block *sb)
>  {
> @@ -1294,8 +1308,11 @@ static void filesystems_freeze_callback(struct super_block *sb, void *freeze_all
>  	if (!freeze_all_ptr && !(sb->s_type->fs_flags & FS_POWER_FREEZE))
>  		return;
>  
> -	if (!get_active_super(sb))
> +	if (!get_active_super(sb)) {
> +		/* an unmount from a workqueue isn't stopped by the freezer */
> +		super_wait_shutdown(sb);
>  		return;
> +	}
>  
>  	if (sb->s_op->freeze_super)
>  		sb->s_op->freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
