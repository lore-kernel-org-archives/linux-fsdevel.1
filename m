Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013740;
	b=3vY0RvFHBK66iXXThmqduHI3ggXCG43z3A6CcqWNwZ1Z+fQHFM0jjC3FWbWy0HpSJ0u0
	 jlPaU+iwjeAOvAHDhMIbRpVt32Nv+KQbwKRek2kPvQtF7KQInQLbf+KP6+x5KOOItAVyg
	 80MJRMKZGRHySYWuKBB6vyXt2a4OmEOVvmq6jcETIduxF3BlYi7jFoa/nvSc1mLunbtyS
	 Zx89Ip28vyGffayJtD/g0FS/34sV8w3nxsxX5/5RsN6J7Acx/C2D77GReK+oIWtv1T5HN
	 PpeuyOIbQiQBD01RzPL2fQQ20X7aWCbXQCKtEQFm+hwocKQBhzTnuzTBgJ4GOXW/KDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013740;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ijqcgAe+pRUXlQUJgaP68UktE3jKkOIl7f6QeVzcqa8=;
	b=odAMprGb0uFfTGrE3Vsdxpd6MqCNmR2ArB/TVixJmTRrcPWvc5mc2o21Qfe1yg7dwJkm
	 QgsZuFBIxNUXEbyIHCxAxcsZQ55ZQCS4LfDx8STKA4i5AwM5VZuSpLmQr/MMhQOUWwFNq
	 PLSsr4ELbRsqfxfnWZy6BT8FqncVLkxQAqWsikTk6ITaCkPKoybtcrffT5gqueE3h2ajj
	 A8lL64Ves8CB/fpHyYugAHghlPMzwobOBeyRHJqkTr2giSpdMxzNexjmmyhQ0TaPg47co
	 HfpgzoO9YjvhB6eDb1hfGdSOBsaz0vXX8p6pK7YxRWwWZ3Iq8ymGj9AWu5zcfqK7Tag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIYIin49;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F950606A320;
	Wed, 18 Nov 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIYIin49
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A5A1F000C6;
	Wed, 18 Nov 2026 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013739;
	bh=ijqcgAe+pRUXlQUJgaP68UktE3jKkOIl7f6QeVzcqa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIYIin49xSrhz3fYpj0Knm3dUy7DYct2MAxbHOUDkYisck7LJSB+Gndhs5lT4zRp0
	 G9yKhwIrSoMLZuvK+kh+eKEGAUD5ZD5PkCSvIc7Yh8N097/MFMZwCvJ44VkcLS1txT
	 gmfuU5dgh9eN0rM5Eivb+hfREhloBoUPSaqyZaceB3ZLGueQNPnbEVpsPbv5gJisMA
	 g0KDwnrs710Grb1t1KlpS4DNooZKDpOAtKxApW4TMkzSV6oxWEG4uAbHNhlEV8ZzX3
	 F4c1H9BtHpNWWlF1dw5YbJdjG1p6nzWGMBKtwO0fiXjBq7YU1Mm5Mo1ITGy75NkD7R
	 OyXlJ/cC3fvyA==
Date: Wed, 18 Nov 2026 16:55:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrei Vagin <avagin@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] mm/userfaultfd: check the hugetlb alignment of
 every VMA in the pre-scan
Message-ID: <av28XEFwGGuNhrSE@kernel.org>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <20261117-uffd-state-fixes-v3-9-b617009d1a4a@columbia.edu>
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
In-Reply-To: <20261117-uffd-state-fixes-v3-9-b617009d1a4a@columbia.edu>

On Tue, Nov 17, 2026 at 11:28:49PM -0500, Tal Zussman wrote:
> UFFDIO_REGISTER and UFFDIO_UNREGISTER both scan the VMAs of the range
> before changing anything. For a hugetlb VMA, userfaultfd_register()
> rejects a range whose start or end is not huge page aligned there.
> However, userfaultfd_unregister() only checks the start.
> 
> An unaligned end only fails later, when vma_modify_flags_uffd() cannot
> split the VMA there. At that point, userfaultfd_clear_vma() already
> cleared the WP or RWP protection. The ioctl returns -EINVAL and the VMA
> stays registered, but accesses to its pages are no longer reported. This
> requires a caller passing a misaligned range.
> 
> To fix it, move the alignment checks into vma_uffd_range_aligned() and
> call it for every VMA in the pre-scan of both ioctls. UFFDIO_UNREGISTER
> still returns -EINVAL for such a range, but no longer unregisters the
> VMAs before the misaligned one first.
> 
> Checking every VMA the same way also changes the following:
> 
> - UFFDIO_UNREGISTER now returns -EINVAL if the end is not huge page
>   aligned in a hugetlb VMA that is not registered. It used to skip that
>   VMA and succeed.
> 
> - Both ioctls now accept a start that is not huge page aligned if it is
>   not inside any VMA and the first VMA of the range is a hugetlb one.
>   They used to return -EINVAL, although such a range covers that VMA
>   from its start, which is always huge page aligned.
> 
> - UFFDIO_REGISTER now returns -EINVAL rather than -EPERM if the end is
>   not huge page aligned in a hugetlb VMA without VM_MAYWRITE.
> 
> Fixes: cab350afcbc9 ("userfaultfd: hugetlbfs: allow registration of ranges containing huge pages")
> Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 54 ++++++++++++++++++------------------------------------
>  1 file changed, 18 insertions(+), 36 deletions(-)

-- 
Sincerely yours,
Mike.
