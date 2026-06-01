Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8A41C72
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780280535; cv=none; b=Jw0lnV5ryNuNPkXdZu7aOTPEHdpDRPJCOmDj/sgCez4WJmnGyIH9Zf0/MCjhisPU5ywT3SL8i812SoXcm3QjLBFgRvsAJaMRUrNBep+6mRvihOKj5EAu4fwT9f/Xa8y3TZeKfzRBE/9U0gUK+EPUcdli248uu+PRgtZCPsRt0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780280535; c=relaxed/simple;
	bh=/mwC6WocMUG69S0jW9WX4Q5M6p37wBSIAOixCDz2XSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mwmx4uqLyx4VVTOBOB4GZWDw0QA/nXH0/pvjIR/xbFYW/UTqVm7Avy6IBsQDwrZne9pJAZ6qKxhFhIAUwJS/yWkm3FMvEtpGZhjKnkfhHxEaYGvIYR6aGTBBmiquriZaHlTmyAVQZj6zqgCj1BTBBKVtAM3GuVzS36hEa4zfUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jO4v7IVB; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jO4v7IVB"
Message-ID: <85c62d67-cbc9-4e7a-b60f-f0d73c17f862@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780280531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpmeJq0Hyk0ZwGp7nYbfeoL7vI95fjbFu/Y5afjjw6M=;
	b=jO4v7IVBQNKEZDZLwi5FZAiLZjuWSms5mpAwIFVqVjEJCjCTkRojKPNSj6NFez4mGmjp5T
	hpX+H8rPFNKypvVgRNObA19vXYcLL0A+d1f94L4xQ4z/aqJEy1XUcqphxFZF+80X2UIa0f
	4GDXsNOn/Vj84EfxiF271uctQrnkNmo=
Date: Mon, 1 Jun 2026 10:21:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fs/namespace: notify pollers of legacy propagation
 changes
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
References: <20260529095441.1744006-1-guopeng.zhang@linux.dev>
 <20260529-herzbrechend-kondor-zahnersatz-3152709a3b47@brauner>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guopeng Zhang <guopeng.zhang@linux.dev>
In-Reply-To: <20260529-herzbrechend-kondor-zahnersatz-3152709a3b47@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/5/29 18:23, Christian Brauner 写道:
> On Fri, May 29, 2026 at 05:54:41PM +0800, Guopeng Zhang wrote:
>> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
>>
>> Changing mount propagation through the legacy mount API changes
>> user-visible mountinfo contents, including the shared: and master:
>> optional fields.
>>
>> The mount_setattr() path already touches the mount namespace after
>> change_mnt_propagation(), so pollers of /proc/<pid>/mountinfo are woken
>> when the namespace event changes.
>>
>> The legacy mount --make-* path also changes propagation through
>> change_mnt_propagation(), and MOVE_MOUNT_SET_GROUP updates the
>> propagation relationship of the target mount. Both paths currently
>> return without touching the affected mount namespace.
>>
>> As a result, userspace polling /proc/<pid>/mountinfo can miss these
>> propagation-only changes even though mountinfo has changed.
>>
>> A simple reproducer that polls /proc/self/mountinfo while changing
>> propagation shows the inconsistency.
>>
>> Before this change:
>>
>>   legacy MS_SHARED: poll ret=0 revents=0x0
>>   mount_setattr MS_SHARED: poll ret=1 revents=0xa
>>
>> After this change:
>>
>>   legacy MS_SHARED: poll ret=1 revents=0xa
>>   mount_setattr MS_SHARED: poll ret=1 revents=0xa
>>
>> Touch the affected mount namespace after successfully changing
>> propagation state in do_change_type() and do_set_group(). Take the
>> vfsmount lock for write around touch_mnt_namespace(), as required by
>> its locking rules.
>>
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>>  fs/namespace.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 9a66a806a9b8..f871c7bf3bc8 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -2908,6 +2908,10 @@ static int do_change_type(const struct path *path, int ms_flags)
>>  	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
>>  		change_mnt_propagation(m, type);
>>  
>> +	lock_mount_hash();
>> +	touch_mnt_namespace(mnt->mnt_ns);
>> +	unlock_mount_hash();
>> +
>>  	return 0;
>>  }
>>  
>> @@ -3479,6 +3483,11 @@ static int do_set_group(const struct path *from_path, const struct path *to_path
>>  		list_add(&to->mnt_share, &from->mnt_share);
>>  		set_mnt_shared(to);
>>  	}
>> +
>> +	lock_mount_hash();
>> +	touch_mnt_namespace(to->mnt_ns);
>> +	unlock_mount_hash();
> 
> Doing this would cause seqcount readers to retry on mount propagation
> changes when all of them really only care about mount topology changes.
> So this can likely use:
> 
> guard(mount_locked_reader)();
> touch_mnt_namespace(mnt_ns);
> 
> Even today, observing an unchanged seqcount across mnt->mnt_flags reads
> doesn't guarantee that it really wasn't changed.
Hi Christian,

Thanks for the review and explanation.

I will send a v2 with the suggested changes.

Thanks,
Guopeng

