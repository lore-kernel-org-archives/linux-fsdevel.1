Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA61463B6D
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619567; cv=none; b=pPaEVUllTBxfZgDB4/Uwg4WfaXIObZThQ1v1opmDu8OTTzcFpRfWI6be/if8OMmhITFxdEMtZFqBDb4LS0jolmdq1deoY1TTSzX9mjlLuS3/cdqpAHIIgO2Cg81kyEgN7JdoUZChd13h3hMhZNF0YboodX1NmDA3ChwY9Icc32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619567; c=relaxed/simple;
	bh=3yfdvLv+7kWcla2fp0SKd7mluUGL2r5qhM2cIxQ+SR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jywkgLkBQzbfiobP/XtMFLEShEIgHk8vcLe+MaJ0fAyqBuo2DxRR7PoksPHz1ZtyYRByx4WqOuvTGTpSDT4H7T1O3HLsscM0ksemQQ2dfmd553H5/vcqo5NcyIqXhZsf+S6YsLrPnhjV/dobUXf+KGwC6Nm5JeXbXD2kmdKE6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kY2wbE5r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ira5jC9D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v2v3Y4um; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HbbWXBnS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kY2wbE5r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ira5jC9D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v2v3Y4um";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HbbWXBnS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A39FB82830;
	Thu, 13 Aug 2026 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aa5PQgPbsqDszH92WC8ete6hlLLGfSpkDZEGTbMUJQU=;
	b=kY2wbE5r6cXe0EoMl0im0qrCP+AWhn41XgI5gPf+3V1JKAj3sQijqf/WaY3diUJaywT57k
	XUai3bMxApx/+EN/MJPpx+2IA1glnWMNjHLMP2TWLJketr0R21OEqBbWDHvyOKGJ6THA6r
	CtAII6A2yZGliaEyS2DpDilkv9KPDhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aa5PQgPbsqDszH92WC8ete6hlLLGfSpkDZEGTbMUJQU=;
	b=Ira5jC9Dvm6/shLPPo+mCN3mXLTgX4KAuoT9AhXa9m8PI6i1Jcy8sL/uVs66eXEw2uPxsw
	gRNxR1zBR1FxVMAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v2v3Y4um;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HbbWXBnS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aa5PQgPbsqDszH92WC8ete6hlLLGfSpkDZEGTbMUJQU=;
	b=v2v3Y4umHePZxuEqj+Vl7Or2jsmfXsPQEuJXVPQSgiS45ELzFwDNxXUH41ei85yIt0jDMQ
	gNx4eLnaRH5/F1/DhfPwVsIH2eqy78rwFkQeo3GAJgYFqhi8pCJeG+16uxYims+199Klrh
	6OdKH24cAOFlUCX9i5NMBjWxfnFrki0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aa5PQgPbsqDszH92WC8ete6hlLLGfSpkDZEGTbMUJQU=;
	b=HbbWXBnS2zCjw2vuOLJyoNv0k/KWIE/HCHGaVgzox/FbbPpyBneHy7LRKzzj/Ghq/g/dm1
	UObDVcKWVfTFUyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8FCA77DB2;
	Thu, 13 Aug 2026 11:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QWXbKZ+mfWrWCAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 13 Aug 2026 11:12:31 +0000
Date: Thu, 13 Aug 2026 12:12:30 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>, 
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v9 08/15] hugetlb: Use the has_hwpoisoned flag
Message-ID: <an2mYe_lClK3co6l@pedro-suse.lan>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-9-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805210557.1118966-9-willy@infradead.org>
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A39FB82830
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,kvack.org,linux.dev,suse.de,kernel.org,huawei.com,gmail.com,suse.cz,vger.kernel.org,brauner.io,google.com,gourry.net];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,infradead.org:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,gourry.net:email,pedro-suse.lan:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed, Aug 05, 2026 at 10:05:48PM +0100, Matthew Wilcox (Oracle) wrote:
> Other large folios use the has_hwpoisoned flag.  Convert hugetlb to match.
> This will help us use the per-page hwpoison flag in the future.
> 
> Also introduce a folio_test_huge_poison().  This has exactly the same
> meaning as folio_test_has_hwpoisoned() but can be used when we don't have
> a reference to the folio containing the page.  folio_test_has_hwpoisoned()
> can race with folio splitting / reallocation and trip the assertions
> in const_folio_flags().
> 
> This closes a gap where a page in a previously-poisoned hugetlb folio
> could be observed to not have the hwpoison bit set.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> ---  
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 9e0ca4824905..e666dd14ca0c 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -843,11 +843,15 @@ config PERSISTENT_HUGE_ZERO_FOLIO
>  config MM_ID
>  	def_bool n
>  
> +config LARGE_FOLIO
> +	def_bool n

random nit: def_bool n means the same as just bool

I can't comment on hwpoison stuff, sorry :)
-- 
Pedro
