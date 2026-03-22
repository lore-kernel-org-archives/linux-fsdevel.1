Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7D199385
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774151535; cv=none; b=bY3UYuByHRqfxL0k4WUNNYFgPI2tpKC6KpDrK5EdrBrPKnS2uUbnJpS8ndljRinkxOD5dxV6//izDOdOrT+WcMc5RwURifDQrVT8NkyfuCWAsm+Vlxusos4TZZLyekqf1JFRxyH+tBnGVJGZAHcLzsG+K0aUPaKnQVCpPIICLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774151535; c=relaxed/simple;
	bh=Q1uo/Y7y30KMALaJDVnaa5a+5p8MusLd+95Do6umkAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKlMpUx6TkMMUtVjmaRokscqAHkH0A+23eeItxDArqQVC6Fk/D4/XiwOS1iIXt+K4NgKxEsVO/J/DoRvKgGS1O29OHTy2yStoCw4MYXkr9FDt92frJJZ9q5ZmGR8QbvnDdN4pQsJjdMyWGr+H63Ji8AVxy73vdLjypqFax5+ylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tTKK2ZjB; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tTKK2ZjB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774151530; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E+SX/46oBuGjE1b6lyeVYrAue0USoQ9fMib1ZGiU374=;
	b=tTKK2ZjBYnCpR9578vRXTq8Ty9aaLDAAfwsgFWOr64diA2aBwdpngbRTbsiAu+BqBpGuKtmdAvzas4jxFuQa3wUyl42P8cLd1uhOr3WbA1gLead0Z8Sg6JpqOkuszp1V3+I7C4tgpSduOGfUdNhccMrCGfcqrL4HfJ0lg8MwDLI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X.Q8tDm_1774151528;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.Q8tDm_1774151528 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Mar 2026 11:52:09 +0800
Message-ID: <755e46b2-a71f-494e-9ee0-22bf8655fbed@linux.alibaba.com>
Date: Sun, 22 Mar 2026 11:52:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Demi Marie Obenour <demiobenour@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>,
 Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Demi,

On 2026/3/22 11:25, Demi Marie Obenour wrote:

...

> 
>>> "that is not the case that we will handle with userspace FUSE
>>> drivers, because the metadata is serious broken"), the only way to
>>> resolve such attack vectors is to run
>>>
>>> the full-scan fsck consistency check and then mount "rw"
>>>
>>> or
>>>
>>> using the immutable filesystem like EROFS (so that there will not
>>> be such inconsisteny issues by design) and isolate the entire write
>>> traffic with a full copy-on-write mechanism with OverlayFS for
>>> example (IOWs, to make all write copy-on-write into another trusted
>>> local filesystem).
>>
>> (Yeah, that's probably the only way to go for prepopulated images like
>> root filesystems and container packages)
> 
> Even an immutable filesystem can still be corrupt.

I disagree with you here, I think we need define what kind of
corruption is really harmful to systems.

I can definitely say, if an immutable filesystem is well-defined,
it cannot bring any harmful behaviors to the systems.

Taking one example, nlink can still be mismatched for immutable
filesystems, but does it have any real impact?

  1) you can write an unpriviledged FUSE daemon to return arbitary
     nlink all the time, so getattr results doesn't really matter;

  2) OverlayFS and some other fses I don't remember now will return
     nlink = 1 all the time.

As long as the mount/user namespace are totally isolated (of course
you shouldn't mix with the other namespaces), I cannot think out
a real practical attack patch to attack users __just out of the
well-designed immutable filesystems__.

According to the EROFS on-disk format for example, some field of
course can still be considered as corruption, but so what?  It
cannot bring any harmful behavior like the other generic writable
filesystems, which much rely on the allocation metadata, nlink,
etc. are absolutely correct, otherwise the write paths are hightly
vulnerable.

Let's keep in other words, many situations, you still need to
download archive files (like zip, tar, etc.) from the internet,
but without any verification hash for example: Sometimes we face
random corruptions out of these archive files, but so what?
such archives can be extracted with garbage data, or garbage
metadata, but if the namespaces are isolated, what's the real
impact to the computer systems or users?

That is all I want to say, if you find any real impact, let just
write down the real attack paths, but that is all my ideas in
mind.

Thanks,
Gao Xiang



