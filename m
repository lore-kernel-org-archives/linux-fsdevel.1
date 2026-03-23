Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EB38C427
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261843; cv=none; b=VxRzoYRzVDHk9s1+8YA4/dALWL95k9T277gH/2kj7mdt+Pj3RcEkBhvEu5Qi9JUOF2S3ll72T3aOyYk0y390sBFSojR4ZcjCkHyJ97bDTHYIrzrNNmHzo9Je4OSNBLH63O37tENh377y6VrdqBW9gAmIZ1W7lVdr8ejF3m2K7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261843; c=relaxed/simple;
	bh=BCB8SHaA8dKfuKB8HtK0GiJ+hlcrC9fzhOHYVFVadpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQHU/uj1rQbMjluaXfONTd/aULqZJu5jsVWV+r8UdRKKVzbZ+tMUi1FzRmEwPPIwrFc2K2GNzaIQ3RxsI4oXdZKPgvWAXJxI7pP4GWXOHPOAijmgvlDfxC7jz5cnGXVsK6m8K2gxnt2YC8e3hedxHyR+bI8fmLftxMhEeF92/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ktDD00Le; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ktDD00Le"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774261836; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xhzDg7l7SKQD19e/DATr7zbJZ6gXmarOR4IANqI/354=;
	b=ktDD00LewfPVb8xgKwK6ZN9pkK+oAsqwchc0Q9jl4hPqbDc20X5q+GszZ7APw12rdFtfZlwoa78uiub9h0FTw8l28JGBVIwar9EXkQ+6TfKVWRwkYqhGFZQ9LbIQZZ4DliNnO5NGT+p69raH6mTEv6kIntxHrbVjYehvTjRZjVA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.W8oQT_1774261834;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.W8oQT_1774261834 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 18:30:35 +0800
Message-ID: <4f5b0671-9ff1-458f-9cc1-21df2cdfdd05@linux.alibaba.com>
Date: Mon, 23 Mar 2026 18:30:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Jan Kara <jack@suse.cz>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
 Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
 Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>,
 lsf-pc@lists.linux-foundation.org
References: <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <4a1fd8dd-6c8a-43bd-877d-c37720ac1e21@linux.alibaba.com>
 <dkixubohp7hp4scizz46s3aruu327vf6gcwelpwlnto3iab7fz@4z7lpju4acqd>
 <6ab85914-6328-4762-910a-2ad17d45a358@linux.alibaba.com>
 <4ubnjtpngijh7azvmqjavubnm3sj25uv2mjkpppzs35lwzjgax@nckcj2we3lru>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4ubnjtpngijh7azvmqjavubnm3sj25uv2mjkpppzs35lwzjgax@nckcj2we3lru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/23 18:14, Jan Kara wrote:
> Hi Gao!
> 
> On Mon 23-03-26 18:05:17, Gao Xiang wrote:
>> On 2026/3/23 17:43, Jan Kara wrote:
>>> And yes, when you have immutable filesystem, things are much simpler
>>> because the data structures and algorithms can be much simpler and as you
>>> wrote a lot of these inconsistencies don't matter (at least for the
>>> kernel). But once you add ability to modify the filesystem - here I don't
>>> think it matters whether through CoW or other means - things get
>>> complicated quickly and it gets much more complex to make your code
>>> resilient to all kinds of inconsistencies...
>>
>> I only consider the COW approach using OverlayFS for example,
>> it just copies up (meta)data into another filesystem (the
>> semantics is just like copy the file in the userspace) and
>> the immutable filesystem image won't change in any case.
>>
>> Overlayfs write goes through normal user write and the
>> writable filesystem is consistent, so I don't think it does
>> matter.  Or am I missing something? (e.g could you point
>> out some case which OverlayFS cannot handle properly?)
> 
> No, you are correct. For the usecases where immutable fs + overlayfs +
> empty initial writeable filesystem works, this is a safe design.

(Just BTW, not only to empty initial writable filesystems
  but also to previously mounted, consistent trusted local
  filesystems used as upper layers, as they are typical
  cases for containers.)

Thanks,
Gao Xiang

> 
> 								Honza

