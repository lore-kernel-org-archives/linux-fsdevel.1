Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2140803F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821144; cv=none; b=X0qifkwP3SaAPfhwFgpAl8728G+ktzpjhstUzXmKXmUnzUCTBw8MLehp+S6Dq2fnmDYtuaF4a7EuOEpwtdW+RjBr68UdM/bGFBdCKmd+8KLm2UOH4lQuvGYWDICe82tBaYq0ysqcblM/FOMSNHZYTIVNResR7jTmaG4XoffYiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821144; c=relaxed/simple;
	bh=y0IECwpS11X03Syuv8WNSoCJUgh0Gr/zONiezbb0hCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTHzquhLQPPU6XkTtvJw7NVSbW+Tfn/LpPLtC9PXtJuR6B7a5+jpdE1AqOrg6kriFZiuM9cI4khVUmn5LsGxjJLoWkFa6dC2OrOXYG3fsf+gFTVDGaunXmQQNMc9w176Sp27gBt1CxkWeji/9itOw2NocwZoAfLX3ipIBN+XhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ssb8Laqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CXix7dh7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iC+oWmZD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vhif/LMX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ssb8Laqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CXix7dh7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iC+oWmZD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vhif/LMX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1CA571A01;
	Tue, 30 Jun 2026 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782821138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6qeYl5QdWsqI+hopgAOLmohwbxl23aNjL7MQDQYJm8=;
	b=Ssb8Laqy/DH8yJevDGsofF+FkMfbKxppLq3zzL75AnwBUMgmCassqeJSC1bur4Fx+9Cxc0
	vXBHz9v0ZQjnk7JYEyBLTeaOLPQzSs91ArHwCimaJnoPWpwb6GJ1VX1UhkCKrNjo18HdBD
	vzT8fg8Y4fkT6/jDoI3dJQv6hREKqrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782821138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6qeYl5QdWsqI+hopgAOLmohwbxl23aNjL7MQDQYJm8=;
	b=CXix7dh7ivvnopTgFv7snhSI+17JyWsMEa/40afS4xKzqU8JjKa0E3QlYlZUbCk4R2Lbv9
	ajtbXLcaLohjaeDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782821136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6qeYl5QdWsqI+hopgAOLmohwbxl23aNjL7MQDQYJm8=;
	b=iC+oWmZDdRvrKhlZfLlXoMQm++41AY+51Zp5mProfKqDC4jq+3rxYTBmngb6VdF2obC2uc
	t16k/ixaIAi414I3UZcm/9Cd2gEwxfTtpQ+eyq7HKkw9sNfYRWZeUiTGNn/uX5RWn7MVzZ
	n/np9tq5k02gUBIz9QSJG9xf/yVC1K0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782821136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6qeYl5QdWsqI+hopgAOLmohwbxl23aNjL7MQDQYJm8=;
	b=vhif/LMXhIUzPz8RC4A6mfbNxF3PA9ZSv1E7t6ibGANjjwoebxfAdYAb0dblMSkCE/ENsk
	rtv2iEbDZFHDwuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BED06779A8;
	Tue, 30 Jun 2026 12:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fzGMLhCxQ2qkbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jun 2026 12:05:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1B67A10B7; Tue, 30 Jun 2026 14:05:33 +0200 (CEST)
Date: Tue, 30 Jun 2026 14:05:33 +0200
From: Jan Kara <jack@suse.cz>
To: Zhen Yan <yanzhen20011121@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: fix mapping_seek_hole_data() overflow on last page
Message-ID: <tikbuxxazkmz5obcf6llp342vn7bi5tlgbbnuliw4jlwndj63e@jkp5g5oj6ug7>
References: <20260629164932.b91930b0497e8446a2a549d2@linux-foundation.org>
 <20260630031226.3141360-1-yanzhen20011121@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630031226.3141360-1-yanzhen20011121@163.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Tue 30-06-26 11:12:26, Zhen Yan wrote:
> A local unprivileged process can create a shmem/tmpfs file with
> i_size == LLONG_MAX using memfd_create() and fallocate().  If the last
> page is present in the page cache, lseek(SEEK_HOLE) on that page
> returns 0x8000000000000000 as a successful offset, which is LLONG_MIN
> when stored in loff_t.
> 
> The same file has readable data at the last byte, but SEEK_DATA from
> that offset returns ENXIO.
> 
> The overflow is in mapping_seek_hole_data():
> 
>   pos = round_up((u64)pos + 1, seek_size);
> 
> For the final page below LLONG_MAX, the next page boundary is
> 0x8000000000000000, which is then used as a signed file offset.
> 
> This violates the lseek() ABI for shmem/tmpfs: a successful seek
> returns a negative offset, and SEEK_DATA can miss readable data at EOF.
> Hole-aware copy, backup, and sparse-file scanners may skip the last
> cached byte range.
> 
> Keep mapping_seek_hole_data() inside its documented [start, end)
> search range by clamping the rounded-up position to end before passing
> it to folio_seek_hole_data().
> 
> Signed-off-by: Zhen Yan <yanzhen20011121@163.com>
> ---
>  mm/filemap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5af62e6abca5..22a1534ec8b3 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3234,6 +3234,8 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
> 
>  		seek_size = seek_folio_size(&xas, folio);
>  		pos = round_up((u64)pos + 1, seek_size);
> +		if (pos > end)
> +			pos = end;

So I agree with your analysis of the problem but I'm not sure how this is
supposed to fix it. If pos was offset of the last folio - that is
LLONG_MAX - PAGE_SIZE + 1, then round_up() ends at LLONG_MAX + 1, which
readily overflows to LLONG_MIN (pos is loff_t). So pos > end will not be
true and nothing changes. Am I missing something? So I think you rather
need the condition to check for something like pos < 0. Or maybe use
check_add_overflow() to make the overflow checking more explicit.

								Honza


>  		start = folio_seek_hole_data(&xas, mapping, folio, start, pos,
>  				seek_data);
>  		if (start < pos)
> --
> 2.25.1
> 
> Sorry, my previous email may have been lost due to network
> filtering issues.  Resending the revised patch with the
> requested changes (tabs preserved, CCs added, signoff added).
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
