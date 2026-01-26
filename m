Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7E2FE571;
	Mon, 26 Jan 2026 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769400257; cv=none; b=G0NgmAl/e8foyYxCE5cnjeQ23B3SxG9c5I4dEAksY9cltWFmg+FAOe+Kn9rooI/01FrnARfGojCRKWeBKXk/pOtq8hv8gCFNzQBOgr9bAhwIyuArKE3qUxVrGi2LpRBmcEH//054MHJOslrs1jGxUiWzJsEcQqUNjWdMfzJ+EEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769400257; c=relaxed/simple;
	bh=9mGrxQAdqrJqfZlF+ojGHteJjxO12gMXVuM/YaXcHzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNqZFMdGWPhljDZh9Ka5oxIMc/S0tXupsad12MDWd9Pjx5G7fD7cUjFZcwOTDuyV8MAuRiLdET64RABblf+uaE/Bzospz172wCcEs1XypPXwMctzY7jlvHv1+t6g+kjRRH3kmftufuEWfub39duT0EUWCCPf83a1ikb8aQvBF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SubR801r; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SubR801r"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769400247; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R3WU+rzl4kQ2/5LwsMxklG3faBx0Hcvrzfc5zqCOnhk=;
	b=SubR801rSod56TUc1aIafCcQTLQh7wXLm4pKo8cCl2NWVt09CbGWeRTDgci0lABSHQ2I8a4Dudbsm+7MVxNEyk6JdPhMpnmQQUYvHY6m9+sP5oDt9+wP7R2I2kZQKL+9f0VFpMHxQiOABHsHk70MFxIE9Ucpe7wJjBfGAhGFnTE=
Received: from 30.221.131.255(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxnO9T-_1769400246 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Jan 2026 12:04:06 +0800
Message-ID: <55e3d9f6-50d2-48c0-b7e3-fb1c144cf3e8@linux.alibaba.com>
Date: Mon, 26 Jan 2026 12:04:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] DAXFS: A zero-copy, dmabuf-friendly filesystem for
 shared memory
To: Cong Wang <cwang@multikernel.io>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>
References: <CAGHCLaREA4xzP7CkJrpqu4C=PKw_3GppOUPWZKn0Fxom_3Z9Qw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGHCLaREA4xzP7CkJrpqu4C=PKw_3GppOUPWZKn0Fxom_3Z9Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Cong,

On 2026/1/25 01:10, Cong Wang wrote:
> Hello,
> 
> I would like to introduce DAXFS, a simple read-only filesystem
> designed to operate directly on shared physical memory via the DAX
> (Direct Access).
> 
> Unlike ramfs or tmpfs, which operate within the kernel’s page cache
> and result in fragmented, per-instance memory allocation, DAXFS
> provides a mechanism for zero-copy reads from contiguous memory
> regions. It bypasses the traditional block I/O stack, buffer heads,
> and page cache entirely.
> 
> Key Features
> - Zero-Copy Efficiency: File reads resolve to direct memory loads,
> eliminating page cache duplication and CPU-driven copies.
> - True Physical Sharing: By mapping a contiguous physical address or a
> dma-buf, multiple kernel instances or containers can share the same
> physical pages.
> - Hardware Integration: Supports mounting memory exported by GPUs,
> FPGAs, or CXL devices via the dma-buf API.
> - Simplicity: Uses a self-contained, read-only image format with no
> runtime allocation or complex device management.
> 
> Primary Use Cases
> - Multikernel Environments: Sharing a common Docker image across
> independent kernel instances via shared memory.
> - CXL Memory Pooling: Accessing read-only data across multiple hosts
> without network I/O.
> - Container Rootfs Sharing: Using a single DAXFS base image for
> multiple containers (via OverlayFS) to save physical RAM.
> - Accelerator Data: Zero-copy access to model weights or lookup tables
> stored in device memory.

Actually, EROFS DAX is already used for this way for various users,
including all the usage above.

Could you explain why EROFS doesn't suit for your use cases?

Thanks,
Gao Xiang


> 
> The source includes a kernel module and a mkdaxfs user-space tool for
> image creation, it is available here:
> https://github.com/multikernel/daxfs
> 
> I am looking forward to your feedback on the architecture and its
> potential integration to the upstream Linux kernel.
> 
> Best regards,
> Cong Wang

