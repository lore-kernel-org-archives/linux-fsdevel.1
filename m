Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ABB381B0B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305523; cv=none; b=lPkKG0IZTgVl/Ici91IEvX1FuvPj3FicAtyZPPLNSCL9YlE9gHV8DJVmrce8ncWZkNBwsEwGfrvW4KrcCfc8Yqh2BlJbsMZI4slWa/cS2VoorvtlzYSZ4MHlng7CDsZBk4BLDTMh86ldSA42nVpxMJNfrSHga4MG6/SgZpO1ji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305523; c=relaxed/simple;
	bh=BZ0H9IGCaC6IUwtUQMrNzJHUq1wZXpbWhJx7lzA2LbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLn+hlh1ndeUrTlqiaZpXQ+qlSX1KxX/U0S/An6/l14gO7l0yjNtGwteOOkpelOFCQQnveBtslVCQR2GscTPMScZt1i2yzixcDbiSyZp/G0Kb1UR94pfK1lg7QqccvWilQ7pPSwXYXA9q/qqsqg4AZQmer4cL31IarLzvi7Cqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oQQY70rV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tur0zfpR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oQQY70rV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tur0zfpR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oQQY70rV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tur0zfpR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oQQY70rV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tur0zfpR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0BA34D364;
	Mon, 23 Mar 2026 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774305520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpmZ4Jy81lqBH0FGz5qygnkBImc0GRAY+WEnWzEnaK0=;
	b=oQQY70rVoacKIVV7lLcSZ3UiG6g28dp3iD6g79gwhyaWSbtyz/DwpegNcckjvsn67LCtk9
	yzjQ5Gn7ybl4v7Xq0t5GzERhmNYCVyGo9ZhLEtTI+MXPExppu5Ijnxdaug1/uvHsQrJrNx
	rmu1IuN5NTtOCyOdZvrcsaVmncbpALo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774305520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpmZ4Jy81lqBH0FGz5qygnkBImc0GRAY+WEnWzEnaK0=;
	b=tur0zfpRS4Tahe+isi/LOWGO9pC4KGMUTFqItcNRlT+JDFw6c51syLjJtlJGMBVO0UPPNp
	qqN9E0WG982y5wAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oQQY70rV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tur0zfpR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774305520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpmZ4Jy81lqBH0FGz5qygnkBImc0GRAY+WEnWzEnaK0=;
	b=oQQY70rVoacKIVV7lLcSZ3UiG6g28dp3iD6g79gwhyaWSbtyz/DwpegNcckjvsn67LCtk9
	yzjQ5Gn7ybl4v7Xq0t5GzERhmNYCVyGo9ZhLEtTI+MXPExppu5Ijnxdaug1/uvHsQrJrNx
	rmu1IuN5NTtOCyOdZvrcsaVmncbpALo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774305520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpmZ4Jy81lqBH0FGz5qygnkBImc0GRAY+WEnWzEnaK0=;
	b=tur0zfpRS4Tahe+isi/LOWGO9pC4KGMUTFqItcNRlT+JDFw6c51syLjJtlJGMBVO0UPPNp
	qqN9E0WG982y5wAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DBF143AF2;
	Mon, 23 Mar 2026 22:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UNQmLuzAwWmEGAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 23 Mar 2026 22:38:36 +0000
Date: Tue, 24 Mar 2026 09:38:04 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 6/6] kstrtox: Drop extern keyword in the
 simple_strtox() declarations
Message-ID: <20260324093804.356f919e.ddiss@suse.de>
In-Reply-To: <20260323150054.3587083-7-andriy.shevchenko@linux.intel.com>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
	<20260323150054.3587083-7-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C0BA34D364

On Mon, 23 Mar 2026 15:54:22 +0100, Andy Shevchenko wrote:

> There is legacy 'extern' keyword for the exported simple_strtox()
> function which are the artefact that can be removed. So drop it.
> 
> While at it, tweak the declaration to provide parameter names.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: David Disseldorp <ddiss@suse.de>
