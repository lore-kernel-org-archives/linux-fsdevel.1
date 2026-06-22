Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBE37267B
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124805; cv=none; b=jlYn6FGpj20n5cH2Mhb9wPa3FYGFR34RfGNkndHJy0hziTyjtLinicMT6UY8lHWuivAZZ0VZWAtYH39AHSMr0O0jiWPyAe19FaudyQR4y20s/qjqOI//u/NvdLaUF+TuNS2t0vi2xfHRgPe75qnHdbAUvmNKZs7PrhQF6WeT7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124805; c=relaxed/simple;
	bh=/M98N0nWbPLHBSGDEZ/remPQFSTrMRR6mILK2OdC3is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTMY/pz6m1Xc5t5sMmSG28xS+qp8U8TxWTJPRg3R7iRPqljkAIMB+/44uFqwiqteDSjxB8kCwm5Xh9rshOSx05gpvGfG6ePN6UP2oyP/KVZPsmcOfKblHssVnBI3tnxLtpA5+fkxGWOpZ0e6XkjlGxzJSQltkMfXxwKeCDRQKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nr2pAkOR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AGIoKqh/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nr2pAkOR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AGIoKqh/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nr2pAkOR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AGIoKqh/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nr2pAkOR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AGIoKqh/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5082A75B66;
	Mon, 22 Jun 2026 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782124802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkRuo/RALBae4rTRv8OE22ZA7JcrZTDytq9aKv/jWx0=;
	b=Nr2pAkORoAbYHVh90pXxrF7Z3nfKZSL+HUm6JhBdUjwAqSDmMqMNsGNgNBq79NwQo/Xqam
	4MZ0dJvxsegm9PX+fhpL9Uegqd6vqvmyEXppXGirgE9fVYBZ+DrkEDSAjVLRd6z8KVMyda
	CNVCzk0Ryxv/TYLMOL3/yscp0wrp9pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782124802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkRuo/RALBae4rTRv8OE22ZA7JcrZTDytq9aKv/jWx0=;
	b=AGIoKqh/cXXPyqn81qUZONwGXhOJgKygXJbyKGuoEpoj2EzB6ydGlBlIFbcfTOc4VS1CLe
	tZTo0zPpqP/jCKCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nr2pAkOR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="AGIoKqh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782124802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkRuo/RALBae4rTRv8OE22ZA7JcrZTDytq9aKv/jWx0=;
	b=Nr2pAkORoAbYHVh90pXxrF7Z3nfKZSL+HUm6JhBdUjwAqSDmMqMNsGNgNBq79NwQo/Xqam
	4MZ0dJvxsegm9PX+fhpL9Uegqd6vqvmyEXppXGirgE9fVYBZ+DrkEDSAjVLRd6z8KVMyda
	CNVCzk0Ryxv/TYLMOL3/yscp0wrp9pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782124802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkRuo/RALBae4rTRv8OE22ZA7JcrZTDytq9aKv/jWx0=;
	b=AGIoKqh/cXXPyqn81qUZONwGXhOJgKygXJbyKGuoEpoj2EzB6ydGlBlIFbcfTOc4VS1CLe
	tZTo0zPpqP/jCKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43B3B779A8;
	Mon, 22 Jun 2026 10:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CiWBEAIROWpGfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 10:40:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DF419A12DE; Mon, 22 Jun 2026 12:39:57 +0200 (CEST)
Date: Mon, 22 Jun 2026 12:39:57 +0200
From: Jan Kara <jack@suse.cz>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: kees@kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, shuah@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
Message-ID: <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5082A75B66
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_HAS_CURRENCY(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sun 21-06-26 21:39:32, Farid Zakaria wrote:
> Currently, standard ELF and ELF FDPIC loaders require a fixed, absolute
> path to the dynamic linker/interpreter (specified via PT_INTERP). This
> creates significant inflexibility for relocatable dynamic interpreters,
> where binaries are packaged independent of global system paths.
> 
> The primary goal of this patch series is to support relocatable binaries
> in Nix, where packages are stored in a read-only store (typically /nix/store).
> Allowing the ELF interpreter path to be resolved dynamically relative to
> the binary's location via $ORIGIN enables Nix packages to be relocated
> without needing patchelf or wrapper scripts.
> 
> For details on the design and motivation for this in Nix, see:
> https://fzakaria.com/2026/06/21/nix-needs-relocatable-binaries
> 
> This series introduces support for resolving the $ORIGIN placeholder in 
> the ELF interpreter path, bringing the kernel's binary loading behavior
> in line with user-space dynamic linker origin resolution. 

Thanks for the patches! Before dwelving into implementation details we
need to discuss whether something like this even belongs to the kernel.
Frankly to me this looks rather arbitrary and tied to the particular way
you've decided to setup your package management system. In particular the
usual answer for situations like these is to use namespaces which you
discount in your blog with: "If you are using tools like Bazel or Buck2
they likely already employ their own sandboxing via namespacing for builds.
Integrating Nix into these ecosystems becomes incredibly impractical
because we run into nested user namespace and mount restrictions."

I don't know enough details to really judge but it seems to me like you are
trying to workaround a mess in userspace with kernel changes.

Anyway I'm pretty sure Christian will have more educated answer than me but
I just wanted to express my skepticism about this approach and that perhaps
you wait for feedback from him before spending more time on these patches.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
