Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F4468C02
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619476; cv=none; b=FZhiOnP5EiNl7dxL2U/hb9GdPA3jyvs73Lv7i/HEVbir+t4uoXshHjUtbPgFMYlP2b2ml/k0wnfomedUkZ8nYVLiyXMuonbcYg23E0/60iHYLtXuInswjXyw2T/4kAqwf1hRZ+Jd3UwjDyUbkqfTs7/7ACciZr2XgF9cbDuJiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619476; c=relaxed/simple;
	bh=kw5vbm5OlS8ajZn/oS/5eUdOGjZZJcZDflPTbSZMTac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebl/IhheTreMHnMdlkfljjRrRqChgY/vULY3N3cvZSkWVGSEaPEWUSN4bTXwVEhbMYmQTnUaR6qNG4XUhsHUMireV4bKvG6iZYgCYblA3jjNbcY8t7mpjwHnyNsAjAFXctHJ0HRzgVJR1V3WZRojzg3AnHnjYWk3Gekb15+ht5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TnGZipEp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q3nLSKTB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JlLhO/E5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vHAxjYR6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TnGZipEp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q3nLSKTB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JlLhO/E5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vHAxjYR6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EC7282849;
	Thu, 13 Aug 2026 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9DLtOqz/kvw6uTXCnnGseLONncfYG1BbS7hBn1gS5c=;
	b=TnGZipEpXvOMDMxm+p7n6VmVm9gNk7OnND1aUBQ3O6TXn972g/wpMpOiOfL3XL96EQLR/6
	OXEElOz/FVz/ITfq/dLPlSol2kX90bLwKrGPbTMT5Ys/BF4opaEtiVeDdr8kNMuom3I0dT
	iFhI0isOjjKy1igGDyTrZ8yXhgrNe0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9DLtOqz/kvw6uTXCnnGseLONncfYG1BbS7hBn1gS5c=;
	b=Q3nLSKTBtwXC7EyRvHr5vGVxtXs4afFuJqlBwLqpaUA24/KFFK1Fante8nxEDWWFGQNK4k
	wl9N9mOff/D03ICQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="JlLhO/E5";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vHAxjYR6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9DLtOqz/kvw6uTXCnnGseLONncfYG1BbS7hBn1gS5c=;
	b=JlLhO/E5yoQSolyiIONWXVN1nBp8Uo4HLLIubjGR/QEpbbNbmCaeL0m6Ed5sQaFIgr3Ez5
	3tlbp+II6/tXdxhjdC7kDMVcwBCLs7KO82pGkKDbuRxw3aKuePxcJop9GkRGtHEfDnnevL
	t1dgNxn6xGWCrN45H/r/L/nWGncGgHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9DLtOqz/kvw6uTXCnnGseLONncfYG1BbS7hBn1gS5c=;
	b=vHAxjYR6VVoC8vsCsZXHUwQgYPl80XBnKxKN41m1GYCLg2OZ/lqDMuMlHn2C9fqAmrBbFL
	JEWltbN13qRmuFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9434C77DB3;
	Thu, 13 Aug 2026 11:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ruTxID+mfWrsBwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 13 Aug 2026 11:10:55 +0000
Date: Thu, 13 Aug 2026 12:10:53 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>, 
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v9 15/15] hugetlb: replace hugetlbfs_read_iter() with
 generic_file_read_iter()
Message-ID: <an2mKH_VQlfEYqcr@pedro-suse.lan>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-16-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805210557.1118966-16-willy@infradead.org>
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8EC7282849
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,infradead.org:email,pedro-suse.lan:mid,oracle.com:email,gourry.net:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed, Aug 05, 2026 at 10:05:55PM +0100, Matthew Wilcox (Oracle) wrote:
> From: Jane Chu <jane.chu@oracle.com>
> 
> generic_file_read_iter() now handles hugetlb poison, hugetlb page
> size and missing folios correctly, so we no longer need a separate
> hugetlbfs_read_iter().
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

Awesome!

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
