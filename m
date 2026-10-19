Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D74A64D5;
	Mon, 19 Oct 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403770; cv=none; b=oCKKZZPBUDI7BSn3tRZgOwdr7NQfyHLanDpJcc8fk4LfurWl4I+rujDU1au7lg3xvk55tOPGNcvs9txhhVkJ+e+/w5AcoG5sq/ifJlj0hGGFLXjwRbhlU1oA6txYomBTj8GG2ZWbwyPea4qEiMJKPOr5pOKze5eHesMAY09N0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403770; c=relaxed/simple;
	bh=wKmAu87rZ/6z8bFi1pbn67n7qUR2NkDwhx8xdFo9qMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k+Gvi7bK3oy/0IEegnoruMPg9OgzRaonB5DjkyXA7p45XF42fYXJV4vijUVzNtBEdvqHC3uYpZXIhJXHkgBWA3frejTYpo+o9xIyqXhKDQjoq8sOlP9pGNkvRIfC7Xxlr1ulL5nEKeNjEOrU8OZ+T13aVCqv/3iEpUXCU5vOzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=FuLV+QZj; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=M4C2c1Td; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="FuLV+QZj";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="M4C2c1Td"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E7D4826F7698;
	Mon, 19 Oct 2026 18:55:58 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792403759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R53a9EiALsYd16hERFKG5ZGiNaW/l8gOjf1X9uDyE34=;
	b=FuLV+QZjA5rUZZGei5HipG65NvSFiKSvBoZGYdyZlsgQ4RtzN06CcMB+mTAsz7VUZMuA2d
	BwouG/Xg5H3s4c1qUgo5AGDYn01XFxpMeBboz2QamGds672F3q8sMCKr0+BO0UUFeIYjtI
	0Be0f52O2dhmJvitU573RKUyhcaaSHLAQ0TSPdjyJn8dU6JEtcdpSNPxxRaWiWfKFgmwjZ
	tqZGbbgcTHcVMkNUJlN9hhKUYlrvKhBNGyjBjv3xZ8snIFRlyPYT4rVtqrTm2u1WNUd35T
	85mWIfOCHpDNriph3lVOMkykXl3KTIi8yTLh9VtpLAUGNLAPcNfp3sdx21VD3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792403759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R53a9EiALsYd16hERFKG5ZGiNaW/l8gOjf1X9uDyE34=;
	b=M4C2c1TdeZRuSq6IdhLGGQuOE1E4FWLPdfaSodGorF9tRd3QI1TTK9KwKif2gFPI+xoC3k
	5FM+Te8v4kZoZ8BA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 695FAE00699;
	Mon, 19 Oct 2026 18:55:58 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 624C02200209; Mon, 19 Oct 2026 18:55:58 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] fat: make rename recovery safe after metadata write
 errors
In-Reply-To: <c820357a-a7cf-4f4b-ab23-91530a12218b@gmail.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
	<20260929090029.742579-1-krystianmkaniewski@gmail.com>
	<87ld8j4161.fsf@mail.parknet.co.jp>
	<1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
	<87bj90m6dq.fsf@mail.parknet.co.jp>
	<20261014082315.190262-1-krystianmkaniewski@gmail.com>
	<87qzhqvloo.fsf@mail.parknet.co.jp>
	<55a1f016-a7a2-469f-b481-37223d695f29@gmail.com>
	<87cxt921rc.fsf@mail.parknet.co.jp>
	<f9b27432-4104-4323-8cd7-e2cda73db2f9@gmail.com>
	<875wz11xfg.fsf@mail.parknet.co.jp>
	<c820357a-a7cf-4f4b-ab23-91530a12218b@gmail.com>
Date: Mon, 19 Oct 2026 18:55:58 +0900
Message-ID: <878q3uhv4h.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> On 10/16/26 17:23, OGAWA Hirofumi wrote:
>> Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:
>> 
>>> On 10/16/26 15:50, OGAWA Hirofumi wrote:
>>>> Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:
>>>>
>>>>> On 10/15/26 20:54, OGAWA Hirofumi wrote:
>>>>>
>>>>>>> +	} else if (!rollback_err) {
>>>>>>> +		/* Read the entry block again if a failed write invalidated it. */
>>>>>>> +		rollback_err = bh_read(sinfo.bh, 0);
>>>>>>
>>>>>> Why do this read the bh from on disk?
>>>>>>
>>>>>
>>>>> The bh_read(sinfo.bh, 0) is needed because a failed inode-position write clears BH_Uptodate. fat_remove_entries() modifies and dirties that retained buffer directly, which otherwise triggers the warning. Reading it first refreshes the whole block. If the read fails, the buffer is left untouched.
>>>>>
>>>>> The same reasoning applies to both the VFAT and MS-DOS paths.
>>>>
>>>> If sinfo.bh is required to read because of failure of I/O error, I guess
>>>> the bh will fail to write again. I think we should give up to rollback
>>>> in that case.
>>>>
>>>> Thanks.
>>>
>>> Thanks. I was trying to handle transient errors here. The old entry still exists at this point, so if the read and removal succeed, the rename can be fully rolled back.
>>>
>>> In my tests with a single injected write error, giving up left the new entry pointing at the root directory, and fsck.fat wanted to remove it. Retrying the cleanup left the filesystem clean. If either the read or the cleanup write fails, we stop and report corruption anyway.
>>>
>>> Do you still think we should give up here? If you prefer not to retry the new-entry block after its failed write, should we also avoid rereading and rewriting dotdot_bh after a failed .. update?
>> 
>> Basically that path is not the failure of sinfo.bh, true? If so, we will
>> not need to re-read sinfo.bh here, just removing the added entries would
>> be ok. 
>> 
>> If we have to read sinfo.bh, the sinfo.bh may be failed the write and
>> cleared the uptodate. If so, I wonder why succeed by retry?
>> 
>> The above is my understand.
>> 
>> Thanks.
> Thanks. error_inode can also be reached when a different metadata buffer fails. In that case, sinfo.bh is still uptodate and bh_read() returns 1 without doing any I/O, so the removal proceeds directly.
>
> The test I mentioned did fail the write of sinfo.bh itself. The trace shows __sync_dirty_buffer() called from fat_sync_inode_metadata() failing on the new-entry block. The retry succeeded because fault injection was configured with times=1, so only that single write failed. bh_read() then reloaded the block and the cleanup write succeeded.
>
> That is why I kept the read. It is a no-op when sinfo.bh is still uptodate, and it allows a complete rollback after a transient write error. Would you still prefer to give up when the failed write cleared BH_Uptodate?

The actual write retry should be done by the block layer or drivers
(with reset of devices if it is required), retrying on FS layer just
make slower to fail basically.  I think we should just believe the
failure from block layer and don't retry.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
