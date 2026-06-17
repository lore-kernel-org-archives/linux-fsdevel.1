Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8931E823;
	Wed, 17 Jun 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781720941; cv=none; b=t9FPDozrukDYKLwqj4Gi5UD8TWd/XE+UP1loEBxhAfVVF33ZB7Si6TeJjVjo3LyfTXnjSiNu7zNipJdeH4lxhuZMiXunswyl+Tiiqpf0YSqZlXLux2tbIkKvr/aH003ZOhpGZCFlTbSoYm9JLN9p70GmBYNnh+2eRpV8sss67IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781720941; c=relaxed/simple;
	bh=gesa1pTbIG65LQTWFGgI9JEkypfx0mAqXszwZsd5RME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRTwx/btzH4MUIRJijjl+Q0j9fuAWJLpZJ+4p4Jho3WTTxrsqHuCB1GhAyUMDhFpOgB+8ZQ1nhMHdtqvtpCi9z5pP/pw6t0nDuDeGRKQNzlOQ925NeLeg1uXAlEd5QpZGiVb5zFdCFW/5h8Lt048CZs3H1KNiEuu0W2epy8Wc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la0c7O+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la0c7O+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB46D1F000E9;
	Wed, 17 Jun 2026 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781720939;
	bh=hwTXKT1EWNTmd+zBnvgMaSU0bhs1xgsbFgpE70mME7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=la0c7O+CxDdY61dPhd78+22LGdOku/1cGY08gVvxkzcIZdFQeBHRhLVanabeliUF8
	 JpdIQEnd2ntNeka5WyYoIWz1vLwPcpk/yoZ4053foxf2ngPP5XrNzZZKAMYcq/g4xv
	 B2Bl38KAf/MZMETEs86d+ed5g1O25faaEV4otDbcX6qYsJV1+/mUj+MNSYW0o9StkO
	 V59XrbXrlk8t+JaIehn3v7zE5FpdRsMSimkAXiLPlKSdiUY3GVQrxxH6GVOGaLDwEs
	 hTK+8wVbWSjKopNkos2n0iGH5mjN0oIQ0H1HfW0Q9M/vJ0KI/MMA3Yq92n4nuYvqzr
	 rustaSbP31X6A==
Date: Wed, 17 Jun 2026 21:28:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jane Chu <jane.chu@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
	osalvador@suse.de, david@kernel.org, hughd@google.com,
	baolin.wang@linux.alibaba.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, lorenzo@kernel.org, peterx@redhat.com,
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] hugetlb: Use PAGE granularity index in exported
 i/f and adopt the common read_iter
Message-ID: <ajLnYRJdtA5U996i@kernel.org>
References: <20260617172534.1740152-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617172534.1740152-1-jane.chu@oracle.com>

Hi Jane,

On Wed, Jun 17, 2026 at 11:25:21AM -0600, Jane Chu wrote:
> changes in v2:
>  - new patches 1-4: add hwpoison handling to filemap_read(),
>    thus replace hugetlbfs_read_iter() with generic_file_read_iter(),
>    suggested by Matthew [2];
>  - new patch 5: convert hugetlb fault handler's vmf->pgoff to PAGE_SIZE
>    granularity like the rest of mm fault handling convention, suggested
>    by Matthew [2];
>  - patch 6: fixed a bug in v1 pointed out by Usama Arif, also by syzbot;
>  - patch 8: did not pick the Acked-by from Oscar (for 5/6 in v1) due to
>    updates to the patch;
>  - patch 11: add VM_WARN_ON in hugetlb_unreserve_pages(), per Oscar;

It seems that cow, hugetlb, GUP and HMM selftests trigger these WARN_ONs:

https://github.com/linux-mm/linux-mm/actions/runs/27707843062/job/81960927740
   
> v1:
> This series stems from a discussion with David. [1]
> The series makes a small cleanup to a few hugetlb interfaces used
> outside the subsystem by standardizing them on base-page indices.
> Hopefully this makes the interface semantics a bit more coherent with
> the rest of mm, while the internal hugetlb code continue to use hugepage
> indices where that remains the more natural fit.
> 
> [1] https://lore.kernel.org/linux-mm/9ec9edd1-0f4c-4da2-ae78-0e7b251a9e25@kernel.org/
> [2] https://lore.kernel.org/linux-mm/aeZwAz6PcdlqSnJ2@casper.infradead.org/

-- 
Sincerely yours,
Mike.
