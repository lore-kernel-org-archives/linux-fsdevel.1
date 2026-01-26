Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF663382E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432889; cv=none; b=ZrKPXwwxjV2UGG4o4PxUKgKHb203b3xqlDYohm6rakxKq0/4c9uRfP2ieIrGIS9d1hoyc8cAp/KzfCGWrhtXyz1TbBS3co+CdLAJLqKqQ+NKID0vcCgMdr1XTS0b+6/7uUkCd+2FqpY1uOP1iO5ybIfmBKF7Ja3M05RPsLTJ8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432889; c=relaxed/simple;
	bh=tebxgPVy4f7ab1EN62FAFOss0wYi00AJSZ/6lgNQ4Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrtBDOBizVbkJMF7xtREF1RryXnsIf7sym8Y/JGR63si6e8uNlBG++/WJwChk3cyyvhWtEpeBUWT1ATSmkAq3DQQtRocSmQ+TNbtcOoqLsatIlgPhbRrejBU1EprOlyhQDB4HVJzHut0b7n3AZw4GIaXvKQRQH+7hXaA9MAFDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UB5n4L9G; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UB5n4L9G"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769432884; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tvvpVC0BKDp0INxVtqI3B7SjCmEHL0XIQNX58k14Fso=;
	b=UB5n4L9GiHzzUnuU3bBEI7RT5V2FggAvMo+t4okUdUlBW1agoT9m13wmU2iQhbO2dsYFLq7/zYrdAOuhJT1dpsheaAxLd9VOXiSnqi1V/R6K50W6i/uq7fhr1AR1GpoDbZOzgY9XXR33U4DcYxuMG5JNGtldEUfIwbGvrCTpQUI=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxuvfXz_1769432883 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Jan 2026 21:08:03 +0800
Message-ID: <851f8dea-f7ae-4d39-b6c4-1188542c0bda@linux.alibaba.com>
Date: Mon, 26 Jan 2026 21:08:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/iomap: Describle @private in iomap_readahead()
To: Hongbo Li <lihongbo22@huawei.com>, brauner@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org
References: <20260126120020.675179-1-lihongbo22@huawei.com>
 <20260126120020.675179-2-lihongbo22@huawei.com>
 <2e960c83-ff29-4d78-927f-64c5cd84d87d@linux.alibaba.com>
 <de894823-29d7-490c-a3fc-f36c7bc27f3c@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <de894823-29d7-490c-a3fc-f36c7bc27f3c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/26 21:01, Hongbo Li wrote:
> 
> 
> On 2026/1/26 20:38, Gao Xiang wrote:
>>
>>
>> On 2026/1/26 20:00, Hongbo Li wrote:
>>> The kernel test rebot reports the kernel-doc warning:
>>>
>>> ```
>>> Warning: fs/iomap/buffered-io.c:624 function parameter 'private'
>>>   not described in 'iomap_readahead'
>>> ```
>>>
>>> The former commit in "iomap: stash iomap read ctx in the private
>>> field of iomap_iter" has added a new parameter @private to
>>> iomap_readahead(), so let's describe the parameter.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202601261111.vIL9rhgD-lkp@intel.com/
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> btw, I don't think the cover letter is needed for
>> this single patch.
> 
> Thank you!
> 
> I would like to use this to indicate that this is a patch based on the vfs-iomap branch. Maybe another way might be possible to place this information in the hidden area after the SOB.

The best practice for a single patch is to drop those comments
after the first `---` line.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>>
>> Thanks,
>> Gao Xiang

