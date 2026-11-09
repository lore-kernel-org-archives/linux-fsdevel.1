Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222326;
	b=tfeAZKdKMPnYgfdR9R2+pxVHRULRPdCZSKuvyitdpmp5/dlHMUiKNqjrCtpHrOjvj5RD
	 0Ep633kdOqv2gvDZg0e5AYL+T8P36fwkiS+7wiiAmAALIWqxqgRoI7oGjfLCcoc42hdkg
	 2Fg3+eS3rIyU6jxTDNI1bOg6S6BlHJQLYUOVy1BEc7snqg7ObcAwQvmTJY+38NWIBqL41
	 vEBtRMXAq1T2BxlwGhl/CanFj2HGlm3fC2alFVs6/88KZdGBaRZd9Fes+1V6fTUHxsryv
	 6++eAO+/EpH9nswJuTf+UcRpPxEkAhrXZgqbYTaSoFEsbpsNrnbGye5ez/iA5Nr1a2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222326;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=wWFtQ4TQ5CeU0nqdqMwSweeVRMq27o66vvOsG+uH2r8=;
	b=0y5eOZMeuhmc52sQ78DaGUmaaBOT1AMgari9fvN/uX7aoyrOEzBEq+ToC0opat9CfhkZ
	 IP29Q0ZvmnR/P3ixtRP3evSnLgxzxKw0idErYxm52brBLF3fRKaVAptOU15RzPZea5oX2
	 p+uXEwbHtZZ3BaAaWDIGAaaQI+EBnEHctjtYPxyC7XZ5h/opPlQaSaeeX57G6pISoCFF3
	 kVbNF/CoZtINbE9HhLG+x9ih+/ZbLLJIiLHDxcVoj4Quuw9z8EKlg9v2hc9o7sGVqKLNU
	 jwoYZwKNxpUk7MAx6yAZHiWD6J5p4ttSqXGDysu/8+53tjTkW1GiRfpPpBgDpTCHvBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Z52LgjxR;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ySTWyVGk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Z52LgjxR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ySTWyVGk;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB152606A31C;
	Mon,  9 Nov 2026 11:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB152606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Z52LgjxR;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ySTWyVGk;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Z52LgjxR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ySTWyVGk
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 987E521E11;
	Mon,  9 Nov 2026 11:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794222323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWFtQ4TQ5CeU0nqdqMwSweeVRMq27o66vvOsG+uH2r8=;
	b=Z52LgjxRQ+uSgINi1sQ3a0lhgQX984kUJ/xNVi4kATxp2LTLk9LptokXOkzng5W/UK8l/p
	QXXQB/3yAKgAVdsIPYtSBFXa3NIpLAk/p6UfAnOx0I3Z/dfwFgjlfDu69gmnYPv6dkT3yj
	xry5syqXrhxoTSPbm/N2neJdlC6kdHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794222323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWFtQ4TQ5CeU0nqdqMwSweeVRMq27o66vvOsG+uH2r8=;
	b=ySTWyVGkWKWnH5J0TWOAq41TS8WXavD8bRY5+XvZXAkm8X5+6PVpRiP/7frFWIVaZQDtA7
	DaIw5NNLnFpGEpAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z52LgjxR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ySTWyVGk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794222323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWFtQ4TQ5CeU0nqdqMwSweeVRMq27o66vvOsG+uH2r8=;
	b=Z52LgjxRQ+uSgINi1sQ3a0lhgQX984kUJ/xNVi4kATxp2LTLk9LptokXOkzng5W/UK8l/p
	QXXQB/3yAKgAVdsIPYtSBFXa3NIpLAk/p6UfAnOx0I3Z/dfwFgjlfDu69gmnYPv6dkT3yj
	xry5syqXrhxoTSPbm/N2neJdlC6kdHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794222323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWFtQ4TQ5CeU0nqdqMwSweeVRMq27o66vvOsG+uH2r8=;
	b=ySTWyVGkWKWnH5J0TWOAq41TS8WXavD8bRY5+XvZXAkm8X5+6PVpRiP/7frFWIVaZQDtA7
	DaIw5NNLnFpGEpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C4F313319;
	Mon,  9 Nov 2026 11:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ALyqEfOo8WrqDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 11:05:23 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id EC4EE21EC1; Mon, 09 Nov 2026 12:05:18 +0100 (CET)
Date: Mon, 9 Nov 2026 12:05:18 +0100
From: Jan Kara <jack@suse.cz>
To: =?utf-8?B?TcOpdmVu?= Car <meven29@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	=?utf-8?B?TcOpdmVu?= Car <meven@kde.org>
Subject: Re: [RFC PATCH v2 1/3] fs: add filename_utimensat()
Message-ID: <35n54rrx6qq67j4fpxlvh67hal7zhmke2g5zcuhs5sbvxy22ez@nnnt4r4xng4r>
References: <20261104110604.126717-1-meven29@gmail.com>
 <20261104110604.126717-2-meven29@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104110604.126717-2-meven29@gmail.com>
X-Rspamd-Queue-Id: 987E521E11
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,kde.org:email,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -13.01

On Wed 04-11-26 12:06:02, Méven Car wrote:
> From: Méven Car <meven@kde.org>
> 
> Copy utilities that preserve timestamps, like cp -p or a file manager,
> set the times of every copy after its last write. To do that through
> io_uring, the request needs the utimensat() lookup on a name that was
> imported at submission time.
> 
> io_uring takes the path of a request when it is submitted and looks it
> up later, from a worker thread. The path ops it already has call the
> filename_*() helpers of fs/namei.c with a struct filename. utimensat(2)
> had no such helper: do_utimes_path() took the user pointer and imported
> the name itself.
> 
> Split the lookup and the vfs_utimes() call out of do_utimes_path() into
> filename_utimensat(), declared in fs/internal.h next to the other
> filename_*() helpers. do_utimes_path() now only imports the name.
> 
> Signed-off-by: Méven Car <meven@kde.org>

Looks ok. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/internal.h |  2 ++
>  fs/utimes.c   | 12 +++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index c658c8a5ebd5..985b2bc5895e 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -63,6 +63,8 @@ int filename_mknodat(int dfd, struct filename *name, umode_t mode, unsigned int
>  int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
>  int filename_linkat(int olddfd, struct filename *old, int newdfd,
>  			struct filename *new, int flags);
> +int filename_utimensat(int dfd, struct filename *name,
> +		       struct timespec64 *times, int flags);
>  int vfs_tmpfile(struct mnt_idmap *idmap,
>  		const struct path *parentpath,
>  		struct file *file, umode_t mode);
> diff --git a/fs/utimes.c b/fs/utimes.c
> index e22664e4115f..8072f05ac8dc 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -79,8 +79,8 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
>  }
>  EXPORT_SYMBOL_GPL(vfs_utimes);
>  
> -static int do_utimes_path(int dfd, const char __user *filename,
> -		struct timespec64 *times, int flags)
> +int filename_utimensat(int dfd, struct filename *name,
> +		       struct timespec64 *times, int flags)
>  {
>  	struct path path;
>  	int lookup_flags = 0, error;
> @@ -91,7 +91,6 @@ static int do_utimes_path(int dfd, const char __user *filename,
>  	if (!(flags & AT_SYMLINK_NOFOLLOW))
>  		lookup_flags |= LOOKUP_FOLLOW;
>  
> -	CLASS(filename_uflags, name)(filename, flags);
>  retry:
>  	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
>  	if (error)
> @@ -105,6 +104,13 @@ static int do_utimes_path(int dfd, const char __user *filename,
>  	return error;
>  }
>  
> +static int do_utimes_path(int dfd, const char __user *filename,
> +		struct timespec64 *times, int flags)
> +{
> +	CLASS(filename_uflags, name)(filename, flags);
> +	return filename_utimensat(dfd, name, times, flags);
> +}
> +
>  static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
>  {
>  	if (flags)
> -- 
> 2.56.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
