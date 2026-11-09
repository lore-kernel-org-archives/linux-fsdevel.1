Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231640;
	b=bCa5X+JnvhaLgUqV2mlkIaZISGqr+dvC7h8n0DVnVNOi9qU5ay/xFYtT+51vWlRjBIIJ
	 ExmEYVd2Tr+8fDb5qtslqWrXcDWAHUaXffvgbfKE2wcHelmCI4VtNNFpjS+2bfH/Vwyqy
	 nHrGQ5WaZ7Ofh7PpHasl0olRG2TzuaHEoM7H35rnihLopuVKj6QTdNhTKCu+5mh8wQE0J
	 2t5eQjUtk1PKWTKzci5T1Z0yFWMHvdlG1lFFECcs3TV5XVXT0F1npKadiA0Z2VJyxkXo6
	 ZuWn1mP1wLCklMZQjhUyDPPuCiJGIqNX27uMBJTOsGCVzSwgn7kz1F81uynoqiD/t8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231640;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=YKlOBeH8gV4FIJ99YcLzcvZDuRPHl6QktDUL10GYuYE=;
	b=RYMBhIteYjXn7GLe1CJQcuXVipgMXnOc8YaEFVUxT14t320tKZiRwsT2rFy4ClIo4lBK
	 N3pjNGqgrLhUJbeVHhCbnDa5evPuU5eaYTMaAe73m056xdI3+5WZ6v08mw2WQ7Kq9OzLb
	 K08cwzMt/8emUa6YLk/lAoZrlWpxDqFfwo1CRpgcqDXy0wdOOaTtdWg2B/JvJLJkQhKbK
	 a7dKW3aWhCKx3z96WpeypLTUXIb6ZgKGGbBM0T9RpYbJB3LT8rhQCp7XquP188RXjsJia
	 HF9ApB4IWiUDWwUdqVVk0jLe7d3ivZNA5D9owjTEySW7tmr/sMiG7qqXoA4gup4T1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=djIbTTuB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NVufgjsP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="e/He3PhI";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=j1hzkaId;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23607606A322;
	Mon,  9 Nov 2026 13:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23607606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=djIbTTuB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NVufgjsP;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=e/He3PhI;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=j1hzkaId
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB6B01F7B4;
	Mon,  9 Nov 2026 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794231638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKlOBeH8gV4FIJ99YcLzcvZDuRPHl6QktDUL10GYuYE=;
	b=djIbTTuBCG5UA8QfHLrNyNkx5shJqPVSx3lNOfk99wOLWwUK07C63HM3C4e5zrqUzANezO
	oD+2tN05rZ7aCNUVHFpTLaj3xosf84yta4wZykBJOHaTr1E5GhfbsTIYA8PTSAGOoklBiu
	fcGc6xdth/wXMy4fAxFj1NtCdxJUppk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794231638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKlOBeH8gV4FIJ99YcLzcvZDuRPHl6QktDUL10GYuYE=;
	b=NVufgjsP/KpdzNtw1W4+XiFooVOv7Hiw4PjTEm3+B+2ZhviXmHIMTpEZHCP4obByN+/vh1
	J9/+3giOGv9ssCDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="e/He3PhI";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j1hzkaId
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794231637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKlOBeH8gV4FIJ99YcLzcvZDuRPHl6QktDUL10GYuYE=;
	b=e/He3PhIvlKNTjLQeh+D2gVGAkbFPuZ7/GyRb77StNjYlkghw103UqLRYISCvka81FEgrQ
	eXEi5wLMZp0FKJmY0TrOxetu/Gq3CDWmsjOjocbWpKs3zxwgg9nHASXYdvZigpVikrf/xs
	WEx7UcfbprHRKOhZS/4CfycNg2IRLnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794231637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKlOBeH8gV4FIJ99YcLzcvZDuRPHl6QktDUL10GYuYE=;
	b=j1hzkaIdpDTZ34++xIdzlIuf6ueecxIR8P936UYYBItCDufvkkdcVp7yYc7kTEuCtLPMkl
	/cy+e54h5RkdbsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD80D13319;
	Mon,  9 Nov 2026 13:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qWYIKlXN8WpONwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 13:40:37 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 62F7522029; Mon, 09 Nov 2026 14:40:37 +0100 (CET)
Date: Mon, 9 Nov 2026 14:40:37 +0100
From: Jan Kara <jack@suse.cz>
To: xujiahao <xujiahao@cmss.chinamobile.com>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com
Subject: Re: [PATCH] udf: reject extents past EOF when extending a file
Message-ID: <5joviizuac2b2zzobk7v7kxwxwkahjfqpumcbgipa43577if5y@h37sjkjw2kja>
References: <20261109013952.449019-1-xujiahao@cmss.chinamobile.com>
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
In-Reply-To: <20261109013952.449019-1-xujiahao@cmss.chinamobile.com>
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[db6df8c0f578bc11e50e];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -11.51
X-Spam-Level: 
X-Rspamd-Queue-Id: EB6B01F7B4

On Mon 09-11-26 09:39:52, xujiahao wrote:
> udf_extend_file() warns when inode_bmap() reports the last extent as
> longer than the block the file is being extended in:
> 
> 	WARN_ON_ONCE(within_last_ext &&
> 		     elen > ((loff_t)offset + 1) << inode->i_blkbits);
> 
> A corrupted image can trigger this, as syzbot reports for
> udf_setsize():
> 
>   WARNING: CPU: 1 PID: 6098 at fs/udf/inode.c:684 udf_extend_file fs/udf/inode.c:683 [inline]
>   WARNING: CPU: 1 PID: 6098 at fs/udf/inode.c:684 udf_setsize+0xd5a/0x1010 fs/udf/inode.c:1300
> 
> The extent really is invalid, so there is nothing to warn about: report
> it with udf_err() and fail the truncate with -EFSCORRUPTED instead of
> tainting the kernel.
> 
> Reported-by: syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
> Fixes: 16d055656814 ("udf: Discard preallocation before extending file with a hole")
> Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>

Thanks! I've added the patch to my tree. I've just slightly modified the
error message to contain inode number.

								Honza


> ---
>  fs/udf/inode.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index bacf2a861..b68aee826 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -687,9 +687,14 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
>  	if (err < 0)
>  		goto out;
>  	within_last_ext = (err == 1);
> -	/* We don't expect extents past EOF... */
> -	WARN_ON_ONCE(within_last_ext &&
> -		     elen > ((loff_t)offset + 1) << inode->i_blkbits);
> +	if (within_last_ext &&
> +	    elen > ((loff_t)offset + 1) << inode->i_blkbits) {
> +		udf_err(sb, "extent past EOF: length %u, expected at most %lld\n",
> +			elen,
> +			(long long)(((loff_t)offset + 1) << inode->i_blkbits));
> +		err = -EFSCORRUPTED;
> +		goto out;
> +	}
>  
>  	if ((!epos.bh && epos.offset == udf_file_entry_alloc_offset(inode)) ||
>  	    (epos.bh && epos.offset == sizeof(struct allocExtDesc))) {
> -- 
> 2.43.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
