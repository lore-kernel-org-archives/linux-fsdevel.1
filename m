Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563518;
	b=riRPqEpoaO+UD7ve3RTbrBLux0d4T4UyY4J29lsMQCjSjAAoN8MTHcgnIla04BAS/HEw
	 xdxeAdr1SeScVozhLDS9jmLNPA69h010cKpoTU/hkmhgYU++QRRlKjFPeIGuhxfRoCTN+
	 UrFDy70aqubAU6rUAJJYQylRjxF99s7DQJdj1pH/oLXlmIpz2W3YQVxrYUPoAX+QWOf+l
	 0JUvgxmyez/I6eHpbAnKIZK+tHCsJm1dnJ2tp+FgRxTDtDRflLUkgGC3YFGguAzl3gUAG
	 Nc2jf7AK1gKhKqP/g2/YlPfYOptneVGQzQ1oIkb0L+3S1otnpFJeEf9sBlLFJormc6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563518;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=f4FQDKbejT3J1n5vJtGKFu4K5+PWNmUP6Rk+a9iJRqo=;
	b=wdnhlWyeH5TvE6duq3kljQz/0xKnkrIgM3sAPmLnlvhWcp8nt+0VQOEgn2mrijkopdVh
	 KnwxooJC+SkWHOvALmQpkqiivWtFgBwbjpBVx5CV3+hZGWq2eMZKdAvCsGcv8Z5zuWvHq
	 1ffPhdIfP4DSYReWHNS7sEAVGQvwtdTGwvVTEYhx5cpTXw6LgHVrftlogZ/ekmIM2lcQN
	 XSgCcX/IwKn5RUfllGnAhmc6jkdWI0LjvM9WTWZq+718217oV55JM0sR5TTnscN9h7ytV
	 P2J2Vsohlac6ZJl0WBqlpdzJo/M2Ki+IBDb4Z/jzSNZVtrHjC2c07iyDMF/wC7JiQLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bfqf14KD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78C606A31C;
	Fri, 13 Nov 2026 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bfqf14KD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796FB1F000C4;
	Fri, 13 Nov 2026 09:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563518;
	bh=f4FQDKbejT3J1n5vJtGKFu4K5+PWNmUP6Rk+a9iJRqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Bfqf14KD2OgZDu86Z/9aV8o4CIRH0r8OahYXT0TKwNcziKzrzdOLXoTAuoYlVGbx7
	 pfgaSnNXw4J4gKWSz3NfG4AmnVizFOTOUtX5VUBwyPSnwRVd/IxOIkD3QNFOAvr7DO
	 7i+U4rAXiFfeOsXzW6MCVh6mgiRN8nJEJ2PIk0O4d18zjcuQ78R6WDZfvLVksXSBuv
	 P25IM8Gp4K5zOe50DJEWq5UCxBUWkQZKXb4fCZPvguf372n9zDOO6cVxeqEuYBMZ4N
	 IeRF1SkqeYixgTjc83/xHzbtEqEG2ETWEZ5zheXeg6drve1ZzHS5E8eQgVHHhu7mbz
	 A8Y0NGmPcugDg==
From: David Hildenbrand <david@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Pedro Falcato <pfalcato@suse.de>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Chris Mason <mason@kernel.org>, 
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <20261111182445.656620-1-kas@kernel.org>
References: <20261111182445.656620-1-kas@kernel.org>
Subject: Re: [PATCH v3] mm/memory: refuse to map page cache folios that are
 not uptodate
Message-Id: <179456351421.3136.15619726484550572099.b4-ty@b4>
Date: Fri, 13 Nov 2026 10:51:54 +0100
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

On Wed, 11 Nov 2026 18:24:43 +0000, Kiryl Shutsemau (Meta) wrote:
> A page cache folio that is not uptodate holds data that was never read
> in or cleared. shmem fallocate(2), for one, adds such folios and clears
> them only on first use. Mapping one hands userspace whatever the memory
> held before.
> 
> Each path that maps page cache checks for this itself: fault-around in
> next_uptodate_folio(), a fault in filemap_fault() or shmem_get_folio().
> Nothing in the mapping code does, so a caller that misses the check
> leaks stale memory silently. MADV_COLLAPSE did exactly that with
> fallocated shmem THPs until recently.
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

[1/1] mm/memory: refuse to map page cache folios that are not uptodate
      https://git.kernel.org/mm/core/c/2b2a2b86

-- 
Cheers,

David

