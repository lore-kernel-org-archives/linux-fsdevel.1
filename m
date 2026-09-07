Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2043E094;
	Mon,  7 Sep 2026 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768918; cv=none; b=ddky6IG8o/CcVMwhTmakgs+vT9MzzW4ZPIwdIzD/2I46051SZzZjbw/375AQPQjjURw+AcmZhPJ7CuO0KEee9Aa+KBiP4zqDUjFVmg7hsa6hgNeiIToU++x3M6EOi3VzBi5delaHJGcjk6JTChrBHcL5wctaeblUMQ7soweqPwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768918; c=relaxed/simple;
	bh=ElOIULgAMDi4U9S3SooKnwGu2kYRiN8Nt64uHmhI5W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV5wfq7IdBCtm7FZf6HkPjRnYR7SZvUK7kA4FxgviIzJ7rBqDcQEFbhvPDY9zLzpJgCvReOZJDGgPONRnmxUyfr1hcqxr1q4LQ5jxO9o853C+Q/4HtRGo56qp2UsboBu6Vv/+hdZs73OWXL+GRAQl9FXHK+U8gg3sNCHU0PJsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K1OA/hgK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+LTRB+jP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WfSDut0z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lv/gb01L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K1OA/hgK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+LTRB+jP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WfSDut0z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lv/gb01L"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FB0921B71;
	Mon,  7 Sep 2026 08:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788768910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BNTNFqUdOlzrExQbTmBMvlA8LJ1R3i4u+JN007pPHQ=;
	b=K1OA/hgKxn0d2qrAOWmbQlcgcvpYBUV7oFlrbUntNXwUirFyOfmybC2oR4CuMJtI6sB88D
	FeKbSbUXssehtwtg3VnEjuWYaDrAGRPBeY/sKk4ylzJm8Gfkhe0cKtVMMA1Tc5V4OATQas
	rimsyXrl58ZQtnBBksti371K7LhUUq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788768910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BNTNFqUdOlzrExQbTmBMvlA8LJ1R3i4u+JN007pPHQ=;
	b=+LTRB+jPadJYBX/J7834zmYzTfOF1AamRzsz+fNg2sAtIjMEtKnKiaP6R8y+nSBjGNXhjR
	t8g7uFHVm7IuBdCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WfSDut0z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Lv/gb01L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788768906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BNTNFqUdOlzrExQbTmBMvlA8LJ1R3i4u+JN007pPHQ=;
	b=WfSDut0zIZgn+IqWFdYOqsxe+G1hzDOnkmUTFTupCd2522UvfMBG2P0bnnjXyrzy8PC3et
	Ng+RZwEG5BcuBIFfP3XAyoIC+CdbbMFVLsNqB0ejZQgAaijPRzKy/uj2cUUlMX8zDHDkcc
	kze1WN8okVofcMBLvm/Bh3x2SaQf2YY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788768906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BNTNFqUdOlzrExQbTmBMvlA8LJ1R3i4u+JN007pPHQ=;
	b=Lv/gb01LOSehRrXJzg5G6uT/oa4scgrSbu+Mzf+fDBpvDqU88PGZmizXW52nHKqKmQr2mN
	Piwb0UxEWamwkqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 820551339B;
	Mon,  7 Sep 2026 08:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w1K5H4pynmp6MwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Sep 2026 08:15:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1098CA13B2; Mon, 07 Sep 2026 10:15:02 +0200 (CEST)
Date: Mon, 7 Sep 2026 10:15:02 +0200
From: Jan Kara <jack@suse.cz>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix repeated word 'in' in comment
Message-ID: <fxnknuyxrjcvdvytipdbfnl3czuy6uxoyfzbglz5upfbatords@2o3yhtlfro6u>
References: <20260904123914.583-1-hemanth.selam@gmail.com>
 <20260907042402.12893-6-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907042402.12893-6-hemanth.selam@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9FB0921B71
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 07-09-26 09:54:02, Hemanth Selam wrote:
> Please drop this patch, it is wrong.
> 
>   "the subsequent blocks are going to come in in short order"
> 
> "come in" is the verb and "in short order" is the adverbial that follows
> it.  Both words belong there and the comment reads correctly as it is.

Ah right. It actually makes sense both ways but you are right the change is
unnecessary. Dropping.
	
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
