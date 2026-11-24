Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508780;
	b=4yuBd80CJ+poTc2/NtmCXgQB9xk70o3J416zlnpmkRiy1HRozlM03pGoMcToLys2NdT9
	 TXq868882g+pYigpBg1GXQ05ffKkAUsFNGA2vWWaUpv54t4SM3t81aS+6Ypc9ypBPldU2
	 4CWc9V1VY28iVsjHIEPNqYF0THJYxlse+38OWY0bbK7a050HLP7j6JnHB2fSyvFpnVm43
	 ylEMmxTim3txI9I1eejzBB3pwUmBbA6H9nvJ7xhmDhT1YVDJhieWov2KUck/xg0flQyPF
	 M/1Gh8IhALQgNF9LXzELmOx1gn8F5vIQUuoMcogM/XVz6EBzbb1OOxUa/Q/2TikEVww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508780;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=nFbKGYqNsE0OEI64HjMZzYVaBoeNIoEd+mOemUKQtdQ=;
	b=wq4eKr6ayQfYjORSFWSqwRiVbnTzg+Oua1QiI8wRUS1ObB8puSBQSoqY0FiRr0hVKqt9
	 bxFRg8GgSjtr9zEIVAG4/KKTIXKk8gcPOJkMFYXzu3MiMaGCDwu6sKOvHBBYInx11X6Ai
	 SVFmrRaSaauNtEjIrTFFQiogFepAkcaGVzoeadLirIkXXRgOVlfteBRGObeDzdMDjeZX8
	 8jOwrGlFimzKdbWw52aPQMD1Kwvfs289Gba20WKz2aFDGm6e3ysxYqiV3p/zVCJOA9ywP
	 vUX5pcvOd4rsXOAr1tB9MUP4Tj/j8uSR63eNirGG7nxY8Rd/7qf5C3bNNrP3ZPlXzdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=funnePDd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE93606A33B;
	Tue, 24 Nov 2026 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=funnePDd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3A01F000C4;
	Tue, 24 Nov 2026 08:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795508779;
	bh=nFbKGYqNsE0OEI64HjMZzYVaBoeNIoEd+mOemUKQtdQ=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=funnePDdYYpjLlc5jX6O/cKl14Oe+ZTrcPDQa62x63ehgOMPY3P0x3Wyczstqs8Mb
	 sd7obCJrirXzuo/YA3svkYpWgK8iC4TD5st6SrplVWv0dh0Hw3rErbwbDoscm6womI
	 6lr12i4TCNpmIzHW+FD3GKnqo21I1sAjLJzZn8BzGOpCxnrmAsGa6zb0Rsk1qeXTxT
	 UCTTDDgBdK7ZON3t1c9fAf1KYMWxl9n0qyoWvY07KD53NIjhB6+CVk2XN9EAl+Yz8B
	 yoUPwPUsxz5ATcSSKHYiH+X0/3KLReNn1K+EbC2zI1BAB+qkM+TSRh8QlkC2fOBuN0
	 RFDUbXtK7DdWQ==
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
Message-Id: <179550876938.7489.17735221885406654534.b4-ty@b4>
Date: Tue, 24 Nov 2026 09:26:09 +0100
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
branch: migrate-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/5] mm/migrate_device: avoid leaking folio references during THP splitting
      https://git.kernel.org/mm/core/c/62541fb6

-- 
Cheers,

David

