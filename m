Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398B386C03;
	Thu,  1 Oct 2026 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844637; cv=none; b=p04jhCV1iYsH1k54unt29twu2oEGFE6rcyFS5Fj/Cfs6w7ld4B11e/b3E18IVUWTu9fTXNUW+UvXJrDtUU2r9ZSHQQ16yKQKi9Y8bq4zFchcWc5Pi4xNr1ji/Tdp4VZo8pk2tt3r3T6Cz/2CimDhxWE5KlZQ/NCVbpD8FJnoAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844637; c=relaxed/simple;
	bh=jy3gRsvqxi0XsPler2paCB2xXz4q+5V2nOoLwJi/s18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESla3ymfgGRCVzuacSvkrDfLUhLXE6Fnw0XgXI0Q+gKxoy8ItxinEUgBB3cyfCUXrD+5dM83zD3gFFrUImRPuXKoDgqoLN7YOwHvh5iThRXxLg38amqTeu74/4M406ahlIxXAzjecw6kru65SQp5zmwWKNoOaV1SA/vDZi76xek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sMJrRmeh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jGV3gPfI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rFRDVkOX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VNhtCYin; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sMJrRmeh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jGV3gPfI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rFRDVkOX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VNhtCYin"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51EA81F7C0;
	Thu,  1 Oct 2026 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790844629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSw6n7xFIENIOV0oN9bjZYdD7KbnM11W59/n1GIX7yU=;
	b=sMJrRmehqTeTP/BJXa4qf3FY92QQUZql7TLnxCd0l3+dYEX3Uweyi1e6wAB9+yIbx9Pula
	D3ELHqCOu7iFOoBTzQV5HgAnTnljbt2zq5QJAaG8yiL5IfmzvxEXmQO8TxZLl/jYkHDfmn
	uVV7QPyuTeF2mj39HbGNbohsFmEtF6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790844629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSw6n7xFIENIOV0oN9bjZYdD7KbnM11W59/n1GIX7yU=;
	b=jGV3gPfI1qpNzIqK4QQPTCjiQb6lYtZHfi35P6U8N/Yn8I2br47C5ZGLd90LB4UYjVpjzs
	o77SDON8k6CP21Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790844625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSw6n7xFIENIOV0oN9bjZYdD7KbnM11W59/n1GIX7yU=;
	b=rFRDVkOXaERe1pTfUzwreVR9AGEhn/r8nybLjMKY+MC5CkiK3AZoYRsDBeU2HdfOaH9DHf
	xy+zSla9P2V5DdaSJuxH00w+kYcpQ8HgImtR1YSnA8M7RffOWt/PEumckfYZB6wD1JZhNY
	l3r7RYEukPyafupVqBSvYEYd1bmTc7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790844625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSw6n7xFIENIOV0oN9bjZYdD7KbnM11W59/n1GIX7yU=;
	b=VNhtCYinB01EIX0GTyDWAizpvMWULAbODVi/Kp6p5Wx0DuImY+UAING4AONat2bp41N9p3
	YNSgtkDKCOiekTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21EDE134B3;
	Thu,  1 Oct 2026 08:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7LiaOtAevmoLewAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Oct 2026 08:50:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0DFEA13F7; Thu, 01 Oct 2026 10:50:20 +0200 (CEST)
Date: Thu, 1 Oct 2026 10:50:20 +0200
From: Jan Kara <jack@suse.cz>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] VFS: d_duplicate: repair comments to avoid kernel-doc
 warnings
Message-ID: <h56tz6lpjm4djnasmnxb6zffwwf7eorh2ufhxlk5hynqom7nir@452f47zazkpb>
References: <20261001021745.2160005-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001021745.2160005-1-rdunlap@infradead.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.cz:email,linuxfoundation.org:email,suse.com:email,linux.org.uk:email,brown.name:email,lwn.net:email];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:email,infradead.org:email,linuxfoundation.org:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,brown.name:email,linux.org.uk:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 30-09-26 19:17:45, Randy Dunlap wrote:
> Use a typical list style for comments to prevent kernel-doc warnings:
> 
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2029: ERROR: Unexpected indentation. [docutils]
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2030: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> 
> Also, modify the spelling of "whiteout" to match all other uses in
> the kernel source tree and to be consistent on the same line.
> 
> Fixes: 33d76519f0cc ("VFS: add d_duplicate()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v3: use one colon for the list, not "::" for a literal block (Neil).
>     Add linux-doc etc. to Cc: list.
> v2: dropped Jan's Reviewed-by since the patch changed.
> 
> Cc: NeilBrown <neil@brown.name>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> 
>  fs/dcache.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> --- linux-next-20260930.orig/fs/dcache.c
> +++ linux-next-20260930/fs/dcache.c
> @@ -2025,11 +2025,12 @@ EXPORT_SYMBOL(d_alloc);
>   * @dentry: the dentry to duplicate
>   *
>   * Some rename operations need to be combined with another operation
> - * inside the filesystem.
> - * 1/ A cluster filesystem when renaming to an in-use file might need to
> - *   first "silly-rename" that target out of the way before the main rename
> - * 2/ A filesystem that supports white-out might want to create a whiteout
> - *   in place of the file being moved.
> + * inside the filesystem:
> + *
> + * 1. A cluster filesystem when renaming to an in-use file might need to
> + *    first "silly-rename" that target out of the way before the main rename
> + * 2. A filesystem that supports whiteout might want to create a whiteout
> + *    in place of the file being moved.
>   *
>   * For this they need two dentries which temporarily have the same name,
>   * before one is renamed.  d_duplicate() provides for this.  Given a
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
