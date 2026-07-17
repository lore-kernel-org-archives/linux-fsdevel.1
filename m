Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD43E51D6
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277463; cv=none; b=Em6Lgk5DMvCLAVRbeXuNwTyLU9LqDyJTP8rHpSHYAmSu4ytSwdKeei3FW0yABQKDkcbFtpw4mU1Q1i0oWiEr5LgK0P2jS+HTkLOZAn4jA1d3iCBJqkgrjF2on1dhq8fhu1MzZ8FjUec03zqfewoJ6f5jOlp3GfqCnZKeLWlooFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277463; c=relaxed/simple;
	bh=WTgX/01f0GSt4LefZRBVhYzWdVM4DBYKSbUb9C7A320=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCiHNgmWIVDFGEU39fkBvX2qqaLe99AzNyIutzfeyGwS0noUUSt/3ESvn+3VB5I01BDY7c99zonOp8v7B53fEUQBps3fe6SxUt1dIJkLciepqIZSFGLCKHahulBMb+32qizOTMr+ndncg/CmZiQ+lkeybZ+KS554i1YQTNx6vzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ksCNvIJR; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ksCNvIJR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784277450; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=46zEzh7V3f0seR05X4wVMTBb1YImbCc49sRB+nWpCh0=;
	b=ksCNvIJRgiLr9HkxjT5gvXamL0acQlls+M5awkvzfd0fSzJfVFtUs33ZHC3Mq/0/pkd3wnS+ewTAgx6XL3KrgcJTGD/UIze34Vewu5CKBxrDyDiBEQ5QohlcLGuuK85XohLOMh3791HC3mq92Gm44AVIk8wVws/+ntCNXhbxrMM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X7GkPe2_1784277449;
Received: from 30.221.133.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X7GkPe2_1784277449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jul 2026 16:37:29 +0800
Message-ID: <5f5e668f-c371-4b8a-9ca3-91aa8fa10fbf@linux.alibaba.com>
Date: Fri, 17 Jul 2026 16:37:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, cyphar@cyphar.com,
 linux-fsdevel@vger.kernel.org
References: <20260714154917.489993-1-gscrivan@redhat.com>
 <a3ee4538-6273-4d25-90d0-8dbaac092a38@linux.alibaba.com>
 <87cxwm2f6z.fsf@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87cxwm2f6z.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/7/17 16:28, Giuseppe Scrivano wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
> 
>> Hi Giuseppe,
>>
>> On 2026/7/14 23:48, Giuseppe Scrivano wrote:
>>> Allow userspace to pass an already-opened file descriptor as the mount
>>> source instead of a path string.  This is useful for tools that already
>>> hold an fd to the image, such as composefs reusing an existing erofs
>>> backing file.
>>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>>
>> Use the current erofs-utils testsuite, the following tests seems skipped incorrectly.
>>
>> [Error 22] Invalid argument
>> SKIP: erofs/008
>> [Error 22] Invalid argument
>> SKIP: erofs/009
>> [Error 22] Invalid argument
>> SKIP: erofs/010
>> [Error 22] Invalid argument
>> SKIP: erofs/011
>>
>> [Error 22] Invalid argument
>> SKIP: erofs/017
>> [Error 22] Invalid argument
>> SKIP: erofs/018
>>
>> And the kernel message shows:
>> [  116.477816] erofs: source is unsupported
>> ...
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-tests
>> $ sudo make check
>>
>> Thanks,
>> Gao Xiang
> 
> it seems to be caused by the different error returned by erofs_fc_get_tree.
> 
> Would you be fine if I amend this on top of v3?

I think you could just send out the diff from the baseline
since it might be harder to follow an incremental diff here.

But anyway, new versions are always welcome, I will play
with them when I am availble.

Thanks,
Gao Xiang

> 
> Thanks,
> Giuseppe
