Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BEB3A4511
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695844; cv=none; b=m8WzhHsOKZbgcpyKbDob1PoGrFXDdBThpcjwq8CcLh3RqtElszpZMFqMrTj9gig2aG/Sf86XMxaIE9lWnRnwlpJlri0BsHtJkBff8ftNxwlcOG3vNmUjRvmaFGkpBLbO4oZHrf+j2FVP6PLM6uZbW/gS/GCPfP6NqUGUqeq5Sd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695844; c=relaxed/simple;
	bh=czRM7YIKBHF5HXnmFZv2m1gGblvmAIniu5j/876gUYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPxlcgyV73ehVtlWrCa4hKa2LpJgE2QAITBO6pbOsyYFRH7KNjScnYZk5HV6XSjGQEQsk5CKrtQyxw/2coLQUdktVrMVe3YSJt0D8zDCL8mVmMJi1r5sjpcFachn/1t3zzO8hYY6gg519F0g+dVJZECb/sqD9MPGK6NGXVP9XV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybO8J8m8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NIgp8dDn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybO8J8m8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NIgp8dDn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybO8J8m8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NIgp8dDn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybO8J8m8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NIgp8dDn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 940B55BD1B;
	Mon, 20 Apr 2026 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4x7ayYmb2WldJf/6C37cs28wjJV8npfe0HZAepSevY=;
	b=ybO8J8m8pfZ+7DgL22b/lb9rm5rM+0fzRTm/B02lxEnyB3lfcTTaPPbrC0ySuQrY+CpeDO
	HNoDlKTg9PZr0RkPsO1hH4Dq4xk/tmxqH/DX4ZCj3c8+ljil6qfcpm6ZVB5ixetR1NO3wa
	mUni9QxVqyv0OtoqHJ4TNsrCkk7VtHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4x7ayYmb2WldJf/6C37cs28wjJV8npfe0HZAepSevY=;
	b=NIgp8dDngLoPcSXodmiYqUa77iHJ+QwSoY6o53mgfnaaW4VL16tRyk5eF0iZ0n2LviRVs1
	K4S53ZfyYWTD3GAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4x7ayYmb2WldJf/6C37cs28wjJV8npfe0HZAepSevY=;
	b=ybO8J8m8pfZ+7DgL22b/lb9rm5rM+0fzRTm/B02lxEnyB3lfcTTaPPbrC0ySuQrY+CpeDO
	HNoDlKTg9PZr0RkPsO1hH4Dq4xk/tmxqH/DX4ZCj3c8+ljil6qfcpm6ZVB5ixetR1NO3wa
	mUni9QxVqyv0OtoqHJ4TNsrCkk7VtHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4x7ayYmb2WldJf/6C37cs28wjJV8npfe0HZAepSevY=;
	b=NIgp8dDngLoPcSXodmiYqUa77iHJ+QwSoY6o53mgfnaaW4VL16tRyk5eF0iZ0n2LviRVs1
	K4S53ZfyYWTD3GAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8397B593AE;
	Mon, 20 Apr 2026 14:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VXUfICE65mmbcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 14:37:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 514E8A0BAC; Mon, 20 Apr 2026 10:32:23 +0200 (CEST)
Date: Mon, 20 Apr 2026 10:32:23 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
References: <20260417142503.1436446-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417142503.1436446-1-amir73il@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO

On Fri 17-04-26 16:25:03, Amir Goldstein wrote:
> + - Handle security issues promptly.  Filesystems parse complex on-disk
> +   structures from potentially untrusted media and must treat security
> +   reports with urgency.

I've commented on this in reply to Matthew. I agree syzbot results must be
reviewed and identified security issues treated in a timely manner. However
dealing with maliciously corrupted on-disk data isn't (IMO) a serious
attack vector. Even current well maintained filesystems (e.g. ext4 and
others) have some issues in this area so it seems unfair to ask this from a
new filesystem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
