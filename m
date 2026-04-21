Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA42C21E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775195; cv=none; b=b3Y+5ky8GhKfIVZqREhiGFuF9+2MoMXIg+RM+/LhIwGqBuYaai9bIAnvQR/qHjdrOCwOFmx0QgNsiSz8PlLJiK+OqbWgoLDUzq3atLQ8Oxtm12ZWQgT4o0hpHVsKZlLlBIHNZDippGuH7KUouOe3icFcqCcDzY5vS1x1zri8Yqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775195; c=relaxed/simple;
	bh=3CsHYJGOKqUYI+3eDeFyz0UwHJ3I7Ycs2PSGiu8I4+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1p+JCLi2pX/KCltLGCuV6Wpcd1WCODt/MOYqiluhmFvDE8/3ho7trSiaxfILVVTVLKUThwDcYOEFGzSigyo2XUqLYV+80jIxByYgIjdj2/dOiKOO8OlRptEz6bzW1yawW9qW6zaT1yN3H2Skgx2V4a/09ONNdWLJdbQVlphyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TdR1nGCr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1vLTrLMl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TdR1nGCr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1vLTrLMl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TdR1nGCr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1vLTrLMl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TdR1nGCr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1vLTrLMl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78D0E6A943;
	Tue, 21 Apr 2026 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776775192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4I8eBJx2YL10N5OSAsEn6AKQhjRgrdzCILMfTm2hVtM=;
	b=TdR1nGCrybitImmPRmZgTQC+bS6yteFktTXZfBb2HemDBCoJHqgWrMoZWu35e6CHbwthrL
	MI7xqe281Ws2Q8nJo5KqYvK9rOchAYr2BGRMZEvVpIB9m9sBJhuMrrqF2LivfGDKtoNHL7
	5NFhrMbGRu3eDGHC5Si9GrgYJLeBmRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776775192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4I8eBJx2YL10N5OSAsEn6AKQhjRgrdzCILMfTm2hVtM=;
	b=1vLTrLMlyftIHEYOuDfCl7PBMqjovCDEGeZa69Qs2EFWYRTgCnqaeoPK+cnC5wy/dM/JT3
	OSGF2P3ToSYe7OCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776775192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4I8eBJx2YL10N5OSAsEn6AKQhjRgrdzCILMfTm2hVtM=;
	b=TdR1nGCrybitImmPRmZgTQC+bS6yteFktTXZfBb2HemDBCoJHqgWrMoZWu35e6CHbwthrL
	MI7xqe281Ws2Q8nJo5KqYvK9rOchAYr2BGRMZEvVpIB9m9sBJhuMrrqF2LivfGDKtoNHL7
	5NFhrMbGRu3eDGHC5Si9GrgYJLeBmRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776775192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4I8eBJx2YL10N5OSAsEn6AKQhjRgrdzCILMfTm2hVtM=;
	b=1vLTrLMlyftIHEYOuDfCl7PBMqjovCDEGeZa69Qs2EFWYRTgCnqaeoPK+cnC5wy/dM/JT3
	OSGF2P3ToSYe7OCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F3F7593AF;
	Tue, 21 Apr 2026 12:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mmIkGxhw52lwXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Apr 2026 12:39:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 27E58A0AE1; Tue, 21 Apr 2026 14:39:52 +0200 (CEST)
Date: Tue, 21 Apr 2026 14:39:52 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	wangzijie <wangzijie1@honor.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Wei Yang <albinwyang@tencent.com>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: use strnlen() for name validation in __proc_create
Message-ID: <qhgpi6dwnbk2o2j2fwxpqq6ptmzge2ilymxtxxsyfg77zgfzmc@ckvtoqq2b6yu>
References: <20260421122648.56723-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421122648.56723-2-thorsten.blum@linux.dev>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,honor.com,kernel.org,zeniv.linux.org.uk,gmail.com,tencent.com,suse.cz,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Tue 21-04-26 14:26:47, Thorsten Blum wrote:
> Replace strlen(fn) with strnlen(fn, NAME_MAX + 1) when validating the
> final path component in __proc_create().
> 
> This preserves the existing name limit while bounding the length scan to
> one byte past the maximum name length. Handle empty names separately,
> and treat names longer than NAME_MAX as too long.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/generic.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 8bb81e58c9d8..3063080f3bb2 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -427,9 +427,13 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
>  	if (xlate_proc_name(name, parent, &fn) != 0)
>  		goto out;
>  	qstr.name = fn;
> -	qstr.len = strlen(fn);
> -	if (qstr.len == 0 || qstr.len >= 256) {
> -		WARN(1, "name len %u\n", qstr.len);
> +	qstr.len = strnlen(fn, NAME_MAX + 1);
> +	if (qstr.len == 0) {
> +		WARN(1, "empty name\n");
> +		return NULL;
> +	}
> +	if (qstr.len > NAME_MAX) {
> +		WARN(1, "name too long\n");
>  		return NULL;
>  	}
>  	if (qstr.len == 1 && fn[0] == '.') {
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
