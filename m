Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1B3BADBD
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200277; cv=none; b=QTKmJuVOha5AuaPgId78J1RGHOCiqcyfJnNsBH+ckYRX25NLFmFe5fIwDqvi9BeyXcve30Owex0qoR5b/U0/ZTV0flKjuC+yzafUeFP1iZQVzFb1IwN6JK1K/wNaySf4trpqv2IWv7ZRJATGJQhpEKicLDpNuhYXeM5S/O9Bz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200277; c=relaxed/simple;
	bh=6M7jXIHCGtzdPhw2qsM41Hv0mXHg4c1P7aB1DUkRz6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eab7UJsJpn0AJd8GMOVv37svC5fllyx+qTgM9qwekeFmtWxtxcfTMhVrHi4Y66WAL88lNdfAbs0vswTsnZBwM+oak0Ruy2C8Px0Ltnr8Pas+8y4xcmfepML3Fj5E4eNzk3IzMJH0t5fVZwRqyTYopehEiEVHEEoTfouFSXt9Rt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ih1f2Ok6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AIBfgMTz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T8WmyiE6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bQdI4cqu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ih1f2Ok6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AIBfgMTz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T8WmyiE6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bQdI4cqu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D73D63E51;
	Thu, 16 Jul 2026 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784200272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpGIdc4n+6jDVSDAog/+Geb9BSEYh8TQula+4k7yDoE=;
	b=Ih1f2Ok6ogo1dzz9PxFjlueQDu6Ll0dAKtXfkAtK7S2AQKaPpaAY+1HpbJnbpJmhAMmjRf
	m3wm2f1vV0SglCPOVMUt13GScHr5tXSg7sy9INic4YYnV+zRB6YQrhba0WT4+Is4Xr3Djg
	/4gS/dtRx61BZxThmDSnqaNaeMFmTdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784200272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpGIdc4n+6jDVSDAog/+Geb9BSEYh8TQula+4k7yDoE=;
	b=AIBfgMTzhQAX8b/HsR4sYQ5Ca+mLxVwzTr+tevRYxZMCqVcvDF41ErHDtXPrBmnvgUUTnC
	i5YmUl6BOOnHjZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784200271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpGIdc4n+6jDVSDAog/+Geb9BSEYh8TQula+4k7yDoE=;
	b=T8WmyiE6Na45Lr3iR9sQlIZGFV0Sw+ZC579s7yjdqjaNdFj5KQGUVi4AYVnWwBWcOUBJMT
	gZQ9yz6wZVkysjuJubgjr39Ob7QSIh01S3QSpVLuxj/iLdf5cWQO4l2FP4Ec+1LhSXrgff
	appz+EaacbZ0TcuxWoV+JXQBUclMVEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784200271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpGIdc4n+6jDVSDAog/+Geb9BSEYh8TQula+4k7yDoE=;
	b=bQdI4cqu6xeVabY9RR7ENFt6iKbHHHOFJvFrGnLTOWtwCRdGncBVQQVc9nxTL1kG8km6VF
	WibRWLLojqIFerCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE5BF779AD;
	Thu, 16 Jul 2026 11:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IqNcMk+8WGpxfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jul 2026 11:11:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8084FA0855; Thu, 16 Jul 2026 13:11:03 +0200 (CEST)
Date: Thu, 16 Jul 2026 13:11:03 +0200
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] pidfs: preserve thread pidfds reopened by file handle
Message-ID: <ks7xfhn7pzzm267bcfo725xwqa6famsv5yulmzgqt7hjdmepep@zm2dw2djd7yb>
References: <20260716052726.1032092-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716052726.1032092-1-me@linux.beauty>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu 16-07-26 13:27:22, Li Chen wrote:
> PIDFD_THREAD shares O_EXCL. do_dentry_open() clears O_EXCL after
> pidfs_export_open() validates the flags, so open_by_handle_at()
> silently turns a thread pidfd into a process pidfd.
> 
> Restore PIDFD_THREAD on the opened file, matching pidfs_alloc_file(),
> and cover the restored flag with F_GETFL.
> 
> Signed-off-by: Li Chen <me@linux.beauty>

Makes sense. Just looking at this code, what about PIDFD_AUTOKILL (aka
O_TRUNC?)? Reading the commit introducing it 07c3ef58223e it appears it was
never meant to be directly requested by userspace so probably
pidfs_export_open() needs to reject it. But that's unrelated issue to your
patch so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c                                             | 8 +++++++-
>  tools/testing/selftests/pidfd/pidfd_file_handle_test.c | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index aaa609ddab044..c20ffd747ff51 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -939,12 +939,18 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
>  
>  static struct file *pidfs_export_open(const struct path *path, unsigned int oflags)
>  {
> +	struct file *file;
> +
>  	/*
>  	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
>  	 * O_RDWR as pidfds always are.
>  	 */
>  	oflags &= ~O_LARGEFILE;
> -	return dentry_open(path, oflags | O_RDWR, current_cred());
> +	file = dentry_open(path, oflags | O_RDWR, current_cred());
> +	/* do_dentry_open() strips O_EXCL, which encodes PIDFD_THREAD. */
> +	if (!IS_ERR(file))
> +		file->f_flags |= oflags & PIDFD_THREAD;
> +	return file;
>  }
>  
>  static const struct export_operations pidfs_export_operations = {
> diff --git a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
> index 68918734dcf32..1e03ae9575fe6 100644
> --- a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
> @@ -373,6 +373,7 @@ TEST_F(file_handle, open_by_handle_at_valid_flags)
>  				  O_CLOEXEC |
>  				  O_EXCL);
>  	ASSERT_GE(pidfd, 0);
> +	ASSERT_NE(fcntl(pidfd, F_GETFL) & PIDFD_THREAD, 0);
>  
>  	ASSERT_EQ(fstat(pidfd, &st2), 0);
>  	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
