Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9042772D;
	Sat, 16 May 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778901632; cv=none; b=dEvGIT8dCXbC+apXZX5+aaWdhPYYWrTL1qNk8eWW6xT7b+reD3XTHnYBM2qlJTZJiIZ/zCgcs9j6XuZUG0o88yhYrfYWBX9Wu/yXXQbAGGIY4319iFWSixTsgL4LRrQ++ebYuHEkBggJDX/zSXJzvbJF8TFb7RT7SquQ+JTh+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778901632; c=relaxed/simple;
	bh=4Jj+uhZ7Raxn7BV+2S1yt2uQDoqkmnbngfmietsVfOg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HowN7KNv6aWbQ9MWHQxjbIkt4nvHI1M4eOup3DpyYGLkzBrVm6pi1WdMbf+FFAdvggrUoAKajLAubKZ5y+1B1GXauyfQeGuuu8s3wAEYtNJf36BtteCLqrxCZoR/lrySlrgr/XvNOZGyf2kNY0nd8mDNJ9olmRDdL/7NwwDNz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=buHYxU8/; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="buHYxU8/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m6z3J6YAAf8+rhp8kpsa02cUy1jFnUj/ICAyMsOLPTM=;
	b=buHYxU8/9By+5xoXViOxOvJfsxzOQonRqCCOa+Irkpm5Mha9LL724qWNSchWmlxls7F3DKIYE
	cqSOcXGfLCuCsMNs6i/gn9X2W1QnaxkCKWEftjMvz0SbWiA/KLqlARfOI0UFZEviNcN1rPySGk6
	LF5KFai5OBup83kcJXj3cLI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gHTdf5QXmzKm4y;
	Sat, 16 May 2026 11:12:38 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id EE02240563;
	Sat, 16 May 2026 11:20:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 16 May 2026 11:20:19 +0800
Subject: Re: [PATCH] fuse: virtiofs: fix illegal inode address access in
 fuse_release_end
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>,
	<yi.zhang@huawei.com>, fuse-devel <fuse-devel@lists.linux.dev>
References: <20260514124102.2703313-1-chengzhihao1@huawei.com>
 <20260515210719.GD9568@frogsfrogsfrogs>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <953d1dc7-f1a4-88a8-1db4-0902b902055f@huawei.com>
Date: Sat, 16 May 2026 11:20:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260515210719.GD9568@frogsfrogsfrogs>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2026/5/16 5:07, Darrick J. Wong Ð´µÀ:
> [add fuse-devel]
> 
> On Thu, May 14, 2026 at 08:41:02PM +0800, Zhihao Cheng wrote:
>> When a submount (e.g. virtiofs with fc->auto_submounts=true) is umounted
>> while an async RELEASE request is still pending, an illegal inode address
>> accessing occurs in fuse_release_end()->iput().
>>
>> Trigger process:
>>   1. virtiofs has a submount; user opens and closes a file under it
>>   2. Close calls fuse_file_put() with sync=false, sending RELEASE
>>      asynchronously
>>   3. fuse_release_end() is scheduled to run later via igrab() holding
>>      inode ref
>>   4. File is freed, mount/dentry refcounts are released
>>   5. User umounts the submount; fuse connection detects remaining
>>      superblock and does NOT flush the connection's requests
>>   6. generic_shutdown_super() destroys the superblock and poisons busy
>>      inodes' inode->i_sb = VFS_PTR_POISON
>>   7. Later, fuse_request_end() calls fuse_release_end() which does
>>      iput(inode)
>>   8. iput() accesses inode->i_sb->s_op at the poisoned address, crash!
>>
>> There are two solutions to fix it:
>>   Solution A: Hold path reference in fuse_file_put, and put path
>>   synchronously, which could reintroduce the issue fixed by commit
>>   5a18ec176c934 ("fuse: fix hang of single threaded fuseblk filesystem").
>>
>>   Solution B (chosen): Use synchronous RELEASE for auto_submounts (which
>>   is only supported by virtiofs). The virtiofsd(fuse daemon) and virtiofs
>>   won't work together under one same kernel instance, so the problem fixed
>>   by commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put from
>>   fuseblk workers") won't be brought back in virtiofs.
> 
> Does the weird AIO "kernel breaks if you close the fd before all the IOs
> complete" behavior happen on virtiofsd?
> 

Hi Darrick,
IMHO, the problem fixed by commit 26e5c67deb2e1f42a9("fuse: fix livelock 
in synchronous file put from fuseblk workers") happens as following process:
    fuse user              fuse daemon
fd = open(file)
io_submit_one
  req->ki_filp = fget(iocb->aio_fildes)
close(fd) // file->f_ref = 1, file won't be released
                         process FUSE_WRITE req
                         write(/dev/fuse, reply)
                          fuse_request_end
                           fuse_aio_complete_req
                            aio_complete_rw
                             fput(iocb->ki_filp)
                              task_work_add
                          task_work_run
                           __fput
                            fuse_release
                             __fuse_simple_request
                              request_wait_answer

For viriofs, the user(virtiofs) runs in kernel A(guest), the 
daemon(virtiofsd) runs kernel B(host), and the fuse_request_end is 
called by virtio_fs_requests_done_work -> virtio_fs_complete_req_work -> 
virtio_fs_request_complete, which is under the kworker context(kernel A, 
guest), so it won't block the daemon thread(kernel B, host).

> --D
> 
>>
>> Fetch a reproducer in https://bugzilla.kernel.org/show_bug.cgi?id=221519.
>>
>> Fixes: 26e5c67deb2e ("fuse: fix livelock in synchronous file put from fuseblk workers")
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> ---
>>   fs/fuse/file.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index c59452d60b8d..a6192b96d861 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -375,13 +375,20 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
>>   	 * synchronous RELEASE is allowed (and desirable) in this case
>>   	 * because the server can be trusted not to screw up.
>>   	 *
>> -	 * Always use the asynchronous file put because the current thread
>> -	 * might be the fuse server.  This can happen if a process starts some
>> -	 * aio and closes the fd before the aio completes.  Since aio takes its
>> -	 * own ref to the file, the IO completion has to drop the ref, which is
>> -	 * how the fuse server can end up closing its clients' files.
>> +	 * For auto_submounts (e.g. virtiofs), always use synchronous
>> +	 * release to avoid illegal inode address access when umount
>> +	 * happens before async release completes. The async release
>> +	 * holds inode reference via igrab(), but umount can shutdown
>> +	 * superblock and poison inode->i_sb before release ends,
>> +	 * causing crash in fuse_release_end()->iput(). Otherwise,
>> +	 * always use the asynchronous file put because the current
>> +	 * thread might be the fuse server. This can happen if a
>> +	 * process starts some aio and closes the fd before the aio
>> +	 * completes. Since aio takes its own ref to the file, the IO
>> +	 * completion has to drop the ref, which is how the fuse server
>> +	 * can end up closing its clients' files.
>>   	 */
>> -	fuse_file_put(ff, false);
>> +	fuse_file_put(ff, ff->fm->fc->auto_submounts);
>>   }
>>   
>>   void fuse_release_common(struct file *file, bool isdir)
>> -- 
>> 2.52.0
>>
> 
> .
> 

