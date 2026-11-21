Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795223973;
	b=Ds38YFRNW5I1yKtKdFVloZ7jNRfi+8wmaehYco38lEazhRlwBkRUzKu8FtJr9jT4jdjG
	 /lvRE8kaFBsagm+uXRh2Dhv8sSFi/SZaK2CC47/7nOyi8dwUZ4EpJNnyNz6j+MZ62+afd
	 8pJ2wzMpmQTiBnSxF0ZJNG1gZ3Ky+Hkuz5NXAXxE+gsDAq0ay2h3bnaNYJGZOKFajM6r4
	 4WWwur7ON4yNNi8PsdRQLIp96uZcDcBo7FpJGRAmz+Xbs9h5rfaIt24rLUJHbpH/uA3YV
	 KuawoY5pcvrZ6LHI8ha8ZX0XyOhgrSF2BXDnsbW3RUjpnEEHqka6gdc/VA3rZalLRZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223973;
	h=DMARC-Filter:Received:Received:Received:Subject:To:References:Cc:
	 From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=QcH66ZrUE/ZdND00AbzOqUuAfU1sdROS2JQr9UyLKvk=;
	b=I6p0GmCwgoAQ1IrZnrRxolP6w1QnmH3ic6P4BixOb3qbhFlwB9yRMf4QGWsmlZ9kgKek
	 GBZ6Z/JBYOPtIYQzcHnHAIG/mtvcOqMYgU1oWeZHB8fPRV5DdPzDrk29hFIuaUBpKbjcj
	 3t13bzhcrrSRKMPx8UCxD+jFxMt0tqwKTVmHlGHm9B37d7O0jAnl2U4U3sdPJcUnAw0a+
	 wBi94DwuSmkmA14VL09KGqVm7IBbtpkU2OYFC1fVhUbQLzyaNLknUL9tvJlP0oghRKuKY
	 vGKD38HEvLDbrwRhI64kyCl/Nn8yx7bWkUmSHnajbuKjgAW7E+BAXg7+8EmYrE01tsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624A8606A330
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 01:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 624A8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jWZ8Z2Bqhz1c0kl
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 09:18:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BC4BA40573
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 09:19:19 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgCn4O+W8QBrr1+sFA--.17443S3;
	Sat, 21 Nov 2026 09:19:19 +0800 (CST)
Subject: Re: [PATCH] fs: hold freeze protection across writable regular file
 ->open()
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
References: <20261112135245.3347102-1-yebin@huaweicloud.com>
 <20261120-zehnfach-flugfeld-textil-72ab74773d45@brauner>
 <4czsdzcffhzpkcdf7zffpj2ow2oa2skb64f4brrbf6z2jqmbik@zkeuyyuyvcdp>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
From: yebin <yebin@huaweicloud.com>
Message-ID: <6B00F196.20601@huaweicloud.com>
Date: Sat, 21 Nov 2026 09:19:18 +0800
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
In-Reply-To: <4czsdzcffhzpkcdf7zffpj2ow2oa2skb64f4brrbf6z2jqmbik@zkeuyyuyvcdp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCn4O+W8QBrr1+sFA--.17443S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GryrAFy8AF1UCw4rKFyUKFg_yoW7CF13pr
	W5ua45GFWUJ3s2kws2gF4vv3WrKr97Wr17ZF1DWryUXr9Yqw1agFy2qrn5CFyrtrZakr4F
	qF4jka47u347CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2026/11/20 20:56, Jan Kara wrote:
> On Fri 20-11-26 12:19:03, Christian Brauner wrote:
>> On Thu, Nov 12, 2026 at 09:52:45PM +0800, Ye Bin wrote:
>>> From: Ye Bin <yebin10@huawei.com>
>>>
>>> A writable open of a regular file reaches the filesystem's ->open()
>>> callback without holding any superblock write (freeze) protection.
>>> ->open() can nevertheless write to the filesystem: ext4_file_open() ->
>>> dquot_file_open() -> dquot_initialize() may acquire a dquot and write
>>> the quota file, which starts a jbd2 transaction.  If the filesystem
>>> reaches SB_FREEZE_COMPLETE in that window, ext4_journal_check_start()
>>> hits
>>>
>>> 	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
>>>
>>> and the open then sleeps in jbd2 until the filesystem is thawed.
>>>
>>> The hole was created over time:
>>>
>>>    - Commit 907f4554e252 ("dquot: move dquot initialization responsibility
>>>      into the filesystem") moved quota initialization into ->open() and
>>>      introduced dquot_file_open(), making ->open() a potentially writing
>>>      operation for writable opens.
>>>
>>>    - Commit eb04c28288bb ("fs: Add freezing handling to mnt_want_write() /
>>>      mnt_drop_write()") added sb_start_write() to mnt_want_write() but
>>>      deliberately kept the write reference held by an open file on the
>>>      non-freezing __mnt_want_write() variant, so the file's own write
>>>      reference does not protect its ->open().
>>>
>>>    - Commit 64894cf84327 ("simplify lookup_open()/atomic_open() - do the
>>>      temporary mnt_want_write() early") moved the temporary write count
>>>      into do_last() and dropped it before finish_open(), so a writable
>>>      open that is not O_TRUNC reaches ->open() with no sb write count at
>>>      all.
>>>
>>> Since then only O_TRUNC opens take mnt_want_write() in do_open().
>>>
>>> Fix this by taking mnt_want_write() for any writable open of a regular
>>> file and holding it across vfs_open()/->open().  Regular files are
>>> checked explicitly so that opening device nodes on a read-only mount is
>>> not newly rejected.  Read-only opens are unaffected.
>>>
>>> Fixes: eb04c28288bb ("fs: Add freezing handling to mnt_want_write() / mnt_drop_write()")
>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>> ---
>>>   fs/namei.c | 16 ++++++++++++++--
>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/namei.c b/fs/namei.c
>>> index f573fd0aacaf..0ee4cf282cf5 100644
>>> --- a/fs/namei.c
>>> +++ b/fs/namei.c
>>> @@ -4906,6 +4906,7 @@ static int do_open(struct nameidata *nd,
>>>   	const struct mnt_idmap *idmap;
>>>   	int open_flag = op->open_flag;
>>>   	bool do_truncate;
>>> +	bool got_write;
>>>   	int acc_mode;
>>>   	int error;
>>>
>>> @@ -4935,12 +4936,23 @@ static int do_open(struct nameidata *nd,
>>>   		return -ENOTDIR;
>>>
>>>   	do_truncate = false;
>>> +	got_write = false;
>>>   	acc_mode = op->acc_mode;
>>>   	if (file->f_mode & FMODE_CREATED) {
>>>   		/* Don't check for write permission, don't truncate */
>>>   		open_flag &= ~O_TRUNC;
>>>   		acc_mode = 0;
>>>   	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
>>> +		do_truncate = true;
>>> +	}
>>> +
>>> +	/*
>>> +	 * ->open() can write to the filesystem, e.g. when it initializes
>>> +	 * quota, so writable opens of regular files need freeze protection
>>> +	 * as well.  O_TRUNC opens already need it for handle_truncate().
>>> +	 */
>>> +	if (do_truncate ||
>>> +	    (d_is_reg(nd->path.dentry) && (file->f_mode & FMODE_WRITE))) {
>>>   		error = mnt_want_write(nd->path.mnt);
>>
>> No, I don't think that's the right thing to do. Every
>> open(O_WRONLY|O_RDWR) would now block for a regular file on a frozen
>> filesystem even if it never writes. That's not acceptable. Log files,
>> editors, backup tools, they all would hang rather than fail on write.
>> It's a drastic uapi change.
>>
>> The write in ->open() is from the quota stuff. So that should be a quota
>> fix and not penalize the whole VFS layer.
>
> Conceptually I agree with you but we cannot easily grab freeze protection
> from ->open() where we do quota stuff because VFS may but need not be already
> holding it.
>
> Somewhat paradoxical is that quota code will actually write anything only
> if we are creating quota structures for a new user but that never happens
> from ->open (it would happen already during vfs_create() in
> dentry_create()). It is just ext4 that unconditionally starts a transaction
> because it doesn't know the context... But ocfs2 actually does write if we
> are touching the first inode of this user so there the problem is real.
>
> Hrm, but I think we could just use sb_start_intwrite() in filesystem's
> .acquire_dquot methods and be done with that. That won't deadlock and it
> will silence the warnings / fix ocfs2 breakage. AFAICS only ext4 & ocfs2
> actually need anything done. Ye?
>
I checked the code of ocfs2 and it should be fine, because sb_start_intwrite()
is called when starting a transaction.
ocfs2_acquire_dquot
   ocfs2_start_trans
     sb_start_intwrite(osb->sb);
So, it should only require fixing the EXT4 file system. That should be enough.

In the ext4_evict_inode() process, calling dquot_initialize() and freezing the
file system concurrently may also trigger a warning.
ext4_evict_inode
   dquot_initialize(inode);
   if (!ext4_journal_current_handle())
     sb_start_intwrite(inode->i_sb);
   ext4_journal_start()

The same processing logic in ext4_acquire_dquot() and ext4_evict_inode() should
be fine.
> 								Honza
>

