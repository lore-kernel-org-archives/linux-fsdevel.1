Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8923643F
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774157447; cv=none; b=mNg4S3JoxxzDNQl5GOQwZ87iEalnU2gIdoSysxSG9u1pU/zryDb70edC7Uw2NZFsIzvPE0149ctkXbvd1Z7x/Hg9UwtIL4cqSyarLOcFJU47TODIhYu8ez6W4EcXeW290GFVSaY6XeqcJB3owqGX1uXUnyU/mEninSXMsTEkbZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774157447; c=relaxed/simple;
	bh=J2ZdcoQN4AmUj3THW/oeprEgEj+Pe4xs1IsQ+8FQPcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbNi1nLvzbto3xcWS/c9T//A+r9kebOQjEQmW1XowGUHt7s3B+gRERIhSwg4YyHxfwqSosQhxm5TVsghjKPSOEI40RDLRNIY2UuY+nPHmXj5yAJ8EmtfiwWv1vhDcRSlAnpZcBXFbe954jasVwhfwaghhosU2wBaNdOO8mPZuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UGsyTYYD; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UGsyTYYD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774157435; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fq+9teCDFCAjQprZGgpiCi/1USoJjKdECB5MTr4IBhI=;
	b=UGsyTYYDp53/Onv6ZgTsRHx/bQG/EYgmnhgvaAtqMD5JDkofKbBVMrkifq9J9wiqB7eU9VynCwm5sakZsHyn7aaAi2Yuan/9d28X6GqIZHxojrN4lZNPneK7ZtLqiMNIKUJuaAiC3sOLVpAOIZNaz+EFq0NElZjZcCsv8M1dbrA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X.QFTgK_1774157434;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.QFTgK_1774157434 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Mar 2026 13:30:35 +0800
Message-ID: <24adea39-8b50-4765-8800-8937f2e23dc3@linux.alibaba.com>
Date: Sun, 22 Mar 2026 13:30:33 +0800
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
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <b30397b4-df0d-4f96-89a6-9c90aad10bd6@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b30397b4-df0d-4f96-89a6-9c90aad10bd6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/22 13:13, Demi Marie Obenour wrote:
> On 3/22/26 00:51, Gao Xiang wrote:
>>
>>
>> On 2026/3/22 11:25, Demi Marie Obenour wrote:
>>
>> ...
>>
>>>>
>>>> Technically speaking fuse4fs could just invoke e2fsck -fn before it
>>>> starts up the rest of the libfuse initialization but who knows if that's
>>>> an acceptable risk.  Also unclear if you actually want -fy for that.
>>>
>>
>> Let me try to reply the remaining part:
>>
>>> To me, the attacks mentioned above are all either user error,
>>> or vulnerabilities in software accessing the filesystem.  If one
>>
>> There are many consequences if users try to use potential inconsistent
>> writable filesystems directly (without full fsck), what I can think
>> out including but not limited to:
>>
>>    - data loss (considering data block double free issue);
>>    - data theft (for example, users keep sensitive information in the
>>         workload in a high permission inode but it can be read with
>>         low permission malicious inode later);
>>    - data tamper (the same principle).
>>
>> All vulnerabilities above happen after users try to write the
>> inconsistent filesystem, which is hard to prevent by on-disk
>> design.
>>
>> But if users write with copy-on-write to another local consistent
>> filesystem, all the vulnerabilities above won't exist.
> 
> That makes sense!  Is this because the reads are at least
> deterministic?

I read the remaining parts, I think only this one that
needs to be clarified.

As I said in the letest reply, I don't think __simple__ is
a suitable descriptive word.

The fact is

A filesystem need to provide users enough information about
files and filesystem hierarchy, otherwise it shouldn't be
called as filesystems.

That is the only thing that immutable filesystem do, providing
filesystem information to vfs, that is all.

No simpler than that, it's the minimal feature set of a
filesystem (and comparing the slight on-disk difference
means nothing unless the on-disk design is too bad). And
I think that should answer your question.

Thanks,
Gao Xiang
