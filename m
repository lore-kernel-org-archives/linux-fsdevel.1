Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256533A6E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892189; cv=none; b=MP/gFlXv7NXyy+1MmuUe6xVw8gjDAZEcipMkmtbA+Gkkn5w5AEeXAJAq2GAI8MMFLfIcuYFkq+lL+7oEZpUq6Mn2TBvTx35dCBE+vYiCa8RPxTs5kXjpEgcZAWQi6QAUeYIdMWmKMY6jD5iCa0IpJJdrSEaccwHvhem1DlJgIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892189; c=relaxed/simple;
	bh=U6EE3pR4ibkVeqKbRMnIAYAZZFQxBl8uzWLe8pgelQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My/xde8rLdc2zVq8pEYspHcZBHN66KY8q1f0nfaMcO61tzOHhGXyKnEIidIGT3aX7shfZ9srhklFzQjsaUw/S6le9GtSaG53y0E5OK7zxKKN/e4xlUwAUYfva/froimSr03lc3U/p6GyVz8v8uE9hpyg5NIYSZQR+WD99P0KJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vBzLPJDu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vBzLPJDu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MqhwZEiU0O87hDj7NuTqXSnZymdMsyPQ6KoUmm7ksBY=; b=vBzLPJDuszdBsXQVsfaYBxJKuB
	GvklbB7VaNLdvBWb7pMG2oE9XwNMqHuTbCkoewPKcMX2F8WH0+lzHqTrMsvVITd6Qv1Gj1MW1Oq4t
	BLAdQKJVaNFcE1bFaD0VHD8jyFshkS++r0nL/hGUvIF9SSc5P92sDEccT84k8Gur9Xxcqx/Jqno8c
	3HywMnrv0PR0v99nVMbrWlfEz1Rk5RY+B8j+LCPRGObZUkuUvRGuqiJMwu+7LaGYCdo92P8BoyMir
	pz9i14eUQ3aF8h0t7ofvu/HTpQe4EEliTPrQJZARjvnlHEDQwcszI4nbkNTjFfSHUaQHPpNfN0T44
	H2yHl5ew==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFGL-00000002elH-0RfN;
	Wed, 27 May 2026 14:29:37 +0000
Date: Wed, 27 May 2026 15:29:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/34] buffer: Add bh_end_read(), bh_end_write() and
 bh_end_async_write()
Message-ID: <ahb_0Dc0Zqr9pGVx@casper.infradead.org>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-5-willy@infradead.org>
 <sfdgf57x2oa3f5hn5izgdiomkgzwoiyqunborxtyfvtty2tlfo@oa6lvhzjrqic>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sfdgf57x2oa3f5hn5izgdiomkgzwoiyqunborxtyfvtty2tlfo@oa6lvhzjrqic>

On Wed, May 27, 2026 at 12:22:27PM +0200, Jan Kara wrote:
> > +/**
> > + * bio_endio_bh - Return the bh for a bio
> > + * @bio: The bio
> > + *
> > + * Call this in your bio_end_io handler to retrieve the buffer_head
> > + * submitted in bh_submit().  If you did not call bh_submit(), do not
> > + * call this function; it will return garbage.
> > + *
> > + * This function consumes the bio refcount which will probably free the
> > + * bio.  You should retrieve the bi_status before calling this.
> > + */
> > +struct buffer_head *bio_endio_bh(struct bio *bio)
> > +{
> > +	struct buffer_head *bh = bio->bi_private;
> > +
> > +	if (unlikely(bio_flagged(bio, BIO_QUIET)))
> > +		set_bit(BH_Quiet, &bh->b_state);
> > +	bio_put(bio);
> > +
> > +	return bh;
> > +}
> > +EXPORT_SYMBOL(bio_endio_bh);
> 
> Frankly, this looks too fragile to me, in particular for an exported
> function. I'd prefer this returned the status and have another argument
> where to store bh to. 

Heh, fair enough.  An earlier iteration of the patchset did this:

+struct xbh bio_endio_bh(struct bio *bio)
+{
+       struct xbh xbh;
+       struct buffer_head *bh = bio->bi_private;
+
+       if (unlikely(bio_flagged(bio, BIO_QUIET)))
+               set_bit(BH_Quiet, &bh->b_state);
+
+       xbh.word = (unsigned long)bh;
+       if (bio->bi_status == BLK_STS_OK)
+               xbh.word |= 1;
+       bio_put(bio);
+
+       return xbh;
+}
+EXPORT_SYMBOL(bio_endio_bh);

and then the callers did this:

+void bh_end_read(struct bio *bio)
+{
+       struct xbh xbh = bio_endio_bh(bio);
+       end_buffer_read_sync(xbh_bh(xbh), xbh_uptodate(xbh));
+}

somewhat patterned after struct fd.  But I decided it just wasn't worth
it and revised the patchset to have the callers grab bi_status
themselves.  I did consider both returning bi_status and returning
a bool (ie the current uptodate).  Do you have a preference between
those two options?  I'd probably go with returning a bool just to make
the conversions easier:

bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp)
{
        bool ret = bio->bi_status == BLK_STS_OK;
        struct buffer_head *bh = bio->bi_private;

        if (unlikely(bio_flagged(bio, BIO_QUIET)))
                set_bit(BH_Quiet, &bh->b_state);
        bio_put(bio);

        *bhp = bh;
        return ret;
}

> Sooo, when going through this rabbit hole I wonder whether we shouldn't
> rework how async writes work for fs/buffer.c. They are used only by
> __block_write_full_page() (and one place in gfs2 which IMHO could be
> massaged to use __block_write_full_page() as well) and the only difference
> from "sync" writeout is that async writeout also takes care of the folio
> writeback bit. What we could thus do is to chain all the bios that are
> writing out buffers in the same folio and then complete all buffers in the
> folio and clear folio writeback bit once the parent bio completes. This
> would be a bit more elegant solution compared to the logic in
> end_buffer_async_write() playing with b_uptodate_lock etc. 
> 
> But as I've spelled out the details now, I guess that's for a separate
> series so I'm just leaving it here as an idea for future work :).

Thanks ;-)
