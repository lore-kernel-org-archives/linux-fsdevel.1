Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A84C3438B0
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915796; cv=none; b=rbuRXk4jSDoza8XnNjdJU3pZaPXyYTfbA15Oh2XkwtJyrkUCF71ILfyVgiB13jkPKQlOHGVstwN0oY1u5Ujae67FoA2vfGmLJ7Bdidd24oKBSrcC3s4pJrqq2EGh6awBMg6sSKEUqN8YdBpfQ4hoPlOl8oBJZ2MqOIEZPkNvuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915796; c=relaxed/simple;
	bh=1WG5aTYqNCDJ+M6yXUUr1SzB2I8EnG3UDsFn7Gmcl8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn9p2UNOE+Yp4ok9lm4Y473L0FJW1nsWW++pPIcM3RdT/L3kH445BsWNp5h4w3UsYcNbcYxU0+jkjwrXoVOY7uPqV9agTJy12bdEYDkAdN0vg9I3SzDkY5M0KhMacRxfq9CYQ670SBwAbmQmH3zFymNR2MBRrU/1pEdZg9s/49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kDhD0Kph; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0iTfvM0k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kDhD0Kph; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0iTfvM0k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kDhD0Kph";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0iTfvM0k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kDhD0Kph";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0iTfvM0k"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58407721EB;
	Wed,  1 Jul 2026 14:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782915793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=95W0nKL1hRUxqV1DLYCYkKF9o64WWkoMvBh6p06VBkM=;
	b=kDhD0KpheC/f6fecE/el33e3lS4GXzLSQ1s9ZBXDmqeliUWes25Db+ze2Er9UGrjbwstCc
	iBHmEkNdNy8Coa9E2fIb6X9qTDcSwzKBpZJCLbR/Cu11Y8k/n8bS8Ijxui1H7S+tP27fQ5
	Gl+irvlUzVZ5P3U3WaJffeIPdOBqfMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782915793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=95W0nKL1hRUxqV1DLYCYkKF9o64WWkoMvBh6p06VBkM=;
	b=0iTfvM0kurn2XV9ZWhpyuYqnCke4yZiUGIKtPm8c8I7R3YpB0QJVXYejip7G2MIyk0EaIG
	yLiy8Zroc3MZxFDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782915793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=95W0nKL1hRUxqV1DLYCYkKF9o64WWkoMvBh6p06VBkM=;
	b=kDhD0KpheC/f6fecE/el33e3lS4GXzLSQ1s9ZBXDmqeliUWes25Db+ze2Er9UGrjbwstCc
	iBHmEkNdNy8Coa9E2fIb6X9qTDcSwzKBpZJCLbR/Cu11Y8k/n8bS8Ijxui1H7S+tP27fQ5
	Gl+irvlUzVZ5P3U3WaJffeIPdOBqfMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782915793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=95W0nKL1hRUxqV1DLYCYkKF9o64WWkoMvBh6p06VBkM=;
	b=0iTfvM0kurn2XV9ZWhpyuYqnCke4yZiUGIKtPm8c8I7R3YpB0QJVXYejip7G2MIyk0EaIG
	yLiy8Zroc3MZxFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D40779AA;
	Wed,  1 Jul 2026 14:23:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YUq0FdAiRWr8PwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 01 Jul 2026 14:23:12 +0000
Date: Wed, 1 Jul 2026 15:23:10 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Gregg Leventhal <gleventhal@janestreet.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Eric Hagberg <ehagberg@janestreet.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
 dirty page cache
Message-ID: <akUezvsxuDKR8D6z@pedro-suse>
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
 <akQIIav_zaK6RmIC@pedro-suse.lan>
 <akQO8JtTxmp89GS8@pedro-suse.lan>
 <akQekZUyoKadiGCH@pedro-suse.lan>
 <akUADHLWEetveHLp@casper.infradead.org>
 <akUKty7jsWJrdyho@pedro-suse>
 <CAFN_u7EE0ooQsH2JAnYn6EFrxnRToXAqvW_uUE0aqPDEPEmSAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFN_u7EE0ooQsH2JAnYn6EFrxnRToXAqvW_uUE0aqPDEPEmSAw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Wed, Jul 01, 2026 at 09:07:44AM -0400, Gregg Leventhal wrote:
> Thanks all, it sounds like there is nothing for me to do quite yet, correct?

Correct.

> Also Zi Yan is correct, I meant order-0 folios.
> 
> Please let me know if there is anything I can do.
> FWIW: The patch I suggested did seem to resolve the issue (based on my
> testing) and did prevent my reproducer from reproducing (whereas it
> repros ~instantly for me on a not patched kernel), but I (obviously)
> defer to you all here.

FWIW, yes, I think your patch approaches correctness, but there are subtle issues, like:

Thread 0                    | Thread 1
do_dentry_open()            | do_dentry_open()
 FMODE_WRITE                | FMODE_WRITE
  nr_thps > 0               | /* the rest of the THP truncate logic */
  write_and_wait            |
                            |  write(opened_file)
                            |  /* we now have dirtied folios */
  truncate()                |

where the effective result depends on whether the invalidate lock
is held across filemap_write_and_wait() as well. But it will always,
as far as I can see, result in weird cases where writes can simply go
missing (truncate isn't really supposed to be called without the inode
lock, I think).

Matthew raised that, fundamentally, large-folio unaware filesystems should
not see these file THPs mixed in with dirty folios. Which is sensible and
seems to result in a simpler and easier to reason about fix overall.


-- 
Pedro
