Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508835;
	b=ycm3ReEnsWm2HS4fSFxsD2t7a0Azue72U4Q4wvn0SkuJTsRI+s2P2s6or3w/W7twNj8W
	 cE3k8DxWGP9bQOnLuDppof996TIRE1H6H+9nOAjoJ84R9vwxKY5B51ybrrqbIhseMT8rP
	 ivgXxhj3IYGt7T71HR48ZYi8F87y/k1Q3OLd5qFU+hVITSkCPSTNeXXuraePrWintC2/d
	 LLbFH3Z4vzUwe52hEpygGNL4UAOf9k63jxFGMsqXrqeymzL8D9ikDlhCQtWGqKywo9GkH
	 Felv9WykYIYV5rfTiZd4Dy0H3fkILavIDcFrckNLQFHsuI7OSuQtlbOT4bb2mNZw+UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508835;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=hQcy+J0Q27okHFSIG61ZS/kukvTSiukLlG4lterpEAo=;
	b=Io70yjBE9oI38g7xHLFdgmkEqCP8lK+Ydc06gt5AhZkyzLzttNfRgPXg1Lf2kbgk+JHE
	 qlS9p5euTmCCY4lGU5fetgBfn3hspgd0L15M/p2pQYHcSUwLMyq6WpHIK6T0QXrAIHLxb
	 OsKClCTQLTSzGzh/nJoMT51l+73WxEyiPe1Oh1ae4v9lG8I0cSmJy43f23f0HhHehkMB6
	 dSkghkOru848UDikz3/zC/010i5A9o1douCm3hF48NJoqPEYgGzKjg+ld8pkMt3T4ozEr
	 ebhk5Geb7ynQR6smJEWLikIb8trjo5Fy+276A4xc9sQi18DoLnmojZSD0heXy6KoIXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boqD8Jr5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026A606A322;
	Tue, 24 Nov 2026 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boqD8Jr5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DAC1F000C4;
	Tue, 24 Nov 2026 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795508835;
	bh=hQcy+J0Q27okHFSIG61ZS/kukvTSiukLlG4lterpEAo=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=boqD8Jr5nch2TD31AiMaSKkiNroCZ7mGESH2QHNH1pMQIBTB7IjBLEY0KHG5M1pxB
	 eU6QsNYc8kyUeB5Txid6WdGM9bfbY7YrwX1vOsQ4mg4OQGzL7qgcMiVrW1ngX8kCSV
	 leaVcrqdGsQg659aCaZeKyEtIpztAqu1sTbUTNUo8gR8mfYPcLVv+J+UluoHqUe0eP
	 duvXvnyVzMsIoGa3zV+fYRHXjii9S1nF+xAJ9lInKZxuAqBk1u0jxP9TjEK0pIkCqS
	 nJZbIHMb6ROINwVN6glswsVpjyH6Osi6shRQYbpggQFa/8xTljk9JhGIqh/aT9/CZj
	 VVhUksjBT1e9g==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
 byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
 joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
 matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, 
 surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com, 
 ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, 
 shakeel.butt@linux.dev, kernel-team@meta.com, baolin.wang@linux.alibaba.com, 
 Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com, 
 baohua@kernel.org, lance.yang@linux.dev, Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261123163301.1568240-1-usama.arif@linux.dev>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
Subject: Re: (subset) [PATCH v3 0/5] mm: fixes for THP migration, swap-in
 and device-private smaps
Message-Id: <179550882470.7632.15364862356979603217.b4-ty@b4>
Date: Tue, 24 Nov 2026 09:27:04 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Mon, 23 Nov 2026 08:32:06 -0800, Usama Arif wrote:
> This series contains four fixes for existing THP migration, PTE swap-in
> and smaps paths, plus one cleanup. They were extracted from the work on
> PMD swap entries for anonymous THPs [1] and can be merged independently.
> 
> 1. Avoid a folio reference leak when concurrent MADV_DONTNEED clears
>    or splits a migration PMD before the device migration split helper
>    acquires the PMD lock.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: core-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[2/5] mm: don't PTE-batch a swap-in of a folio with a hardware-poisoned page
      https://git.kernel.org/mm/core/c/37d4eb7d

-- 
Cheers,

David

