Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3F390CB7
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358047; cv=none; b=q8hKswFubwJTbOew8E1ms3MUL3+1AOFIu7S3c7oCaPn3/TcBF9CXjHpENT/Gf9Dohmd78YYozPttiqeStqCTNkzDfp/ZO9A7QF6RfGPpvFSKQ13qyB60eQ5v3Qd9vBJP72G7SMRDCSRvJ7KLtynPhBxmy9PQ3PO1ExiU/5q7/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358047; c=relaxed/simple;
	bh=/dAzJGgdmVQA6LkA6mNbjM5l8nBmNiNRguIh7usWb1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsGOD5cwWkpAfiewXFVR00mbSBdFTvAyYJVVdefsqMZyxtOgY/9xGVf+27Nc7xEWC29w+LrVwpE6jVQ6rAWgqvox9uH3u4d9tSOLO3iG/yqhXwouX8iv9IymOIUeLHrS3bZO3IwcR8SST4jXrMuX2zM+qKPcjuu3NbDuTkaMhqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7806C68C4E; Wed,  2 Sep 2026 16:07:20 +0200 (CEST)
Date: Wed, 2 Sep 2026 16:07:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Matthew Wilcox <willy@infradead.org>, glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
	vdubeyko@coreweave.com
Subject: Re: [PATCH v2 0/7] hfsplus: convert regular file I/O to
 iomap-based operations
Message-ID: <20260902140720.GA23855@lst.de>
References: <20260826225614.486112-1-slava@dubeyko.com> <ao9_az3JPNhHooMl@casper.infradead.org> <e865789c62b799baf43a2afd67c67302e3eaea25.camel@dubeyko.com> <apCQPaalWMaB5D-p@pedro-suse.lan> <a7b30d5e625da9cbb4a888e31a81df03d37ce91e.camel@dubeyko.com> <apV-epG6dtc71Fgt@pedro-suse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apV-epG6dtc71Fgt@pedro-suse>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 31, 2026 at 02:21:48PM +0100, Pedro Falcato wrote:
> > And this call could take place concurrently with
> > hfsplus_block_allocate(), hfsplus_block_free(). The main goal of
> > folio_wait_stable() or folio_wait_writeback() is to prevent the
> > allocate or free methods from accessing memory page until it under
> > writeback.
> 
> Why is that a problem? Racing writeback is fine for most block devices
> (those that aren't have bdev_stable_writes(), thus just doing
> folio_wait_stable() should work, I think)

Because file systems really prefer their metadata to be internally
consistent.  At least in a given block..

Same reason why buffer_head locking also doesn't allow modification
while the data is under writeback.

