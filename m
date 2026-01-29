Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048EA37BE71
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678527; cv=none; b=YAg4gUNLP2+OfVHdrNc9QMtH+Tm+PCtjFmSPKDg5Na5h5x2g6eIhNhHa2H+fGwzRot5b1K92m4SJqhj4EmT4fKo0AeWdmUDVay4K6uL/dBtpo8g7OQO9rEIjMudaZf0ZgO0D73r+M3e6xfk5a7X+tXzn1g1RBBKeXBAlP0oQcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678527; c=relaxed/simple;
	bh=t/kbRXCBwYgVNjvjwowHSWRsY+nKJNPEbjD9l/i+ONw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqhCdjYve8710ei8tJvU9sHBy2Dc4kED25O7WutA4itBPewSmVH4J2+AULKbbzhdAFdZxHXWUGDjV8nIob47i5Y62ydMdMY7zBAFO+SeQ8Sv1cRlvOJXZZuKipMwvsTOs8bNuxswDbZNmrzOO4bOGHgoVggSOjUdpCFBqfmECHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MAmopZT9; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MAmopZT9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769678516; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dvYhqz/D1UEmV1UCtNYMkzkgB8fONkP/7WnRfF0jNcI=;
	b=MAmopZT9f/BoZp7oHJM4TX7KQea1HD0XQlTsjUumX+6bgU7c+1hfEWkVePniJ6ADLdqk41qA0DpjFMpDBWzKGf99DAcE5WwHqolrxoxCbl5/3Lb1AIQO8noR4FZhLoQfPZDPAUXDIlI9ruixYdfxlhD5zvtp4YQ4CRlauUdcsrw=
Received: from 30.221.130.123(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wy6wbrK_1769678515 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 17:21:55 +0800
Message-ID: <4dd236c2-2ada-4d2b-a565-5c94904dcc23@linux.alibaba.com>
Date: Thu, 29 Jan 2026 17:21:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/iomap: Describle @private in iomap_readahead()
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>,
 "Darrick J. Wong" <djwong@kernel.org>
References: <20260126120020.675179-1-lihongbo22@huawei.com>
 <20260126120020.675179-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260126120020.675179-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2026/1/26 20:00, Hongbo Li wrote:
> The kernel test rebot reports the kernel-doc warning:
> 
> ```
> Warning: fs/iomap/buffered-io.c:624 function parameter 'private'
>   not described in 'iomap_readahead'
> ```
> 
> The former commit in "iomap: stash iomap read ctx in the private
> field of iomap_iter" has added a new parameter @private to
> iomap_readahead(), so let's describe the parameter.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601261111.vIL9rhgD-lkp@intel.com/
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Could you apply this single patch kernel-doc fix directly?

Thanks,
Gao Xiang
