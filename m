Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CF1E3DDE
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741315; cv=none; b=ilg8AtXPWEmjQ+C+8QH4JuXl/kXh21IrSii3y6dsxZciIlWeFChT6NJCR977P3R9sKNC6uVYSj7LjXSe0bLCGEEqGnDgGoRrSnJWDD53NR6LYFRMpJ4LR1vVb7s7sCuOaZQpG0iWxEeI+lRVujUTkEmCiujjdvvUIBPPBleBd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741315; c=relaxed/simple;
	bh=GOUSy21JiqFmIW/kb+ADPKohJxOMSsJ0pVxhRNRBDm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6Zobso22sXz7d0ARWPuT7leBGrstFlRt+CDHmyYhzr87ZbSCCgoO+6kASXHeGAm63WuTsEXuYTKAwtq1nV30xq+hzJ0VBUU1ed82rG/yZxutu1zmTlNdxOGrJJkWwJPyCfnOL95zM6eXsm0dy2bvEWD6ScG8fVjs8IbCQ/7ock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hpuEz5ri; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hpuEz5ri"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769741310; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=33RaaeNgDXYNuPSWuy97rzuxflmqdZ8xOQJZfcMGfYM=;
	b=hpuEz5riyHla6xbdjruKfHQK0km5y9EvnBlxYY7kAm+n+7Sfc3Xxlv+IYmVkPtebD/1F32WEQoxnE7OUOzXF4dtim6Maa6L8yRYMdzeAKxsmocYETMWoCjA/vPpE/5oWTDVX+qhMsWOcVJAhm33BKIaLejlMIetyWNlGmSKo9dc=
Received: from 30.221.147.164(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wy9EUAY_1769741308 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 10:48:29 +0800
Message-ID: <f1118f14-bc78-465a-ad44-c058dc311239@linux.alibaba.com>
Date: Fri, 30 Jan 2026 10:48:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] fuse: validate outarg offset and size in notify
 store/retrieve
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, luochunsheng@ustc.edu, djwong@kernel.org,
 horst@birthelmer.de, linux-fsdevel@vger.kernel.org
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
 <20260120224449.1847176-2-joannelkoong@gmail.com>
 <8e23cfa0-5648-4d07-b873-b364148bca60@linux.alibaba.com>
 <CAJnrk1bFVPW0MHaz+oos-ze_Ns-9zOHir8OGTKfA7CcYAe=_nA@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1bFVPW0MHaz+oos-ze_Ns-9zOHir8OGTKfA7CcYAe=_nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/30/26 3:30 AM, Joanne Koong wrote:
> On Tue, Jan 20, 2026 at 6:08 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>> On 1/21/26 6:44 AM, Joanne Koong wrote:
>>>
>>>       num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>> @@ -1962,6 +1965,9 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
>>>
>>>       fuse_copy_finish(cs);
>>>
>>> +     if (outarg.offset >= MAX_LFS_FILESIZE)
>>> +             return -EINVAL;
>>> +
>>
>> Theoretically this check is nonsense.  The following fuse_retrieve()
>> will ensure that outarg->offset can not exceed file_size, while
> 
> imo this check is useful. It'll directly error out fuse_retrieve()
> with -EINVAL which I think is the correct behavior. Otherwise,
> fuse_retrieve() has the "if (outarg->offset > file_size) { num = 0; }"
> check but this still sends a FUSE_NOTIFY_REPLY request to the server.
> With that said though, if you feel strongly about this, I can get rid
> of the check.
> 

Okay that makes sense.  I'm fine with the prerequisite check here.


-- 
Thanks,
Jingbo

