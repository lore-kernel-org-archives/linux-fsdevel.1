Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39CC439F9B
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737554; cv=none; b=L+YwFkonyeFJQl+gD5BU1+YSSSXxZSCq0YC6ukzze34Q3yZbmuT1fuYn1rA0hZGQGqVSluIjvXm6JkiLlaFhKTAjF2sKCKIobVOFUfO1tl0bsNI+LG7k7AKVMMcCKXp5YA84D+78KlVM5EEdei5yMbeOnRUk+xNW4WRWAeJIoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737554; c=relaxed/simple;
	bh=C+b6BXXkwc7g6pjUcOjoJK61qF1UD47c3y5E2MeOh3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CI4jqDun5gAXRJcq+XqY9gPQoA+8SzrksVdEuoGEJIYK+/CBec5crP/rHGEowib8ptFURNHgrrVZ1WNG2dD8N2C1pWL0HnzM/pvxNOLq5CluDrZS8JMNqQ0oMjYRkCRzFj9+1hYteyuh6HWE4PcUm8AoUs57QSfYbjMiYZOR6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MnsM7Skc; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MnsM7Skc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784737539; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UhkTy60TW9NQTrHWuSMLMh4MnJI7jkjC8lD9pHSLfZI=;
	b=MnsM7SkcLrDu5sUH3i1iCF7h1qJKEOzWayW+iA33iN64CcLebHxOr0MAuM96siD9HwGndh5yGK+qXuYqe2s2aMjjo632MZ0/HAmEXhVsjtqLabB3Vry9y88zSuFvB1wmms+z70d5zZ8Y8X5PV2Wat6XLV4qDSRxtCL89/NtxbXA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X7dfH3H_1784737538;
Received: from 30.180.139.68(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X7dfH3H_1784737538 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jul 2026 00:25:39 +0800
Message-ID: <6d1ac697-d5f8-4952-ba68-27610f17bf3c@linux.alibaba.com>
Date: Thu, 23 Jul 2026 00:25:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: accept source file descriptor via fsconfig
To: Christian Brauner <brauner@kernel.org>,
 Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, cyphar@cyphar.com,
 linux-fsdevel@vger.kernel.org
References: <20260717134147.1602735-1-gscrivan@redhat.com>
 <20260722-notnagel-allemal-kampfsport-8fd4e4d98a15@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260722-notnagel-allemal-kampfsport-8fd4e4d98a15@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2026/7/23 00:11, Christian Brauner wrote:
>> Allow userspace to pass an already-opened file descriptor as the mount
>> source instead of a path string.  This is useful for tools that already
>> hold an fd to the image, such as composefs reusing an existing erofs
>> backing file.
>>
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 9d8f862f309f..bc55be84d945 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>>   enum {
>>   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>   	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
>> +	Opt_source,
>>   };
>>   
>>   static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -402,17 +403,18 @@ static const struct constant_table erofs_dax_param_enums[] = {
>>   };
>>   
>>   static const struct fs_parameter_spec erofs_fs_parameters[] = {
>> -	fsparam_flag_no("user_xattr",	Opt_user_xattr),
>> -	fsparam_flag_no("acl",		Opt_acl),
>> -	fsparam_enum("cache_strategy",	Opt_cache_strategy,
>> +	fsparam_flag_no("user_xattr",		Opt_user_xattr),
>> +	fsparam_flag_no("acl",			Opt_acl),
>> +	fsparam_enum("cache_strategy",		Opt_cache_strategy,
>>   		     erofs_param_cache_strategy),
>> -	fsparam_flag("dax",             Opt_dax),
>> -	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
>> -	fsparam_string("device",	Opt_device),
>> -	fsparam_string("domain_id",	Opt_domain_id),
>> -	fsparam_flag_no("directio",	Opt_directio),
>> -	fsparam_u64("fsoffset",		Opt_fsoffset),
>> -	fsparam_flag("inode_share",	Opt_inode_share),
>> +	fsparam_flag("dax",			Opt_dax),
>> +	fsparam_enum("dax",			Opt_dax_enum, erofs_dax_param_enums),
>> +	fsparam_string("device",		Opt_device),
>> +	fsparam_string("domain_id",		Opt_domain_id),
>> +	fsparam_flag_no("directio",		Opt_directio),
>> +	fsparam_u64("fsoffset",			Opt_fsoffset),
>> +	fsparam_flag("inode_share",		Opt_inode_share),
>> +	fsparam_file_or_string("source",	Opt_source),
>>   	{}
>>   };
>>   
>> @@ -437,6 +439,40 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>>   	return false;
>>   }
>>   
>> +static int erofs_fc_parse_source(struct fs_context *fc,
>> +				 struct fs_parameter *param)
>> +{
>> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>> +
>> +	if (fc->source || sbi->dif0.file)
>> +		return invalf(fc, "Multiple sources");
>> +
>> +	switch (param->type) {
>> +	case fs_value_is_string:
>> +		fc->source = param->string;
>> +		param->string = NULL;
>> +		return 0;
>> +	case fs_value_is_file: {
> 
> Afaict this is just fsparam_file_or_string()?
> 
>> +		char *buf __free(kfree) = kmalloc(PATH_MAX, GFP_KERNEL);
>> +		char *p;
>> +
>> +		if (!buf)
>> +			return -ENOMEM;
>> +		p = file_path(param->file, buf, PATH_MAX);
>> +		if (IS_ERR(p))
>> +			return PTR_ERR(p);
>> +		fc->source = kstrdup(p, GFP_KERNEL);
>> +		if (!fc->source)
>> +			return -ENOMEM;
> 
> Hm, hm, hm... How is that reliable? So iirc this is then passed to:
> 
> static int erofs_fc_get_tree(struct fs_context *fc)
> {
> 	int ret;
> 
> 	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
> 		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
> 			GET_TREE_BDEV_QUIET_LOOKUP : 0);
> 	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
> 		struct erofs_sb_info *sbi = fc->s_fs_info;
> 		struct file *file;
> 
> 		if (!fc->source)
> 			return invalf(fc, "No source specified");
> 		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
> 		if (IS_ERR(file))
> 			return PTR_ERR(file);
> 		sbi->dif0.file = file;
> 
> 		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
> 		    sbi->dif0.file->f_mapping->a_ops->read_folio)
> 			return get_tree_nodev(fc, erofs_fc_fill_super);
> 	}
> 	return ret;
> }
> 
> which then reopens the file or looks up the block device. So the only
> way this is _vaguely_ (and really _very vaguely_) safe is if userspace
> keeps at least the file descriptor open until the filesystem has been
> mounted.

I'm not quite sure if I catched the point, I think Giuseppe's patch here
tried to record `file` into `sbi->dif0.file` (which indicates the primary
"device" later.)

And if `sbi->dif0.file` is set up by erofs_fc_parse_source(),
erofs_fc_get_tree() will just use `sbi->dif0.file` instead of
`fc->source` according to this patch.

The reason why `fc->source` is set was discussed in the
thread of the previous version suggested by Aleksa.

> 
> If they close it before this means you can mount something completely
> different. The other thing is even if they keep the fd open someone
> could just rename the damn thing and fc->source ends up pointing
> somwhere completely different. The could switch namespaces as well in
> some circumstances and then it points again into wherever.
> 
> I've played with that fd idea before. The only way to make this work
> correctly is if you plumb this down into get_tree_nodev()

fc->source in this case has no use in erofs_fc_get_tree() (`fc->source`
is just used for mountinfo for example), `sbi->dif0.file` works instead
I hope I don't misunderstand something.

Thanks,
Gao Xiang

> 

