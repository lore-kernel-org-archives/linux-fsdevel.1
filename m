Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4318414A09
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619226; cv=none; b=OY9QwRdT/rBLM0wIVsB986a7Z7Uq82VVvxQF8odHOTiUYd7SJZ2hDrgXcom25rYhBH6gFxkYQsl3MnYiHJfpZhLKp3l31jRwH7QqaZ/eUVLK/Dah6hRhZ6G/5wsR3xEttCkkLRyLy5aUR9iV84+06hcmyBNtN6cUjGL68cktAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619226; c=relaxed/simple;
	bh=bah9mcUArPN48z5NX/ilN98S3EUInnoxAcu2c4IcFtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdLer77VK2TrxAVsTS0HhoFVTT02suVvcz37j73kU2BG942T5C5tsrajfSIW7rBgSknKWD4xlCnkcyQu4C2o4I3tGKru6k15EWauUxVpyaeA9VbYRi3h51Oz1J78fhdIwc9NDrPUva6veDkZmot2ax7Ur+C96yXoVtGnBqSwGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cDR4STOh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nqXtYE6Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lisi1/bG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mKtbXSv2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cDR4STOh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nqXtYE6Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lisi1/bG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mKtbXSv2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDBFA82849;
	Thu, 13 Aug 2026 11:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldjfp1RMyqVRaRD31x2B8WF9el1NG4ea1OnLuwDBLx8=;
	b=cDR4STOhhN0AHiUM2OTboi9tHG+DW7YM0pDY8xIJoDxfdFWIy4BPYAabpp68iYWfI/9ICn
	rdtH8F+b786wAO/A/W/2Xc1S32pAwj9FCz8D6/Zvj9RNci4g60wWtMeBJ7OTR6Wtc64Gk0
	XJ2MqMRWtIkKpntXOqdhA5LFskV9x4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldjfp1RMyqVRaRD31x2B8WF9el1NG4ea1OnLuwDBLx8=;
	b=nqXtYE6Q/TWKJXm1iNasWV8iMehZ8VYvEXJxrwRn7T2ynD5lGK3DFO+xpwNo7GKZu47640
	gJEI6mJnulee2+Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Lisi1/bG";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mKtbXSv2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldjfp1RMyqVRaRD31x2B8WF9el1NG4ea1OnLuwDBLx8=;
	b=Lisi1/bGCaX4g5r4dLOA1F0R+c61DVS7IE+1P92JLSgWQ5DZ5xzLZ74rTH6Th5GYFqLSKj
	C6xKUFwwaEhpCeq5DUiZW0sMPGufdn3ZnUdVlHhM4BQycGprgMb2155wUhbWFtgaJI8sl3
	ypCGtX8zm8RjHd6MdSshrFTJzDt64qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldjfp1RMyqVRaRD31x2B8WF9el1NG4ea1OnLuwDBLx8=;
	b=mKtbXSv2IEh+HOEYN+JhmPQzfQ/09RSHQYl2ySekwiSdekV1GcstbLQWqk4/5+SvFJf3er
	PrEKBUZRygfNX8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD1A577DAD;
	Thu, 13 Aug 2026 11:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /77MLkilfWpPBAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 13 Aug 2026 11:06:48 +0000
Date: Thu, 13 Aug 2026 12:06:47 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>, 
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v9 13/15] hugetlb: Set mapping folio order
Message-ID: <an2lN6mOrZpahYhG@pedro-suse.lan>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-14-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805210557.1118966-14-willy@infradead.org>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,kvack.org,linux.dev,suse.de,kernel.org,huawei.com,gmail.com,suse.cz,vger.kernel.org,brauner.io,google.com,gourry.net];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email,infradead.org:email,suse.de:email,suse.de:dkim,pedro-suse.lan:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: BDBFA82849
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed, Aug 05, 2026 at 10:05:53PM +0100, Matthew Wilcox (Oracle) wrote:
> hugetlbfs currently uses an fs-specific way to determine the size of
> the folios in its page cache.  Thanks to the support of block sizes
> larger than page sizes, we now support this as part of the page cache.
> It's somewhat more efficient as we have this information directly in the
> mapping rather than going from inode->i_sb->s_fs_info.  We can convert
> the rest of the hugetlb code to use this at our leisure; this is needed
> now so that we can use filemap_get_pages() unmodified.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro
