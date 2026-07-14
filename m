Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDDC3DE451
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011523; cv=none; b=Qd5ftnWASth+hsqnBb7bGViu70NyHPEuOOCQANuEDt+06Z8RCnsUrnDAqtP0I0+3gQRUb1rxSL7u0nHdTTc8kg93GmbZp+GBW6f+K9FiLyoKptirQ3c/PYfInDn62onyR+tWroi9iuCpY5nm+Egcaq/iSuhQY6QqFvREadQXgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011523; c=relaxed/simple;
	bh=27uPRkLZUQlcSLn6dzwQ5vfOoXym42IQFixFDO+WdpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdVSuQQ+BaYx7lxCTfA1oA/DeDNldcxiuu3HFfDDHghIMD4kDq3cfthcne8D2HjjUTy4sOw/u2NhJq1GQfVa8/SBvHkxGksYAq4WQlYRa++BJRBU3WeXHmi3gcCcp/HmxA/udEch9QWQizTWHzaPblblIiGHqNj2m62WTh32RtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OZQaA6DK; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OZQaA6DK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784011510; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vGbmFD6y9CGGcHfpyGvrjOOFr/zJMI05639wnL9HMzM=;
	b=OZQaA6DKHwRfVFBhAxgGjE8J+lq4SqV8NztJWAv7rZ6XctT2jfW0bRb6mToM2yeZx6mg66rKDCZ80QM33J7d276uVKZB0JBK+I43tb/a7BozBxfO2i2Jq2rlltlSQhO5Fe6sBxA3HdeXFrvGL3Fdf6AQWbk2boSuEsy13fYQeTU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X73ODja_1784011509;
Received: from 30.221.132.65(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X73ODja_1784011509 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 14:45:10 +0800
Message-ID: <c812e638-8a66-4dc0-b8d9-c971134bb413@linux.alibaba.com>
Date: Tue, 14 Jul 2026 14:45:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
References: <20260711071137.4130824-1-gscrivan@redhat.com>
 <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
 <871pd748kh.fsf@redhat.com>
 <2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
 <87wluz2nnc.fsf@redhat.com>
 <2026-07-14-drafty-folded-woes-volumes-Z93P4V@cyphar.com>
 <ba9cf493-45c8-45e8-9e21-9731ec492030@linux.alibaba.com>
 <87pl0q2i2r.fsf@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87pl0q2i2r.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/7/14 14:36, Giuseppe Scrivano wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
> 
>> On 2026/7/14 08:49, Aleksa Sarai wrote:
>>> On 2026-07-13, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>>> thanks for the hints.
>>>>
>>>> I'll prepare a v3 if you are fine with the version below:
>>> No worries, and this seems more reasonable at a first glance.
>>>
>>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>>> index 86fa5c6a0c70..72c85cc53085 100644
>>>> --- a/fs/erofs/super.c
>>>> +++ b/fs/erofs/super.c
>>> ...
>>>> @@ -437,6 +439,38 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>>>>    	return false;
>>>>    }
>>>>    +static int erofs_fc_parse_source(struct fs_context *fc,
>>>> +				 struct fs_parameter *param)
>>>> +{
>>>> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>>>> +
>>>> +	if (fc->source || sbi->dif0.file)
>>>> +		return invalf(fc, "Multiple sources");
>>>> +
>>>> +	switch (param->type) {
>>>> +	case fs_value_is_string:
>>>> +		fc->source = param->string;
>>>> +		param->string = NULL;
>>>> +		return 0;
>>>> +	case fs_value_is_file: {
>>>> +		char *buf, *p;
>>>> +
>>>> +		sbi->dif0.file = get_file(param->file);
>>> A very minor nit, but you can actually steal the file reference here
>>> with
>>> 		sbi->dif0.file = no_free_ptr(param->file);
>>> A few other places do this. (You'll also need to change the
>>> param->file
>>> reference below.)
>>>
>>>> +		buf = kmalloc(PATH_MAX, GFP_KERNEL);
>>>> +		if (!buf)
>>>> +			return -ENOMEM;
>>>> +		p = file_path(param->file, buf, PATH_MAX);
>>>> +		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
>>> I think that /proc/self/fd/%d would be a more useful name for
>>> debugging
>>> if file_path() fails (not that it is really possible here AFAICS). But
>>> I'm not really too fussed.
>>
>> Not quite sure if we should get in agreement with the format of this
>> one in advance (IOWs, users use source_fd and how fc->source looks like;
>> since other fses may follow the same practice if source_fd becomes common
>> later) since it's a user-visible field and I believe we shouldn't treat
>> this one as a dontcare field as some pseudo fses (since those fses don't
>> rely on `fc->source` by design but typically EROFS can rely on.)
>>
>> I hope Christian and others could share move thought on this part too
>> before I land this feature for the next cycle.
> 
> would it be better to just return the error from file_path without any
> fallback?

I hope Christian or other vfs folks can decide how to handle fc->source
string here, since in the long term, how to deal with source_fd should
be unique among different fses: just our current short-term
implementation lands into erofs directly for file-backed mounts to
fulfill composefs needs.

Thanks,
Gao Xiang

> 
> Thanks,
> Giuseppe

