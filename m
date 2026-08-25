Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB450394EB7;
	Tue, 25 Aug 2026 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654403; cv=none; b=PKclF0O76csh2iBiqhLN6/AAHosZAmIRxVIQloWt4VCIqJJHcm3+Ie8UZlSbXEZPjjhu1vEWVlG+eKfgjZLeGq6D+FbEpvLDFvqI+sB3fvXyeq3z/vuRMx74IOYSKXcZCJsXNk7f+Vdre+1IE6OwutIih/hlA1ILHAcAavMbk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654403; c=relaxed/simple;
	bh=77OK7qfo528EFSrktvYwNXNtBWHxgU9rrm+kSM1NtNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju+hHoME3Qw3ib43bSUK0MUpP7A40bufiE/MTP35VXHP/UIgsPnZhAX06Z/ohGHSuSOPhOo+fHnfh/qcem7pcb20wc4SiMocHY7g6Rl+WrjIY77ue2alx1ZHu+jFrxx1SCKqXIGVp688MoXntRtODYrAdmEU2+H4oy6M2aDjPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YI3MOy1B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sc+VUg2h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fTob6Lo7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E7F/3w7p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YI3MOy1B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sc+VUg2h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fTob6Lo7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E7F/3w7p"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6580D86DC5;
	Tue, 25 Aug 2026 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787654395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=77OK7qfo528EFSrktvYwNXNtBWHxgU9rrm+kSM1NtNg=;
	b=YI3MOy1B/Dd7v6wB8/n0aTw5GzE8zx/IALElwvJ3J8gKTGMdCQ7jlnpQBp5ou31dXDNgYJ
	cYdElYFyP94/i+GAjCLRq+PStJQkOaCfq/iIky8gGS58vKVuvn56P/8wQy0aGq88YmxR1U
	8F24peBJzkDxKgmaptj0yBgiOeetNBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787654395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=77OK7qfo528EFSrktvYwNXNtBWHxgU9rrm+kSM1NtNg=;
	b=sc+VUg2hgxDSO+wHu+7Fc1YvcrsUaqHDFjFaT8+xLXdoDrbsMKYKOKwFNy3C4YhiZyCQ2l
	bUbDpFfxMeqqRJDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fTob6Lo7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="E7F/3w7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787654391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=77OK7qfo528EFSrktvYwNXNtBWHxgU9rrm+kSM1NtNg=;
	b=fTob6Lo7rXoMXfd3hVv1GM4DqHCsA8vFL2T02vB3FDCUUmANEzQeDjfBlDdcKdYgkCkTtR
	P03UHd3Au95xh0NkRsegtL6J1KJhv+vA135CgaE8gTSUapfIOg+6r5ksUgPCsN+qxPgWtC
	OGyW9JKBkFV1UHUfPUdQ0XRPVLX/NBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787654391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=77OK7qfo528EFSrktvYwNXNtBWHxgU9rrm+kSM1NtNg=;
	b=E7F/3w7pLm3hsEATXDZEQlelQozBKvIxMAVVOWPvOiq1O7FIp3cHHgtMyvyABCYfPZT5uN
	NNLI4ERtVL3QPuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F7A013332;
	Tue, 25 Aug 2026 10:39:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C5w0GvZwjWoXEQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 25 Aug 2026 10:39:50 +0000
Date: Tue, 25 Aug 2026 12:39:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>, linux-fsdevel@vger.kernel.org,
	oe-lkp@lists.linux.dev, ltp@lists.linux.it
Subject: Re: [LTP] [linus:master] [fanotify] 82c6dd2047: ltp.fanotify21.fail
Message-ID: <20260825103948.GA57544@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <202606291514.594c4370-lkp@intel.com>
 <qvbzvyoqab7c4g6jh2rezvdemqed7omco4qgvdq3elwbrlaffn@thrhz2uqtgqt>
 <akNRvmJdCKALZbo6@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akNRvmJdCKALZbo6@xsang-OptiPlex-9020>
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,intel.com,vger.kernel.org,gmail.com,lists.linux.dev,lists.linux.it];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.71
X-Spam-Level: 
X-Rspamd-Queue-Id: 6580D86DC5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Hi Jan, all,

> hi, Jan Kara,

> On Mon, Jun 29, 2026 at 11:36:25AM +0200, Jan Kara wrote:
> > On Mon 29-06-26 16:45:58, kernel test robot wrote:
> > > kernel test robot noticed "ltp.fanotify21.fail" on:

> > > commit: 82c6dd20479bb6a9625e1d63a650c3be8865e2db ("fanotify: allow reporting pidfds for reaped tasks")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

> > FWIW this is expected failure. Patch to fix fanotify21 to accept success
> > in this test was submitted to LTP.

Jan, thanks a lot for a ping, I completely forgot on the rest of the patchset,
these 4 commits merged now.

> thanks a lot for information!

Oliver, FYI 7.2 specific fix:
https://github.com/linux-test-project/ltp/commit/a851461ea951622a973980510d031bb6b24a5541

The rest are enhancements.

Kind regards,
Petr
