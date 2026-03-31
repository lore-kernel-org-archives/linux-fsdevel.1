Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C740DFCA
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935991; cv=none; b=ijqNxPqP5yeb6omWSQBIqq2P8ynpDZwhUpxENSt1NJaD07svu6uTirZ0dsjAHcG24EDT5Z4JmkUavGNAE3TovLuxpR+tQHJCu+Sd8zjAMBOm80EDVQcWaK+uWPFVv/0WAei45D7QGKGHfxW6+/r9Dn/OkBWHmpR03B0hfFv/p70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935991; c=relaxed/simple;
	bh=SMQ8Sxi3RYNkbeYMjt5U2Q0++YFu1+Y5xYQoQ7Q1W+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azxyjXOoN1Ie6RThsm4S0yXhMRGUOTl3Ccb06HCPWIM/KsUusl4aTgPlx805Vd7Z6Dt3A0f5q8BExe9Qh2dYDNGmn59KcJ1x20PsF6a6MWjFON+b6OdxCe2HlJOBT3xD7t/K+qoW5xNQgfvCzu9eFslad82JXbNxn8mWT16CCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D7DD68B05; Tue, 31 Mar 2026 07:46:16 +0200 (CEST)
Date: Tue, 31 Mar 2026 07:46:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
	yuezhang.mo@sony.com, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
	chizhiling@163.com
Subject: Re: [PATCH 3/5] exfat: add iomap buffered I/O support
Message-ID: <20260331054616.GA31506@lst.de>
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-4-linkinjeon@kernel.org> <20260330063821.GC5897@lst.de> <CAKYAXd9pZx1g=53wtCh0xTVYgQCLNz1sEL-2-fHbkSHQ=qTiTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9pZx1g=53wtCh0xTVYgQCLNz1sEL-2-fHbkSHQ=qTiTg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 31, 2026 at 02:22:57PM +0900, Namjae Jeon wrote:
> There is a deadlock issue when using iomap_dio_rw(). In
> exfat_write_iter(), the inode lock is held while calling iomap_dio_rw.
> generic_write_sync()->__generic_file_fsync() in iomap_dio_complete()
> can be triggered, which attempts to acquire the inode lock again.

Can you document this?  Note that Jan has looked into __generic_file_fsync
and decided i_rwsem isn't needed there.  So maybe as a first step just
switch exfat to generic_buffers_fsync_noflush, which doesn't need this
(or way if/when Jan's series gets merged) and keep using a generic
version?  If not document in the commit log why this is changed.

