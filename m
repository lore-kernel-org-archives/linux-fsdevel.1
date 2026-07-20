Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD62449B1E;
	Mon, 20 Jul 2026 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576896; cv=none; b=gLWf/RSddXAzxELF1KQRDPBGAIPjDAXNcr6lMmHFEHfSTrqIq9WxwCc4RHpKGlZgX0h1xvNGM8oN2JEoeLKllRION/rHxIEiFewldUg6EtmIQf1Xz9LgOUm3id/R+YTSJuB5JMq/PGOniWkWdJ9+Sbk9yejFzeq1CVKKpUXoCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576896; c=relaxed/simple;
	bh=z5DqRcLbYNjo7e7/eys/x7/3mz36m2KW/vWmj28hpk4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tZblMfc1AVcSDaxe++QCbdzi9y4gCOW3Bjls03+mhi9z9xYaOhHCXpOJNFRKXgWuzBcGRMtlQ7vWTwDwIIhLGGVKby+Y8Hj2IL4HOwKun+JQCuiUhUyMIuFMN+Lf8a4PDK12SaD5tYWq+mkyBJQhIIwaNUYyrDV2AyjAG1SburU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kk4B9AnZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kk4B9AnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714FF1F000E9;
	Mon, 20 Jul 2026 19:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784576894;
	bh=bY1azwx4jsJQ8qPk/eyE9vAbXOIQ9l1CV/aEbqxCteI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kk4B9AnZqoB09H/QyCds+vQW8ifZnmBuX+TT7CXqkZYAze8MiNWDEn4/41loU6QuY
	 hFZkQUANo2EVXCBtP+yWrp+JWh6cfKRs/ZllD0E8MSBKM6mgtRgiZaDeEhLncUVbCG
	 A3Y+YWhNRQRMWuxYj/yZg2zIy65cBzbKo0kKabBo=
Date: Mon, 20 Jul 2026 12:48:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, Kees Cook
 <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/15] mm/rmap: index MAP_PRIVATE file-backed folios
 by virt pgoff
Message-Id: <20260720124812.30e04cc81a56dd6f0346cdf6@linux-foundation.org>
In-Reply-To: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 15:38:26 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> In memory management we've managed to manufacture a great deal of confusion
> around the concept of anonymous memory. We have:
> 
> 1. 'Pure anon' memory - anonymous VMAs whose folios are anonymous and
>    swap-backed (thus for reclaim purposes, treated as anonymous). These are
>    simple enough.
> 
> 2. shmem - file-backed VMAs, file-backed folios (from rmap perspective) so
>    present in the page cache and mapped by an address_space object, but
>    whose folios are also swap-backed (thus treated as anonymous for reclaim
>    purposes).
> 
> 3. MAP_PRIVATE-mapped /dev/zero - a strange beast whose VMAs have
>    vma->vm_file set, but whose mmap_prepare callback clears vma->vm_ops to
>    satisfy vma_is_anonymous(), which results in VMAs that were mmap()'d
>    referencing a file, but are in every other sense anonymous, including the
>    folios.
> 
> 4. Other MAP_PRIVATE-file backed mappings - These possess file-backed VMAs
>    and have file-backed folios until CoW'd, at which point those CoW'd
>    folios are anonymous.
> 
> This series fixes issues 3 and 4.

Thanks, I'll add this to mm-new for review-n-test.

AI review seems overloaded at present, might have found a few things:
	https://sashiko.dev/#/patchset/20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org

