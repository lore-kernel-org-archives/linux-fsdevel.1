Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB9339847
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939977; cv=none; b=cL6FuHOP0KU+uXiwGsnd6ekNxl4XcApv8+pxran5ocWvouJcRYphBDEY3nzQZkIa+OFQVQ72qO+ZaChaE1LM115dAb1DLiyVcjzjmOXpjmp1PH67ZE6/nwn3MJMa3a2hmVLOOxghNHGiTt0kQVSMwMC+KhQ0BPeST98RVJkHg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939977; c=relaxed/simple;
	bh=9j/jpRcb+Z0NNkLcRmCa0kiCGRu8SfqTZPmK7urOy2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/hWCs5pbCC2UFagD0iUGcM9l5Hz782DGDkIOLAuE/uU2HCmfkORI3OthkMpva6KBRIaOyLa3H2c/5agPoUJf/ye5V5iEUPRLngYBdl4ldfST0kmi5/YwVnZmRxG9af1Ok+NuH4K69eU+7720bjMu2+pAREMAxVmQU1jIm8j/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p0P8v7DE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L9N3eH0y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p0P8v7DE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L9N3eH0y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p0P8v7DE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L9N3eH0y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p0P8v7DE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L9N3eH0y"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE69D5BCCA;
	Tue, 20 Jan 2026 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8t+GAsRP49d9mHv9MM3za84W86kcv7VYaBe5TRYUVLk=;
	b=p0P8v7DEdltjaz7R1kaXHZ0qYEMKAvke5SVrISOMjwmyj2ZmBe8E9TBdvpk0hNIT2pAGl/
	6rTgf9YoVycAeg6URAlVPdW059rxxC2Cfj4iF5LUA1Ih4wY0XSHydNMaouNd/P9LNAPkEF
	mbmH8aMIlR604FvjOAGMngFUdX9CYuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8t+GAsRP49d9mHv9MM3za84W86kcv7VYaBe5TRYUVLk=;
	b=L9N3eH0yePUmqmtvXZR26XtRG5aHiZaJTekVuKZ5/3FkHYOBz9xHk6ASAtJDE/mznqP+54
	NXgsO9jKVZwXLnCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p0P8v7DE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L9N3eH0y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768939973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8t+GAsRP49d9mHv9MM3za84W86kcv7VYaBe5TRYUVLk=;
	b=p0P8v7DEdltjaz7R1kaXHZ0qYEMKAvke5SVrISOMjwmyj2ZmBe8E9TBdvpk0hNIT2pAGl/
	6rTgf9YoVycAeg6URAlVPdW059rxxC2Cfj4iF5LUA1Ih4wY0XSHydNMaouNd/P9LNAPkEF
	mbmH8aMIlR604FvjOAGMngFUdX9CYuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768939973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8t+GAsRP49d9mHv9MM3za84W86kcv7VYaBe5TRYUVLk=;
	b=L9N3eH0yePUmqmtvXZR26XtRG5aHiZaJTekVuKZ5/3FkHYOBz9xHk6ASAtJDE/mznqP+54
	NXgsO9jKVZwXLnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68D1E3EA63;
	Tue, 20 Jan 2026 20:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJ16F8Xhb2nLMAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 20 Jan 2026 20:12:53 +0000
Date: Wed, 21 Jan 2026 07:12:50 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/4] initramfs: Refactor to use hex2bin() instead of
 custom approach
Message-ID: <20260120230030.5813bfb1.ddiss@suse.de>
In-Reply-To: <20260119204151.1447503-3-andriy.shevchenko@linux.intel.com>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
	<20260119204151.1447503-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.51
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BE69D5BCCA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon, 19 Jan 2026 21:38:39 +0100, Andy Shevchenko wrote:

> +	ret = hex2bin((u8 *)header, s + 6, sizeof(header));
> +	if (ret)
> +		error("damaged header");

The changes look reasonable to me on first glance, but I think we really
should improve the error handling to abort the state machine on
malformed header here.

One further issue that we have is simple_strntoul()'s acceptance of
"0x" prefixes for the hex strings - any initramfs which carries such
prefixes will now result in an error.
It's a pretty obscure corner case, but cpio is really easy to generate
from printf(), so maybe there are some images out there which rely on
this.

I've written an initramfs_test regression test for the "0x" prefix
handling. I'll send it to the list.

Thanks, David
