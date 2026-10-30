Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379972;
	b=ZuJFBUFyAT32Twsd1wxhatHhPNG2BWrvouQri0tPbOxEY40qSgqVhB5Za+hIW9xK66fn
	 md4TowP8UxpVOrQ3wyP9GT0GP8JOEYoKU6GqxkFqoFHVXmDGWTgBeFQpiR1ZaSFeDt61F
	 +0ZgeV8QdG92X0ibkuh/EATklG9obThZq9C5FNBbGUT1rrYRJEUu8Wf3qu7ItyxUmLlBQ
	 gkJhmYm8/9YAXS8EnV7M4MaPKVnPrzEKWicMcrUrudYAD9O6ShdAhejCSreB8rSUX+2di
	 QQyCAv73xD9oPbDNDlHhgbjvCb4GCYvbUOKlL9w+sUCTQwhksUIVrBJNi792n1NayfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379972;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=hFRkVPchWu2LC0tp+MWL7EkYr8CAcAPAsC5mUVUYyZg=;
	b=swYeB99iRN4z9t0dOM3GpChLNYKOCxWyuXRdAw/PDtyXxWZTPT+VSJL4GrnOB95pZ5R4
	 lCZd+/+dBgkeo0xcTNk8pDXTAQm+CU34ZxRpeKtBrdqevzZFpC43acSmUY4HZfeMWiSHW
	 gtCJxwUtNlyY83LIaHIrKuhc0nFs23QSVJYn4A2AgHzPwVedHhqxNog9JFjgUn9WjVkqX
	 gTJSGd9GsxRR9gtkGFYdOOyLtwd+VFrAEBnWynUiIiQkKOq/Cdz6J6J2Dv2XWa/CzFB9r
	 7zsgaAJpKIReUDVUQ9lnktF3+s/kobbq330NGPu+Eqvns2lvF5y2dI/3oQP71A5c+yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="wfVEu1F/";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uMqEflvD;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="LNTf47L/";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0pXrQJap;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083AF606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 17:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 083AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wfVEu1F/;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uMqEflvD;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LNTf47L/;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0pXrQJap
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BD6421EE8;
	Fri, 30 Oct 2026 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793379970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFRkVPchWu2LC0tp+MWL7EkYr8CAcAPAsC5mUVUYyZg=;
	b=wfVEu1F/4Q+A+z9YUZ8gfuniR8dg1SOoY1owVSAJ6AsBuiSsLT+ce485VvP+l+oTOVwGII
	Lq19jSed3PRHe4IIlOpsoLqu3NAbt3Nhx9/ecM/CZaYAgTGnBESjzMYWz6AjUVPJy3k+5m
	somMCbn02IvccJz8yq0b526W/Bjl4/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793379970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFRkVPchWu2LC0tp+MWL7EkYr8CAcAPAsC5mUVUYyZg=;
	b=uMqEflvDiFMf1hXSwxeJ8Afk+RRC4cu5U7ySUCq5F5kCdst88Iq/u0yeGyv8wH6cQT2ea3
	ucIg0fU+bWG6QDBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793379969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFRkVPchWu2LC0tp+MWL7EkYr8CAcAPAsC5mUVUYyZg=;
	b=LNTf47L/AigGMo9WAknmSL1JK1RxkOfqDNPxCzGI2Wg/UxkXrTGBn/en2ir67gJeH8RTHw
	SZ0YHdQhMF3jxjSWIk9j9pnSENXuct3PA9Gz8Fcb6rpr4AZHFCGYFjS/K+wMaQM+0qhZcP
	7EJacowjxLxQUimYlFu4f7N6ZwKlY8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793379969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFRkVPchWu2LC0tp+MWL7EkYr8CAcAPAsC5mUVUYyZg=;
	b=0pXrQJapwKkl+QEc97GvDsSCyeSztgPm80a+2wuOPkOrkRw5bBD33a9SMtzryFRj4l83DZ
	+pgXAtMVxq7wPXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C17CC13625;
	Fri, 30 Oct 2026 17:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EFecIYDO5GrJPQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 17:06:08 +0000
Date: Fri, 30 Oct 2026 18:06:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v4] inotify13: check rename cookie pairing after
 adjacent moves
Message-ID: <20261030170603.GA31132@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20261029210701.80050-1-dennylin0707@gmail.com>
 <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com>
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
In-Reply-To: <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-16.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.cz,lists.linux.it];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto]
X-Spam-Score: -16.50

> On Thu, Oct 29, 2026 at 10:07 PM Hungyu Lin <dennylin0707@gmail.com> wrote:

> > Queue an unpaired IN_MOVED_FROM event, followed by an IN_MOVED_FROM and
> > IN_MOVED_TO pair with the same source watch descriptor and name as the
> > first event. Watch only IN_MOVE so creation of the replacement entry
> > does not separate the two IN_MOVED_FROM events in the queue.

> > Affected kernels coalesce the second IN_MOVED_FROM into the first,
> > leaving the IN_MOVED_TO cookie without a matching IN_MOVED_FROM cookie.
> > Check that all three events are retained, the two moves have distinct
> > cookies, and the second IN_MOVED_FROM matches the IN_MOVED_TO cookie.
> > Cover both regular files and directories.

> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

> Thank you for your patience with my review

> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thank you!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I have no problem to fix very minor issues reported by agent before merge,
but what bothers me there is no kernel fix for the failure.  If I'm not
mistaken, the fix in kernel [1] was reviewed [2] but not yet merged (I looked to
next tree as well).
There are other fixes for 63c882a05416 ("inotify: reimplement inotify using
fsnotify") in stable, e.g. e422777fdd474 ("fsnotify: Fix stale object mask after
concurrent mark updates"), but I haven't found this one.

Merging test helps kernel developers to test if the problem was fixed but break
for it for anybody who uses master for regular testing without even explaining
fix is WIP. But I suppose it will be processed soon because stable was in Cc,
right?

We have runtest/staging, but that's for new functionality, not for tests which
reproduce problem which was not fixed.

@Jan @Amir is there a git kernel tree for fanotify and inotify? I found only
VFS. If yes, please update MAINTAINERS file.

Kind regards,
Petr

[1] https://lore.kernel.org/lkml/20261027192027.8617-1-dennylin0707@gmail.com/
[2] https://lore.kernel.org/lkml/CAOQ4uxj3et_cyzD1iWHr3_z1dH1R3WQMCOm+kO2Q90TXjaV9pQ@mail.gmail.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git/
