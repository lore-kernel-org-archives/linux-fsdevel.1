Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540193BC66A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768194; cv=none; b=CK08n4DoH6EJxTv6kJgSY9bwR9AUmrxuzEn8k2fptthnG/NzntVf2YUXhr5NnGuA0zA3Yh4WpcEzwdtT8KMEzQ6IOv/t9tppYQCzc2zEUYdiAquXPOCxVUelfWcsk9PZyE0JKosCDOTktzyvTohy1isAuSeUQN75N5ajKjTV2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768194; c=relaxed/simple;
	bh=E9X0f0Zt0XT3F6rE5+VWP6xB4FbmyaGtt3R3o8TunPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tkyeck9Bd1ILgJggV0zA1/c6q5gt0PRD2YrUuIogT5+Y7D5VGRz5oUUgt3VYBGHzeUk8s7FqM6TP00BN+wENmQftxQVDOFmrbYbuSjk2cFvSd7Z0tin063KMZJfMG3foNuJo22oqphslxU6hO3NIVyvS2K9qCiSmUjxSsJI2C34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bNj2QZgm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8F3wRE2O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HRL4bvDq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ObSXzi9h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bNj2QZgm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8F3wRE2O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HRL4bvDq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ObSXzi9h"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5E325BD36;
	Tue, 21 Apr 2026 10:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776768191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQK12VyTJh/9j4wXAj1sM4zUaOZJVx0UPefA9W/hqMo=;
	b=bNj2QZgmdn7zM+NPctB6jRi7Ixl2+YB59NPkvcRodjWDQi4DgrRWztx0TgHts/SspZbslX
	n/0gdF/+P/2vLDyQbxfrNonBzxqOU05mJS3pcjtbiC3qaTZRkmKi4zbDKWr2ShTM0vLw2i
	BOMHjqFPNmIVWU/VH2dNZyzMmLDZKfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776768191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQK12VyTJh/9j4wXAj1sM4zUaOZJVx0UPefA9W/hqMo=;
	b=8F3wRE2OEMzYFMExwVVTfkiSONxiKhXRbEApedpE0rWS6g+9F2PKXYOuIAUpICkJQfwFgM
	Ej4ORV5Wf4WP6cAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HRL4bvDq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ObSXzi9h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776768190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQK12VyTJh/9j4wXAj1sM4zUaOZJVx0UPefA9W/hqMo=;
	b=HRL4bvDq7fnaTQMaJWhiGC3e+CgAZt0kRZKPCvXY1aaqdQQamQqSxWPbug50v1fSJ0VE9a
	O14/bnyHqXH2xGxLsY2zlzmbu6j3KAnzYEK7g4bnT8aecm6suRAzXiZfc+DPdK+MLO5r8h
	lBcziGuHGQssIfwZisGdNCKeaY1EHe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776768190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQK12VyTJh/9j4wXAj1sM4zUaOZJVx0UPefA9W/hqMo=;
	b=ObSXzi9hptV9sMpeDQxFOXwg4YgieujZyA2sDcbpHF5tLOD6KfgHvq/zM9YwOsc3P3Dz0b
	6+MpEwcD83yOZfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA26E593AF;
	Tue, 21 Apr 2026 10:43:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CFOFKb5U52mEaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Apr 2026 10:43:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6BE1DA0AE1; Tue, 21 Apr 2026 12:43:06 +0200 (CEST)
Date: Tue, 21 Apr 2026 12:43:06 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: gregkh@linuxfoundation.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, cmirabil@redhat.com, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: remove always taken if-branch in find_next_fd()
Message-ID: <shj22v3ehlhlp4vuay3idkqpu7j5mhn3skqfkcluu52vngiol4@wmfte3r6xz3r>
References: <20260420101801.806785-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420101801.806785-1-jkoolstra@xs4all.nl>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,xs4all.nl:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: B5E325BD36
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 20-04-26 12:18:01, Jori Koolstra wrote:
> find_next_fd() finds the next free fd slot in the passed fdtable's
> bitmap. It does so in two steps: first it checks whether the bitmap
> has a free entry in the word containing start. If not, it looks at
> second level bitmap that registers which words in the first level bitmap
> are full and then looks at the first level bitmap at the first non-full
> word.
> 
> In the current code the second level lookup is done by:
> 
>   bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) *
>     BITS_PER_LONG;
> 
> where bitbit = start / BITS_PER_LONG. However, in the fast path (first
> step) we already checked the word at bitbit, so we can skip that word bit
> and start at bitbit+1. This also means that we can get rid of the branch
> 
>   if (bitbit > start)
>     start = bitbit;
> 
> since if we set
> 
>   bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit+1) *
>     BITS_PER_LONG;
> 
> the reassigned bitbit can never be less than
> 
>   ((start/BITS_PER_LONG)+1) * BITS_PER_LONG > start
> 
> So the branch is always taken.
> 
> Obviously the reuse of the variable name bitbit (and the name itself) is
> quite confusing, so change that as well.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Nice. Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 384c83ce768d..b7b78efcb0d1 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -544,24 +544,23 @@ struct files_struct init_files = {
>  static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>  {
>  	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
> -	unsigned int maxbit = maxfd / BITS_PER_LONG;
> -	unsigned int bitbit = start / BITS_PER_LONG;
> +	unsigned int max_fds_words = maxfd / BITS_PER_LONG;
> +	unsigned int fds_word_idx = start / BITS_PER_LONG;
>  	unsigned int bit;
>  
>  	/*
>  	 * Try to avoid looking at the second level bitmap
>  	 */
> -	bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
> +	bit = find_next_zero_bit(&fdt->open_fds[fds_word_idx], BITS_PER_LONG,
>  				 start & (BITS_PER_LONG - 1));
>  	if (bit < BITS_PER_LONG)
> -		return bit + bitbit * BITS_PER_LONG;
> +		return bit + (fds_word_idx * BITS_PER_LONG);
>  
> -	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
> -	if (bitbit >= maxfd)
> +	bit = BITS_PER_LONG *
> +		find_next_zero_bit(fdt->full_fds_bits, max_fds_words, fds_word_idx + 1);
> +	if (bit >= maxfd)
>  		return maxfd;
> -	if (bitbit > start)
> -		start = bitbit;
> -	return find_next_zero_bit(fdt->open_fds, maxfd, start);
> +	return find_next_zero_bit(fdt->open_fds, maxfd, bit);
>  }
>  
>  /*
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
