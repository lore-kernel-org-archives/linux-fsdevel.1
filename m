Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59130E0EE;
	Thu, 24 Sep 2026 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262243; cv=none; b=GSFi+EEnGSjZQZZtoeycnT4NNEugbcuVXO8SJa6R+gmGYGLlfot2CQQTGf7GJt8U9m16G15+NfSe1r/m53vFoo4KV8+Apsb+kjFQXedn1QV1kspCFsotPySmtY5g6U+0iGTGBm72pzhiR5tNIeBS4bgbUJgUR1VnpwaTSNA/42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262243; c=relaxed/simple;
	bh=WmyQ/b+AVFTPd1WqcNsheZvWvlvM6kFEgBDJJ1uO9/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llNR05xfNB/kLg7hmzSNqWeAaVmCqE4Is+q+n8o/36f5+vZ5rbV9da6zMAynh0HnrDTJioZUW5z45/pbM1CYJWDprSIped1TKX3sQOv0s1Y8C2dK8+Fpv8Zzfg+N6T3fiwmapZm+DzSok2qyJGmBnkeQcXW3IMKaZlAGp4jHhCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hdZ6p579; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGGQrhdA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JY4hJr0w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PN9EcLto; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hdZ6p579";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGGQrhdA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JY4hJr0w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PN9EcLto"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCEBB21EB3;
	Thu, 24 Sep 2026 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790262234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8ajNCRnEhCGpEQykd0NxDczeBMsq8IF8+aOw3IKpQs=;
	b=hdZ6p579pzuRhvknZG3X/6kejEi6XPsuyYIfvGavXLZ7E0isvSA218uTbjChW/EXwasMf4
	DB55tar9J9KklsaX8ZvuUCLcbsuLMTs4dwMbOTaUKT4J45/TE00NW3PTAw0dIlk1LsneQW
	C8Voj4EV5cA6jQYIpcPMeWuz9Pm0SFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790262234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8ajNCRnEhCGpEQykd0NxDczeBMsq8IF8+aOw3IKpQs=;
	b=bGGQrhdAuh9syEvndaO1ekzNb/58Umc5I+EfyCnxKfPWm1Zm9dnESUz6T8/7949XeSgNW7
	1y3OhF+nmEj+CfCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790262230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8ajNCRnEhCGpEQykd0NxDczeBMsq8IF8+aOw3IKpQs=;
	b=JY4hJr0wBCndSS0dw6IiOShyfoJM7dnvUDGhiNmXd4myZ8wkf33byzLOMwX3XTZMuu7k3D
	/m540duq4oICECJ/PTQO+NKhYrC3PFf0OCZYLl+OfdT8mgqNY6WmY7PElNp/Y3Egw9rcOH
	+7CITC2J+dQICq4fj+hfAxTZWsNEHUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790262230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8ajNCRnEhCGpEQykd0NxDczeBMsq8IF8+aOw3IKpQs=;
	b=PN9EcLtoCnh/yCAHs+7YA0oZzorLQfNbpjRwtvEh8smOryYF0lGRg6H0sepfsTTxL2trOt
	vw5Db+5OUgpOX9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93DBA136E6;
	Thu, 24 Sep 2026 15:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2avsG9Y7tWqRFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Sep 2026 15:03:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2807CA132E; Thu, 24 Sep 2026 17:03:50 +0200 (CEST)
Date: Thu, 24 Sep 2026 17:03:50 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Hui Peng <benquike@gmail.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: reject short directory records in
 isofs_read_level3_size()
Message-ID: <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf>
References: <20260919222553.3792320-1-benquike@gmail.com>
 <20260923175215.1577791-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923175215.1577791-1-matthias.goergens@gmail.com>
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,zeniv.linux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

Hi!

On Thu 24-09-26 01:52:15, Matthias Goergens wrote:
> I'm sorry, I missed your patch when I sent mine for the same function a
> few days later ("[PATCH v2] isofs: validate directory records in
> isofs_read_level3_size()"), and Jan has since applied mine to his tree.
> 
> I did test yours, on mainline and on Jan's for_next, running fs/isofs in
> a userspace harness with ASan and UBSan: it fixes the three fuzzer
> images that made isofs_read_level3_size() read past a record, and I
> found no change on valid multi-extent images.

For record I think your fix was better because it used proper entry
validation helper which catches more problems.

> The part of yours that mine doesn't have is the limit on how many empty
> blocks the walk skips.  Without it, a run of zero blocks is walked until
> the end of the device.  On top of for_next that would be a small
> follow-up, and if you'd like to send it I'm happy to test and review it.
> If you'd rather I send it, I'll credit you with Suggested-by, or with
> Co-developed-by followed by your Signed-off-by if you prefer.

Based on the standard empty directory blocks are not allowed (there must be
at least one directory record in each directory block). So I'd perhaps just
add checks to refuse them. Then the limit on the number of sections of inode
description already present in isofs_read_level3_size() will naturally take
care of the rest.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
