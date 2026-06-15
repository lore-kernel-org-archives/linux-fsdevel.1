Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C83E316D;
	Mon, 15 Jun 2026 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525804; cv=none; b=AsFc5kNldjhl40Q4BpwcUdXui19BAirb/0NdRcQPeCDh8VIze6KSUyXH8nlQ8HgsycfTwJ8HeR4JUgkmJDDxOQUpOJpvq6aCy8GOtU2jF90k9cU0DdAoJZOHYuqO5JPloYNX2OfqwUud0As1J77PmtiP7dHsF8E0umkxZOR5Pbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525804; c=relaxed/simple;
	bh=Ep4St/MXU/i6+fDCyEyaPjKwT6BoIfMp/hPwPjd1NwA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MetfyPjytKgDmVWfYyApS4iatVTTRlTHWuGJ7EmGb4q4Hyy74PTD5BdlZVwEgGoMl6PkcCispuU1mDeAIgyu9sidjzjptRG8YZkAJMgSOpJ6MDYdRCuRKcHxcuSytRxmDv077C1/7blVkMlFaFvBxFTIn9wNTziyFtRivSn+L1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GI4sxPVx; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GI4sxPVx; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GI4sxPVx";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GI4sxPVx"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i3fvrmeoyMD3lHK+GthpqTQ/lqfDCBQbHMQZ1AjT2aQ=;
	b=GI4sxPVxhjqrJZysCMfnpgv5Xo0eQJve0HNhqcWveqpGn0vvP1H9SkWUo3H7k+CBsJRDv/5bX
	CU8K9ll3Rbjt4t6u0AEHTc5Mgn2bR3ime1jHZZbHSmP4keGeRVq3wJNAaRon958eb/NyIZPIGGS
	3b5EQB5mDXiEXZsINr6URrA=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gf85r6LXlzcb0b;
	Mon, 15 Jun 2026 20:08:16 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i3fvrmeoyMD3lHK+GthpqTQ/lqfDCBQbHMQZ1AjT2aQ=;
	b=GI4sxPVxhjqrJZysCMfnpgv5Xo0eQJve0HNhqcWveqpGn0vvP1H9SkWUo3H7k+CBsJRDv/5bX
	CU8K9ll3Rbjt4t6u0AEHTc5Mgn2bR3ime1jHZZbHSmP4keGeRVq3wJNAaRon958eb/NyIZPIGGS
	3b5EQB5mDXiEXZsINr6URrA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gf85j4m21z1T4Fv;
	Mon, 15 Jun 2026 20:08:09 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id DC40940575;
	Mon, 15 Jun 2026 20:16:37 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 20:16:37 +0800
Subject: Re: [PATCH] fuse: virtiofs: fix illegal inode address access in
 fuse_release_end
To: Miklos Szeredi <miklos@szeredi.hu>
CC: "Darrick J. Wong" <djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>,
	<yi.zhang@huawei.com>, fuse-devel <fuse-devel@lists.linux.dev>
References: <20260514124102.2703313-1-chengzhihao1@huawei.com>
 <20260515210719.GD9568@frogsfrogsfrogs>
 <953d1dc7-f1a4-88a8-1db4-0902b902055f@huawei.com>
 <da9772f5-d20c-0efe-2fb8-74f14e8d490b@huawei.com>
 <CAJfpegv0SYbE_TB7Xy24VWDFSvghHexwzxLJ-SyNQ7BXky4hLw@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <1dae8432-d890-845a-6552-967665fcf143@huawei.com>
Date: Mon, 15 Jun 2026 20:16:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJfpegv0SYbE_TB7Xy24VWDFSvghHexwzxLJ-SyNQ7BXky4hLw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2026/6/15 20:06, Miklos Szeredi 写道:
> On Mon, 15 Jun 2026 at 13:08, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>
>> 在 2026/5/16 11:20, Zhihao Cheng 写道:
>>> 在 2026/5/16 5:07, Darrick J. Wong 写道:
>>>> [add fuse-devel]
>>>>
>>
>> friendly ping
> 
> This is fixed in fuse.git#for-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?h=for-next&id=19e8d6bd9ec35db2221e84bfeb1862ab6688a4bc
> 
> I added your Reported-by.

Fine, thanks Miklos.
> 
> Thanks,
> Miklos
> .
> 

