Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593295;
	b=MbP0jtxgEV+VtMBvN9hf/Jj2I3zyqrqmdSYkzx9K4bElOxqIbVBI1zAa0XTRs3NBREdo
	 RsGZQREzpgsAFn7Wskz1oURMbyiqDJdPL1zzHbWcjehX9Ok2yBCMYfdZnpYEstEaMKod3
	 nipT5VVVXEwAmiwLi8KCoqXb7maEqkLQdDSfEW+6QJI+dSm25HEDmSRU1YbT0/P+p/fje
	 F1ZIyD7iyj5LsWZaT6DuXxJtguJ5XZMKHkBWHINYDkOJBurswTPNvFxBzgUca+rVs+blm
	 sPEVVb43q4dZ/m6wq8j7UjgFJXjIFo8s7CFiamH2J5b0usY81cnS7hh+uYRBYqhsl7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593295;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=JSd8lyxv59hdH3K4I6bbwGW1AIznqdRNwt6KuhU8KKQ=;
	b=f4h8uLn0v2juHwNT/dRBqfqejQGXDZFgMpM7+tBB4MnpaLOqNJldFjSxPVk3Xou68upy
	 hjZFt31syGJ/hRhcWv1SHO/oI8vKltTzh5QOGRSqB+8Wp4NaaMkuNb/pP1L2UhOkKjjBK
	 +sUpji4olOT/6F7PwExNAYhD8NzWLHoUDlHjPVFYl39OSWEeH7ziL/kZjwCwv9RC5MmZN
	 tQJ/7fnVlXnGgl1+kNBOoUZoW0D28wKLAn0xoXSqiBQole+64sc6ygvR9aA3tTPk3GRHJ
	 sf2sWZu4kUNntQtTrFphv3CIMYHd9KCcvV9gqWLGk9l6hfmuNX9WWWA5Tke0S/Xht1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hrU3W0Ch;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZiTmXpmh;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FHX+Zptd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="Duc/CCMd";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A4260A2637;
	Wed, 21 Oct 2026 14:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A4260A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hrU3W0Ch;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZiTmXpmh;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FHX+Zptd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Duc/CCMd
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8FD11FAA7;
	Wed, 21 Oct 2026 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792593280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSd8lyxv59hdH3K4I6bbwGW1AIznqdRNwt6KuhU8KKQ=;
	b=hrU3W0Chhs2NZNDiDn/AzTgCc1SZElY10pt66TzJwLSJ6GLas89/BAAriL1d3TY1TiyyDc
	KPTaMohIFKzWVDSeFzsdGd9ed7/P0L9YHVow1MqRVVs56I/OedP+SmLZbSfmsp9khSgBw7
	I2oOBfdsCF+TMXL+SZgPK67/yWe8S9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792593280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSd8lyxv59hdH3K4I6bbwGW1AIznqdRNwt6KuhU8KKQ=;
	b=ZiTmXpmh9mj44n9HQhNtzg+gCzSg5xRkfi7ifSlaaRgHpd0lCE+uHcmeX+2DBhDtcn0AUl
	6KknozYU9QIVxdBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FHX+Zptd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Duc/CCMd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792593279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSd8lyxv59hdH3K4I6bbwGW1AIznqdRNwt6KuhU8KKQ=;
	b=FHX+ZptdyKOFPXvX6jGt429CNWCJfZStxZ9rS0iCIQtrlqvwGMRHOCrrCdFD8II20TKj9D
	0XvYTGezkFomzZ3l5qhxRU+cIR6AiqvMCplg6yu9NH7r4buugmLUBwv/oqzmlCeDt/Mrms
	pWFqTWOxjgOhiBn1zsIjFs6JjbNXzCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792593279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSd8lyxv59hdH3K4I6bbwGW1AIznqdRNwt6KuhU8KKQ=;
	b=Duc/CCMdzAvf1SnD9c1v7931n6FJv0yk/g8Pwosiu9n3M+cTYiPyDnfpQwY4cMi9MdHZJ5
	I0nC0SacqaNYw1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F59A13518;
	Wed, 21 Oct 2026 14:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fCAbHX/N2GoVWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 14:34:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F2FB1A1424; Wed, 21 Oct 2026 13:53:11 +0200 (CEST)
Date: Wed, 21 Oct 2026 13:53:11 +0200
From: Jan Kara <jack@suse.cz>
To: Hui Peng <benquike@gmail.com>
Cc: jack@suse.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: validate vat20->lengthHeader and VAT inode size in
 udf_load_vat()
Message-ID: <kfex5w22vfjpi4hxgmmirel67ulcidftnb5x2ujicuwj7qpjd3@cgdhwhzyi6sq>
References: <20260919222600.3793513-1-benquike@gmail.com>
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
In-Reply-To: <20260919222600.3793513-1-benquike@gmail.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D8FD11FAA7

On Sat 19-09-26 22:26:00, Hui Peng wrote:
> In udf_load_vat() (fs/udf/super.c), validate that vat20->lengthHeader is
> at least sizeof(struct virtualAllocationTable20) and does not exceed the
> mapped buffer or VAT inode size so computing the VAT table pointer and
> entry count cannot underflow or read out of bounds.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Thanks. The i_lenAlloc checks are pointless - we verify i_size matches
i_lenAlloc when loading the inode for IN_ICB inodes. But otherwise the
patch looks good so I've added it to my tree without these checks.

								Honza

> ---
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 2ba5973ef4dd..2f0f087bcced 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1252,6 +1252,15 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
>  			(sbi->s_vat_inode->i_size - 36) >> 2;
>  	} else if (map->s_partition_type == UDF_VIRTUAL_MAP20) {
>  		vati = UDF_I(sbi->s_vat_inode);
> +		if (sbi->s_vat_inode->i_size <
> +			sizeof(struct virtualAllocationTable20) ||
> +		    (vati->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
> +		     vati->i_lenAlloc <
> +			sizeof(struct virtualAllocationTable20))) {
> +			udf_err(sb, "Too short VAT inode size %lld\n",
> +				sbi->s_vat_inode->i_size);
> +			return -EFSCORRUPTED;
> +		}
>  		if (vati->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
>  			int err = 0;
>  
> @@ -1269,8 +1278,15 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
>  
>  		map->s_type_specific.s_virtual.s_start_offset =
>  			le16_to_cpu(vat20->lengthHeader);
> -		if (map->s_type_specific.s_virtual.s_start_offset
> -		    > sbi->s_vat_inode->i_size) {
> +		if (map->s_type_specific.s_virtual.s_start_offset <
> +			sizeof(struct virtualAllocationTable20) ||
> +		    map->s_type_specific.s_virtual.s_start_offset >
> +			sb->s_blocksize ||
> +		    map->s_type_specific.s_virtual.s_start_offset >
> +			sbi->s_vat_inode->i_size ||
> +		    (vati->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
> +		     map->s_type_specific.s_virtual.s_start_offset >
> +			vati->i_lenAlloc)) {
>  			udf_err(sb, "Corrupted VAT header length %u (VAT inode size %lld)\n",
>  				map->s_type_specific.s_virtual.s_start_offset,
>  				sbi->s_vat_inode->i_size);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
