Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C488363C75
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259767; cv=none; b=Iy+VSnSc/o4XanK2bH2TFuzMqftYmnooMSav8Qkh/fhMOnsrerioTcOh5QD/iy4jCw9HIwVb/aqCaTYdLi6KulOjwcG2ZOVRFFei3roWRTSrFH7TAx4rUfGziUDWNIMr/GV5nC5+XgItaov1pPO3TInjB3ox2uyMgAOg7ul3Um4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259767; c=relaxed/simple;
	bh=NrTd09WQ0Zfo1XlbtvAWTsKgz96bNdFvyTZaJ/pdt+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkt8jcMv78bxJHjl4J9GiNjzCWPx7vf5v2uJn8oTKY9Pba+Zv+yqo1uoIw14Icvh6KZ62gs0IAqohct0xrsirBoF0v6qJrhW1HV7ev/tSq5ds995i8TQTT0+kY5S21H4d2CkmC6WHW2PqTE1gED/oXPGT61Ihi6PmNLwveFxnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qmFOxNhx; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qmFOxNhx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784259760; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5DvvIMn/V+Lz9bnP310CzHmXUZlWMDUr4Pw3ahRkInA=;
	b=qmFOxNhxT+YOnD15x3Yut5u9DfgRSoH9y7RmDqaBDSxcnahEAOSDx5X4ABaLoNPw5vmvEg+2rof8yBagX07NjFVnSS5TReFLsTTghIlvDlywAxfMNDj4lLLXigWS7yeX7d2RKty0pWyFbTesWkptKBiNCND4CaLeqyw/iFni6YI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X7G2Tnf_1784259760;
Received: from 30.221.133.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X7G2Tnf_1784259760 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jul 2026 11:42:40 +0800
Message-ID: <a3ee4538-6273-4d25-90d0-8dbaac092a38@linux.alibaba.com>
Date: Fri, 17 Jul 2026 11:42:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org
Cc: cyphar@cyphar.com, linux-fsdevel@vger.kernel.org
References: <20260714154917.489993-1-gscrivan@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260714154917.489993-1-gscrivan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Giuseppe,

On 2026/7/14 23:48, Giuseppe Scrivano wrote:
> Allow userspace to pass an already-opened file descriptor as the mount
> source instead of a path string.  This is useful for tools that already
> hold an fd to the image, such as composefs reusing an existing erofs
> backing file.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Use the current erofs-utils testsuite, the following tests seems skipped incorrectly.

[Error 22] Invalid argument
SKIP: erofs/008
[Error 22] Invalid argument
SKIP: erofs/009
[Error 22] Invalid argument
SKIP: erofs/010
[Error 22] Invalid argument
SKIP: erofs/011

[Error 22] Invalid argument
SKIP: erofs/017
[Error 22] Invalid argument
SKIP: erofs/018

And the kernel message shows:
[  116.477816] erofs: source is unsupported
...

git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-tests
$ sudo make check

Thanks,
Gao Xiang
