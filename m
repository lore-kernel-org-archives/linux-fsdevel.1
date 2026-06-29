Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A93F9F22
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724650; cv=none; b=TThTK8NjzWHWYbH6o64l5RW01gr3EIVx06kzUwzn2MmWhb77p+aLlAEm22b+iJ5jX4MXWcdPXDk+PrU7JTDYb8FCj+5r7C8GO3668nOxEDSHCXPleBWIIL43gXQmV61kurMGndGChtK7ijCiaw2YuNWcH90D4dNfk9CAbx2T4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724650; c=relaxed/simple;
	bh=DFPzXMXoxmhePxu785wnA6HK6TQ1Fhg1iOosWVUDDzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH2SPNRdoDkDSEsmf9CppukhSZmOhoHwtIvsmtVNwAPe2IvBlkBjEfc7sEYCm7v0667frHSkb4ziHsVTq1vFEG50hc33tsGK7STOM52xE9WiJcwvl+rpPrQ1JpKTAI8PmZ7Hbj6S74xTJI2u7t6ivND1yzFV+bYHkePK48i2hJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIRUbWsb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UG/m+CUN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIRUbWsb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UG/m+CUN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIRUbWsb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UG/m+CUN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIRUbWsb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UG/m+CUN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 115ED75D20;
	Mon, 29 Jun 2026 09:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782724647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZeAHFDLmNkecZQngxQ3dUI9xirafN9LnHLj1HtwQhg=;
	b=GIRUbWsbKs7tt0snoOPAtRqfjTNgym9+pooVPE+VLWDca1icO+WdbMFDIUTj0sG5ZzYZ4G
	7r4NEe9Agt4NXdlla+4iT4Qx+DziEgx7k4J2ztGaZc/vLz5tJCWJ0Lax2QAl9EcOOGdgf+
	hWzxm9/CaKvoRVTE8XNQy/4mje6iS/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782724647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZeAHFDLmNkecZQngxQ3dUI9xirafN9LnHLj1HtwQhg=;
	b=UG/m+CUNYWvPbuem14pEqEL6zVHLEBC1Z1rv+usTMzY1eXJHfT97q8L3AfKa/WIt482v+b
	4qP4sczyRDLfdmCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GIRUbWsb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="UG/m+CUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782724647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZeAHFDLmNkecZQngxQ3dUI9xirafN9LnHLj1HtwQhg=;
	b=GIRUbWsbKs7tt0snoOPAtRqfjTNgym9+pooVPE+VLWDca1icO+WdbMFDIUTj0sG5ZzYZ4G
	7r4NEe9Agt4NXdlla+4iT4Qx+DziEgx7k4J2ztGaZc/vLz5tJCWJ0Lax2QAl9EcOOGdgf+
	hWzxm9/CaKvoRVTE8XNQy/4mje6iS/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782724647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZeAHFDLmNkecZQngxQ3dUI9xirafN9LnHLj1HtwQhg=;
	b=UG/m+CUNYWvPbuem14pEqEL6zVHLEBC1Z1rv+usTMzY1eXJHfT97q8L3AfKa/WIt482v+b
	4qP4sczyRDLfdmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07A6F779A8;
	Mon, 29 Jun 2026 09:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CsHRASc4QmpQUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Jun 2026 09:17:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4C0EA10B5; Mon, 29 Jun 2026 11:17:22 +0200 (CEST)
Date: Mon, 29 Jun 2026 11:17:22 +0200
From: Jan Kara <jack@suse.cz>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Jan Kara <jack@suse.cz>, Wei Yang <albinwyang@tencent.com>, 
	Zijie Wang <wangzijie1@honor.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] proc: only bump parent nlink when registering
 directories
Message-ID: <nmzpiovepu4fi2ls2xrgserszqy3vwyoud3u4ze7cz53wwjvp6@jmenhf5qni6e>
References: <20260613211005.921692-1-kwilczynski@kernel.org>
 <20260617-zeitig-umlagen-ortseinfahrt-1389d7457b0f@brauner>
 <20260629054007.GA2410937@rocinante>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260629054007.GA2410937@rocinante>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 115ED75D20
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,suse.cz,tencent.com,honor.com,vger.kernel.org,linux-foundation.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hello!

On Mon 29-06-26 14:42:17, Krzysztof Wilczyński wrote:
> > > proc_register() increments the parent directory's link count for every
> > > entry it registers, while remove_proc_entry() and remove_proc_subtree()
> > > decrement it only when the removed entry is a directory.  Regular files
> > > thus inflate the parent's count while they exist, and leak one link
> > > permanently on every create and remove cycle.
> > > 
> > > For example, /proc/bus/pci/00 with twenty-two device files and no
> > > subdirectories reports nlink 24 instead of 2, and SR-IOV VF enable
> > > and disable cycles, each creating and removing the VF config space
> > > entries under /proc/bus/pci/<bus>, inflate the link count of that
> > > directory without bound.
> > > 
> > > [...]
> > 
> > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > Patches in the vfs.fixes branch should appear in linux-next soon.
> [...] 
> > [1/1] proc: only bump parent nlink when registering directories
> >       https://git.kernel.org/vfs/vfs/c/552864f6ac8f
> 
> I assume this got lost?  Seems its missing from 7.2-rc1, sadly.

I don't think it got lost. I'd expect Christian to send the fix for 7.2-rc2
(he merged it to his tree only during a merge window). I've checked his
tree to verify but apparently Christian didn't push out vfs.fixes or
vfs.all branch for a couple of weeks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
