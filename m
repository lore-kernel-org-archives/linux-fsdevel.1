Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D822D12ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655487; cv=none; b=exXEE01asOMBHXwMuXn2Q7bnB9pIxAeq1Pjczih8Lc43kIVw4Amq9edlJKSvAGIiBEMfoA6NRk8xNKHKiLuyx7yWDJTj921nHOZfwK9DOqtQOONZRC++FzUwLjtL2RMrjwTJCL6qLWPA1vBd+TyN4vceyR2AAm3K7IcRneHwgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655487; c=relaxed/simple;
	bh=AknfT6DOvNis5ZvNGkVKzRf4gJ8SGhx5DmaESprlZB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtKv/iLTSNazC4+AaBlXMw6LUM1zEdGIuGE4QY2MFmS71zVu2GPd+KSxKuYVZM223uMf0/7lOvmDoEN9kdcsD3A5GYGVuV622cwGffP85Qm/49KoiQaBtAHQNPCSHdJQM3bRl1b2Bvohyz0NS2ufU+48z6J5xwN18iw8q6oms3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dHi3+ung; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dHi3+ung"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778655480; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hnMM+47wijWEsiSC/Rp2YSplBxkVNxtL2pqSMMI2mHU=;
	b=dHi3+ungoee4ug8VGL+PTDK/7G3r7Hxjqqjc6Pzn89SGS2SpBNp443fNJPOVI1CnEbe5SMf8tsP/8qQPN/aOVnztUk3/y3FyFcAJ1QryvSslf3LIOfyf5y8w1CyQz0/mg7yHcH8gspBYuOMRJYWrOs09BUjytvSZULBvxMd2pKk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X2svuPR_1778655479;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2svuPR_1778655479 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 May 2026 14:57:59 +0800
Message-ID: <fe714fbc-c9a5-4c26-8b7d-6976adb56b63@linux.alibaba.com>
Date: Wed, 13 May 2026 14:57:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [post LSFMM summary] where is fuse going?
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel <fuse-devel@lists.linux.dev>, linux-fsdevel@vger.kernel.org,
 John Groves <John@groves.net>, Joanne Koong <joannelkoong@gmail.com>,
 "Darrick J . Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>,
 Horst Birthelmer <horst@birthelmer.de>, Luis Henriques <luis@igalia.com>
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <CAOQ4uxhnOEkX4qnn0wHMCqWhEeAGTR9rxcw5u_oqGUovuszo0w@mail.gmail.com>
 <943cb464-78f3-44a7-92a7-57a1fe4fbc10@linux.alibaba.com>
 <CAOQ4uxh4yKEBdgbkfZTVyYM1P8ahALFVJzQCj7ASkrH746_4xw@mail.gmail.com>
 <CAJfpeguR=x+Kf7jd4zyeSoUtbjaPRLhXCRh9wa3c14x+M77kXA@mail.gmail.com>
 <CAOQ4uxiTowEnpQR3-oBXM3Q5uxBf5PXeNu+Qda8CVeD0fTHfXg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxiTowEnpQR3-oBXM3Q5uxBf5PXeNu+Qda8CVeD0fTHfXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/5/13 05:40, Amir Goldstein wrote:
> On Tue, May 12, 2026 at 12:01 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Tue, 12 May 2026 at 09:53, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>>> The problem is only with  fuse_passthrough_mmap().
>>> Depending on the workload (?) mmap may not be important and
>>> we could fail if trying to map cross-backing-id regions.
>>
>> mmap(2) is the main entry point into famfs,  so it's very important.
>>
>> That doesn't work with "traditional" passthrough and needs to do the
>> DAX mapping that famfs currently does.
>>
> 
> Yes, famfs surely needs mmap to multiple daxdev and this is done.
> 
> I was referring to Gao's question about dealing with non-dax multi
> backing id (const mapped) files.

Yes, it can work on DAX and my question was all about
mmap backed by multiple pagecache-backed files.

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.

