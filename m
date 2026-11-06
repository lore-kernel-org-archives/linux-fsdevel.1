Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973621;
	b=FAw8M9kSLizfeREd2LdMa9qWnDFud+3M40IUqS9rHEuQaxuh1X3jzzVSocqrXws5NZUa
	 VAvIgJeWB4jFHd5FPq/pckKA/VTzaP7y5P6I6NhnoyjFJaNQLPuCA2DtzqzGofQgx5bfa
	 ERYQ3SohN/CdTpyevLdBIQuRuIEtjrMdfuAm2kfBH0+Ybe8wDEy33QWNAgEjoVqkzxP3G
	 INK2qQ/vjotjRzCC6IGx8MaCYYXbAIzJ6esrsR8HGapivfiYqsG1wDkGDU30zO2rEtKqC
	 x0H3318+sq24/BS/S2YjoOGKkgByg6UD/bI4U7YZLOh0zwTXbO87xpzZK2lVXTUvg8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973621;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=MMisgwf5ivCyneAXCg/69ag5tUf9sccmY26a8c7FNEM=;
	b=erpWR01rBaXUAfN4SBtTe94TEDi00h2Xmi017utayXvxsNISxXk1pgGCTSrT4k+AzNCw
	 EihMvDQdVT1gMrREdtUFXLk5YHQGKHFZFBMUVkFBpb+XPWY+hjUw+H8zVMHRCF73qs7V6
	 lNeHArFnJGDg47CQAXq6L9jz/zarNFkYjEhdNCM8+DUb6uQrkZtt2tyfd0+NZlDRdl51n
	 xMTwBAZqRKGAXp4DUyzIGBFFoLOD/JTrByna4+fjv/UGWTvcCyEBTYprTuwZ3fNSfC+8T
	 GOdX/U/8zjSyuzejqiUmEh0XrMUs+8mH1bJ1sIHrPNEodlcxAnthOYOAUOI6JR+gP4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoMaartx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075A606D81D;
	Fri,  6 Nov 2026 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoMaartx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0DE1F0089F;
	Fri,  6 Nov 2026 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973621;
	bh=MMisgwf5ivCyneAXCg/69ag5tUf9sccmY26a8c7FNEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=NoMaartx2k1NoDKHbinjDj/PbXDYhvLBDoS7ThiZ6Zh8degSdrM/cbNrjWCvJFPXn
	 IJa6OLrwSv7WeMgzoB3AuW/FePKuMzJwKFHbXEdI+ZYAwQGc/8vmhnKnmMjWU6LJ9x
	 33ovPBGmrTbUtWQlZ8QAyW3GCySDsLz5acI0WwsJZ5luc2SvTKggPaXxOHYrDVTmU1
	 D0Syu1/RiDILFaoQPgpwI3BeakKZgA8HYUcIZbDXsO1DAvgiVgvpXqbRHAyOx0m8ju
	 kJuhvtjsTeuWAZga6LkTBCYXNU81R/1eVeG/45nAIROGbzedXUk1SOmtB8Ud+4XU9q
	 KBbQqwdFHF80w==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Qiliang Yuan <odys.yuan@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20261105-bug-mm-shmem-undo-batch-v2-1-ae5f89ced044@gmail.com>
References: <20261105-bug-mm-shmem-undo-batch-v2-1-ae5f89ced044@gmail.com>
Subject: Re: [PATCH v2] mm/shmem: remove truncated folios from the page
 cache in batches
Message-Id: <179397361569.3706.17727764242079446039.b4-ty@b4>
Date: Fri, 06 Nov 2026 15:00:15 +0100
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

On Thu, 05 Nov 2026 07:32:11 -0500, Qiliang Yuan wrote:
> truncate_inode_pages_range() takes the folios it finds out of the page
> cache with delete_from_page_cache_batch(), which takes the inode's
> i_lock and the i_pages lock once for each batch of up to
> FOLIO_BATCH_SIZE folios.
> 
> shmem_undo_range() calls truncate_inode_folio() on each folio instead,
> so filemap_remove_folio() takes and drops both locks once per folio.
> Truncating, punching or freeing a tmpfs file or memfd made of small
> folios, such as a large /dev/shm segment, pays for that on every page.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: shmem-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/shmem: remove truncated folios from the page cache in batches
      https://git.kernel.org/mm/core/c/b97fbd54

-- 
Cheers,

David

