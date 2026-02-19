Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41481D555
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 04:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771475012; cv=none; b=hOnZQGDyJ6+rJiE0W+TWH7zZzaTnK26qOfE7bLE0MMyxW2xchSW20BZgeHgY4Y3pAqmXeKsg0uh6z1VpErqawZfS/Dp+dvQ0y7ZjbdU1gbexckDtSd8YVMNh4snsdkMeL5hj0zewp55OxJz3mptPHN+Mha7hBk0HoopS6htDuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771475012; c=relaxed/simple;
	bh=ZuRKUb7dsiZra7zctPqNon23MQouBzd+SnNEmoJPUFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2IS7UL/T5hkc8gCwHi1INcMkdrDMIkbgBmuztLizJ85OU6q1JMgc4H2JX6xlL3d+aNPTLC/2qGSl9gBSPMI1By+B2stVIldp+V0wSmdDbzy8w5/fbVP2+bGCPCgVhq0Hp3v9z0dkTT3xpP8JkjQrtfAqa3XukF96iISAHrTx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=To/hbeNt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="To/hbeNt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GH52e+A0BBW0wZjieGvTJweniCefo2rkdMskInsY3sU=; b=To/hbeNtvkw2lyK5ikMxTfGnAw
	hTT1iC5uoGkcBO0HKOsOv6Y/EUwfNxA6hzkHtnUUSt/pBkjoirrXS93+AXdpe1zEahvGPYEHMsE6U
	YRx5XvJ4YSJs8RjsQtOrz7v8VLg7xovZ0VP6kNPvZdlAhyJBpdrMm1zBkGACKjrh9eb6LuTL3sHDX
	4hoiZRGXTUK0EIeIroblm4xg3tYs4eD87dW5baSBurdShsTOw9E9nQAyTWyDfBgkqlql0DOvtJkxd
	2w+XeLYSfa/NtcS9O+VRDH8Vz6p86ftlStz6pU1F9U0tqzGaVoIWkfeqsJKO6rTkwHdaftRndIObh
	d8JRgzIA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsvZT-000000076C4-4C2X;
	Thu, 19 Feb 2026 04:23:24 +0000
Date: Thu, 19 Feb 2026 04:23:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	wegao@suse.com, sashal@kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iomap: don't mark folio uptodate if read IO has
 bytes pending
Message-ID: <aZaQO0jQaZXakwOA@casper.infradead.org>
References: <20260219003911.344478-1-joannelkoong@gmail.com>
 <20260219003911.344478-2-joannelkoong@gmail.com>
 <20260219024534.GN6467@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219024534.GN6467@frogsfrogsfrogs>

On Wed, Feb 18, 2026 at 06:45:34PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 18, 2026 at 04:39:11PM -0800, Joanne Koong wrote:
> > If a folio has ifs metadata attached to it and the folio is partially
> > read in through an async IO helper with the rest of it then being read
> > in through post-EOF zeroing or as inline data, and the helper
> > successfully finishes the read first, then post-EOF zeroing / reading
> > inline will mark the folio as uptodate in iomap_set_range_uptodate().
> > 
> > This is a problem because when the read completion path later calls
> > iomap_read_end(), it will call folio_end_read(), which sets the uptodate
> > bit using XOR semantics. Calling folio_end_read() on a folio that was
> > already marked uptodate clears the uptodate bit.
> 
> Aha, I wondered if that xor thing was going to come back to bite us.

This isn't "the xor thing has come back to bite us".  This is "the iomap
code is now too complicated and I cannot figure out how to explain to
Joanne that there's really a simple way to do this".

I'm going to have to set aside my current projects and redo the iomap
readahead/read_folio code myself, aren't I?
