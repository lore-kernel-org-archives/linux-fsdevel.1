Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F75835028C
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063364; cv=none; b=kO66VQbMnjMdlrd0BaNEi/0Xv2TXMOr22H+cFUo/4DNb3i8RpyohwucE149sg3nTffdFWhNB2IWKULbtyWVEF5+HS684bVWimNbKYChZDuNMCV01rVR2x9POamf0SxxGIShOpmBiRWjlYf7BuPOe0LAwmUoTA27W5LE3p7V8Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063364; c=relaxed/simple;
	bh=EB2cRpFzXsPl7F2w2V4LCRRlXaXB11FE/NxaITXlF+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkj+brt6bdyklLcuqXdH0AkWzd3CmClBM0wL+J9IkcrVGoJK79ucM7bZjPuwR4wthIUqTc6/yKLw3IlogGN2XnLDLry4y9De6p13qsq5oSkcI24ocN2yV2mCbXXog+yKG0yuWARiV1PXl/o8rjfEij8nkhUqF4KIwkKHmo6oQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jsd3/xep; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JL9zGDrM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BOG8zFs2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tmAM+ccs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jsd3/xep";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JL9zGDrM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BOG8zFs2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tmAM+ccs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C404C3E82;
	Tue, 18 Aug 2026 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787063298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQGelGCsB9DzG7kIUl03C0yP8ONbjI/sNiCgGw7LPck=;
	b=Jsd3/xepafNzNkU+7wjy7jjfjOMuakDjcR3Zxzk8GEHTQ2TeZbQ1FcIJjxnr+lSCVyr2oh
	QmaK8yZLOV+/RKX6Wg+wzLcklWc+GXQM0XSx1wukoMqtb1Ff8szyKSzYGT2Dcwlj7EeQby
	4esw2JXxRyn8g9a5CPFBuyXn89RyhuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787063298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQGelGCsB9DzG7kIUl03C0yP8ONbjI/sNiCgGw7LPck=;
	b=JL9zGDrMICEW3NoRxJUxKXw2ZN2AmXHGdYf54a8svA8tLUY/bA/bPf4bnTQsMZQZVyZFgm
	xzBVd+H2RjCz0mCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787063294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQGelGCsB9DzG7kIUl03C0yP8ONbjI/sNiCgGw7LPck=;
	b=BOG8zFs2TTbwygDoog4iftldMTVAUgbZ8FSglpZ6QEr2ZGmjoBXesLdF/ZegRtSmcFbRZ1
	VRRe0CKOJlR+JweIv8MzIC417hP1KZr8y9LmMfPRRcbKovKnml+86VZDw3TriVBQkgUXlM
	4UUWWeSTS9iSNO95WPAQ98Fah7cI2yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787063294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQGelGCsB9DzG7kIUl03C0yP8ONbjI/sNiCgGw7LPck=;
	b=tmAM+ccsKSABaVUdd10F/589/6OXbR0azaFBaX7MxqM5wuDmSlN5l9Jpb6/SLUEVAVNSd8
	X2D4EHDLAYxN7YBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC35022BA;
	Tue, 18 Aug 2026 14:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1WPvLf5rhGqIfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Aug 2026 14:28:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 78C82A13AB; Tue, 18 Aug 2026 16:28:14 +0200 (CEST)
Date: Tue, 18 Aug 2026 16:28:14 +0200
From: Jan Kara <jack@suse.cz>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: fix comment typo in bpf_fs_kfuncs.c
Message-ID: <wd4zznlz2utk7n5ga52jinitgvuotfgymyqqzixdoex2wimmpu@2giwhslspzo3>
References: <20260813093404.1278-1-manushprajwal555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813093404.1278-1-manushprajwal555@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]

On Thu 13-08-26 15:04:04, Manush Prajwal wrote:
> Fix "Rmove" -> "Remove" in the kernel-doc comments for
> bpf_set_dentry_xattr_locked() and bpf_set_dentry_xattr(). No
> functional change.
> 
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/bpf_fs_kfuncs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index f1863a891d..e8a5a4cffe 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -235,7 +235,7 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
>   * @dentry: dentry to get xattr from
>   * @name__str: name of the xattr
>   *
> - * Rmove xattr *name__str* of *dentry*.
> + * Remove xattr *name__str* of *dentry*.
>   *
>   * For security reasons, only *name__str* with prefix "security.bpf."
>   * is allowed.
> @@ -303,7 +303,7 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__st
>   * @dentry: dentry to get xattr from
>   * @name__str: name of the xattr
>   *
> - * Rmove xattr *name__str* of *dentry*.
> + * Remove xattr *name__str* of *dentry*.
>   *
>   * For security reasons, only *name__str* with prefix "security.bpf."
>   * is allowed.
> -- 
> 2.46.2.windows.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
