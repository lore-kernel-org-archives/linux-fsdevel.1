Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670994;
	b=sTaRvvDA+jMJ9wV6ec2HxNZwMAnbUfknTzOnD+QE/qvREyaLTtabixB1d30fSyvW5F15
	 rrkYscDsRar866CGmSW+aJcozCmKj+5N8/sb/ykqBKrmn37mET0Vx0RzRxXi0vJKkG4iu
	 HReaGpGaln6Kum9s0UrWkkAFNrpZUa7KRECG+8+XLGZ6UTuAj9RGr8UhmABa1/FyN5e4s
	 sBZn8wEIyMITYObsUPYjmNMNJkLwQEoCulrp1tVnLuKsc0Bc2zcD8Bq3XGBmnRFj5wd84
	 HO5QUnIMmpAbHRrcPTB9ubNeXRTLUdnAyC4A8a3L09XdSwwv7S/TmVcf6ZukVpBpK/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oG/UK1lpPVs0T+G/uex5I6y18oVty/cZKc6GhxA17CU=;
	b=L7MOstOu6LtCe80BOZT4lzvhrTL3QpqfSWWRxkw9dV7az28+rBZq/PEBINky0pk+BJPd
	 SxqteQRk9lAxci+aH4pCSnqssZXPnUlH5ExJ9RMf+4E9gN7Zt8p6/KvJ8MgNPVUxlfEnW
	 pdcz5KkiAjj2YgS0I+p5rr4m6tnOOXza/jXi8dpFkniZLYCC6qh/2ymuFlI6t1901Gh+N
	 hT/0aZYN2lLhqjadvwKK8EWFdP5giL9D0+e8xwlEbDMe90ON0aw0bQOVkxzrOIeIbNqMK
	 v85xd2xrBLPZ42gNXzf10HiGpHESs+U1Yzu2gIHAxtHGJ9F6Xucm5xNaeMnBKhdAgPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GR3b6Ou7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C822606A327;
	Tue,  3 Nov 2026 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GR3b6Ou7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E971F00919;
	Tue,  3 Nov 2026 01:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793670994;
	bh=oG/UK1lpPVs0T+G/uex5I6y18oVty/cZKc6GhxA17CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GR3b6Ou7TomFWO0koV9WkroAduiPVKsmUD6/YPTpUoTzyGLMtkji7zWzVR8FrgiHI
	 9OHvH5s3KGh9l5yDsvxYIDlr8ZoPQROdPIVZBp4enZcR6M6Ki3yQ1PYth8jSGKc7wK
	 1pe/wtsBYyfAlR1F3athy4ymdpghRh7mbyufTTPDeVvJkilhfLOLKbMMS9zLpZMA2Q
	 N0+G8PV1zOzmeTqB5KcF735yHW8kb+luK6FY3SIuSXL9J4kLjUYL45zIp9Jl858QVV
	 3RiizWoZATPLgG/cfhePSC25t26uP3Bbu/ZJVtmbSVsg5uVAn0Z4AiykwGRiImF5Hd
	 aJryq0kKDemug==
From: SJ Park <sj@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] MAINTAINERS updates for page and slab allocators
Date: Mon,  2 Nov 2026 17:56:16 -0800
Message-ID: <20261103015616.95465-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
References: 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 01 Nov 2026 17:34:47 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> Following David's updates [1], perform similar updates for page and slab
> allocators to indicate the MM process transition for these
> subcomponents. Importantly, add Johannes as a page allocator
> co-maintainer.

Makes perfect sense to me.  Thank you for stepping up, Johannes!

> 
> [1] https://lore.kernel.org/all/20261030-maintainers-v1-0-97278f8a5f54@kernel.org/
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

For the series,

Acked-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
