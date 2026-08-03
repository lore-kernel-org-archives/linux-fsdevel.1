Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB6370AEC
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751233; cv=none; b=eHf2O7DftexQ0DIFsbuwCyz/rLa3+4Rbmif/PXIXfkGPWp2+pbK/R/oNTwIKlSjx5oT8MkJAV8lCVh+Hz1p+fbPGFbGKpoa/smbEvSdUOInjY1QKDV/vmCrn4cJyiMfJ1mmVjEpXzaD/6ZGtgA0sW5pPU/gq4OVe5a16M+Ui+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751233; c=relaxed/simple;
	bh=fEbclkYfNXMwif+IrxM5EzMGQ30LNOkHSSbeyLPB7lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+uKM0ysVkvRu2s/IQhfcDlCl1T3Ohy0eldMTwyVTL1SS+fftNFYAFo7PIg2nq1GaWnM2F1eMHt2BCV4cQkl0Gxro0vJGogMs64OQKi0BeJ9mFX/Ni9rSCQmkoQKeaHSY7GJUUOhegqbX+D96ITF+58Bfd/2VE17kDH/Xbzexjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=STKRJqVS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aiX4lVn+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XdlS4GY9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n5rwGbqa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="STKRJqVS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aiX4lVn+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XdlS4GY9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n5rwGbqa"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A51E3FB3;
	Mon,  3 Aug 2026 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785751226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w/++j7fwULy9KLyqvdlM2uTskeNOOa4w6Kun3TVD5uM=;
	b=STKRJqVSFiIkOc5Xs47T/eSgJ1HrqnFyd+1gVM6dKzIUqn5I/enDkCwPK09doxvscMgzZh
	kS6FMugC/giam//aLxwZB7sGWVUeyXGUu0w4NwNPuAQxAro3rakO9FrPnc9PrPrnWUC69v
	3jfsZK5HUw7FFVqy1NNK8IzIYvPSQ7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785751226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w/++j7fwULy9KLyqvdlM2uTskeNOOa4w6Kun3TVD5uM=;
	b=aiX4lVn+YC4Yk1AjJEReREPivVfs/yCBqOMU9dIJVK46DlgP+8i39uGN9BLT2umxknbYyP
	/Otz1Rh5fSodWFAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785751222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w/++j7fwULy9KLyqvdlM2uTskeNOOa4w6Kun3TVD5uM=;
	b=XdlS4GY9DS7txLV+emN9eGTDKKv4UyfKIPHN0cPw8WUrFEAVfpbMFPxggl06l1LeISKTtv
	OQVoXUns9haH0BJgtqjF/v8qZz3wPT623p7YX/RpmiPEtwNtlMXWq+V+bqTkCYVvBN41TP
	eCWPF/ATqtJByYhKSCCoSfDvIF6U7eE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785751222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w/++j7fwULy9KLyqvdlM2uTskeNOOa4w6Kun3TVD5uM=;
	b=n5rwGbqa4Pe8LRp+xM3pUXg+u6lWh5uU0PHAuzIi4v6NSsvwB0dmV4641ml817+pHpggFn
	FHSKVG07KC0FNCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22CB2779C1;
	Mon,  3 Aug 2026 10:00:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yXd9CLZmcGp3OQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Aug 2026 10:00:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4DD6A13A4; Mon, 03 Aug 2026 12:00:21 +0200 (CEST)
Date: Mon, 3 Aug 2026 12:00:21 +0200
From: Jan Kara <jack@suse.cz>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: jack@suse.cz, willy@infradead.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as UFS filesystem maintainer
Message-ID: <2zlxynjoguy2zlrxcsrylkhuz4iit73mul66ddqzaqvodyde2i@be4rxu76tbbf>
References: <am10yuQx5a3h2pXH@casper.infradead.org>
 <20260801073059.63651-1-ali@iusegentoo.com>
 <opm7uuadw7ctvvo6uln22nb6id3pepcs4nohunq7tzeaciq3kc@kigwxsd3pcbo>
 <20260803094412.8059-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803094412.8059-1-ali@iusegentoo.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 03-08-26 09:44:10, Ali Ahmet Memis wrote:
> On Mon, Aug 03, 2026 at 10:57:14AM +0200, Jan Kara wrote:
> > I'm a bit curious: Are you using UFS driver in Linux? Or do you know of
> > anybody using it?
> 
> Yes. I run FreeBSD on a second machine that I keep as a small server, and
> its disks are UFS2. I mount those from my Linux box with the in-tree ufs
> driver to read data off them, which on Linux is read-only for UFS2. So the
> driver is not theoretical for me, it is how I reach my own data.

Cool! When real users are fixing what they are using the results are
usually better than if it is just "close a couple of syzbot bugs" :).

> More generally that is what the driver is for: reading FreeBSD, NetBSD,
> OpenBSD and Solaris disks from Linux. Anyone dual booting a BSD, migrating
> data off one, or doing recovery or forensics on a BSD or Solaris volume
> ends up here. It is a small user base but not an empty one, and it is the
> only in-tree way to do it.

Yep, I was expecting some real users still do exist but I didn't hear about
anybody for a long time :).

> That is also why the mount path bugs bother me. The images I feed it are
> real BSD volumes, sometimes left unclean after a crash, so an unusual but
> legitimate on-disk layout should not panic the kernel. The fixes I have
> been sending are all in that parse and mount path.

Sure.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
