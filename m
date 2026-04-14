Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8283CA4AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162166; cv=none; b=e2Dk79sIUI5tFRFf059rJ/TT353SEN6AljJ68LrUIxiN1ZBJ7bFUg/yZyisK68sG2UZX3t1nL38JuJmr01QQ7pJvW8CcIQJzfsh4VwE9+uNKOJt+yaSZiqXeAaBDS3xyLjUr4C/3hXaIfvFpSqm1+KECFaXxQfPYhVjqlUYGzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162166; c=relaxed/simple;
	bh=RHyY3fu+KsskXf9Ho9PFuJfqQqHGL6sXPkChG335C00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBeZzssD9LDNu7E9pu8P7fgZ3eX+bE6W5JNCuZzVsdlsE9tXZR7xed0RJPwAPe9b09BMxtNzn8hwZlclPsbljkHJtb6bxEmEulhsouED6dL2YpkAoy+UANB55vFQuSXeVlQv/Wxrf2bB/Y5OxJvA81DdzNDlz3vee7YMIXx5r5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ox++Anid; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N6tr2sly; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ED6dSCiq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u4qaZEyC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ox++Anid";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N6tr2sly";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ED6dSCiq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u4qaZEyC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0EE96A8CA;
	Tue, 14 Apr 2026 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776162158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0TNOkA/+a7W7vErcFBKrNBDFT19xL80TsUxcGCksYo=;
	b=Ox++Anid9LYWuZqS+PUwQBxuuvcABjVDcQnw4jX0PWItsOI4RDk5RE18i/lqxXoHDARjjQ
	DXo9jSAfM5qjCS2zUkVzYelazgsU8qh8jc/Z+SOjq9rU/3TZw77rlC3t6l5yFS66cTqc67
	r0FRnVVHJoW+HbiCs9HKpNwaPIqT76w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776162158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0TNOkA/+a7W7vErcFBKrNBDFT19xL80TsUxcGCksYo=;
	b=N6tr2sly/YqmqYnX1tfOg0+/0YEbKts4beCq1bIgmNDVR7hLW9uHQv6Ubue8RO0EaLoei0
	9ehitt/PfTVxBUBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776162157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0TNOkA/+a7W7vErcFBKrNBDFT19xL80TsUxcGCksYo=;
	b=ED6dSCiqALiqtWCaf0v19sDgYkSIPWtVQaHBt6Rs32bN7weloZnpSq52cfP4cGKikptztV
	6lRNrfPOiaDBAiZK76otnorfowb4ec6Gmh/t7hPdpEKV96G6FyPwZsZIx43txG/6b9r6b7
	niIKUMqahLuzhWzuISm3Ss/ATzSBm/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776162157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0TNOkA/+a7W7vErcFBKrNBDFT19xL80TsUxcGCksYo=;
	b=u4qaZEyCzZ9Ks7vu627v8+uZH5EtvIFD5LMUf2FmaIUmgqtYNkZzxAWiYEnxvHByY0gHQV
	fa6iPKbJLkPCpcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E7014B3C4;
	Tue, 14 Apr 2026 10:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2X7XD20V3mmgBQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 14 Apr 2026 10:22:37 +0000
Date: Tue, 14 Apr 2026 11:22:35 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Aurelien DESBRIERES <aurelien@hackers.camp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, willy@infradead.org, djwong@kernel.org, adilger.kernel@dilger.ca, 
	pedro.falcato@gmail.com, xiang@kernel.org
Subject: Re: [PATCH v3 00/12] ftrfs: Fault-Tolerant Radiation-Robust
 Filesystem
Message-ID: <bxgqldv2abuadh3gweymib2co6gfor7sgpbkouznj6jliyblfq@42xw4jviodeb>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414120726.5713-1-aurelien@hackers.camp>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,infradead.org,kernel.org,dilger.ca,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hackers.camp:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Tue, Apr 14, 2026 at 02:07:13PM +0200, Aurelien DESBRIERES wrote:
> This is v3 of the FTRFS patch series. FTRFS is a Linux kernel filesystem
> designed for dependable storage in radiation-intensive environments,
> implementing Reed-Solomon FEC at the filesystem block level for in-place
> correction of silent bit flips on single-device embedded systems (MRAM,
> NOR flash) without external redundancy.
> 
> Based on: Fuchs, Langer, Trinitis - ARCS 2015, TU Munich / MOVE-II CubeSat.
> Full text: https://www.cfuchs.net/chris/publication-list/ARCS2015/FTRFS.pdf
> 
> Changes since v2 (<20260413230601.525400-1-aurelien@hackers.camp>):
> 
>   - iomap IO path: replace buffer_head based read/write with iomap API
>     as requested by Matthew Wilcox. Implements ftrfs_iomap_begin/end,
>     iomap_writeback_ops (writeback_range/writeback_submit), and uses
>     iomap_bio_read_ops for the read path. buffer_head is retained for
>     metadata IO (inode table, directory blocks) as discussed.
> 
>   - rename: implement ftrfs_rename in namei.c. Handles same-dir and
>     cross-dir rename for files and directories, updates '..' entries
>     and nlink counts. RENAME_EXCHANGE and RENAME_WHITEOUT return
>     -EINVAL (not supported in v3).
> 
>   - RS FEC decoder: implement full RS(255,239) decoder in edac.c using
>     Berlekamp-Massey error locator polynomial, Chien search, and Forney
>     algorithm for in-place correction. Corrects up to 8 symbol errors
>     per 255-byte subblock. Returns -EBADMSG if uncorrectable.
> 
>   - Radiation Event Journal: persistent ring buffer of 64 x 24 bytes
>     in the superblock reserved area. Records block number, timestamp
>     (ns), symbols corrected, and per-entry CRC32 for each RS correction
>     event. Written under spinlock via ftrfs_log_rs_event(). No existing
>     Linux filesystem provides this filesystem-level radiation event
>     history - VxWorks HRFS, btrfs scrub, and NVMe SMART all operate
>     at different layers.
> 
> AI tooling disclosure (Documentation/process/coding-assistants.rst):
>   Assisted-by: Claude:claude-sonnet-4-6
>   The submitter takes full responsibility for all code, has reviewed,
>   tested, and debugged every patch.

I was going to ask if you were on the world's strongest stimulant but, yeah,
this also makes sense.

3 versions in a day and no reply to review comments, no usecase, just vibes,
AI ones at that. This latest batch even got the LLM to hallucinate my old
email address.

Naturally,
Nacked-by: Pedro Falcato <pfalcato@suse.de>

Please pick this up to every patch if you get to send more slop versions.

-- 
Pedro
