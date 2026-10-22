Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669910;
	b=NbQtCWH0WHFr1CyS3Ky12Xo4dm7vb5GC5keVdoG7SAL2kMeCuAlt/WJ+rhiATpLZaYw2
	 nHZSSNpfCqvzwdqFQZI3tj9uQHOrrfUkEncjfi8d2TAplz2EELr46Z/NuxP4F415bxpMs
	 BUJoT/oZv2amCLFAajDMMsIRAuz4MsWUt9tOSah2iMUOdBxIfi8iCV3dX4tc9nwQ6u3PZ
	 RlzURPousTsnn6hMBNEJ51elbPnSo4dKdLZM14Tce/jFWppMRhbipfX0k5NY42Egqcj8f
	 Kp9KdvgiNB5Hf5ItE/JPty87Y8wUhCVnpvx2vreAA8wLy7B4IKVnDeuN6WO4umEVO2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669910;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=CcMtzXV2Q8QoG5e/gEZ6v0nstf58huEIMEd8B3QCXD0=;
	b=4eR399ZiHCVwRuuf1MRYwr5LV/2M2h6FVN172E+mk5108iMUH+eZ9XRcQYlGeqJdh6gF
	 fNOO2twD28k13poHeNlqR6dSfshanqygb/n1ZuyxPSzOnUZQQGnywoMkUu/AbysPEkaCL
	 L+hVwci6jpb5EeG2DykC0dHGXkNt3qjTD45nnk4AtLaIBiZ8OA9K/KY4LL7WipcHoTwU+
	 fLhWjUFZclw0GdHYXkc2jPNPt1xh/g3tuiqMzhRvCgIVlIP7PxAxFsAeNdS55WHtlaUPW
	 nQEc+j724FJBzMn5TVUEh3EG1Da9wqD7T4MrRslS9RjQxt8+4ps5hjGmVcz5jy6Bw2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gJGkUhZp;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DFOFpeSA;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Sl6g4Fup;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sKkxGY8r;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0485606A323;
	Thu, 22 Oct 2026 11:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0485606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gJGkUhZp;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DFOFpeSA;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Sl6g4Fup;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sKkxGY8r
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E55D51F7C4;
	Thu, 22 Oct 2026 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792669908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcMtzXV2Q8QoG5e/gEZ6v0nstf58huEIMEd8B3QCXD0=;
	b=gJGkUhZpuBlDUNvFW5Knax/qK0O0bKiyggnPb5ybcEROISMFjwPBt30AN7SSiY6XvCbms4
	o6A/Um9BvNxKdAFTfltwAPWNknxtIqiNeN67s2HjsPkhQ2km8rGomu4rutFCVbGF2NrFKF
	anpNO6c3gH2sv4wCXSqRlTSKRE0h6eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792669908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcMtzXV2Q8QoG5e/gEZ6v0nstf58huEIMEd8B3QCXD0=;
	b=DFOFpeSAF2bqNptuIe7wuHBsszRyVj9FbkXAtXcLyel1yq5WwsNOY1+9JtdtKyMANHDUF6
	5jGOkXFpCEuXLZCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792669907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcMtzXV2Q8QoG5e/gEZ6v0nstf58huEIMEd8B3QCXD0=;
	b=Sl6g4Fupis7hxr0w9WV74GNIL/4Kd5RvIBH2TtOrFvqXOccBHoa6s/CIP169nOP+jLa/xT
	TsH1NrMNdPu3Qzam7K+pInH0EM+/G54oPO4sBBQERZs48T8Bq+vBom+N4IvD8x5KSXq1+s
	gwnTB1r9L3T+ahXigIDNN+yG8qEVErA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792669907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcMtzXV2Q8QoG5e/gEZ6v0nstf58huEIMEd8B3QCXD0=;
	b=sKkxGY8rg15QiTMH5pnnI1KFgb7JeIEi2WQUaCtvAM0hPNt6kHNe7W2ebnzZdchFeQtXl+
	fhf6cIS1fy7gQ4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7F2D133F3;
	Thu, 22 Oct 2026 11:51:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fOX9KdP42WqdBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 11:51:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5DF29A1417; Thu, 22 Oct 2026 13:51:43 +0200 (CEST)
Date: Thu, 22 Oct 2026 13:51:43 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: make BLKFLSBUF's wait for a superblock killable
Message-ID: <ly27r66db2a4yxpg57sjnshen4dxygc5nkkofmdflvnrht7spx@zuutwesrz5go>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
 <20261021-b4-super-lock-unborn-v1-3-0265eddb6dee@toxicpanda.com>
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
In-Reply-To: <20261021-b4-super-lock-unborn-v1-3-0265eddb6dee@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,toxicpanda.com:email,suse.com:email]
X-Spam-Score: -12.80

On Wed 21-10-26 16:46:59, Josef Bacik wrote:
> fs_bdev_sync() syncs the filesystems on a block device for BLKFLSBUF.  It
> can already be killed while it waits for one which is being unmounted.  For
> one which is still being mounted it waits for SB_BORN, and then for
> s_umount, in super_lock(), which can't be killed.  If the mount is stuck on
> that very device, so is the ioctl.
> 
> Use super_lock_killable() and stop the walk when the task is killed, as for
> the unmount.  All BLKFLSBUF does afterwards is invalidate_bdev(), which
> leaves dirty pages and pages under writeback alone.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Christian has just pulled some changes in this area so please rebase on top
of them. Otherwise the changes look ok to me.

								Honza

> ---
>  fs/super.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 40f92ffa39c1..ecba64ed0c2a 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1676,17 +1676,21 @@ static void fs_bdev_sync(struct block_device *bdev)
>  
>  	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
>  		struct super_block *sb = sb_dev->sd_sb;
> +		int ret;
>  
> -		if (!super_lock_shared(sb)) {
> -			if (super_wait_shutdown_killable(sb)) {
> -				super_dev_put(sb_dev);
> -				return;
> -			}
> +		ret = super_lock_killable(sb, false);
> +		if (!ret) {
> +			if (sb->s_root && (sb->s_flags & SB_ACTIVE))
> +				sync_filesystem(sb);
> +			super_unlock_shared(sb);
>  			continue;
>  		}
> -		if (sb->s_root && (sb->s_flags & SB_ACTIVE))
> -			sync_filesystem(sb);
> -		super_unlock_shared(sb);
> +		if (ret == -ENOENT)
> +			ret = super_wait_shutdown_killable(sb);
> +		if (ret) {
> +			super_dev_put(sb_dev);
> +			return;
> +		}
>  	}
>  }
>  
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
