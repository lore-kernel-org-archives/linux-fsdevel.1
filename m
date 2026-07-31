Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98043F4DDB
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501148; cv=none; b=ETBJSj45tPk5LeNNFv6bIqikN61M+OuU58H+PHps75vQKZhAceNmHEAW7zTHff9k5QCV5PFDI2R3HYcXyw677P7xAcKRJALKxPB81708mkwG2yZ5VA8ZmVpPIuCyNAU/1WTXTUg0Fzfc7Wg+C3NWcYVHQNqxag8sBbGpSytgZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501148; c=relaxed/simple;
	bh=4x1l13tDZXaxk1RQu5M3cxNt766PPEayJN9o1cWxA/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPwBomAxo4/2xVYd+bvCqHNcOVZIiZA2Z3Eo42mNqZRChRtCtLHaZb44EktsqtYXCYjd4xUk6Y6VCiH4uKiVXZNas+QkokqwE2js1J0fnCKzUWeJ0OamFGEIDncXy7bfD3Z6lwyaa6aJ8GPKFTsD79uJOckPDvyW/9OmTvNrl00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z8AXXofJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4JARpdH9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGO9uSiZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FlJ8f+Qf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z8AXXofJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4JARpdH9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGO9uSiZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FlJ8f+Qf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95178410C;
	Fri, 31 Jul 2026 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785501140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBm/eTQW7pAs2FPRIDwtAbxXn/ODVdYs0PwQsRoanwo=;
	b=Z8AXXofJfNYlND2QROkNOxUcG0YqtPvkPAnuCGbF71G8gNJD/XmFrxHCiNkJ6GsR8CQO1B
	jUN9BBE6ru4A5LCSHDq5EjMvYakcnGaMtEtHifRq64BGBwsfmir8FmpdTuVo8GZvIyApB2
	xTBJzUs2gKT0A/PpcTZbuacKWHTIS9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785501140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBm/eTQW7pAs2FPRIDwtAbxXn/ODVdYs0PwQsRoanwo=;
	b=4JARpdH9nUhDXSwKpUXwEfVKYgZSl9iieFHZqC9yhJQRJzpD4Djcrv3Eo2kxujO+i+OJJS
	660Eby7jeFhn0ZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785501136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBm/eTQW7pAs2FPRIDwtAbxXn/ODVdYs0PwQsRoanwo=;
	b=qGO9uSiZyfZQz79UfLi6IoQ0OQUF9d2P2Nia7Z22yQjTx9dp3lIAqUSppQmpFzx0C3dLrk
	hyW1FMizR+bhfAjSNYL3w/4yFKP79UyKE1qp1gSTu6hu6jKPFQP+w9awEAsN4nH18AfWqQ
	5cHDnxW7m+vtL8c4h1meAED3cQPp+HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785501136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBm/eTQW7pAs2FPRIDwtAbxXn/ODVdYs0PwQsRoanwo=;
	b=FlJ8f+QfnmB924OjsD0j1CjGUoZOmKjsPqHqQINuGABHt/38lMAgUaKF+3GgTq8TLKayM2
	6MLlgN9Vb0bod2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BB8C779C6;
	Fri, 31 Jul 2026 12:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rNQSItCVbGqrCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 31 Jul 2026 12:32:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37CB8A13A4; Fri, 31 Jul 2026 14:32:12 +0200 (CEST)
Date: Fri, 31 Jul 2026 14:32:12 +0200
From: Jan Kara <jack@suse.cz>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-aio@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] aio: Use accessor for hrtimer_sleeper ->task
 field
Message-ID: <pkeixgcd65n4mmxlrsw3i2getbkrzyybgd27h4iralrmp53llg@bczwlw3f7fzd>
References: <e76a426b-f65c-4357-b263-96506d877136@paulmck-laptop>
 <20260731004019.3530210-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731004019.3530210-2-paulmck@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 30-07-26 17:40:12, Paul E. McKenney wrote:
> The hrtimer_sleeper structure's ->task field is used as a flag to indicate
> that the associated hrtimer has expired.  This means that the hrtimer
> handler can be storing to this field while other code is loading from it
> to check for expiry.  Note that additional races appear for hrtimers that
> can be restarted, which could be argued to be a user error.  However, that
> is no reason to let the compiler introduce additional confusion, and to
> this end, the hrtimer_sleeper_task_get() was introduced, use of which also
> has the benefit of avoiding open-code access to hrtimer_sleeper innards.
> 
> KCSAN located this issue.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: <linux-aio@kvack.org>
> Cc: <linux-fsdevel@vger.kernel.org>

Looks good. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index f57fa21a250353..e8cd65fce41eba 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1402,7 +1402,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
>  		w.min_nr = min_nr - ret;
>  
>  		ret2 = prepare_to_wait_event(&ctx->wait, &w.w, TASK_INTERRUPTIBLE);
> -		if (!ret2 && !t.task)
> +		if (!ret2 && !hrtimer_sleeper_task_get(&t))
>  			ret2 = -ETIME;
>  
>  		if (aio_read_events(ctx, min_nr, nr, event, &ret) || ret2)
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
