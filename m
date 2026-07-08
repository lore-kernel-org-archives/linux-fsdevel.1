Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6D372EDD
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525839; cv=none; b=sJFU+9OQeCbWrPtNkkqEI3+9pGGGpv99zyYvoWiKlcyG2NutDxZfQMnT9gTbI4h7NeJAxqeMzs/reajq7QNqrMiLLAGmvn14EO/Yla8OMZ57R2vI2e5p0PWDg3K8RuRGSxxnSZCguZ0iZo6R/PxfEokl8MhCEa0pMWIbaz2yXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525839; c=relaxed/simple;
	bh=GSqVOF5FdHGVGJEPxgkwgT6GsULiB/JmxdpZmY6edow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+IU9pe1G1hE4XQV9HOM4wyl8WEtR1a+iAnEUWxbepiMOP24DiCnh+46oBWa+CVXzPzxMt0PvPEeGxQSQK3YB+JNUbkhCf0m0p3C41AtCLqdrL6X1E3Q/W1w+vRzAMXpgSUrjGMFH6vOv2ct8iuDoe7r5CK42oZg2G7tprh5bLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V6kvgugn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CE2kNZJa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V6kvgugn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CE2kNZJa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V6kvgugn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CE2kNZJa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V6kvgugn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CE2kNZJa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15F4075F21;
	Wed,  8 Jul 2026 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783525836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q7kxwCbd44mF+etD0hvPMr2LSv1SOszwIwfwIod8vw=;
	b=V6kvgugnDl3YNn8sj7xW5Q13LfL1DQP5uNv4CaKNJ3ZhdEg9UhHaDH3dmKj7hlIqGOlZTv
	LPUG2jRbU0zBJ14FTmc3OdziILcdmquQaudYJtSABV9ugXeoo2Urp0Z3AR3c+uKuK6ktk8
	uDNd7netO0z0a1nK9+/jCOlRIw12HQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783525836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q7kxwCbd44mF+etD0hvPMr2LSv1SOszwIwfwIod8vw=;
	b=CE2kNZJaeeyVuncJnT9NK49ko1GlAabEbYZ8s6rvbvl/hIkRkQ572UgAK8Pd6MS+kVzI55
	1qjxbQwIpygBIxBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=V6kvgugn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CE2kNZJa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783525836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q7kxwCbd44mF+etD0hvPMr2LSv1SOszwIwfwIod8vw=;
	b=V6kvgugnDl3YNn8sj7xW5Q13LfL1DQP5uNv4CaKNJ3ZhdEg9UhHaDH3dmKj7hlIqGOlZTv
	LPUG2jRbU0zBJ14FTmc3OdziILcdmquQaudYJtSABV9ugXeoo2Urp0Z3AR3c+uKuK6ktk8
	uDNd7netO0z0a1nK9+/jCOlRIw12HQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783525836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q7kxwCbd44mF+etD0hvPMr2LSv1SOszwIwfwIod8vw=;
	b=CE2kNZJaeeyVuncJnT9NK49ko1GlAabEbYZ8s6rvbvl/hIkRkQ572UgAK8Pd6MS+kVzI55
	1qjxbQwIpygBIxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D232779AE;
	Wed,  8 Jul 2026 15:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FGstA8xxTmqqUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Jul 2026 15:50:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5BCFA12D6; Wed, 08 Jul 2026 17:50:31 +0200 (CEST)
Date: Wed, 8 Jul 2026 17:50:31 +0200
From: Jan Kara <jack@suse.cz>
To: Qingshuang Fu <fuqingshuang@kylinos.cn>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] fs: fix two spelling mistakes in comments
Message-ID: <q3qjcmhu2mwvx62rv5yr3uflqhbfv7go7f6ihegommntgvo5cv@yvfyveatbuoj>
References: <20260527033102.824028-1-fffsqian@163.com>
 <iqp6gjxl7qohnxn7rle62zovyiedmw7nnfhjk5mpmq4azx7v5m@llgoenjgzgbf>
 <2fd64e26.5358.19f3b56d73f.Coremail.fuqingshuang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fd64e26.5358.19f3b56d73f.Coremail.fuqingshuang@kylinos.cn>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 15F4075F21
X-Spam-Score: -4.01

On Tue 07-07-26 14:49:34, Qingshuang Fu wrote:
> 
> At 2026-05-28 19:52:19, "Jan Kara" <jack@suse.cz> wrote:
> >On Wed 27-05-26 11:31:02, fffsqian@163.com wrote:
> >> From: Qingshuang Fu <fuqingshuang@kylinos.cn>
> >> 
> >> Fix two spelling errors in fs/:
> >> - childen  →  children
> >> - postion → position
> >> 
> >> Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
> >
> >Looks good. Feel free to add:
> >
> >Reviewed-by: Jan Kara <jack@suse.cz>
> >
> >								Honza
> >
> >> ---
> >>  fs/coredump.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/fs/coredump.c b/fs/coredump.c
> >> index bb6fdb1f458e..f82f6dc4f773 100644
> >> --- a/fs/coredump.c
> >> +++ b/fs/coredump.c
> >> @@ -637,7 +637,7 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
> >>  		pidfs_coredump(cp);
> >>  
> >>  		/*
> >> -		 * Usermode helpers are childen of either
> >> +		 * Usermode helpers are children of either
> >>  		 * system_dfl_wq or of kthreadd. So we know that
> >>  		 * we're starting off with a clean file descriptor
> >>  		 * table. So we should always be able to use
> >> @@ -1053,7 +1053,7 @@ static bool coredump_write(struct core_name *cn,
> >>  	cn->core_dumped = binfmt->core_dump(cprm);
> >>  	/*
> >>  	 * Ensures that file size is big enough to contain the current
> >> -	 * file postion. This prevents gdb from complaining about
> >> +	 * file position. This prevents gdb from complaining about
> >>  	 * a truncated file if the last "write" to the file was
> >>  	 * dump_skip.
> >>  	 */
> >> 
> >> base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
> >> -- 
> >> 2.25.1
> >> 
> >-- 
> >Jan Kara <jack@suse.com>
> >SUSE Labs, CR
> 
> Hi Jan, Al, Christian,
> 
> Thanks Jan for providing the Reviewed-by tag on my original patch.
> I sent out v2 one month ago which carries your reviewed-by tag, but there has been no further feedback.
> 
> This patch only fixes two trivial spelling typos in coredump comment, no functional logic changes.
> Could you help review/merge it when you have spare time?
> 
> Reference v2 patch:
> https://lore.kernel.org/all/20260529040701.1825238-1-fffsqian@163.com/

Yeah, I believe it has fallen through the cracks in Christian's mailbox. I
guess he'll pick it up after this ping.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
