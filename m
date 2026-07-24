Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9820A5C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784871195; cv=none; b=EzBai1s9BG6rHFvPW9lzOjJikjrsEfHDFwbnNgwS+1+5hb9D4SAIQIf6ul5qa+N/Ic/av1BxOBZpbB4kexGnnCfKnoUxWI7U/Wx6yIOmvBEjfRRWtiLPa7cG5nE1xkY0l9o+L2S3qgB/cnggnDTk24/s82TTHqwhqFSwGfqtb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784871195; c=relaxed/simple;
	bh=HbzZVZaBivAGG8cy69F9Z4XwOSC5tRsBXMF6kCv/+uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1gweUjB0tLbpI5bYcrrRntE6alUR2MlqNYqBd/GNvniIBrQEKz15ummLExX03dgVOF8QeCNkJqNEUwJxkDVQanGKNQEJYyBM45kFbR/6xFL+Z8F58W5T1FYnr1KWQDpXpSs7YbA2ZZ8wk/Tq7LacbFGURs+Z22i29FZxVFxFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47C0C68BFE; Fri, 24 Jul 2026 07:33:11 +0200 (CEST)
Date: Fri, 24 Jul 2026 07:33:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] hfsplus: add iomap-based file_operations
Message-ID: <20260724053311.GF4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com> <20260722213759.1360225-6-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722213759.1360225-6-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 22, 2026 at 02:37:57PM -0700, Viacheslav Dubeyko wrote:
> This patch adds fs/hfsplus/file.c with the goal of
> moving the file related operations from fs/hfsplus/inode.c.
> The hfsplus_file_open() and hfsplus_file_release() have
> been moved without any modifications. The hfsplus_file_fsync()
> no longer takes inode_lock() itself, because taking inode_lock()
> here would deadlock against callers that invoke fsync while
> already holding it (swapon()).

Please split the pure move into a prep patch and then start modifying
the coe in the new place.

