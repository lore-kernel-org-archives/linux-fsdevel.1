Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DFD3148A6;
	Tue, 10 Mar 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125011; cv=none; b=pavQeG291Kf3DR89WAj3s3Ex5qLQXarsWAv4mrGGQ9Q9cvUdC+AL1IFIumJnBsfoJHE0VRY0Rn3gks6N0kHpvGZj0/6h9NtoUL/+F6X3JCXUEuJYpnTEabW9IwBCxJKd15fMWB75msTM1+uyzufX86rsfj9zY+C7Z17m+vao8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125011; c=relaxed/simple;
	bh=kmAHE66Z62sPt/kCRQBOfYRaj9T5VBqB56d8tCGRNZI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z7nTvBNurHYu18/3cv9Vkhr50EzFZuTK4RE0MsDVEyKMTwrBB9BoHowItERRhyjjy259JTd0e3K2kKOzDMVNNw0v05oBzUz+imCltAJ/JMdh3eRUE3bycvaB2mqHPFS3uH1+/a/dMYb4b90RAM+9KYMoUdy7ty8nqbhFvlUGxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR5D1qin; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR5D1qin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F08C19423;
	Tue, 10 Mar 2026 06:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773125011;
	bh=kmAHE66Z62sPt/kCRQBOfYRaj9T5VBqB56d8tCGRNZI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fR5D1qine57olTg3hpBxhT4rnXpUN3Iap9wCSI0VnbNOyCEq9lpGEvrskCnHMMQK4
	 V9b+vd1GS4PsA+MAybnBaFNHU1O2uo5yeHqmYwn/axv23Mv+t0Ixy51UiWg9ZDET1u
	 HVpVP+XxhJSNErHa3Oyp3/yVsWVUylI/o2YW4LQ0+x6GBZCrvevN1BjBNgGK7ySmKZ
	 JOLmyXVUWX/FBEEs9geZ4l7QRz55JDndv5dF8heZfjFXflwjsAwf9VB08WsV64Pzbm
	 v0o/tBWT6Q7XGVrjEG3eOvocGvJlVTha8PscHGoz4neqsAeU5nwP33JrLilQ2IQp/4
	 sqVSbquXfUmoA==
Message-ID: <dc645bd1-2881-4472-8918-0eada3786ab3@kernel.org>
Date: Tue, 10 Mar 2026 14:43:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>,
 Hongbo Li <lihongbo22@huawei.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] erofs: introduce nolargefolio mount option
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20260309023053.1685839-1-chao@kernel.org>
 <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Xiang,

On 3/9/26 11:03, Gao Xiang wrote:
> Hi Chao,
> 
> (+cc -fsdevel, willy, Jan kara)
> 
> On 2026/3/9 10:30, Chao Yu wrote:
>> This patch introduces a new mount option 'nolargefolio' for EROFS.
>> When this option is specified, large folio will be disabled by
>> default for all inodes, this option can be used for environments
>> where large folio resources are limited, it's necessary to only
>> let specified user to allocate large folios on demand.
> 
> For this kind of options, I think more real backgrounds
> about avoiding high-order allocations are needed in the
> commit message (at least for later reference) also like
> what I observed in:
> https://android-review.googlesource.com/c/kernel/common/+/3877981

Basically, the background is about contention scenario on large folio allocation,
it's among multiple users including EROFS in Android-system, as it's related to
internal scene of product, so I can not provide more details now, I'm sorry
about that, but I'm glad to discuss based on the background and pain point once
if I can share more, let's see. :)

> 
> because the entire community tends to enable large folios
> unconditionally if possible.  Without enough clarification,
> even I merge this, there will be endless questions again
> and again about this.
> 
> And Jan once raised up if it should be a user interface
> or auto-tuning one:
> https://lore.kernel.org/r/z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5

Thanks for sharing this anyway, I didn't notice this previously...

Thanks,

> > My question is that if the needs are real, I wonder if
> it should be a vfs generic decision instead (because
> it's not due to the filesystem restriction but due to
> real system memory pressure or heavy workload for
> example).  However, if the answer is that others don't
> really care about this, I'm fine to leave it as an
> erofs-specific option as long as the actual case is
> clear in the commit message.
> > Thanks,
> Gao Xiang
> 
> 
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   Documentation/filesystems/erofs.rst | 1 +
>>   fs/erofs/inode.c                    | 3 ++-
>>   fs/erofs/internal.h                 | 1 +
>>   fs/erofs/super.c                    | 8 +++++++-
>>   4 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
>> index fe06308e546c..d692a1d9f32c 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -137,6 +137,7 @@ fsoffset=%llu          Specify block-aligned filesystem offset for the primary d
>>   inode_share            Enable inode page sharing for this filesystem.  Inodes with
>>                          identical content within the same domain ID can share the
>>                          page cache.
>> +nolargefolio           Disable large folio support for all files.
>>   ===================    =========================================================
>>     Sysfs Entries
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 4b3d21402e10..26361e86a354 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -254,7 +254,8 @@ static int erofs_fill_inode(struct inode *inode)
>>           return 0;
>>       }
>>   -    mapping_set_large_folios(inode->i_mapping);
>> +    if (!test_opt(&EROFS_SB(inode->i_sb)->opt, NO_LARGE_FOLIO))
>> +        mapping_set_large_folios(inode->i_mapping);
>>       aops = erofs_get_aops(inode, false);
>>       if (IS_ERR(aops))
>>           return PTR_ERR(aops);
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index a4f0a42cf8c3..b5d98410c699 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -177,6 +177,7 @@ struct erofs_sb_info {
>>   #define EROFS_MOUNT_DAX_NEVER        0x00000080
>>   #define EROFS_MOUNT_DIRECT_IO        0x00000100
>>   #define EROFS_MOUNT_INODE_SHARE        0x00000200
>> +#define EROFS_MOUNT_NO_LARGE_FOLIO    0x00000400
>>     #define clear_opt(opt, option)    ((opt)->mount_opt &= ~EROFS_MOUNT_##option)
>>   #define set_opt(opt, option)    ((opt)->mount_opt |= EROFS_MOUNT_##option)
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 972a0c82198d..a353369d4db8 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -390,7 +390,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>>   enum {
>>       Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>       Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
>> -    Opt_inode_share,
>> +    Opt_inode_share, Opt_nolargefolio,
>>   };
>>     static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -419,6 +419,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>       fsparam_flag_no("directio",    Opt_directio),
>>       fsparam_u64("fsoffset",        Opt_fsoffset),
>>       fsparam_flag("inode_share",    Opt_inode_share),
>> +    fsparam_flag("nolargefolio",    Opt_nolargefolio),
>>       {}
>>   };
>>   @@ -541,6 +542,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>           else
>>               set_opt(&sbi->opt, INODE_SHARE);
>>           break;
>> +    case Opt_nolargefolio:
>> +        set_opt(&sbi->opt, NO_LARGE_FOLIO);
>> +        break;
>>       }
>>       return 0;
>>   }
>> @@ -1105,6 +1109,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>>           seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
>>       if (test_opt(opt, INODE_SHARE))
>>           seq_puts(seq, ",inode_share");
>> +    if (test_opt(opt, NO_LARGE_FOLIO))
>> +        seq_puts(seq, ",nolargefolio");
>>       return 0;
>>   }
>>   
> 

