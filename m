Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BA395D9F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264511; cv=none; b=gYSsRieuH6WgNG6zlXc4MdEXvvH6sfOeX9gJiwzLFp62aMGilv8z0s8sIltcidzibumrHxwHTOI7NBtzV8M74gl4shxwxbkcOStpmFBKwBx9VJOXRth3E9R/1CcS7zuqbrHC4BFVCs6wv2/1EKNd3kysU/NfNVpEcyw+8KtEn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264511; c=relaxed/simple;
	bh=+rG8SrvnWW/MtZB9zFZZbf/x0BqNI/d2otEsc+WKIpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crZuh7LSGqq8mXMueBiJ1KTaqPU/HLoQ+oaLiLJVBYBgNc0sSDBf12CR13VbQrGS8KFF4IR3UA1B2LOrBEqAz5J/2xDjkpEeDmnw35f97VwMTFUKQs4Em5d9+pV7lhInQZcVQjEzAmww2QXjq/rLZrBJ9086KhL+S4Xo/uPFc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HlR7KN4F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oC6VH3X6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HlR7KN4F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oC6VH3X6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HlR7KN4F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oC6VH3X6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HlR7KN4F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oC6VH3X6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51CDC6C03C;
	Fri, 12 Jun 2026 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781264508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0YbFP2IjNEOUPGaG6UG3au0+Y0QOxb8ZhAgQOzlXWQ=;
	b=HlR7KN4FxRAaQ7RO8ZBeAwUn3mofQXnryn/zRujkKO+xU2Puja/3qKl7gnl85qzGhlXP2E
	fEHrBx9H94Ku5DQp4MYpuvSnvCwp6ufo4OW9J6X3fUm5lUI4BzFbqbxr2vnMyRDnaron34
	WKg+GJLVLm+uLdQMdUjPAkt5fgmKA5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781264508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0YbFP2IjNEOUPGaG6UG3au0+Y0QOxb8ZhAgQOzlXWQ=;
	b=oC6VH3X6LCNSmn04B4PQYwIef3Sk9dH0TsS5MvjjlLZRDahfjeYot0NbOrNDN7LZBBMwxl
	y2SkHTNjrUZ3TuBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781264508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0YbFP2IjNEOUPGaG6UG3au0+Y0QOxb8ZhAgQOzlXWQ=;
	b=HlR7KN4FxRAaQ7RO8ZBeAwUn3mofQXnryn/zRujkKO+xU2Puja/3qKl7gnl85qzGhlXP2E
	fEHrBx9H94Ku5DQp4MYpuvSnvCwp6ufo4OW9J6X3fUm5lUI4BzFbqbxr2vnMyRDnaron34
	WKg+GJLVLm+uLdQMdUjPAkt5fgmKA5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781264508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0YbFP2IjNEOUPGaG6UG3au0+Y0QOxb8ZhAgQOzlXWQ=;
	b=oC6VH3X6LCNSmn04B4PQYwIef3Sk9dH0TsS5MvjjlLZRDahfjeYot0NbOrNDN7LZBBMwxl
	y2SkHTNjrUZ3TuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48CAC779A7;
	Fri, 12 Jun 2026 11:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h1O9EXzwK2prAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Jun 2026 11:41:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0365A0EB4; Fri, 12 Jun 2026 13:41:39 +0200 (CEST)
Date: Fri, 12 Jun 2026 13:41:39 +0200
From: Jan Kara <jack@suse.cz>
To: hexlabsecurity@proton.me
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: validate VAT header length against the VAT inode
 size
Message-ID: <bhobgvj6tntmyvkerfa4siowfttrq6b4lelqq2tuoeiksddkul@fvi3aitmgric>
References: <20260612-b4-disp-9a2317ee-v1-1-fefef5736154@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-b4-disp-9a2317ee-v1-1-fefef5736154@proton.me>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri 12-06-26 02:53:31, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> udf_load_vat() takes the virtual partition's start offset straight from
> the on-disk VAT 2.0 header without checking it against the VAT inode
> size:
> 
> 	map->s_type_specific.s_virtual.s_start_offset =
> 		le16_to_cpu(vat20->lengthHeader);
> 	map->s_type_specific.s_virtual.s_num_entries =
> 		(sbi->s_vat_inode->i_size -
> 			map->s_type_specific.s_virtual.s_start_offset) >> 2;
> 
> lengthHeader is a fully attacker-controlled 16-bit value.  If it exceeds
> the VAT inode size, the s_num_entries subtraction underflows to a huge
> count, which defeats the "block > s_num_entries" bound in
> udf_get_pblock_virt15(); and on the ICB-inline path that function reads
> 
> 	((__le32 *)(iinfo->i_data + s_start_offset))[block]
> 
> so a large s_start_offset indexes past the inode's in-ICB data.  Mounting
> a crafted UDF image with a virtual (VAT) partition then triggers an
> out-of-bounds read.
> 
> Reject a VAT whose header length does not leave room for at least one
> entry within the VAT inode.
> 
> Fixes: fa5e08156335 ("udf: Handle VAT packed inside inode properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Thanks. I've added the patch to my tree. I'll just note that we need a
similar check for older format of VAT handled in that function as well.
I'll add that.

								Honza

> ---
>  fs/udf/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index cad2e15d633b..561eace476ab 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1263,6 +1263,14 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
>  
>  		map->s_type_specific.s_virtual.s_start_offset =
>  			le16_to_cpu(vat20->lengthHeader);
> +		if (map->s_type_specific.s_virtual.s_start_offset +
> +		    sizeof(__le32) > sbi->s_vat_inode->i_size) {
> +			udf_err(sb, "Corrupted VAT header length %u (VAT inode size %lld)\n",
> +				map->s_type_specific.s_virtual.s_start_offset,
> +				sbi->s_vat_inode->i_size);
> +			brelse(bh);
> +			return -EFSCORRUPTED;
> +		}
>  		map->s_type_specific.s_virtual.s_num_entries =
>  			(sbi->s_vat_inode->i_size -
>  				map->s_type_specific.s_virtual.
> 
> ---
> base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
> change-id: 20260612-b4-disp-9a2317ee-0042af154672
> 
> Best regards,
> -- 
> Bryam Vargas <hexlabsecurity@proton.me>
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
