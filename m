Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418CA3B9DA7;
	Fri, 18 Sep 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738271; cv=none; b=m1Mf76P79HyHLAMksYFhb5BTR55bv2LDEV/FzJXKFtdjk4ywzD6jFOMueVKUzZESmzqHPDJbSelW99nNpP+PAodc+BzicL1rkRYRg/7bZmsnifzLmx9eGIpFMejpiQSUclxvz+qnNpJqxXqeyZL7j8lw1u8MkG6fS7QNDBR1/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738271; c=relaxed/simple;
	bh=3vosCxbuDdGnpZxRwAwGdZ4aw6CkydFOdU6u/2e2YeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcrL6uDS4JK3bWAqr6WcARwcaXg4aTlZv+pxM/uyK0Yuv0u6HrLMtFEmaAPpd++Aw7WynEJXUAYBBtYltu+KbQ12aLcbFwxYX9bWsIhgKJh7F1wSpXq5qdHR7vHBjhoGQRJnaUP5wzRYxyOcxqffFehd+xdb1vrTYJGo5lD8jHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3CE968BEB; Fri, 18 Sep 2026 15:31:06 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:31:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH v4 5/7] hfsplus: move file related operations to file.c
Message-ID: <20260918133106.GD18107@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com> <20260914233941.2966421-6-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-6-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 14, 2026 at 04:39:39PM -0700, Viacheslav Dubeyko wrote:
> This patch introduces fs/hfsplus/file.c and moves
> file related operations from fs/hfsplus/inode.c
> into the new file.

Looks good, but I think it would be much better to keep this before
adding any iomap code.

Reviewed-by: Christoph Hellwig <hch@lst.de>

