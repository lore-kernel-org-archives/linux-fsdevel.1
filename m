Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC62874F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043528; cv=none; b=P5UT0JuSKtnTyJZgDCQscHiISVgOlgyH4bzMpmgaIA1bL8p+fgcPRAXlCJycVnR8lvPEK19p8vyyF/0kkisKBsd87VxQn4cGNAkAsJ4UyZ6KH+WkSd+oo0sNlGOht5mUy+hkMqUNSsOkx4hePnBegE83OkM4YS/lsy62NgjHxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043528; c=relaxed/simple;
	bh=vbchxXmaT1p6LDzzSD7o39RGshVjY9Fc6Ws718Ry/mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdpmiWJDxB1cWyPdPX6xV+9F16Q6Y99ZMCX5G7Jt3QdiSyzpa9KLxjSVK0/xLmxOAgb5tMfMgqnyXM0ItoIJlenjLcu1v/AXNwF10uTfVVbkW4gEz1Je2gyY0eFk5HgEyfa24MlfjTCKVQUUpfULPCt4yyu2+rLNchAsNCea5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kCwFg9Oj; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kCwFg9Oj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777043516; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iUo/7TuyEFMd00rE0dpf4oPPcZQPSw76TdVjf5h4L2o=;
	b=kCwFg9OjSHaaYL/FxhAMGHXk9Eq3MV40kUYp1NsRntNUNQermcVkh1BhsebgRP6E6LAWjLEP79uM1X86YzqQtfhfq0zFfB0mNQgyi743HqFhjblc42yK4PQUGMqqcVr8HWU7lHxEDem0WO2SvKrLEFxS51lOdsTiutrNa9oi90I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X1cq6bx_1777043195;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1cq6bx_1777043195 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Apr 2026 23:06:36 +0800
Message-ID: <d9ac4def-a34a-4748-8cc8-d63b460ba8ab@linux.alibaba.com>
Date: Fri, 24 Apr 2026 23:06:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iomap: remove over-strict inline data boundary check
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: willy@infradead.org, xiang@kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, hyc.lee@gmail.com
References: <20260423213203.5533-1-linkinjeon@kernel.org>
 <20260423213203.5533-2-linkinjeon@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260423213203.5533-2-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/4/24 05:32, Namjae Jeon wrote:
> The current iomap_inline_data_valid() check ensures that inline data
> does not cross a PAGE_SIZE boundary. However, this is an unnecessarily
> strict constraint. If a filesystem provides a valid iomap::inline_data
> pointer and iomap::length, we should trust that the caller has mapped
> sufficient memory for the range, even if it spans across page boundaries.
> Removing this check allows filesystems to point directly to their
> internal data structures without forced page-alignment or additional
> redundant allocations. This remove iomap_inline_data_valid() and
> its callers in buffered and direct I/O paths.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
