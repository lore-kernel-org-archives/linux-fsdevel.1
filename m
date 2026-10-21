Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595002;
	b=EbBAMMepE9m3fzL6rCAqLmXTGSpSYmvo2x6xJ2M4SQxer683Z1m8Ow1e8z3PK0foMjBQ
	 67GumgZAlsaNk15ILiYGBE9zp1MeZBR+Rx9Nh9ujb7zPuykbp1wzr8VS5PivqpEoFVBar
	 +FXN0xRM1ncUwKn4NSdylSER3JYY1aPWQJkYZoKOBL+XXD5Xgy/Yvl/5KAR5+sFwgzpmH
	 S4RGSOPl3YcdB54xpqn9pyZRYjERe0GyLl08G3EL9nyAu3n+4YOMZaQC88Z/MdqLu5DM8
	 KeWvIhoG/f0w9robs/gSbBJe44ElsMVkOUrscU6LwBVjPXgxQYBswlLdp42U5fDBdJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595002;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=GxeHVT2qL6sGRauX1063cDj44dMqPtepnr8lk8BOP1U=;
	b=fIAjl31JSLzBiT1dbQLaRtQQyZZVEx58iSQ+VeItTaQOMwy5oUvJYiiBSTn8IOg99DWS
	 wU5GcsJENdUlGfV61+1a3aeRDa7cJAQDY/EpAV+w7QotJnA8q1pgyrQsJ9h5fMyhB1rmo
	 kZBSF/sHtc/f7uItRy+i27ct/wwiEcDIeQhqt/cdCf04fyNxJJLYCgjpQ2noWRXJc63KD
	 6UH1Bp1b+q7hRwV3X4Z8f7MX6TBEKTsMBKp4ObX9ow1HCHAnl2cOF5DKYu66Yh/gJv2t3
	 0RPwBe6b0UzOL6TuO/yqsrdcLPbnnzVG21Cc9cCquBi9kveM1OHF0SlBlKO2QjtH41A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NsyeGYvZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="WkEjL+/F";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NsyeGYvZ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="WkEjL+/F";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F009606A319;
	Wed, 21 Oct 2026 15:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F009606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NsyeGYvZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WkEjL+/F;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NsyeGYvZ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WkEjL+/F
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C29D11FAB6;
	Wed, 21 Oct 2026 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792594999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GxeHVT2qL6sGRauX1063cDj44dMqPtepnr8lk8BOP1U=;
	b=NsyeGYvZgXGRuSzTYFo6f7/4ZEAoE35zzAVXVeL8Z+4CA+uwuMlB9S6DG9twr/ufPzCgT7
	4+mYaRa7H7kanVNXIj2338pLTfL5AmhTVVzINE+NHQ7OtpLpciwR4NXzSKRVCFAKy3xwT4
	b11QQHX1YYdAjQCwaDyndsgmTKcPmc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792594999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GxeHVT2qL6sGRauX1063cDj44dMqPtepnr8lk8BOP1U=;
	b=WkEjL+/F/uB0cunI/gv/AUmolfNRDua1+0eh+Qp84i5BMpuAzAu6wA5aEOgz4GJ+Tr0v+2
	xlz1L4mPYeglq5CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NsyeGYvZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="WkEjL+/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792594999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GxeHVT2qL6sGRauX1063cDj44dMqPtepnr8lk8BOP1U=;
	b=NsyeGYvZgXGRuSzTYFo6f7/4ZEAoE35zzAVXVeL8Z+4CA+uwuMlB9S6DG9twr/ufPzCgT7
	4+mYaRa7H7kanVNXIj2338pLTfL5AmhTVVzINE+NHQ7OtpLpciwR4NXzSKRVCFAKy3xwT4
	b11QQHX1YYdAjQCwaDyndsgmTKcPmc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792594999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GxeHVT2qL6sGRauX1063cDj44dMqPtepnr8lk8BOP1U=;
	b=WkEjL+/F/uB0cunI/gv/AUmolfNRDua1+0eh+Qp84i5BMpuAzAu6wA5aEOgz4GJ+Tr0v+2
	xlz1L4mPYeglq5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97F0E134A5;
	Wed, 21 Oct 2026 15:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QaLlHDfU2Gq+dwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 15:03:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 22A10A13C6; Wed, 21 Oct 2026 17:03:19 +0200 (CEST)
Date: Wed, 21 Oct 2026 17:03:19 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: let a mount waiting for the old superblock to
 die be killed
Message-ID: <mti6fpzjrw7xjvzn7j6cdoljtjpltuzdr4x6l7uvldiv6pe3rr@i6bplnpyrqsz>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
 <20261021-b4-super-lock-dying-v1-5-2b35e86706ff@toxicpanda.com>
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
In-Reply-To: <20261021-b4-super-lock-dying-v1-5-2b35e86706ff@toxicpanda.com>
X-Rspamd-Queue-Id: C29D11FAB6
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
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

On Wed 21-10-26 00:56:39, Josef Bacik wrote:
> When sget_fc() finds a superblock for what is being mounted and that
> superblock is being shut down, grab_super() waits for SB_DEAD and sget_fc()
> then looks again.  This one does have to wait: the old superblock owns the
> device until ->kill_sb() is done with it.
> 
> It doesn't have to be uninterruptible though.  If the unmount is stuck, so
> is every attempt to mount that device again, and none of them can be
> killed.  mount(2) and fsconfig(2) can fail at this point, nothing has been
> set up yet apart from a spare superblock which sget_fc() frees on its
> other ways out as well.
> 
> Make the wait killable.  grab_super() now has three outcomes, so have it
> return 0, -EAGAIN for "look again", or the error from the wait.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 9f76b399f3fb..36fdf88ef88e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -673,12 +673,14 @@ EXPORT_SYMBOL(deactivate_super);
>   * superblock to either become SB_BORN or for it to pass through
>   * sb->kill() and be marked as SB_DEAD.
>   *
> - * Return: This returns true if an active reference could be acquired,
> - *         false if not.
> + * Return: 0 if an active reference could be acquired, -EAGAIN if the
> + *         superblock is gone and the caller should look again,
> + *         -ERESTARTSYS if the task was killed while waiting for that.
>   */
> -static bool grab_super(struct super_block *sb)
> +static int grab_super(struct super_block *sb)
>  {
>  	bool locked;
> +	int ret;
>  
>  	refcount_inc(&sb->s_passive);
>  	spin_unlock(&sb_lock);
> @@ -686,13 +688,13 @@ static bool grab_super(struct super_block *sb)
>  	if (locked) {
>  		if (atomic_inc_not_zero(&sb->s_active)) {
>  			put_super(sb);
> -			return true;
> +			return 0;
>  		}
>  		super_unlock_excl(sb);
>  	}
> -	wait_var_event(&sb->s_flags, super_flags(sb, SB_DEAD));
> +	ret = wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DEAD));
>  	put_super(sb);
> -	return false;
> +	return ret ? ret : -EAGAIN;
>  }
>  
>  /*
> @@ -960,9 +962,12 @@ struct super_block *sget_fc(struct fs_context *fc,
>  			warnfc(fc, "reusing existing filesystem in another namespace not allowed");
>  		return ERR_PTR(-EBUSY);
>  	}
> -	if (!grab_super(old))
> +	err = grab_super(old);
> +	if (err == -EAGAIN)
>  		goto retry;
>  	destroy_unused_super(s);
> +	if (err)
> +		return ERR_PTR(err);
>  	return old;
>  }
>  EXPORT_SYMBOL(sget_fc);
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
