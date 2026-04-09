Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5F38E5C0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722130; cv=none; b=E+/nKneU1fXcM0QWavVh5XBGi5VGx9CNpTQicH9WBcIGLEQmD56gP5k1FDW+waQ53SGumHDNAjYQhT4VwG8RF/QifF6j+fpeptkJu5jANYxAvKO42k4zCjf3P6D0CkOdfQnE5vgMNLBt71qCtE4vkc+9VG81t6+ivMN4e+aC+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722130; c=relaxed/simple;
	bh=Ldk7zM4xHPvkN7qlQhnzrX2SCfdO6Z3dzEsYXTGoFtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=adO/n3s4dLVhtzIvmaj7RNHIEa+v1N5OAi7j3ml8ZQN2dB7aXyG8jNt2iJn6+2kRlBb+eMdqaapxztiS5y+QsONlbmjiRjftthSTmEQadBdWmo0tyLWaP87hTIiX3Kl+x+qlkZITN0VGbuzWdOyXpoTPlOoyx/1pGB5Gydo3Nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Qg3MJHeR; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Qg3MJHeR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2wKIVbg9ebDYTSOl8F0vaTg0+4KOKttW9ZEjysh+UqA=;
	b=Qg3MJHeR+jC0YBSXUgSxWuy6TUsy0aGjFOw80rQSgUK48+NK/rpO1fdY3TzRVAFSPIcHtz8Sz
	v/d5xZV7DUgWv/jLOq1H5ZMGpitBSjxW/fTB9PfAKtZc73XL2kebD5f65nA+rKFw55fy9KS5UkA
	E78O4/vVhCfmVPplr/JmIpg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4frsq44MT1zcZyR;
	Thu,  9 Apr 2026 16:02:24 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id A903D40538;
	Thu,  9 Apr 2026 16:08:43 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Apr 2026 16:08:42 +0800
Message-ID: <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
Date: Thu, 9 Apr 2026 16:08:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
To: Michal Hocko <mhocko@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Christian Brauner <brauner@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo
 Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <addP4MKmA8zfSN1o@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 4/9/2026 3:06 PM, Michal Hocko wrote:
> On Thu 09-04-26 14:35:03, Kefeng Wang wrote:
>> Add a sysfs interface at /sys/devices/system/node/nodeX/drop_caches
>> to allow dropping caches on a specific NUMA node.
>>
>> The existing global drop_caches mechanism (/proc/sys/vm/drop_caches)
>> operates across all NUMA nodes indiscriminately, causing,
>> - Unnecessary eviction of hot cache on some nodes
>> - Performance degradation for applications with NUMA affinity
>> - Long times spent on large systems with lots of memory
>>
>> By exposing a per-node interface, admistrator can,
>> - Target specific nodes experiencing memory pressure
>> - Preserve cache on unaffected nodes
>> - Perform reclamation with finer granularity
> 
> Quite honestly drop_caches is not the best interface to build any new
> functionality on top of. It has backfired a lot in the past and we have
> tried to make it extra clear that this should be used for debugging
> purposes only. Extending it further sounds like a bad step.


I am not clear about this history of this interface, but some of our
products do use this interface :(

> 
>> One use cases is hot-pluggable NUMA nodes, during hot-remove, simply
>> dropping pagecache is far more efficient than migrating large amounts
>> of pages to other nodes, which also eliminating the risk of accessing
>> potentially faulty memory.
> 
> Does the per-node reclaim interface can help with this by
> any means?

I have also considered this interface. As mentioned above, our product
uses drop_caches, so it is easy to convert to using the per-node
drop_caches interface.

'echo 1 > per-node-dropcaches'  VS 'echo XG swappiness=0 > per-node-reclaim'

To use the reclaim interface, there are two differences,

1) we need to input the reclaim numbers and swappiness, this is not a 
big problem
2) for reclaim, it supports swappiness=max to only reclaim anonymous 
pages, but cannot only reclaim file pages,

So if per-node-drop_caches cannot be accepted, we can consider expanding
the reclaim interface to reclaim file pages?
