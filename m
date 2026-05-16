Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A32264C0;
	Sat, 16 May 2026 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778972834; cv=none; b=i8aqzpJSld4SsIkfAjSRaza6mwwpPj2avbr/6odjOhkeSFuyk6ANJ+CiK/q92zr7AScc48b5jKX+0gOkhwTu/LynjjFaygEoPopx6Vh1QHO/53sIzCW67k0CkXlsmtRK/FLKKvD0ETCbTNjQlUWtci3CPcwga/CrdAPVLei0RKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778972834; c=relaxed/simple;
	bh=pPboQzoxWll5atCrTn0mxAwC43E1aAqbWkxgCSWY0Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrlB6E/9ZJN/PrEKKryIlduvgQ9DV7no6IuQjE5wmuITo+eoZQ0i32Ro873VGamwol9kMaNAwRjANpYjlooWEIY8y/gXl4OZGL6RlM5njR/qOKDhsoqwhbz4fH1cTynnz//oXt2nz/7Q/uOfP+yoSKhE8RgpzvDO8K7sBHceswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ryYtMULD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ryYtMULD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4fRmmYsKxngs2j8r5GGiootBnUnPKw9sKMgaHLCSBl4=; b=ryYtMULDZwbQs+GFCAfwBOEPaM
	Lob7cabWXt13wQzjh6qSjSSCVuthAadH8UeE/XKJUo4VkKXGtC1zEAUuZXPXBrvQ2F5APtt86fU10
	bloGX19doRG67ifJN4xM0yACmLuoxANePWuKlNqoy4Hj4CSKnlLhjAKIOaHwgLXjJ709m0UEmDGe+
	HXs+53WHSuzeaFFf2ucsFU8JPiAJhz/5GISHU5xVqc3K+RAgguo/uW9gDe5S5Td/voIxTixKg9QlU
	Cp8I523m9rASYVx16gEMXLzCF9XbkbxJAXNzdmMB1a4J9hiCrOr18DU/FrppKKUE+hd7r94r3JJ/D
	cpOw1f4w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOO65-00000003KaM-2J8E;
	Sat, 16 May 2026 23:07:05 +0000
Date: Sun, 17 May 2026 00:07:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <agj4mXKRVW44ZJ18@casper.infradead.org>
References: <20260516182126.530498-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516182126.530498-1-pfalcato@suse.de>

On Sat, May 16, 2026 at 07:21:26PM +0100, Pedro Falcato wrote:
> +static bool may_write_to_page(struct page *page, struct address_space **plast)
> +{
> +	struct folio *folio = page_folio(page);
> +	struct address_space *mapping, *last = *plast;
> +	struct inode *inode;
> +	bool may = false;
> +
> +	if (!READ_ONCE(sysctl_splice_needs_write))
> +		return true;
> +	/*
> +	 * Always fine to write to anon folios.
> +	 */
> +	if (folio_test_anon(folio))
> +		return true;

What about KSM?  It's not something we've seen attacked yet, but it'd be
pretty nasty to be able to change a KSM page in another process.

I just got off a flight, so hopefully I'm semicoherent.

> +	mapping = READ_ONCE(folio->mapping);
> +	WARN_ON((unsigned long) mapping & FOLIO_MAPPING_FLAGS);
> +
> +	/* If it is the same (locklessly), then LGTM, proceed. */
> +	if (mapping == last)
> +		return true;
> +	/*
> +	 * Else we have to recheck with the folio lock held, for mapping
> +	 * stability. TODO: killable?

I wouldn't've thought that'd be necessary.  The folio can't be being
read because it's mapped, and we won't map a folio until it's uptodate.

> +	 */
> +	folio_lock(folio);
> +	mapping = folio_mapping(folio);

I think you're safe to just look at folio->mapping here.  You have a
refcount on the folio so it can't be freed, and I'm not sure there's a
way to transition from page cache folio to anon folio without taking a
trip through the page allocator.

> +	/* May have been truncated, etc */
> +	if (!mapping)
> +		goto out_lock;

typically we call this "out_unlock".

> +	inode = mapping->host;
> +	may = inode_owner_or_capable(&nop_mnt_idmap, inode) ||
> +	      inode_permission(&nop_mnt_idmap, inode, MAY_WRITE) == 0;
> +	if (likely(may))
> +		*plast = mapping;
> +out_lock:
> +	folio_unlock(folio);
> +	return may;
> +}

I don't have a problem with the idea, other than it's really sad we have
to do this.
