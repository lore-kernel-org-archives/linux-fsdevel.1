Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569033CC9F6;
	Tue, 10 Mar 2026 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773126154; cv=none; b=GAWTtHErpFtLw/wuiGq3fqln3y6BOcbt4IUCharv/qgUJFLiU4ZyrOKC5JilRLSV2qdM9z1JAxtr+OkLQuQIN/WT8MaBv8RMvPcn2rNai1LKb+g7B9WtNeALmJjKZY5SGKJqyHrsS7xl49ovDHlSg8ArHamrhrjqebBdsKp8iSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773126154; c=relaxed/simple;
	bh=atHg+Sgdle+GXIMCIjO1yPxucOxYmPhxd+RSQKasRmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJgbs9A0AuW4Q8bWZYhE57xSpq8E9WXR+326vw0iRGRW1ddDZfYuLNWmyEorcTNJ/HOqRMcy81Cg1U4eNXQA5WZLzPr61mjWTLDvSVz5NyFc0pU9rrvm3eBScMdLqOcpZUFV+kMYO+7VwyDz4MK5LTiWwnjKpkVdbtTxCdi7q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aQ+yv2k1; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aQ+yv2k1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773126146; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8OfXxbZRS7165p6jxMorXrfU7kFI5hv4wFv/bCV1+9s=;
	b=aQ+yv2k1eXwy1tglptd+aOxzp14ntmoyARiLFP7omumCw9l3qrVMSzUz9luqfbX0w5C2gh9mMTf469aziMQh2abu65CJ85rrMmLyESP8cYsjUGyI3OypsN1r/8F3eRj9/CnxrPNJX7jTo6ha0x5KXZogXamjdO9wwY8F9++CIZc=
Received: from 30.221.132.177(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-fCCDd_1773126144 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Mar 2026 15:02:25 +0800
Message-ID: <a15eeac5-8035-4ac5-93b5-5c71f3ce7105@linux.alibaba.com>
Date: Tue, 10 Mar 2026 15:02:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: introduce nolargefolio mount option
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>,
 Hongbo Li <lihongbo22@huawei.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260309023053.1685839-1-chao@kernel.org>
 <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
 <dc645bd1-2881-4472-8918-0eada3786ab3@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <dc645bd1-2881-4472-8918-0eada3786ab3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/10 14:43, Chao Yu wrote:
> Xiang,
> 
> On 3/9/26 11:03, Gao Xiang wrote:
>> Hi Chao,
>>
>> (+cc -fsdevel, willy, Jan kara)
>>
>> On 2026/3/9 10:30, Chao Yu wrote:
>>> This patch introduces a new mount option 'nolargefolio' for EROFS.
>>> When this option is specified, large folio will be disabled by
>>> default for all inodes, this option can be used for environments
>>> where large folio resources are limited, it's necessary to only
>>> let specified user to allocate large folios on demand.
>>
>> For this kind of options, I think more real backgrounds
>> about avoiding high-order allocations are needed in the
>> commit message (at least for later reference) also like
>> what I observed in:
>> https://android-review.googlesource.com/c/kernel/common/+/3877981
> 
> Basically, the background is about contention scenario on large folio allocation,
> it's among multiple users including EROFS in Android-system, as it's related to
> internal scene of product, so I can not provide more details now, I'm sorry
> about that, but I'm glad to discuss based on the background and pain point once
> if I can share more, let's see. :)

Understood, but I think it's hard to justify an upstream
solution without a public load for discussion.  Anyway,
I can imagine some real workloads which large folios could
cause unnecessary pressure since I once worked for Android,
but I think others need an explicit one anyway to justify
this.

As Matthew and Jan mentioned, it's hard to add a per-fs
knob like this.  If it's Android-specific and no possible
public infos, I suggest leaving the changes Android
downstream for now, until the workloads can be made public.

Thanks,
Gao Xiang
