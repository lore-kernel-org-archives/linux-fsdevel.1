Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7836AB56
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766620; cv=none; b=qwfpO4LRcRVpSdx8to+Tj2u8YjRmCkALbxK1GCmHFjygbzzd0SXQ1PHpK/dDE4nNl9g8WMCDC3HLrRtIv6g2L0hfNCYutwvWeIUkV9FKyGCUC+DY9QYnLij1mZBTXXhJFBvUmzptdWeldvN0sMF1GcfOVDYGJxvxQN9IJCOH/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766620; c=relaxed/simple;
	bh=ANmEUFvPCXH6mWPZ0LxVhffG7NQxZVX6X5qJMO6LBbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXG7jKzWuZkx1+jP5MEHgFH36rKQfvyGq1JLktMLta+rwbaZWQ+5dsoBsjc/IuX3OUvmM7t6Rdn94eLasUm/0zZHMBTWtLPw9MGBwXBR8opT4VvHTrzNTLdQmNeX7/c2xQ6vdpyy8Y5Pbh9L/tDHKKY8PgonlcLQ5ICvmGjUOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N5SgD/7B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HELLyNJV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N5SgD/7B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HELLyNJV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N5SgD/7B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HELLyNJV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N5SgD/7B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HELLyNJV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A88CA6A7F6;
	Tue, 21 Apr 2026 10:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776766617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhT/9IBBHYZUHLEtYrK68N6VA9yzBN7ZGJGZR+AiCX0=;
	b=N5SgD/7BHushhC4+xJKnNI7olPFIixTtR42lphRitXI7WSQa8dv2g2yE0kuTTUyvtQnJth
	Ov2OvoxlbdnxAuR5GazLTzK/0eLVkwDFYk6aLvOYZdyb8j+2WMo/VFH91PpLumEtZ0ZPP5
	9EbqvIfAeBGnQ1bgumE/gqSQiXrdQ7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776766617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhT/9IBBHYZUHLEtYrK68N6VA9yzBN7ZGJGZR+AiCX0=;
	b=HELLyNJVHqQFjMMgLU5ajkWHrdq+CY4pJHXhETS707TIlWl63POc7ddxsImYzbSP+BMhSn
	MSV0cK1ZL3NYauDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776766617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhT/9IBBHYZUHLEtYrK68N6VA9yzBN7ZGJGZR+AiCX0=;
	b=N5SgD/7BHushhC4+xJKnNI7olPFIixTtR42lphRitXI7WSQa8dv2g2yE0kuTTUyvtQnJth
	Ov2OvoxlbdnxAuR5GazLTzK/0eLVkwDFYk6aLvOYZdyb8j+2WMo/VFH91PpLumEtZ0ZPP5
	9EbqvIfAeBGnQ1bgumE/gqSQiXrdQ7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776766617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhT/9IBBHYZUHLEtYrK68N6VA9yzBN7ZGJGZR+AiCX0=;
	b=HELLyNJVHqQFjMMgLU5ajkWHrdq+CY4pJHXhETS707TIlWl63POc7ddxsImYzbSP+BMhSn
	MSV0cK1ZL3NYauDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EF2B593AF;
	Tue, 21 Apr 2026 10:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n03OJplO52ncTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Apr 2026 10:16:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 63209A0AE1; Tue, 21 Apr 2026 12:16:49 +0200 (CEST)
Date: Tue, 21 Apr 2026 12:16:49 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 20-04-26 20:14:58, Amir Goldstein wrote:
> On Mon, Apr 20, 2026 at 4:37 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 17-04-26 16:25:03, Amir Goldstein wrote:
> > > + - Handle security issues promptly.  Filesystems parse complex on-disk
> > > +   structures from potentially untrusted media and must treat security
> > > +   reports with urgency.
> >
> > I've commented on this in reply to Matthew. I agree syzbot results must be
> > reviewed and identified security issues treated in a timely manner. However
> > dealing with maliciously corrupted on-disk data isn't (IMO) a serious
> > attack vector. Even current well maintained filesystems (e.g. ext4 and
> > others) have some issues in this area so it seems unfair to ask this from a
> > new filesystem.
> >
> 
> This is what I posted in v2:
> 
>  - Handle security issues promptly.  Filesystems parse complex on-disk
>    structures from potentially untrusted media and must treat security
>    reports with urgency.  Expect the filesystem to be subjected to fuzzing
>    of both syscalls and filesystem images.  The filesystem must handle
>    corrupted input gracefully without hanging or crashing the kernel.
> 
> Are you saying that ext4 and others do not react to crash reports from
> image fuzzing which result in crash/hang?

We are reacting to them, but not with such an urgency this paragraph seems
to suggest :).

> Can you suggest a more relaxed clause or should I remove it altogether?

I definitely want to keep a clause like this. Maybe I'd just reformulate it
like:

  - Handle security issues promptly.  Both those reported by ordinary users
    as well as those reported by fuzzing tools. Expect that your filesystem
    will be subject to syscall fuzzing as well as filesystem image fuzzing.
    Dealing with maliciously corrupted filesystem images is not generally
    considered a high severity security issue but still it is considered a
    quality-of-implementation issue that should be fixed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
