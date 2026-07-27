Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44553B42D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167636; cv=none; b=cgkIiiVYAS5QtPnk0mg780fnxRUnCBW4JLhPnFmJR17ZRa5z4vlhM/td7BraBbU+0YJFlbIsq2dE6xECvDCbBmWQFXK6T9Re48mrIvMK9RVrKin0uaMqj6+uNlGWE+4CZ/FB3ESehe7Bp21v1Cua/3klysVceNx+oY3med/wWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167636; c=relaxed/simple;
	bh=PQpsokXER4K7Glv8QPD76N73tkNS8S+gI3mU1IJKFNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UppaarqOomN2EgcxJOizM9YjPAqfZfWit93aSKhseNHB6/JIO6b2PJxoQmWYG0tXOWYYXlp8urx64bSgu7R1IOIDF2Yo+XAVqyE1siinquwyMaEGqBZxi+tHWCu41uJPKIRYaKuesvAeAePewZDEbokg/S8s2p7fDxs5bAFGK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tZSNr4LZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=313a4l7w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r2qKVn5w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+2VWC0y0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZSNr4LZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="313a4l7w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r2qKVn5w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+2VWC0y0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB7434015;
	Mon, 27 Jul 2026 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785167628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCAkwJDJahcpe263LcPp92lUoKA8MWt+sIoO6Xpo+fs=;
	b=tZSNr4LZ1kco1FAqEs22i5E6n7+4ylJmAQX0RYb+u6Swh7T7iD218/vQm7vQo62H+0KhQt
	F84o2ydu2FKh1yMw8I/0Hb7aB4GlbWLs2T+FAOjOzGq3NoySnuRMo90SOnLig6M0MF/EGh
	OXqGvtSDCjedoADFntRe3oDs8Y5SSwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785167628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCAkwJDJahcpe263LcPp92lUoKA8MWt+sIoO6Xpo+fs=;
	b=313a4l7wbJxyZPxg3gYPKhTu7V6PTsG0IIKn6NhAT140A/nD5WQnCGUXmYNe6A940FX5br
	2YkEQU2N6Yo5xSBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785167624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCAkwJDJahcpe263LcPp92lUoKA8MWt+sIoO6Xpo+fs=;
	b=r2qKVn5wD1+yg5835CVPs+v2HIWJgwOMrlXA3TfIzHczhwjnnHi3QLYuvX7KCTvlxTBkrD
	T7ABS1a7AaPdaI13WJyaFcA6M4fP7IjrrmgzxBk5a/0/n69SL2Ydq+j5ie5cQiO7H7sW5s
	O+JXyUeMM2TofWl8BmsSmQ+k2VyHLs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785167624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCAkwJDJahcpe263LcPp92lUoKA8MWt+sIoO6Xpo+fs=;
	b=+2VWC0y05/3pfH9RcOTm2oaYt1jUNIQmKwSKSUXOpG99eTG+/JNu1UbAdrwdt83I6G5j8v
	W23FFd/X/lcr2KDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3EAB779B9;
	Mon, 27 Jul 2026 15:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xIrkKwh/Z2oAFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Jul 2026 15:53:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5F194A0BA1; Mon, 27 Jul 2026 17:53:36 +0200 (CEST)
Date: Mon, 27 Jul 2026 17:53:36 +0200
From: Jan Kara <jack@suse.cz>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: Re: [PATCH] udf: Fix i_lenExtents truncation on 32-bit kernels
Message-ID: <jccun7ddkwrfmdjbmvwqgiuu775irnsg2zhg5l7cm57bxrte36@h7bdupdkx7of>
References: <20260722082425.213311-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722082425.213311-1-zhanxusheng@xiaomi.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,xiaomi.com:email]

On Wed 22-07-26 16:24:25, Zhan Xusheng wrote:
> In udf_do_extend_file() the total extent length is rounded up to a block
> boundary with:
> 
> 	iinfo->i_lenExtents = (iinfo->i_lenExtents + sb->s_blocksize - 1) &
> 			      ~(sb->s_blocksize - 1);
> 
> i_lenExtents is a __u64, but sb->s_blocksize is unsigned long.  On 32-bit
> kernels unsigned long is 32-bit, so ~(sb->s_blocksize - 1) is a 32-bit
> value (e.g. 0xfffff800 for a 2 KiB block) that is zero-extended in the AND,
> clearing the upper 32 bits of i_lenExtents.  For UDF files whose total
> extent length exceeds 4 GiB this truncates i_lenExtents when the file is
> extended, corrupting the tracked extent length.
> 
> Cast the block size to 64-bit before forming the mask.  64-bit kernels are
> unaffected.
> 
> Fixes: 48d6d8ff7dca ("udf: cache struct udf_inode_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/udf/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 67bcf83758c8..c519644acfd7 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -531,7 +531,7 @@ static int udf_do_extend_file(struct inode *inode,
>  			  sb->s_blocksize - 1) & ~(sb->s_blocksize - 1));
>  		iinfo->i_lenExtents =
>  			(iinfo->i_lenExtents + sb->s_blocksize - 1) &
> -			~(sb->s_blocksize - 1);
> +			~((u64)sb->s_blocksize - 1);
>  	}
>  
>  	add = 0;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
