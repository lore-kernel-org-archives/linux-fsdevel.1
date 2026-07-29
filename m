Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD423AA4E7
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328815; cv=none; b=WZ5uDOw7j4bUsS9W45a29OEpP/x8GCHuUx+1GIhZKkvXA7RVlu007fD2zHP0JfrIcmejBhq+gGd96VzNKLmOOCkqHvHIVaIGd0YndYG5FF/BoD4XCV8JvVv91iO9UIgQXP5gctXw7YpaIjSU5baR9zGHmb7vtarYzOO33CDd6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328815; c=relaxed/simple;
	bh=mmyLGWwz7ixGglm3PK/MzQvKx1c0i0DOVa0jg6OxGiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKhdNb3iEmBp2A5nf7GVvzkkbrinwCqodSoZ82Emh4+gJXo22C/gvLPPm26HfovqtousNuJ3MArHE4oIdtOc8HFOhpQcUcIF0iFYp1oDRDwZCbcm3S8VRJoMUWiif+BfFrCYT6ZC9VQF7UdPb6yAMlZ3efrxqJ8mG1WjIUuzbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CS39VuwG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQqhw4gr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cdJAYFaF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jhnZBAtt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CS39VuwG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQqhw4gr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cdJAYFaF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jhnZBAtt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEBB77CAE4;
	Wed, 29 Jul 2026 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785328800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQCFbZkdkebJTE4XpBiOk+0kx0t78136/P5M44hgxIo=;
	b=CS39VuwGrs8YFT7OyT/WzywmnVzf1n4mlAr9gf0kjzbLmJsJEiUNsHU5JZ3vIUVPpVwGnP
	XU8/cEWk44RHwQPdzkHZASxKEwAS0PainwKN/Ztl+p/IUTP+kP1yU3bTmzH9WWPOkeglTD
	+cPXe4HLmJN7CsFq3tgss2wAWlBAxy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785328800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQCFbZkdkebJTE4XpBiOk+0kx0t78136/P5M44hgxIo=;
	b=iQqhw4grfRWyMNfAxHbrnBWFV8zGCGoHUpB7eQ0NC5REX4wtRNLWpFXJrAdb+O2PEtE2Y5
	FqtlVjhVJTL1J+Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785328795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQCFbZkdkebJTE4XpBiOk+0kx0t78136/P5M44hgxIo=;
	b=cdJAYFaFWjJiCQUoAdu/9I6CAk3ThRqd0LEJkn880mVPLI7E7FsPBi1fgYp9Wb36L21cne
	DH2OSokO6yEs/y5MAcIH5z0t3ZCQf80U6h+3TiTw3zjqG92ApTeHpf+09GPsrvnjqRNGOB
	jb/QF5+WPk97pO8pQxSQrXZJLXHdu5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785328795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQCFbZkdkebJTE4XpBiOk+0kx0t78136/P5M44hgxIo=;
	b=jhnZBAttgMBLE03IRFI6I3usKgqRe5uzRt/J3QZB4T551ivirePPSyyma3CtNdjfQbUkG2
	GOlNcUwO5sjGyBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D62EB779A1;
	Wed, 29 Jul 2026 12:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2KBKNJv0aWpQSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 Jul 2026 12:39:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D348A131F; Wed, 29 Jul 2026 14:39:51 +0200 (CEST)
Date: Wed, 29 Jul 2026 14:39:51 +0200
From: Jan Kara <jack@suse.cz>
To: =?utf-8?B?6raM7JiB7J6sIC8g7ZWZ7IOdIC8g7KCE6riwwrfsoJXrs7Tqs7XtlZnrtoA=?= <yjkwon0026@snu.ac.kr>
Cc: jack@suse.cz, amir73il@gmail.com, repnop@google.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] fsnotify: concurrent mark updates can publish a stale
 aggregate mask and lose events
Message-ID: <dtryuddxj63ibzfzmktla4ypj7vnxj5gia66joet3lp6zgzpot@btjuuubvckv3>
References: <CACwKKmANzQaVSLni4QkvfoL6Axd3_3mYvCrsWRazXg0QeO6y3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACwKKmANzQaVSLni4QkvfoL6Axd3_3mYvCrsWRazXg0QeO6y3w@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

Hi!

On Tue 28-07-26 14:32:33, 권영재 / 학생 / 전기·정보공학부 wrote:
> Concurrent updates to marks from different groups on the same inode can
> leave the object's cached aggregate mask missing an event bit that is
> still present in a live mark. An operation started after both mark-update
> syscalls have returned can then be filtered by fsnotify_object_watched(),
> so the matching fanotify or inotify notification is not delivered.
> 
> I forced this source interleaving with diagnostic scheduling barriers and
> reproduced persistent FAN_MODIFY and IN_MODIFY loss in 3/3 independent
> boots for each interface. A control update that caused a fresh aggregate
> scan restored delivery. I also observed the same loss-and-repair outcome
> without kernel instrumentation on an unmodified v6.12.95 kernel image in
> 3/3 independent boots, with 9 strict hits in 30,000 attempts. I have not
> identified a memory-safety issue or a security-boundary crossing; I am
> reporting this as a notification correctness bug.

Thanks for the report. To clarify is this a result of a code review
(personal or by LLM) or some real application was hitting the problem?

Also for the next time I'd like to ask you to try to keep your report a bit
more condensed (either by instructing LLM or by selecting the substantial
content from LLM output). E.g. in this case the above two paragraphs
explain substance of the problem and reproducibility, the scheme in "The
race" section shows how the problem happens and the rest is mostly just
uninteresting noise so this report could have been less than two screens
worth of text whereas now it is over 7 screens in my terminal.

Now to the problem:

> The race
> ========
> 
> Let P and E be marks from different groups on one inode. P initially
> supplies event bit X to the cached aggregate, while E does not contain X.
> 
>   P update/removal                 E update/add
>   ----------------                ---------------------------------
>   remove X from P
>   start connector recalculation
>   scan E without X
>                                   add X to E
>                                   observe old aggregate containing X
>                                   decide recalculation is redundant
>   publish the older scan without X
>   both syscalls return
> 
> The add-side decisions are not serialized with connector->lock:
> 
>   fanotify_mark_add_to_mask():
> 
>     recalc = fsnotify_calc_mask(fsn_mark) &
>              ~fsnotify_conn_mask(fsn_mark->connector);
> 
>   inotify_update_existing_watch():
> 
>     dropped = old_mask & ~new_mask;
>     do_inode = new_mask & ~READ_ONCE(inode->i_fsnotify_mask);
>     if (dropped || do_inode)
>             fsnotify_recalc_mask(...);
> 
> __fsnotify_recalc_mask() scans under connector->lock and later publishes
> the sampled union with WRITE_ONCE(). A different mark can be mutated after
> it has been sampled. Its add-side redundancy check can still observe the
> old aggregate, which the in-flight scan then overwrites.
> 
> After this ordering, E contains X but the aggregate does not. The state
> persists until another operation causes a full recalculation.

Yeah, right. So for simplicity I'd just solve this by always calling
fsnotify_recalc_mask() whenever mark->mask is changed. We *could* keep the
current behavior by providing new mark->mask to fsnotify_recalc_mask() when
adding events and then doing the check under conn->lock or even improve on
it and completely avoid scanning the whole conn->list and just add the new
mask to the current connector mask. But at this point I think it is a
premature optimization - we don't expect many notification groups to be
watching the same inode and frequently adding marks to it. So let's keep
things simple for now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
