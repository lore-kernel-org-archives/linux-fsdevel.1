Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B7378D8A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870899; cv=none; b=UMopDrNiJUXv+WjJN+QRVARg+lvvMmWc6pxVzZrb58K2BkaFR9qeZevw8YVcJi61XU+K8Dm4R3dVMH3AjeVxp47IT3bfoPNJV05DjQ8a7/PlaDWWqK4EjYm5lU0iICeh711zzy62T70OkV77G/3tr5SYnNfKyssPzLueq15rn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870899; c=relaxed/simple;
	bh=SSSHiRRLfShUvgGItYon+Fp0FEuAO8rMSJKexcBdqCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlzrWteXVGKBs1SAOOIv/L+7oCqfu2WK+sZeH7rz0UxsDyYnLPoLCJRioN6vYhvJ/toORNZUUqcf+uEqmYugB4qTuUGNky6GXepOxofjLC8v/Z8xw2IoXcS+2WLEgJDxi7BdGbEA30KPf0vbbJjJ7xUPqgHdPWquVB5JeEaOfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 360A068BEB; Fri, 24 Jul 2026 07:28:15 +0200 (CEST)
Date: Fri, 24 Jul 2026 07:28:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] hfs/hfsplus: exchange hardcoded number of extents
 on named constants
Message-ID: <20260724052815.GB4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com> <20260722213759.1360225-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722213759.1360225-2-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 22, 2026 at 02:37:53PM -0700, Viacheslav Dubeyko wrote:
> Replace the magic 8/3 fork extent-count literals with named
> constants (HFS_FORK_EXTENT_COUNT and HFSPLUS_FORK_EXTENT_COUNT).
> No functional change.

A typedef for an array of struct still looks a bit odd, but removing
the hardcoded constants is a good step:

Reviewed-by: Christoph Hellwig <hch@lst.de>

