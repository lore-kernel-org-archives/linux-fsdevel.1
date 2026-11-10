Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308597;
	b=BqHjYuHJiD5jqYr6D921D47QVVo0uIPv8RwrzNGEOa9J0LMqLgYLaO09O8CTYIPA5tHi
	 pzaZ44AjS571i0hST1JoZ6R/7Fepvp73fsOJ1sdH8w0urMsUpYIsffzO94n4UdALB3pvh
	 0hJM4Fur3uZAW+C3XVQQaAVF/3pAsYnG++TlpYwBd3+cg7lMs0mH/Wu6IKvLiQD1jqjd1
	 GH8KmSdNwUKzS0BImMeT5IGzjOwMWCHTBNF+co4W3ZXzUIzDebmALxyUD/mkMPIbXBNZX
	 /cvZa/MBRmdy9DWBpsshBOp7aYl6vyd0RtyPBSle45FTnBVR4rBrZJYy2h9lq1vEFgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308597;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zJqoM5byy7t2oJnrolNTZNqtxc09Si1RLmF8E4lHkmc=;
	b=OMUthagpJbpQA05IhBFCf1R0ShiYdO5ccO17lKGsLiVJvlcxgTfMh7hXVek3PtTIVpBF
	 jNukrc69y7tA7IurJy9Z02XJ2ylfByovKgUYfaFH7Q3Vyvdh8fzlK90vvrVirJHaemlrD
	 1Mt/sBcpm341E+ATccWzj0oGH5i/SpiPZjRdiemdhO1bTSfSDkHcWHrX8ilPl/RcbD7DV
	 mLYPd9f9PNoGINqn+f9W96shmxftB5DCPAfqz0vIUFlP/+hA3oujvDdzoVDeI5F07EnWz
	 snnQUpqt4y1IGttRX0MXLsUETLpVc63CwFPcFkIsbDP8JBLo0Zbxrky2nFWSde2uGag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YANA8zpl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FEF606A31C;
	Tue, 10 Nov 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YANA8zpl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558691F008A1;
	Tue, 10 Nov 2026 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794308597;
	bh=zJqoM5byy7t2oJnrolNTZNqtxc09Si1RLmF8E4lHkmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YANA8zplr5ixeJhh0AM8kWaDEpgWrinnTQE5LawdfgLFWTMxt5ac2dOiWa2uHAMWT
	 ECRyCaV5UcHiP0DAo950O9Dmg0eiMieX5pblSLm5iCsk5XT3a9DATsrRof7z/6txrQ
	 mwJ76n3z4xZHT0rB0l8oFErQFtc54rlSYNYJ5NS5nwj6xa1ameGYDGdHgXlRk/01r8
	 bZANPsfP8Swcja4QTEWwCPFJkEUzh7Fdsp5RiafyRFQLtUGpl5OvmRJugN4TQbo7/U
	 Q/1lOVg0My+24NrLBHq5Z1LHUVmtllX3g3t3W6cC1YtpP7IgN0+ncBEq4UwiLL9fTs
	 HUPvecaa/x0jA==
Date: Tue, 10 Nov 2026 11:03:10 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Seunghyun An <san55@wisc.edu>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Suren Baghdasaryan <surenb@google.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: avoid redundant reads of the vm_refcnt cacheline
 in anonymous faults
Message-ID: <avLxcf8KaFP_XPnM@gremlin>
References: <20261110000002.1834454-1-san55@wisc.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110000002.1834454-1-san55@wisc.edu>

Thanks for the report.

You are a complete newcomer to mm, and you are sending very subtle changes
to a core part of it, so I am not confident that you have the depth of
understanding the kernel requires for such work. See
https://docs.kernel.org/process/generated-content.html

I'll therefore take over this change and treat this as a bug report.

I will give you due credit for reporting the issue of course.

I'd like to collaborate on the perf measurements however, so if you could
re-run your test results on my series when I send it that'd be appreciated.

In general it seems that the actual issue is the debug assertion, given you
state only vma_has_anon_rmap() as a problem here.

In general in future - while we're fine with you using LLMs, newcomers
should work on small, incremental changes to mm to build up understanding
first.

--
Cheers, Lorenzo
