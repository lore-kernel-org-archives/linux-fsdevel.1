Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CFA480968;
	Fri,  2 Oct 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938543; cv=none; b=YXMW3LWDQflt6zDZWllhPbQdma854cHBBC2qiH0onU3KALmAcsUOIPx4D3s4pHC1M4mu3vCkQhSdM/s6whtX8JPQ+31A8lTb4CNibTbjBqqKM6njwYVsbySPToexpvUZZS1FWgyuuYZW596ZrQJ3RHZ1RxmFRecZNZIw8vnaB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938543; c=relaxed/simple;
	bh=RKnHZco4UJqmb9aBoEB/Ye1X8z+yfLYpTu1WHiFqsac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztrgwxn5pjBvsdgL30988FcT6DWS8kjx7BkNZyqsGWkfan5cNoELR+uHwPdXl8nFFp65wWHSu3b0X1yzOLJIpSwzEtBz4JqOPz888nToBqUiVOfH8jaRW/V28rMHc8/nSKqsDDl+yTo/BgqbVJCg01m6hyUkJZlORLT+QV7sMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i5ckGo+P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HXLwhiRo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xdL4DT1R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mLqPIFxt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i5ckGo+P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HXLwhiRo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xdL4DT1R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mLqPIFxt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9BB721E72;
	Fri,  2 Oct 2026 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790938529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qV8diR+xE1O7UkxwbN2DZAXwHEZM8xvfjkG5TwhVhW0=;
	b=i5ckGo+P54i32raXBoCcm7ajCHx93p1InPdXWY17eSbBhuexEc3XxbveCVB4JIZ9kAAMXf
	9Kg6WPujZxCCMnX0kbf8Ty9pUVgU6jdbPTXWT2SkVfGB6zgoeXtzH6xhwxB+MRGlNhrDjP
	jtZf5xBRrldrXzLjLLZN4v6vxAhxfy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790938529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qV8diR+xE1O7UkxwbN2DZAXwHEZM8xvfjkG5TwhVhW0=;
	b=HXLwhiRouy12jzwgfKbCxZ5tIFP2Gxn0tx3fBPgOoGMiVsgcqdiiibwgiA+xljLom10WmC
	/0YLYgmPGyNjmoCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xdL4DT1R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mLqPIFxt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790938525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qV8diR+xE1O7UkxwbN2DZAXwHEZM8xvfjkG5TwhVhW0=;
	b=xdL4DT1RfowXEtqORZSmieq2ZZlLFgKPF7chr+jDO3ugPtRXF64qIt84tV6BmSYlAUwRqO
	sN6PUr18Uak7HsX3Ap3/36VXkjHOW19An9GfzHWz0hQaLnoLHaDGROmGjlii/4XOQIVXkm
	x3ng8Dqn9ls6vtuh832cySvR93xUKlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790938525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qV8diR+xE1O7UkxwbN2DZAXwHEZM8xvfjkG5TwhVhW0=;
	b=mLqPIFxtlaBtUKjahFPTlC0J2W6wZHcF1y+CLJmWH9wa7Om3t1ljJQH8pznkkYQi+Qsv3G
	UkjeFLsWOBn1ZSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BFE613C4C;
	Fri,  2 Oct 2026 10:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q0WxHJ2Nv2ovWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 02 Oct 2026 10:55:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D6F4A13C2; Fri, 02 Oct 2026 12:55:10 +0200 (CEST)
Date: Fri, 2 Oct 2026 12:55:10 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Hui Peng <benquike@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: bound empty directory blocks in
 isofs_read_level3_size()
Message-ID: <yw2b4jq5loeo3bp5vffd3mptpdhvjch2nu5nc6qr45opss3zbq@5feos574vwcy>
References: <20260923175215.1577791-1-matthias.goergens@gmail.com>
 <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf>
 <20260924151356.3287733-1-matthias.goergens@gmail.com>
 <20260925043804.2091174-1-matthias.goergens@gmail.com>
 <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n>
 <20260926083517.556576-1-matthias.goergens@gmail.com>
 <cm3n7vjwbdnafttuz5ftkzz5wdbalgews4dfs5zlwvkyuzotuq@jo2nhsplhstc>
 <20260930033940.175021-1-matthias.goergens@gmail.com>
 <xr6nxaat4f4zlmnk6dcn6fyiih336io2qaxm6lytxyb23oznw6@xcd4rjwpg4di>
 <20261001103000.3408032-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001103000.3408032-1-matthias.goergens@gmail.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,zeniv.linux.org.uk,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C9BB721E72
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Thu 01-10-26 18:30:00, Matthias Goergens wrote:
> Hi Honza,
> 
> > Right, that needs a bit more care but still, something like the attached
> > patch should work?
> 
> Yes, it does.  Testing the next-section link as "not yet set" instead
> of "i == 1" is what was missing from the first variant.  I ran your
> patch on top of v1, built in userspace with ASan and UBSan, against 67
> test images: empty blocks between and after the section records,
> three-section files, and the 100 bound from both sides.  i_size, the
> recorded next section, the limit message and the file contents match
> v1 on every image, including the split-gap one your first variant read
> wrongly.  No sanitizer reports.
> 
> Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
> Tested-by: Matthias Goergens <matthias.goergens@gmail.com>

Thanks for review & testing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
