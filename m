Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706515;
	b=pHupQ5dqpDQBWhKq78Rb9CCPz6xBczlZ8sJdYi7guVsTJYlkLjdGpLyMOUq/3hUcinI3
	 oxhxjFcGSJESWe2JkcY3V9FftN/HD7Kf4qGbiRrKNwTquQ/ohCSNIqhnMsQ0VZ85+adRU
	 31WT7n3kCyIeLdNnFWw8OnAioPqHmVvysZRSuj22ht00hFUKhplgaej4VfiD2lYUlZWK1
	 ZYEwE0xp+Q0FchfmKEMywVTCGRtlxxK1VVsKAIVt5UMmK7Xf1cFLcJ+IkMZuMqQgNnJMc
	 z/VvfBv7wfCtajEaUL5fKVFg6MKN5nkFz/90T2npBA4PVFlT8aSDa3lQQoSqjWny7Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706515;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=Mdmz3a1W+ktjLVjBOf8zM49VMCj6dhCFAkQ8H5Ze2HU=;
	b=zvfSbgeqVoWwz75NqTIWZtGVFNAoC5cPCIWT0+K8O6lBsoPspkkldpNcAnRgUwqPUDkM
	 +3iKbIfVAcJRyXcFzM6U2CkvFeCLD/5/H9jqeAp8a7QrdeV1j4TVFilLlB8cLSP56Oto/
	 iyS3PAhwmw9j9iJIE8HcHj593+xnMlnXtY/EgKvMCi4ubEnsRsQ12vwxMdOB1Zif6xEgs
	 V1MN+vx8J9sM+BmuqK6N9zYsBfNsFV1C+elqMw97D5kZvoBt+75ip0uZreQ1Pl3xRcfsU
	 sY1x5HNRKVS6bcqj/N/x6RXKf5v5xlh6CfxQLGjOz2/dgknwjOiuaturA0+4MdFXYrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=aW5p3c0x;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WvArbhQZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pPrJHiGj;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pBxIw67h;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45582606D814;
	Tue,  3 Nov 2026 11:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45582606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=aW5p3c0x;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WvArbhQZ;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pPrJHiGj;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pBxIw67h
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0338122198;
	Tue,  3 Nov 2026 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793706513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mdmz3a1W+ktjLVjBOf8zM49VMCj6dhCFAkQ8H5Ze2HU=;
	b=aW5p3c0xMU8JtROUrNkhtFWz4HNRHAgRuvtrtZO53l0vZQrDeHy3xXrO1rsqz0jd7Apj1F
	2R0Jqeg8z30fk8DA8YZSoVtmsVy8ec8ucrxC0534b//mryEGkBsH3QBDrgiOHkQMoWNH7A
	KIVDgreEHCb6knZYF7gL1NWzQlDUm5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793706513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mdmz3a1W+ktjLVjBOf8zM49VMCj6dhCFAkQ8H5Ze2HU=;
	b=WvArbhQZut+w8KpX3/okohtlzkXdb9tQP1MfdCzB9pFuWwkQLWBhT3Ss4WsKjGUNlbLM6C
	zacCBBhYXBGh9NDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793706512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mdmz3a1W+ktjLVjBOf8zM49VMCj6dhCFAkQ8H5Ze2HU=;
	b=pPrJHiGjzwz+z7puwZSlcXZosnAjDdIokgsqy1hnlG8oWcn/OBgZQsq0Z+1PXSYa0DzGvj
	SaUgrGeTf362zOQWbnrc7y3TWIYXB7b9YpG2KG2heQYrNeOisYKoPDcy9Vl1Icqw9gWK8y
	JLNbrcyxc2M74Myy8D1eOtgFO8PsklQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793706512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mdmz3a1W+ktjLVjBOf8zM49VMCj6dhCFAkQ8H5Ze2HU=;
	b=pBxIw67h90A6YwjJRUFc6HyoiqzqqWUfWNWVQEyGRfk5PtIeDTcvm/Lb5EXfqtglXP7USn
	VyGeULyaNYnF6DAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D003E134B8;
	Tue,  3 Nov 2026 11:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PXbNKg/K6WpNVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Nov 2026 11:48:31 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 7530CB23C; Tue, 03 Nov 2026 12:48:31 +0100 (CET)
Date: Tue, 3 Nov 2026 12:48:31 +0100
From: Jan Kara <jack@suse.cz>
To: Luo Qiu <luoqiu@kylinsec.com.cn>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix typo in do_open() comment
Message-ID: <bhvmwehlfbeejamomz7wyso2ixma4xsk2iony3ed2nkogeijax@nxw5f2rb3blo>
References: <A977B5B944F3C7C3+20261027122647.1837472-1-luoqiu@kylinsec.com.cn>
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
In-Reply-To: <A977B5B944F3C7C3+20261027122647.1837472-1-luoqiu@kylinsec.com.cn>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,kylinsec.com.cn:email,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Tue 27-10-26 20:26:47, Luo Qiu wrote:
> Fix "acess" -> "access"
> 
> Fixes: 161ce1e692d0 ("fs: avoid spurious dentry ref/unref cycle on open")
> 
> Signed-off-by: Luo Qiu <luoqiu@kylinsec.com.cn>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 96c65940391a..9bf97d5ce37e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4835,7 +4835,7 @@ static int do_open(struct nameidata *nd,
>  		/*
>  		 * A dedicated reference is needed because after the call to
>  		 * vfs_open_consume() we no longer own the reference in nd->path.mnt
> -		 * while we need to undo write acess below.
> +		 * while we need to undo write access below.
>  		 */
>  		mnt = mntget(nd->path.mnt);
>  		do_truncate = true;
> -- 
> 2.56.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
