Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFB374E42
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392146; cv=none; b=SGTgD+ZkHOOzvupvmHwFGNh1N3LjtvpGYK2wGEfUiVSJxjrSNN26HW6EqP1luWvUoOZFR2yWyeRQJ8vuDVDNpMVNLwJpuEbdMe+FBPReUEV8Mkd7Odk9TgD98N79QxoaS/9RrxDmqgD5aYISP2pyBPsYVB0TOldQpbAPYIZS9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392146; c=relaxed/simple;
	bh=IFC7hXKPwMedJytsJeI5mp/FynpAiPFG78VuYifsEps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hQ7RFdePFco49LU3pzVhwIYmf7/FQHI/1IIbway9v15NLnhIR479piiBB2tLWKiHW4Uc+EhUz4boT0J+y2Dyo40OLzRrzv+Ju0/5n0gR5wxWXbYbzQugmtOXu0ENWGt0wPcMihSNlrcxKMfN1wcUVdWLPyvYJwwxlFy/kV9VNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ENFRIItb; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ENFRIItb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QHzU3ct+4jvkw954wX1fuSd83oPCWlFHer4z3d/39Bo=;
	b=ENFRIItb2F/FlVI7RJ+1OuW5ULJ7gPfCK6qW5TYjO3EKw49V27wdaITAzoTQ1PpAgizXshQMo
	2p0b5cU2AkEhZCfY4wMIURRCVU/8aZew+KX6qeT+/p+sOMMoopwYj/K3IGZxjJOTe+A1Cg8vClN
	0Jwit/ZqSSmIOoQ/6mULX7w=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gvQJ02s2Hz1K96m;
	Tue,  7 Jul 2026 10:33:04 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 661D04048B;
	Tue,  7 Jul 2026 10:42:16 +0800 (CST)
Received: from [10.174.178.9] (10.174.178.9) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Jul
 2026 10:42:15 +0800
Message-ID: <3aa50eea-ad23-4b19-9b31-a111dd5efb71@huawei.com>
Date: Tue, 7 Jul 2026 10:42:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/task_mmu: count KSM-placed zero pages in smaps
To: "David Hildenbrand (Arm)" <david@kernel.org>, <akpm@linux-foundation.org>,
	<liam@infradead.org>, <ljs@kernel.org>, <vbabka@kernel.org>,
	<jannh@google.com>, <pfalcato@suse.de>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20260706121323.1149847-1-tujinjiang@huawei.com>
 <6ef49a9f-af0c-4bce-8402-16926424ea7a@kernel.org>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <6ef49a9f-af0c-4bce-8402-16926424ea7a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2026/7/6 21:40, David Hildenbrand (Arm) 写道:
> On 7/6/26 14:13, Jinjiang Tu wrote:
>> When KSM deduplicates a page to the kernel zero page (i.e. when
>> /sys/kernel/mm/ksm/use_zero_pages=1), it places a zero PTE with the dirty
>> bit set. vm_normal_page() returns NULL for such PTEs, so smaps_pte_entry()
>> bails out before reaching smaps_account() and these pages are never counted
>> into mss->ksm. As a result /proc/<pid>/smaps and smaps_rollup report a KSM
>> value of 0 even though the region is fully merged.
>>
>> Count KSM-placed zero pages directly in smaps_pte_entry() using
>> is_ksm_zero_pte().
> Hm.
>
> We do expose "ksm_zero_pages" in /proc/<pid>/ksm_stat for calculating the KSM
> profit.
>
> Why would we want to expose it here as KSM pages?

I wasanalyzing the KSM profit of a process comes from which VMAs. However, 
smaps does not include the savings from ksm_zero_pages, make me fail to 
analyze.

> An application will notice the difference between "zeropage enabled vs.
> disabled" either way because we'll also not account zerpages towards e.g.,
> "Anonymous".
>
> So faking that something consumes memory when it actually doesn't consume memory
> is wrong?
