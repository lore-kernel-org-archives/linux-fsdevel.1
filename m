Received: from mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96A4CA793
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867071; cv=none; b=ora32kJt9PR3AYV/4+H068/3aHlhBq6HrsI6pkBXRMW5LmbsPDx0wRKwey6NWmsBaOPWHTYRPCkfUqt6PI0uOHmvaPEhTD1pFiDgPZf89+ObRZToh20IqHQDlI1t7d718HWyqAv1ek+3lSF06T6WuPcUU21Bi1REszmkq82TBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867071; c=relaxed/simple;
	bh=u8J66aam5HAU3EWrKJfVOFwKlJPnOYn4J4IC9+9xLnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpIdaV8FRlr/z7YQdTdxeagiouhmq6MWLLVv8gEqkdkEUiQ0XTezSzodpOkezTz/ZcMWk1w2m7lVyk2H0FPh8hdWNkeSgdZ0BQtwClNbMbVtRl0vAeM5leYiNAOQefS0zvEh2Tkn45F8U4tEPKRRWyLWx+vmsx99Tm99+C0v4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gGARx6Tv; arc=none smtp.client-ip=95.215.58.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gGARx6Tv"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u8J66aam5HAU3EWrKJfVOFwKlJPnOYn4J4IC9+9xLnk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788867061; v=1; x=1789471861;
 b=gGARx6TvljhZxn3wQ90OPpLeZ+gOca9cflYOlVJs6elN369NvRAvAHQQR/eHU9thSf7sv+tl
 gdSkinhip0iHsgunVPb+SI42IQzaLgK1QNhu9hfAoh2niY0A9dIz9wEQmefDWY17TYbvEytWh3K
 IlcAPGMhsDYOLQ+73ZxibGRc=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c921d85a689fffe6;
	Tue, 08 Sep 2026 11:31:01 +0000
X-Mizu-Trace-ID: c921d85a689fffe6
X-Migadu-Flow: FLOW_OUT
Message-ID: <6e54b8b3-150d-4d41-b4d1-8c5793edb840@linux.dev>
Date: Tue, 8 Sep 2026 19:30:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] buffer: guard folio_test_dropbehind() against a NULL
 b_folio in __bh_submit()
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Chao Shi <coshi036@gmail.com>,
 Weidong Zhu <weizhu@fiu.edu>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260908023600.788219-1-ridong.chen@linux.dev>
 <mpqseqzxcgyug5cwk5sivtyngvtcz7az7pugzv65nkm3ylmwjq@rfhz34dg655s>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <mpqseqzxcgyug5cwk5sivtyngvtcz7az7pugzv65nkm3ylmwjq@rfhz34dg655s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2026 6:07 PM, Jan Kara wrote:
> On Tue 08-09-26 10:36:00, Ridong Chen wrote:
>> From: Ridong Chen <chenridong@xiaomi.com>
>>
>> Commit 8deae2284976 ("buffer: allow a buffer_head to point at memory
>> outside the page cache") made bh->b_folio optional: jbd2 submits a shadow
>> buffer_head whose data lives in slab (the frozen/escaped copy of a metadata
>> block), and such a buffer carries no folio at all - b_folio stays NULL from
>> alloc_buffer_head() onwards (see the comment in
>> jbd2_journal_write_metadata_buffer()).  That commit audited __bh_submit()
>> and taught bio_add_folio_nofail() and wbc_account_cgroup_owner() to check
>> for a NULL folio, but it missed an earlier dereference:
>>
>> 	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
>> 		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>>
>> That test was added by commit a2c924c240e7 ("buffer: set
>> BIO_COMPLETE_IN_TASK for dropbehind writeback"), which predates the
>> NULL-b_folio semantics and so dereferenced b_folio unconditionally.  Once
>> b_folio may be NULL, folio_test_dropbehind() reads NULL->flags and the
>> kernel takes a NULL pointer dereference.
>>
>> This is reached from the jbd2 commit path (bh_submit() -> __bh_submit())
>> whenever a shadow buffer is submitted, i.e. when a metadata block has to be
>> escaped or was copied out, so it is data/timing dependent rather than seen
>> on every commit.  When it does hit, it is deterministic and independent of
>> the dropbehind bit, since the flag test dereferences the folio before
>> examining it.
>>
>> Reproduced on x86_64 with KASAN under filesystem write pressure:
>>
>>    KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>>    RIP: 0010:__bh_submit+0x21b/0x9d0
>>    Call Trace:
>>     bh_submit+0x15/0x30
>>     jbd2_journal_commit_transaction+0x1c19/0x5ac0
>>     kjournald2+0x1cf/0x760
>>
>> Guard the flag test with a b_folio check, matching the other folio
>> accesses in the same function.
>>
>> Fixes: 8deae2284976 ("buffer: allow a buffer_head to point at memory outside the page cache")
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> 
> A similar fix was already posted here [1] and is on its way to upstream.
> 
> 								Honza
> 
> [1] https://lore.kernel.org/all/20260902013357.2815214-1-joseph.qi@linux.alibaba.com/
> 

Apologies, I missed that. Thank you for letting me know.

>> ---
>>   fs/buffer.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/buffer.c b/fs/buffer.c
>> index 427d8a817cd5..f46fa6413032 100644
>> --- a/fs/buffer.c
>> +++ b/fs/buffer.c
>> @@ -1106,7 +1106,8 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
>>   
>>   	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
>>   
>> -	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
>> +	if (bh->b_folio && folio_test_dropbehind(bh->b_folio) &&
>> +	    op_is_write(opf))
>>   		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>>   
>>   	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
>> -- 
>> 2.34.1
>>

-- 
Best regards
Ridong

