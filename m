Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813077;
	b=Uze0gYEuUxqH9vmTNeIKtKIHrBZxOfkj+d28Yl4LLP6gr7+yOGmOBHxpJ6qXg8U29Sr8
	 i+XWqlPOx2mFr5BjzCZB6/ZaZ2MPbkTGmsWnEGze5utJ4IIBAR+zmeuFT0Pd8/ghMXLLE
	 odzcvVbB+LEfHOymfQBW/uM4/yoXoJckN4nxW0ls705mZUO/xznexlaV2KCG+9kcaSPSQ
	 m/vefb/8By9eqFec7eAa9bR1PdqDsC1asu4MIS5mmSc1D2li9JpLTzLmzXiHKNgWQ6KDe
	 ihhhtrJ4Ny5siZ3kYeF4uduelxcEadD1ucMOO/uJn3MInLy3ChVWniyIts4dLRRDhDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813077;
	h=DMARC-Filter:Received:Received:Received:Subject:To:References:Cc:
	 From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=9yMolbkDKBtyv0XYZnWfrAvfqJa/8+41tayFSo6T49A=;
	b=PTA/WLdP/fT/NWxtxO2l4AfDfbQ+GeFhe9URozrA5+W64o8cgZ8rjUC26El69GMPC20e
	 9/1ifAPpaOSFZJEH9ade8DLH/Mr7l8NKCIpKbqgOyQbx+uEQbN7J90KjhTt8/aL3FRZEf
	 4FH5iYiWQPa/2dMTg4DzW80y82NQ7Z/kTArCNI1dxrcqBc9uV07OPJAvznf8cvUmjkFkJ
	 3SX1fZYne71EknRQPi20+3GEI2CIo8Y/HQoacyTdc6tOyZcpg3m+ql+iJPEpwAyK4D3g+
	 PsChvUtehMMd39bfS5bhwD0OJY4C+yGAC4NkCinTiUrw4PwrsjAoU04jTTCj5SfYgPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0D606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 07:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC0D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jSfC33Yltz1c1KD
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:10:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5C78B40561
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:11:12 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgAnZvWOrPpqRPg2Eg--.33204S3;
	Mon, 16 Nov 2026 15:11:12 +0800 (CST)
Subject: Re: [PATCH] fs: hold freeze protection across writable regular file
 ->open()
To: Josef Bacik <josef@toxicpanda.com>
References: <20261112135245.3347102-1-yebin@huaweicloud.com>
 <sxlubqvhlkeg4ukyxakquv4e72o4ib7u2o2jtak4qqs6gz5haw@uoty23uvtlf3>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org
From: yebin <yebin@huaweicloud.com>
Message-ID: <6AFAAC8E.5090702@huaweicloud.com>
Date: Mon, 16 Nov 2026 15:11:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <sxlubqvhlkeg4ukyxakquv4e72o4ib7u2o2jtak4qqs6gz5haw@uoty23uvtlf3>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAnZvWOrPpqRPg2Eg--.33204S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy8Ar4DZw1ftr4DWF17KFg_yoWrWrWkpr
	Wruay5GFWUK3sFkFn29F4DZ3WF9r1Igr1xZF4DWry7Jr9aqryagFyIgrnY9FW8tr93Kr1F
	qF4jka9xC347CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2026/11/13 1:56, Josef Bacik wrote:
> On Thu, Nov 12, 2026 at 09:52:45PM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> A writable open of a regular file reaches the filesystem's ->open()
>> callback without holding any superblock write (freeze) protection.
>> ->open() can nevertheless write to the filesystem: ext4_file_open() ->
>> dquot_file_open() -> dquot_initialize() may acquire a dquot and write
>> the quota file, which starts a jbd2 transaction.  If the filesystem
>> reaches SB_FREEZE_COMPLETE in that window, ext4_journal_check_start()
>> hits
>>
>> 	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
>>
>> and the open then sleeps in jbd2 until the filesystem is thawed.
>>
>> The hole was created over time:
>>
>>    - Commit 907f4554e252 ("dquot: move dquot initialization responsibility
>>      into the filesystem") moved quota initialization into ->open() and
>>      introduced dquot_file_open(), making ->open() a potentially writing
>>      operation for writable opens.
>>
>>    - Commit eb04c28288bb ("fs: Add freezing handling to mnt_want_write() /
>>      mnt_drop_write()") added sb_start_write() to mnt_want_write() but
>>      deliberately kept the write reference held by an open file on the
>>      non-freezing __mnt_want_write() variant, so the file's own write
>>      reference does not protect its ->open().
>>
>>    - Commit 64894cf84327 ("simplify lookup_open()/atomic_open() - do the
>>      temporary mnt_want_write() early") moved the temporary write count
>>      into do_last() and dropped it before finish_open(), so a writable
>>      open that is not O_TRUNC reaches ->open() with no sb write count at
>>      all.
>>
>> Since then only O_TRUNC opens take mnt_want_write() in do_open().
>>
>> Fix this by taking mnt_want_write() for any writable open of a regular
>> file and holding it across vfs_open()/->open().  Regular files are
>> checked explicitly so that opening device nodes on a read-only mount is
>> not newly rejected.  Read-only opens are unaffected.
>>
>> Fixes: eb04c28288bb ("fs: Add freezing handling to mnt_want_write() / mnt_drop_write()")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/namei.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index f573fd0aacaf..0ee4cf282cf5 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -4906,6 +4906,7 @@ static int do_open(struct nameidata *nd,
>>   	const struct mnt_idmap *idmap;
>>   	int open_flag = op->open_flag;
>>   	bool do_truncate;
>> +	bool got_write;
>>   	int acc_mode;
>>   	int error;
>>
>> @@ -4935,12 +4936,23 @@ static int do_open(struct nameidata *nd,
>>   		return -ENOTDIR;
>>
>>   	do_truncate = false;
>> +	got_write = false;
>>   	acc_mode = op->acc_mode;
>>   	if (file->f_mode & FMODE_CREATED) {
>>   		/* Don't check for write permission, don't truncate */
>>   		open_flag &= ~O_TRUNC;
>>   		acc_mode = 0;
>>   	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
>> +		do_truncate = true;
>> +	}
>> +
>> +	/*
>> +	 * ->open() can write to the filesystem, e.g. when it initializes
>> +	 * quota, so writable opens of regular files need freeze protection
>> +	 * as well.  O_TRUNC opens already need it for handle_truncate().
>> +	 */
>> +	if (do_truncate ||
>> +	    (d_is_reg(nd->path.dentry) && (file->f_mode & FMODE_WRITE))) {
>
> This is convoluted, you can get rid of the do_truncate flag altogether,
> just do
>
> if (d_is_reg(nd->path.dentry) &&
>      ((open_flag & O_TRUNC) || (file->f_mode & FMOD_WRITE))) {
> 	// mntwrite thing
> 	go_write = true;
> }
>
> And the delete the extra else if block. Thanks,
>
Thank you for your reply.
At first, I also wanted to remove the 'do_truncate' parameter, but this
parameter is still used later. So I decided to keep it.

do_open() :
...
          if (!error)
                  error = security_file_post_open(file, op->acc_mode);
          if (!error && do_truncate)  // The 'do_truncate' parameter is required.
                  error = handle_truncate(idmap, file);
          if (unlikely(error > 0)) {
                  WARN_ON(1);
                  error = -EINVAL;
          }
...

> Josef
>

