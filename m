Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312F3AD532
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695844; cv=none; b=m+vfeKeGpfnRkYaq3nJoQYNDMIQ36CwOnjY4Kac2eke+mVnkD56AlhE7eIl/HwzLbfXyyzufDS6RCroZLMTz7DF/CJ47ru75NLDF+FKHvl4+BXZS7LjzzWweogQNaMwyLt0jPjzlqc/eBpvxYmIBLw2GXr+oomvLhZlCOdn51ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695844; c=relaxed/simple;
	bh=gupYLRYbgrvYTbHVLBPiX1vxcz+J1905lX+xLzG35i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6Rset8HMnn/ESCsGWMS1x5BDZMNtN2eoMgpJMB1KGekAhob1rbx77/G6thpHwJgmQ+PYbao47nnC+5FKlVh2Y79vZOUUJVFhAxK7pDfoTYvoWLBhdDhP4CaOHSeQTqha82BkazipaEXQm7qndo832EPVVbP4/9Wme/0uyVGuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g84HJu85; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XuyMJ4CQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g84HJu85; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XuyMJ4CQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g84HJu85";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XuyMJ4CQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g84HJu85";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XuyMJ4CQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D41666A7E0;
	Mon, 20 Apr 2026 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jH2jMdnRZk0O2hnJ67NlJr+2mzB/XExdXrwBWt9wjys=;
	b=g84HJu85n5wYs/0BN92CwzwIck+YlZPcv/wVm5NGQRbyVqrG/5Sew7lCi8oF4JF60dbtMg
	zXm/lXhBFz+uxHnGVzxiI+VumTBVdICfLzuXS9TkQDd/HvwuGJqFDK+gguGBUNCZ8W6Vxh
	LVbi/ObZHBW4h+djKdKYEPe5udYtJWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jH2jMdnRZk0O2hnJ67NlJr+2mzB/XExdXrwBWt9wjys=;
	b=XuyMJ4CQrr6UQXpWXy04epOFAFPVVuRARiqh9C5lLIF7XW8wt5q820/D3llh7iWS9WVivm
	P1+KbRuM2SKIz7DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g84HJu85;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XuyMJ4CQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jH2jMdnRZk0O2hnJ67NlJr+2mzB/XExdXrwBWt9wjys=;
	b=g84HJu85n5wYs/0BN92CwzwIck+YlZPcv/wVm5NGQRbyVqrG/5Sew7lCi8oF4JF60dbtMg
	zXm/lXhBFz+uxHnGVzxiI+VumTBVdICfLzuXS9TkQDd/HvwuGJqFDK+gguGBUNCZ8W6Vxh
	LVbi/ObZHBW4h+djKdKYEPe5udYtJWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jH2jMdnRZk0O2hnJ67NlJr+2mzB/XExdXrwBWt9wjys=;
	b=XuyMJ4CQrr6UQXpWXy04epOFAFPVVuRARiqh9C5lLIF7XW8wt5q820/D3llh7iWS9WVivm
	P1+KbRuM2SKIz7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B757A593B2;
	Mon, 20 Apr 2026 14:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fgpRLCE65mmocgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 14:37:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D80FEA0BA6; Mon, 20 Apr 2026 10:15:35 +0200 (CEST)
Date: Mon, 20 Apr 2026 10:15:35 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>, 
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <tk2swkmfv7ggqukhngzhkbcgkrc2r6vkimzsq2af3ra57vi6jx@ek6wqha2g4qh>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <aeP4gT5T69izWj-m@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeP4gT5T69izWj-m@casper.infradead.org>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.cz,zeniv.linux.org.uk,vger.kernel.org,mit.edu,lst.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D41666A7E0

On Sat 18-04-26 22:32:49, Matthew Wilcox wrote:
> On Fri, Apr 17, 2026 at 04:25:03PM +0200, Amir Goldstein wrote:
> > +Be testable
> > +  The filesystem must be testable in a meaningful way.  The
> > +  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
> > +  framework (also known as xfstests) is the standard testing infrastructure
> > +  for Linux filesystems and its use is highly recommended.  At a minimum,
> > +  there must be a credible and documented way to test the filesystem and
> > +  detect regressions.  When submitting, include a summary of test results
> > +  indicating which tests pass, fail, or are not applicable.
> 
> Perhaps we need a section on fuzzing?  Maybe something like this:
> 
> Fuzzing
>   Filesystems in the Linux kernel are subjected to various fuzzing
>   activities, by academic researchers, syzbot and malicious actors.
>   Your filesystem will need to be robust against not just random
>   syscalls but also fuzzed (corrupted) filesystem images (for block
>   based filesystems) and crafted hostile network messages (for network
>   filesystems).  It should react appropriately to such attacks,
>   by repairing or reporting a corrupted filesystem, but not hanging
>   executing BUG() or WARN() statements or otherwise corrupting the kernel.

Well, as much as I agree this is the goal, our current in-kernel
filesystems (even the well supported ones) aren't meeting these goals.
Dealing with maliciously corrupted media simply isn't an attack vector
filesystem developers (including me) consider particularly severe. So sure
fuzzing results must be reviewed as syzbot sometimes finds issues where
unpriviledged user on totally correct filesystem manages to corrupt it,
corrupt memory, or do other nasty things but in particular the reproducers
based on corrupted images are in "good to fix" category only.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
