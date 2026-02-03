Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD24325488;
	Tue,  3 Feb 2026 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099731; cv=none; b=V/DwFHYT0fBKjMEHjauhERGYG8+AJ49EwNjwNhlMtvbInN6sT2r7A7GfwshVQdu4wqAQtNItDT+U7xWHAvT73bfafkFyO/Qi5lhCs+MUPVVyOwvx2898ttD7d2m/0reqA1xCJaowR/+CVSfI4nmFVeWkLKrIMcaYA8Rxoih1eP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099731; c=relaxed/simple;
	bh=9KzwuW/Z7SVptFEKrAmCTY1rjXgEAQGQ2sAD5m5a3fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOaTwDp05A18xpnJjEiIguR4/XpgtVq0ypQvup1Hkp3rNnUseD7NgdZ/j2b4y1M27CyzU43T0hJBLCb81rUZIrtTflt82cvwWW3BUV415pJavaLWXU56537paXOVxq7Axv/4EdY0+vui1ZN/pjtS2WUV7IsdVe2VCUNFPbqY3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C388468AFE; Tue,  3 Feb 2026 07:22:06 +0100 (CET)
Date: Tue, 3 Feb 2026 07:22:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v6 10/16] ntfs: update attrib operations
Message-ID: <20260203062206.GG16426@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-11-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-11-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Suggested commit message:

Overhaul the attribute operations to support write access, including
full attribute list management for handling multiple MFT records, and
compressed writes.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
