Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4956175A60
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094157; cv=none; b=QySZOPOqirqhIabQVWekoYWcHGKHyChQIvVZFINfslFJholpInz5O9iwwT+rqwmsoQF/6iGb64uvybW4EZOeAfANipJfQZZKp7IWzHyQ5t36d55nv1sqgwSCakh6l//4q7mIPxhyyIVlJeRrkqV722lnseOWUVZBXQ+/N2VbH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094157; c=relaxed/simple;
	bh=KMFF0pvA4rCV7SWQmUz9cFO5vm6kEF+DS4ZAvFsqjsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOaIC2UwGpdaog9MN/oY5GHVHOF8aLe+EjaqNxwQwuyRESfA5KpmULcf5MJEwLA8nS7br4TMh67lPVtZGb8ytORjE3AYCjnb/DfT+S+iOzDOfTQUAevdBiUxnecLWwS/Y3GhiSCy0Fzi+6Nu94CGfjH9Ze6LU3lDtnNjeXwwoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9ZL038q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lcMp/JiL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A+H9UM8L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+cuqK7J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9ZL038q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lcMp/JiL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A+H9UM8L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+cuqK7J"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEB68675E3;
	Mon, 18 May 2026 08:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779094154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXtI2CjKT5ae6SkMSnoH945y0xPpqzu+uTrB6NFerG8=;
	b=K9ZL038qvmk/XCddRpn2myDEVtNcgcCITvEt0Q3VP4vLwaY+JHgcqjiGNmeZ1jKhYriM1n
	vJpr0LkDS7TkMAOd3/sjud6J8H79kyh/RGqlO96oYdYy3nXJGqkICJWuvs61wjtEYnPoxN
	rkxtX9MdEs/HcVPHqskXmQwTqMom+lU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779094154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXtI2CjKT5ae6SkMSnoH945y0xPpqzu+uTrB6NFerG8=;
	b=lcMp/JiLkS0oO6fGbmLxGvP5lgKWphVQk67r1DpsDEW5FbK28Slo6SqY5R9ZkbkLnY0laF
	RpANDlxoaf2PgMBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A+H9UM8L;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n+cuqK7J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779094153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXtI2CjKT5ae6SkMSnoH945y0xPpqzu+uTrB6NFerG8=;
	b=A+H9UM8LkSMwYTLv13V2oNiwi0LLCsE2q9G9qfffYCxAaJBcQi5qs8PHqcCQW9SYNRxhoR
	dW+h3SPBDHgdZKpQyjUFqkO7+sGZYSMK4VZXu0cY/Gk0vw9AvUPxQjRrKrUYK70LCD8Y75
	ckcADSyYW1jpzudrfUBELe7q8Q2JFwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779094153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXtI2CjKT5ae6SkMSnoH945y0xPpqzu+uTrB6NFerG8=;
	b=n+cuqK7JM6cmuHJGcmCTustfv0MLlH0kzXt9EFGUGKefAIJ7jzuiw6TyHlxAVHbEs3nmm3
	JEWXV8DAx9TgmuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0B9C593A8;
	Mon, 18 May 2026 08:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qLruMonSCmoCPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 May 2026 08:49:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE741A0A90; Mon, 18 May 2026 10:49:08 +0200 (CEST)
Date: Mon, 18 May 2026 10:49:08 +0200
From: Jan Kara <jack@suse.cz>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jan Kara <jack@suse.com>, Roman Smirnov <r.smirnov@omp.ru>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: validate free block extents against the partition
 length
Message-ID: <htztuprcb2oshlftqck2njqw2vagmwxgyqftscy5i5gihll5if@3rrvzyrd4xyq>
References: <20260515142327.1120767-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515142327.1120767-1-michael.bommarito@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DEB68675E3
X-Spam-Level: 

On Fri 15-05-26 10:23:27, Michael Bommarito wrote:
> udf_free_blocks() checks the logical block number and count against the
> partition length, but drops the extent offset from that final bound.  A
> crafted extent can pass the guard while logicalBlockNum + offset + count
> points past the partition, which later indexes past the space bitmap
> array.
> 
> A single ftruncate(2) on a file backed by such an extent reliably
> panics the kernel.  This is a local availability issue.  On desktop
> systems where UDisks/polkit allows the active user to mount removable
> UDF media without CAP_SYS_ADMIN, an unprivileged local user can supply
> the crafted filesystem and trigger the panic by truncating a writable
> file on it.  Systems that require root or CAP_SYS_ADMIN to mount the
> image have a higher prerequisite.
> 
> No confidentiality or integrity impact is claimed: the reproduced
> primitive is an out-of-bounds read of a bitmap pointer slot followed by
> a kernel panic.
> 
> Use the already computed logicalBlockNum + offset + count value for the
> partition length check.  Also make load_block_bitmap() reject an
> out-of-range block group before indexing s_block_bitmap[], so corrupted
> callers cannot walk past the flexible array.
> 
> Fixes: 56e69e59751d ("udf: prevent integer overflow in udf_bitmap_free_blocks()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/udf/balloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index 807c493ed0cd..cc6dc6e1d84d 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -82,8 +82,9 @@ static int load_block_bitmap(struct super_block *sb,
>  	int nr_groups = bitmap->s_nr_groups;
>  
>  	if (block_group >= nr_groups) {
> -		udf_debug("block_group (%u) > nr_groups (%d)\n",
> +		udf_debug("block_group (%u) >= nr_groups (%d)\n",
>  			  block_group, nr_groups);
> +		return -EFSCORRUPTED;
>  	}
>  
>  	if (bitmap->s_block_bitmap[block_group]) {
> @@ -662,7 +663,7 @@ void udf_free_blocks(struct super_block *sb, struct inode *inode,
>  
>  	if (check_add_overflow(bloc->logicalBlockNum, offset, &blk) ||
>  	    check_add_overflow(blk, count, &blk) ||
> -	    bloc->logicalBlockNum + count > map->s_partition_len) {
> +	    blk > map->s_partition_len) {
>  		udf_debug("Invalid request to free blocks: (%d, %u), off %u, "
>  			  "len %u, partition len %u\n",
>  			  partition, bloc->logicalBlockNum, offset, count,
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
