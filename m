Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404E359A8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166119; cv=none; b=PPvZ+Yta+CcNyJCjwbUf7KuDYleN4mmZxteLJC053J7HMbTd7iwD6wx5Yw+F9C8aAMGg/MkSPL18nBo5JSekmwfYJjqyoQ24Os1AmcYkVOHCFzkyTWBcE89RH3aECQZ3HQ+BLcphIi+AgGFSmWH0vjV5Wpa/8J8cos/cHe9RVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166119; c=relaxed/simple;
	bh=XwNiH4/+Qej7ma56CkLt0PimA+IA0ghuzQd+wQ/sIbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNJMsuonULrllrwneLfC1ryxwagtUzw4xqIxSmdMN6UBhgLSzes7jcGMj1l5AGBj7VR8i9Bo9Am4bVFIEWc5AFyHA9Ls2NbGUkSID1eBFC1q084M/e1jDkkR71ftbstK85QCLi6KJMDWOkrckclPqPpDsG1dkDkPRRgS42rkgsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqoIpEIC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YOxXBTnC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqoIpEIC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YOxXBTnC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqoIpEIC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YOxXBTnC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqoIpEIC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YOxXBTnC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AE7E5BD00;
	Tue, 14 Apr 2026 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776166116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+/UTaLm1FoNUho5Jmq3dFK22ooaSSdlHwvjKnrUI+U=;
	b=gqoIpEICqqXJOvOMnD0QC5W2HfbtqOTSmPVHHOhfw+HpaNeEOGWkFnPsmSYl8HWkds5xHF
	ph6c3Ja82mkBBrTLR82aMZBg1EsYvlQu2zKeXLkjxUHw5gWreRYIA1RDXmjBJDatOHlPm8
	+eEg2ZeB62xJyq/g2p8SF23gm3Zuj48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776166116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+/UTaLm1FoNUho5Jmq3dFK22ooaSSdlHwvjKnrUI+U=;
	b=YOxXBTnCWzKBbFe6o373lYqC/yl/+Hj+qr3vBv0ljQKTcFgP1p/i8qwU0F+OUWIsPnOxzE
	YjW/4Z4eA7OtczCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776166116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+/UTaLm1FoNUho5Jmq3dFK22ooaSSdlHwvjKnrUI+U=;
	b=gqoIpEICqqXJOvOMnD0QC5W2HfbtqOTSmPVHHOhfw+HpaNeEOGWkFnPsmSYl8HWkds5xHF
	ph6c3Ja82mkBBrTLR82aMZBg1EsYvlQu2zKeXLkjxUHw5gWreRYIA1RDXmjBJDatOHlPm8
	+eEg2ZeB62xJyq/g2p8SF23gm3Zuj48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776166116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+/UTaLm1FoNUho5Jmq3dFK22ooaSSdlHwvjKnrUI+U=;
	b=YOxXBTnCWzKBbFe6o373lYqC/yl/+Hj+qr3vBv0ljQKTcFgP1p/i8qwU0F+OUWIsPnOxzE
	YjW/4Z4eA7OtczCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C11EA4B406;
	Tue, 14 Apr 2026 11:28:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id guzNK+Mk3mnARgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 14 Apr 2026 11:28:35 +0000
Date: Tue, 14 Apr 2026 12:28:33 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Joshua Peisach <jpeisach@ubuntu.com>
Cc: Aurelien DESBRIERES <aurelien@hackers.camp>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	willy@infradead.org, djwong@kernel.org, adilger.kernel@dilger.ca, 
	pedro.falcato@gmail.com, xiang@kernel.org
Subject: Re: [PATCH v3 00/12] ftrfs: Fault-Tolerant Radiation-Robust
 Filesystem
Message-ID: <ab7zobowzvreloffpvua4orlqf6tecvczqwxvv5pdjn3wplnod@4vy7dp32elia>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
 <bxgqldv2abuadh3gweymib2co6gfor7sgpbkouznj6jliyblfq@42xw4jviodeb>
 <DHSTUKN1JCDK.2FO2HZLZLXTOT@ubuntu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHSTUKN1JCDK.2FO2HZLZLXTOT@ubuntu.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	FREEMAIL_CC(0.00)[hackers.camp,vger.kernel.org,linux-foundation.org,infradead.org,kernel.org,dilger.ca,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO

On Tue, Apr 14, 2026 at 07:05:30AM -0400, Joshua Peisach wrote:
> On Tue Apr 14, 2026 at 6:22 AM EDT, Pedro Falcato wrote:
> > On Tue, Apr 14, 2026 at 02:07:13PM +0200, Aurelien DESBRIERES wrote:
> > > 
> > > Based on: Fuchs, Langer, Trinitis - ARCS 2015, TU Munich / MOVE-II CubeSat.
> > > Full text: https://www.cfuchs.net/chris/publication-list/ARCS2015/FTRFS.pdf
> > > 
> 
> > > AI tooling disclosure (Documentation/process/coding-assistants.rst):
> > >   Assisted-by: Claude:claude-sonnet-4-6
> > >   The submitter takes full responsibility for all code, has reviewed,
> > >   tested, and debugged every patch.
> > 
> > I was going to ask if you were on the world's strongest stimulant but, yeah,
> > this also makes sense.
> > 
> > 3 versions in a day and no reply to review comments, no usecase, just vibes,
> > AI ones at that. This latest batch even got the LLM to hallucinate my old
> > email address.
> > 
> > Naturally,
> > Nacked-by: Pedro Falcato <pfalcato@suse.de>
> > 
> > Please pick this up to every patch if you get to send more slop versions.
> 
> I'm not enthusiastic about vibe coding either, so I understand why you
> wanted to NACK the series. But I feel obligated to say that you
> can't claim there is "no usecase" when in the cover letter, a paper was
> provided, and you even quoted it in the reply.

Yes, a paper is provided. However, when I asked for a usecase I really did mean:
"is anyone going to actually use this?". Which is a very non-trivial question to
answer, particularly when it comes to "space stuff" (how commonly is linux even
used for those?).

Good answers (IMHO):
- "Yes, we have a couple of planned users for this"
- "Yes, this has been maintained out-of-tree for X months/years, known to work
well for a variety of users"
- "Yes, we are using it"

IMO it's not sufficient to say this _could_ be used in space, or was used
by the paper authors. And instead of a straight up answer, there was radio
silence.

-- 
Pedro
