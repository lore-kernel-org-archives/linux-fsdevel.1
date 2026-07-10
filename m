Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039DA37996C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661502; cv=none; b=RBVI/cvISM23pAixHJ6rkmdsrGAexhNQb/9K0jdMbDtYtRNc1ryq5tsvXmikCfSQaXY7SJNry616oCLwx0e76Lc6j1XzTCHdUEPEVVvlwEQFOo+iKqN36LdFfHeqrcEZfIwlYoKNDMYQt4BzDxaxmo4GWm5IKosqRpfIo2giECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661502; c=relaxed/simple;
	bh=VqmF9GI0gTmQqhocRD4jnduOyMUTDUd2GQMosZW84xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqtJ7mO7madlhBFKsJyO2aPwSLqDCIj+iGx9ReO8JuQTsna6PGsTlOlk0Rw+OIbksyHQD/DOuQhiWdc8F8knO1+jL3gH9nk9TK0p0tPqg6SPPai9/uWhT450c3Al3t3T1E/iGBsn6TIJzAU9DfzldyplionC9f796sd737/5Mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X+ii2uKz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+ii2uKz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m+7YlcxqEgwEdrHeKrNcCIL0I5xbqVzC15C+6HdBVE8=; b=X+ii2uKzRDuJX9v0OhzYIzEsEE
	78BCl2tXMqVfj/iCo3TW5XKXMmQfJsuFd2rgviuyhHVPpLT6Z9LECY0LfgoH+b4D37APC5BkMfCOd
	yAAwqCn10Xtta0zT+rWsbhs0RPexuEFJ2EyFScvtjYbS8JS9LeDr7LQj4LJfof304vDBqEDkGTsnr
	Ggi87xaciHduEFm0vMs7WO9wCb1onVjA6MQfpodNHDtZ3F3QwcPs1aalXQekh/1ah+AxslFGvDUzu
	f83PqOfvjIcapJGVUXfndNOdOqkKcehNoA9Xi7OwAXySpZKuqhQv+fVrbnhGR7HQdjhLUSco5N9kP
	yfWzy0mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi3ps-00000004Cdb-17xn;
	Fri, 10 Jul 2026 05:31:40 +0000
Date: Thu, 9 Jul 2026 22:31:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fs: refuse O_TMPFILE creation with an unmapped fsuid
 or fsgid
Message-ID: <alCDvIW_8L6J99__@infradead.org>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
 <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
 <akju9Nag-jhIoVq9@infradead.org>
 <20260707021838.GB9368@frogsfrogsfrogs>
 <20260707-villen-clubhaus-postleitzahl-60a67025879a@brauner>
 <20260707-babynahrung-gruft-sirenen-6e791a5f086c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-babynahrung-gruft-sirenen-6e791a5f086c@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 07, 2026 at 01:20:51PM +0200, Christian Brauner wrote:
> On Tue, Jul 07, 2026 at 09:20:48AM +0200, Christian Brauner wrote:
> > On Mon, Jul 06, 2026 at 07:18:38PM -0700, Darrick J. Wong wrote:
> > > On Sat, Jul 04, 2026 at 04:31:00AM -0700, Christoph Hellwig wrote:
> > > > This commit causes failures in xfstests generic/633 generic/696 and
> > > > generic/697 with messages like:
> > > > 
> > > > utils.c: 948: openat_tmpfile_supported - Value too large for defined data type - failure: create
> > > 
> > > Seconded, I also see these test regressions now.
> > 
> > Yes, that's expected. It needs a fix in the idmapped mount feature test
> > portion. I thought I had sent a fix for that though.
> 
> And so I did:
> 
> https://lore.kernel.org/20260615-overlay-idmapped-vfstest-v1-1-c6b3b2228092@kernel.org

It would be good to mention the test suite breakage in the commits
insted of leaving people wondering, e.g.:

This breaks xfstests foo/bar because it makes wrong assumptions.  A fix
(will be / has been) posted to the mailing list.
