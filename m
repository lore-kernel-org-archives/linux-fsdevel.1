Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD93E49ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711038; cv=none; b=VUF0nwa8mTfX24EYbQIy8EFu7iqUAbEs8V1U2SAdHGJZZJI1becC36eh1xOgFO5JYWPF6sx+Lq/KRD8vQdnyy/Oj7LLB3UnxvL9DlZSQVsaUORAEDEpIIQCcT4qRsn3VfL2no1uod2/h5JXE1YhW7aXBrIqm062TYVjgDtYKYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711038; c=relaxed/simple;
	bh=syoZwRDh/gaF8vgV2NndNNQ20cGT2fXrPd1J62aQTGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC4GhXg1jRV9pqNHxI9z8ZSEudqRDbNGdCpc0eeyTsvViVSywL4XH0zAxVA1i6SEOXUONIxzySBLg2m6KorFnI8PwB9WAJg0k+xDKQzVU5qVG/xS3oN6wlxzLXfd96/qoyTBxm3RqSGGLLIy6u5/MuyoEsYTrh8W73Fs95g27ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C861E68C4E; Wed, 22 Jul 2026 11:03:50 +0200 (CEST)
Date: Wed, 22 Jul 2026 11:03:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: changfengnan <changfengnan@bytedance.com>
Cc: Christoph Hellwig <hch@lst.de>, Joanne Koong <joannelkoong@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>, David Sterba <dsterba@suse.com>,
	Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 00/20] iomap: convert to in-iter iomap_next() model
Message-ID: <20260722090350.GC30516@lst.de>
References: <20260720210202.1163861-1-joannelkoong@gmail.com> <20260721142842.GA11935@lst.de> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.7d28bf40.2201.47ab.bf41.5b700aefabf7@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.7d28bf40.2201.47ab.bf41.5b700aefabf7@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 22, 2026 at 03:04:24PM +0800, changfengnan wrote:
> Hi Christoph,
> I tested the simple direct I/O path and did not observe any performance
> degradation.

Thanks.  But no improvement either?

I'll respin this to sit before the iter_next conversion and will
send it out.

