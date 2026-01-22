Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5105353EC4;
	Thu, 22 Jan 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099306; cv=none; b=ESNmxcYrGgtCbsm9EykjSD4BDuJasb2va9HTk+p1vEhSdRIM6QTCaLkj20/esfWwndp04m4FUS78MB8dVgT58OVI8KybHsnnlztb4S+ATo8eLNF8A/0dPiO4jyr611UhtVP9H6BH/kRuzygU2mBCzUiT2nr2AZpSFMjdgRENokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099306; c=relaxed/simple;
	bh=x0RRb4KhkxV2/ugkUwlBx8quJ9+6DnZcshRM2yP9ljs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCPiw9yTFGbz/dQlMyqKmi3AZLocHf81EkQk2D/W5YqJ09oBjRPP/YKh+IokZRwT41oWUiOy8e7SeJANoes1LUXreAGwWUdQCi5PhoyJWJXcmnXaK/k0Ant7OK7et3KzMocZCMJbNR4GaC7iCi2fe32iSSNc26JJbfVGOEFGf0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ljiZJNW0; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ljiZJNW0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769099294; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XWX8sKG8xrwbs9iqmEBS/RJQlvN79p8s5kBuqCBWZqo=;
	b=ljiZJNW0SLqyHXlLk2RcA4t4F+ZZ91udgeS8vhIWiT+sXPBG4vkYRkS2AFS0Aoo2X3tMbZYINniiMKqyrcARqdu0zrjzlTWAU3AAP8aWeqvwxf/mZlXPLLuWfo7cGSn3gVf0IBY0SGOF9F4E4YCJHbGB3TyFgPaWI1fidsq54sw=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxcw24g_1769099293 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 00:28:14 +0800
Message-ID: <98cb255a-86c7-48b2-a8de-e7bd9dcb72bb@linux.alibaba.com>
Date: Fri, 23 Jan 2026 00:28:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 04/10] erofs: add erofs_inode_set_aops helper to set
 the aops
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, chao@kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20260122153406.660073-1-lihongbo22@huawei.com>
 <20260122153406.660073-5-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122153406.660073-5-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/22 23:34, Hongbo Li wrote:
> Add erofs_inode_set_aops helper to set the inode->i_mapping->a_ops
> to make it cleaner.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
