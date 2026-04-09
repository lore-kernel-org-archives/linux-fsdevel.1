Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6F12CD8B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737813; cv=none; b=MT6t9ouLsUZXAh9OTsxumEjdoDyftwL1I3QfPmRw6FMcpKN86d0XVv8jE715AomPEERRNQ4C40n98FIWLzc2GTxDM8sOZwCsS93iKAhKLjn5mB/s+dreVQOTGd0vet1Si2HDNKcWgZv56p7et6Y8rSlFxGzyYp+t9C8S2PTaqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737813; c=relaxed/simple;
	bh=f+0yHDMsjyaBxPVkG3NgRs4DDuLlNKrf3iS74/mzmMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2OLyS/SBY8RIrGeaSlYf+1a68UW6i5ER1FrbdOWSoiq8aMj7g56m4KPDd+O9D0DPAJBVDdDYbKiSwoJN+junf/QVTywx7reQTai9sGOlCZZpKrQSwyWC31TG80UVb+yvRAyNbvyYvUypUunUxrlQ5IHKdYibu+LgcfQuVsV4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X6dZYlP6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3TK8WTTE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X6dZYlP6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3TK8WTTE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X6dZYlP6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3TK8WTTE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X6dZYlP6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3TK8WTTE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FE225BD91;
	Thu,  9 Apr 2026 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775737810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+BclCMMJkegAVjxkS8iqk3jYq/9F9dXxMWASAliJHE=;
	b=X6dZYlP6DDDRp6OregtEaw74ANiWrOsY7Bh3gbVhrJEJv+9U4OVvTHWccgNlk6CqSRSeRd
	gSNhhue2F/t2Js4OvDV73nZvn7Slyzl1yO+c81KA58+mMJsLDWLCHrrU+puQeKdtAuOzGe
	qdkbiq0Q/jXK90m19n7RAzkqtYqL4hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775737810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+BclCMMJkegAVjxkS8iqk3jYq/9F9dXxMWASAliJHE=;
	b=3TK8WTTERfRUanMAPa3HPrH8Y1KMBSnVdrAsAxfojf1Wx84+ONKCr6PmYuk6kGEOyx0vKI
	7DFZCXNtZNJqgEAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775737810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+BclCMMJkegAVjxkS8iqk3jYq/9F9dXxMWASAliJHE=;
	b=X6dZYlP6DDDRp6OregtEaw74ANiWrOsY7Bh3gbVhrJEJv+9U4OVvTHWccgNlk6CqSRSeRd
	gSNhhue2F/t2Js4OvDV73nZvn7Slyzl1yO+c81KA58+mMJsLDWLCHrrU+puQeKdtAuOzGe
	qdkbiq0Q/jXK90m19n7RAzkqtYqL4hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775737810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+BclCMMJkegAVjxkS8iqk3jYq/9F9dXxMWASAliJHE=;
	b=3TK8WTTERfRUanMAPa3HPrH8Y1KMBSnVdrAsAxfojf1Wx84+ONKCr6PmYuk6kGEOyx0vKI
	7DFZCXNtZNJqgEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 744334A0B3;
	Thu,  9 Apr 2026 12:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kWMCGdGb12myBwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 09 Apr 2026 12:30:09 +0000
Date: Thu, 9 Apr 2026 13:30:07 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Denis M. Karpov" <komlomal@gmail.com>
Cc: harry@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, ljs@kernel.org, vbabka@kernel.org, jannh@google.com, 
	peterx@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	usama.arif@linux.dev
Subject: Re: [PATCH v2] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <d4xigmgectqbv5q5dxsrlunea3ynexa4ym4nuxy2rokrawsqu6@yfhzm3hl5nya>
References: <20260409103345.15044-1-komlomal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409103345.15044-1-komlomal@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu, Apr 09, 2026 at 01:33:45PM +0300, Denis M. Karpov wrote:
> The current implementation of validate_range() in fs/userfaultfd.c
> performs a hard check against mmap_min_addr. This is redundant because
> UFFDIO_REGISTER operates on memory ranges that must already be backed
> by a VMA.
> 
> Enforcing mmap_min_addr or capability checks again in userfaultfd is
> unnecessary and prevents applications like binary compilers from
> using UFFD for valid memory regions mapped by application.
> 
> Remove the redundant check for mmap_min_addr.
> 
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Denis M. Karpov <komlomal@gmail.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

This looks relatively safe. However, I'm not sure if we want this in stable.
This has been broken for 11 years now, with no complaints.

-- 
Pedro
