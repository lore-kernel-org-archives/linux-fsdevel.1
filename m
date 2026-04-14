Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605423E6388
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170618; cv=none; b=gSCluECd+enIx3b3FP3TIZ1reThRbMZ/Kq/FeerNCIkLKOITF59d5ksUxKHwAU59tKg0Oh6RkphtWkXNS3zK7wES4+kXQxxXq5V/tX6AqSHde5Tw/I8eoShErWS4l426+l2gHenh//xbSC0Kus8bhbLgqxDaWfNnWm7ZtvkQIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170618; c=relaxed/simple;
	bh=qnK7k6IHrNCSTDNTQUKwGDOjgyfhjHYpvqF0dYs5OXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb4qkMp3vEBHXUKoSMw5ZQsjyy81pRt8lIADIIXUbYyzmwuChONy6G9mRcmV0x0MBfpPbQTHplqLfMFQPoVGVy0zSQSlRINolXIxf35ESHbsMAtlatB7lH+6TaFvyIr5oD2Kl1wT+Wu5XnknMdVtBcU/3WUXm7AE3qADVjQSKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XaoKwOYU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CqYKbcTj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XaoKwOYU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CqYKbcTj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XaoKwOYU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CqYKbcTj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XaoKwOYU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CqYKbcTj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B772B6A900;
	Tue, 14 Apr 2026 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776170615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxarUO4lk7LF8B8XC/HDZwn/7Us9hb+n9d6wW16auuY=;
	b=XaoKwOYU5/HTTMesQ0qlJoQxwhhL6Nonr/Z2TomSx2+uJWALChsNVs4PKxw7SPs/b+M7wh
	RWHWq4C1heTK55F9+ugEezkyhKIioLINDXEUpdUtgaLCjOJHsy5A9Kbn8Vkm6PdB6RUvD3
	4DkOLeMw3e+gUvzEHgKSbdhV17h/EKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776170615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxarUO4lk7LF8B8XC/HDZwn/7Us9hb+n9d6wW16auuY=;
	b=CqYKbcTj3CCzefsZdBeVROoqnk+amXk5EWaAObY1EbMjIfo+casGg6JeXzYMUo4H176Jps
	OhGZ8OGx1rhMi+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776170615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxarUO4lk7LF8B8XC/HDZwn/7Us9hb+n9d6wW16auuY=;
	b=XaoKwOYU5/HTTMesQ0qlJoQxwhhL6Nonr/Z2TomSx2+uJWALChsNVs4PKxw7SPs/b+M7wh
	RWHWq4C1heTK55F9+ugEezkyhKIioLINDXEUpdUtgaLCjOJHsy5A9Kbn8Vkm6PdB6RUvD3
	4DkOLeMw3e+gUvzEHgKSbdhV17h/EKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776170615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxarUO4lk7LF8B8XC/HDZwn/7Us9hb+n9d6wW16auuY=;
	b=CqYKbcTj3CCzefsZdBeVROoqnk+amXk5EWaAObY1EbMjIfo+casGg6JeXzYMUo4H176Jps
	OhGZ8OGx1rhMi+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF35A4B453;
	Tue, 14 Apr 2026 12:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NLS/Knc23mkHEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Apr 2026 12:43:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6E622A0B66; Tue, 14 Apr 2026 14:43:31 +0200 (CEST)
Date: Tue, 14 Apr 2026 14:43:31 +0200
From: Jan Kara <jack@suse.cz>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] udf: reject descriptors with oversized CRC length
Message-ID: <7sphdwp54fokevos7ppeq2iaydltdq2uxxt6iqamjwtycs2a34@yt53i7nyvwc3>
References: <20260413211240.853662-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413211240.853662-1-michael.bommarito@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 13-04-26 17:12:40, Michael Bommarito wrote:
> udf_read_tagged() skips CRC verification when descCRCLength +
> sizeof(struct tag) exceeds the block size.  A crafted UDF image can
> set descCRCLength to an oversized value to bypass CRC validation
> entirely; the descriptor is then accepted based solely on the 8-bit
> tag checksum, which is trivially recomputable.
> 
> Reject such descriptors instead of silently accepting them.  A
> legitimate single-block descriptor should never have a CRC length that
> exceeds the block.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Thanks for the fix! It looks good to me. I'll merge it into my tree later
this week once the pull requests for the merge window are done.

								Honza

> ---
> Found during a filesystem security audit.  The CRC validation
> condition in udf_read_tagged() uses OR logic: the first arm
> (descCRCLength too large) short-circuits the second arm (CRC
> comparison), so an oversized descCRCLength causes the function to
> return the buffer head without verifying the CRC.  The descriptor
> is accepted based solely on the 8-bit tag checksum.
> 
> A crafted UDF image with descCRCLength set to blocksize (e.g. 2048
> on a 2048-byte-block filesystem, vs the 2032 limit) in both the
> main and reserve Volume Descriptor Sequences mounts successfully
> with corrupted descriptor bodies.
> 
> Reproduced on UML (ARCH=um, KASAN-enabled v7.0-rc7) with a
> mkudffs-generated 20 MiB image, both LVD copies patched to
> descCRCLength=2040, CRC left stale, body byte flipped, tag
> checksum recomputed.  Mount succeeds (MOUNT=0) with the corrupt
> LVD accepted.  With this patch applied, mount fails with EINVAL
> and the new "CRC length ... exceeds block size" error is logged.
> 
> Reproducer details and UML console logs available on request.
> 
>  fs/udf/misc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/udf/misc.c b/fs/udf/misc.c
> index 0788593b6a1d..6928e378fbbd 100644
> --- a/fs/udf/misc.c
> +++ b/fs/udf/misc.c
> @@ -230,8 +230,12 @@ struct buffer_head *udf_read_tagged(struct super_block *sb, uint32_t block,
>  	}
>  
>  	/* Verify the descriptor CRC */
> -	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize ||
> -	    le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
> +	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize) {
> +		udf_err(sb, "block %u: CRC length %u exceeds block size\n",
> +			block, le16_to_cpu(tag_p->descCRCLength));
> +		goto error_out;
> +	}
> +	if (le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
>  					bh->b_data + sizeof(struct tag),
>  					le16_to_cpu(tag_p->descCRCLength)))
>  		return bh;
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
