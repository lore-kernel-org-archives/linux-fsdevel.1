Received: from mta1.migadu.com (out-116.mta1.migadu.com [95.215.58.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAB3AF66E
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978840; cv=none; b=JD3w3Qt7u0EQHD0CoW0QKbfg2dVgyYYt14JYOhI2pFhElHyYlL6BhO9gzB6Yltn7hAPijmZ0ALZOCdLCpEJPiVzDsUlSnIBLqAr7NcEghMPONYLmU4m/+1klV3ITzDyO8kf/fMwxf0YzIV3vedF33ZKObNhrCi8Zcf1d341jXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978840; c=relaxed/simple;
	bh=aoprAUYmUN2jwm3AkI2t0iJil/x7yD8M/lNnyU1MNmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2pCsHs9GTynq88pzktWRP0tWKiCFVdgaJ2y04b4c6IOHHDCAz5a04fiMZVMf5VV9/CBjzsBzMhGu7RNH8EdZzNAFeH5frKJ3CWffHWv2k/uSl10czY7qf4R+iAI4EqDQo6z5+HUT8qmV/0G1wT2yHb+2EWQYdkjeHlxrJz+hu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pbnXMYd1; arc=none smtp.client-ip=95.215.58.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pbnXMYd1"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aoprAUYmUN2jwm3AkI2t0iJil/x7yD8M/lNnyU1MNmM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789978836; v=1; x=1790583636;
 b=pbnXMYd1TTDYxvKVuHEhnHM68i5nflXaGYTg/MAPcW5x241s8L2cTE6Cg4McgY82bnXkB9BN
 Ds2WIlCp8hucVQ1jbqb8NZNGL43WzXy7dsPIDjJXTdF9/N3ZfhV/JkzxgPm3TtHHXmyJNA1gcNC
 CGyqPD3c+oF929v1pvjwUUyg=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3d02c4ea80ac0ea7;
	Mon, 21 Sep 2026 08:20:20 +0000
X-Mizu-Trace-ID: 3d02c4ea80ac0ea7
X-Migadu-Flow: FLOW_OUT
Message-ID: <86f06c26-5318-4196-b792-0662ad64f2bf@linux.dev>
Date: Mon, 21 Sep 2026 16:20:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/17] erofs: mm/pagemap: add readahead_folio_last() to
 avoid folio->private
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
 Gregory Price <gourry@gourry.net>, linux-kernel@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Nico Pache <nico.pache@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lorenzo Stoakes
 <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Hongbo Li <hongbohbli@tencent.com>, Kairui Song <kasong@tencent.com>,
 "Liam R. Howlett" <liam@infradead.org>, Chunhai Guo <guochunhai@vivo.com>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 Ying Huang <ying.huang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-8-bb68b6a21869@nvidia.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260920-remove-pg_private-v5-8-bb68b6a21869@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/9/21 10:28, Zi Yan wrote:
> erofs needs to traverse readahead folios in reverse order to achieve
> maximum performance by
> 1. reading all folios from readahead_folio();
> 2. storing the prior folio pointer in folio->private;
> 3. traverse from the last folio to the first one.
> 
> Add readahead_folio_last() to achieve the same function without using
> folio->private. __readahead_advance() helper shares readahead_control
> adjustment code among __readahead_folio(), readahead_folio_last(), and
> __readahead_batch() by checking new private member, _forward, of
> readahead_control.
> 
> It prepares for a future commit that replaces PG_private checks with
> !folio->private checks. After switching the checks, erofs's use of
> folio->private without bumping folio refcount can cause unexpected
> outcomes, e.g., in filemap_release_folio(), try_to_free_buffers() becomes
> reachable.
> 
> No functional change intended.
> 
> Assisted-by: LLM
> To: Gao Xiang <xiang@kernel.org>
> To: Chao Yu <chao@kernel.org>
> To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> To: Jan Kara <jack@suse.cz>
> Cc: Yue Hu <zbestahu@gmail.com>
> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Hongbo Li <hongbohbli@tencent.com>
> Cc: Chunhai Guo <guochunhai@vivo.com>
> Cc: linux-erofs@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Nothing jumped out at me, feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
