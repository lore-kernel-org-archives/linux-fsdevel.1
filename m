Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103504;
	b=FMJNoHFE+mgCdI5E3xS2KDaemqcOu+ZuSHXvmuQiKIlfYxKX+bhV1g8niGc40qjeYgZ4
	 PLoy1BV8W+lCJr/Ie00bP5UdD73/Aq1z8F2qqQPhEAdRdkvVrJa95pQ5xRHEUGycG3IbN
	 RXjBscnRup7dd2oEGOB2k1nK/8SU7eKrPj21RBrVFb5gfo5+QJrxnTuuqjt+QRXr7+3rs
	 BqO0Kzq7+oErGhZissBbyiiWdlSTH+XvmL7lsk1/nU/gzvo5QWq5e+Qdkh06m1NpyytCC
	 Fl0nUldZkzkvgCCYKeP0E+zPI0sH5LFCk5aVSm74bgEKa6rm8SJGOwHPU1+XA7x6eFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103504;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=PDKPE1DY4rH3zqXOGpxZjcDadnBXMru7fQiU3DWYkZQ=;
	b=HjW1n9BssM11wcSnAfIaZzP5M0rtJpAZkXsjIuRejoGPnKP07JMgfCBtW+Ze02Ctnka/
	 z1T32FOdpju1VjEbDTRTwEqbikR6GxvsZDQd6Dsv/sbUq64I5PZ7wXucJRaYUcDTvaRVR
	 Vtg8AbkDPV8dybxlil5/M300fBMJ3INsmr7A1tlO1OcmoKgX+C5JbBM85n/ylcp2ZqG4e
	 X3omv+EE4NapxQ+ZvrRzB1lf8EeGYI4t6e1VA+HPg4LfWNwO0wVrlIxOsoLdfQ3CokVjC
	 Jx2A9AtaxcUG88YHq5yWi3XODbGc8UaZHgNeJhXyDnhAyFU3416FG+32kmbyG/ylQEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=g7Ibpv6B;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nVInDUJg;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JSzPA2tX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xmGj1+R7;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8553606A31A;
	Tue, 27 Oct 2026 12:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8553606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=g7Ibpv6B;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nVInDUJg;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JSzPA2tX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xmGj1+R7
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B42BF1F7BE;
	Tue, 27 Oct 2026 12:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793103501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDKPE1DY4rH3zqXOGpxZjcDadnBXMru7fQiU3DWYkZQ=;
	b=g7Ibpv6B84sstM7I/79yQ+rlnikVcDxn9Z5abKeg9i74awwyWyymesqZoid6Uwy9/1lxI5
	4TwztHSU3LV7ydiscMf5ESkXJ5XT0sJnwDKOZBEzxhlSdLHdQ/mn1UkkrA0sY6alFk3qos
	WkwtX+FdR0//bCFpGSoISHQyYx9HfLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793103501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDKPE1DY4rH3zqXOGpxZjcDadnBXMru7fQiU3DWYkZQ=;
	b=nVInDUJggYLCLbDRHYYsRMbO1x+AOVoKrdg0w6wowrIravKKS1DD0LwPj/N/hdC52OvETO
	c9VDQe8gZLF4fqDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JSzPA2tX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xmGj1+R7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793103500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDKPE1DY4rH3zqXOGpxZjcDadnBXMru7fQiU3DWYkZQ=;
	b=JSzPA2tX8PYYltEI9WbXOazkPLv6rb+rIrCFid9Wnd+nyNjqbVugILUI7ObmOiICofwGT4
	rgXh9yBS53OmFVZ5vvUSRO7uUKXDtugAPdSpRpxnfzg2u246LM4cwo5+DAe5dPruDYw92i
	kA9MPuFDywGLerXFHZj/0iTIkaeNuss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793103500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDKPE1DY4rH3zqXOGpxZjcDadnBXMru7fQiU3DWYkZQ=;
	b=xmGj1+R79hNqFuB8nfpVJtCUhw40zo+0yC8Y5uBLsU4LZnM9oq+QP/kmryQBokIdj49bqf
	p66WsENkV6pp8iAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 818C51321C;
	Tue, 27 Oct 2026 12:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OZ+fFoyW4GppAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Oct 2026 12:18:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 21F51A133E; Tue, 27 Oct 2026 13:18:16 +0100 (CET)
Date: Tue, 27 Oct 2026 13:18:16 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] super: make sync(2)'s wait for s_umount killable
Message-ID: <iuzzutvgk7rzto25mdmbsooewnacir5y2gu2ghvcwqcwuox2n6@7elbvcvbrzws>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
 <20261023-work-super-lock_helpers-v1-4-d0fcb3f2f275@kernel.org>
 <tqgqwii6it4zxhtsfgnkri2mppbcijvsdnywrsbsyrsc3ey6w5@ts5aqmpikwyv>
 <20261027-spargel-laterne-verirren-9d984ac342d4@brauner>
 <20261027-wedel-lenken-seehund-d85c9ba29aa9@brauner>
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
In-Reply-To: <20261027-wedel-lenken-seehund-d85c9ba29aa9@brauner>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: B42BF1F7BE

On Tue 27-10-26 11:13:09, Christian Brauner wrote:
> On Tue, Oct 27, 2026 at 09:11:42AM +0100, Christian Brauner wrote:
> > On Mon, Oct 26, 2026 at 01:02:46PM +0100, Jan Kara wrote:
> > > On Fri 23-10-26 11:41:04, Christian Brauner wrote:
> > > > iterate_supers_sync() waits killably for a superblock that's being shut
> > > > down, but it takes s_umount of a live superblock uninterruptibly. So a
> > > > freeze_super() or remount that's stuck under s_umount, in
> > > > sync_filesystem() or ->freeze_fs() say, still hangs every sync(2) on
> > > > the machine without anyone being able to kill it.
> > > > 
> > > > That's inconsistent with fs_bdev_sync() which already uses a killable
> > > > super_lock() for both waits. And the reasoning is the same: if the task
> > > > is killed the walk stops and ksys_sync() returns, there's nobody left to
> > > > make a promise to. The emergency sync and the sync before suspend and
> > > > hibernation run from a workqueue where that can't happen. The PROM sync
> > > > on sparc32 runs in whatever task it interrupted but that one could
> > > > already be cut short while it waited for a superblock being shut down.
> > > > 
> > > > Let __iterate_supers() pass SUPER_LOCK_KILLABLE together with
> > > > SUPER_LOCK_WAIT_SHUTDOWN for SUPER_ITER_WAIT_SHUTDOWN. Only
> > > > iterate_supers_sync() passes that flag.
> > > 
> > > This might get surprising in the future, I guess SUPER_ITER_KILLABLE flag
> > > might be a more explicit way to control this but I can live with what we
> > > have now.
> > 
> > I think you're right I'll fix that up in-tree.
> 
> I've folded:

Thanks!

								Honza

> 
> diff --git a/fs/super.c b/fs/super.c
> index aff2169ca94d..cd6f57ababe0 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1015,6 +1015,7 @@ enum super_iter_flags_t {
>         SUPER_ITER_REVERSE      = (1U << 1),
>         SUPER_ITER_WAIT_SHUTDOWN = (1U << 2),
>         SUPER_ITER_SKIP_UNBORN  = (1U << 3),
> +       SUPER_ITER_KILLABLE     = (1U << 4),
>  };
> 
>  static inline struct super_block *first_super(enum super_iter_flags_t flags)
> @@ -1040,7 +1041,9 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>         int ret = 0;
> 
>         if (flags & SUPER_ITER_WAIT_SHUTDOWN)
> -               lock_flags |= SUPER_LOCK_KILLABLE | SUPER_LOCK_WAIT_SHUTDOWN;
> +               lock_flags |= SUPER_LOCK_WAIT_SHUTDOWN;
> +       if (flags & SUPER_ITER_KILLABLE)
> +               lock_flags |= SUPER_LOCK_KILLABLE;
> 
>         spin_lock(&sb_lock);
> 
> @@ -1122,6 +1125,7 @@ void iterate_supers_born(void (*f)(struct super_block *, void *), void *arg)
>  int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg)
>  {
>         return __iterate_supers(f, arg, SUPER_ITER_WAIT_SHUTDOWN |
> +                                       SUPER_ITER_KILLABLE |
>                                         SUPER_ITER_SKIP_UNBORN);
>  }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
