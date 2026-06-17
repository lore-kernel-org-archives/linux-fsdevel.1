Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B633FB075
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706218; cv=none; b=ng/TG9f8sZ6L7k5A6IZgetPumahWHc9eXaw4etp4mBGSCX86jWhSA/up88pOTROiUxeZIZ08a9fq/7X9Qe0KsxClst/EOsAZDTyQ3TefEaUDhFrZKnUwAO2j6dv3DrH5TwK9hF0ZCLKdGh5fZn1LWctL8ctKNpokMfrBfodkBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706218; c=relaxed/simple;
	bh=4OrGCeLcSDfOcDzbTmyuu4uMLYeihA5aKajB96CfwYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TboFlN89TLqWE3KeQr6el/fKXd0uEQ+n4CsleUU2/b524+fBliOwBSGn9EebZYH32ryvCOWFCxKUvYzQIzravPNKy8bbaPyri6X6E6Ck8QtYPo1Dlk9RtSDmgCRPnC4oZW9JF9L8/gRZyfdJOVw/K0s/pJTLUs4kEWO6fjXvuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v7yESB7j; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v7yESB7j"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781706204; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vhvsUEgLYTUDkOIBA4DwsqfV7AptAA3xKwJAvS7jSGY=;
	b=v7yESB7jJfP8wWAU5lV7CgGxKa+WQqNXLb4DW8e8J0BnCTaqcLLCTP3ZYRIK98c/1MLSZ5ZsGbwR1g0K8WNVBBwtCyEJi33xSbeTD/zvpCogO+KwUptZuAcCtw9BCnWch1iIJw3tkzuEOREesozVqLcg/6aL9HV5QJhclx5MTk4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X53odUx_1781706202;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X53odUx_1781706202 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 22:23:23 +0800
Message-ID: <905b7d03-3e35-4db5-b72e-51051b034cf4@linux.alibaba.com>
Date: Wed, 17 Jun 2026 22:23:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
To: Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>,
 Song Liu <song@kernel.org>
References: <95371379-97e9-4cb4-8358-ec014b765b74@linux.alibaba.com>
 <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
 <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
 <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
 <yguigvx3sapcemq2oudlc6lmiwmxr27zx572oyqocbvefnpt3s@z3oj2pzgdjuj>
 <CAOQ4uxi2Mx4ZB48DhQJWOvt6UBur3LnrkttgRjo72U4+Cu81iQ@mail.gmail.com>
 <20260617-vorfahren-haften-nullnummer-b0d6fccadae3@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260617-vorfahren-haften-nullnummer-b0d6fccadae3@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/6/17 21:37, Christian Brauner wrote:
> On Thu, Jun 11, 2026 at 05:25:56PM +0200, Amir Goldstein wrote:
>> On Thu, Jun 11, 2026 at 1:32 PM Jan Kara <jack@suse.cz> wrote:

...

>>
>> My crystal ball tells me we are probably not going to do that :-/
>> But if we did, it would have been nice to validate that LOOP_CHANGE_FD
>> does not set the backing file of loopA to a file on fsB ;)
> 
> LOOP_CHANGE_FD should be removed. I proposed that years ago because it's
> problematic in other ways. Everyone agreed as it was effectively unused
> I just never bothered pushing it through. So let's not worry about that
> let's kill it instead. Here's the patch from 2023:
> 
>  From 46db77d781d329b7fc7b3245dd295a69026f6ec0 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Mon, 6 Nov 2023 16:29:32 +0100
> Subject: [PATCH] loop: remove support for swapping loop fds
> 
> We did not find any users of LOOP_CHANGE_FD.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I am glad if it could be dropped so at least I will not
worry about missing features if fs shutdown is
implemented in erofs.

Thanks,
Gao Xiang
