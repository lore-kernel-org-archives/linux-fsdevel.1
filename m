Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283502773EE
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174929; cv=none; b=rc+j1JpAEdpgyI8tVGahcW7KcODG8Dg0wUOPyVmdoOz1nQiULByP9IZ/8bYQyshx1W/iAl3nuc/57hgsQg6HFvPjWjCocf8l9DAKgiG+UvsP0krYeIXL0VtvsIVm2NsRFCZluyJ3sTxYyqgTYl4AxL6GMx7hrjmX2rGEENWkB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174929; c=relaxed/simple;
	bh=/0Pfm8yg5Hi20fkvCP6rh4iKXjE1hyR/7xqigvR5UXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEK4H3vGRQorRY2uPwtuSPuM1oFLJBTHjFBjbVPuAtkfu81ZMUwORAv7iMa3et4OFzsTN9mwAWUNsf0zkLOilrz93ntVTn+I+tlEDjYjJYVAcH/nX53hRg/OIM+0AWJ6t2ZDJJ1c0EbPSHmNlRuNaV2e8A3+CpGCFlEmJHqu9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IIGUxHaz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H81de6h2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IIGUxHaz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H81de6h2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIGUxHaz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H81de6h2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIGUxHaz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H81de6h2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01A2F337E8;
	Fri, 23 Jan 2026 13:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769174926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKZbv8HP1lHjem4ZlORk52SmSzDh2FsHRLWWPU2yAQk=;
	b=IIGUxHazUDX5fFXFgdVVkoI0tsDV+AFKQ4OmjfsVHc4kScOkT9azZPC/HBDIwOeCDsUnEo
	xDlYzhUsPh17WilCJvvUFA9rzeXyLzOZyZmPWcxC40ywJUs3ISsMJYV+Do1k+AfzMzt2iC
	qQBtd4sbdfIO21EC4nbrBn0Cgq131B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769174926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKZbv8HP1lHjem4ZlORk52SmSzDh2FsHRLWWPU2yAQk=;
	b=H81de6h2n8wADz4jhN8mbj8pP0sA45VE8Q0bsBq3LSyMZO2so2R2y6LKIbPA5q4pGdxbFZ
	kKKB5j0GuwOP3wDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769174926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKZbv8HP1lHjem4ZlORk52SmSzDh2FsHRLWWPU2yAQk=;
	b=IIGUxHazUDX5fFXFgdVVkoI0tsDV+AFKQ4OmjfsVHc4kScOkT9azZPC/HBDIwOeCDsUnEo
	xDlYzhUsPh17WilCJvvUFA9rzeXyLzOZyZmPWcxC40ywJUs3ISsMJYV+Do1k+AfzMzt2iC
	qQBtd4sbdfIO21EC4nbrBn0Cgq131B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769174926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKZbv8HP1lHjem4ZlORk52SmSzDh2FsHRLWWPU2yAQk=;
	b=H81de6h2n8wADz4jhN8mbj8pP0sA45VE8Q0bsBq3LSyMZO2so2R2y6LKIbPA5q4pGdxbFZ
	kKKB5j0GuwOP3wDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3110136AA;
	Fri, 23 Jan 2026 13:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6hVkN413c2m2agAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 23 Jan 2026 13:28:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9E9BA0A1B; Fri, 23 Jan 2026 14:28:45 +0100 (CET)
Date: Fri, 23 Jan 2026 14:28:45 +0100
From: Jan Kara <jack@suse.cz>
To: Shawn Landden <slandden@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: isofs: support full length file names
Message-ID: <6ihm5cyg54nv4lwoikvcpejws6vwu2rzevkdwm3ufshan4liti@qfpcl2toy6md>
References: <CA+49okpQYfsg=6AwZ_CGGPSYP0Hed0-+RELwzHg5ovZyXiZFFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+49okpQYfsg=6AwZ_CGGPSYP0Hed0-+RELwzHg5ovZyXiZFFA@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 22-01-26 13:33:35, Shawn Landden wrote:
> commit 561453fdcf0dd8f4402f14867bf5bd961cb1704d (HEAD -> master)
> Author: shawn landden <slandden@gmail.com>
> Date:   Thu Jan 15 21:44:11 2026 +0000
> 
>     isofs: support full length file names (255 instead of 253)
>     Linux file names can be up to 255 characters in
>     length (256 characters with the NUL), but the code
>     here only supports 253 characters.
> 
>     I tested a different version of this patch a few
>     years back when I fumbled across this bug, but
>     this version has not been tested.

Thanks for the patch! Can you please add proper Signed-off-by line so that
the patch can be merged (see Documentation/process/submitting-patches.rst)?
Also please use NAME_MAX constant instead of hardcoded 255 value. Finally
I'd note that I didn't find anything in the Rockridge standard that would
limit alternate name length even to 255 characters and Linux kernel
supports upto PATH_MAX long path components. But at the same time I think
there's no practical value in supporting longer file names, only larger
chance of breaking something somewhere so I think NAME_MAX is a good value
to pick.

								Honza

> diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
> index 576498245b9d..094778d77974 100644
> --- a/fs/isofs/rock.c
> +++ b/fs/isofs/rock.c
> @@ -271,7 +271,7 @@ int get_rock_ridge_filename(struct iso_directory_record *de,
>                                 break;
>                         }
>                         len = rr->len - 5;
> -                       if (retnamlen + len >= 254) {
> +                       if (retnamlen + len > 255) {
>                                 truncate = 1;
>                                 break;
>                         }
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
