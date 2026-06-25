Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C2328B7B
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393921; cv=none; b=c7yHBNfStLzgkvpSeg/pbXMJjr9xsuEHcyXqNU5TtXwDjYumZyOeVAGdQog2E/0J3d+XZ/G8XzwbWA56NtoNuu90kAWmSf2kVjc9TOqCkNs+ODPPVbbr86vYzp0xW4oAZvIuHowakxdCHgbYaxJztUmqS9uYyTNIZw9PjBMsXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393921; c=relaxed/simple;
	bh=+KGFYuTHXr52pDUj9naqEwscSnD4hhsZ4+B+7TrOsIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie/BYwMu/LCIX7rV/0NtzP1LJdgcYqmfjpZhaSPdguKU1P40GMkQnkcemjqGSq8cAI8oxFQQ/oDvolIffocuXs36WrU2N2ePU9B9e6IXMUpVPF+6qyeGTZ09xH6WQe/cbfE7zvuiv8EM8tnz1WxNeHJzyrnyeD09qhRbhLEfbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hoA5E8f+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IkGiSPVG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hoA5E8f+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IkGiSPVG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hoA5E8f+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IkGiSPVG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hoA5E8f+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IkGiSPVG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA81471B9E;
	Thu, 25 Jun 2026 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782393918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bv8hdKU0kVTGNugZ+EqK3cP027aZGj25L9MrEJZohaM=;
	b=hoA5E8f+HkuH18VAn7jk2fe6Q6pNpcyzs4SKftsh84JL3Ut8qr2025OMYNTKcRe98H35XW
	jKJTCA0Lh3JYEa03de0pzcm6/IWoSrD9RDujPzO26yMVN0gNIoZtibcfoDBEKEY+7FCX1m
	AliIqVnypQoYYnvK0+iUJoJLOxPLPlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782393918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bv8hdKU0kVTGNugZ+EqK3cP027aZGj25L9MrEJZohaM=;
	b=IkGiSPVG86EyPoygvQZkq15btxTeFawc/1P65MS3sgrjuV0D7t0hVow/QNyMetmBsvcYNO
	cdX/YGaM7GaXxqBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782393918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bv8hdKU0kVTGNugZ+EqK3cP027aZGj25L9MrEJZohaM=;
	b=hoA5E8f+HkuH18VAn7jk2fe6Q6pNpcyzs4SKftsh84JL3Ut8qr2025OMYNTKcRe98H35XW
	jKJTCA0Lh3JYEa03de0pzcm6/IWoSrD9RDujPzO26yMVN0gNIoZtibcfoDBEKEY+7FCX1m
	AliIqVnypQoYYnvK0+iUJoJLOxPLPlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782393918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bv8hdKU0kVTGNugZ+EqK3cP027aZGj25L9MrEJZohaM=;
	b=IkGiSPVG86EyPoygvQZkq15btxTeFawc/1P65MS3sgrjuV0D7t0hVow/QNyMetmBsvcYNO
	cdX/YGaM7GaXxqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 470AA779A8;
	Thu, 25 Jun 2026 13:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E+1vDT4sPWroVwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 25 Jun 2026 13:25:18 +0000
Date: Thu, 25 Jun 2026 14:25:16 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] fanotify for flock release
Message-ID: <aj0qCBgIwSkCrfPj@pedro-suse.lan>
References: <716044027.2969861.1782392539951@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <716044027.2969861.1782392539951@kpc.webmail.kpnmail.nl>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Thu, Jun 25, 2026 at 03:02:19PM +0200, Jori Koolstra wrote:
> Hi Jan and Amir, (cc Christian)
> 
> There has been a wish from systemd to be able to be notified on flock(2) releases.[1]
> I've been looking at the locks.c code (I really wish requests were decoupled
> from locks... :) ) and the fanotify code, and this seems to be a rather
> straightforward expansion of existing fanotify functionality. Before sending a
> patch up, are there any objections to this? If we implement this should we
> also do POSIX locks notifications? And what about lock taking?

Random comment: any sort of feature like this probably has to interact
really weirdly with remote filesystems that do non-trivial things for
their flocking. Like NFS, ceph, 9pfs, etc.

I'm definitely not saying that this is a blocker for the functionality, but
it is worth keeping in mind that any sort of expectation from userspace will
be met with inconsistency across filesystems.

There's also another gotcha when it comes to block devices I think. systemd
wants to be notified of block device locking, but block devices also have
their own innate way of locking other users out (by O_EXCL). I don't know
if this is worth considering for systemd and other potential users of this.

-- 
Pedro
