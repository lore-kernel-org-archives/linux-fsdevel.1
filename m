Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A913909AB;
	Tue, 19 May 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172762; cv=none; b=NEUjmQ1pwrNK9X/mlIMj8D1uJB8wUApupOJLXjx2VGTnFK1W6bHVzhX6l7hhtiCtPQWtK8VPxYfldoPvlXWgOt7iPDojsxvVBBKMZSpoT5oQcU7Lc0pVWZdCX9T6k0TXkbwH/xZKH7K5C9dBR3S0QmsTnGxa4+cBRCnnxz5twp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172762; c=relaxed/simple;
	bh=KUZTR+SH0jixxrilW1KEm/IFWAbpQsxHtrVzuRpnmxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZu+FqDyGa8LPyXAjP8i1LhmQGef86+0dgR9CeGZfxTgFuWl3vRgQzjkPdV1lSzt+GKuofHyCrYH3YC8sYvoXmudPjzxMyLjW0qCLPYu6NzMAdEasXTvGpJ2009TJ9Hn641lDD/eg1xAsxH49K+xAfPy4ZchvJNtGIXEpjm1+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1nMUS+u2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1nMUS+u2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ekkueEbKjoJ5ZcmBfTn2kbworqdQev5OvGeeGiZpqXc=; b=1nMUS+u2ccmBib9tSNIYywxfu5
	xRDQK/03CAPPKghXgMhuu2ZeenqK63qusqx2i4Dodb1yqzFXYDdw3lplYIlv/LU97QRefQe6AiM26
	pgAENic7w8SIDcZYDa13uatQWoVJhaDovVrx950oVoDVibkJCQFD1IlwUKzrNnXYvl9Wu6jvBs9/L
	Kpe38PL56s/e1ONIVxfP84EU+gVmWV37QIy2JCtg8kZh4tP2Qhi3yCh8/AY63pjWjRLzdW28+9J2w
	geUqYQE4R8ip3C0kmm4kgNfZjBu7P/TbfnmsnqiD936ohg82DxXcJW2Li2TQazCo22+VNIWwQFfDB
	0in/EcPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPE6m-00000000NAl-0lq7;
	Tue, 19 May 2026 06:39:16 +0000
Date: Mon, 18 May 2026 23:39:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <agwFlBKvKytjURDO@infradead.org>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 18, 2026 at 08:59:13PM +0200, Jann Horn wrote:
> I feel like a sysctl for "disable all the splice-like interfaces and
> zerocopy TX" would be reasonable to have? Either by blocking such
> operations, or better, silently downgrading all such operations to
> normal copies.

Yes.

> FWIW, vmsplice() and splice() are also weird in how much memory they
> can implicitly pin - if you call vmsplice() on a single byte in a 2M
> THP page, I believe you'll implicitly pin 2M of memory...

vmsplice is the worst, as it is one of the few remaining places that
can incorrectly dirty file backed pages without telling the file system
and cause the other problems fixed by a FOLL_PIN conversion, but it is
the only one where we do not have any idea yet how we could convert it
to FOLL_PIN due to the unbounded pin time.

Note that we sometimes use splice underneath other operations that do
not have these issue.  The most important one is sendfile, which has
very clearly defined semantics avoid all these pinning problems, but
there also are similar in-kernel users as in nfsd.

