Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C23471255;
	Thu,  8 Oct 2026 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451621; cv=none; b=Z2xVMBahG01GUwl+5RaULoqaWE7Ajg2hcvY4ljsMfTL7r9u71E5lv5aT6qRA42UJOHU9Ypo6+u3lRQtHt28UrpN5cwUM3VHTWokdMPX713TdQwfj0SflB5SNgxT4j8vpJxSO5xjhNL0eQuUevDvsQPUvEtE7/n7TTOZJc3ZpI1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451621; c=relaxed/simple;
	bh=DNTwANhn2i6yk4cbwvEgIsXXMPj+4iNRyM8Nr8eUd2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nECB2+P+dJwOvmKq4T+ll3UMtqk0paNqO6xJx08QlqI525pNF2z4xAR9ABYVQPrtx6YLw5kvb4DUmUr7D8uqiTgBerZmYY+/5Mo5xtC0jA2A9SQnD0a9IQPx4JllyG7sdUc2egKONHtpryKtDL4KdoumrSRAVglzxFPhU+vEUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MLPhnO/F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uURyrTv+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MLPhnO/F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uURyrTv+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2C3A21BEB;
	Thu,  8 Oct 2026 09:26:57 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791451618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9J/h37jwaSf9Oat6ZX0Xs/P9dCpzFnbCtqimX+FEfw=;
	b=MLPhnO/F8tjDHvGqA36wUv0eytwTHqgKlBiw4KGMMqcNaY1J/c+mzBcRZZyNlIS5ZD1fyD
	qrnXZz998c/ts6+ki+/mhHP3p8bT1B452yp3zjFBxjbXAqbwaHIZbF9z8I4QQZuzZ22uxQ
	CcSPFCQ2HxP7Jg3fWfL4DOqpj0hMh2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791451618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9J/h37jwaSf9Oat6ZX0Xs/P9dCpzFnbCtqimX+FEfw=;
	b=uURyrTv+nWnbSIE+uqGeKv1pwgpzPX2ROnUeXYMrMUhG4NnG0iggh5LEM0BAVyoG2JdGB4
	Y38bOEls0tLV0+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA4D313354;
	Thu,  8 Oct 2026 09:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FUxpKeFhx2rUfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Oct 2026 09:26:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 575EEA13FC; Thu, 08 Oct 2026 11:26:57 +0200 (CEST)
Date: Thu, 8 Oct 2026 11:26:57 +0200
From: Jan Kara <jack@suse.cz>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ayush Ranjan <ayushr@modal.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
Message-ID: <zlfk2ussq6ighnxxb2dl2nqhopposzyj45smrr6ztnthe6xcjy@uekwoodseblv>
References: <20260924061708.1645968-1-ayushr@modal.com>
 <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
 <20260925053027.1998394-1-ayushr@modal.com>
 <20260925065013.3682431-1-ayushr@modal.com>
 <20261003033107.1488699-1-ayushr@modal.com>
 <6aa5a165-3ba6-4974-b549-fed7318ead49@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa5a165-3ba6-4974-b549-fed7318ead49@linux.alibaba.com>
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: F2C3A21BEB
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: 0.00
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 08-10-26 15:58:56, Baolin Wang wrote:
> On 10/3/26 11:31 AM, Ayush Ranjan wrote:
> > Hi all,
> > 
> > Gentle ping on this.
> 
> Sorry for the late reply due to my vacation.
> 
> The reproducer in my previous mail [1] triggers
> > "Bad page cache ... still mapped when deleted" on 6.18.46 within a
> > couple of minutes on a 128-CPU bare-metal box, with no fork() and no
> > gVisor involved.
> > 
> > We continue to hit this in production at low frequency, so I am happy
> > to test patches or collect more data if that would help.
> 
> Now I can reproduce this issue on my machine with the latest mm-unstable
> branch, and I understand the race. I have confirmed that Andrew's patch can
> fix it. You can try Andrew's patch.

Great that you can reproduce and understand what's going on. Can you
perhaps explain what I've asked in my reply to Andrew? I'm apparently
missing something but I don't know what that is :). Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
