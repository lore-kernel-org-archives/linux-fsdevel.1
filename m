Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A0284690;
	Thu, 27 Aug 2026 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829193; cv=none; b=FiEm4oxjupnmJLkrrW6VP6FEK3NzQfahUBSXy9ENUqYwaT7cIQgaZWyK8UwIq9K+gPK2m/Pqj2mmsJYk5xu1DtADounbUgb2s6E5FoIQIFMHTpi8i54BLalLSrbuuvx2l1HYa1yRD/wkhy+o4s/owHsTzC1h4bz2sEAIvj8sjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829193; c=relaxed/simple;
	bh=bTC6x/24k0isLblpzPLOwwPeAbmEkv0/EIyCKVCIMnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6pdIMn1cYeidx8wopNojeqAZmVDMCS3TMnQUrIQnq8F8VrImPMkEaaPCEGAUNYYHpmDzjP/d2SdcHslphGYJIxjj15Cb5HGc9epYpHGCiZ2YZ4A6xgGM7UPHUkXTeCkSn78mX0b3p2p0norpxkE1Kz9lbhuwOB1JhwHAHA2xvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w6pCQLuB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SMg0u+0A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcTQufRG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nyzjiJc9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w6pCQLuB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SMg0u+0A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcTQufRG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nyzjiJc9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD22B1F841;
	Thu, 27 Aug 2026 11:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787829183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zc2nVPHbEDtMm+7SYCSdS9Lgw0Mj1r3Q9/id4xINcx8=;
	b=w6pCQLuBUi6kgshHVeAQu2cRDZe+c/zB36HD7f5/+vKW3O9z/2W0F8rSMVDBD8J4Ky4Pfk
	iE8vUCUpmMxtspDmTP5KZvMMGX1E463nQScbpTHkMxwbVRi9ocVR/gM6SC+xSoIkJB4sSb
	B9sROcruDj7+8Ixb8x8HoerJq+dMHJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787829183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zc2nVPHbEDtMm+7SYCSdS9Lgw0Mj1r3Q9/id4xINcx8=;
	b=SMg0u+0AWa79eVQm8Aj+9z5nE9y4e9/lyCmCsaB0mdiaoh4o/fMjB43j9PfF00Za97EEpq
	hpU5pS+U/VCCDxBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LcTQufRG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nyzjiJc9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787829178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zc2nVPHbEDtMm+7SYCSdS9Lgw0Mj1r3Q9/id4xINcx8=;
	b=LcTQufRG+bO01qVw5fv+gVa7i4Q48nI+R+EqSl++rN463CHoo2LfRlPpbDPCVRQyPgELPy
	WXclsQsUGKrM1BIwOcoYnsOjIyudCXtJ8iViGSVEA+GHi3Dh+X5QBDSpKvufA2sh/rnlqD
	aM+7ywOJq78DYGsQV6rFr1AwwyKcVDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787829178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zc2nVPHbEDtMm+7SYCSdS9Lgw0Mj1r3Q9/id4xINcx8=;
	b=nyzjiJc9uZJOLhdSEWVg3x2jF9bJBtJmaKfG7RiiSMcXwxuH688zQrQyDRKeBjpGarum5L
	J337qOKgSvHHayAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B36F813354;
	Thu, 27 Aug 2026 11:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o5vKK7obkGrIYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Aug 2026 11:12:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 566D8A1324; Thu, 27 Aug 2026 13:12:54 +0200 (CEST)
Date: Thu, 27 Aug 2026 13:12:54 +0200
From: Jan Kara <jack@suse.cz>
To: Bill Wendling <morbo@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/2] vfs: Annotate struct fdtable's fd field with
 __counted_by_ptr
Message-ID: <7wmcr2qkkasokniszgbsegmglmyibshtq7ecwstwm5fwdidtom@67ubpgapnkte>
References: <20260810204118.1981755-1-morbo@google.com>
 <20260827041732.188707-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827041732.188707-1-morbo@google.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BD22B1F841
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.org.uk:email];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Thu 27-08-26 04:17:29, Bill Wendling wrote:
> The 'struct fdtable' holds the file descriptor table information,
> including the current file descriptor array 'fd' and its size 'max_fds'.
> To harden the kernel against out-of-bounds accesses, we can annotate the
> 'fd' pointer field with the '__counted_by_ptr' attribute, referencing
> 'max_fds'.
> 
> The compiler uses the '__counted_by_ptr' attribute to track the
> size of the memory allocated for the pointer field, enabling
> runtime bounds checks under KASAN and fortified functions. There are
> three places where a 'struct fdtable' is initialized, and in all of
> them, 'max_fds' is set before the 'fd' pointer is accessed or assigned
> in all allocation and initialization places.
> 
> No accesses to 'fd' occur before 'max_fds' is set, preventing any
> potential runtime false-positives or panics due to uninitialized count
> fields.
> 
> Assisted-by: Gemini:3.1-pro-preview
> Signed-off-by: Bill Wendling <morbo@google.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v3 - Add version to the PATCH subject line
> ---
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: codemender-patching+linux@google.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  include/linux/fdtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index c45306a9f007..3a5c88291125 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -25,7 +25,7 @@
>  
>  struct fdtable {
>  	unsigned int max_fds;
> -	struct file __rcu **fd;      /* current fd array */
> +	struct file __rcu **fd __counted_by_ptr(max_fds);      /* current fd array */
>  	unsigned long *close_on_exec;
>  	unsigned long *open_fds;
>  	unsigned long *full_fds_bits;
> -- 
> 2.55.0.897.gb25b4bd76c-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
