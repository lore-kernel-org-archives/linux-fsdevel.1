Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5CD2DC77F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566640; cv=none; b=fyxlqdNmNHo/XLXjgCpOduo1GZUF7fzykJLHUKkI8q87GbQBLCO7t+zfD0sZm8+1IzPAVqDtyHQBcIF75p3W2sUd+pQuyMyghbZNSl6i6g7bGvPGHbr3S7VfQOx7T1fj6QzIogNjPSmUW9zi1BIeEXxSi5d0wCttW5CXakZWfRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566640; c=relaxed/simple;
	bh=JrMxN6czQPoGOONKgY18HJvolnNtQnmQ8Y1VPx+CX+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mE5eyF/6AccKx0dCAh7HfygFPmRH+bB7YnQYGa+BjyDrX/5l/heEvOiMpfMOWN0vT51ZGM3WXDaQcLl4HRuae81TblKgoaNNGFy+ymvxqSboom7i43O8L8SceT6aTmPYT6Cd2mqkZX+yH+IynJXBfwsSP9iO/0m6tE5GJo9Kcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DWJ0EIUI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KvfItLkc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DWJ0EIUI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KvfItLkc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DWJ0EIUI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KvfItLkc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DWJ0EIUI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KvfItLkc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5F285BD4F;
	Thu, 26 Mar 2026 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774566637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUfMj6YlzPd4Sd90tbR4ROfWvttUmoMVeBoBFZiv/uY=;
	b=DWJ0EIUITK+MmoIPfsCV6QZ/z8VthBPsTwFsJVycgGvyRgW1VGG2Y6Ekc8gInm7Qoi/iIw
	dWhDvyiYBUyouukwI+uqsxZRUdem7xqIOdbiuOHhvmaabcRweC2o2q8fNeU2iuL47hw/hQ
	tz+UeQX5ulRhEpDoyL1nZF8IlVRpnKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774566637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUfMj6YlzPd4Sd90tbR4ROfWvttUmoMVeBoBFZiv/uY=;
	b=KvfItLkco5Uar8i6eIP1aEQBcWirlx//NwHPkcjTQI7UsoangUOUag4IBNVI9fK7QYwSM9
	R7nmhT7HE9nVARBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774566637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUfMj6YlzPd4Sd90tbR4ROfWvttUmoMVeBoBFZiv/uY=;
	b=DWJ0EIUITK+MmoIPfsCV6QZ/z8VthBPsTwFsJVycgGvyRgW1VGG2Y6Ekc8gInm7Qoi/iIw
	dWhDvyiYBUyouukwI+uqsxZRUdem7xqIOdbiuOHhvmaabcRweC2o2q8fNeU2iuL47hw/hQ
	tz+UeQX5ulRhEpDoyL1nZF8IlVRpnKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774566637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUfMj6YlzPd4Sd90tbR4ROfWvttUmoMVeBoBFZiv/uY=;
	b=KvfItLkco5Uar8i6eIP1aEQBcWirlx//NwHPkcjTQI7UsoangUOUag4IBNVI9fK7QYwSM9
	R7nmhT7HE9nVARBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 362454A0A3;
	Thu, 26 Mar 2026 23:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pzHFN+m8xWmfOQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 26 Mar 2026 23:10:33 +0000
Date: Fri, 27 Mar 2026 10:10:27 +1100
From: David Disseldorp <ddiss@suse.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/6] initramfs_test: add fill_cpio() format parameter
Message-ID: <20260327101027.77453666.ddiss@suse.de>
In-Reply-To: <acVdb6wb5GuEpb3x@pathway.suse.cz>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
	<20260323150054.3587083-2-andriy.shevchenko@linux.intel.com>
	<acVdb6wb5GuEpb3x@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Thanks for the feedback Petr...

On Thu, 26 Mar 2026 17:23:11 +0100, Petr Mladek wrote:

> The compiler is not longer able to check whether the number/type of
> parameters match the given printf format. It was poitned out by
> Sashiko.dev AI and I agree that it makes it harder to maintain.
> 
> A solution might be to split this sprintf out into a macro.
> Or add some "bool inject_ox" parameter and keep the format
> hardcoded here.

The "bool inject_ox" option would keep the test code relatively simple.
I'll do that and send a v4.
