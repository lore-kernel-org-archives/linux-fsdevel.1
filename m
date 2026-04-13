Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484435A925
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092945; cv=none; b=Qz49im6d7uw0q1aCFMgGD/9sbFz05AYktNPegHZhg/IsyqIqcByE8wGPvY/KkqRcD+EboFfVRgcZRRT1Pqi93k1bB0WTCUXThs7ft0WVTbMPTWuS4p+3v1SP5/sFHp6wQwylo4JYw0em7rEL6cUeW63OV2EtyovjoJfBbnJYQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092945; c=relaxed/simple;
	bh=jDMP+fZwqfgD5IA8cPIvPtBkwaDAjYm8eZ6T53j405M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD6JRxc+1M+HgN2oUNFVOrP+lr95UJVI+6GMw2ZjSuMNsjCw6d6qX7nqOL68IzXo5ICFcSn+2vW7XiDo7CcAMsxQTkL+zEgPcODhpNABnMnLe2g1eR9uJI8Tz8oMh4oa8IEajj+RJUTmqv0dPsmEEAAFZtO3i+2x+Hld1y+Cqug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EEybKn28; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HuddEAv7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EEybKn28; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HuddEAv7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EEybKn28";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HuddEAv7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EEybKn28";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HuddEAv7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83E106A8AE;
	Mon, 13 Apr 2026 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776092942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UgetTjD7giGAxpCxHYMrnKGytpHhQ8QqoYwhRAcF104=;
	b=EEybKn283N1i5bwlicKEtdQ/XFWHo6Kg2SeMjb29cTZ09zpjbsJifIP44m8UMgIZdkYS64
	iJ4+Rc6zm5zlOY1kynuMtDsWK9rTWZLCihHAYZk21TfNPGCNz4roFW3XvVAoQ4xEtEbBP+
	GAQpGX4Ho9GSe86gEJi9DVkWSvcLCtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776092942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UgetTjD7giGAxpCxHYMrnKGytpHhQ8QqoYwhRAcF104=;
	b=HuddEAv7ysEcZGsKxZOphcZy0P4vIG4lAG+A/Ov6s+plSApbhonYpBzx3eFmH8MzIEgnKL
	r5wFA7KD9u0B4kDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EEybKn28;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HuddEAv7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776092942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UgetTjD7giGAxpCxHYMrnKGytpHhQ8QqoYwhRAcF104=;
	b=EEybKn283N1i5bwlicKEtdQ/XFWHo6Kg2SeMjb29cTZ09zpjbsJifIP44m8UMgIZdkYS64
	iJ4+Rc6zm5zlOY1kynuMtDsWK9rTWZLCihHAYZk21TfNPGCNz4roFW3XvVAoQ4xEtEbBP+
	GAQpGX4Ho9GSe86gEJi9DVkWSvcLCtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776092942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UgetTjD7giGAxpCxHYMrnKGytpHhQ8QqoYwhRAcF104=;
	b=HuddEAv7ysEcZGsKxZOphcZy0P4vIG4lAG+A/Ov6s+plSApbhonYpBzx3eFmH8MzIEgnKL
	r5wFA7KD9u0B4kDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FE5C4AF4A;
	Mon, 13 Apr 2026 15:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJ6AAA4H3WnnKAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 13 Apr 2026 15:09:02 +0000
Date: Mon, 13 Apr 2026 16:09:00 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: Linux FS development <linux-fsdevel@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/5 -v2] Add support for VMUFAT filesystem
Message-ID: <uamj3cggfd4fdvah6jjfbyqmffxaib7yj4upbnkxzudaos6ig6@xz4rhorxkufp>
References: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 83E106A8AE
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sat, Apr 11, 2026 at 04:11:34PM +0100, Adrian McMenamin wrote:
> SEGA Dreamcasts come with a "visual memory unit" (VMU) which contains a slab
> of flash memory to save games playable on the VMU or data from Dreamcast games.
> 
> The VMU uses a file allocation based filesystem - which we label VMUFAT - to
> organise the data. With a control block, a file allocation table and a directory.
> 
> All physical VMUs are of the same size (256 blocks of 512 octets) but the
> filesystem itself is extendable to other sizes and need not be tied to the VMU.
> 
> These patches implement VMUFAT as a Linux filesystem independent of hardware.

Isn't this filesystem a great target for FUSE? You definitely don't need
super high performance here.

Also, you're missing the fs maintainers. Adding them.

> 
> It seems obvious almost all users will be those working with Linux on
> Dreamcasts or Dreamcast emulators but there is no dependence on SH or on the
> MTD layer.
> 
> VMUFAT has been tested on a 32 bit Dreamcast and on x86_64 systems.
> 
> Tools to format a filesystem are available here: 
> https://github.com/mcmenaminadrian/mkfs.vmufat
> 
> Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
> 
> Adrian McMenamin (5):
>   Add vmufat super.c
>   Add vmufat inode.c
>   Add vmufat header
>   Add vmufat documentation
>   miscellaneous vmufat changes and additions
> 
>  Documentation/filesystems/index.rst  |    1 +
>  Documentation/filesystems/vmufat.rst |  127 ++++
>  fs/Kconfig                           |    1 +
>  fs/Makefile                          |    1 +
>  fs/vmufat/Kconfig                    |   14 +
>  fs/vmufat/Makefile                   |    7 +
>  fs/vmufat/inode.c                    | 1017 ++++++++++++++++++++++++++
>  fs/vmufat/super.c                    |  581 +++++++++++++++
>  fs/vmufat/vmufat.h                   |  126 ++++
>  include/uapi/linux/magic.h           |    1 +
>  10 files changed, 1876 insertions(+)
>  create mode 100644 Documentation/filesystems/vmufat.rst
>  create mode 100644 fs/vmufat/Kconfig
>  create mode 100644 fs/vmufat/Makefile
>  create mode 100644 fs/vmufat/inode.c
>  create mode 100644 fs/vmufat/super.c
>  create mode 100644 fs/vmufat/vmufat.h
> 
> -- 
> 2.43.0
> 

-- 
Pedro
