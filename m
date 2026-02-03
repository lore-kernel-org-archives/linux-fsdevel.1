Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACB366546
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096753; cv=none; b=JFcQIEV/9GmE5DB4zD5/QQH8jwK5U7Gs8vAPtdohsrotr/gjH1IYEXLYzIiLF5MEbTfGYXEvB14KiDkD+UyU1beT2OkR1d1b8ui26uIt9ZjR3zqyDWagAo7kshK0r9DYhzUVRZbhgf9WhjoBtpA1mK/fk/ozU6F4lizDfJYhTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096753; c=relaxed/simple;
	bh=fs/NRSNAuw7Zu4gJ1VEptU0JD85IwsG2goAuMKdkTnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6U3mqTB48LPQ/eI+BXpEMX02k8AeYkUWNASCwoBWHbAxReA6M2nqypJmSBx7F7DMI/6TA/9CSLRV3LWkxLnmHJjRXg5x+kZv9yG2eRc4SgqWpAH/ngZoaQw7cItKsEDwxrxFMMQvvfl1XEDqbuw9F9rHl71MHg1r7imcUj8LaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88D1568AFE; Tue,  3 Feb 2026 06:32:28 +0100 (CET)
Date: Tue, 3 Feb 2026 06:32:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] fsverity: add missing fsverity_free_info()
Message-ID: <20260203053228.GB15956@lst.de>
References: <20260202214306.153492-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202214306.153492-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 02, 2026 at 01:43:06PM -0800, Eric Biggers wrote:
> If fsverity_set_info() fails, we need to call fsverity_free_info().
> 
> Fixes: ada3a1a48d5a ("fsverity: use a hashtable to find the fsverity_info")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Looks good.  It might make sense to fold into the offending patch to help
with bisectability, though.

