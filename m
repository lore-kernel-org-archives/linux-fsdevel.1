Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23862690D5;
	Wed, 20 May 2026 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277101; cv=none; b=V9W+rMtGskubpKK5wvorOYj7hJXVmC2xBiXLo5Z3MUufwqYcjnVYSNY/tRuCSteesLVRH+j9Dn3wcTiQBZCsAz2Cmrkw60EoIgXVkXI23jQPY9IbUGUtHhCWDT0bNQBsetVlI3fgXCZlrd3svtelim3MLr6nsmZDp20ZCp0BTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277101; c=relaxed/simple;
	bh=gaZRzEzHOY2CfFs2vHkxu2ftNSrYHUb55zifcifZlck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBrkBlxEV3f9dnbs+/KGXbyJsjqxgVTACXwGMO24WNKXbZbrCu7b2HqJcC6GYm7+xb7rtq9T/lYGrJU/WoQ2n7uwae3rPmA6qm02zmiUnBp03CmI7KakmEaXchZ6Q2CWIw5HaROlqx3n1fYHi60L84AuR9iELRdvh+ztQsVzCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ri3/Rfi2; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ri3/Rfi2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779277095; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ub71hIbpe3G2zjp/ezNUEfE96sZBOZFBfh43PEc2oV0=;
	b=ri3/Rfi2kZDiWCV1IOaKHrBdZtvbN5TR1ncPlhrmEGyqY19IAABq5/jfPHEBlGNI7lEnQdigQ0toGG/P+PX/kwfSylITO6VBF2vhwUC8t6YX2ImGkZxoJke0SPUc/Dwx9ZP9f523DJm/PuDeL9+sHiGZrTlQHcRnK9sOdnxIuMw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3Iu716_1779277093;
Received: from 30.221.129.237(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3Iu716_1779277093 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 May 2026 19:38:14 +0800
Message-ID: <fb678612-84cb-4b24-8e8b-1403ff1c26fa@linux.alibaba.com>
Date: Wed, 20 May 2026 19:38:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] writeback: drop now-unnecessary rcu_barrier() in
 cgroup_writeback_umount()
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20260518135349.1187628-1-libaokun@linux.alibaba.com>
 <20260518135349.1187628-3-libaokun@linux.alibaba.com>
 <loqxahkvp7givyu2uyngsah3blxegywjbslj7cay27nnut3z7s@zybn6vft6az7>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <loqxahkvp7givyu2uyngsah3blxegywjbslj7cay27nnut3z7s@zybn6vft6az7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/5/20 16:46, Jan Kara wrote:
> On Mon 18-05-26 21:53:48, Baokun Li wrote:
>> Commit e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
>> switching inodes") replaced the queue_rcu_work() based scheduling of
>> inode wb switches with a plain queue_work().  Since then no switcher
>> goes through call_rcu(), so rcu_barrier() in cgroup_writeback_umount()
>> has no callbacks of its own to wait for.  It still drains unrelated
>> call_rcu() callbacks from other subsystems on busy systems, which
>> incidentally slows umount down; drop it.
>>
>> Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
>> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> I've already replied to previous version but anyway: feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza


Hi Honza,

Thank you for your review!

Sorry for the rushed v3 — your Reviewed-by on v2 came in right after
I hit send, so I missed picking it up. I'll carry it forward in v4.


Thanks,
Baokun


>> ---
>>  fs/fs-writeback.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index 6766de9f9d75..325a30cc35bf 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -1248,11 +1248,6 @@ void cgroup_writeback_umount(struct super_block *sb)
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

