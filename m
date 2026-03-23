Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D8381AE9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305506; cv=none; b=iiNJx/6vu3M+fbtLitWtQsZaggUav15+ipN8Nr0ELR6lCnS6YjXllKyaE2oocnt3Q9ykyJLQt5QVyFMJbimf1m3ytZQxLRGI7ACaD4t+/qIKfY12IBWRDI6V5l3p9XXJQZbstG5RhYEDvBX77hkufh5CVAjVXqG1NNUu88FiDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305506; c=relaxed/simple;
	bh=WToFKLK0XpXupBdDQz+pB9St5dlXUhJlv3BdG9DrWuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7MIv2ybrdR8tIiB+BTVprIWl8ByPQO1QG+1L26XzD99AmpGo7vMec8OjURDZTBD6CcX+Wl1U1AhiRx9Lebgq+lWCm2wESArfGykk/JjyC21jy6sx99phZZnrb/YFQczl0iTKsQKsjmRR2PXcSvCL3YEErHIfwKVCyEED2lM8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rwahkaq5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3CP8TBY0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rwahkaq5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3CP8TBY0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rwahkaq5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3CP8TBY0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rwahkaq5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3CP8TBY0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45E1C5BDB9;
	Mon, 23 Mar 2026 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774305503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfXvtpHG3bXRF5fEiaOvAg1ISU2RJHX7qXiRD+TnhuM=;
	b=Rwahkaq5f7M63oGPX9c8OggbcYQ52XrBWVa1ckypP+5DVlNbSDoR7IvxBR9zOdR+D4qd1B
	cqtEjRQEqTnei1cZ3Ox2AUuomdQQroGihju1t7q/InamRkvTElhl3gy32QpMx2/7ZcFvYz
	YhXMKooKDBS3J0LS2v/CRFw6rGlwtHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774305503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfXvtpHG3bXRF5fEiaOvAg1ISU2RJHX7qXiRD+TnhuM=;
	b=3CP8TBY0Om3uI5V05Bkh0fcQEN01pN0h4KJuUO7EYpSH8Y2AOKREVWGMRVuA3UluVD5PIE
	tqvx9FV552UhbRDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Rwahkaq5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3CP8TBY0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774305503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfXvtpHG3bXRF5fEiaOvAg1ISU2RJHX7qXiRD+TnhuM=;
	b=Rwahkaq5f7M63oGPX9c8OggbcYQ52XrBWVa1ckypP+5DVlNbSDoR7IvxBR9zOdR+D4qd1B
	cqtEjRQEqTnei1cZ3Ox2AUuomdQQroGihju1t7q/InamRkvTElhl3gy32QpMx2/7ZcFvYz
	YhXMKooKDBS3J0LS2v/CRFw6rGlwtHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774305503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfXvtpHG3bXRF5fEiaOvAg1ISU2RJHX7qXiRD+TnhuM=;
	b=3CP8TBY0Om3uI5V05Bkh0fcQEN01pN0h4KJuUO7EYpSH8Y2AOKREVWGMRVuA3UluVD5PIE
	tqvx9FV552UhbRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8420A43AF2;
	Mon, 23 Mar 2026 22:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ++FRD9vAwWlbGAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 23 Mar 2026 22:38:19 +0000
Date: Tue, 24 Mar 2026 09:38:09 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 5/6] vsprintf: Revert "add simple_strntoul"
Message-ID: <20260324093809.18e05aaa.ddiss@suse.de>
In-Reply-To: <20260323150054.3587083-6-andriy.shevchenko@linux.intel.com>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
	<20260323150054.3587083-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 45E1C5BDB9
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Mon, 23 Mar 2026 15:54:21 +0100, Andy Shevchenko wrote:

> No users anymore and none should be in the first place.
> 
> This reverts commit fcc155008a20fa31b01569e105250490750f0687.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: David Disseldorp <ddiss@suse.de>
