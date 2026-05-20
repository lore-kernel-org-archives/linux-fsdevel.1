Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD413D8916
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274635; cv=none; b=UHHZJtMJPOYKwaAmmu7owPtuL7xLI2+9rbuF9CbV8XVqhuVaYCufuohCm5ImvtgBaqAG0dDTrQkQHgleN2Fgdw6dngj+hgOYjri1hOU3hJeFkWLN/tITp+MCElFY8o7Rle6I0JCEpfH2fQHPlDKlwNQgnveWmyifYVN5HuhAwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274635; c=relaxed/simple;
	bh=Pj6ShApgFZJx7dwdH2jmhQ9kKxTTPi9g7gNzobJU/es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o66GOte2tWZvhEyS7pWLjZLja6cZRwkbxVfLfJQ73RbW6eIHqrB241Q//sSBmyw7njsw7wRrre0bREtCxRI1yCaen1uYocX8akCdfHbQ8QxFN/lo/shaNJmb8kdZZxWTw5WUBy04MLC7BeAqjM1VCADS4N1xzYsmRbMl/+jaycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vo2KQOz5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ARz4FRXu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vo2KQOz5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ARz4FRXu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vo2KQOz5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ARz4FRXu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vo2KQOz5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ARz4FRXu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C12A5D435;
	Wed, 20 May 2026 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779274632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kYOnY1NLP3hz4vVJSnAnkeHt6oJfDo6Aot7QkXO3qo=;
	b=vo2KQOz5E63hp05SxV86zHVJbtBN7gai126dcgSzm0uOubab48kE75zP2jSfXPlMgw/rew
	LKAPcJezUJx3SfdwnJTjix3NSOG/+7gBbY2905oKTcJElpuP5LZMbkQSEUUiH2KixlJlHT
	WyRO6xDPSjncOWhOOmX/zLw7SYXYzyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779274632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kYOnY1NLP3hz4vVJSnAnkeHt6oJfDo6Aot7QkXO3qo=;
	b=ARz4FRXuC+gULBP8pWQMc3WCjYB/R1+L++d0AV6TlF6smdMwaCelQJkwDZ4Zcw4lLSs7Y+
	t6U+0/1s1tchOZBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779274632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kYOnY1NLP3hz4vVJSnAnkeHt6oJfDo6Aot7QkXO3qo=;
	b=vo2KQOz5E63hp05SxV86zHVJbtBN7gai126dcgSzm0uOubab48kE75zP2jSfXPlMgw/rew
	LKAPcJezUJx3SfdwnJTjix3NSOG/+7gBbY2905oKTcJElpuP5LZMbkQSEUUiH2KixlJlHT
	WyRO6xDPSjncOWhOOmX/zLw7SYXYzyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779274632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kYOnY1NLP3hz4vVJSnAnkeHt6oJfDo6Aot7QkXO3qo=;
	b=ARz4FRXuC+gULBP8pWQMc3WCjYB/R1+L++d0AV6TlF6smdMwaCelQJkwDZ4Zcw4lLSs7Y+
	t6U+0/1s1tchOZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC9B0593AA;
	Wed, 20 May 2026 10:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MB4xIYWTDWp0LAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 20 May 2026 10:57:09 +0000
Date: Wed, 20 May 2026 20:57:03 +1000
From: David Disseldorp <ddiss@suse.de>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] init: do_mounts: use kmalloc() for allocations of
 temporary buffers
Message-ID: <20260520205703.590947d6.ddiss@suse.de>
In-Reply-To: <20260520-init-v1-1-aaf2ebac5ad9@kernel.org>
References: <20260520-init-v1-1-aaf2ebac5ad9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Wed, 20 May 2026 11:16:51 +0300, Mike Rapoport (Microsoft) wrote:

> Several places in init/do_mounts.c allocate temporary buffers for
> filesystem names or options using __get_free_page() or alloc_page().
> 
> Usage of alloc_page() APIs is not required there and only creates
> unnecessary noise with castings or conversion from struct page to void *.
> 
> kmalloc() is a better API for these uses and it also provides better
> scalability and more debugging possibilities.
> 
> Replace use of __get_free_page() and alloc_page() with kmalloc().
> 
> While on it, add a check for -ENOMEM condition in mount_root_generic().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Looks fine...
Reviewed-by: David Disseldorp <ddiss@suse.de>
