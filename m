Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BF30E83A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870299; cv=none; b=fNN46LEi17qSR7EirX0nAB1bpKWFwuCW7AU3bnYf1akXwa4DgnimHiL3emRIFNmfSZOZg9ANSkjWux2hnfFrazgumKOCVv9zS63EvAbXFymtwRTtexDC2FBPKJSgLhAjuVuCnosEkF6TkrbRYrTYt6plrKEmscOIXNe4ijjYMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870299; c=relaxed/simple;
	bh=GUZGQ45uSXTii8NRAsESlabO5IzaXYYl0sJBervxAUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBWgUE3WOLpz6PyFqjahvGZ9tBOgkuQFzM+MwvY8cuMSHv2PtZkaLqT5Amf2SNr8BhD0Jiumxv9uJ3VlnbS0IEiDZ9z7+JYle8okTEZ19URH63Y3FjdIdTh99+OUqb4mFaXeorpNBXjIcbxG4rUZJK+QqJZtisgXbDqqKxzKj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DLtBP8By; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NTl1shBe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pj6f8LZ/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=twyVSMtz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DLtBP8By";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NTl1shBe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pj6f8LZ/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="twyVSMtz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C4466A96F;
	Wed, 22 Apr 2026 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776870296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyGBy+XHbUwdbd8kUzk17cm00YRfKXB+fVANEn5LEFs=;
	b=DLtBP8ByN9PU1MauQ5MSpYcsj/cxKZHdI62njBxmO0frKVP6Z4a9C5dKmTRUYg0oIrwFDA
	B3/sXTp7WSUvIgDUbS0IDvEfmoMfof/a7p8XB/KHomFhABjzuJvs4RaZMDMstXuJ02iyDS
	rQK6EwiHoXQg0K+bDUigOVVC1EU/DgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776870296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyGBy+XHbUwdbd8kUzk17cm00YRfKXB+fVANEn5LEFs=;
	b=NTl1shBeEfl5mC95GG+0577GOMyQOZkwPUtdf8NoP4DTt3wbnNiKbvyiHOGe+GiBhOt7PO
	uQKXaxOTfvkQMTAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776870295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyGBy+XHbUwdbd8kUzk17cm00YRfKXB+fVANEn5LEFs=;
	b=pj6f8LZ/r+cfw+/pBidXECgQ6Tdxc/orE+7yxcbYcIYh8PrRc0Wxt04MTE6ywsJFfPtLUm
	/AQEe9XsziKRILUov8ewA9YM0xzxPZ2FFxqtRnpu+W4N0SAyf3Rly/V3Q7isdDIFBZxCku
	P6VU4hx+mk2xCSuVAMYxmGwZMFjQsXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776870295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyGBy+XHbUwdbd8kUzk17cm00YRfKXB+fVANEn5LEFs=;
	b=twyVSMtzlGKY+YC2RrtCK0gwzZj9mDy+Q/PPxnkrEnl195MNjK67S1Ysvno4n/l7tB92GO
	Ae+Ba/Eu+FLk1uAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D788593B1;
	Wed, 22 Apr 2026 15:04:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id siH8Dpfj6GlFCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 15:04:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8741A0B44; Wed, 22 Apr 2026 17:04:54 +0200 (CEST)
Date: Wed, 22 Apr 2026 17:04:54 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: use QSTR() instead of QSTR_INIT()
Message-ID: <6kjrb7mchttfnh6cx2av3aqk3y24346rrl462psfrhjwgle7n3@l77coamhara6>
References: <20260422123345.100436-2-thorsten.blum@linux.dev>
 <20260422143437.GI3518998@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422143437.GI3518998@ZenIV>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 22-04-26 15:34:37, Al Viro wrote:
> On Wed, Apr 22, 2026 at 02:33:46PM +0200, Thorsten Blum wrote:
> > Drop the hard-coded length arguments and use the simpler QSTR().
> 
> ... which is not a constant expression.  NAK.
> 
> QSTR_INIT() is an initializer list for struct qstr; QSTR() is a
> compound literal for the same.  IOW, its value is an anonymous
> local variable with given contents.
> 
> C grammar allows both
> 	struct foo x = {.bar = y};
> and
> 	struct foo x = (struct foo){.bar = y};
> for auto variables, and compiler is able to figure out that they
> are equivalent.  But the second form is not legal for the static-duration
> variables.

Hum, I understand your reasoning but if it isn't legal, I'd expect the
compiler to complain. Which it doesn't and the generated binary of a sample
test program with both constructs is exactly the same...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
