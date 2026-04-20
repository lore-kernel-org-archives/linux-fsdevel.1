Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A5313547
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700215; cv=none; b=VnXxkgZcFg2w92VxpWj/WDlk/OU+oMwicToObPuJwu9CiOe3a6Ml0UO/2VJj6KdC/azx0CcPsKCt8f6ZbfxGbvJlkaQkNC26wCtGrCFc2Y8w8h/MUPpKhGfJNeqCoQNafGAi9On0UQnAIvvHvbmHucUJyj5moV8nFFEQcjv6UwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700215; c=relaxed/simple;
	bh=pJHPkbj0zGIGILC4VBGPq85dh5ZmfSFQrNTBCbMwCDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP63ez0Dx5nPGh73OXp+/ITwBszkTJuqR2xx5AS7g74cHP9pMWUVhd/CrVF6y4xBEcR9A6Y/inMapCVgWpucKEyP3I4DhKxgBPVJwzpcyBWU1U262wlMQ0V4bcWfcPah4sDmldhKSwsoxmsW57EmKcvtufNep4Ca6jJHRT42TH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yrALJMBO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ZMNMdnI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yrALJMBO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ZMNMdnI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yrALJMBO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ZMNMdnI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yrALJMBO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ZMNMdnI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD0A55BCD7;
	Mon, 20 Apr 2026 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776700212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+O8jLVIvmydo3KfeUb97tJo2DVzie5fDGrI2KYfTX1E=;
	b=yrALJMBOSJcsDojeTuzaIhGzHbJwY8noXzo9mNpBOjjeg1FX77+hccLxzxY4Otx2ymvXQh
	bXGVl1AuFFQZVFA6yYbN8K4TyHPoal6s7oCtKlva7ek96a4OmCp/GdhW8FYlyVrL1pMcAo
	5PAWznFBCXvhPC4aaq6cihqIi0LpX4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776700212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+O8jLVIvmydo3KfeUb97tJo2DVzie5fDGrI2KYfTX1E=;
	b=6ZMNMdnICkGNn2O8u/PzmcDmexmZjmS8MI4XaKf5RJv/9rUMLM1142iuyfU4j/EDUOfBa5
	tFO+IHHJ/OSrtNBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yrALJMBO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6ZMNMdnI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776700212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+O8jLVIvmydo3KfeUb97tJo2DVzie5fDGrI2KYfTX1E=;
	b=yrALJMBOSJcsDojeTuzaIhGzHbJwY8noXzo9mNpBOjjeg1FX77+hccLxzxY4Otx2ymvXQh
	bXGVl1AuFFQZVFA6yYbN8K4TyHPoal6s7oCtKlva7ek96a4OmCp/GdhW8FYlyVrL1pMcAo
	5PAWznFBCXvhPC4aaq6cihqIi0LpX4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776700212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+O8jLVIvmydo3KfeUb97tJo2DVzie5fDGrI2KYfTX1E=;
	b=6ZMNMdnICkGNn2O8u/PzmcDmexmZjmS8MI4XaKf5RJv/9rUMLM1142iuyfU4j/EDUOfBa5
	tFO+IHHJ/OSrtNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E459593AE;
	Mon, 20 Apr 2026 15:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wSqlJjRL5mmROQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 15:50:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B668A0AFF; Mon, 20 Apr 2026 17:50:07 +0200 (CEST)
Date: Mon, 20 Apr 2026 17:50:07 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pidfs: don't report pidfd_info fields that won't fit
 in the user buffer
Message-ID: <uw4l3eotcpg2xu6db5ti6g7bf63hrxmrquxzpxxii5xi6z5cjk@2tmuzej7kons>
References: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
 <20260420-work-pidfs-v1-3-4bd614e1cb33@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-work-pidfs-v1-3-4bd614e1cb33@kernel.org>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: AD0A55BCD7
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 20-04-26 15:32:37, Christian Brauner wrote:
> The UAPI documentation for struct pidfd_info promises that if the
> structure provided by userspace is too small to contain a field, the
> kernel will not set the corresponding bit in the returned mask.
> 
> The kernel violates this contract: it sets PIDFD_INFO_COREDUMP and
> PIDFD_INFO_COREDUMP_SIGNAL in the returned mask without checking that
> usize >= PIDFD_INFO_SIZE_VER1 (the coredump fields start at offset 64,
> beyond a VER0 buffer). Similarly, PIDFD_INFO_SUPPORTED_MASK is set
> without checking usize >= PIDFD_INFO_SIZE_VER2.
> 
> While copy_struct_to_user() correctly only copies min(usize, ksize)
> bytes (so no kernel memory leaks), userspace that trusts the mask bits
> as documented may read its own uninitialized buffer and interpret it as
> valid data.
> 
> Gate each set of mask bits on the user-provided struct being large
> enough to actually deliver the corresponding fields.
> 
> Fixes: 9e77e4882bae ("pidfs: support retrieving supported pidfd_info flags")
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 2ab8fd2646f0..4c24d2eb7e41 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -375,7 +375,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  		}
>  	}
>  
> -	if (mask & PIDFD_INFO_COREDUMP) {
> +	if ((mask & PIDFD_INFO_COREDUMP) && usize >= PIDFD_INFO_SIZE_VER1) {
>  		if (test_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask)) {
>  			smp_rmb();
>  			kinfo.mask |= PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;

This sets also PIDFD_INFO_COREDUMP_CODE which only fits for VER2? I'm not
sure what's expected to happen for usize == VER1...

Otherwise the patch looks good.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
