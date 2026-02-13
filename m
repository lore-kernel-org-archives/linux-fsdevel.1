Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034F31B828
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975337; cv=none; b=Va/IaHkRsgVm+gxrzBJf1JAVKx9I6qilfCXiKi0mXe9sd772J+j/sht2chslMsL6+Gl1QT9GBwbpxNnjMShQ0ThFJ/UTNq90it8KvK24CAkRTXqCKHI0hutgTMCHm+HA0viEX8AikVeGaDAQbIWkQCH9LksbYQocebpMCQ20WLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975337; c=relaxed/simple;
	bh=a0hIZ9W64EiB/jTlbZha/E4Dyvy53mjVGMKxveCfXmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXKU9tB/wUfwIVBOfFUOANW5flgPT7KqcBumKufElbiKoY5A/a1s418hZghQfT02ec3TBrCHckkevvFsn3j9qL0JLKt+im4bYu7u4mhqgYDoieKGUXlj+YKv8qfsX4c0lcwXeuUXfMEQEA3keeGElbII7SGLRn3dfbFoE4YAXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SrR+scQ+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RQT2SYqJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxP6FrLx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kh0DXS0J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SrR+scQ+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RQT2SYqJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxP6FrLx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kh0DXS0J"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A6213E6D7;
	Fri, 13 Feb 2026 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770975333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlDkK35DtBY17drznjj/ZH9stt2AhfeyFIosjNUZrGw=;
	b=SrR+scQ+RQ6n6Fe94OiP4USP9QFGi0ktX0XY7fmPOeTvdHh7kz13fJ1kyke8cT9Q7QjWK+
	94J5X62ZU80Em98rope7ynkRA7OnhKtpEAGpajDsGeDKvUMW/SzWsvo7TaXlvwZtFWRcl1
	x1tbQ5jOr6kQcs/LyzmjY48Yvnai83k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770975333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlDkK35DtBY17drznjj/ZH9stt2AhfeyFIosjNUZrGw=;
	b=RQT2SYqJPatvMF00CeOTQc0dL9/YBKt5t+nJtndqmCZLYBP4cJAi2b0vuQtRFko8KjS/V7
	lS6UIPIILck8uTDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770975332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlDkK35DtBY17drznjj/ZH9stt2AhfeyFIosjNUZrGw=;
	b=hxP6FrLxX24Ait7vKnw3lgRCigUFeBMbTDGhcI5MF/r9tC2BMgHvoxiERoyclGfi1xfC2q
	Gpeww8ewqakQ00e788MC25GDSdX/XkJx5xIgn3AZS/r5VeWWSBnh8IqvmU271IInOPWEPx
	WWCye01EP85iHPYLYvAUlsMICujL7rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770975332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlDkK35DtBY17drznjj/ZH9stt2AhfeyFIosjNUZrGw=;
	b=kh0DXS0J/ZxpHM1qMm3tmAvu2kG+6aPypxcEjhmcpxOmHCdyM3e904jKzZ8djkxhBY70DV
	9HPompKZ9J2jjQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 708B33EA62;
	Fri, 13 Feb 2026 09:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jeg4GmTwjmlcRwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 13 Feb 2026 09:35:32 +0000
Date: Fri, 13 Feb 2026 10:35:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, lkp@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	oe-lkp@lists.linux.dev, ltp@lists.linux.it
Subject: Re: [LTP] [linux-next:master] [mount]  4f5ba37ddc: ltp.fsmount02.fail
Message-ID: <aY7wZwHXH2zS_Sj-@yuki.lan>
References: <202602122354.412c5e65-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602122354.412c5e65-lkp@intel.com>
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

Hi!
> commit: 4f5ba37ddcdf5eaac2408178050183345d56b2d3 ("mount: add FSMOUNT_NAMESPACE")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

The relevant part of the log is:

fsmount02.c:56: TFAIL: invalid-flags: fsmount() succeeded unexpectedly (index: 1)

This is another case where new flag was added so the invalid flag value
is not invalid anymore. The test needs to be adjusted if/once the patch
hits mainline.

-- 
Cyril Hrubis
chrubis@suse.cz
