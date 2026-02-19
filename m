Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70F24B45
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771509646; cv=none; b=IDFL6KDHOLOMjknx1RTgVQsEC5j9FX3PvnghpfHGEaReHFD2XEu0ZVWADe1lnGEML/knDITjBk9WMqMrE3IvAUq133+mPJMfDJgBKpn1HiV+miebYecytYGZWX0tVg22Ozx9r/XMEDbHX4clgo0YbuEXnrkFQkHb045ZlmcRgwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771509646; c=relaxed/simple;
	bh=5IjJjHniOqxdypB4ABtjvZlYXXtQmktmND/HWkfDK6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkY1R5kchWQuao5tYhrrgJ4K7mR0EydWfNbGfa24Ch5B0ZcJ9nB1yL6xP7eEZmN7mmCeTacs7hpEeStOsUMKG6ZBiIkXCFy4Ax32jWfpB8fWK42V4B6+L3GKXS8P0w1WXT4Tv3Jm+M8WtATeX4GGBr5Q3TwdmuGDECMMoMfp8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61JE0Non067312;
	Thu, 19 Feb 2026 23:00:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61JE0Nhl067309
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Feb 2026 23:00:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a6e9fe8b-5a20-4c01-a1f8-144572fc3f4a@I-love.SAKURA.ne.jp>
Date: Thu, 19 Feb 2026 23:00:23 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: evaluate the upper 32bits for detecting overflow
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
 <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
 <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
 <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
 <37b976e33847b4e3370d423825aaa23bdc081606.camel@ibm.com>
 <f8700c59-3763-4ea9-b5c2-f4510c2106ed@I-love.SAKURA.ne.jp>
 <40a8f3a228cf8f3580f633b9289cd371b553c3e4.camel@ibm.com>
 <524bed1e-fceb-4061-b274-219e64a6b619@I-love.SAKURA.ne.jp>
 <645baa4f25bb435217be8f9f6aa1448de5d5744e.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <645baa4f25bb435217be8f9f6aa1448de5d5744e.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp

On 2026/02/19 7:07, Viacheslav Dubeyko wrote:
>> @@ -132,6 +132,7 @@ struct hfs_sb_info {
>>  	int work_queued;		/* non-zero delayed work is queued */
>>  	struct delayed_work mdb_work;	/* MDB flush delayed work */
>>  	spinlock_t work_lock;		/* protects mdb_work and work_queued */
>> +	bool suggest_fsck;
> 
> I completely don't see the point in adding likewise field. We always can share
> warning message in the point of problem detection.

Calling printk() so frequently can cause stall warnings.
Calling printk() upon mount time or unmount time is fine, but
calling printk() upon e.g. sync() time can become problematic.


> What's the point to make code so complicated? What's wrong with atomic64_t? Are
> you trying to save 32 bits? :) I completely don't see the point in such very
> complicated logic.

These are u32 version of atomic_add_unless(v, 1, -1) and atomic_add_unless(v, -1, 0),
for you said that it is confusing to keep in mind that we need to treat negative
value as positive.

You also said that "It will introduce the bugs easily.", but the reality is that
we had been failing to understand that the BUG_ON() in

	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
	atomic64_dec(&HFS_SB(sb)->file_count);

does not fire when HFS_SB(sb)->file_count < 0 due to s64 and u32 comparison.
We can avoid such oversight if we change it to u32 and u32 comparison using
dec_u32_unless_wraparound().


>> @@ -34,7 +34,6 @@ MODULE_LICENSE("GPL");
>>  
>>  static int hfs_sync_fs(struct super_block *sb, int wait)
>>  {
>> -	is_hfs_cnid_counts_valid(sb);
> 
> We need to check it for every sync because, potentially, file system could stay
> in mounted state for days/weeks/months. And corruption could happen during
> metadata modification.

Calling printk() for every sync() might cause stall problems.

Also, if I understand the code correctly, these counter values are "for your
information" level which is not guaranteed to be in sync with actual number of
files/directories. It does not worth making operations fail.


> Nobody checks the file system message after unmount because nobody cares. But
> everyone really cares about mount and regular file system operations. So, this
> check is too late and it is not necessary here.

Then, I suggest completely removing warning messages regarding these counter values.


>> @@ -66,8 +69,6 @@ static void flush_mdb(struct work_struct *work)
>>  	sbi->work_queued = 0;
>>  	spin_unlock(&sbi->work_lock);
>>  
>> -	is_hfs_cnid_counts_valid(sb);
>> -
> 
> This check is important because it is done during hfs_fill_super() call.

I couldn't catch, for INIT_DELAYED_WORK(&sbi->mdb_work, flush_mdb)
in hfs_fill_super() does not call flush_mdb().

