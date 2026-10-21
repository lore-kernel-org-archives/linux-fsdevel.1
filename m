Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594143;
	b=e5CPyx1th2cz1cp9n1Ss5GiucAADOoJPGQhEuZ8E2jaiJ5NQowHzwLnKfZKVLGn9qbpf
	 1kyZdtLy07XXZSpgW+/CJ8SATq3e83LkomJZOG2+49+LUIYz7yANdCWHJ88Ed6V/94ZY8
	 9i0jvcNyMo2atH9FfCrm/Q1EZGBu3xPowe1GSylUELSs0jgURqj0guW2YxWkPGiNBKsrK
	 DONFJc9Z1hvfk7o45U6Pf59i563juzwTb5GxwU/6onyHX444dfNHr8oflXltpoIXtj2ya
	 iaeMKx9ZRQn/wvRJRIFAnlfIn9zvJgwonMVIQqb9KKmYNDBrU3gMYZyHkA/V/AYO11A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594143;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=0FQjjH/1NaNGWFHzrSCjGz72MzCZ8wWJp/PHZdLvZfs=;
	b=mwOn/zjFJOq+CbmexC1GYB0ZaZYomvfyRSMCARR+K/yZ7X8TgiPe/qpPjg0O20oFfAgx
	 2XAk2lWQlVkd+09bhs1amUT2r63TywFCBbK0UjRgcS7l0qU4K9kBORTkd0g/TAFS1Be9v
	 UA4PJ+VD7IoBQVgAKvgYMd8A9wcxJS3SxDDkw+R1vXOoLvz5uIFbIGIM32IuFKHE4ReG5
	 qLJU15TE83E2LozqPcy5k1R6yleMV0KdQ59FYOhBNQX4OnS/tZMkzVbom5RsPcJWJIYMq
	 Y1QsLFTbFP82C57SSLgT+Oex1UHGWKZTNudRwH2mcqtmyyR5YxYyRIIJYJZn0tVjjkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=rtzPfR9F;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="454jNR/Q";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=rtzPfR9F;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="454jNR/Q";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E007606A31D;
	Wed, 21 Oct 2026 14:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E007606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=rtzPfR9F;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=454jNR/Q;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=rtzPfR9F;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=454jNR/Q
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79FD121F56;
	Wed, 21 Oct 2026 14:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792594141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FQjjH/1NaNGWFHzrSCjGz72MzCZ8wWJp/PHZdLvZfs=;
	b=rtzPfR9FePJ2r47F+PveX4OIB1+IorVJrjSSg4SQOcbcOHv3PeVsGxFQqvDsctBcoCyuy0
	haAzfqoH84QIojIHDqVKQHb2KauK4D8C0pWlHm59DPwMhxcdjYRqoZj4M6o4DlCdcaZ2LO
	BykU3yYd/Rjr6Y0t6vzBWdGYZ1LRyVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792594141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FQjjH/1NaNGWFHzrSCjGz72MzCZ8wWJp/PHZdLvZfs=;
	b=454jNR/QIWfKtrJftZjcGeT+gHPE9J8y3eTp31V0SB0I/fDprjIPCLuvLlCQwCEcemDBUH
	mrkMQQxvpykXPZBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792594141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FQjjH/1NaNGWFHzrSCjGz72MzCZ8wWJp/PHZdLvZfs=;
	b=rtzPfR9FePJ2r47F+PveX4OIB1+IorVJrjSSg4SQOcbcOHv3PeVsGxFQqvDsctBcoCyuy0
	haAzfqoH84QIojIHDqVKQHb2KauK4D8C0pWlHm59DPwMhxcdjYRqoZj4M6o4DlCdcaZ2LO
	BykU3yYd/Rjr6Y0t6vzBWdGYZ1LRyVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792594141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FQjjH/1NaNGWFHzrSCjGz72MzCZ8wWJp/PHZdLvZfs=;
	b=454jNR/QIWfKtrJftZjcGeT+gHPE9J8y3eTp31V0SB0I/fDprjIPCLuvLlCQwCEcemDBUH
	mrkMQQxvpykXPZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 504D7134A5;
	Wed, 21 Oct 2026 14:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XQOrC93Q2GquaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 14:49:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D10A2A13C6; Wed, 21 Oct 2026 16:49:00 +0200 (CEST)
Date: Wed, 21 Oct 2026 16:49:00 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: make the block device callbacks wait for
 superblocks being shut down
Message-ID: <36qz7ogt6fkjcmiujvt5rsn3t47bhsnh2g5sinthabwakajvw6@l6hmukz4h66v>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
 <20261021-b4-super-lock-dying-v1-3-2b35e86706ff@toxicpanda.com>
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
In-Reply-To: <20261021-b4-super-lock-dying-v1-3-2b35e86706ff@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,toxicpanda.com:email]
X-Spam-Score: -12.80

On Wed 21-10-26 00:56:37, Josef Bacik wrote:
> Three of the callbacks the block layer has into the filesystem using a
> device rely on super_lock() sleeping on s_umount until an unmount is done,
> in the same unspoken way as sync(2) and freezing for suspend:
> 
>  - fs_bdev_sync() is there to get the filesystem onto the device.  While it
>    is being unmounted, the unmount is what does that.
> 
>  - fs_bdev_freeze() promises that nothing writes to the device once it has
>    returned.  An unmount writes to it until ->put_super() is done.
> 
>  - fs_bdev_mark_dead() without @surprise is an orderly removal, which syncs
>    the filesystem before the device goes away.  Going ahead while an
>    unmount is still writing would lose what it hasn't written yet.
> 
> Have them wait for SB_DYING when the superblock turns out to be going
> away, ahead of super_lock() not sleeping on such a superblock any more.
> With @surprise the device is gone already and there is nothing to wait
> for.
> 
> Only fs_bdev_sync() can be killed while it waits.  Its one caller is
> BLKFLSBUF, and all that does afterwards is invalidate_bdev(), which leaves
> dirty pages and pages under writeback alone.
> 
> The other two use super_wait_shutdown() and can't be killed, as they can't
> be today.  Killing the task doesn't call off the removal of the
> device, it would only make it overtake the unmount.  fs_bdev_freeze() could
> return an error, but by then it may have frozen other superblocks on the
> device, which its caller doesn't thaw on failure.
> 
> For now SB_DYING is always set by the time super_lock() fails, so nothing
> changes yet.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 76101307da01..9baaaa3256b2 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1572,8 +1572,12 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
>  		struct super_block *sb = sb_dev->sd_sb;
>  
> -		if (!super_lock_shared(sb))
> +		if (!super_lock_shared(sb)) {
> +			/* don't take the device away from under an unmount */
> +			if (!surprise)
> +				super_wait_shutdown(sb);
>  			continue;
> +		}
>  		if (sb->s_root && (sb->s_flags & SB_ACTIVE)) {
>  			if (!sb->s_op->remove_bdev ||
>  			    sb->s_op->remove_bdev(sb, bdev)) {
> @@ -1599,8 +1603,13 @@ static void fs_bdev_sync(struct block_device *bdev)
>  	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
>  		struct super_block *sb = sb_dev->sd_sb;
>  
> -		if (!super_lock_shared(sb))
> +		if (!super_lock_shared(sb)) {
> +			if (super_wait_shutdown_killable(sb)) {
> +				super_dev_put(sb_dev);
> +				return;
> +			}
>  			continue;
> +		}
>  		if (sb->s_root && (sb->s_flags & SB_ACTIVE))
>  			sync_filesystem(sb);
>  		super_unlock_shared(sb);
> @@ -1631,8 +1640,11 @@ static int fs_bdev_freeze(struct block_device *bdev)
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
>  	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
> -		if (!get_active_super(sb_dev->sd_sb))
> +		if (!get_active_super(sb_dev->sd_sb)) {
> +			/* an unmount writes to the device until it is done */
> +			super_wait_shutdown(sb_dev->sd_sb);
>  			continue;
> +		}
>  		err = fs_super_freeze(sb_dev->sd_sb);
>  		if (err && !error)
>  			error = err;
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
