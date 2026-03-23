Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09719383C84
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305559; cv=none; b=t7R/EzCCKvHPamqnk1qQQ3ovB6MBNJTl97Etr/lzzbw3CjpTfcsu/LgbjR8R0C8DsXAAAZxeyV+To3Tn1/QnvfJksDVtqiEQA+3QgVaxDKUdCmrpEnHJat4By1E+OM3O0vr24iLPRe1MrL13Si5zZ7eCiv1ty88k2vkuThhbebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305559; c=relaxed/simple;
	bh=hBUWnd6IBFsf1JKG3HGcL8fYZREiRgEbhaMJNB7wkG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmGcRql2A5+paxLo3ZdlgGj92oqPZ+nStvvftCMRawdxdfYu4/w/Xfn3xXPHFPAnVx59QrzHsKwA4n5WRg8FTUvhgQRMkYYvs57riCJcVPMnSE2Hs3vtvtHA1ChbPyHp67Cfh528ALN1iCNQXtzFC9HarwHBMNNXIpXpy9C3WZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UGzpXXru; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sGs5ZrHH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UGzpXXru; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sGs5ZrHH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UGzpXXru";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sGs5ZrHH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UGzpXXru";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sGs5ZrHH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56A194D350;
	Mon, 23 Mar 2026 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774305547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaD5o7NK6Up5Hdp40PDkVOlczva92o+cp/rBJGdqNq8=;
	b=UGzpXXrue7Srm6xRRXBze4QqSKxWCOGYOFQiH2VZqUn2V95N0zZo53H6zIuRO6dWaaUnOQ
	NIVGZyzzu+fXAgSSaoxMnRZ1pvVVHtKIHg/s2iV4TDpD+bkoSR3Vsgo4aml1WCiiaeKQms
	n3hvMjq8aurqWZ9wnrR2jsYxoojbX+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774305547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaD5o7NK6Up5Hdp40PDkVOlczva92o+cp/rBJGdqNq8=;
	b=sGs5ZrHHuWu8K8cl7/fdWJbQtgchsguWDpy38UwJMCzrU4Nn6ESk3eULwPLh3KTrDbEJAk
	/yylOaQ4qVYGBcCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774305547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaD5o7NK6Up5Hdp40PDkVOlczva92o+cp/rBJGdqNq8=;
	b=UGzpXXrue7Srm6xRRXBze4QqSKxWCOGYOFQiH2VZqUn2V95N0zZo53H6zIuRO6dWaaUnOQ
	NIVGZyzzu+fXAgSSaoxMnRZ1pvVVHtKIHg/s2iV4TDpD+bkoSR3Vsgo4aml1WCiiaeKQms
	n3hvMjq8aurqWZ9wnrR2jsYxoojbX+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774305547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaD5o7NK6Up5Hdp40PDkVOlczva92o+cp/rBJGdqNq8=;
	b=sGs5ZrHHuWu8K8cl7/fdWJbQtgchsguWDpy38UwJMCzrU4Nn6ESk3eULwPLh3KTrDbEJAk
	/yylOaQ4qVYGBcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5029243AF3;
	Mon, 23 Mar 2026 22:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UEhnAQfBwWkiGQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 23 Mar 2026 22:39:03 +0000
Date: Tue, 24 Mar 2026 09:38:49 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/6] initramfs: Sort headers alphabetically
Message-ID: <20260324093826.5534b09c.ddiss@suse.de>
In-Reply-To: <20260323150054.3587083-4-andriy.shevchenko@linux.intel.com>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
	<20260323150054.3587083-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO

On Mon, 23 Mar 2026 15:54:19 +0100, Andy Shevchenko wrote:

> Sorting headers alphabetically helps locating duplicates, and makes it
> easier to figure out where to insert new headers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: David Disseldorp <ddiss@suse.de>
