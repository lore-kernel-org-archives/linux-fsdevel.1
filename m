Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C13D34BB
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369731; cv=none; b=KlS6qDMeGshrTELbQFUWDasB636opNCeyNqaNx4lSwJ78ExV5vF7l6LgGshga4HUizY0V26OLNxDMZJyyWkR6jjX9I8U/Uy1MhtaCMhjkPiXncCSxo+dor73LiAJHwihtPbfus/2ooRei10u3Cs//WDuPzlFBftYaf26mQR/baM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369731; c=relaxed/simple;
	bh=3eEmzoz1b50gv4FI0ZaV9mUL/+4VM7eqsbOBhlkHFRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUTMag+3Ygfl+vGpvKhS1VwxQjAgk5RrBzbj5NwJUpLXq3edf0jOOUzsdyUDR6HPcEdfwa2OoetHlTBd3dWcYF2kqscUcOI4KYUah5iQRe0p1LIBOurULWRdCQnDmEhmjN30H60XgDMfXw/14LuFLVNZOPIbmR0CKc7Os9C8fL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qfiV26mE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x1fe0l70; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qfiV26mE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x1fe0l70; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qfiV26mE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x1fe0l70";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qfiV26mE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x1fe0l70"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B3F96A7E7;
	Tue, 28 Apr 2026 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777369728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+1aaYj2CnEX1a5PD5J7TGxUpvG8RyAVHxtUULGmhmg=;
	b=qfiV26mEo8+AaV3WzZ8MuUk5+NlcpxR4kg8NOhl+01B1MXLHgCd0Lq1KyDe8Ujoe7/c9hu
	63tKz1T/8Pv/TN5ZHczkbIfXN3kvPk0aFmk+xfFHEdflZh0NWxceKwPE/PcfxLj1vZZvBo
	WrUiYz7U1L0HP9p/q/YISKTVHzU/w3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777369728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+1aaYj2CnEX1a5PD5J7TGxUpvG8RyAVHxtUULGmhmg=;
	b=x1fe0l70pe5lxEzmvOIQKopMXKCDZf0Gk15Z+OI5ucLG2YRy8UBZlHDJH9KwquwWhVnzR/
	XuZzqoxVKOWwPdDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777369728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+1aaYj2CnEX1a5PD5J7TGxUpvG8RyAVHxtUULGmhmg=;
	b=qfiV26mEo8+AaV3WzZ8MuUk5+NlcpxR4kg8NOhl+01B1MXLHgCd0Lq1KyDe8Ujoe7/c9hu
	63tKz1T/8Pv/TN5ZHczkbIfXN3kvPk0aFmk+xfFHEdflZh0NWxceKwPE/PcfxLj1vZZvBo
	WrUiYz7U1L0HP9p/q/YISKTVHzU/w3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777369728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2+1aaYj2CnEX1a5PD5J7TGxUpvG8RyAVHxtUULGmhmg=;
	b=x1fe0l70pe5lxEzmvOIQKopMXKCDZf0Gk15Z+OI5ucLG2YRy8UBZlHDJH9KwquwWhVnzR/
	XuZzqoxVKOWwPdDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43C3F593B0;
	Tue, 28 Apr 2026 09:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j2+JEICC8GlICAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 Apr 2026 09:48:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0C532A0B62; Tue, 28 Apr 2026 11:48:48 +0200 (CEST)
Date: Tue, 28 Apr 2026 11:48:48 +0200
From: Jan Kara <jack@suse.cz>
To: fujunjie <fujunjie1@qq.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>, 
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: Re: [PATCH v3 2/2] mm/filemap: do not count FAULT_FLAG_TRIED retries
 as mmap hits
Message-ID: <lxmyrpudachmomrrfltlvwxtddqakuudeq3wau2izgunakpvpz@3mbztm6x57nr>
References: <tencent_AA501E9A238337BD167E5C2ACF948A1AF308@qq.com>
 <tencent_22E6B8849EC1141FE7773C64467E6F1E2C09@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_22E6B8849EC1141FE7773C64467E6F1E2C09@qq.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,qq.com:email]
X-Spam-Flag: NO

On Tue 28-04-26 01:59:44, fujunjie wrote:
> A fault that starts synchronous mmap readahead can return VM_FAULT_RETRY
> after dropping mmap_lock.  The retry may then map the folio brought in
> by that same miss.
> 
> Do not let this retry decrement mmap_miss.  The retry still maps the
> folio from the page cache; it just does not count as a useful mmap
> readahead hit.
> 
> Signed-off-by: fujunjie <fujunjie1@qq.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 543e51c32397..86a46a61eac8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3933,6 +3933,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		 * we can stop read-ahead.
>  		 */
>  		if ((map_ret & VM_FAULT_NOPAGE) &&
> +		    !(vmf->flags & FAULT_FLAG_TRIED) &&
>  		    !folio_test_workingset(folio)) {
>  			unsigned short mmap_miss;
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
