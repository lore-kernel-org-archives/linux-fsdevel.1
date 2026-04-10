Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD71AC44D;
	Fri, 10 Apr 2026 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775787464; cv=none; b=Z1SGkPiqBdwVzn4LMk+fZLepLsxp8Z5CzVyIk0IlAcbGXnLo7A5MT4N0CEZan1BrDvvDWT8t7RMduLUHj0Hq6VYNyFz2PkZzXYsBQhKeIqGaHgT06hRUt1C9atFVGynHpcMKPNRNYbvCDiKBw6Ii2KYAf3YRl9+edouUj2V4FoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775787464; c=relaxed/simple;
	bh=c5C0ozKYK9gfyZHVn9W1yVtl86aGApueKdZDlITWWHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpLR0Z6z6ZJdZNpMKQXhB4BrQsi51ANvTcoctKR3fXf0wJi4Sv4HBs3+yecKMYQf4MphwJO99Ydavto9tSFsS1JAkzSwuzJYRTJ9b8tQkQaeKl8nvOrCUyzodOj/1V1kGfKvsMNjzHPYnNH+XeJhoUMti+M8GogRaRXaoL/Lu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BYD/ICwf; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BYD/ICwf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775787453; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Iy3mih1dyYGtLK3soy9gqeCAYhH4XWLvz5hQJbUTmhw=;
	b=BYD/ICwflQrG/cGEYaKhCFRFwwIZC+3AwqYLy38CMvGB2eRXrvfW+Jnjoc3HQTTrDXYCUWJAssEbHpR+Dm2I7BdF2jou17nqExeOtX4BuXeW1PwcQJ32tDO9Bhl7Gmk/1IDkdJv34+GNG1lIFvyKz5C+l2pd2mEY+AdE45FtGdk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X0jegMD_1775787451;
Received: from 30.221.146.186(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X0jegMD_1775787451 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 10:17:32 +0800
Message-ID: <e6d9be02-fa8d-47b3-a76a-4afd83293ef6@linux.alibaba.com>
Date: Fri, 10 Apr 2026 10:17:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>,
 Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Horst Birthelmer <hbirthelmer@ddn.com>, Kevin Chen <kchen@ddn.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
References: <20260225112439.27276-1-luis@igalia.com>
 <20260225112439.27276-7-luis@igalia.com>
 <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
 <87v7e24gdw.fsf@igalia.com>
 <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
 <87fr55lpu4.fsf@igalia.com>
 <5c13b5ae-ca74-4fd8-97ec-39f24ccfd5c2@linux.alibaba.com>
 <CAOQ4uxjRN9hCXwxmy3rwsR-vaHN0d2+i+U1pOC7WgSwSdWCC7g@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAOQ4uxjRN9hCXwxmy3rwsR-vaHN0d2+i+U1pOC7WgSwSdWCC7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Amir,

On 4/9/26 10:03 PM, Amir Goldstein wrote:
> On Thu, Apr 9, 2026 at 4:27 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Many thanks for your work on this.
>>
>> Just FYI We are also interested in the kernel-maintained filehandle,
>> which can dramatically help reduce the memory footprint on the FUSE
>> server side.
>>
> 
> Hi Jingbo,
> 
> I might have told you this before. I don't keep track of who I shared this with.
> If you are implementing a passthough fs to a backing fs like ext4/xfs which
> CAN open a file by inode number, you could already use this library
> that I developed for our in house passthrough fs, to reduce memory footprint
> of server:
> 
> https://github.com/amir73il/libfuse/commits/fuse_passthrough
> 
> It was my intention to adapt this library to also work with LOOKUP_HANDLE
> to support more backing fs after LOOKUP_HANDLE is implemented.


Many thanks for the shared link and kind reminder.  To be honest I
didn't notice it.  IIUC it seems that the previous O_PATH fd (of backing
ext4/xfs file) is replaced by the file handle (of backing file), so that
the memory footprint for the inode cache for the backing files could be
saved.

Actually in our using case, the backing store is a remote network file
system and FUSE daemon uses file handles to access remote network files.

Besides the LOOKUP_HANDLE mechanism also helps the FUSE daemon recovery,
since the daemon doesn't need to rebuild the nodeid<->filehandle mapping
after recovery any more.

-- 
Thanks,
Jingbo

