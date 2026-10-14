Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C3A3B0585
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980729; cv=none; b=XnHfrjT05tLilp3/+nTMED6QXwVE4w8270kVhLG5HaaRMZmEWA6LvRPZZBwVw0/+/foRYahuLwRYWMc5sbnGecpp7II7+wm/X1KIRgU/dXKS7iUNIIWrOZ/NgIzF5AIjw8uUKxGBp2MFeo6lVbUqQ9m1aVBFh614J9Gzw31WfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980729; c=relaxed/simple;
	bh=dTN4VRT73vWooNZnHgBYGvyiigAg6ycM/xZWTraLgTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICV+tC3EtVxY/0nmS9i9pg616fSpFEeGLPaYKiW0kYDpXLYx7BwqrzDZPiaL0MWjlt96i7VAAGIlZB65M3l2Q6VLuxNp88JKD3NmV1A/USvw32dwNuDbSO2nXEzyUuC2qm4BeYGS0OC2z184EuXoGRjsm9FoVg/+KVU1RZe5Y3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2abxPE6d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Em6y8vNn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2abxPE6d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Em6y8vNn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2abxPE6d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Em6y8vNn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2abxPE6d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Em6y8vNn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66C6B21FB8;
	Wed, 14 Oct 2026 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791980726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XvfG2mHGEJ2GdEXoYVDz1CSqauYTqIHed0bCuudb/I=;
	b=2abxPE6dAnkblR9Zwpohs4ub+xZSUChmiiVaMQyhwKaNII21jdOtG5HwLIcimWmOXzaCWM
	W9lPX7m6MI5GTbpT8sqT6oyPQ86H+4D+b1yNav4MlX8NghYzL/n7UTCvCOuHs1ovZT9GiP
	+9IEMtk7ZClzU/2FR01r0Ivq1lVDi0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791980726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XvfG2mHGEJ2GdEXoYVDz1CSqauYTqIHed0bCuudb/I=;
	b=Em6y8vNnxV8o9WI1rkDOaol/q9wIHawlj5olcSq4XLsPmS4MQoD7I5ani6DKZrYam7PcDF
	Uw8xCzBJAbXqZxCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791980726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XvfG2mHGEJ2GdEXoYVDz1CSqauYTqIHed0bCuudb/I=;
	b=2abxPE6dAnkblR9Zwpohs4ub+xZSUChmiiVaMQyhwKaNII21jdOtG5HwLIcimWmOXzaCWM
	W9lPX7m6MI5GTbpT8sqT6oyPQ86H+4D+b1yNav4MlX8NghYzL/n7UTCvCOuHs1ovZT9GiP
	+9IEMtk7ZClzU/2FR01r0Ivq1lVDi0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791980726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XvfG2mHGEJ2GdEXoYVDz1CSqauYTqIHed0bCuudb/I=;
	b=Em6y8vNnxV8o9WI1rkDOaol/q9wIHawlj5olcSq4XLsPmS4MQoD7I5ani6DKZrYam7PcDF
	Uw8xCzBJAbXqZxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E56DE1368E;
	Wed, 14 Oct 2026 12:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JYfEGbV0z2pCdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 Oct 2026 12:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8070A140E; Wed, 14 Oct 2026 14:25:24 +0200 (CEST)
Date: Wed, 14 Oct 2026 14:25:24 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] fanotify: gate fs events checks in
 fanotify_mark() by group type
Message-ID: <qhtr7zgiqo5wjfd3mrnnezmoeeqsvtax7526mrowzaufe3uvem@ijxhtvopilul>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-8-amir73il@gmail.com>
 <ulal5iiolonkeccun5lyzkuf73odidgbkmabzupbwtawwjhhlz@tneaqqtlody6>
 <CAOQ4uxjO+Q_Z0OF4XquO7o4GVF2b3akRDrLYadtUNpZzi8nEsQ@mail.gmail.com>
 <cz26vtfw5xq3hi7lv6guec75untdqrtqx5violro7ymefxduqy@ajieh3qai7xr>
 <CAOQ4uxi93n7beP20Lt865hGotZA-=2Kvuc=rMA+H+gwbQaWOAg@mail.gmail.com>
 <u4wnn46chae6helb5yuqw2eqjxux6plmyffxilisxnuiuyhyyh@mq7rahg3g5fq>
 <CAOQ4uxi4x+K7LNS07Z9raB6u5toYUXap22UFNDnz-yw9mRC7QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi4x+K7LNS07Z9raB6u5toYUXap22UFNDnz-yw9mRC7QA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 12-10-26 11:19:59, Amir Goldstein wrote:
> > > Anyway, with no end users to nag me and summer vacation getting close
> > > it may take me some time to post v3, so if you think of any new ideas
> > > there is still time to bring them up.
> >
> > Sure :) Thanks for working on this!
> 
> I pushed the tested poc to github [1] so you can take a look when you have time.
> I will post the patches for proper review, but first I wanted to know
> if you are fine
> with the semantics I came up with.

I've glanced through the series in github and it looks good to me. I didn't
find any problem with the design. So feel free to post it :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
