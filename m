Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E43DB323
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280699; cv=none; b=NrX9rF0VsGdCRLlNHT2z/XmvMwycT9iIa7WScI39c6X7v52wiYO4PWtM5F3nQ+XxUcBa6AqFTwHBOyAbwt69qMbhglizJWknDZMurXGjt6Yuq5lc746p02IELiBaiO2e3TtxvVNx4MpUeVXiNBP+Bo3y2rcj/oi1PjqqAz2QVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280699; c=relaxed/simple;
	bh=Msi6FWOym7/XTmWIcpvni1Cd3C1PW2QCv4EMF0bzhZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MP0VF72UjgD5Cgc6VLo8+ZkfBJM0FoKHsg0nUclywPvRzPFLb4THxVEG7er3u+VJWjYAKYzEN4/EDtILjdF2f5/PL3G9O+6tZQjULptxX516ULogUIxBbWZJHVC2MFA7cv6KhmB7F1KP50YHqRSANCNmEaS70K9fCYxw3rfqm5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CKNwMd1O; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CKNwMd1O"
Message-ID: <dd037379-cf59-468e-8b42-51546bf2e28c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784280695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OG6jvXmMMoQvaDYJwcula4TIxwe3WKsFp2ip9kul7ZE=;
	b=CKNwMd1OZtgv6WxEj0MvRApGEEyk7cRyetAls+cov9UTpb1CnVjUJCNEoCpm8SWQLMbmq+
	Jq4RF1RTKmGUZWA6lBe03a6WyE2rZSTSgHrkzu63qBPxTAtctHBqESrmnZSKPalJfRK6J9
	9fEgL+v817O3b3ruFs/yj+X2zSX8nXI=
Date: Fri, 17 Jul 2026 17:31:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/thp: expose deferred split folio memory usage in
 meminfo
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260717063025.168436-1-ye.liu@linux.dev>
 <46017e29-48a3-4a74-8c5a-0be9d912deaa@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <46017e29-48a3-4a74-8c5a-0be9d912deaa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/17 16:37, David Hildenbrand (Arm) 写道:
> On 7/17/26 08:30, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Folios on the deferred split list hold physical memory that is
>> invisible in meminfo. When a THP becomes partially mapped, the
>> unmapped pages are removed from AnonPages but remain physically
>> allocated until the shrinker splits the folio. This creates a
>> memory accounting gap where used memory cannot be attributed to
>> any meminfo field.
>>
>> Add NR_DEFERRED_SPLIT_PAGES to track the total memory consumed by
>> folios currently on the deferred_split_lru, updated via
>> mod_node_page_state() at all enqueue/dequeue points. The new field
>> DeferredSplitPages is visible in /proc/meminfo, /proc/vmstat, and
>> per-node /sys/devices/system/node/node*/meminfo.
>>
> 
> Oh no.
> 
> This is really exposing a current implementation detail where we have this
> information easily available in a way that we will not be able to change that
> implementation later.
> 

Yes, `/proc/meminfo` is a user-space ABI.                                
Adding it there means you can't change the semantics,                    
and the field will become unmaintainable, yet you can't delete it either.
But I think this information is still necessary.                         
Where would be a better place to put it?                                 

-- 
Thanks,
Ye Liu

