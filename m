Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567825771;
	Tue, 29 Sep 2026 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712922; cv=none; b=lGU/B/Z351JHmPeHgFj1LU2pTq8X3XfvBVPwRQAI1/7qRYx388vvFKE57xmAVjj26lAdk70d8clLJU2cMyvVYpKEdtmaoG6NYXhfcVoa6iNIMV8yvElJMpErZr9k51tegKbWIrBsKYhJXCgkj9rSIkaG0J7KFwR2H/kky4S+xNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712922; c=relaxed/simple;
	bh=mYb6HuWTv/WHtKqU/2IpK8Rk+iiZoTCn0FW3KpQMwLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsSy76oTJPCtItqzyBPvDiAk3Ok8h7qIjLKGuS+pOUQ6G/LXrnnOv26J0cllEgi4KcRDOFg9a11mWwPZhFr3Yg6Rc47zixMJaODusScIau+I8wgqeVZu8YkfH0KmWB0BAz/V7/LfAQDQyxKOqTLKiPov14OBLuJIYN5skTQti50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v4j7e9EX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vnxL+PrW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ymcPJibv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zk8kqjx6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v4j7e9EX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vnxL+PrW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ymcPJibv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zk8kqjx6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3850021D97;
	Tue, 29 Sep 2026 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790712914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hJksYPHwrC24aM2sk7fDWEmMxAcxBQUI0qvWyDbPdA=;
	b=v4j7e9EXC90rxgVmGJaK1hmG57w7OQ0w5YtIlrGBBMxQd6PblDHEMZfpm4LmMdLvc0bN1Q
	wyoVuaUekx27ZmIwuYu4RejJpKCd+j5UiJYLEAOix4aZTYBjh5qoCg2vECensb6h0AH3dl
	4na52xukYP8wX6KLquGRe/YAFfD6mTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790712914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hJksYPHwrC24aM2sk7fDWEmMxAcxBQUI0qvWyDbPdA=;
	b=vnxL+PrWvF16rHTpC/zVaxTZaTel4vCM6Sr1bHYYPOksK2U4UVscAQrkWl7k2CU8oMUz+C
	4YlmVXo330S19pAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790712910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hJksYPHwrC24aM2sk7fDWEmMxAcxBQUI0qvWyDbPdA=;
	b=ymcPJibv9hhAOUADcEZPwMsjB9fnfzcx3+h2Bxp6zPrIchvESYZ1HeqOI+cXRzhJYunlKo
	aMgZlHuFGXkgEzCfMmOstpn/4W5wj4bCjTqALVPWBFQRHHalQ4M80Ijq53F/TeEeJUV1us
	QTvtMHDtVwJUIe9RKM2k6YcL0hT5w+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790712910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hJksYPHwrC24aM2sk7fDWEmMxAcxBQUI0qvWyDbPdA=;
	b=Zk8kqjx6Kvs/NylkMdjgg0yazDJE3JRURPYaWWRkuquMYS0WNqFggMBIr2tBOP2po+yECK
	i5kcveRwGgCepZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCBAA136D1;
	Tue, 29 Sep 2026 20:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QPnULE0cvGpXUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Sep 2026 20:15:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 58B21A133D; Tue, 29 Sep 2026 22:15:05 +0200 (CEST)
Date: Tue, 29 Sep 2026 22:15:05 +0200
From: Jan Kara <jack@suse.cz>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Thomas Maarseveen <maarseveent@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] errseq: don't let errseq_check_and_advance() hide
 later errors
Message-ID: <4g47imecevlvhwo3gcc7r66w2hoal4ay5xtdtppuctojnnpyo5@b42cmt74mlkf>
References: <20260927051726.71337-1-jain.sm@gmail.com>
 <20260927051726.71337-2-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927051726.71337-2-jain.sm@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,brown.name,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Sun 27-09-26 10:47:25, Shashank Mohan Jain wrote:
> errseq_check_and_advance() reads the errseq_t, sets ERRSEQ_SEEN with a
> cmpxchg() and then advances *since to the value it computed, ignoring
> whether the cmpxchg() succeeded. When it fails because errseq_set()
> recorded a different error in the meantime, *since ends up holding a
> value that was never stored in the errseq_t.
> 
> errseq_set() only bumps the counter when ERRSEQ_SEEN is set. So as long
> as nobody has seen the new error, recording the original errno again
> recreates exactly the old value, and once another subscriber marks it
> seen, it is equal to the stale *since. The next check through that
> cursor then reports nothing, although -ENOSPC was recorded after the
> value that check reported, and -EIO was recorded again after it
> returned:
> 
>   cursor f                writeback              cursor g
>   --------                ---------              --------
>                           set(-EIO)
>   check_and_advance(&f)
>     old = [c, EIO]
>                           set(-ENOSPC)
>                           -> [c, ENOSPC]
>     cmpxchg() fails
>     f = [c, EIO, SEEN]
>     returns -EIO
>                           set(-EIO)
>                           -> [c, EIO]
>                           (no bump: unseen)
>                                                  check_and_advance(&g)
>                                                  -> [c, EIO, SEEN]
>                                                  returns -EIO
>   check_and_advance(&f)
>     [c, EIO, SEEN] == f
>     returns 0             <- -ENOSPC and the second -EIO are lost
> 
> For file->f_wb_err this means that fsync() on one descriptor can return
> 0 although writeback failed after the previous fsync() on that
> descriptor returned, when writeback errors race with fsync() on another
> descriptor of the same file. The same applies to syncfs() through
> sb->s_wb_err, which every file on the filesystem shares, and to the
> ext4 and jbd2 cursors on the block device mapping. The kernel-doc
> promises "Negative errno if one has been stored, or 0 if no new error
> has occurred".
> 
> Retry with the value found when the cmpxchg() fails, so that *since is
> only ever advanced to a value that was actually stored with ERRSEQ_SEEN
> set. Every later errseq_set() then has to bump the counter, and the
> error is reported. The retry loop terminates because each iteration
> needs a concurrent update, like the loop in errseq_set().
> 
> A TLA+ model of errseq_set() and errseq_check_and_advance(), checked
> with the TLC model checker, finds the lost error with the current code;
> with this change TLC checks that an error recorded after a check
> returned is always reported by the next check (exhaustively for two
> subscribers with three checks each, and one writer recording four
> errors or two writers recording two each). The KUnit race test added
> in the next patch misses the error in 1-6% of 2 million rounds on
> 4-CPU UML before this change (depending on host load), and in none
> after it.
> 
> Fixes: 84cbadadc6ea ("lib: add errseq_t type and infrastructure for handling it")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM TLC
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Found with a TLA+ model of lib/errseq.c checked with TLC; the fix, the
> test and the changelogs were drafted with an LLM assistant (Claude
> Code, Claude Opus 5.5).
> 
> Tested: the KUnit case in patch 2 on UML x86_64 with 4 CPUs (8 runs)
> and 2 CPUs, and on UML i386 with 4 CPUs (--kernel_args seccomp=on
> --kernel_args ncpus=4): 22k-116k of 2M rounds lose the error before,
> 0 after; a userspace replay of the unmodified lib/errseq.c with a hook
> before the cmpxchg(); TLC (exhaustive for 2 files x 3 checks, 1 writer
> x 4 errors or 2 writers x 2 errors); W=1 builds for UML x86_64 and
> i386.
> Not tested: fsync()/syncfs() on a real failing device, and weakly
> ordered hardware (the model is sequentially consistent; the fix adds
> no ordering requirements beyond cmpxchg()).
> 
> Applies to mainline on its own; see the cover letter for patch 2.
> 
>  lib/errseq.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/errseq.c b/lib/errseq.c
> index 13a2581c5a87..ea4ff9cc2166 100644
> --- a/lib/errseq.c
> +++ b/lib/errseq.c
> @@ -162,7 +162,8 @@ EXPORT_SYMBOL(errseq_check);
>   * points to. If it does, then just return 0.
>   *
>   * If it doesn't, then the value has changed. Set the "seen" flag, and try to
> - * swap it into place as the new eseq value. Then, set that value as the new
> + * swap it into place as the new eseq value. If the swap fails because the
> + * value changed, retry with the new value. Then, set that value as the new
>   * "since" value, and return whatever the error portion is set to.
>   *
>   * Note that no locking is provided here for concurrent updates to the "since"
> @@ -184,24 +185,30 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
>  	 * to take the lock that protects the "since" value.
>  	 */
>  	old = READ_ONCE(*eseq);
> -	if (old != *since) {
> +	while (old != *since) {
>  		/*
>  		 * Set the flag and try to swap it into place if it has
>  		 * changed.
>  		 *
> -		 * We don't care about the outcome of the swap here. If the
> -		 * swap doesn't occur, then it has either been updated by a
> -		 * writer who is altering the value in some way (updating
> -		 * counter or resetting the error), or another reader who is
> -		 * just setting the "seen" flag. Either outcome is OK, and we
> -		 * can advance "since" and return an error based on what we
> -		 * have.
> +		 * If the swap fails, a writer or another reader changed the
> +		 * value under us, so retry with the new value.  "since" must
> +		 * only ever be set to a value that was stored with the SEEN
> +		 * flag: errseq_set() does not bump the counter while the
> +		 * flag is clear, so an unstored value could come back later
> +		 * and hide the errors that were recorded in the meantime.
>  		 */
>  		new = old | ERRSEQ_SEEN;
> -		if (new != old)
> -			cmpxchg(eseq, old, new);
> +		if (new != old) {
> +			errseq_t cur = cmpxchg(eseq, old, new);
> +
> +			if (cur != old) {
> +				old = cur;
> +				continue;
> +			}
> +		}
>  		*since = new;
>  		err = -(new & ERRNO_MASK);
> +		break;
>  	}
>  	return err;
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
