Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321133AD9A
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774156504; cv=none; b=KnFTdBZ5tKvhWV+TOyHzikQdeQo73lDTnCfNXMGVBuZJnOSW4i5iv7a9ZpRZfhpEsMjC4sxOTWLd1/MWYxWyrO32UIsL9cCg3iIsRvxYMUxlhCzsM0f5m4ZL0MI/9z8cLEUKid01lodnENMktXyY9qvttH25+ZDMeznL0qD6Omk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774156504; c=relaxed/simple;
	bh=LDIAYUs8tob7nVIVdv7QU9yzERHHWIu9l+17oNCJFXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkQn29n8XGHq9SWEa52fjLIyW8x+I/xvbstFF/rKAStfKubAyohiI4dqNKZyOlv+3yfT1SdlFXpr614cgDqRFga4frQsOAOfXFnVwrNZ1Wv0nVitHGGMskWICNW47SG4/Cf/cEFdiL1hTeS5ulfneKLvAaa32sceocMcbag319E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=il2x6fF7; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="il2x6fF7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774156497; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5/XpVs3lIDwNxiqfq0aiNU/HpsT4HvHvC0Dzaz8Y48I=;
	b=il2x6fF7m3H4bwN9cz8ogzihrhNUDyFfX2qcY+ctrykcBUz/xZSI+mjEuC9/I9FjmHt2m/6vTIpd52E2otmPdcOHj2CIAmJSBbhqqNhB0yhN0XN7c+j2WLi/jO1GXaRrnhw7yePXi66NC1HY5qZiaI3fx8NOI0kA1kBLTHwoVhQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X.QGwLI_1774156495;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.QGwLI_1774156495 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Mar 2026 13:14:56 +0800
Message-ID: <4a1fd8dd-6c8a-43bd-877d-c37720ac1e21@linux.alibaba.com>
Date: Sun, 22 Mar 2026 13:14:55 +0800
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



On 2026/3/22 11:25, Demi Marie Obenour wrote:

> The only exceptions are if the filesystem is incredibly simple
> or formal methods are used, and neither is the case for existing
> filesystems in the Linux kernel.

Again, first, I don't think "simple" is a helpful and descriptive
word out of this kind of area:

"simple" formats are all formats just archive the filesystem
data and metadata, but without any more use cases. No simpler
than that, because you need to tell vfs the file (meta)data
(even the file data is the garbage data), otherwise they won't
be called as filesystems.

So why we always fall into comparing which archive filesystem
is simpler than others unless some bad buggy designs in those
"simple" filesystems.

Here, I can definitely say _EROFS uncompressed format_ fits
this kind of area, and I will write down formally later if each
on-disk field has unexpected values like garbage numbers, what
the outcome.  And the final goal is to allow EROFS uncompressed
format can be mounted as the "root" into totally isolated
user/mount namespaces since it's really useful and no practical
risk.

If any other kernel filesystem maintainers say that they can do
the same , why not also allow them do the same thing? I don't
think it's a reasonable policy that "due to EXT4, XFS, BtrFS
communities say that they cannot tolerate the inconsistent
consequence, any other kernel filesystem should follow the
same policy even they don't have such issue by design."

In other words, does TCP/IP protocol simple? and is there no
simplier protocol for network data? I don't think so, but why
untrusted network data can be parsed in the kernel?  Does
TCP/IP kernel implementation already bugless?

Quite confusing.

Thanks,
Gao Xiang

