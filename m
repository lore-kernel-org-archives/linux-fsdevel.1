Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA07156661
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139741; cv=none; b=J8rvY5EUx9gqCRG7IyzqHpBVsw7U6R4QZZ/6cAVVF+keFaabJWEnEfrm7ttJyuUaMf+pmJsxtDsIPtz7u8JecHTIkWdUo9L3e1RMObB5OOMXab79OzrwYRbrduv0fo1AGhpZw/pbVoHjZ+Vq264MqWE4diG549E7ZOqgQUG2sQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139741; c=relaxed/simple;
	bh=4yXam7P1CatY5Jj3tEYkT/ysiGwPWCGOrp4iCw3SqtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY+KFh3Zw1LCXI2djwXwPWrG5RxZYhABy8aaj0VfBeaLIxsYgc7dWulx38aLWLNecY8/t+Qr3yS91ond3NQ2hqffm/Z6qLBWnrxzdU5JLe7UfJh/h4xUaDj3zNoxwo4dUb4+DuyzeR+UNpS9Xz4WCerCiFpu0byvyZG2jD1CULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ypnksrHm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2PxYdXlg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DBWZOFyi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+O6h8mMm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ypnksrHm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2PxYdXlg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DBWZOFyi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+O6h8mMm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AA6B6789E;
	Sat, 30 May 2026 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780139738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SvdTnOqDUuaISygzxpB5+o01Gyll44W9NCHBRGZT/Bs=;
	b=ypnksrHmRlX8wtCop1b/htUbD4cFg3sWEaXbwwqRvhc8q92TK+1EUp/0jmy5Tuy+wXOWPK
	K0ZfiW66vStWs6gGXHtmoL3on1gXKEia3CEnxCak/bKOe88S/CERe4zFTE0+MaNhb5hcGy
	tM063y5CbZZVlo3NriUYyC9yPggRtFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780139738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SvdTnOqDUuaISygzxpB5+o01Gyll44W9NCHBRGZT/Bs=;
	b=2PxYdXlgrQKwj73K19/IrGlQRm631Ji8B/JGJ7himFfEW8UasmK6rsGkrlCUgOldeXOLzl
	cLkXbbl6Rjaih3Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DBWZOFyi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+O6h8mMm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780139737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SvdTnOqDUuaISygzxpB5+o01Gyll44W9NCHBRGZT/Bs=;
	b=DBWZOFyiGKJ2NOm6+VZ9RVvkTZ7zFozsEC2EAwB6hXVX0n//6HjJGb7i4Qn8Kis4eCEV/4
	ujWulHd0RKOs49/v5PoLNKaUUmNd5EenLig8LXsZ0F/wqhpSrGmCJwJyZzFd/358+jXTIz
	mjUETKPj9R+Q2Mjpw91XZyFNeyHB+6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780139737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SvdTnOqDUuaISygzxpB5+o01Gyll44W9NCHBRGZT/Bs=;
	b=+O6h8mMmADHSqWWyoYhD0+Lhyo+RioIQf5eO+XAcg6aMF0odVMwKjyIlOO/6I+WXxkS1gX
	EnVLT5B2Rk6SBVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E28A779A7;
	Sat, 30 May 2026 11:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 73PhHdnGGmr0IwAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:15:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 22A8CA0EBD; Sat, 30 May 2026 13:15:37 +0200 (CEST)
Date: Sat, 30 May 2026 13:15:37 +0200
From: Jan Kara <jack@suse.cz>
To: Philipp Matthias Hahn <pmhahn@pmhahn.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: Proper error-handling of cdev_add() after cdev_alloc() ?
Message-ID: <f64qxrwhhfrxxcp4z7kaeudoz5x7irzu5tjhcu2qarzdhtf6e3@g4g3ytghcyoe>
References: <agLivEl8W_gjAi51@birdy.pmhahn.de>
 <ahb5O4PqQd51u8Ke@birdy.pmhahn.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahb5O4PqQd51u8Ke@birdy.pmhahn.de>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8AA6B6789E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01

Hello!

On Wed 27-05-26 16:01:31, Philipp Matthias Hahn wrote:
> > How should errors of `cdev_add()` after `cdev_alloc()` be handled?
> 
> sorry for ping-ing you directly, but so far got no answer and I would
> like to get a definitive answer on this before I spend more time on this
> to create and send patches. Thank you.

So I don't really feel like chrdev specialist but based on reading the
code:

> Am Tue, May 12, 2026 at 10:20:13AM +0200 schrieb Philipp Matthias Hahn:
> > The basic schema seems to be like this:
> > 
> > 	cdev = cdev_alloc();
> > 	if (!cdev)
> > 		return -ENOMEM;
> > 	...
> > 	ret = cdev_add(cdev, ...);
> > 	if (ret < 0) {
> > 		/* WHAT HERE ??? */
> > 		return ret;
> > 	}
> > 	...
> > 	return 0;  // success
> > 
> > I found 5 case of how errors are handled:
> > 
> > 1.  kfree(cdev);
> > 	drivers/media/v4l2-core/v4l2-dev.c:1060
> > 
> > 2.  kobject_put(&cdev->kobj);
> > 	drivers/char/xillybus/xillybus_class.c:107
> > 	fs/char_dev.c:293
> > 	drivers/s390/char/vmlogrdr.c:780
> > 	drivers/tty/tty_io.c:3171
> > 	drivers/uio/uio.c:925
> > 
> > 3.  cdev_del(cdev);
> > 	drivers/char/virtio_console.c:1435
> > 	fs/fuse/cuse.c:419
> > 	drivers/misc/mei/main.c:1318
> > 	drivers/s390/char/tape_class.c:92
> > 	drivers/s390/char/vmur.c:928
> > 	drivers/scsi/sg.c:1560
> > 	drivers/scsi/st.c:4307
> > 	drivers/staging/vme_user/vme_user.c:694
> > 
> > 4.  No error handling at all.
> > 	arch/sh/boards/mach-landisk/gio.c:145
> > 
> > 5.  panic()
> > 
> > Currently I'm unsure of what's the correct way.
> > My current understanding is, that `cdev_del()` should only be called if
> > `cdev_add()` succeeded, so those findings above should be fixed. But
> > to what?
> 
> I guess __register_chrdev() from fs/char_dev.c:293 is correct and
> 	kobject_put(&cdev->kobj);
> should be used.

This indeed looks like proper handling of the failure.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
