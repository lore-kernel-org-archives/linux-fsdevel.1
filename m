Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6D361DBF
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921554; cv=none; b=jOSqQI6MCJWx6h1HMQ0nq2TRsHCaWL7Sa5VALl51EikZbS9jwtsLEMUkfT8uv9sIbNSE8bw5rcMYPlbmgjEw7AXkRa+Lj3/xsmHVn6LU7eTMFPNktUooL3vRh25ktUoUPHG2RYJmV/JO3aeyGKHgzm2nQYSzgxefRCDD50H25n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921554; c=relaxed/simple;
	bh=crfdgm3ZJ6ZA0XSJ3JoFcvGJH6owtKApCLv8tGBNw/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6xMmQguoMpwH5R1VJZdNZf2Ev5wHeLFU3n4mMmGX44X6U26i4oip6tQINnYCiZFucDtsB1fmjF5E85QEqZm9HIvWnDhY4sD1/u9CMEuoV2ls+5eRgCCYfp3c3uHX4oFR3LhXB0MbU+4h7+3kc6+J58Gh13B/4A9hXk7c17VaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r7b3BKFM; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r7b3BKFM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783921528; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uFekaIWvGGMu29Ps5oGZE7SikNcDlsQ2OFFA9vRlC+o=;
	b=r7b3BKFMsE2ed2AX7w86L8HeQJAOPL7GMjk1zqpN8e6bj3VQVlyu9wa4FAp+QAoj8aZyV3myKmAlxUDtyjx/vKAsaa+29RNN2m1ONVNYrzrsQqhgt5DCq92IsMj1GeXn8w0VTPIIq3JA18ZvOzJ3U6HUpyrGOzQgWu+7bqVRu6c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6u6xjW_1783921527;
Received: from 30.221.131.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6u6xjW_1783921527 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 13:45:28 +0800
Message-ID: <8829ed0e-5ebc-4832-b9bf-9efdfeb128c7@linux.alibaba.com>
Date: Mon, 13 Jul 2026 13:45:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
To: Aleksa Sarai <cyphar@cyphar.com>, Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20260711071137.4130824-1-gscrivan@redhat.com>
 <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aleksa,

On 2026/7/13 12:52, Aleksa Sarai wrote:
> On 2026-07-11, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 86fa5c6a0c70..3040d4cf9b85 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>>   enum {
>>   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>   	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
>> +	Opt_source_fd,
>>   };
>>   
>>   static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>   	fsparam_flag_no("directio",	Opt_directio),
>>   	fsparam_u64("fsoffset",		Opt_fsoffset),
>>   	fsparam_flag("inode_share",	Opt_inode_share),
>> +	fsparam_fd("source",		Opt_source_fd),
>>   	{}
>>   };
>>   
>> @@ -524,6 +526,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>   		else
>>   			set_opt(&sbi->opt, INODE_SHARE);
>>   		break;
>> +	case Opt_source_fd:
>> +		if (sbi->dif0.file)
>> +			return -EINVAL;
>> +		sbi->dif0.file = get_file(param->file);
>> +		break;
> 
> I don't think this handling is right for a few reasons:
> 
>   1. AFAICS this shadows the default "source" handling logic (because
>      -ENOPARAM is not returned for the non-fd case), which means that
>      this regresses existing erofs users -- everyone already uses
>      "source" today. I must really be missing something if this worked
>      when you tested it.
> 
>      Additionally, fsparam_fd unfortunately permits strings (where the
>      string is the numerical value of the fd number), meaning that this
>      will call get_file(<garbage>) if someone uses FSCONFIG_SET_STRING.
>      You will need to check param->type at least to avoid that.
> 
>      I meant to send a patch for this earlier this year, but a nicer
>      solution would be to have a custom helper similar to fs_lookup_param
>      except that it permits FSCONFIG_SET_FD, FSCONFIG_SET_PATH,
>      FSCONFIG_SET_PATH_EMPTY, and FSCONFIG_SET_STRING. This is sorely
>      missing and people keep accidentally creating unusable interfaces as
>      a result. I mentioned this in an LPC talk last year[1].
> 
>      proc_parse_pidns_param was my minimal version that only accepts
>      FSCONFIG_SET_FD and FSCONFIG_SET_STRING, and if you don't want to
>      add dirfd support yet then you should use something more like that.

Yes, I tried this patch just now, it seems it regresses the default
"source" as you said.  I have to withdraw my rvb.

Just check the codebase, it seems at least the minimal change is that
it needs a way for the default "source" to fall back to
vfs_parse_fs_param_source().

My initial rough thought for source_fd support for a filesystem was
not simple as this too, but I never tried to seek time to implement
myself according to my priority list.  As you said, I think in order
to better parse both source or source_fd cases, it should be better
to have better vfs helpers to parse both cases in a clean way;
I think then that should also enable bdev-backed source fds [1].

> 
>   2. On a slightly less critical note, fc->source has special handling in
>      the VFS in a few places and AFAICS this is the first example of
>      someone adding an implementation of "source" that does not set
>      fc->source to a proper value, which deserves some additional review.
> 
>      (At at quick glance it seems this just means that some stuff in
>      procfs will show as "none" rather than fc->source debugging, but
>      again it probably needs a closer look.)
  
Yes, "none" is useless for source fd cases, it'd be better to have
a path instead.

[1] https://github.com/composefs/composefs-rs/issues/346#issuecomment-4903974902

Thanks,
Gao Xiang

> 
> [1]: https://youtu.be/NX5IzF6JXp0?t=72
> 

