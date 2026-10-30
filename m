Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382543;
	b=xmAeBr5RUpRP++gIRSQjICZtUclbDeJ/J7GWPSUIBQITl90cEiz+9z6fbnRTbI195+VT
	 13yOyQG947f7fEtn1B5PdRSVNoEsxaa8zZMO4ggN5xCx3hMR0aHtsFiL0FtC4/1jgLHYx
	 jqPMssAq6trIaz/XM51his6lF0R9lWjDUxUGPKqCAIUs8hfXAKZEjkg3DRJS3lRsEekUT
	 hHeUPshMVolPbqNDHlawslfVVYcbKUv5LvvCkQ6YEItUQ5LIbMdu1s1Uyqi4FG7r86fWR
	 HB4LN/Z2Pna0iU51q18z0U077/y06OTNbZm0LuthVEC+qKrRNfWteeOejOfymU3WTjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382543;
	h=DMARC-Filter:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Rspamd-Pre-Result:X-Rspamd-Server:X-Spamd-Result:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:
	 X-Rspamd-Action;
	bh=9F8jAcX1oJfRlwvfFWWuBo3EfPi1437RsFLhsSQ56+w=;
	b=B4Go+nX1ROx3DCz4jsfPLOqs6Reil26Jd3F+SASd1bYQajDUCkAIKFkfEK67VkVqs6RU
	 Zchd5WZ84dnuPTAMux0kmdIGS5aggMmGW/9LEnGVYm95by3/0gZatLWLSGJwH4482Al0l
	 k8S9gJb6Zded9Qk0UwosSHIv4umlrTtzphhNu8VWQYeij2gm9tncyqnmlrnRcWc7wjy3h
	 WRf5PrdkleuVTi8Aob9X1m3azSJaE0o0PJ8Z9mPdIryyNQeRfPyw8/0jAfCcbCXkVtbWA
	 8HFtZgWfhEVgminjANyvGvRpDFcWVLIkduOxWYt7P7w5Q30CBhe0Rq/idCmJ1O9Vw6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B66606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 17:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B66606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10A0E223B4;
	Fri, 30 Oct 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C637813625;
	Fri, 30 Oct 2026 17:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fymgJYzY5Go7aQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 17:49:00 +0000
Date: Fri, 30 Oct 2026 18:48:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v4] inotify13: check rename cookie pairing after
 adjacent moves
Message-ID: <20261030174855.GA53338@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20261029210701.80050-1-dennylin0707@gmail.com>
 <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com>
 <20261030170603.GA31132@pevik>
 <CAOQ4uxjsf=6Do-uNEOS9R61M8jXcmExY1jnrLNY9ex=doNn3wA@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjsf=6Do-uNEOS9R61M8jXcmExY1jnrLNY9ex=doNn3wA@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 10A0E223B4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

> On Fri, Oct 30, 2026 at 6:06 PM Petr Vorel <pvorel@suse.cz> wrote:

> > > On Thu, Oct 29, 2026 at 10:07 PM Hungyu Lin <dennylin0707@gmail.com> wrote:

> > > > Queue an unpaired IN_MOVED_FROM event, followed by an IN_MOVED_FROM and
> > > > IN_MOVED_TO pair with the same source watch descriptor and name as the
> > > > first event. Watch only IN_MOVE so creation of the replacement entry
> > > > does not separate the two IN_MOVED_FROM events in the queue.

> > > > Affected kernels coalesce the second IN_MOVED_FROM into the first,
> > > > leaving the IN_MOVED_TO cookie without a matching IN_MOVED_FROM cookie.
> > > > Check that all three events are retained, the two moves have distinct
> > > > cookies, and the second IN_MOVED_FROM matches the IN_MOVED_TO cookie.
> > > > Cover both regular files and directories.

> > > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

> > > Thank you for your patience with my review

> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> > Thank you!

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > I have no problem to fix very minor issues reported by agent before merge,
> > but what bothers me there is no kernel fix for the failure.  If I'm not
> > mistaken, the fix in kernel [1] was reviewed [2] but not yet merged (I looked to
> > next tree as well).
> > There are other fixes for 63c882a05416 ("inotify: reimplement inotify using
> > fsnotify") in stable, e.g. e422777fdd474 ("fsnotify: Fix stale object mask after
> > concurrent mark updates"), but I haven't found this one.

> > Merging test helps kernel developers to test if the problem was fixed but break
> > for it for anybody who uses master for regular testing without even explaining
> > fix is WIP. But I suppose it will be processed soon because stable was in Cc,
> > right?

> > We have runtest/staging, but that's for new functionality, not for tests which
> > reproduce problem which was not fixed.

> > @Jan @Amir is there a git kernel tree for fanotify and inotify? I found only
> > VFS. If yes, please update MAINTAINERS file.


> FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE
> M:      Jan Kara <jack@suse.cz>
> R:      Amir Goldstein <amir73il@gmail.com>
> L:      linux-fsdevel@vger.kernel.org
> S:      Maintained
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
> fsnotify
> F:      fs/notify/
> F:      include/linux/fsnotify*.h

Thanks a lot for pointing this doc, I overlooked because I noticed the earlier:

FANOTIFY
M:	Jan Kara <jack@suse.cz>
R:	Amir Goldstein <amir73il@gmail.com>
R:	Matt Bobrowski <matt@bobrowski.net>
L:	linux-fsdevel@vger.kernel.org
S:	Maintained
F:	fs/notify/fanotify/
F:	include/linux/fanotify.h
F:	include/uapi/linux/fanotify.h

INOTIFY
M:	Jan Kara <jack@suse.cz>
R:	Amir Goldstein <amir73il@gmail.com>
L:	linux-fsdevel@vger.kernel.org
S:	Maintained
F:	Documentation/filesystems/inotify.rst
F:	fs/notify/inotify/
F:	include/linux/inotify.h
F:	include/uapi/linux/inotify.h

> We could probably rename/move the fanotify/inotify entries to appear as
> sub entries mimicking the VFS entries:

> FILESYSTEM NOTIFICATION (fsnotify infrastructure)
> ...
> FILESYSTEM NOTIFICATION [INOTIFY]
> ...
> FILESYSTEM NOTIFICATION [FANOTIFY]

+1

Kind regards,
Petr

> Thanks,
> Amir.
