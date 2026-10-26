Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018386;
	b=ItQC79zZ9VNUdW/IcV3B32ErBpUEs1/lXUC0Q2mE6x5L6pqmexEz8hOATg8HGrRMUrWf
	 fzF4Hr958BEnBUqwIZrsb0wvAfiU8/dzFJYTkkZvLxBeqWIgomQH9m0yE+6hrGI70vHIK
	 T7idnz3UXkRE9fQV6MsZh/zqlr5aOlvfwNZuUtIZ/tht2Wdxzg5EGu7eLqZXUsPdB0dd9
	 QgYacha22et1MXuWNmETud3WwZkeYEzBBHv3XJsekWBfuExjV+FTjbdwCrWUHndLCvKwQ
	 b1QwmTkVR5Qs60WV9MR5PW2a8J0rLXwCcNAQJyMiU2snh5QopSVOHxSgaBAGYnr+Zxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018386;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=NGOYvwWXtHCtXAoCdL/2EsRICoNUM1uFaxEPB0yTgrg=;
	b=osellOhcQxVfV8CAob7Tkac9CrCdi9BjvIztYXW34hZyDPGTA4MgMvc7VPdDqjoh5309
	 G0mDhTrIeNZj8Ij7c9YkZB0LtOo0iapZDNLwCHbnuTbCFwMoJTutmMMd7IdDZmDQU2WL1
	 hwayQ720t2DwqkIN1JdzjmsbgkTiuBxZkCHac0J6d5T0Sz5/fMd6Pip5e19bK5C2HNpMr
	 10qTHp15eNh+WzR3AzwUkRVrDwy0d2Qt7/8wLylp2xV2iRZfvOL2+eHhMmBMnXN+uAAF/
	 WUUbNwX/FM55M50qtFrTcp3hw2STW6sfncSvnl+wowzsEfnntBcuSdkmpin6X5oeQUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="i/Qotwak";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NPbnbhH1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UyBkdwTm;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/jbCXYqr";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD347606A31A;
	Mon, 26 Oct 2026 12:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD347606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=i/Qotwak;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NPbnbhH1;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UyBkdwTm;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/jbCXYqr
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D8631F807;
	Mon, 26 Oct 2026 12:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NGOYvwWXtHCtXAoCdL/2EsRICoNUM1uFaxEPB0yTgrg=;
	b=i/QotwakT0gNRHREU1wFt/wueTqEGMxkEwBZeAfvtg2vOQK5MYdjocpFukd6OPnCPB/HBb
	BS0H0i4lis8Cx5HxUegab52ZMYIDulElTF5aTBb4Hap0VclwXxLjUKay5gMGoKDFBAw/gO
	anMbeiMRLXl/qiNjvli9BmC5o5g5fSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NGOYvwWXtHCtXAoCdL/2EsRICoNUM1uFaxEPB0yTgrg=;
	b=NPbnbhH1+/ni7hIQiLvEz0Rw5mCTPrjqGt7I2H76ldS/ThhDXfkF8lfkKoBLAi7flQa7sI
	AFYw0bBdP9G4PIBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NGOYvwWXtHCtXAoCdL/2EsRICoNUM1uFaxEPB0yTgrg=;
	b=UyBkdwTm5idr9gRs92m2eXllZTQxCYHgb6mSyGPn3DAQii7ZPZorI6hRb5yz437E6K8JRt
	9pOQjbje6tYo+E1xUamu/s+LJWs2gVfm2XsRkhf8at6dGKTDCHLAc33wjhqLyl1FQZJ5Tu
	RVFUKsWGY9W3ynWQXI3luWhJsu7g258=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NGOYvwWXtHCtXAoCdL/2EsRICoNUM1uFaxEPB0yTgrg=;
	b=/jbCXYqrtbqaIP7dJVxN5S4mQ57yZnFtClcNfpzjJKt3CjU7A46+Pv9vRDGjctpBpT3HIY
	FqElgoIqGoH83JAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E89A713319;
	Mon, 26 Oct 2026 12:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 39IFMQxK32qJQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 12:39:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7EA71A1419; Mon, 26 Oct 2026 13:39:40 +0100 (CET)
Date: Mon, 26 Oct 2026 13:39:40 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: make mount(2) remounts killable on s_umount
Message-ID: <3x3n2vfnyy3nmhz3rd56q6ygm72252gy26lxrf2kmhdrxg7f5d@q56ow6psbtpb>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
 <20261023-b4-s-umount-killable-v1-3-844a341ff1df@toxicpanda.com>
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
In-Reply-To: <20261023-b4-s-umount-killable-v1-3-844a341ff1df@toxicpanda.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,toxicpanda.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 23-10-26 20:39:32, Josef Bacik wrote:
> mount(2) with MS_REMOUNT takes s_umount exclusively, with MS_BIND as well
> it takes it shared.  If the lock is held for a long time, by a syncfs(2) on
> a device which doesn't answer say, the remount sits in D state and can't be
> killed.
> 
> The one which wants the lock exclusively makes matters worse for everybody
> else: while it is queued, every new reader of s_umount queues up behind it.
> Killing it gets it out of the way, the rwsem wakes those behind a waiter
> which gives up.
> 
> Nothing has been changed yet when the lock is taken, and both can fail.
> Use the killable variants.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e5feb4e48290..837f531e494b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3485,7 +3485,9 @@ static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
>  	 * We're only checking whether the superblock is read-only not
>  	 * changing it, so only take down_read(&sb->s_umount).
>  	 */
> -	down_read(&sb->s_umount);
> +	ret = down_read_killable(&sb->s_umount);
> +	if (ret)
> +		return ret;
>  	lock_mount_hash();
>  	ret = change_mount_ro_state(mnt, mnt_flags);
>  	if (ret == 0)
> @@ -3531,8 +3533,9 @@ static int do_remount(const struct path *path, int sb_flags,
>  	fc->oldapi = true;
>  
>  	err = parse_monolithic_mount_data(fc, data);
> +	if (!err)
> +		err = down_write_killable(&sb->s_umount);
>  	if (!err) {
> -		down_write(&sb->s_umount);
>  		err = -EPERM;
>  		if (ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
>  			err = reconfigure_super(fc);
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
