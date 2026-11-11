Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407459;
	b=RuItNvxzYH7CSwlEfS4++geoRsB4ECE9T1B9uTLAgzEYxdAT2zkDJcBmP1vJf4rj5tYH
	 vuYDIUQ1a3ZDUFa7aMzuJW0f76tG/4uZNLaLoJhMtqZYyiv2MU1smq5vZh0tqUPVbY2iJ
	 ZjK8kcDxST1O0FIhaDMpQCcr9dlhrbGKwZL2bjjN1zVoS8RfkRJAWPIVeITyUa7viDUm1
	 bZXgYbo2yh0CUlL4Bkeagx4bjKRlGu6Vq2XDXhkXolrwiRIeIiT2GyCIKAeeMNEQ//PNx
	 cWBU+BAqYcZYZcXarn8cNOtmiSx9hkMSKNWrxPcWheInikdNBpoEqY295cq68K3eU/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407459;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=GY6CJAAsVN6OvG5bSqoRMsKEExnDqerjHHITuI2jmDg=;
	b=cjOeoTagRYAzIS7V20vgiYaIzHWHsKRiuv9uK3k95CVDzl/8EIsrE3sXPU1Bkm3yJRn/
	 Qh8c3kqHmMMutBOBHLYnQCf9SYM30IDpPbCWq089Nbc4IQsfgZBgAAB8Vz9waajtpom7G
	 WKo75Y9jOB6bKpM2aBfWe8ffwJ2mE4Av5WX0iEZi3urZaAN0RcHo4Qh1eCTNkHgrsBRb+
	 KQiKF9yY7r/e7wo4DCBywPX7didyEggJp7sPFqNbDhLZlmHyp85FWUrN1FSK8/5PAz9bv
	 va3BMfc4qtsMdqDcuTn+QikWPHNdyRcyN7lPc+RZaQ8gkPdc5memdKs091YVsk3D94A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QH5uqhO4;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lCt4eElK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=bsXRBU1y;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sHcx6RK4;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34869606A324;
	Wed, 11 Nov 2026 14:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34869606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QH5uqhO4;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lCt4eElK;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=bsXRBU1y;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sHcx6RK4
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 182841FCBE;
	Wed, 11 Nov 2026 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794407457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GY6CJAAsVN6OvG5bSqoRMsKEExnDqerjHHITuI2jmDg=;
	b=QH5uqhO4faMVYcawyral8jKfPo4RlI+1R/Mga7XZXRoANKlr2ZiZSAn/yav7zGKcSgLKfu
	bYmC25JQmHPxVnKPWiwPukj869ZVGo4yyZWQoxjbfZ22NS/JbDMZC/HOMnKgC5Ek/ovGLy
	n7tnbSdLo0Uq1lzPe012c9crUdKwTD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794407457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GY6CJAAsVN6OvG5bSqoRMsKEExnDqerjHHITuI2jmDg=;
	b=lCt4eElKHPNqVqDroWCfcJHD4Z5hrEGjZVxZXxu4mFZWOKO5dTmCRElBmD3J/BQe3DQDSi
	HDNtV7J+wM5L5MBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794407456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GY6CJAAsVN6OvG5bSqoRMsKEExnDqerjHHITuI2jmDg=;
	b=bsXRBU1yAsyOtvuC3UdiSYyKAioDw8zLUZWYh4d9yGrCqE21NmeDxkQPfeTdNNfEWJA2aK
	kDYv+TAZ4hJRDu7N3sSSru8Zg1nPqmIZtv5YPsS4b6GxLCb5ngBLtSt0QqXUYtffhPSTmb
	ky42u/IifaIVOQDj/pYMbzOpkZLF9as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794407456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GY6CJAAsVN6OvG5bSqoRMsKEExnDqerjHHITuI2jmDg=;
	b=sHcx6RK4cHikLtoOtPts+bYVPGPDFUTPC8zRdAdxuUSHZZdyThHDDFR6xPETrzrlMUNp3C
	uK0J5xnga/t2X4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58C1E134E5;
	Wed, 11 Nov 2026 14:30:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dsdTDR989GqFEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Nov 2026 14:30:55 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 812F622945; Wed, 11 Nov 2026 15:30:54 +0100 (CET)
Date: Wed, 11 Nov 2026 15:30:54 +0100
From: Jan Kara <jack@suse.cz>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jack@suse.cz, willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+c4e217748763d41236ee@syzkaller.appspotmail.com
Subject: Re: [PATCH] writeback: mark concurrent accesses to the aging period
 time
Message-ID: <msw5tajltjgyynnpoixzhikfnumbgkoywxje7e552wdh5vpxfu@2g272xypjxmv>
References: <20261111064642.17114-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261111064642.17114-1-zhujun2@cmss.chinamobile.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[c4e217748763d41236ee];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,chinamobile.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.30

On Wed 11-11-26 14:46:42, Zhu Jun wrote:
> Writeback completion and the aging timer access dom->period_time without
> a common lock. Concurrent restarts are deliberately allowed, since an
> approximate aging deadline is sufficient, but the plain reads and writes
> cause KCSAN reports.
> 
> Use READ_ONCE() and WRITE_ONCE() for the shared deadline. Keep a local
> copy when calculating and scheduling a deadline so that each calculation
> uses one snapshot.
> 
> Fixes: eb608e3a344b ("block: Convert BDI proportion calculations to flexible proportions")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0694ec4098f6..fd75f46f744a 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -550,18 +550,21 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
>  				   struct fprop_local_percpu *completions,
>  				   unsigned int max_prop_frac, long nr)
>  {
> +	unsigned long period_time;
> +
>  	__fprop_add_percpu_max(&dom->completions, completions,
>  			       max_prop_frac, nr);
>  	/* First event after period switching was turned off? */
> -	if (unlikely(!dom->period_time)) {
> +	if (unlikely(!READ_ONCE(dom->period_time))) {
>  		/*
>  		 * We can race with other wb_domain_writeout_add calls here but
>  		 * it does not cause any harm since the resulting time when
>  		 * timer will fire and what is in writeout_period_time will be
>  		 * roughly the same.
>  		 */
> -		dom->period_time = wp_next_time(jiffies);
> -		mod_timer(&dom->period_timer, dom->period_time);
> +		period_time = wp_next_time(jiffies);
> +		WRITE_ONCE(dom->period_time, period_time);
> +		mod_timer(&dom->period_timer, period_time);
>  	}
>  }
>  
> @@ -590,19 +593,21 @@ static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
>  static void writeout_period(struct timer_list *t)
>  {
>  	struct wb_domain *dom = timer_container_of(dom, t, period_timer);
> -	int miss_periods = (jiffies - dom->period_time) /
> +	unsigned long period_time = READ_ONCE(dom->period_time);
> +	int miss_periods = (jiffies - period_time) /
>  						 VM_COMPLETIONS_PERIOD_LEN;
>  
>  	if (fprop_new_period(&dom->completions, miss_periods + 1)) {
> -		dom->period_time = wp_next_time(dom->period_time +
> +		period_time = wp_next_time(period_time +
>  				miss_periods * VM_COMPLETIONS_PERIOD_LEN);
> -		mod_timer(&dom->period_timer, dom->period_time);
> +		WRITE_ONCE(dom->period_time, period_time);
> +		mod_timer(&dom->period_timer, period_time);
>  	} else {
>  		/*
>  		 * Aging has zeroed all fractions. Stop wasting CPU on period
>  		 * updates.
>  		 */
> -		dom->period_time = 0;
> +		WRITE_ONCE(dom->period_time, 0);
>  	}
>  }
>  
> -- 
> 2.51.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
