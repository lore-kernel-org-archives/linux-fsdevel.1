Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7631B130;
	Mon,  5 Oct 2026 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180202; cv=none; b=nPHxAyliY56J9eHtfYBg90PXA5KIrayAwoV+vTw4KZs9SX56AOj2tqmnfPKH8vHyFeY1dybjql1pN+2kTMT5TuVVKEoKtGLNm2WdQ1anzBhtvyDNL38AvHLiC0bFO5m4RiFlPByvtpnU1dpcGSz2wmy9bDowIy3ed6D6kASYeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180202; c=relaxed/simple;
	bh=TQCifGKDqnp9wRfiCilrXZi23ydH1JMQCQN+eRLuIIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2H4tGe5ncKeZELsDpnoFqDL7XtIT2KttGI2LFk0E7QxQdcrG9okCIYRNTh7Hf9gqFjjvLxLUZ0A3ohVoyKv/w5vzMDw/58ICKznB2AukZliVuX8fwLfzXcOnf2a+q/3+CbXP6bLWdWJyMltRNKWtRa75Int4N3fx1mQ5BzS7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ry3F95Ai; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1z1AQyNz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wasxx8NK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sKr4zx5z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ry3F95Ai";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1z1AQyNz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wasxx8NK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKr4zx5z"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5ED451F451;
	Mon,  5 Oct 2026 06:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791180188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2d1KHg0VhjUYD6CQVXxYhZfv7qR/Z8p4l2rnI8FsiQE=;
	b=Ry3F95AiRdsJlNxXlBkr6zZPFcNAkykw1SsVZUU1ZkE6r25z5t6YQPbh313uqiknGjyd+7
	L1zfGwysHLDmI/CImT+PNtdZ54O0hIPD99RDAf08gS/4aC2hJ0/4tbj3YCYIzbQM6cac8B
	DAKhV3pW7Sm/iyUGTXGWR/ttd9xNp0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791180188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2d1KHg0VhjUYD6CQVXxYhZfv7qR/Z8p4l2rnI8FsiQE=;
	b=1z1AQyNzr7vsrYr8Y1AfGEwNE2ikyn1kJJ8yfL0//HwbmlPgbSjLOakeke0NoI64qtp9Wt
	dVau8LDPm5qSdtCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791180184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2d1KHg0VhjUYD6CQVXxYhZfv7qR/Z8p4l2rnI8FsiQE=;
	b=Wasxx8NKJSUzc5AP4HUq0UqEFPLBcWsLLolrydVzc1GiOC+Y6CQDXcDwinCWOwB/Db5ssR
	cnOqiu2A+NBBNCijFzF2sICB8i28NAJc+bJLslc8UBWW5ByzXrv8dWcYQaZ+tXwmDi5+no
	3eAtirDDa9uQNPinO2bkQIinwbkAJ4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791180184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2d1KHg0VhjUYD6CQVXxYhZfv7qR/Z8p4l2rnI8FsiQE=;
	b=sKr4zx5zfOP3K4BRwqpykKq1WIh1Sz1F/Jm+hRt//Xh5aJgKy9P5gRKOJSIEnCZ9y0b3pi
	ubn9kRsc/D7XQPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2190C132D3;
	Mon,  5 Oct 2026 06:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9CCYO5c9w2qACAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Oct 2026 06:03:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36119A13FB; Mon, 05 Oct 2026 08:02:59 +0200 (CEST)
Date: Mon, 5 Oct 2026 08:02:59 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>
Subject: Re: [PATCH 16/21] fsnotify: let a filesystem refuse marks on its
 objects
Message-ID: <ktwf3k6arjrcezb2ah3fmj7q7qu235ri4yau5c6hmwithutl3l@3xk6vqisfjhj>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
 <20261002-work-mount-fixes-4-v1-16-dd44b89d44ce@kernel.org>
 <CAOQ4uxh9O4-sUpN5mT-GHriGQ26R_n++mELNh3wOPKSrMYDSRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh9O4-sUpN5mT-GHriGQ26R_n++mELNh3wOPKSrMYDSRQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 02-10-26 16:26:19, Amir Goldstein wrote:
> On Fri, Oct 2, 2026 at 3:54 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Don't let nullfs be watched. fanotify refuses mount and filesystem marks
> > on SB_NOUSER superblocks but inode marks of inotify, fanotify and
> > dnotify go through. The one inode of knullfs is the root of every
> > kernel thread and the following patches make it reachable from
> > userspace as the directory that stands in for an unmounted mount. A
> > watch placed through one such directory would report the opens through
> > all the others, across users.
> >
> > Add FS_DISALLOW_NOTIFY next to FS_DISALLOW_NOTIFY_PERM, refuse a mark on
> > any object of such a filesystem in fsnotify_add_mark_list() where every
> > backend ends up and set it for nullfs. There's nothing to watch on a
> > permanently empty and immutable filesystem.
> >
> 
> I don't particularly mind this custom opt-out, but
> shall we perhaps instead deny marks on SB_NOUSER directories?
> IIRC, we already wanted to deny marks on any SB_NOUSER, but then
> it turned out that some users set inotify watches on pipes, so we stepped
> back and restricted SB_NOUSER only for fs/mount marks.
> I think that the same logic extends well also for directories, because
> I don't think that any existing SB_NOUSER fs is supposed to be
> exposing them atm, so no regressions are to be expected.

Yes, I agree that placing marks on directories of SB_NOUSER filesystems
should be denied as well because it doesn't make sense which would settle
this case without a special flag AFAIU.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
