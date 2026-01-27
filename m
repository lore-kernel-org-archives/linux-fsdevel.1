Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606A30C62C;
	Tue, 27 Jan 2026 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485186; cv=none; b=cX+8VGfhE/xFJNCBmDlDbHgfrg1+Zw140aw3iqmQConsH0ondOHzRPtZfRIqgQNy9HOl0CgvSGmP4ZHs8f2JJIXz9vHgN4cYbHCBusJE2DqbWfT1ZcZD4o8x1zIGEhQ4i3DW8fGAAAUJ6gXzutg0+/YkQWGRCGr9s5T1t2iwAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485186; c=relaxed/simple;
	bh=gSeHXuR8DX2djj7+H3f82v+wWZsuq4UBEs1qhFlw63w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVmOaH2bg/EX23AhP2XxyOXs81Mi/Vp8yR76iG8pKkPAjLBLt+5vWfU3+qBsX3CPxziOCMXSqV+hCxkwlNO2n9tc75wJZejQiZ1UlMlm8Z4xJhwOk+nObABuYB3SkGn9ZaIvSI6SDs21dYhNjBCx934c5DnILOnxoO0x4186fI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZRsxevFE; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZRsxevFE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769485181; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JXX/+UhJQ3V1KOHJlhTwhRIDR47qF0HW0feoeATTwOU=;
	b=ZRsxevFEAN81jTBM996EZGGghCPHRibc//7l+1WHP3nwjt/vWRHA1EHe/8Kmuqmy1C3dhenLAO8R4eSw8nFu6AnurHjFgQxuZRbJwETsbytKa+YfyOXrgQ4WBODF8IZ5+nrdLBwUfKSerG54r1vKTSvWBt/UwZW1GdUTdOLDa9Q=
Received: from 30.221.133.109(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wy-HAhn_1769485179 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Jan 2026 11:39:40 +0800
Message-ID: <191f6576-ba2f-490a-824d-d27b22350921@linux.alibaba.com>
Date: Tue, 27 Jan 2026 11:39:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 04/10] erofs: add erofs_inode_set_aops helper to set
 the aops
To: Hongbo Li <lihongbo22@huawei.com>, brauner@kernel.org, chao@kernel.org
Cc: amir73il@gmail.com, djwong@kernel.org, hch@lst.de,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260123013132.662393-5-lihongbo22@huawei.com>
 <20260123075239.664330-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260123075239.664330-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/23 15:52, Hongbo Li wrote:
> Add erofs_inode_set_aops helper to set the inode->i_mapping->a_ops
> and use IS_ENABLED to make it cleaner.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Sorry, forget to reply this:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

btw, I've pushed the series into erofs -dev branch for
-next testing now.

Thanks,
Gao Xiang
