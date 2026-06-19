Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5833B83FE;
	Fri, 19 Jun 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888917; cv=none; b=b9++janurNj/W3ZIF2zKlz2MGr170DaLKRT+7rEXMUZid1bymioJbJMCapdaw2QgbJqqL41HNUWWGDM7erICAIpH9PUn9YrLIIAdsTtvmvW/GRh+z7ElKM9fG+Lwad10s6r+VjnjL4p9l7rvk2KJyRb6vaY3KQv69bQ4prkvApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888917; c=relaxed/simple;
	bh=gSFyUTSQCQY5vs7VfKRlVX2+O8jg+IdCcyNy1PibSiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu/ldvH3086HKlkZJ8mNQ8x5A/k21Cw3pCIY7dtisgyhldJLEFz82S1bzWULpGx+fjyUbO4UD4RTD/msl1auQdtrEI6lmJ33w6bvUCNDv2jgCoFUr4CHro4HTRluZwq9OS0aZt+SWNCjZEyGgJE90fCVe5/HVgnnBDaqW0r3cKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj7b6zPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj7b6zPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0285C1F000E9;
	Fri, 19 Jun 2026 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888916;
	bh=gSFyUTSQCQY5vs7VfKRlVX2+O8jg+IdCcyNy1PibSiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tj7b6zPmYnN41mwKxXh1WftVElB0s9elgh2RAbdMpaKYPseRUwwUPcNtUQqL4PIex
	 pGQT4BmMhMmy6rImlTB+6AKZF4RF6KUhrINF7CNWUWz6OOd3NoFLU754zj17tXZEe+
	 TeFBEQYdseQcCrTr1p5QH7PoJp2oxq/FyU8o2V/usMZ3+9EeEz57hxOeWrcn+bi2kr
	 pQBCsMWCwS9h1NyyNMd5ZPTQmPih/RvQYpxE2c8veT8Y3B82+zOzGSDmfQr+VTlHLv
	 Bj0DN7CWSTcCWu+xnYEEltibAMieD/uGakEU4XI9rs/fjPK2BvKtWc67B+Dkf6ke7k
	 70BbqEGz4MFxQ==
Date: Fri, 19 Jun 2026 18:08:30 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Frederick Mayle <fmayle@google.com>, Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajV3b02BnQdKK8bw@lucifer>
References: <20260619112852.104213-1-ljs@kernel.org>
 <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org>
 <ajV0TbwEyaKMzoa6@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajV0TbwEyaKMzoa6@lucifer>

On Fri, Jun 19, 2026 at 06:07:35PM +0100, Lorenzo Stoakes wrote:
> So yeah, this does not to be reverted, and as a hotfix sooner rather than later.

Does _need_ to be reverted :)

What an unfortunate typo... :P
