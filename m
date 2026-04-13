Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5B397E81
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066359; cv=none; b=fufjhsAN4PE1o/2Ewf68U8sv8vgO2DLz6gD/NQ0TOgcEFYl3vy58pKDBQLb+V5LPSMEIuN9o4G6k91QTskF/WeKxKNkCQ2WKy22vujiHN4SKR0a1aoRJklo50iP8q73UiQkQm4O+1JV0F+5oFoCi4Tj3w+XKr7WYDjyMbWB6eLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066359; c=relaxed/simple;
	bh=SD5VxWWgkzh89ARrd2JLuond4t2KMqNA8Uo1gxrkops=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iecOhrcpKTO0SIAYbS+28IHyZEMPT5mYZv9CfOHxiyYDC+HRkDe/IuWGr06jhh6F/9wRzuKwk9v9VLpOp+C0FL2WGDj7SiyLMx98NFIhZlWhAYfTRn0NoTYxtrOFmRYwKJl0IoUDU+A/5fuhqbmVkFW5ILOeP5c1jovPT7Sw4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FcmbC42P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QuemtuqU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AafFgXzZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Q4A865R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FcmbC42P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QuemtuqU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AafFgXzZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Q4A865R"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD1B86A88E;
	Mon, 13 Apr 2026 07:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776066356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTJMZK9JNHrBNpULFH39psQsEEIXluaKja8inHYGWDg=;
	b=FcmbC42PtXmV/QCTrR7n9FZMc5dhwhf3bW4y0wNO4KrZKnl6AVLYpAUexJcAxPYSgiVkVZ
	FgOPYVMYt6qtYQ+wk9VAeOc0ynMpbUeVp/1JgDwbRCqhhOKVgLILfezjbrOj4khuQjI/Rr
	eVq3buWfszl+KiEiE9s3B/R2Blo/M7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776066356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTJMZK9JNHrBNpULFH39psQsEEIXluaKja8inHYGWDg=;
	b=QuemtuqUjON2NvTiai8i5mv6ew7exoZKaKqM/dEsGRq7DMWmpkae9Lc2Yn4RShdz2JCh6k
	Mtbf10X36H7xFiCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AafFgXzZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9Q4A865R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776066355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTJMZK9JNHrBNpULFH39psQsEEIXluaKja8inHYGWDg=;
	b=AafFgXzZmiBooGmUG8a+Cprt8/0H1IfXfIU7KBMYF38pvXjqZWjJAPyTh0L2JlAMGbxb7a
	4P4k8jb/QiAK23sL0jh+GP5AbXrzdJaS26iAG2he75gQZFDWttMBPbYcQVQYPHomQTMpUe
	Lz7F7fgWR0KHzq5Fj4+A+t12q9/fJy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776066355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTJMZK9JNHrBNpULFH39psQsEEIXluaKja8inHYGWDg=;
	b=9Q4A865RlSf2Oy6CcPW6jj4fkYj+ilJPE3iLP+zVrzwzsCo+CHrdTceUL/GDTcWa94REzq
	6IP6BXuWr7l3V/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2F164AD8F;
	Mon, 13 Apr 2026 07:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pbp1MzOf3GmqYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Apr 2026 07:45:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84265A0AFF; Mon, 13 Apr 2026 09:45:51 +0200 (CEST)
Date: Mon, 13 Apr 2026 09:45:51 +0200
From: Jan Kara <jack@suse.cz>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <sbypvp2rwe6m6ip5jzjser3ebyrj2233cjpflpmxzpbb5ib6do@gfb7eddxi3ul>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <adikj3y6OXgSyObW@infradead.org>
 <4q7d2bi2qjg6crznvr55yfnv2gcomfqdt5j2dgkrwp5hh3ynqo@cfgy5o53zjwr>
 <1BDB4B6F-D8B8-4FCA-8B3C-FA0672108C75@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1BDB4B6F-D8B8-4FCA-8B3C-FA0672108C75@dilger.ca>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DD1B86A88E

On Fri 10-04-26 15:14:04, Andreas Dilger wrote:
> > On Apr 10, 2026, at 14:56, Jan Kara <jack@suse.cz> wrote:
> > 
> > On Fri 10-04-26 00:19:43, Christoph Hellwig wrote:
> >> I think a patch is more useful than a discussion here, that idea has been
> >> voiced multiple times, and effecticely implemented in XFS.
> > 
> > I know but after thinking for some time I wanted to get some feedback
> > before I start coding.
> > 
> >> Trying to lift the XFS logic into the VFS and finding other consumers
> >> for it would be very helpful.
> > 
> > I hope not to get all the complexity of XFS but we'll see :)
> > 
> >>> 1) Filesystems will be required to mark inodes that have non-trivial
> >>> cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> >>> whatever :)). Usually I expect this to happen on first inode modification
> >>> or so. This will require some per-fs work but it shouldn't be that
> >>> difficult and filesystems can be adapted one-by-one as they decide to
> >>> address these warnings from reclaim.
> >> 
> >> I think otherwise we call this dirty :)
> > 
> > Yup :) I was considering for a while to use another kind of dirty flag for
> > this and then clean it from flush worker but in the end I decided against
> > it as it would be IMHO confusing.
> > 
> >>> There's also a simpler approach to this problem but with more radical
> >>> changes to behavior. For example getting rid of inode LRU completely -
> >>> inodes without dentries referencing them anymore should be rare and it
> >>> isn't very useful to cache them. So we can always drop inodes on last
> >>> iput() (as we currently do for example for unlinked inodes). But I have a
> >>> nagging feeling that somebody is depending on inode LRU somewhere - I'd
> >>> like poll the collective knowledge of what could possibly go wrong here :)
> >> 
> >> I've heard this theory multiple times, but we really need to valide that
> >> we don't need the LRU.  It also doesn't really solve the above problem,
> >> as we still would not want to perform the expensive inode inactivation
> >> work inline with the last dput.
> >> 
> >> So while this might be worth investigating, please keept it separate.
> > 
> > Ack. With the point Jeff made about NFS revalidations I agree it won't be
> > straightforward.
> 
> Can this be opt-in to flag an inode with `I_KEEP_UNREFERENCED` so that it
> is not reaped immediately when NFS does iput() on an inode (or even set
> it on iget() by NFS for that matter, in case there are multiple users?
> And a sysfs parameter that makes this optional for other filesystems
> (defaults to off)?
> 
> That way you could float a trial balloon of an LRU-less kernel, but leave
> an escape hatch/debug mechanism if this turns out to kill some workloads.
> It would take some time (a few years) to get feedback, but this and the
> negative dcache growth have also been discussed for that long without
> forward progress.  Having a runtime parameter with the intent to make it
> permanent in the future at least moves the needle.

Thanks for an interesting idea! But from VFS point of view this won't bring
much as we'll have to keep the complexity of inode LRU and the associated
inode cleanup woes anyway. It still could be interesting from MM point of
view as in most cases FS caches would be faster to reclaim on memory
pressure. Anyway this is sufficiently complex that I don't want to
complicate the "let's fix inode reclaim warnings" series with this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
