Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D513D091F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534412; cv=none; b=RJuWJtZfWAwaJejABg03dIeVxhsMi1XkEl07MbeSgdl6vtg3MJknb2BxB4vwk19LSBLwmR3dzTbNRHapJ1w3bqU1RW0SLOKXGRiikWUlF/M/SlmBWhHOEqs+9UBaORMsdPaTmiO2J4IsnlqA1kZ+iieMbNjwCc8M2d99NH0by/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534412; c=relaxed/simple;
	bh=6GB+rL5AtFOV0IYK43qjfbBG7eqPQsL8Y/De31outEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FopN6u2GZaQ0S6F6M5L0T9cNrxrlnS4GllL/EVMS/KLVPV9PCSwev8VbCCmhMrtESivjoSkDps0ZoyMZiFVx/ICUox0vs9BsfS+ERJm9d/V9ODB9Ev2jUn3VD5EdfGqrvU00lY3ZL16I+zoC8ZoD8qXzMQxzEMd3xS9mUQUPvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NtJD3dKQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqkkyGob; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NtJD3dKQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqkkyGob; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NtJD3dKQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqkkyGob";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NtJD3dKQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqkkyGob"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69A6D6A7DE;
	Thu, 30 Apr 2026 07:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777534389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plbWhxNpYLeFGBJno02mxGZasSRd9/GHoMSBEMAOw1U=;
	b=NtJD3dKQmImdKYxPBncDXLDM6GDPWdV27+yU1j8EzxJDWx0KB1+EIhkn4dPSz8tCL6/AK6
	CSPrnZgi5hCJsOiU/lsl1mLp6WBBn1jnwNJR7ya4vNoDbR79k/QF02DaBYcO8JbFL9178H
	khXQtlJc8UirWQv10ZqMq7XAqZ5phD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777534389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plbWhxNpYLeFGBJno02mxGZasSRd9/GHoMSBEMAOw1U=;
	b=lqkkyGobM8sV9afYp4hC+q/Ub7h7P+Ydp3RjvzlO9A4g7teUYroxMMaLkJ5bGMo5DJdYb/
	/P6ehIBBGZJ1mtCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777534389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plbWhxNpYLeFGBJno02mxGZasSRd9/GHoMSBEMAOw1U=;
	b=NtJD3dKQmImdKYxPBncDXLDM6GDPWdV27+yU1j8EzxJDWx0KB1+EIhkn4dPSz8tCL6/AK6
	CSPrnZgi5hCJsOiU/lsl1mLp6WBBn1jnwNJR7ya4vNoDbR79k/QF02DaBYcO8JbFL9178H
	khXQtlJc8UirWQv10ZqMq7XAqZ5phD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777534389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plbWhxNpYLeFGBJno02mxGZasSRd9/GHoMSBEMAOw1U=;
	b=lqkkyGobM8sV9afYp4hC+q/Ub7h7P+Ydp3RjvzlO9A4g7teUYroxMMaLkJ5bGMo5DJdYb/
	/P6ehIBBGZJ1mtCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E759593B0;
	Thu, 30 Apr 2026 07:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jswhE7UF82mOTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Apr 2026 07:33:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19083A07AC; Thu, 30 Apr 2026 09:33:01 +0200 (CEST)
Date: Thu, 30 Apr 2026 09:33:01 +0200
From: Jan Kara <jack@suse.cz>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	clm@meta.com, kernel-team@meta.com
Subject: Re: [PATCH] fs/select: reject negative timeval components in
 kern_select()
Message-ID: <gyswxhot4ze7u47kxhljzcwd4bjvutq5yrwlir5x37ulry2grc@52i7icjp6rki>
References: <20260429-timeval-v1-1-4448e2588bbf@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-timeval-v1-1-4448e2588bbf@debian.org>
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 29-04-26 06:09:37, Breno Leitao wrote:
> kern_select() normalises the user-supplied struct __kernel_old_timeval
> with
> 
> 	tv.tv_sec + (tv.tv_usec / USEC_PER_SEC)
> 	(tv.tv_usec % USEC_PER_SEC) * NSEC_PER_USEC
> 
> before calling poll_select_set_timeout() -> timespec64_valid().  Both
> operands of the seconds sum are unbounded user-controlled signed long.
> A crafted pair where tv_usec is a negative multiple of USEC_PER_SEC
> drives the sum across the wrap boundary - e.g.
> 
> 	{ .tv_sec = LONG_MIN, .tv_usec = -1000000 }
> 
> yields sec = LONG_MAX, nsec = 0, which passes timespec64_valid() and
> then flows through timespec64_add_safe(), which saturates the absolute
> deadline to TIME64_MAX (clamped further to KTIME_MAX downstream).
> select(2) therefore blocks effectively forever instead of returning
> -EINVAL as POSIX requires for a negative timeout.
> 
> Only the legacy __NR_select syscall takes this path.  pselect6, ppoll,
> poll and epoll_pwait2 all hand the user's two fields directly to
> poll_select_set_timeout(), which validates *before* doing any
> arithmetic:
> 
> 	/* fs/select.c:271 -- the validator */
> 	int poll_select_set_timeout(struct timespec64 *to, time64_t sec, long nsec)
> 	{
> 		struct timespec64 ts = {.tv_sec = sec, .tv_nsec = nsec};
> 		if (!timespec64_valid(&ts))
> 			return -EINVAL;
> 		...
> 	}
> 
> 	/* include/linux/time64.h:97 -- timespec64_valid */
> 	if (ts->tv_sec < 0)                              return false;
> 	if ((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)  return false;
> 
> 	/* fs/select.c:744  do_pselect() (pselect6, pselect6_time32) */
> 	if (get_timespec64(&ts, tsp)) return -EFAULT;
> 	if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec)) return -EINVAL;
> 
> 	/* fs/select.c:1097 ppoll */
> 	if (get_timespec64(&ts, tsp)) return -EFAULT;
> 	if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec)) return -EINVAL;
> 
> 	/* fs/select.c:1065 poll -- timeout_msecs is int; >= 0 gates the math */
> 	if (timeout_msecs >= 0)
> 		poll_select_set_timeout(to, timeout_msecs / MSEC_PER_SEC,
> 		                        NSEC_PER_MSEC * (timeout_msecs % MSEC_PER_SEC));
> 
> 	/* fs/eventpoll.c:2512 epoll_pwait2 */
> 	if (get_timespec64(&ts, timeout)) return -EFAULT;
> 	if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec)) return -EINVAL;
> 
> In every one of these the wrap-prone arithmetic from kern_select()
> simply does not exist; the user fields reach timespec64_valid()
> unmodified.  glibc routes the C-library select() through pselect6,
> so the bug is reachable only via a direct syscall(__NR_select, ...).
> 
> The pre-validation negative check that used to live here was lost
> when the syscall was switched to the poll_select_set_timeout() helper.
> Restore it: reject tv_sec < 0 || tv_usec < 0 up front, mirroring what
> glibc does in userspace.  do_compat_select() has the same arithmetic
> pattern but is only reachable on 32-bit compat and from a different
> syscall entry; left for a follow-up so this change stays minimal.
> 
> Reproducer (returns -1/EINVAL on a fixed kernel; blocks indefinitely
> on an unfixed one):
> 
> 	struct timeval tv = { .tv_sec = LONG_MIN, .tv_usec = -1000000 };
> 	fd_set r;
> 	int pfd[2];
> 	pipe(pfd);
> 	FD_ZERO(&r);
> 	FD_SET(pfd[0], &r);
> 	syscall(__NR_select, pfd[0] + 1, &r, NULL, NULL, &tv);
> 
> Fixes: 4d36a9e65d49 ("select: deal with math overflow from borderline valid userland data")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Looks good. I just wonder whether we shouldn't also check that tv.tv_usec <
USEC_PER_SEC. But in any case feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/select.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 75978b18f48f8..bf71c9838dfe1 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -708,6 +708,17 @@ static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
>  		if (copy_from_user(&tv, tvp, sizeof(tv)))
>  			return -EFAULT;
>  
> +		/*
> +		 * Reject negative components before normalisation. The seconds
> +		 * sum below is performed in signed long and a crafted negative
> +		 * timeval can wrap to a positive value that passes
> +		 * timespec64_valid() and turns into an effectively-infinite
> +		 * deadline via timespec64_add_safe()'s saturation, instead of
> +		 * the -EINVAL POSIX requires for negative timeouts.
> +		 */
> +		if (tv.tv_sec < 0 || tv.tv_usec < 0)
> +			return -EINVAL;
> +
>  		to = &end_time;
>  		if (poll_select_set_timeout(to,
>  				tv.tv_sec + (tv.tv_usec / USEC_PER_SEC),
> 
> ---
> base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
> change-id: 20260429-timeval-8a3498dde479
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
