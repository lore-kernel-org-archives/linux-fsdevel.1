Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793230;
	b=0hKb69z7qyyMwAj2mhcYbWaPIERlOA5ODCrBFNMY8YV/o00+H8TSj99mEKbobf1OQlls
	 tzdE4ZSzgjgwbNII2Wt6b59p6DLHw49v/gS9YT+5pz5SfLPS2/CKTln01vKHebdg05Ftg
	 st5WgCt8WtMjHzvy4Xac0IvuBOUCaWdboVcPeDxPB8iOqC1+OWeVgfRN0ZwCwsX7YNHVu
	 7lUDXl+JMNwV3OagwWej01zo/jXj3AJFjYP8u0F5oy1WGFBLWoj9YiQz74PMIEkLwD+Hc
	 VN+IwIs2V/LGEEXcniYPRkPC86kP9qAi16kXkIB0I0jiPh1vSPG7XxbXZZghF+y/Iqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793230;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=XViuky4maevRglLQ+Gw3+zRrHlRCYabT6ch8Ipi46xU=;
	b=wF3AeZEPRytt/Of5GqvILdn9VFEh3G9vILOtKrBS6zHQ8gFb0XgEFeUo/hEeh3Wko5RW
	 5wX9IMgs2fabriOi8YXZVXBdG0+wNaLYutBfquwLpOj8Zz1CXzW96KxH8+Q5nJUmBT3U/
	 SKFHE7WI2YGDVtly8zrbmIYFFik2l6oE+yvWWG20ExpsTaSbV1P95xo9/YPcTEJ0a7f80
	 8QBG9gJqK7BGnCVfYy8Py0pksO5fimw5drC7ud5d4yTF4mGbsPFjbgnwXBri1M6ajWGdk
	 Hvy5yJ3iScTgRLa4iAmXyT6/02XPLUXkyjBFjf/JRD3g5qLAcm68lrd5jubg3LpBXnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=H7F4mp6T;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=95rfp8bY;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zN8ScRQl;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vex8oINC;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E37606A31C;
	Fri, 27 Nov 2026 15:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=H7F4mp6T;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=95rfp8bY;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zN8ScRQl;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vex8oINC
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE5C81FBA2;
	Fri, 27 Nov 2026 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795793228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XViuky4maevRglLQ+Gw3+zRrHlRCYabT6ch8Ipi46xU=;
	b=H7F4mp6Ta/MyK6bTBkpc64QYzoTIYIuRrwWUYSeNz2smVCiyVxmyDGwG3yUAxsA8ZJVJly
	8C8iIMZMHfl7qywLbAqiF7AQTAgnKNU8s66BVNQM5N7UjUsJ7T6OSwrh8kQcSWlnfgNyyY
	X8sp7LT/tSCO4hzhVdKIGBKn8TKwX4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795793228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XViuky4maevRglLQ+Gw3+zRrHlRCYabT6ch8Ipi46xU=;
	b=95rfp8bYHCDkaHcKMxZdDI2hXLSduVotclGPEHBZJ3qcFTwdjhM02hvHW5xQlmQI9Tow5u
	KcbuLvryesctldAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zN8ScRQl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vex8oINC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795793226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XViuky4maevRglLQ+Gw3+zRrHlRCYabT6ch8Ipi46xU=;
	b=zN8ScRQlO3iAx6+DNXl2RSSItWGa1druMxHzKW+9kRxuGFBC+bRXZHoAR9R5EjnfeTZKZA
	yECgJpG15RjasEUatKsVR6GhLKCKD73Zt0Cb5ApqcQXnVyeKi/hd9zfmgnyLBDTss2iQuo
	sLmh5CMnAujvYz7wzQweAoI4R5C4FWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795793226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XViuky4maevRglLQ+Gw3+zRrHlRCYabT6ch8Ipi46xU=;
	b=vex8oINCrIJq+7xb6KqmvWq6TRsTp1X+MD61jS0XHAW5KwxBFG26ou0tdjYzdv0XiPmQjY
	pEo9FsL2ALgagICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9837713432;
	Fri, 27 Nov 2026 15:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uvZyHEqhCWvlEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Nov 2026 15:27:06 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id CAD605107C; Fri, 27 Nov 2026 16:27:01 +0100 (CET)
Date: Fri, 27 Nov 2026 16:27:01 +0100
From: Jan Kara <jack@suse.cz>
To: Ding Feng <dingf3ng@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, 
	Jeff Layton <jlayton@kernel.org>, Kyuwon Cho <kyuwoncho18@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] statmount: retry an overflowed seq buffer before any
 other check
Message-ID: <xecensago4k4423jzchvvo7laiauaxvtpjpowxsuab3iu27zbd@zxco3d3jenkl>
References: <20261125-statmount-retry-v2-1-dingf3ng@gmail.com>
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
In-Reply-To: <20261125-statmount-retry-v2-1-dingf3ng@gmail.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,themaw.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: CE5C81FBA2

On Thu 26-11-26 01:13:48, Ding Feng wrote:
> statmount_string() checks whether the seq_file overflowed only after
> two earlier returns, and both can hide the overflow.
> 
> The size check runs first. After an overflow, seq->count equals
> seq->size, so every buffer of up to sizeof(struct statmount) +
> seq->size bytes gets -EOVERFLOW, and the retry with a larger seq buffer
> never runs. The result can still fit in such a buffer.
> statmount_mnt_root() and statmount_sb_source() write escaped strings
> and unescape them in place, so the escaped form can overflow the
> 3 * PATH_MAX seq buffer while the final string is much shorter. A bind
> mount whose root is a 3765-byte path of spaces needs a 4.3 KiB buffer,
> but STATMOUNT_MNT_ROOT fails with -EOVERFLOW for every buffer up to
> 12800 bytes and succeeds from 12801.
> 
> The early return for a string that emits nothing runs before both. The
> NUL written after a string that ends one byte before the end of the seq
> buffer leaves seq->count == seq->size. The next string then emits
> nothing, and the early return drops it with no error and no retry. With
> a tmpfs mounted on a 12278-byte path, statmount() for
> STATMOUNT_FS_TYPE | STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT |
> STATMOUNT_SB_SOURCE returns 0 without STATMOUNT_SB_SOURCE.
> 
> Check for the overflow before both, so the string is regenerated in a
> larger seq buffer.
> 
> Fixes: 68385d77c05b ("statmount: simplify string option retrieval")
> Fixes: 75ead69a7173 ("fs: don't let statmount return empty strings")
> Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
> Closes: https://lore.kernel.org/all/179552693473.1490262.10477620788152048784@gmail.com/
> Suggested-by: Kyuwon Cho <kyuwoncho18@gmail.com>
> Assisted-by: Claude:claude-opus-5-5 Frama-C
> Signed-off-by: Ding Feng <dingf3ng@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Notes:
>     v2: move the check above the "seq->count == start" return as well,
>     which also fixes the dropped string Kyuwon found.
>     
>     v1: https://lore.kernel.org/all/20261120033644.99834-1-dingf3ng@gmail.com/
>     
>     Tested on v7.4-rc3 (65e4fd942), arm64 tinyconfig in QEMU:
>     
>       case                                          v7.4-rc3   v1         v2
>       STATMOUNT_MNT_ROOT, 3765-byte root of spaces,
>         bufsize 8192 or 12800                       EOVERFLOW  ok         ok
>         bufsize 4096                                EOVERFLOW  EOVERFLOW  EOVERFLOW
>       tmpfs on a 12278-byte path, SB_SOURCE         missing    missing    tmpfs
>       tmpfs on a 12276, 12277, 12279 or 12280-byte
>         path, SB_SOURCE                             tmpfs      tmpfs      tmpfs
>     
>     A plain bind mount gives the same results on all three (1024 ok, 512
>     EOVERFLOW).
>     
>     A string that legitimately emits nothing after a full seq buffer now
>     costs one retry, and a buffer too small for a string longer than the
>     seq buffer costs one or more retries before -EOVERFLOW.
> 
>  fs/namespace.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index aecd05ac0..3c41fd42c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5807,6 +5807,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  		return -EINVAL;
>  	}
>  
> +	/* signal a retry */
> +	if (unlikely(seq_has_overflowed(seq)))
> +		return -EAGAIN;
> +
>  	/*
>  	 * If nothing was emitted, return to avoid setting the flag
>  	 * and terminating the buffer.
> @@ -5818,10 +5822,6 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  	if (kbufsize >= s->bufsize)
>  		return -EOVERFLOW;
>  
> -	/* signal a retry */
> -	if (unlikely(seq_has_overflowed(seq)))
> -		return -EAGAIN;
> -
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
