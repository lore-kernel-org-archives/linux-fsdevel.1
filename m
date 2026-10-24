Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877975;
	b=d4WI9CVch0o/M2xvDsWaV5aAEnZr9j0E02RQAhyHEgFR+UUTw23QoArkWFeIUs5N4KTX
	 E9+IeaqrS2f8c6c43q3J4DQc1063jMP4iFIQnKqo8S9B9cGYVkYaL/+5RdYI9k2YksG0d
	 wyMiyn/xpZJXEhf+ImmHTyw9SsUR9Jk7D5I2HyL/drh07tjbjER5WfKaODIJ2xLInfEzC
	 s6/3IrJUOkAYtNA3tDuGLHFls0kS3jcyQE5PqCtsnpJli13P8UKYY/rZZSccERs0qNNS6
	 xl0eNSSSR3Hw56xOc1GiKYANpGmtWe7EpbctnSmCKJ9QXVJUYP1pFyjSXACpXhOyeLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877975;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=vm7/fsP/sg92Pgvt7+1980ql6OkAUgOzW7e5joju6Wo=;
	b=Fa9/JaoNNIIerazz6WUklnFhoQPkLkJE+DBJyB3owhuXZE4XVJkrIXV3vWKQxcUvUFeU
	 e1PX0X2Xkju+UMNReW7JGRZHjP+P7+UFn+jKwM8T8JxOernQRhegd2U3s5wewGvFj5eW6
	 Ys+X+fdJJdKpLwbQzYFo5IaE94STXrhSi/RYXx6aBYiDR/xc6ydRDR8XK8N8pLKZK7j4Z
	 5JFY2rJBAHfxNhzuSMMoK/GGu6TgI0XdjcHnz3Y/huY8fdszayDUlgIgG0qjcq9mhLsf4
	 JQ8aM8LelrDudu/fiGC4DJTkY3CVVosn176RacOUFfJ3rkZLm5D1kNxr8kNp6F3srDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZSuLecdn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Emy51tGX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZSuLecdn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Emy51tGX;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FC606A31A;
	Sat, 24 Oct 2026 21:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE2FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZSuLecdn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Emy51tGX;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZSuLecdn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Emy51tGX
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72A3322529;
	Sat, 24 Oct 2026 21:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792877972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vm7/fsP/sg92Pgvt7+1980ql6OkAUgOzW7e5joju6Wo=;
	b=ZSuLecdnBnciu14T0QD4DIXt9MDvm9G9X48nA+9FDjtdCtOBjE7545gUazAEc619aukRh4
	RTR9tDiJlbMxdCBo3J+4IjZvyQFuWGP1UZbCexWMaRT1yZmb5IIKMwk13nJ6Wu41AF6FC+
	2NrW+tvhS05Mfo+Au347B3JPdkdTKpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792877972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vm7/fsP/sg92Pgvt7+1980ql6OkAUgOzW7e5joju6Wo=;
	b=Emy51tGX94iL1lrgA+Lz4XFn294NYmIlFx0gEwMUyMuKB5dmD5OhTOFHXIdGSJAUZ4kk8w
	K4dlqrOERgEqyjAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792877972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vm7/fsP/sg92Pgvt7+1980ql6OkAUgOzW7e5joju6Wo=;
	b=ZSuLecdnBnciu14T0QD4DIXt9MDvm9G9X48nA+9FDjtdCtOBjE7545gUazAEc619aukRh4
	RTR9tDiJlbMxdCBo3J+4IjZvyQFuWGP1UZbCexWMaRT1yZmb5IIKMwk13nJ6Wu41AF6FC+
	2NrW+tvhS05Mfo+Au347B3JPdkdTKpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792877972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vm7/fsP/sg92Pgvt7+1980ql6OkAUgOzW7e5joju6Wo=;
	b=Emy51tGX94iL1lrgA+Lz4XFn294NYmIlFx0gEwMUyMuKB5dmD5OhTOFHXIdGSJAUZ4kk8w
	K4dlqrOERgEqyjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF0CF133F3;
	Sat, 24 Oct 2026 21:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GBHMJZMl3WrKAQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Sat, 24 Oct 2026 21:39:31 +0000
Date: Sat, 24 Oct 2026 22:39:30 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: hold truncate_lock in fat_write_failed()
Message-ID: <at0kGRzkfLeqD7yq@pedro-suse.tail5790ac.ts.net>
References: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
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
In-Reply-To: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,ufrgs.br:email]
X-Spam-Score: -13.30

On Wed, Oct 21, 2026 at 01:21:04PM -0300, Matheus Alves de Almeida wrote:
> The current fat_write_failed() implementation calls into
> fat_truncate_blocks() without holding truncate_lock. Make it so it is
> held exclusive while truncating.
> 
> Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  fs/fat/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 141276fcf8db..2a16ed415631 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -216,7 +216,9 @@ static void fat_write_failed(struct address_space *mapping, loff_t to)
>  
>  	if (to > inode->i_size) {
>  		truncate_pagecache(inode, inode->i_size);
> +		down_write(&MSDOS_I(inode)->truncate_lock);
>  		fat_truncate_blocks(inode, inode->i_size);
> +		up_write(&MSDOS_I(inode)->truncate_lock);

Hmm, I think there's still a race here. Nothing's stopping a sequence of
events like:

1) truncate_pagecache
2) concurrent pagecache look creates mapping for out-of-range blocks
3) fat_truncate_blocks() truncates the blocks out from the inode
4) page cache has stale pages pointing at stale blocks

-- 
Pedro
