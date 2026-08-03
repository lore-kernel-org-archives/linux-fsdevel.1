Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED36345EC0
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749801; cv=none; b=CReb+1UBb2KJQOUqsvSxZ9d5NrCr3h2fkRrwGkZ+liKoB8tF6bYQl7mlGqmSqw383WY7RkBbnLAG2Ti3mjm6uOFHPgDHuNp3mpAUpRV0Wnx1nszY2jevsmr/QrMc/ocaZHdK9YuUDGsdAlLdvwYgrPPOSGo4NwyCGGGiP+w9vcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749801; c=relaxed/simple;
	bh=JcLaJWvNBhfL+qNHmfjA572j8N6/qWfJmrhDrmgtf9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtKca1dZ7QZMj81dQjuopHGTxX7/dtuFBqvcaejzV7him1J/YNCGm4FbyfpcFJHpzDhL37TW7fz1GpEL9/F63OztCxJZnyiZY9j4ipV5pCQJXfOXWqMKQkkYXLTRGg9hGArxcmazhogKUZdHRE7usvvFyzVVFtP6y3A18vJPFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l8i0COTt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XaJmKW5G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J2HLDY+Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFaTONOY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l8i0COTt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XaJmKW5G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J2HLDY+Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFaTONOY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 527673E06;
	Mon,  3 Aug 2026 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785749789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3StYU4PnkxHEDavzJEVYJFyozTO0wM/EH0NQIlVmxo=;
	b=l8i0COTtrpsb0SBtIjyuNFWUQMaB3pJ+pmZzqCJASCpvsHE2GmRjx7IVpmtquyDPcJ14Qw
	8pluWx6fxLFFd049v5NxlGztkc4pomPSYJalChMyWcravML0qJQueC2b8jh3ZjV/Jr7SwY
	IS7JZfMfqZP1HvCgv6OCvMw1j0fh5Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785749789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3StYU4PnkxHEDavzJEVYJFyozTO0wM/EH0NQIlVmxo=;
	b=XaJmKW5G23n3sGAB9ZSDWM2tK72XaisY/yg/OoiBhEHKm9cdXgbpEuQwXDDjkkUUGgMz9/
	gvApnZkjGl8uNZAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J2HLDY+Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zFaTONOY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785749785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3StYU4PnkxHEDavzJEVYJFyozTO0wM/EH0NQIlVmxo=;
	b=J2HLDY+YvhfdQPY7UfPWo5PTvkC8gBd3jXn553q7d+TfjluZkaoN+1ViZh/zhOx5YmAS9+
	F55rMY+V7l2ug0xkMr4KXU0LjyqOWeEYDg8RDScwqIaK+eyBI61MJB+UPgEt78jriX81nU
	kmePdydvw3thUdxwWc7xzV0VpmAmyKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785749785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3StYU4PnkxHEDavzJEVYJFyozTO0wM/EH0NQIlVmxo=;
	b=zFaTONOYiNvkd0qeoTQZg9GSZdXk+hxaRtCmCYfKLfCc2PHeQAfjvnGb+e9Ouh9W93d8DA
	WluG1eeQLGY6mrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A490779D3;
	Mon,  3 Aug 2026 09:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1u8cEhlhcGokIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Aug 2026 09:36:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6766FA13A4; Mon, 03 Aug 2026 10:57:14 +0200 (CEST)
Date: Mon, 3 Aug 2026 10:57:14 +0200
From: Jan Kara <jack@suse.cz>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as UFS filesystem maintainer
Message-ID: <opm7uuadw7ctvvo6uln22nb6id3pepcs4nohunq7tzeaciq3kc@kigwxsd3pcbo>
References: <am10yuQx5a3h2pXH@casper.infradead.org>
 <20260801073059.63651-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801073059.63651-1-ali@iusegentoo.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 527673E06
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Sat 01-08-26 10:30:59, Ali Ahmet Memis wrote:
> What I care about is ufs bugs not being ignored. If routing my fixes
> through you or the vfs tree is the better path, that is fine by me.

I'm a bit curious: Are you using UFS driver in Linux? Or do you know of
anybody using it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
