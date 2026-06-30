Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771003F23C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826048; cv=none; b=b9QpojuBpFUoPytG9acXGnPl/P+yXJ+fv0q35iFFx227HnlISP9Akar65UZXbfezFsXoahADdH3Z4PnOxLrEB/nBj4oRzNcL7JjhgLaU5L4GOUlQfFUCGmrT9de3+XsJHvIxwFeiNKmP+PQCohDIKsblisnxJXBdwQUg0BF9row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826048; c=relaxed/simple;
	bh=qAYrHU9BlbBUoGs8ioiVp2UzrTOdjV/7/LM6DlKT6Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy3bTiEAb0Psit0imx51fluID/PYdPZAaKN0SI9I8nsTS4sRDuXljQvDu65BXrHUgtIfxUU4M15fQ8bBDneOjCVDRkoB9WRb00m5vF94tfoNABODEd7LL2lRssS/tYG4Vnm7oQh1Uh//rJnM7t6RRRjFGmmFj1MmjpnT/Gwt/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7KgrTfb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9Hqkt+E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7KgrTfb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9Hqkt+E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7KgrTfb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9Hqkt+E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7KgrTfb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9Hqkt+E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B891675DEE;
	Tue, 30 Jun 2026 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782826045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EohyzSqi61XNm9HTErvonNu/Vfwe4QH4QFsyqiBSeg=;
	b=s7KgrTfb1lBuC2JTCht2qO194h+5f9v4Vld4r4855ctAu3XCjYe1M3GqLtlimJaYtM2t5s
	haw+QzH/gRSlxC01p7tf3rT1Yh+7ErqGOiQo/vbORjPKfkBazNIbShgO+z1zn9XY/nyCla
	oCKI/uMYhqeNXXyjzHXdzQoX6IMz3Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782826045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EohyzSqi61XNm9HTErvonNu/Vfwe4QH4QFsyqiBSeg=;
	b=p9Hqkt+E/w/gUzXuhwFZgO/ysZQSrBOBn6Cg6gHT7Xeg6Ii8k1sszcVjj7p6gGPftP+sK9
	skv4w+kP5F9adCDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782826045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EohyzSqi61XNm9HTErvonNu/Vfwe4QH4QFsyqiBSeg=;
	b=s7KgrTfb1lBuC2JTCht2qO194h+5f9v4Vld4r4855ctAu3XCjYe1M3GqLtlimJaYtM2t5s
	haw+QzH/gRSlxC01p7tf3rT1Yh+7ErqGOiQo/vbORjPKfkBazNIbShgO+z1zn9XY/nyCla
	oCKI/uMYhqeNXXyjzHXdzQoX6IMz3Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782826045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EohyzSqi61XNm9HTErvonNu/Vfwe4QH4QFsyqiBSeg=;
	b=p9Hqkt+E/w/gUzXuhwFZgO/ysZQSrBOBn6Cg6gHT7Xeg6Ii8k1sszcVjj7p6gGPftP+sK9
	skv4w+kP5F9adCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD6CB779A8;
	Tue, 30 Jun 2026 13:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iT1OKj3EQ2pFQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jun 2026 13:27:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F97DA10B7; Tue, 30 Jun 2026 15:27:25 +0200 (CEST)
Date: Tue, 30 Jun 2026 15:27:25 +0200
From: Jan Kara <jack@suse.cz>
To: Zhen Yan <yanzhen20011121@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: fix mapping_seek_hole_data() overflow on last page
Message-ID: <hhrt7iy4rgv33wxghhhwryiw3jjgorvmbw4tvxenhmin7z52z2@njm2bn273f26>
References: <tikbuxxazkmz5obcf6llp342vn7bi5tlgbbnuliw4jlwndj63e@jkp5g5oj6ug7>
 <20260630125047.703170-1-yanzhen20011121@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630125047.703170-1-yanzhen20011121@163.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[163.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue 30-06-26 20:50:47, Zhen Yan wrote:
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
> When assigned to the loff_t pos, this overflows to LLONG_MIN, so
> a subsequent "pos > end" comparison does not catch it.
> 
> Keep mapping_seek_hole_data() inside its documented [start, end)
> search range: compute round_up() into a u64 variable and compare
> against (u64)end so the overflow is detected, then clamp pos to
> end when the rounded-up value goes past the search limit.
> 
> Signed-off-by: Zhen Yan <yanzhen20011121@163.com>

Thanks for the patch! It looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One small comment below:

> ---
>  mm/filemap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

The explanation you've added to the bottom of the email really belongs
<here>.

								Honza

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5af62e6abca5..b78fd88f2638 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3225,6 +3225,7 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>  	while ((folio = find_get_entry(&xas, max, XA_PRESENT))) {
>  		loff_t pos = (u64)xas.xa_index << PAGE_SHIFT;
>  		size_t seek_size;
> +		u64 next;
> 
>  		if (start < pos) {
>  			if (!seek_data)
> @@ -3233,7 +3234,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>  		}
> 
>  		seek_size = seek_folio_size(&xas, folio);
> -		pos = round_up((u64)pos + 1, seek_size);
> +		next = round_up((u64)pos + 1, seek_size);
> +		if (next > (u64)end)
> +			pos = end;
> +		else
> +			pos = next;
>  		start = folio_seek_hole_data(&xas, mapping, folio, start, pos,
>  				seek_data);
>  		if (start < pos)
> --
> 2.25.1
> 
> Sorry about the previous patch -- the `pos > end` check was wrong
> because round_up() overflows loff_t to LLONG_MIN, making the
> signed comparison ineffective.  Thanks to Jan Kara for pointing
> this out.  This v2 uses a u64 intermediate variable so the
> overflow is correctly detected.
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
