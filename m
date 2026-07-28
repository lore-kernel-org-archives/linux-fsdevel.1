Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74EA30E82E
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211139; cv=none; b=peU2znsvpa6RlgnkKbK++1O+UqqcmTiiKpvZI+yShMxFbzzAKnZ0VgFkOb8ltu+qlGKNyjvxVfTs8WS2pkPj4JWJgt4V5Fv9n6NPOv18RkOGh0uaj5/a1dxZaZEHdwi6emhTvQF5o2NLFeRVLPtRXslDYxu2pX57tD7Vof7jfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211139; c=relaxed/simple;
	bh=S7dIM9k7CnK1l1eKx6p0craoR5vXdiCmS7Zbc6v0jXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8A/Z/9q+iNJcL1+fIdUeDNhE1OUhlZSm5WPtrxrNgsvvuLBUja9nS02TeOcM9LR94zVkmKhsvRIgwRnF8sASJvRYh9OOof0RfAmCNEgNgGCTfF/g+gwwi2nNPdhLqfRE3qKOShkbebHtd9wfEODLb7tQf1StDu48G/mD4ZGXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46E5168B05; Tue, 28 Jul 2026 05:58:55 +0200 (CEST)
Date: Tue, 28 Jul 2026 05:58:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christoph Hellwig <hch@lst.de>, glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com, linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 4/6] hfsplus: add iomap operations for regular file data
Message-ID: <20260728035855.GB19357@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com> <20260722213759.1360225-5-slava@dubeyko.com> <20260724053229.GE4181@lst.de> <78cb029e014d9590463729c43519b647f3a38dd3.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78cb029e014d9590463729c43519b647f3a38dd3.camel@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 24, 2026 at 12:45:14PM -0700, Viacheslav Dubeyko wrote:
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + *  linux/fs/hfsplus/iomap.c
> > 
> > Please don't put the file name into the file itself.  It is pointless
> > and prone to get out of date.
> 
> I am simply following the driver context. Other HFS+ files contain
> this. I can remove it, of course, if you like.

Yes, don't add it to new files, and remove it from existing ones if
you have to touch them anyway.

