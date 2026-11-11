Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406912;
	b=Hii1R1vszVAh4VtUNT4YOdlkVhCNUTdVwLSKsOrK2P9C78Ky/wQkTKrQ+zb8Y8EcoyfW
	 CQa3sxe7IRBVuXnwrwDiLYE96T7Wtx76LNEvr8lE5FGGJKdEjaqXhOJhWz6wP1eycPYYO
	 j6j9ZiCFGm4sDxETvKX1jhRXNAdMoGTfLs5TNPlYCxfduhnIvkovYZK0HlNt0vJW4xKru
	 LhZCPV+5rcm3bVsN3V9TVoUK8HSQTmhZ5YjXp32l0YzKmokHsd1rm7sMCjzwf/foyN5Gi
	 Ha90V0a9G/ZCi7H2oU3D5AGETNK0yzHuUEnY+Jvekkg83qC12iWg27jCMQNgkPlvtXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406912;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=Bp8NQg8Yf5lJieYAKYkS6RK79RFpuknu92dwGieYtho=;
	b=tnjqAYvRXCQOufPlYoZ1UDJd4MsqkZA0qcUX7Au4EVKq0T7l9WiRd3Ef17471OaPCgYW
	 fHk8+bSF1K85ArufzX5W0PU1hP+sGFgeZZtS+FRIF1Xvod4dMjzMboNel8JEKqdd6DXZJ
	 AlfGSYyiLohBlzyyXzYeeO7CpP7Caaz95qcGBdFRFezN0CdvFJsx42/s/ZXHQYTDRQkTX
	 G8ATqjQb/YeQOyRf3ZctcswU2xL+r/9uIe6RHlMZus+LliKOUclEoA4i8PwFP3h2iU2DU
	 DUi0WNI/bMw9w5hQ/zWERmxyqi57pr87dmvFz0q6K9TCIWKO/96xsi+Iv/niTygSM9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Y0oVpKDQ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EXfDCNaE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Y0oVpKDQ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EXfDCNaE;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D2606A327;
	Wed, 11 Nov 2026 14:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE3D2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Y0oVpKDQ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EXfDCNaE;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Y0oVpKDQ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EXfDCNaE
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F4E933692;
	Wed, 11 Nov 2026 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794406910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp8NQg8Yf5lJieYAKYkS6RK79RFpuknu92dwGieYtho=;
	b=Y0oVpKDQAMptpW6dMUzDl+cM5Tp3iyT2wqObpQ1SCMsJJKigwh01YQj4SV+U0MBt3ZvuUp
	6TbNrfGj/Pd8eCC/XH+DR0NynsjHN9stPipT/yNN/B92aSquzOV2t6WVkPRCGK3GEyBFxB
	7AywR88lRNpsHKx2dySyStdGdt1gtis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794406910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp8NQg8Yf5lJieYAKYkS6RK79RFpuknu92dwGieYtho=;
	b=EXfDCNaEv59wAE4njB0gCOnUtabwN7TLnX20HjG9Nc9IZ99vwgTnzWcoM8e5ANKOp5t8D3
	MN4biB3xPklK+ADA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794406910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp8NQg8Yf5lJieYAKYkS6RK79RFpuknu92dwGieYtho=;
	b=Y0oVpKDQAMptpW6dMUzDl+cM5Tp3iyT2wqObpQ1SCMsJJKigwh01YQj4SV+U0MBt3ZvuUp
	6TbNrfGj/Pd8eCC/XH+DR0NynsjHN9stPipT/yNN/B92aSquzOV2t6WVkPRCGK3GEyBFxB
	7AywR88lRNpsHKx2dySyStdGdt1gtis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794406910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp8NQg8Yf5lJieYAKYkS6RK79RFpuknu92dwGieYtho=;
	b=EXfDCNaEv59wAE4njB0gCOnUtabwN7TLnX20HjG9Nc9IZ99vwgTnzWcoM8e5ANKOp5t8D3
	MN4biB3xPklK+ADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF50134E5;
	Wed, 11 Nov 2026 14:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0+PKK/159Gr2CAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Nov 2026 14:21:49 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 6638D2293C; Wed, 11 Nov 2026 15:21:49 +0100 (CET)
Date: Wed, 11 Nov 2026 15:21:49 +0100
From: Jan Kara <jack@suse.cz>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7528a49543144ca596b7@syzkaller.appspotmail.com
Subject: Re: [PATCH] buffer: Annotate the remote buffer LRU occupancy check
Message-ID: <cv5aazopgwqzihi5zqtdhcntbbpxkrncggvtj53mvusehcaciz@vfqpjm4aozye>
References: <20261111084113.80884-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261111084113.80884-1-zhujun2@cmss.chinamobile.com>
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
	TAGGED_RCPT(0.00)[7528a49543144ca596b7];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,chinamobile.com:email]
X-Spam-Score: -11.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 11-11-26 16:41:12, Zhu Jun wrote:
> has_bh_in_lru() reads another CPU's buffer LRU while that CPU may install
> or invalidate entries. The local BH LRU lock does not serialize this
> remote occupancy check, which KCSAN reports as a data race.
> 
> The check only decides whether to send a drain IPI and never dereferences
> the sampled pointer. Mark it as an intentional race and use READ_ONCE()
> to keep the test to a single load.
> 
> Fixes: 42be35d0390b ("fs: only send IPI to invalidate LRU BH when needed")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
...
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
> -		if (b->bhs[i])
> +		/* Only test occupancy; the remote CPU owns the references. */
> +		if (data_race(READ_ONCE(b->bhs[i])))

No need for the comment. Also combining READ_ONCE() and data_race() is
really silly. Just use data_race().

								Honza

>  			return true;
>  	}
>  
> -- 
> 2.51.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
