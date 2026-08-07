Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A842F71B
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Aug 2026 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133514; cv=none; b=J+FlE6i4mHC/3AEm7nrqt6lsal/Av6spXBULVQFZMvXT4yuY2LQFBumeotanaXALXojZyYRH5JE4kDWH3HOPW6xkJmA07r3jVVoBLvWzlPaqreQA5r0zrdsGUk70iwrMKkCTcL3Ditcf3zgOE8KYgsUGRCBgohL0gbvUv+FWUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133514; c=relaxed/simple;
	bh=Apvh0u5eXDSx863rY7fsHuM/O8cdC0VODFAfSZWWdDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVpHnICDcG2VV7EL02ozG9n7jqvtaVLAMIgmwLDjGQPOCB9NiC800v73GTYXZcEsIBFOdYahEQ6Sl1Ol5rymc8XrM35qxD5xrYwEohcx0vbz759OnaMwbvlWaVp3/W2Me8rnGrO4aKmf6/qFBpymCVlavdVdJFVMrsBr8FTmXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rK4FNMf8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rK4FNMf8"
Message-ID: <2b1a75f9-528c-4b33-946b-d1452372a5ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786133509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COYAz0/fn9f9zQMqxdnS8F+AaTPqDwUGO++486vjWrg=;
	b=rK4FNMf8ZLmXAC9A9ufsnjj80noZmotG1gbAy4Na+GVcZbohwGM7fppahlUVn16sNdc0+1
	7LN+B3lUnTdKzPh7LiZiSCxqoAmRgvJx2/kv7+l0ufErowdUqa+Q8Qn+LzRBdVQKydeu2e
	zCweJL08enSH/sZpu7IjfbwBvRpZOUQ=
Date: Fri, 7 Aug 2026 21:11:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] squashfs: avoid thundering-herd cache wakeups
To: Andrew Morton <akpm@linux-foundation.org>,
 Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 jlayton@kernel.org, boris@bur.io, riel@surriel.com, kernel-team@meta.com
References: <20260724190556.1950693-1-usama.arif@linux.dev>
 <7d92d30a-c92e-451b-907e-74c91562d4ae@squashfs.org.uk>
 <20260807115844.d4eca51ea2b6ddfdcd7dc25c@linux-foundation.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260807115844.d4eca51ea2b6ddfdcd7dc25c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 07/08/2026 19:58, Andrew Morton wrote:
> On Fri, 7 Aug 2026 17:01:30 +0100 Phillip Lougher <phillip@squashfs.org.uk> wrote:
> 
>>
>>
>> Hi Usama,
>>
>> Sashiko (the new patch reviewing AI) failed to apply and review your patch.
>>
>> See https://sashiko.dev/#/patchset/20260724190556.1950693-1-usama.arif%40linux.dev
>>
>> I have been dealing with this issue all week because Sashiko also rejected my
>> patch sent this week.
>>
>> https://sashiko.dev/#/patchset/20260805175900.600140-1-phillip%40squashfs.org.uk
>>
>> After quite a bit of investigation, it appears the problem is Sashiko is applying
>> the patches against the squashfs-next-git URL listed in the MAINTAINERS file.
>>
>> Unfortunately that squashfs-next.git tree is unused and twelve years out of date
>> (last updated 2014).
>>
>> See
>>
>> https://lore.kernel.org/all/267938f6-8212-4ddc-9055-452f9d166010@squashfs.org.uk/
>>
>> and
>>
>> https://lore.kernel.org/all/anUi3bkwfM8teo_R@debarbos-thinkpadt14gen5.rmtusma.csb/
>>
>>
>> But as it stands your patch and mine are going nowhere because Andrew won't
>> pull any patch that has not passed Sashiko.
>>
>> See
>>
>> https://lwn.net/Articles/1064830/
> 
> Geeze, that's very overstated.
> 
> If Sashiko can't review a thing then that's annoying because sometimes
> it finds bugs.  If it does review a thing and claims to find
> significant issues then I want to see the developer or maintainer
> explain why things are OK.
> 
> If you the maintainer want the patchset merged in this situation then I
> have no problem with that.
> 
>>
>> I'm going to resend my patch with a base-commit: tag to see if it makes
>> a difference to Sashiko.
> 
> That would be interesting.


It worked! This is for the v2, that I just sent on top of linus upstream
from today, commit a13307e97d5c54b65720bb71fa379960ded1e51a which is also
mentioned in the sashiko review in "baseline" section.

https://sashiko.dev/#/patchset/20260807172421.3875982-1-usama.arif%40linux.dev

Sashiko found no regressions! So hopefully the patch is in a good shape.

Thanks,
Usama

