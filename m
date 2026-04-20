Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72B3DB63C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695850; cv=none; b=rH11nO86W6TX3KcveIuNV2OAg0mbuPXWqing6fWq0+b+vYZK43AW4PNXb5Hvv7Osi5rUJ5+75qMfzcgaHWv4BBAG9/GFsGVmkcVjiRUvneaonxsup8OYvyo6Fi0FvNWIOFSUkj2w1tyUy34OdtK6jZaCCSoqrZ99hSBjgum2ZTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695850; c=relaxed/simple;
	bh=ClmPdM7ffGybcNdo1qDbKfTjkao5KqVmTCj1Ud4OpKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkzhgFVXJ/IRDcezPRPMmW93QlMnJAnJdqnmk3CO3tru5THXYyiJnv/1lXqjhih4tSma9pZnaQt8CxShPWIxnquHNgDo3EDDtXlyKRivmB7oi6UFJ2LFbGcbjlQM+Pj5mKz2g1ZuOeiPrVRNrO8FnlLkN9aRpIGRMGaoYqGKuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HxQSY2Ie; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OazZq1X/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HxQSY2Ie; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OazZq1X/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HxQSY2Ie";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OazZq1X/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HxQSY2Ie";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OazZq1X/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D1245BD6B;
	Mon, 20 Apr 2026 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fAJDeoEx2MfOncwdtK7TNF9S0AtJfWSokIAVjKghDM=;
	b=HxQSY2IesT03TcFQJ4YrSAu2LeeI30LqcKX5FABekeWoHV2VyjbQMYEi6GC6g+Mus+NyuN
	E/djr7aF8pALSaYuB9edmf4SAe7z4S3P6mPr3Vhn4bUU9FbzlvZwth3axH1cu7LD/JVleY
	Hk8kVS/sgXNCTfiyEY9cRS+/bx9F50w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fAJDeoEx2MfOncwdtK7TNF9S0AtJfWSokIAVjKghDM=;
	b=OazZq1X/AZiKhp2ES+FUr3L99cXeKnCp7Es2MBy9XeiLblCJfNNx0T1pSxBv1tRCrFee0f
	zFduJZGPpl/g48Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fAJDeoEx2MfOncwdtK7TNF9S0AtJfWSokIAVjKghDM=;
	b=HxQSY2IesT03TcFQJ4YrSAu2LeeI30LqcKX5FABekeWoHV2VyjbQMYEi6GC6g+Mus+NyuN
	E/djr7aF8pALSaYuB9edmf4SAe7z4S3P6mPr3Vhn4bUU9FbzlvZwth3axH1cu7LD/JVleY
	Hk8kVS/sgXNCTfiyEY9cRS+/bx9F50w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fAJDeoEx2MfOncwdtK7TNF9S0AtJfWSokIAVjKghDM=;
	b=OazZq1X/AZiKhp2ES+FUr3L99cXeKnCp7Es2MBy9XeiLblCJfNNx0T1pSxBv1tRCrFee0f
	zFduJZGPpl/g48Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B49A593AE;
	Mon, 20 Apr 2026 14:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aqBCFiM65mnNcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 14:37:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE9ADA0B9D; Mon, 20 Apr 2026 09:41:00 +0200 (CEST)
Date: Mon, 20 Apr 2026 09:41:00 +0200
From: Jan Kara <jack@suse.cz>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fanotify: Fix spelling mistake "enforecement" ->
 "enforcement"
Message-ID: <i2tnrhbaxvjs6hivxu6il6kkeug5gtwdxkvuulpgugdeqmj2k3@6bzwd7om7gd3>
References: <20260418-fanotify-typo-v1-1-03ea48cb44ba@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418-fanotify-typo-v1-1-03ea48cb44ba@ethancedwards.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,ethancedwards.com:email];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sat 18-04-26 20:42:30, Ethan Carter Edwards wrote:
> There is a spelling mistake in a comment. Fix it.
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>

Thanks. Patch queued up.

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index bfe884d624e7..38290b9c07f7 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -457,7 +457,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	/*
>  	 * Unlike file_handle, type and len of struct fanotify_fh are u8.
>  	 * Traditionally, filesystem return handle_type < 0xff, but there
> -	 * is no enforecement for that in vfs.
> +	 * is no enforcement for that in vfs.
>  	 */
>  	BUILD_BUG_ON(MAX_HANDLE_SZ > 0xff || FILEID_INVALID > 0xff);
>  	if (type <= 0 || type >= FILEID_INVALID || fh_len != dwords << 2)
> 
> ---
> base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
> change-id: 20260418-fanotify-typo-c4ec2ad325f0
> 
> Best regards,
> -- 
> Ethan Carter Edwards <ethan@ethancedwards.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
