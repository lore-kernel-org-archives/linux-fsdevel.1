Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877190;
	b=ZY56pN0uAA79Ci5gs8EnYgzG5qjm4An/R7yQcaO84GRUPCGWvnT4F78X7Vc04W+HDrup
	 A2YxTrxZ5gyOpf1TEicr4Mc8JRYWmPOBPO5M8kvX0tUs9E7VENZI0ZDgCxHFggkFL7RMz
	 WtbDfXlntw/mttG0qdm/a2KA8/i0Qb4alpz/bZbCzMc/gT6RnpeAl+3B410w5wifRJlY2
	 lkKg2lwHgbjkOnKqRv/g8UEHwGBPjWzMC8ZaI2g+GgmrC/T/nIaE0+n2GUU+eX/IvCzkF
	 zY30monQwrwszXvpiqoZN+2GiZT3ab39zci0w3E+nrNDZ0RwtYK9j59KNzy87rJgP1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877190;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=DjYu4yt3RK0Xx9SJ3jT2askD5Cjf05nRefGibZGlW4E=;
	b=dB7JtDqFDoW8NmyPqri/2BC1bRDY3p7EBCB6zraSVEhXG/ZfW/KEdv9gilWc1X1ygkAm
	 6Mt98r4TmTrDSHTf5eWphQCcaRkYdt2p3pS4qrwLis1SDZ30dTqArEzAgU79JWC/yQ+OG
	 GBa8YPTm8RREwTTc4XjmQ71Qk6h2UgLXT3dbZtSYPz52oD0O5bzzc2QEYgeBTpWC1gG0y
	 Dvx9MWFjYFWhXyWJ7bhG8RIfAIi3ufiCY2tqzZ4HE0U+kkoZ813MoRuEtmmUrmbqeI6BG
	 UmREmeGhMh+xXFm5VVZozO3YgjHCRkzWDrv/x3G1V3Wi8mnIcHXg8PJRJTZsoVBNjDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="hEM/Akjz";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RBDVdOnn;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="hEM/Akjz";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RBDVdOnn;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE13606D804;
	Thu,  5 Nov 2026 11:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE13606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hEM/Akjz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RBDVdOnn;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hEM/Akjz;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RBDVdOnn
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2B7F21EFA;
	Thu,  5 Nov 2026 11:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793877188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DjYu4yt3RK0Xx9SJ3jT2askD5Cjf05nRefGibZGlW4E=;
	b=hEM/AkjzxEGmSFcv+Kxo/aXB3B/D8XmYcXinvh9SMMo6KRBlOFpWUegKn9K7nZwqzIhywz
	AMCAvsAulU0EnNL2bSbEK8hJVjrpSFArD7MQDB9WsfP8z0m7ql1te3xkeZvVAMJdPfTFQN
	KXusvdnCANnYDzPKsdUC9FCVOYkiQp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793877188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DjYu4yt3RK0Xx9SJ3jT2askD5Cjf05nRefGibZGlW4E=;
	b=RBDVdOnnrg9iObP8c4dbkETTCeqbG6gaYMGTdUdlxG/zwYTCNMU99SOW6BJyFjNvKaqO2W
	ha7ffFgvYit8D4CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793877188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DjYu4yt3RK0Xx9SJ3jT2askD5Cjf05nRefGibZGlW4E=;
	b=hEM/AkjzxEGmSFcv+Kxo/aXB3B/D8XmYcXinvh9SMMo6KRBlOFpWUegKn9K7nZwqzIhywz
	AMCAvsAulU0EnNL2bSbEK8hJVjrpSFArD7MQDB9WsfP8z0m7ql1te3xkeZvVAMJdPfTFQN
	KXusvdnCANnYDzPKsdUC9FCVOYkiQp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793877188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DjYu4yt3RK0Xx9SJ3jT2askD5Cjf05nRefGibZGlW4E=;
	b=RBDVdOnnrg9iObP8c4dbkETTCeqbG6gaYMGTdUdlxG/zwYTCNMU99SOW6BJyFjNvKaqO2W
	ha7ffFgvYit8D4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA489134F4;
	Thu,  5 Nov 2026 11:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tkFWKcNk7GrfVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 11:13:07 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 5AC52B6A7; Thu, 05 Nov 2026 12:13:07 +0100 (CET)
Date: Thu, 5 Nov 2026 12:13:07 +0100
From: Jan Kara <jack@suse.cz>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Breno Leitao <leitao@debian.org>, 
	Arjan van de Ven <arjan@linux.intel.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/select: reject negative timeval components in
 do_compat_select()
Message-ID: <u7acpjmrb4e5wiesl35f3buaiibj26jxjddjfngcut3qtvdurx@pucwumtcgnkp>
References: <20261031083059.3245047-2-thnkslprpt@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031083059.3245047-2-thnkslprpt@gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Sat 31-10-26 10:31:00, Avi Weiss wrote:
> do_compat_select() normalizes old_timeval32 before validating the
> timeout. Negative seconds and microseconds can cancel each other,
> causing compat select() and old_select() to accept invalid timeouts.

Yes, but who cares? You can pass various strange values (like making sec +
usec / USEC_PER_SEC overflow) resulting in odd behavior but you are only
shooting yourself in the foot... So if it doesn't hurt integrity of the
code flow, I'd just ignore this.

								Honza

> 
> Reject negative components before normalization (as kern_select()
> already does) - and preserve the handling of oversized positive
> tv_usec values.
> 
> A 32-bit syscall reproducer confirmed four incorrect results on the
> unpatched kernel. With the fix applied, all my test cases passed on
> both compat select interfaces.
> 
> Fixes: 4d36a9e65d49 ("select: deal with math overflow from borderline valid userland data")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  fs/select.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 95d76531015aa..8b6d1dd2977c6 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -1265,6 +1265,8 @@ static int do_compat_select(int n, compat_ulong_t __user *inp,
>  		if (copy_from_user(&tv, tvp, sizeof(tv)))
>  			return -EFAULT;
>  
> +		if (tv.tv_sec < 0 || tv.tv_usec < 0)
> +			return -EINVAL;
>  		to = &end_time;
>  		if (poll_select_set_timeout(to,
>  				tv.tv_sec + (tv.tv_usec / USEC_PER_SEC),
> 
> base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
