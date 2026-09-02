Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E939D6D6;
	Wed,  2 Sep 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344291; cv=none; b=rDiYdhO13SZhgTVwLANi2XUWDuhZqLf4m3t9xkNyVydMFni4e90+omxPnURM/x2/RwdA1iOFaA8liOf9koDw4nPvLP9Pc/aJi4yFGSP4/vRTOVM+iAt+bw1GKAZgzW5ipnQSarv13I7TpHgF9QaPLnwq9+tzWBJwr5+MKUbi9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344291; c=relaxed/simple;
	bh=L4dl+I8eJZr3QwINbEgQX0+lXkQHdU/NO7O3NIe/AO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDhvz74ZkSn5cNJSO0Ch9HSzPXdWgxSFeNRJMj+NbiQzseajC03aNfKd3t/C0WL8+/YB8ZYBcpKYo7E4EkSu6y5b5Gs3XvgKvR5ZxCzzC912JYHCgWvKRhwcbffQ+V6TSjB303pfW8Z5XF8p7WO/9VaYm4UaRHNx57AF7UlrEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0CTONCk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Frhm3lg0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jLcf4ese; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n8AmMtZR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0CTONCk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Frhm3lg0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jLcf4ese";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n8AmMtZR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C684121CDA;
	Wed,  2 Sep 2026 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788344283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leU8WBYFb+b1H5ZuoGcOMF3uO0IPANu0kE55T3Hz8Ig=;
	b=B0CTONCkNrxCg8WLHfPFskz9pEolmu9iGFvby14IKuxzKsLNCMHAuxZF32eYur9FVF2SgO
	Gs4r4/ymxbq8sQZXrLULdU0Mbmq44rf9IBr8FcRnGao4Voe6S1Uy/5PsGVvZzDmy27kUce
	5r/p9y7wD3geFSSkn9DzmO35ZcyprHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788344283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leU8WBYFb+b1H5ZuoGcOMF3uO0IPANu0kE55T3Hz8Ig=;
	b=Frhm3lg0SCTtPlFKZkN7vPxtpyU3VCcedStCRf6yNgGHuDzezIodRSwpiTPc6yrm253ytT
	LRWo1EAZqEgDZWDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jLcf4ese;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n8AmMtZR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788344279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leU8WBYFb+b1H5ZuoGcOMF3uO0IPANu0kE55T3Hz8Ig=;
	b=jLcf4ese1nTodXaE1Iocx58Ey/ZInriHbPl7sw2pcMksgSRMpftfDlYf5UWzhQAwEjJEz3
	z/REwIfuxzVMhAvV/vVkAl8Iv9doT0iS+YxqZErVyp/LkercJ1l/wJ/0bXhn9Ect622/BQ
	CMGmoootdrGt1b3qynO+g21lIFh+0r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788344279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leU8WBYFb+b1H5ZuoGcOMF3uO0IPANu0kE55T3Hz8Ig=;
	b=n8AmMtZRnpuOj56A4xP2JJ751dYv0vlut2L0CB94wSZqXLAFjbfkNRUB3zWZOZzpahErCW
	EbWq3Bx+hdqRFZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A524B136E6;
	Wed,  2 Sep 2026 10:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PqhEKNf3l2oYFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Sep 2026 10:17:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2CA2AA13B5; Wed, 02 Sep 2026 12:17:55 +0200 (CEST)
Date: Wed, 2 Sep 2026 12:17:55 +0200
From: Jan Kara <jack@suse.cz>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: jack@suse.cz, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lkp@intel.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH V2] fs: Kconfig: Alignment of code and text in the FS_DAX
 help section for better readability
Message-ID: <ga4rb66i2zartjmraicprs7vpvkeaphi6juhajfi2mmcxqtitg@eqvtcf34mrdx>
References: <tobxd52ikncxgffyrbz6bwvz3rk4joxrf2i7agh2ajevkgwfre@xekv4txekrsf>
 <87zey0ouzj.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zey0ouzj.fsf@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C684121CDA
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
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 02-09-26 15:06:32, Bhaskar Chowdhury wrote:
> Ah, you are missing the point. Reading a single straight line and read a
> divided line make difference.
> 
> I took away the line divisor( the forward slash at the end of line to
> break it) and while doing so, the colon at the end of it produces "build
> error" as the kernel-test-robots complained.

No, I got that part. What I was objecting to was that merging these split
lines into longer ones is beneficial. I've actually tried in my terminal
and after the proposed patch things actually look worse (the long lines get
trimmed in the view, you have to use right arrow to scroll the kconfig help
window to see them all).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
