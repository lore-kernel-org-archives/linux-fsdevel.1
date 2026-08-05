Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA13FBEBC
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922788; cv=none; b=pLQer2iyvIIhgYPA9vW0IHzY8L88J5io8fiCfwKrqYnXJ020u60jViv7mh1ynckgOmvjk4rOEJzKTu3NJQrZPlsfdUOjwn3QGY4hw/JTwSrSn0QihMlRoP+1oW+W22Mr70dsrhAbwy+5MXdakt4y3S6qUts+CPlhK9/nj/C2KAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922788; c=relaxed/simple;
	bh=1N4hMDGgfLWcZ0iw99rx75WDQgKwuA+e0WQ6QLMv+98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/jfzqod9SccWSYKgNtaYINe6rsLpcuQUZWfmoSJ3SXoeDWsSGpIkQ4WZcS5zRPk4riH0Z4vbj48s57cHC+fbH2psrEJo0BbIkITwjOQHcnBe1XbpQ8Fc97w33eOJb18glWF2LVLHnRxZY1n8J72EF1YEH1Qzui19TGhVgfNcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yi2ZR8Xl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6TZFTWyo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AX6nMKyo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g7qO1uA3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yi2ZR8Xl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6TZFTWyo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AX6nMKyo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g7qO1uA3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90F597FD2C;
	Wed,  5 Aug 2026 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785922780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQVwr3gnBJOHSgeW9bCvvZBvXsMXD7EH3ku70gJIfoQ=;
	b=yi2ZR8XlagMVBg52yBL52rT2DhnP9SkazsC2usqtm2Fdp+/ywzdxy0qLWmEeF6iiSQImID
	TyWE0isyLzBOIs903hQ+m1hoYPAA56IRaz6+8npRxadbimWif+Do4hSkqdWvdqlfdHqf7r
	FX5nPew37I8kp/CdduBGBC1OKFUHxsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785922780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQVwr3gnBJOHSgeW9bCvvZBvXsMXD7EH3ku70gJIfoQ=;
	b=6TZFTWyor/50frl5M3SOQWOXgOkQe8Z43UcFdpP5YzT3/Xpx24bb2EqM6Kakfz74OudwHl
	0gaUYrsxZTZ4qUAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785922776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQVwr3gnBJOHSgeW9bCvvZBvXsMXD7EH3ku70gJIfoQ=;
	b=AX6nMKyonJLT1KeWcLsKlFFlLGMNrtcISnrmtn0x9F8rlN2xsthDW1jYjsEikPY0LXN+xj
	TaIO19z8hr4aldCRnREpoPA3MKL6eZf3KrOiKieTkarzYWSnMUTW0emgrigYR+7sZBNrR0
	pN+s3i2L/X2KmFNZAeDf5h3ygxN4nfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785922776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQVwr3gnBJOHSgeW9bCvvZBvXsMXD7EH3ku70gJIfoQ=;
	b=g7qO1uA38mTs+HG7a4ORr+8vtdWO8B1V+t3zaOOPzMFqy9ZNIRs6dplDvQ46/Liw1xv4Cm
	S8JZrfCTsDhl4OAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 873E9779B6;
	Wed,  5 Aug 2026 09:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uOD9INgEc2oGPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Aug 2026 09:39:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14607A13A7; Wed, 05 Aug 2026 11:39:32 +0200 (CEST)
Date: Wed, 5 Aug 2026 11:39:32 +0200
From: Jan Kara <jack@suse.cz>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: document semantics of kstat::{uid,gid} fields
Message-ID: <jdgkb7u77fc56g7nm3k4ict4hk73ypu7whjriqocsjbawudm24@we72tpaxods6>
References: <20260803-vfs-comment-stat-uid-v1-1-162d062b737c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-vfs-comment-stat-uid-v1-1-162d062b737c@google.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]

On Mon 03-08-26 21:46:19, Jann Horn wrote:
> The uid stored in struct kstat is logically a vfsuid; file systems
> initialize it by converting a kuid (filesystem perspective) to a vfsuid
> (mount perspective), then use vfsuid_into_kuid(), which essentially just
> typecasts from vfsuid to kuid.
> 
> For now, just add a comment to note this mismatch between C type and
> semantic type.
> 
> Below are some notes for anyone who wants to refactor this in the future.
> 
> There are probably two options to refactor this away:
> 
> 1. Change the type of kstat::uid to vfsuid_t, and perform the conversion
>    from vfsuid to userspace-uid in the VFS layer. This wouldn't change
>    machine code, just be more semantically correct.
> 2. Change the semantics of kstat::uid to really be a kuid_t, and let the
>    VFS layer take care of doing the translation from kuid to vfsuid that is
>    currently done in filesystem code (or in generic_fillattr, on behalf of
>    the filesystem code).
> 
> Option 2 is probably neater since it moves more logic into the generic VFS
> layer, and this is something that is expected to work the same way in all
> file systems?
> 
> The following coccinelle script:
> ```
> virtual context
> 
> @@
> struct kstat *stat;
> @@
> * stat->uid
> 
> @@
> struct kstat *stat;
> @@
> * stat->gid
> 
> @@
> struct kstat stat;
> @@
> * stat.uid
> 
> @@
> struct kstat stat;
> @@
> * stat.gid
> ```
> detects 43 field accesses to these uid/gid fields.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

I don't remember the reason why things are like this - Christian will have
to return from vacation for that :). But I agree with your analysis so feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/stat.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index e3d00e7bb26d..9c5709132862 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -41,8 +41,8 @@ struct kstat {
>  	u64		ino;
>  	dev_t		dev;
>  	dev_t		rdev;
> -	kuid_t		uid;
> -	kgid_t		gid;
> +	kuid_t		uid;		/* This is logically a vfsuid_t. */
> +	kgid_t		gid;		/* This is logically a vfsgid_t. */
>  	loff_t		size;
>  	struct timespec64 atime;
>  	struct timespec64 mtime;
> 
> ---
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> change-id: 20260803-vfs-comment-stat-uid-ea9d874f9368
> 
> Best regards,
> --  
> Jann Horn <jannh@google.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
