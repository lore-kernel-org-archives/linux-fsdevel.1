Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14E2D63E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214028; cv=none; b=Yq6gjlA8CpPB9vsh6El9iCGz77Uij+5JDER0JEQ7GziumGnfob+Q/dG/h2wtAJUVF11A+Qp4hEf1n2X3OCpF0ZfaPVuU4yec8l3dfHNwyeSvr5iBt55uguECWMeCmHI6vdD8v5OUR2MiQeFNEQk1pzo9oG/lYH4wPT3fvLEg4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214028; c=relaxed/simple;
	bh=LL2t84tRVy/yMwSbGOm3TB6WxI1RFR5gMht0+VI28HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlQT4TVvEXBmHfhd76O7HbN3hVZ+uI4YKoUVC0oQ65NVyQ8QqIzgbVUIItPQ6Ky/AEhcMWUY0c7aJI3lNEDD6vXHUEU15E6cbVw8KWAru9lS36V8ngLksXPQY4G3MiA+ZGfFinsWDf5PlJs+cOaydDFUt3C7606JnBgYHJ1aR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kpR6qZeJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QbuJu5cW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vlV+wa1i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UgL2TXKp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kpR6qZeJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QbuJu5cW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vlV+wa1i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UgL2TXKp"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18348789D9;
	Thu, 16 Jul 2026 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784214025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjvkGKuPJ296l1J1J3uCsSQ+DmnJfmCxvobbSXSn3RY=;
	b=kpR6qZeJnTWfFR5xq3HuUcnvmhUFB1z+KxOAtkBDXoEO0GGnKalTLFvidY1LuGitqQGyr8
	15wJnYrknaYuwCWtSEcBF4fWJ65LDm1OFZjDX2AWGTkchqLd1K8ufpJAi+/z/9JbAYLDG9
	ctrr46By/iIwLvlmjj2Gc+z9crLP6w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784214025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjvkGKuPJ296l1J1J3uCsSQ+DmnJfmCxvobbSXSn3RY=;
	b=QbuJu5cWpxZqmSZN9YbystvcbDUxBh1PYRIldVg7ngHVdNIntESifKTkuw/kmLVMREzler
	X+GL1KTiPJx//8Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784214023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjvkGKuPJ296l1J1J3uCsSQ+DmnJfmCxvobbSXSn3RY=;
	b=vlV+wa1ivQoGPbk3AQTEA5ZDf+ThRTh06m6oW6BEVZwIkYDM6cueF1j2E9b4/9DnZBA8lV
	Xzn4Jias30EC9wkHbqS+i+6MtAQ0MPNi8FKEFENUMaULMO9HyK8QeGXdHMZKW+vES3d0xd
	lWmP6QbNb3gkw0/dnq1icPyROfoz2pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784214023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjvkGKuPJ296l1J1J3uCsSQ+DmnJfmCxvobbSXSn3RY=;
	b=UgL2TXKpq11ef3h1QHS7CS1zGkZ+Na/xDv1HfH0FgTBs6fyyonHEItDRJXI9CNoFKD07Na
	wjNy+ibhS74MTXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08C82779AD;
	Thu, 16 Jul 2026 15:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EaL0OQXyWGrzYQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 16 Jul 2026 15:00:21 +0000
Date: Thu, 16 Jul 2026 16:00:20 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/mseal: remove superfluous comments, fix confusion
 around mm
Message-ID: <aljudrDILCC5KDso@pedro-suse.lan>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-1-3a9609bf041b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-mseal-fixups-v1-1-3a9609bf041b@kernel.org>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -4.30

On Thu, Jul 16, 2026 at 02:43:09PM +0100, Lorenzo Stoakes (ARM) wrote:
> Remove comment blocks that don't add value and eliminate any confusion
> about whether or not we permit mseal()'ing of remote mm's by explicitly
> referencing current->mm consistently.
> 
> Also avoid ugly goto by using an else branch.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro
