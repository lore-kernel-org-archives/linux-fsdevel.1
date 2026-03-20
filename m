Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1662DC76D;
	Fri, 20 Mar 2026 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029225; cv=none; b=T/EVP8zslsuenHlK4ekfebPt8pUzemaCGlN+mte2Tsf68l2G8gxUdqUhid+vhtby/Pq5H3fEOf5xfEEL7lH4/dM4HFTeLGZ+mKAf3z67UkFwcx6VXMELk4yEX0c3Snco3SR3Z6o10T5y6v45eBNwAvE11RBuAeoNxc4ePkJAKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029225; c=relaxed/simple;
	bh=h//oGyLG5CzZJ3ZAYHDx9XZrR0UhXsRRj9FiPsHwWsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtmJqt1d9dd7TLMI5pjvQAXjo3DxAENqh4P1r6mzijSHDBjAcBsbeW3eFUQhNGf3QgXXGeTn9zXSjzaN0en0XP39jVWIRyMJDzq5RJl73+Ou0FU6meIzAH5ysPExnSQJLGsxWky5JXghyN5bzoxXxjAt3RAKFmt5pkV9r92DVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiEYv2bo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiEYv2bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEBFC4CEF7;
	Fri, 20 Mar 2026 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774029225;
	bh=h//oGyLG5CzZJ3ZAYHDx9XZrR0UhXsRRj9FiPsHwWsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiEYv2bopFQyYcQTTmao16YHY0s25gTILH0j4Uo/jjcc1jQYIeERrtFpWhHUC8llk
	 1Ivpn0/V4XRXI/ebxqkI+w00aHnOyD6OLBbLiioWe8ikCZxOgwcn6jUDJf9+zEMtY5
	 aerSNmGAA4+YCrYkPDAq+McY+vRNZRaSXuKlRMI1dEfKo14kPd6ELQOZ5s+lSKb6rC
	 twzYcePHq10w7+pUyb6m431OXO6YA+zEDvZ8pS9kgCmfGHwEyheiOGdNqBwvccPZef
	 s3+MOy8YdY+YCgiLvIZ36jeoG/NqOAQEMhcO19dFmHftXh6EO8syhFT2J9kmPnP8HT
	 NHD1pKtb4gA3Q==
Date: Fri, 20 Mar 2026 17:53:43 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>, 
	Eero Kelly <eero.kelly@dfinity.org>, Andrew Battat <andrew.battat@dfinity.org>, 
	Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/mm: add folio_split() and
 filemap_get_entry() race test
Message-ID: <6b087c27-a5d5-4f49-81e6-1204209b0c89@lucifer.local>
References: <20260319190409.294523-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319190409.294523-1-ziy@nvidia.com>

(-cc old email)

On Thu, Mar 19, 2026 at 03:04:08PM -0400, Zi Yan wrote:
> The added folio_split_race_test is a modified C port of the race condition
> test from [1]. The test creates shmem huge pages, where the main thread
> punches holes in the shmem to cause folio_split() in the kernel and
> a set of 16 threads reads the shmem to cause filemap_get_entry() in the
> kernel. filemap_get_entry() reads the folio and xarray split by
> folio_split() locklessly. The original test[2] is written in rust and uses
> memfd (shmem backed). This C port uses shmem directly and use a single
> process.
>
> Note: the initial rust to C conversion is done by Cursor.
>
> Link: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/ [1]
> Link: https://github.com/dfinity/thp-madv-remove-test [2]
> Signed-off-by: Bas van Dijk <bas@dfinity.org>
> Signed-off-by: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

No .gitignore entry? :)

(Just saw it flag up locally in git status)

Linus says don't remove, but he doesn't say don't add :P

Cheers, Lorenzo
