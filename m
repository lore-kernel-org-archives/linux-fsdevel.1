Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1533BBCF
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464006; cv=none; b=qQxrDM5Xd98AxRDTQ3dGPDzbmHWdC95fygftIwi9s8Vl13Zz1rc44+Xd7InDEt6TOEjhT1JjjZ7d7Hbn0pMhSccrkNtfWs3iHZ3axKT6R9rVUVe8lJPYg7UR30AxFSUNSb+fk10a2M01CKb9a1IzNDt8VDdwaWPFo+ju3JpHOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464006; c=relaxed/simple;
	bh=ebA9AT3DZyrXiGPXOYiDArsAp7wmXKXImDq3tw/tBzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdRXVtxyZmBL6/TP0TZKNj4rMRJecSLU4MBXWTaHiyUvbg8B3JSM35IfLo8pzNgDJi+qScTrOFeL8zk+8putYkjQrAZuo3FO9Y3JRcP+rJNhY7CYeD6p3bz21gA+iDiUrgLuISgaI0Sjmswfn0E9/fjjZGxbgU914mws1eMP8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R82g9xbk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CeKczkdZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ahQQq2GP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A3buodUM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R82g9xbk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CeKczkdZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ahQQq2GP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A3buodUM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C3A95BCF8;
	Wed, 25 Mar 2026 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774464001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYDGDrGfIn122PZC9+Po4r/LTcmi8K6tGyJ7hJ3pxfU=;
	b=R82g9xbkKRFUHDDEQ0sYaqpkgMyIA/uThYtui3aHU8RIAH4fXR2zekzITuIJIAY9TzAQMe
	i3l+bePv+AeOWBQfb7j3LrxZoXnF1oHRl4KZ//PoISvSNE8g79x+Hl2/3rxQsZ/O2pbwNs
	lV8wy6DuFgUA6d8L9aUM9WhDs8tTz0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774464001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYDGDrGfIn122PZC9+Po4r/LTcmi8K6tGyJ7hJ3pxfU=;
	b=CeKczkdZKp+ZH0otzOb+1i8ldwwh29DdNYBJXt/l5s73zBSg/aujgeRvfXgpmdhU1mFHGb
	DQJ8O5vR+4ADF8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774464000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYDGDrGfIn122PZC9+Po4r/LTcmi8K6tGyJ7hJ3pxfU=;
	b=ahQQq2GPbGUZ/H/+nbVfo8WGKCPHnKFbq8iFFU2lYW/t7svJLKxAqmSUuvLoUlLcuOFdzm
	0EgpA/s0y/usHEcoeO1hRpL5YjJGmvr1asFc+ad39x6LijiB1NwXF+2Oylyu8hSLz4GdBo
	gW43moFk3FMkwZGeqCxjnpcCoiXOkIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774464000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYDGDrGfIn122PZC9+Po4r/LTcmi8K6tGyJ7hJ3pxfU=;
	b=A3buodUM4dUxTK65Jm8S0deVGOmbR8Y7lBnKO2SfyM9XNernv7ihWdK7NTeRY2KzMna7Bz
	57wa0HlvX3g3XNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2451644543;
	Wed, 25 Mar 2026 18:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SInMCAAsxGleTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Mar 2026 18:40:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A307DA0B32; Wed, 25 Mar 2026 17:12:23 +0100 (CET)
Date: Wed, 25 Mar 2026 17:12:23 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Jianzhou Zhao <luckd0g@163.com>
Subject: Re: [PATCH v2 2/2] udf: Fix race between file type conversion and
 writeback
Message-ID: <mrtedxufgnu3pguazamd6p3fgu7crj2hkx2gkmckodmn2zccfb@x3g5vrmntkxa>
References: <20260324105132.30490-1-jack@suse.cz>
 <20260324105316.28684-4-jack@suse.cz>
 <acN6YNzbgVUPGETm@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acN6YNzbgVUPGETm@infradead.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kvack.org,163.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO

On Tue 24-03-26 23:02:08, Christoph Hellwig wrote:
> The race is real, but I don't like exporting the writeback internals
> for it.
> 
> It seems like the somewhat cleaner version would be to have a version
> of mpage_writepages that takes and extra callback called in the
> writeback_iter() loop and allows bypassing mpage_write_folio when
> say returning a positive value?

With a single user I don't think that's really worth it. I think it's
easier to just opencode that small function in UDF. It won't be the first
filesystem doing the "is it dirty, wait for writeback, clear dirty bit"
dance on its own. Thanks for feedback!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
