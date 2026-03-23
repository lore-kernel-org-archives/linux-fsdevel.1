Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB32BE02A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307277; cv=none; b=ohcy7P713X9N8RxOKp+9RM8PzKb0cTmGx31FtFDzzzwcqwGXWoL7esx+hsYni9TTc8OSXaCPIQUrKtDG2RAgH8IkF1j62Ob/+7lZhmwDkLfaUj3m4hDivK/JI/kW/z8Hz9a8qPYq/RuMWTFEoHADYP/N/ZzcUNoMjwqlBhsAUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307277; c=relaxed/simple;
	bh=/ttPpm56KP6VcCer6vrzJslwkooRabo2wvtfwN3QB9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuKRrH69DyiUyrwOsjDam638CXcG6/VUlkMVRxTEKmpHaMcJ6IkYUnN8ofjz7PROUpHOQkgA+GRlZcQGWdnc89lgf3LCWpe3qjRXSy/PikJmNjtKgZplQYX7ctMAD4Zc4FoEWpAM4+jG4NxBScgQBYYl2FBTXZJJzgw2P3gUg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rMrqmRpE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BSbmsqjU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rMrqmRpE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BSbmsqjU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rMrqmRpE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BSbmsqjU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rMrqmRpE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BSbmsqjU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A1F04D364;
	Mon, 23 Mar 2026 23:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774307273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqDpmHasijrQTR2umFEzKgc+Vg7a/FSm/ClkBhdq2LE=;
	b=rMrqmRpESqURhcIwtc0IObcg1PEwB4sMzptJ0mUiNt+G8NWjHekBTe4+Z89qa/XtqI6t6G
	aIHxofvfTSFbvl8VZ+3ZCuElvNt1DT/zTm6y3FD4HNHnC/ty5QTaLPjfG3+jvchypwd0Qz
	cpAlnth3Dyppv9NWw4y9syf7NNkWlTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774307273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqDpmHasijrQTR2umFEzKgc+Vg7a/FSm/ClkBhdq2LE=;
	b=BSbmsqjUTKYzasKddqoWN7RlqZTOTC/Eg60OOeFTFfNZSTb8OA/cD18Wfhld3MgnGQ3/Wm
	mfphobnFpd17bJBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rMrqmRpE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BSbmsqjU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774307273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqDpmHasijrQTR2umFEzKgc+Vg7a/FSm/ClkBhdq2LE=;
	b=rMrqmRpESqURhcIwtc0IObcg1PEwB4sMzptJ0mUiNt+G8NWjHekBTe4+Z89qa/XtqI6t6G
	aIHxofvfTSFbvl8VZ+3ZCuElvNt1DT/zTm6y3FD4HNHnC/ty5QTaLPjfG3+jvchypwd0Qz
	cpAlnth3Dyppv9NWw4y9syf7NNkWlTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774307273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqDpmHasijrQTR2umFEzKgc+Vg7a/FSm/ClkBhdq2LE=;
	b=BSbmsqjUTKYzasKddqoWN7RlqZTOTC/Eg60OOeFTFfNZSTb8OA/cD18Wfhld3MgnGQ3/Wm
	mfphobnFpd17bJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A97843B10;
	Mon, 23 Mar 2026 23:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1xPOEsXHwWmCNQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 23 Mar 2026 23:07:49 +0000
Date: Tue, 24 Mar 2026 10:07:40 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Petr Mladek
 <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/6] initramfs: test and improve cpio hex header
 validation
Message-ID: <20260324100740.72937c07.ddiss@suse.de>
In-Reply-To: <20260323150753.1937b34b80772602d634d180@linux-foundation.org>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
	<20260323150753.1937b34b80772602d634d180@linux-foundation.org>
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
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9A1F04D364
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Mon, 23 Mar 2026 15:07:53 -0700, Andrew Morton wrote:

> On Mon, 23 Mar 2026 15:54:16 +0100 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The series that introduced simple_strntoul() had passed into kernel
> > without proper review and hence reinvented a wheel that's not needed.
> > Here is the refactoring to show that. It can go via PRINTK or VFS
> > tree.
> > 
> > I have tested this on x86, but I believe the same result will be
> > on big-endian CPUs (I deduced that from how strtox() works).  
> 
> AI review asked a few questions:
> 
> 	https://sashiko.dev/#/patchset/20260323150054.3587083-1-andriy.shevchenko@linux.intel.com
> 
> The "Is it possible for kzalloc() to fail and return NULL here?" one
> should be ignored - I've asked Roman&Chris to teach the reviewbot that
> unchecked allocations in __init code are OK.

The bot should ideally also consider KUNIT=y / INITRAMFS_TEST here. The
feedback regarding misuse of the new fill_cpio() fmt parameter is
valid, but my preference was to keep the initramfs test code simple.

If there's a concern that this test code may be copied into other parts
of the kernel, then I'd prefer to go with a different approach: drop the
fill_cpio() change and just call sprintf directly within
initramfs_test_hdr_hex().

Thanks, David
