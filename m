Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D192415F2C
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619147; cv=none; b=HGck7s5EzlzfvipTr3Kwz98SOxjysZEY5H2/w/T/hW6dyuQ3XWBpv0eOcjumWP6b1POvkqN1H46IB14Ktd1NeFcn4O2cXVPWt6EE1eTrE0FHzCIWv2SJJAmwSLkjNKe6D2AfPeI9DOSbJ+9qpWAhsRPkpu3AfuT0Dh83+be6/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619147; c=relaxed/simple;
	bh=Sl+l0bnXEyxZKko7dFm9bw5fn8KyI3svQ1SXmnlwtyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oelXIR7mHNOmJG3tpyYOI07EtmHF9BbSkslOzzRudSz6MK64X5Na9zeHREzQ+IT1bKlxDG/pxDM6Ay05INfeXaH5bmRe0tFTH4oGD3S4tN+zVvzFVXpYRUS6v/eX/OZK3LDRkk5+Khr0tKEJb9wu1isw9BjD95ipg7SSTTafJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QgTKfof/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SW7399y7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Egm2Kt59; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4gsKVIcM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QgTKfof/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SW7399y7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Egm2Kt59";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4gsKVIcM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DDB43E0D;
	Thu, 13 Aug 2026 11:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uibj/eRl0gzKJwNpAnrp43JZg6Px+9DiZOe91L9wuN8=;
	b=QgTKfof/u5YafqZjss7nLIyoDdhbu0rWmTfUtW3X73CscD1Z/pf2BmZlJecWfka7+QROGT
	vJJ6+U6c6v8oPs+hgtV6LREykNAnqfhQ96eBpgFfonygZvP15bq92VW0pwZZrpAYN77N3q
	HoR/dZRxuSql2lojVdyMELhZT9kIzH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uibj/eRl0gzKJwNpAnrp43JZg6Px+9DiZOe91L9wuN8=;
	b=SW7399y7HoYBZ0WJ7OcOs1nsPwhpKY43dW3G0yIGi/XucHa8sgXHXHmdWAjoYHL7OFFtV0
	w9HycSRwZ21CdoCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uibj/eRl0gzKJwNpAnrp43JZg6Px+9DiZOe91L9wuN8=;
	b=Egm2Kt59TwMHWdUX27Fdj5GOjzex5mEMjU36hKeSVpguV9y/0B0LQXmTkcune7jXHIBqqy
	XIb5NnFFrkSGlJaLBxAZcuWKQvYGXi7O4Uu5C/v2fvZ+CYvJ5dGs380HXiLIrfKpbZSPK/
	3k9dy+Ar9ttljGNhG3cMm938KcwBxmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uibj/eRl0gzKJwNpAnrp43JZg6Px+9DiZOe91L9wuN8=;
	b=4gsKVIcM7P+VVUu1H36KE4YDc81I0L/28ZXTJTL7A8msOqiuxtjIaFLOBlP2IfKBlpx8vU
	CPI6xpownYAJABCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 650CE77DAB;
	Thu, 13 Aug 2026 11:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rjM+FfmkfWp9AgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 13 Aug 2026 11:05:29 +0000
Date: Thu, 13 Aug 2026 12:05:27 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>, 
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v9 12/15] filemap: Remove checks in
 mapping_set_folio_order_range()
Message-ID: <an2j-26QD3KxczRO@pedro-suse.lan>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-13-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805210557.1118966-13-willy@infradead.org>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,kvack.org,linux.dev,suse.de,kernel.org,huawei.com,gmail.com,suse.cz,vger.kernel.org,brauner.io,google.com,gourry.net];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:helo,pedro-suse.lan:mid,oracle.com:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Wed, Aug 05, 2026 at 10:05:52PM +0100, Matthew Wilcox (Oracle) wrote:
> These checks make it impossible to use mapping_set_folio_order_range()
> in hugetlb.  They add very little value and can simply be removed.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
