Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0079F3D5F27;
	Thu, 22 Jan 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100042; cv=none; b=nOSCkFDCZ7bc+AH6iqmqqTjQ2d+qJqp2FAHVTwtqCom/5W4G9Bcz9J5ux9c8X/fO3QIQr7EkcybDGPBxgErHLpsiVlQjGIcsrCQAxlqsHxOT+XNSI2CGU0t+MQf0ChGWJ8aBQ2QM5faJP9vsa4+NTHVAcsc6Nsl6mFCP4oBXjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100042; c=relaxed/simple;
	bh=LFQ/OHmthFs8z30IX0b80eIK1cGfhlnFvuTJP9xo84I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRzLiXffPm5uf0uH+ihMfBQsncGKv2n60roSUdSmfXBp5g8So5iR5iMD1iyamznR+J9tb2c/EcugRev29MLgyw4kB596OJXPE2IKNaOwuwf9K4UlShBjdt2LeOq35L0GtbRFZjmE/VMewZvTnw3W0Znzr6BviIqDZvQrduf91aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x1M6DtwY; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x1M6DtwY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769100034; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=syGS9brh/yDzXJb2T0Cga/xLH20nK1dJL8Pud/2n4Lk=;
	b=x1M6DtwYJ9XGZf4MSpP/AgFSkdgAlR5aTfRKpM/igzlmbHMaO/XltD71Io83R6eF5qzPjlQchpQ6y/3hjrpmD24to5mePhMh6x8lsTRUb61hZi6Im+cCCc9MrpvxhavPfmrOAeOKGcn0ibpFutDwPkE6ZhAWDmi1zHFKlCchaFw=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxcwsl0_1769100033 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 00:40:33 +0800
Message-ID: <87884a51-f6a7-486a-96f8-26d037f9dd76@linux.alibaba.com>
Date: Fri, 23 Jan 2026 00:40:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/10] erofs: implement .fadvise for page cache share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, Chao Yu <chao@kernel.org>
References: <20260122153406.660073-1-lihongbo22@huawei.com>
 <20260122153406.660073-11-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122153406.660073-11-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/22 23:34, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch implements the .fadvise interface for page cache share.
> Similar to overlayfs, it drops those clean, unused pages through
> vfs_fadvise().
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
