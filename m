Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630213F86FF;
	Mon, 18 May 2026 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105165; cv=none; b=WnCqjbseMmB1zHcx9r1AMOH4dT7jur8HIaLsn2Uai9Hwa+mNbSxMVYmm3hU+TPwF3IHWykd3ooLj2JNm9UFl4kOK+LVskGwx9IW8iHcrJJhBbIuAnmcELwZxs5/C1u9AWb02vp1EfVgXshItz1npUzxNltyW78JfbUEAz7M5QYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105165; c=relaxed/simple;
	bh=wbQUDBkdz7/ptgHWHonc39KioGMt58wosVpXgsglVoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ga1fkhtByqvU+vVw9JSai19JfLbaZ4KjqqfgmcE9ua4UYfgzmzyCuDBcD1Jk74nZIxUd0DeFg1Pf/z5q5JLdJ19fxSxm7lm1h8ezNJLpAomzjII/F4tY1w6zMojBGQoArTNBI7gYujoJMQ1qlafdfUNcIXJ7yBY4tIFUJQf1qiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ENKCtWu3; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ENKCtWu3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779105158; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3GtCS+hIwnY7OgZdEmVvS9GUU2peuTeA0/MCf7ioF4w=;
	b=ENKCtWu3GAkCDeoWqgttp1BJ0kTuTz6HTHTVqOBoBKJNXAlFU9DHSAPphtR8fZO3x01XaFs8JiLU/wxBrPxoYsyJ7tIfXAstuyQoKa5Ke7angHsfoZraKqo1ZS519rs7aT2JO4FkuQQDqmBLKDTR0AHnm8HxnLCjuEBLJOv0kyk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X38.0vQ_1779105157;
Received: from 30.221.131.155(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X38.0vQ_1779105157 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 19:52:37 +0800
Message-ID: <e1308815-c650-4b8e-bdf4-0e36d0e2458f@linux.alibaba.com>
Date: Mon, 18 May 2026 19:52:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] writeback: use a per-sb counter to drain inode wb
 switches at umount
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 tj@kernel.org, linux-kernel@vger.kernel.org
References: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
 <20260517142147.3354909-4-libaokun@linux.alibaba.com>
 <177910456953.488929.2169908940676707307.b4-review@b4>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <177910456953.488929.2169908940676707307.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2026/5/18 19:42, Christian Brauner 写道:
> On Sun, 17 May 2026 22:21:32 +0800, Baokun Li <libaokun@linux.alibaba.com> wrote:
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index 9ae290547eb2..4282fcfe027b 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -1215,38 +1209,30 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>> [ ... skip 38 lines ... ]
>> -		 * in-flight switcher that already passed the SB_ACTIVE check
>> -		 * to finish queueing its work, so flush_workqueue() below
>> -		 * will then drain it.
>> -		 */
>> -		synchronize_rcu();
>> +	while (atomic_read(&sb->s_isw_nr_in_flight)) {
> Would probably be a bit nicer to just wait until the count is zero?
> We have that pattern for inode_dio_wait(). So something like (untested):
>
> static bool cgroup_writeback_finished(const struct super_block *sb)
> {
> 	if (atomic_read(&sb->s_isw_nr_in_flight) == 0)
> 		return true;
>
>    	flush_workqueue(isw_wq);
> 	return false;
> }
>
> void cgroup_writeback_wait(const struct super_block *sb)
> {
> 	wait_var_event(&sb->s_isw_nr_in_flight, cgroup_writeback_finished(sb));
> }
>
> void cgroup_writeback_finish(const struct super_block *sb)
> {
> 	if (atomic_dec_and_test(&sb->s_isw_nr_in_flight))
> 		wake_up_var(&sb->s_isw_nr_in_flight);
> }
>

Thank you for your suggestion!

Totally agree. sashiko also raised similar opinions, and
I will send out the v3 patch using this proposal right away.


Cheers,
Baokun

