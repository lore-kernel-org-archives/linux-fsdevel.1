Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A66344036
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063356; cv=none; b=HUHF3Vb8yEUjT07d8l01iYEUff37HtZn8g1Gnx+83+cxVEeyDwHzAUZixwa/v2BJIbk7VDY6NgSSKhVGVXbAZqDMVFdy1LT/cJI7gv7dI2zKRIeqbtXySU70rh/h9srCe0NZFkwdNGwSyZnawhvF61aEnd3VxKwlyOXNkzeNZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063356; c=relaxed/simple;
	bh=Mpx7IBlTZU67NkG9grm9QKFrD2wBTVeIuBebdfU7ILA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncot56a3KE4gCZS2/NF2ERw3+0YOqobHgxq8gD0gOsBS0+LFN8/9be7jQ3Bv0gCc9+ya0Rn6hcAQRQ36UJaWhYXSd/Uciq6qhF6bn9UuOIwPBpmOTLH/vofvriJtUbKSu5kmnw28n228UpIk5WVCwZ/IujZ7O8YNLpsH97YNFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJVaLKAQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ALOkSmwr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iUlRoKBv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCcamouk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJVaLKAQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ALOkSmwr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iUlRoKBv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCcamouk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16ADE3E47;
	Tue, 18 Aug 2026 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787063281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+NFEV1DQUDKHpDs5u54ZaT691JPOY3th4aVgA6HFsM=;
	b=XJVaLKAQPfmDbnr12ss+htMJq3HsQUnNJTuJfIib25v6xfFbYaeytYKVoDUwqKlbFyxAPY
	jZTDojnMlf2EVHfKToNyz0w4Zq1LSxT2dW/3UyU8CR1+QkrZaZOGXIYqVr+Oy6w9i6UuCB
	yTyixwU79K5kGxkuFuhEfCxdVhDsc9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787063281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+NFEV1DQUDKHpDs5u54ZaT691JPOY3th4aVgA6HFsM=;
	b=ALOkSmwr9PMq8Eyckbb1vpcokgB26jtwzpep+/WynYAIm09p5y8zpp/fIK/v1uPQwb+JX2
	TEAVVr+F1vs8N8Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iUlRoKBv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yCcamouk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787063277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+NFEV1DQUDKHpDs5u54ZaT691JPOY3th4aVgA6HFsM=;
	b=iUlRoKBv8IpoPnu20CdQa4zqMyC2bu1RgM6qBX4R50f9/yYdaJN6wlT6pAncvVULbW1mGm
	PK8uUrvJ4JzdqZdCrK/Gd2eXNkAhb/5Gyv7zfhfbGHendWv89Eo2sa4KLVPNDY+9vEQDf9
	Xrh8uGK3zZNbieg1e7tsiLuJkC6t1TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787063277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+NFEV1DQUDKHpDs5u54ZaT691JPOY3th4aVgA6HFsM=;
	b=yCcamoukVs3JGXbhs+Aw7bBKu8WXVMdLg+OMr4o4NMKMWzzCVbnpBpmPTyU2X+/91S6cJ7
	z07ksIt965bKddBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 095F7362E;
	Tue, 18 Aug 2026 14:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCdIAu1rhGpyfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Aug 2026 14:27:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C1217A13AB; Tue, 18 Aug 2026 16:27:56 +0200 (CEST)
Date: Tue, 18 Aug 2026 16:27:56 +0200
From: Jan Kara <jack@suse.cz>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: fix comment typo in fs-writeback.c
Message-ID: <xfpcxeuaul3cq75fzzz7yvyt6hcjptxcwdblsnd3y7llg4noum@vpq3wbqpm3vm>
References: <20260813093431.410-1-manushprajwal555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813093431.410-1-manushprajwal555@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 16ADE3E47
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Thu 13-08-26 15:04:30, Manush Prajwal wrote:
> Fix "paramters" -> "parameters" in the foreign-inode-detection
> comment above wb_wait_for_completion(). No functional change.
> 
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index fdb8766d27..e19a588c07 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -233,7 +233,7 @@ void wb_wait_for_completion(struct wb_completion *done)
>   * Parameters for foreign inode detection, see wbc_detach_inode() to see
>   * how they're used.
>   *
> - * These paramters are inherently heuristical as the detection target
> + * These parameters are inherently heuristical as the detection target
>   * itself is fuzzy.  All we want to do is detaching an inode from the
>   * current owner if it's being written to by some other cgroups too much.
>   *
> -- 
> 2.46.2.windows.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
