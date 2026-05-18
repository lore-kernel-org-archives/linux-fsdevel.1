Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578C3FB044;
	Mon, 18 May 2026 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109827; cv=none; b=MThba5lRKPbSEqxelvEQ/uwy0eluau7PcfZSyYRY+cpvphTNNJGthkEbt0sVPnhLFibyIom9N/b9U3JBxAXbh460yan75w8Y9zP4UzbVmbJZoxHMkTSy6Qb2PCylLjdXgKQQ+IhGsEQc4Ie2PHXnxnDMSrI0jeMSA0rpR8rDX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109827; c=relaxed/simple;
	bh=ZvcFnhY6ueercZUvJc49VJkmFhdYuRLbX7X42LTWs5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJorFCPxzWam5ZwAtgLCp2M4Mon1lOM4IqKZfiBThxZVW6wfxlhE5nki2N2ifgjeEO4lwy27FlvPwQhw+hPLYBv1fI+WXZvDMsSJWSM7QM1IJSYvJPVCVUvibq0HyfEEkcINpQYYoG7lZqWBNu9rLml1B2Ld1x5CdBBosbc4bAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lbB1P+b/; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lbB1P+b/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779109822; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CCEyD59qsgBU95uMHveztG/UUirW700DG8BsMevIJqU=;
	b=lbB1P+b/4YWkWu/t/2gaziTrcsJYRyZj8Hy+/TJdLmkyzWS8V2OtxrJcUpN8ulEC5GIkETNrX8TOnwnOCyzgALFqkkeIpn26Gx30KbWA/LA9Pztpl6cFaZML4i55bd/z55l5kc4OF4i/lb1uA/NPBdqqAj7DNtqAKNukUxC2p9k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X399JTb_1779109821;
Received: from 30.221.131.155(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X399JTb_1779109821 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 21:10:21 +0800
Message-ID: <306ba367-0e84-465f-8449-d88c45eb68b7@linux.alibaba.com>
Date: Mon, 18 May 2026 21:10:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] writeback: drop now-unnecessary rcu_barrier() in
 cgroup_writeback_umount()
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
 <20260517142147.3354909-3-libaokun@linux.alibaba.com>
 <q75moaoyuys22umiai3h6jnrowes37rrif2ap6v44j7vgd7qgw@lx4esnq6stjg>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <q75moaoyuys22umiai3h6jnrowes37rrif2ap6v44j7vgd7qgw@lx4esnq6stjg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2026/5/18 21:01, Jan Kara 写道:
> On Sun 17-05-26 22:21:31, Baokun Li wrote:
>> Commit e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
>> switching inodes") replaced the queue_rcu_work() based scheduling of
>> inode wb switches with a plain queue_work().  Since then no switcher
>> goes through call_rcu(), so rcu_barrier() in cgroup_writeback_umount()
>> has no work to wait for and is effectively a no-op.
>>
>> Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
>> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> Looks good. Just I think this should be folded in patch 1, since you have
> proper Fixes tag, I don't think there's a concern this would be backported
> to kernels where rcu_barrier() is still needed.
>
> 								Honza

Thank you for your review!

Because the two patches have different fix tags, there is concern that
removing rcu_barrier here could cause the stable branches still using
queue_rcu_work (5.10.y, 6.6.y, ...) to reintroduce similar issues when
the round of fix patches deletes this necessary synchronization.

Therefore, the patches are split into two to make their purposes clearer.


Cheers,
Baokun

>> ---
>>  fs/fs-writeback.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index 1f95ddcee363..9ae290547eb2 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -1246,11 +1246,6 @@ void cgroup_writeback_umount(struct super_block *sb)
>>  		 * will then drain it.
>>  		 */
>>  		synchronize_rcu();
>> -		/*
>> -		 * Use rcu_barrier() to wait for all pending callbacks to
>> -		 * ensure that all in-flight wb switches are in the workqueue.
>> -		 */
>> -		rcu_barrier();
>>  		flush_workqueue(isw_wq);
>>  	}
>>  }
>> -- 
>> 2.43.7
>>

