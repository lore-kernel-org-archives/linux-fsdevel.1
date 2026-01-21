Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127328B4FE
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961299; cv=none; b=pyah7boB9us64HAqAl2t619VENI/ebr96J708voEPOccfI1gW8oopqn6vKareqfdxZo7TD0az2BmE05GIsPMG8+OjqtIccTj22Xle08zCMLaYvQlH5n3HOkbW95f4lNZ5MLNzQdeYcYTTsdaQ+zizcPaYGl5VdR6sMwnKjFCXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961299; c=relaxed/simple;
	bh=sE52spwYthUgFaid5KERMXYZ5L9Yxe42CWGNoynci6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7TfEtknz2dsk1lszjKbX9lRTsjbt+GqR1hyzhVrJ9/cU4IR+0k77HQwtxXrIUNnq+GN6JtyIFZWLup1aR1N3PhXeIX1rOA9Z6Qr9Da46jRzrPVTPHw8FTbSieEc1Xt6li8MfEQ5NKeOeYy/VcCEVOjumut4r8EpaN0Ps/AFvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cDAphjUS; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cDAphjUS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768961292; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7D8IpxFE3MQLw82CE4MDZh4WPRKIYF7T4YFIYYPpkpI=;
	b=cDAphjUSLqcd5Q3KnadIVIKPDTFGlzWy9DllKlRDRn/7cwqCQHU+6s8HqexAr1fvC+KqKzlDxUuk4QHbU5nm/PTcmv/RG3R8vgCS6avzECPDKFvekFLtTpyv43j8wVc5466bMJ7+MTQP4zXfQR/0F/XgVEMdFht8VyVZff7Zzds=
Received: from 30.221.146.111(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WxWGnl1_1768961291 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Jan 2026 10:08:11 +0800
Message-ID: <8e23cfa0-5648-4d07-b873-b364148bca60@linux.alibaba.com>
Date: Wed, 21 Jan 2026 10:08:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] fuse: validate outarg offset and size in notify
 store/retrieve
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: luochunsheng@ustc.edu, djwong@kernel.org, horst@birthelmer.de,
 linux-fsdevel@vger.kernel.org
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
 <20260120224449.1847176-2-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260120224449.1847176-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/21/26 6:44 AM, Joanne Koong wrote:
>  
>  	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
> @@ -1962,6 +1965,9 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
>  
>  	fuse_copy_finish(cs);
>  
> +	if (outarg.offset >= MAX_LFS_FILESIZE)
> +		return -EINVAL;
> +

Theoretically this check is nonsense.  The following fuse_retrieve()
will ensure that outarg->offset can not exceed file_size, while
generic_write_check_limits() ensures that file_size can not exceed
MAX_LFS_FILESIZE.


-- 
Thanks,
Jingbo

