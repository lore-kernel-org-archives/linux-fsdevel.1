Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA63630B0
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189435; cv=none; b=swTmYxkawzHYsBAT9RRIRHl7MO7YuEA91p7RTg+w+jlWE+1rVcoGzER80MGmgoKllXJ/JprYpLApOz/GT10sTU2yOYqi07+5zN0yUjkCISHWNvUJsQZzB+BG6vaFHz+885Gv78pcQYp8Zn2ZeYt7pWERycfGZaIuCJTV1LRe7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189435; c=relaxed/simple;
	bh=xU8g5/aGqy/DJRVQspIBHi2Cf/i5++0bg1BTBIgA9/E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KufrzLrtAMHuB0ThFz7Hy+ynYWmvUgNF8Uf0+7GjFtSy9V/C+8bwIQR2ZvYRxD3CoKxPnKCwXczvzlONHhDre5RWQFU0jaJpVwQ16KJG7fN4QZQr6cGfHaxxhU2YGLUuaDLo+5MsRtzoh6NmXIFttn49QAp1IuA0qpMHoSnHtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=xMmp4cGV; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="xMmp4cGV"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 796831D490;
	Sun, 22 Mar 2026 14:23:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 796831D490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1774189432; bh=xU8g5/aGqy/DJRVQspIBHi2Cf/i5++0bg1BTBIgA9/E=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=xMmp4cGV2TKJUDnlcAsJn14bpTxhHBGW/2n+6S0x/bNa9Gu/RWlRASEVoEvoFTf4V
	 modPyzoqXZke1xB/SjEZp8dCR7n8AhnNhApWOyUDYPqtCIxpy5MTrMoGXbcn57WoS5
	 ZE4/w7LYQ+RPX++ULtaOGAPxecBeicsJhcnVvmIQ=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id mBM0Cnf7v2kwyQgA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sun, 22 Mar 2026 14:23:51 +0000
Message-ID: <860c6266-394e-4fd9-88ed-f93b80e3aa13@dev.snart.me>
Date: Sun, 22 Mar 2026 23:23:48 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Timber <dxdt@dev.snart.me>
Subject: Re: [PATCH] ntfs(3): export super block magic
To: kernel test robot <lkp@intel.com>, linkinjeon@kernel.org,
 hyc.lee@gmail.com, almaz.alexandrovich@paragon-software.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev
References: <20260319234047.43253-1-dxdt@dev.snart.me>
 <202603221308.oDwds9wL-lkp@intel.com>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <202603221308.oDwds9wL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/26 14:53, kernel test robot wrote:
> Hi David,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on next-20260319]
> [cannot apply to brauner-vfs/vfs.all linus/master v7.0-rc4 v7.0-rc3 v7.0-rc2 v7.0-rc4]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Timber/ntfs-3-export-super-block-magic/20260320-181810
> base:   next-20260319
> patch link:    https://lore.kernel.org/r/20260319234047.43253-1-dxdt%40dev.snart.me
> patch subject: [PATCH] ntfs(3): export super block magic
> config: *hexagon*-allmodconfig (https://download.01.org/0day-ci/archive/20260322/202603221308.oDwds9wL-lkp@intel.com/config)
On 3/22/26 13:56, kernel test robot wrote:
> compiler: *sh4*-linux-gcc (GCC) 15.2.0
Interesting.

I didn't add #include <linux/magic.h> thinking that it's included in the
chain somwhere so it's redundant. Apparently, I was wrong. I smell
header hell situation here. Will investigate why these two arches don't
include <magic.h>. In the meantime, if you're interested in my
suggestion, let me know.

Davo

