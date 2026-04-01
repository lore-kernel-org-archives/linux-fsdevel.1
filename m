Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F71A3172;
	Wed,  1 Apr 2026 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008030; cv=none; b=bEfB8TQF2xFpkDSfFAMPHMmzK86U6Ii8tSG5au1SRSajlm+zYZToABRRq/BxhdRDvO9yZm32/43HXk6BTSlZv/Q4Snjo1cnBtreihyVhwv8Ov8cwh/Lsn+BE/3+SndKYbLBous86spxMcDvShbPvWLp82/hx3X0xXilaf06tRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008030; c=relaxed/simple;
	bh=tHNfa8qPJcgCNoBG+hbftrQsKqtUiRLwI4EfVAAO0Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftzXflvFnL9sBhDZhutu0pRQd6QFKA3BO45GGWIXsfPpod2ORmti27gKLnC/b0nEtOnrqkxdQAkEXQdcpES0B0+KUJVoeID1fjT6xLo2ZQjXRXNrDPIQlPpUBFL44NYTJVvMKadvjAC+BI5oPzr+16h4TxGRvVN9JNHaVKdrWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pLdH/pTF; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pLdH/pTF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775008025; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1rlmMjl+JIj6qHe9twgM8IVoDk0lsZrMCr14XubCCPE=;
	b=pLdH/pTFgnZQvDfye2tRfCU5LzY0SmYS46grLeA2391Vn9R726qYjuJ0PBQUFohqFB03zNmkclqUXztBEeZshuL9plnrSSdQOGfW+MZVhLOfXgshbg9fRpDnmuUA7Q8v2QoReqonll29x871VbPEYRDlHpAAoZdh4CSPWzifigM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X062Lee_1775008023;
Received: from 30.221.131.203(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X062Lee_1775008023 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 01 Apr 2026 09:47:03 +0800
Message-ID: <b04c1c86-100e-467b-b104-7312c4dd0251@linux.alibaba.com>
Date: Wed, 1 Apr 2026 09:47:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
To: Ian Kent <raven@themaw.net>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
 Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>,
 Jay Shin <jaeshin@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Yafang Shao <laoar.shao@gmail.com>,
 Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>,
 Colin Walters <walters@verbum.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20260331012925.74840-1-raven@themaw.net>
 <20260331012925.74840-2-raven@themaw.net>
 <20260331-engste-raushalten-f66cd264ce77@brauner>
 <4184b060-2923-4722-9899-c85238b8e3eb@linux.alibaba.com>
 <d54d4791-dab3-4141-9665-091fc8918235@themaw.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d54d4791-dab3-4141-9665-091fc8918235@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/4/1 09:38, Ian Kent wrote:
> On 31/3/26 17:54, Gao Xiang wrote:
>> Hi,
>>
>> On 2026/3/31 17:39, Christian Brauner wrote:
>>> On Tue, Mar 31, 2026 at 09:29:09AM +0800, Ian Kent wrote:
>>>> If there's a very large number of children present in a directory dentry
>>>> then the benifit from retaining stale child dentries for re-use can
>>>> become ineffective. Even hashed lookup can become ineffective as hash
>>>> chains grow, time taken to umount a file system can increase a lot, as
>>>> well as child dentry traversals resulting in lock held too long log
>>>> messages.
>>>
>>> Fwiw, there's also e6957c99dca5 ("vfs: Add a sysctl for automated deletion of dentry")
>>>
>>> This patch introduces the concept conditionally, where the associated
>>> dentry is deleted only when the user explicitly opts for it during file
>>> removal. A new sysctl fs.automated_deletion_of_dentry is added for this
>>> purpose. Its default value is set to 0.
>>>
>>> I have no massive objections to your approach. It feels a bit hacky tbh
>>> as it seems to degrade performance for new workloads in favor old
>>> workloads. The LRU should sort this out though.
>>
>> JFYI, another issue we once observed on user workloads is that
>>
>> `d_lockref.count` can exceed `int` on very very large
>> directories in reality (also combined with cached
>> negative dentries).
> 
> Ouch!
> 
> So more than 2 Billion?

We received some report.

> 
> I suspect in that case you have much bigger problems than 7 or 8
> 
> million dentries on the LRU list and linked into the directory.

That shrinker seemed not to be triggered at all
since the memory was abundant on those bare
metals; I don't see how it cannot happen with
enough memory and trigger negative lookups on
a directory for example.

However, it was a report quite few years ago, but
I remembered it was a real user report
(`d_lockref.count` overflowed).

Thanks,
Gao Xiang

> 
> 
>>
>> It can be a real overflow, this commit can help but it
>> doesn't strictly resolve this, anyway.
>>
>> Thanks,
>> Gao Xiang

