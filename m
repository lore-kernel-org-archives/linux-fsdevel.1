Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826428030E;
	Tue, 27 Jan 2026 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485711; cv=none; b=jInoGJ6p+0373mq+K1ydyspYz9Y8nsa99uRkV04VabtlRA3oimN9V1Q8dG1blquoo7F9gCyTHIdTiVanThWW0B2pivu3QGGS17Tu80/9rjexAjF2oXT3zbvtLHehbjkrDVg5MyWohNDSN/bvD3aaRyUKjfWECUslFIqzmZM7HBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485711; c=relaxed/simple;
	bh=WGjFBW4UN91d6sFxGyKPtDlxiJ4aYX6kwreoynEpBAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtxFJsy9bAB0EnMMIp3xmhSLnmnQ+DCqrPvCb9DoxA5Llo6tolyZzJiLCYfUv8wr3w35xtjRC+P2M+vAmg41WRwWPfL9MEENTJ+IPZjsTe262DWYKhaNYU2zMCpDpO4Y6mGp/nYVZhEcvC5u+Oc8U/hNMvLXhB+rUPHYh+PnMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hjeMWgTV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjeMWgTV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WGjFBW4UN91d6sFxGyKPtDlxiJ4aYX6kwreoynEpBAY=; b=hjeMWgTV22fZUAZwE27itRCxD+
	rtlt+wm6zSG+VYG0E2W4hr5sbzO39jo/6PcHISQJY8DsF88UdFJTrqUlsxcZaelxUOFnWDzqq2xBI
	astHLOsQfRU41v6TnSwweoNASgKosrwY8Ca+WaRqM0oWlbVnqCyk5WB9ltnrXc5ftd5bErplyNLCx
	hpYaRtJTdIe14VuIK/Wd8InP12+FAhgDccCrlqQKSeEry8IabZcB4Wc2u16HCKLnQPqko2hIkqAv4
	5wFfYi++r39VIc6ZsegNDsgVPTtOfZj1UnmIHudFxSmuKPkax55lhOu2S7TqOsB6g7pGyqgRFV2Jp
	/aDpQT6A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vka3w-00000006sUP-48dQ;
	Tue, 27 Jan 2026 03:48:21 +0000
Date: Tue, 27 Jan 2026 03:48:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	dev.jain@arm.com, david@kernel.org, janak@mpiricsoftware.com,
	shardulsb08@gmail.com, tujinjiang@huawei.com
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
Message-ID: <aXg1hHkvHbd62W0z@casper.infradead.org>
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
 <b2b99877afef36d9c79777846d19beeb14c81159.camel@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b99877afef36d9c79777846d19beeb14c81159.camel@mpiricsoftware.com>

On Wed, Dec 31, 2025 at 11:59:42AM +0530, Shardul Bankar wrote:
> Hi Matthew, Andrew,

pinging on december 31st is an entirely ineffective thing to do.
for one, oracle is in shutdown.
