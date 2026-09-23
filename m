Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8A4F30D6
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188846; cv=none; b=qY+aDWBx7I2WSH28dHfl/OPGaDOrp7Xu/S8Srs8VDkgHFxAAqoFy6HB0L0zO6a3r2BvM5L5CSHS12jSNyxAm0S2ONp3L1ogwOO616Y8CFI01Q02j7cEdLw2xClpR5EHXa0MFZShCi6aCU/ri1DyAfPRsC5YZ9V4AxA1l+lyFHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188846; c=relaxed/simple;
	bh=22CULu6ulJ5AeXjY/wToPJolZBNJtjj2QI3H1mZUo/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpf5IoXee73R2kYDmhSysp/SoU0tjHARQYs07cJGRhkpExkaZwedmBe2WYy53bea8Ify3vQ/xXkUNby8HN0LsuYWS7NPsZ0csGIS/X2awIjHXlCVcxHqRi9LikGyuartjlGfJZ4JxjMJv5b5EHa+bJb2PIY5xKDLXZNsOGjBUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rxE197jS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MfpgrgqN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kDUrGjau; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tsWI34OC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rxE197jS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfpgrgqN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kDUrGjau";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tsWI34OC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10C791F79F;
	Wed, 23 Sep 2026 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790188832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzDpsagwjubWKoJjqqHuCsV8wjoSl3KlBaa7WjGDsm4=;
	b=rxE197jSVxQEuchkbHss4YoOTWD22bIBSS52ZclpY4HTKmpxqDex9zeqV1fLcdg5Wx32zN
	mhqa19KBRGgHeXQ9XrWcAYPh8zoqnLu3oqfdgtc3XhAQ6f0Q4wewyMRPyzK9ZqdemD3MkF
	N4lM9Wapgw20/yWZGyEpyZpmeXjOP4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790188832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzDpsagwjubWKoJjqqHuCsV8wjoSl3KlBaa7WjGDsm4=;
	b=MfpgrgqNdiyZPFqJXaiO0yHamgZPUfuW6bAC+wcswTmlMfcRe482GCOHnQHdUmU72Cyv6q
	NSv9oQGgiUE7L+DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790188828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzDpsagwjubWKoJjqqHuCsV8wjoSl3KlBaa7WjGDsm4=;
	b=kDUrGjauh7D3QFbZHKJhbAL+B/NpuHMlyf8RddPcyvjyNAA1oHIiLyNFKZXWrJzGXFxBUC
	+xv05YfPq+evgm0MZTmSEgLTWq61Zh9EqYlN7p9YgoRz/h49AybyYBvek+aE1xRfYFBm6z
	yTFn3eL7k20UmaIGPs1MtEmVKAcFkbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790188828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzDpsagwjubWKoJjqqHuCsV8wjoSl3KlBaa7WjGDsm4=;
	b=tsWI34OCL41s7CF95I8ypDUZW6mHl4We2EFveMJheXJBThMb4Az6a9MeI41+150aQEQkaT
	8claxUAS/uKJihBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD0C3134E8;
	Wed, 23 Sep 2026 18:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZNu5LRsdtGqcdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 18:40:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F910A13D4; Wed, 23 Sep 2026 20:40:27 +0200 (CEST)
Date: Wed, 23 Sep 2026 20:40:27 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Thomas Schmitt <scdbackup@gmx.net>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] isofs: Always advance to the next block in readdir and
 lookup
Message-ID: <v6z353w6ngxaqistefy5hex53mzia4q4dapnfs6dtw6cxmkz7k@qeampdcsvd6b>
References: <20260922121912.2258134-2-jack@suse.cz>
 <20260923153134.771632-1-matthias.goergens@gmail.com>
 <vjb4g4xyuare7b6w6lwtbuijboeqhrzdo4vboi7fgpyeu4prtx@gv2zvtsbae6u>
 <20260923175208.1576995-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923175208.1576995-1-matthias.goergens@gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmx.net,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Thu 24-09-26 01:52:08, Matthias Goergens wrote:
> On Wed 23-09-26 18:55:11, Jan Kara wrote:
> > So I agree what you do is easier to understand so I'll fold it into the
> > previous commit. Just I'm not sure it is a realistic failure case - that
> > would mean a directory would contain full block of zeros which I don't
> > think can happen. Plus this infinite loop was there forever AFAICS and
> > nobody complained...
> 
> Thanks for folding it in.
> 
> Maybe I'm missing something, but I thought the loop came in with
> 3c01d9263683.  Before it, both walkers advanced with
> (pos + ISOFS_BLOCK_SIZE) & ~(ISOFS_BLOCK_SIZE - 1), which moves on even
> when pos is already aligned, and mainline lists the reproducer images
> fine; only for_next spins on them.  Is there an older path that loops
> that I haven't found?

Hum, right. Today isn't my best day ;) The old code will indeed move to the
next block even if the first byte is 0.

> Agreed that a well-formed image with 2048-byte blocks won't have such a
> block.  But only the first byte of the directory block has to be zero,
> since the walk doesn't look past it: a crafted image needs one byte, and
> faulty hardware or an incomplete copy that returns a zeroed sector does
> it too.  The task then can't be killed.

OK, for corrupted image I agree the looping was possible and it's good to
have that fixed. I just wasn't sure from your explanation whether you don't
have some valid image in mind.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
