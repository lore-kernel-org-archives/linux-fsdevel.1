Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525E1FF5E3;
	Thu,  2 Jul 2026 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960170; cv=none; b=Oqu5ePxlwZ3IatDO3DWc2RpHZ7y9qcH2Vx/sFfMduC9CDrXTc0VEinYVBrNas4iJCZznLfFNahjJmrqu/aJgNYkX9yKDxwycXS6BBLtrNz5n8gN+3cLvtPLVUrE8qu48ThtrDpVgMQ0fMlbDe3zdNpj+zNt9/TVRzut4+ZqLE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960170; c=relaxed/simple;
	bh=mZx85SmqurJw5XpRcNyNyJ0HFKrbxPsiHTk5jJ/Y/XE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J6lVZJUwHE2ojJj6trPFK4Fjn8aLR5nYpeOIvkB1axMruO2SVvK+dzIBSo8L6gYZFTgGxNhyvxlycTNn5rRlqQcALyGH72puKHjtDvaKfBs43Mogvd9ZSSGIXiD2Sj3Y7yvvIygZTO13cqtvgDMkazZWcM6xspAiGqL+YmBQYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZRtM7fa0; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZRtM7fa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=6Pn4pf6f5s+K9mk+WFRvSch9mSawLEvD0kBg3n7MWcA=;
	b=ZRtM7fa0jhc/T2xn1mO349xz/fT2mmi8ZuhfP1nNfAi1a7Ifa6kG6MpYiuZxvM
	+sxLIipVkb8yf87VYafUSxe4qT2rwqFxvoEBunEV/8DbTpGbV8EcjOL4ZG4pxAUh
	ASxFbZqte2kxtSGbTJ7xDNAKeraD00cJ3yLJ/zKGNgXjk=
Received: from [192.168.3.124] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBX6lsM0EVq9a7uGA--.114S2;
	Thu, 02 Jul 2026 10:42:25 +0800 (CST)
Message-ID: <613f117f-e192-427e-ba88-4a060250e7db@163.com>
Date: Thu, 2 Jul 2026 10:42:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exfat: validate cached iomaps during buffered writes
 and writeback
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260702023116.829321-1-chizhiling@163.com>
In-Reply-To: <20260702023116.829321-1-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBX6lsM0EVq9a7uGA--.114S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrXrWrAFyrJry3Xw1UXw17GFg_yoWxGFXEvw
	1vvryrGa1jvF1rJr47Xw43ArZ2vFs5GFn8X3yUt3srtwn2gFs2vF1xZFnxtryjq39rGF1v
	yr4vkw4UJFy7XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj8nY7UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BEkwWpF0BHYzAAA3S

On 7/2/26 10:31 AM, Chi Zhiling wrote:
>   		error = __exfat_iomap_begin(wpc->inode, offset, len,
> @@ -269,3 +271,12 @@ int exfat_iomap_swap_activate(struct swap_info_struct *sis,
>   {
>   	return iomap_swapfile_activate(sis, file, span, &exfat_iomap_ops);
>   }
> +
> +static bool exfat_iomap_valid(struct inode *inode, const struct iomap *iomap)
> +{
> +	return EXFAT_I(inode)->cache_valid_id == iomap->validity_cookie;
> +}
> +
> +const struct iomap_write_ops exfat_iomap_write_ops = {
> +	.iomap_valid = exfat_iomap_valid,
> +};
Sorry, this patch causes a build failure. I'll send a v3 as soon as 
possible.

