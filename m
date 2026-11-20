Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176261;
	b=3RM19GEz/Y8ddfN8OJzRzCSz711PA6VzaB9Url9Da4rNhnsHp+Pq1x6mpSFJrJnU/cTM
	 7pdsZKmlXYMC9o0muTwivTx90k9Ag3NcfAdrBqpzOvwNmDvktROh/rMUEUKShtScFNbmP
	 PjA7ePw6wv0/NNMzjuvayjvYKDuGa/EQtxFNp76zKyIgtFYkyrsKMy2oE1ariukUaRI8z
	 bAgrjQUXRp3hQVjZEXQKm1+DaeXNlk6o8vW97qgZ7PDSloYgEddUzkWBZlKkZVKfWpbMx
	 b3UfqHxH3ftRjb34UMiKSebP2k0p9zqzzfcCrOZp0BA3yClOh2/q5AytGCeLvzGhC7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=f5jFU1oClGpHi+sP+eLcjKraNLMQXWt1ophJUUm0GbE=;
	b=glOI+AOrRfDtSK9EyMRRJHt2KYnXc+yPH70cN0AylN0wJW9QDuV7zqVCry6FRrEwmqoJ
	 vOinZ6OwO2w+S+Vcj5JqXz1u43mXXujb5K22zw2aS/dSFVwwGHB5oIV2q22m4EC/+2Ymn
	 fy471T2Zu4PpQOrYMSs08YBUm+GUElAGXybGkuRItPDn9/ChZO9nPtETy+fL267I8syL0
	 /ryRw0P+bV9T7KRzF1dODrvMu8+HdmClVP3xfbV5+xfUpfeWuOnaP95e3Oq0ZCwlP1NM5
	 2WOiANECI8jNdZqudjYTUISwOnIKjUyEnVUTf57bm8BumeUl1+SzLD63PPuS1SZKWig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JyqHZBSG;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB0606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 12:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79EB0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JyqHZBSG
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so404836266b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 04:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795176260; x=1795781060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5jFU1oClGpHi+sP+eLcjKraNLMQXWt1ophJUUm0GbE=;
        b=JyqHZBSGCCRqDdOHH65ZZy9yArIzKay9iBcAGj+JCP39dQWxzibSCZRuFYM9l+iNqC
         ces5ENxu9spsVKO9ohgXKIAXU1bbRyezWFmA+b2FHoyLzFoNlQI+7HD39OomPwhdb5DX
         C4LoYW6oqQMITUwQXNsowUpr7Vlci2qUQv2DpGWLfrGxRO6BnoIrsxkL0GBIvYadfT4Q
         7Qawy2XUZGLdTRJkQcNbgTZ4zUcZNXIWDvQ34wYzqefUxFGdaPu2dfabz9bFU/AaAXky
         qev/w6ejUs8bYaYzBQ8LDYo/ZXAiO4WP4fpYsKNeY2J5+PXqcz3nCo7Vlz1NlsideXcE
         OexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176260; x=1795781060;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f5jFU1oClGpHi+sP+eLcjKraNLMQXWt1ophJUUm0GbE=;
        b=uPwfvKOoqdfqI+y1F0oPpb57rxkg88SB/XruOIPxx3UD43ktpDv086OuguRrkgZOYg
         LYD3/SgcMknl50VeOJE+/P/zhM2jrCB8OFxDuJa6ypthXvHJl+DNtDITeFtFcBuTS59p
         bfDXXzeFFE7oypJzXENvMIpRC1HQNesPDVHicxvIja/WVrNoS91ZtrI0LgUFBEbm02vg
         W+UiKMVIPYSjsc/sT/vRtAYzWGtnj41Kqupxi48AudLQQkCXtOKkhnE9pFWER3tDyZlg
         WIECbT+bEvnatGCbFbSRTivfpYqxYsKVmSmt4aZLyYykt7xyGT73MRYNJmN73UGNkqpc
         Sm7Q==
X-Forwarded-Encrypted: i=1; AL+hErHw5iUHf34K35wPCDuBDjQm2jrqRuvlVhQzl5qXEQNfyu40YkE/23mzadqFgaTjLMA7a6fxpObUoZxIVlxr@vger.kernel.org
X-Gm-Message-State: APuU4Z/dRYPw5Ls2KqGhf27uoR+EEuYsp74M6S7D34JDnRaRn+hh96PG
	lOzEI6Ajwb0/KW2PT/P23O0o4KqR3+nhhs6oCrK7SNjM2egiMUBjue/n
X-Gm-Gg: AYBFou3cibz0WMbe5qZ/l66SFxXb/9ATgcNM4FruA6sgtTr2uisad0zBNJGSsdeGUHT
	M7QiKcjw8+BGK/6ONmxJ3t1Id5BB2wPilAhvDjtSBOF558Iiu8cBqohvewKWqZrZYXa0LiELoaZ
	foK3Y45M9iBhnKlhKxQ6/+dNvSzcm7wZIy1xfneJlS6md78I6h2gLEUHWfY5Zqgsv827dDUfMhX
	47UVASB20QeT8pFmQwQbAVsQCteMs9PapgNHNb11Wgz+5FQi7guXxc3sTOgIaRxrt285eUyPHp3
	EEozRKV6/yBaT3AahhLpE8lceeQDc/0XtlCPwElIX873/lYHvgxWVOMfPrzC8QCC0d87N0nDw0s
	59qrdRaUHTePJ8gowRMkDImoY1i1CcVWc6g1/TUlXl3RcI+MT7yqzuJ98KD+6QfaXlawwxJDmCw
	iNCFa/dk2n30TrxNY1Z51AR1iwf4tRdkxXhg00p1tLyNiLyzXao0Mq2w/MbVM+1gbX1s8GXbITv
	oqxLp55qkIFPt1I/2YcHYVh5rDfn/Ou0CeF4konbNB9skSsI/DvQEIJwoCxxMDozdKrXc08gDgL
	3o14eYXVpXXIu2Cn/6nvaGl4wLjadudJiTyAvr++qdg95P2xz+Q9f2Q0Qns+zrVx8IQKkLJGVTx
	vFGYMiVBXcwtjiBrCuPNDDtGTeIwdn7pZglEEHIxBl+ntanJx2BRHMALs2HzTwc0hBAFjZ0/cKH
	WSIDKN8RwYLmOMprCkkyJzN+kX9BZxnv64WvtURv2TdCU6lecMh6DvbgyMoR8bpAA=
X-Received: by 2002:a17:907:3dac:b0:c51:249f:7215 with SMTP id a640c23a62f3a-c51317e3341mr433349466b.7.1795176259541;
        Fri, 20 Nov 2026 04:04:19 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc5396sm88672866b.58.2026.11.20.04.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 04:04:19 -0800 (PST)
Message-ID: <91d8a899-e768-4a4f-8f56-50a7b6f8a293@gmail.com>
Date: Fri, 20 Nov 2026 13:04:18 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] fat: make rename recovery safe after metadata write
 errors
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
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
 <878q3uhv4h.fsf@mail.parknet.co.jp>
 <20261019145146.539233-1-krystianmkaniewski@gmail.com>
 <87wlrdy8ch.fsf@mail.parknet.co.jp>
 <2ba329a1-ad8c-4b6a-8dd6-1f93c85224c0@gmail.com>
 <20261102143013.492650-1-krystianmkaniewski@gmail.com>
 <87y0b3to5u.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <87y0b3to5u.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/26 15:04, OGAWA Hirofumi wrote:
>>
>>  fs/fat/namei_msdos.c | 18 ++++++++++++----
>>  fs/fat/namei_vfat.c  | 50 +++++++++++++++++++++++++++++++-------------
>>  2 files changed, 49 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
>> index d46d1a3851f25f..51d49a3ca93c14 100644
>> --- a/fs/fat/namei_msdos.c
>> +++ b/fs/fat/namei_msdos.c
>> @@ -562,14 +562,20 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>>  	return err;
>>  
>>  error_dotdot:
>> -	/* data cluster is shared, serious corruption */
>> +	/*
>> +	 * Complete the remaining rollback. Report corruption only if a
>> +	 * recovery step cannot be completed.
>> +	 */
>>  	corrupt = 1;
>>  
>> -	if (update_dotdot) {
>> +	/* A failed sync write clears BH_Uptodate, leave that buffer alone. */
>> +	if (update_dotdot && buffer_uptodate(dotdot_bh)) {
>>  		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
>>  		mmb_mark_buffer_dirty(dotdot_bh,
>>  				      &MSDOS_I(old_inode)->i_metadata_bhs);
>>  		corrupt |= sync_dirty_buffer(dotdot_bh);
>> +	} else if (update_dotdot) {
>> +		corrupt = err;
>>  	}
>>  error_inode:
>>  	fat_detach(old_inode);
>> @@ -577,11 +583,13 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>>  	MSDOS_I(old_inode)->i_attrs = old_attrs;
>>  	if (new_inode) {
>>  		fat_attach(new_inode, new_i_pos);
>> -		if (corrupt) {
>> +		if (corrupt && buffer_uptodate(sinfo.bh)) {
> 
> This check is ok with sinfo.bh?
> 

Yes. For an existing destination, msdos_lookup() reaches fat_scan()
through msdos_find(), while do_msdos_rename() calls fat_scan() with
the same normalized 8.3 name. Both identify the same directory entry,
so sinfo.i_pos equals new_i_pos and sinfo.bh is the buffer containing
that entry.

> 
> I guess this check is needed for msdos too? If so, maybe we want the
> helper function in fat module.
> 
> Thanks.

I agree that a common FAT helper would be the right shape if this check
were still needed. I prepared that version, but before sending v6 I
noticed that the buffer write-error contract changed in v7.4-rc1.

Commit 9f08e58149dc ("buffer: stop touching BH_Uptodate on write
completion") no longer clears BH_Uptodate after a failed write. The
failure is recorded in BH_Write_EIO instead. The same series changed
fat_sync_bhs() in 8417ab622ffc ("fat: check for a metadata write error
with buffer_write_io_error()"). The 9f08e58149dc commit message calls
out the mark_buffer_dirty() warning from this report as the reason for
the series.

I reran the original C and syz reproducers and targeted metadata write
faults on current mainline without a FAT patch. The writes still failed,
but the !buffer_uptodate warning did not occur.

This also means that changing the v5 checks mechanically to
buffer_write_io_error() would not be correct. The new buffer semantics
deliberately preserve the in-memory data so that a failed write can be
retried. In particular, suppressing the second dotdot rollback in
vfat_rename_exchange() would now remove valid recovery.

My current conclusion is that I should not send a FAT v6 for mainline.
Would you agree that 9f08e58149dc should be reported to syzbot as the
fix and that this FAT series should be dropped?

Older kernels that do not contain these buffer changes may still hit
the warning. Since the warning is now addressed in the buffer layer,
backporting the relevant v7.4 buffer changes may be preferable to
adding a separate FAT recovery change.

Thanks,
-- 
Krystian Kaniewski
