Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED3478847
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061069; cv=none; b=Xo9q911NxGZ2iuNNlX9dxvmZMJSkYipSHKQTgg8OVZre5didGPSCkFUoaaYS2De256mqQ3sRNEQc5JKItFpc+kFIZ+NtJ+nmyhMwRnOyd1DhGKpT8+VUivfqmfjZDJ54z5AwvXWk/iEgW1RgFj9fFY2Edd5X5TbvjfATkSHmwTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061069; c=relaxed/simple;
	bh=7D4XGnCINZD0kCRj5p0nau+aIDsMcPiX9iDQf6/8fAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmMgmri46jjkhzsp97lgRvFp2bBLQGetMKnsmWRjmcAZ0gocvBspbFUQrlXbG1bnfgs5f/7118n7JpSDr3ROLV4VltvRvVRrx9f3N27ICWnEKmrfiKly1j/ASCcXsf4YlcJjrsXSoPyzvwUKR9VaeRsEzdqFbJ0WKq8nIjdu1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kdKwJuy0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/UTQMI83; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TYxNHsl5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=50xnfiq7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kdKwJuy0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/UTQMI83";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TYxNHsl5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="50xnfiq7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA17B4D305;
	Wed,  1 Apr 2026 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775061064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mrz8RGNPnc70Z3dHVGCi2lu4rxIGK4ux7WnKlXn2C/g=;
	b=kdKwJuy0UBpqF0REXKiYrycjhFEDj88ArmAFMKWx0aigay4qXABcXiYWhV5Vs3fyV++4PX
	1KygErYcy9e0b4eMNoSia9Wegf1KXN8B+W5ka2j6vpJ1pAffr5GjlSHh4Iq1aHYc8Ta7FB
	hc7Wl6yixXay6+DQId2KIctOJ1tqaj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775061064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mrz8RGNPnc70Z3dHVGCi2lu4rxIGK4ux7WnKlXn2C/g=;
	b=/UTQMI83VujbE9Aqz4uiv9sx8QQehwtEfRAair6N+2q5PwEAFfXHkEj+V30ZZCPds/a/mW
	1niisYnxaDvjqpDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775061063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mrz8RGNPnc70Z3dHVGCi2lu4rxIGK4ux7WnKlXn2C/g=;
	b=TYxNHsl5JoNtIy1qm/6aDNv3T/YMZXjSTktIbhtRO9SF8JDwxqOn7CRQPh9RWMSGjbVhiT
	sHFrFu6FQjTPc1oZBhc3nWCQ4D3H0HE4CTg772rW8NNldwxHeg8MX8g9x4Th+5a1W30M9y
	SelhCHMSwcm3hqTI2hjqxtt3gWPLiQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775061063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mrz8RGNPnc70Z3dHVGCi2lu4rxIGK4ux7WnKlXn2C/g=;
	b=50xnfiq7NYzZZ8FIF0cDtpb6iTdu2KYT8uCqtvwHuuRr86pBNcYsBPsAsi1pOqwAmZZYD6
	waiW9wJwtmFjSHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D18C04A0B0;
	Wed,  1 Apr 2026 16:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CkgiM0dIzWksAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Apr 2026 16:31:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 819C7A0B39; Wed,  1 Apr 2026 18:30:55 +0200 (CEST)
Date: Wed, 1 Apr 2026 18:30:55 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: use strnlen() in __set_task_comm
Message-ID: <wesnxxbjdbzstv2weyuyhcmorz3nuib6hz6msfxmrdlbuyow7x@e7rodhd7s7zm>
References: <20260401152039.724811-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401152039.724811-3-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,linux.dev:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 01-04-26 17:20:40, Thorsten Blum wrote:
> Use strnlen() to limit source string scanning to 'TASK_COMM_LEN - 1'
> bytes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9ea3a775d51e..ba12b4c466f6 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1074,7 +1074,7 @@ static int unshare_sighand(struct task_struct *me)
>   */
>  void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
>  {
> -	size_t len = min(strlen(buf), sizeof(tsk->comm) - 1);
> +	size_t len = strnlen(buf, sizeof(tsk->comm) - 1);
>  
>  	trace_task_rename(tsk, buf);
>  	memcpy(tsk->comm, buf, len);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
