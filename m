Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62163803DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995978; cv=none; b=iYMZHwQ13FUzCxJqnMadldb3qUZwxJ3I94615XlKvtmaXuXxb125TbTlddbXFoKfr0g9gm2SMzKZPimd/0Lz+r6LmR5yHFEqcWUmyPIYgnCq097HoNJTqKfba0+FCC8Af0fY8X14fENm8xGmrFCxD6WlTAI4hMOK1t8e1eA8y24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995978; c=relaxed/simple;
	bh=2MXE+6sOitUL5XrqKNvzNXUBhmCW8wc9X1AeXlBc9gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5x4i1cfa07TbpNPzzwSqq7/9hQ62q4L5IX7ugo4tGw7q4RWZUQk90Z3AQT2n6+5BDlrMZoYcWJ5F+wvxjBVtO3jkIGoZ4kEDhgk+BpoP/j5X9c8kFBeM3JP4vGDOAvAlhcJ/KAcGpyu2lVRkbN+1TxRySb7oCSlDl8XZJq1CXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LT3LlI1t; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LT3LlI1t"
Received: from macsyma.thunk.org ([151.240.45.25])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 66E2Q3Vp020514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 22:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1783995967; bh=vsOYajHeIyLSsU9EB1ENXGcRdGepOVQ4m5ymyFVbzWg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LT3LlI1tNY5tBhgTLf61XBsXSWZ0Wr9Tcq6aBeGaDnQcgbs3iP2Wejkh3ZwTlCqy6
	 ZMyYr7jX9OmmPI/iY5qCQ5s2g253TGFxzqW3vsRkY7/A0m8Pf3FDTuUK1KJaryMtc1
	 lA6hU2hbLgA/ACGZRxO9wQ7OzQHTwWeaqSVUEykTVmg7Qo9NE4wRpKdq6nGvN0pDUs
	 1XRukHbz891tFN3MKfb6nZ1Ot0vE8G7S/5FpmeztKr4KypTAFdiInpT3zpWrSfD6cj
	 C9RtzmvCroVhnGC7nbrjE1uBPdU6Z1MnFWZyDquUv7wo9Db+8fj8sz6ZUNhEnHiai4
	 Bs90XpyIDutcQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 71348A02015; Mon, 13 Jul 2026 22:26:02 -0400 (EDT)
Date: Mon, 13 Jul 2026 22:26:02 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Timothy Day <timday@thelustrecollective.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Marco Elver <elver@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/9] ext2: fix ext2_xattr_delete_inode() context
 analysis warning
Message-ID: <alWJFP2k7bR8REK2@mit.edu>
References: <20260712165610.366474-1-timday@thelustrecollective.com>
 <20260712165610.366474-2-timday@thelustrecollective.com>
 <alT2yHlfzhTZ9n4T@mit.edu>
 <20260713164417.350710-1-timday@thelustrecollective.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713164417.350710-1-timday@thelustrecollective.com>

On Mon, Jul 13, 2026 at 12:44:17PM -0500, Timothy Day wrote:
> I don't think we'd want to disable unlikely() globally when context
> analysis is enabled. Only for cases where it'd conflict with the
> context analysis annotation. Long term, I think we'd want context
> analysis enabled by default for Clang builds.

I see that Marco has a potential change to make LLVM/Clang to handle
this better, which is great, but I'm not sure why disabling unlikely()
globally when context analysis is enabled would be that terrible.
Context analysis wouldn't be changed with or without unlikely(), and
if we use context analysis as a debugging build pass, we wouldn't care
about performance, right?  What am I missing?

      		   	   	     - Ted
