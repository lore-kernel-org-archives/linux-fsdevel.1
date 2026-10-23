Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745313;
	b=TGPklLfSRXxEvyQuTjAEKNejpkGmtuq111BgFFbzUGTtQTIHKFgZu0ZpwOc7QLnbZMhO
	 9PJIgT/w8w7UhESB+q7MruIleR1uuDRV/MHK+3GHvDrVoV3geMpszZBBKQphU9f71yiw/
	 7FCN/+AlFBxZxo9mSczYH+I0TGsLTf6ovBOPOEwnr6YnWv/sBxhzfxsmtbftu3psIeM4+
	 jJcbOqzGfR+bd+PBneh00L40BNSuWePORrNDihUPDzZTJgRjTFWTofWwi1n5ngR8JYD4j
	 Wrv6+Wo0XKQH+ku3bi9vbMcazJyTsOjxaeMRL+wgu44b19vebknF6AG+2sF4vQRPj2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745313;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=eh+XeTghhNpEBCcLveL4eJ+dFfIWG6uFY0NZX4jjpUw=;
	b=Mmo3LikDHp7bYfcQgYooxFKRf8r47Pnt/mFSVyLZ637qFYiGmIBu2usruB13QiwF4Oo9
	 8McizkmsSHfUkm/G7fAU0Tn5mlGjB0hRcYtY1RJnPkY/Mo7Foz7TB5DVqyUMr4+SjFiSy
	 tT7GjbK1VHapceqUhNRLare18GUbKPFvIY9I7dzfdhkk6ZQYOD4tbgLc5ZTmhSfyO4vmg
	 3sbxE9017Vs186H5gNwQlxD5BdsmhrklEI78DKBiBtRehRTW07lnj8kwYHPrjpEFNEwCD
	 dbYpTw70M93LTfmi9Nj5fH7LdgF/lYeZaOeZgOHzZ+yCTrXX6JM6fP0ryfa4+Gp/auA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RLYKsQHi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JLKLr4Ia;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RLYKsQHi;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JLKLr4Ia;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F036606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 08:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F036606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RLYKsQHi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JLKLr4Ia;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RLYKsQHi;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JLKLr4Ia
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79CAE2211E;
	Fri, 23 Oct 2026 08:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792745311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh+XeTghhNpEBCcLveL4eJ+dFfIWG6uFY0NZX4jjpUw=;
	b=RLYKsQHiGbB73OAEcu4TQV5EoEXI47Y42kVlVgEkOX+reVfeyrxQgC9ql0N9ZF9vrtUzVc
	GYysL4SXHSRV9z70Joss+33DC2mIOybIHJuiJZZnUyIsJL8vtSxFBU2e+LCbpTTvhmIdbr
	AYtMm8O+kLueazqVJKiI8Dk/wgVOJoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792745311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh+XeTghhNpEBCcLveL4eJ+dFfIWG6uFY0NZX4jjpUw=;
	b=JLKLr4IaaDvExRCibs0/9+1QkEKc9bbMEXi0M9XcLE6UEqAOJV1QkmfL3Ocgw5aA6RUpWC
	umPaxrvZabJyy9DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792745311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh+XeTghhNpEBCcLveL4eJ+dFfIWG6uFY0NZX4jjpUw=;
	b=RLYKsQHiGbB73OAEcu4TQV5EoEXI47Y42kVlVgEkOX+reVfeyrxQgC9ql0N9ZF9vrtUzVc
	GYysL4SXHSRV9z70Joss+33DC2mIOybIHJuiJZZnUyIsJL8vtSxFBU2e+LCbpTTvhmIdbr
	AYtMm8O+kLueazqVJKiI8Dk/wgVOJoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792745311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh+XeTghhNpEBCcLveL4eJ+dFfIWG6uFY0NZX4jjpUw=;
	b=JLKLr4IaaDvExRCibs0/9+1QkEKc9bbMEXi0M9XcLE6UEqAOJV1QkmfL3Ocgw5aA6RUpWC
	umPaxrvZabJyy9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52965133F6;
	Fri, 23 Oct 2026 08:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fa0JDl8f22pPHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 23 Oct 2026 08:48:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05F0BA1415; Fri, 23 Oct 2026 10:48:31 +0200 (CEST)
Date: Fri, 23 Oct 2026 10:48:30 +0200
From: Jan Kara <jack@suse.cz>
To: Finke Lennart <lfinke@student.ethz.ch>
Cc: "jack@suse.cz" <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Regression in udf_get_extendedattr()
Message-ID: <v37eqgcl4l4vp4j42uictssgx7t3fzzlbdinejlmislskibqxo@jipytmhde75f>
References: <E7E8CE97-3384-4FD3-BB91-B3DF393D45E1@student.ethz.ch>
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
In-Reply-To: <E7E8CE97-3384-4FD3-BB91-B3DF393D45E1@student.ethz.ch>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

Hi!

On Thu 22-10-26 15:36:26, Finke  Lennart wrote:
> this is Lennart<https://finke.dev/>, I stumbled on what I think is a missing bounds check in udf_get_extendedattr(). Found with AI, so take with a grain of salt:
> 
> I think 127b0d87649f ("udf: Avoid confusion of missing and corrupted
> extended attributes") reintroduced a missing bounds check in
> udf_get_extendedattr(). In
> 
> while (offset <
>       iinfo->i_lenEAttr - sizeof(struct genericFormat)) {
> 
> i_lenEAttr is a u32 and is only checked against the block size in
> udf_read_inode() (nothing enforces a minimum), so for 1 <= i_lenEAttr < 12
> the subtraction wraps and the guard always holds.
> 
> Maybe something like
> 
> while (offset + sizeof(struct genericFormat) < iinfo->i_lenEAttr) {
> 
> should do it?

I actually prefer a fix in udf_read_inode() - see the patch I've sent.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
