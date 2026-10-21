Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597291;
	b=Xd//J/JqsqG0HebfvXAaRSWtnfvIF/IWHsp82yo9sNIFt6CHujnunFzjc6cqBgtcOwLf
	 piGdctYH4mSNk2xvauZe9cdC/PSwYWXBZHGAJKn4WeP88ydAj9/Yv9M7uk06L8lzA7ayU
	 HfWAFdEw5BpUS1Rl/Q2CP/dN73FDJe6IHEmINAVchSZW1LpHOZ1AElCA0hDAHbhhHLDAG
	 NuVvWYsdMQZRj1tFIcJnTopPNtVMnIUnOMYrgAWxZxTp7ktdeD0KueSSFEvBWnIzkVoDg
	 ZUF/8SBnposYdtdR/6e9oHxaekxhAVf+5HoEzuaKBorUhPuZd4uAMxpZQKmg87ZvMDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597291;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=PgcvyPwRypf4gzo0pCuokMQDtNAiht5wk85Jq1Ch7D0=;
	b=EZaQvHyn5qiD7Vs3BNKPQektZJSQu2KaFdQrPOsDoGhhXXwbw0mEs9UQsMpxztkmA3zA
	 1mYM4p9CHHFzAiFn+VMTo7P6ACMNpW7fwjiFnjb70yxl/70PjR6zAx24AkoCoqIiaTLEJ
	 2DZRdlQTNOXuFgbhY3ua9l6o2G6SJ6Vd4ftDUkRhvUmHza9cIHq1ilRfuPZegWGXmltd5
	 SFAETagcAt8lrSYyKjTgocsYDfdqINeK2itOH3qKcS1NacR635xS9/qQ5QGsL6ntyxA1f
	 aEGYtjoPS1F9pfVWpvKbYIupW8iODO5bFkpvyw3QjeHJjNwR04wbEOTLIH3ZEzqy6WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZUdAmFu1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BI5ORfBk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZUdAmFu1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BI5ORfBk;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B7606A319;
	Wed, 21 Oct 2026 15:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 429B7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZUdAmFu1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BI5ORfBk;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZUdAmFu1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BI5ORfBk
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7616021AFE;
	Wed, 21 Oct 2026 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792597288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgcvyPwRypf4gzo0pCuokMQDtNAiht5wk85Jq1Ch7D0=;
	b=ZUdAmFu1/+Q59ylWeQZqUyleOv4BBwTCzw3jhkzkACqm9RY8Za5zR4E1i7n5B/75oc/yOz
	qsvs+5Kef61Wrc4cBDapM8nGEeMu6LTmTVXf0k7s60U87x80t55CVsRjJNVZgMZrk6R6Lj
	MCTjADs3dpZo5YXPWzspbqliRrg51J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792597288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgcvyPwRypf4gzo0pCuokMQDtNAiht5wk85Jq1Ch7D0=;
	b=BI5ORfBk1ivVMitHb8ukDjoQbcVmqAYr2TLEEidi0LL4dnaUazD6mxL52LaDrSZHAsjf8e
	krN9TYFAh+avoyCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZUdAmFu1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BI5ORfBk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792597288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgcvyPwRypf4gzo0pCuokMQDtNAiht5wk85Jq1Ch7D0=;
	b=ZUdAmFu1/+Q59ylWeQZqUyleOv4BBwTCzw3jhkzkACqm9RY8Za5zR4E1i7n5B/75oc/yOz
	qsvs+5Kef61Wrc4cBDapM8nGEeMu6LTmTVXf0k7s60U87x80t55CVsRjJNVZgMZrk6R6Lj
	MCTjADs3dpZo5YXPWzspbqliRrg51J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792597288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgcvyPwRypf4gzo0pCuokMQDtNAiht5wk85Jq1Ch7D0=;
	b=BI5ORfBk1ivVMitHb8ukDjoQbcVmqAYr2TLEEidi0LL4dnaUazD6mxL52LaDrSZHAsjf8e
	krN9TYFAh+avoyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45BAA134A5;
	Wed, 21 Oct 2026 15:41:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e+rACCjd2GqCIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 15:41:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C625EA1418; Wed, 21 Oct 2026 17:41:27 +0200 (CEST)
Date: Wed, 21 Oct 2026 17:41:27 +0200
From: Jan Kara <jack@suse.cz>
To: YouYou Yu <youyouyu@amazon.com>
Cc: jack@suse.cz, brauner@kernel.org, dgj@amazon.com, gunnarku@amazon.com, 
	lichliu@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] quota: initialize dquot cache before mounting rootfs
Message-ID: <xunj5l4iycoaakuvstnshjzf7c7p7jlntg7ndjf4iaj45eukb4@3dld5dfexifh>
References: <4x3ngu2v723xnbommkln6yjwj27qdiy53dphxp74thsbihfqcr@rehvrhj7egvk>
 <20261020215229.31406-1-youyouyu@amazon.com>
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
In-Reply-To: <20261020215229.31406-1-youyouyu@amazon.com>
X-Rspamd-Queue-Id: 7616021AFE
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
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.01

Hi!

On Tue 20-10-26 21:52:29, YouYou Yu wrote:
> On Mon, 19 Oct 2026 12:44:49 +0200, Jan Kara wrote:
> > I definitely don't think anybody sane wants quotas on initramfs. Is this
> > just a fuzzing result or are you really interested in that functionality?
> 
> The truth is it's not a fuzzing result, we are really interested in it.
> We run systems that extensively use rootfs and we want to limit per user
> usage on it the same way tmpfs quotas allow on any other tmpfs mount.

OK, please make the fact that you have this usecase explicit in the
changelog.

> > Instead of pulling quota into early boot I'd just refuse tmpfs mount in
> > this case (same result as original behavior but clearer error message :)).
> 
> Refusing the mount would avoid the crash, but rootfs would then be
> the only tmpfs instance where quotas can't be used, even though
> initramfs_options= exists to pass mount options to it. That said, if
> initializing this earlier is a concern, I'm happy to rework the patch
> if you have a preferred approach.

No, the patch was actually good. I just didn't want to add complexity just
because fuzzer was able to come up with some insanity. If you have a real
use for it, I'm OK with the change. I'll take it through my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
