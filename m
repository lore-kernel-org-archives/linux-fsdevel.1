Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40F386C17
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030939; cv=none; b=RT1xZUgT2DBCOWCY8582q85xQKJgPlkWSuIgRbdKInR69npYAqqIom1ev4r9hxzdqxjA4jUt1rh/x/4PgNhvxIc5irqMCSMbT1iIZZwUhTywRseJtIPQT6+wa6csLdWc6zJ2ykW/NG8I+wsg2FLTqHF4dLhizPCjLQ6XkiC2nSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030939; c=relaxed/simple;
	bh=jQg/ujmwWL1ROkcFHzJyIMJSjUEShh4HyGUAAz4sDGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WurvkPGmUcIevrXhmPUNVDglvv9aaNGXbsP42ixf/QCHXx93gyjamXlBI76LKZ7KxykcBHADAKVYZcg2XfjYBSENC7TefmGExzn/jbrA3L6joCvNi0SzjcSZsPGyqXEnY2bccFRISUnoYzPvKqrCOP31/By67N+6i0/tEgJCgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WNnPqN9A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sT+QRxRl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WNnPqN9A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sT+QRxRl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WNnPqN9A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sT+QRxRl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WNnPqN9A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sT+QRxRl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FC635BCDD;
	Wed,  1 Apr 2026 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775030936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YHPxm2V7oayOKi2lF5PKNxwPWXYDw9mRVVi8XJgRkI4=;
	b=WNnPqN9AWOEuVnI7+EeGNwTz+nIcH5c4zoYU9KAHr2+RwTxwd3txmf4flH50LWIRxkN1ZE
	R+kZY7oH1mGmeydITbNlgNWcJhlh+zSMdCKHnABtVDaMHP6cOSKbbFA9elwlIKvpQb//42
	xkYGLb1MUFmI9OkkVCpQ672CLjEEavA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775030936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YHPxm2V7oayOKi2lF5PKNxwPWXYDw9mRVVi8XJgRkI4=;
	b=sT+QRxRlitMND7I0+noBCf1fc5BhEvvu6nphdBwwXelDQT0AW1b6gPogegM/C+/PQ4Ib5q
	1hbkCa+BYApZfvBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WNnPqN9A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sT+QRxRl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775030936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YHPxm2V7oayOKi2lF5PKNxwPWXYDw9mRVVi8XJgRkI4=;
	b=WNnPqN9AWOEuVnI7+EeGNwTz+nIcH5c4zoYU9KAHr2+RwTxwd3txmf4flH50LWIRxkN1ZE
	R+kZY7oH1mGmeydITbNlgNWcJhlh+zSMdCKHnABtVDaMHP6cOSKbbFA9elwlIKvpQb//42
	xkYGLb1MUFmI9OkkVCpQ672CLjEEavA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775030936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YHPxm2V7oayOKi2lF5PKNxwPWXYDw9mRVVi8XJgRkI4=;
	b=sT+QRxRlitMND7I0+noBCf1fc5BhEvvu6nphdBwwXelDQT0AW1b6gPogegM/C+/PQ4Ib5q
	1hbkCa+BYApZfvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8541A4A0B0;
	Wed,  1 Apr 2026 08:08:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EsqAIJjSzGlJcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Apr 2026 08:08:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36769A0AFD; Wed,  1 Apr 2026 10:08:56 +0200 (CEST)
Date: Wed, 1 Apr 2026 10:08:56 +0200
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Deepanshu Kartikey <kartikey406@gmail.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
Message-ID: <e3gspf7vh2h7r5llbc7qman7tmqiyr3pd4nrzpu3cyuqtlolxy@2kobbzkgjr4d>
References: <20260320130615.1109449-1-kartikey406@gmail.com>
 <acvkAuq4_cWmegC7@infradead.org>
 <fa551c4c-7e9b-47b4-9011-92adc880ed1a@kernel.dk>
 <acvmXDBm1xOak_Uq@infradead.org>
 <26d2e8f0-8b82-4192-9edb-e31f3975bb82@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d2e8f0-8b82-4192-9edb-e31f3975bb82@kernel.dk>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,syzkaller.appspotmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[d31a3b77e5cba96b9f69];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 8FC635BCDD
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Tue 31-03-26 09:24:29, Jens Axboe wrote:
> On 3/31/26 9:21 AM, Christoph Hellwig wrote:
> > On Tue, Mar 31, 2026 at 09:15:07AM -0600, Jens Axboe wrote:
> >> On 3/31/26 9:10 AM, Christoph Hellwig wrote:
> >>> On Fri, Mar 20, 2026 at 06:36:15PM +0530, Deepanshu Kartikey wrote:
> >>>> Fix this by checking if the input and output files share the
> >>>> same inode before proceeding, returning -EINVAL if they do.
> >>>> This mirrors the existing check in do_splice() for the
> >>>> pipe-to-pipe case where ipipe == opipe.
> >>>
> >>> While restricting splice to be between difference inodes sounds like a
> >>> nice simplification, I'm not sure we can add it 20 years after the
> >>> syscall was added.
> >>
> >> Well if we could break splice all over with:
> >>
> >> 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> > 
> > Well, that had an easy way out by converting instances people actually
> > used to the iter ops.  Which we ended up doing for a few.
> 
> Sure, and it was the right thing to do, but you still end up with a
> broken kernel for that user. Until it gets reported, fixed, and bubbles
> back to a kernel that they can use.
> 
> IOW, no different than this one.
> 
> >> then surely this one would be OK too?
> > 
> > While this has no way out.  Not that I would complain if it worked,
> > but splicing into the same file doesn't seem like a too outlandish
> > idea.  OTOH it probably already didn't work for file systems that
> > take i_rwsem in the read path like XFS or these days the block
> > device node.
> 
> There is a way out, it's reverting it. I'd be surprised if this didn't
> trigger issues already, like the flagged one.
> 
> Thing is, I don't really see an alternative fix to this...

Hum, I'm probably missing something but I just don't see how the proposed
deadlock is supposed to happen. Block devices use filemap_splice_read() as
their .splice_read method. That does not acquire inode lock anywhere
AFAICT. Even if it did, it just reads a chunk of file into the pipe
(internal in-kernel splice pipe) and then we use .splice_write
(iter_file_splice_write() in bdev case) to write the content from the pipe
into the file. So I don't see how the locks between the read and write part
of the pipe would get intertwined...

Also if I check the console log from the syzbot reproducer (and hung task
dump) there's no sign we'd be already holding inode lock - and it would be
lockdep loudly complaining that we're trying to reacquire the same lock,
not hung task detector, if we really did acquire that lock twice. So I just
don't think the patch or the changelog makes sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
