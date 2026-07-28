Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4E30E82E
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211102; cv=none; b=CiMvODyjSZTKf9L8VhedPirn+2rdAHDigw9KdbDR0arEOYQrfVAusbfUNTENDkW4Vq+QFLvUOTs21iQxBaNuewn/GqI+MtQp2Iag20Jm/1WokP4Hx/8gCM0KlAUoeZ7z4CQlfcmaksi2udoKFiQCCAhKz+30iWx/ukI5ek7OQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211102; c=relaxed/simple;
	bh=+X51fkq7n8tFpYgUXiGf7fSPgSYP+Cez078+EXm9TiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6mCJe7q6LpH0vws5lVZB4laNBZ+YXaGtMvTA74RcXNcaX0c1uQ7fobTdKnIVA7ZW2bcw3xE4NLh2U7X1MUt7CL4SDOksOQmQLtR+q230bZt/Bq09YyxqvcbmqfMR3+QH9Dl/sXEoUUJzWat+v4tZK5isC+oMQv9wLogN0e84hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F40E68AFE; Tue, 28 Jul 2026 05:58:18 +0200 (CEST)
Date: Tue, 28 Jul 2026 05:58:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christoph Hellwig <hch@lst.de>, glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] hfsplus: take the bitmap page lock for
 allocate/free
Message-ID: <20260728035818.GA19357@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com> <20260722213759.1360225-4-slava@dubeyko.com> <20260724052931.GD4181@lst.de> <f532f95937e8a5123ac07a796bc5aff40c2ffa40.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f532f95937e8a5123ac07a796bc5aff40c2ffa40.camel@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 24, 2026 at 12:40:36PM -0700, Viacheslav Dubeyko wrote:
> > You are still unprotected against concurrent writeback, as writeback
> > drops the page lock before writing the data out.
> 
> 
> Yeah, you are right. As far as I can see, the sbi->alloc_mutex is the
> main mechanism of synchronization of access to Allocation File (block
> bitmap). And I see that hfsplus_sync_fs() doesn't use it during
> filemap_write_and_wait(sbi->alloc_file->i_mapping). Probably, it should
> be used there. Let me double check it. What do you think?

I don't really know what scheme hfsplus uses for synchronization here,
set mapping_set_stable_writes on the btree inode mapping and use
folio_wait_stable after locking the folio.

