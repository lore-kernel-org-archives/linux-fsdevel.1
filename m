Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B23D3009;
	Tue, 10 Mar 2026 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773126801; cv=none; b=ImpuJmGZMF6FtkB6osj13lTu/VlsDcUY12XsbndcyqS+NlyzRx7xfLvT0oKGXklaiw/ywiv8Vtv8Ntujf9Vi5CovohYKvsayA1IIvN6OrTLPskqbubzC9y4dJbXGF01eoIkPjGSfkg7/rthcEswsuVMyuiyF05aeT42J2q+E484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773126801; c=relaxed/simple;
	bh=Q6xcBXHNuicDNA0HG45fl3n9eDQDK7GjZ8Lp4YQEqQo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GBVQYcJJnoSFAAYvmrcJlZv6qMj0x2hbj/pIWSE/Pzq6t4qtFi4Q+Lwm+I1QLBcClpdc2p/1xt98S4SqIhH6wkLmRcS7KSnIuCqqKNZV5RM4nJIS2tQ6I1m86qmtQjQVVNSQBJkdogUAlXhYTRvoFI922ibHxevhdf/serKJ5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS+v42Ll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS+v42Ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF0CC19423;
	Tue, 10 Mar 2026 07:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773126800;
	bh=Q6xcBXHNuicDNA0HG45fl3n9eDQDK7GjZ8Lp4YQEqQo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gS+v42LlsueP8KIMsq3bUeernz7YGdezod33aJ5up60bWgpCLl2UknWMSK54P+32R
	 ptq1mpcCQUTED/DZGCBSW6uCSMAZx7Fc837t1gZw7HKPMafe5fyV7KYopJalZVoobD
	 kZ+nl02uqurLUmVCSn8YGkMKkrPJpFKohS4NVD2WtsqAYXZcU+SukpFo/odsU66xHk
	 jj85YsGoniF4miPxhP7DyfUS6SDjoDpdEY4N3LY85CD6Krwzib+q6Ly1eWGDjTeHdf
	 8uY8Z1hOUeS8WfEfrXs8ZEeqak/Mjnu5rUyo8nO2L9BZDOjmc/fn1o0RN3P19WqzOm
	 WsSYgsgTyqyTA==
Message-ID: <aac25712-a3f4-4f1a-9200-d16cc7ea97a7@kernel.org>
Date: Tue, 10 Mar 2026 15:13:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>,
 Hongbo Li <lihongbo22@huawei.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] erofs: introduce nolargefolio mount option
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20260309023053.1685839-1-chao@kernel.org>
 <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
 <dc645bd1-2881-4472-8918-0eada3786ab3@kernel.org>
 <a15eeac5-8035-4ac5-93b5-5c71f3ce7105@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <a15eeac5-8035-4ac5-93b5-5c71f3ce7105@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/10/26 15:02, Gao Xiang wrote:
> 
> 
> On 2026/3/10 14:43, Chao Yu wrote:
>> Xiang,
>>
>> On 3/9/26 11:03, Gao Xiang wrote:
>>> Hi Chao,
>>>
>>> (+cc -fsdevel, willy, Jan kara)
>>>
>>> On 2026/3/9 10:30, Chao Yu wrote:
>>>> This patch introduces a new mount option 'nolargefolio' for EROFS.
>>>> When this option is specified, large folio will be disabled by
>>>> default for all inodes, this option can be used for environments
>>>> where large folio resources are limited, it's necessary to only
>>>> let specified user to allocate large folios on demand.
>>>
>>> For this kind of options, I think more real backgrounds
>>> about avoiding high-order allocations are needed in the
>>> commit message (at least for later reference) also like
>>> what I observed in:
>>> https://android-review.googlesource.com/c/kernel/common/+/3877981
>>
>> Basically, the background is about contention scenario on large folio allocation,
>> it's among multiple users including EROFS in Android-system, as it's related to
>> internal scene of product, so I can not provide more details now, I'm sorry
>> about that, but I'm glad to discuss based on the background and pain point once
>> if I can share more, let's see. :)
> 
> Understood, but I think it's hard to justify an upstream
> solution without a public load for discussion.  Anyway,
> I can imagine some real workloads which large folios could
> cause unnecessary pressure since I once worked for Android,
> but I think others need an explicit one anyway to justify
> this.

Yes,

> 
> As Matthew and Jan mentioned, it's hard to add a per-fs
> knob like this.  If it's Android-specific and no possible
> public infos, I suggest leaving the changes Android
> downstream for now, until the workloads can be made public.

Sure, I can understand that we're not going to accept per-fs change
on large folio policy, as if there is conclusion or agreement about
this in previous discussion from community.

Thanks for the suggestion, I can take a look from downstream side.

Thanks,

> 
> Thanks,
> Gao Xiang

