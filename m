Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484906;
	b=MlPItPfGJ7KaMT4b/pxHvtiRwG2LoWelUEFFD+ulzeZ6qQThbThU+gwiRymG5RNLtjDs
	 bIwS39GLOVzhxEHPFziJMww/3UeM9oGBQstmWcMJU8EHd+1XyJDBv4CoINaGw6jag6QfR
	 2ejFpt/6RcK4WRfR/Y96E2/FqDlXh2eSyJls2FECYrY7/4v3Xy/DhsyJwJYuabt09WEhP
	 uSSpg9//Qp1DmRGXW2bq0TDBaAXiWNksf8+22xtBB6fEH17p5zeJloVjz4RUhBr4vkTli
	 plJrLXE9c1gxx0NtViuIg1INNb5ukoXup4xAPeciY5O/saJpERelT7Z2u6N4hxvdRUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LqA+OZmo2M6tqsVAGTcyRM8yq3jp+Ep4XD34ypKdY3g=;
	b=rLE/SR+W0m18XwPBufHd3/NL9cEID9MK5t0V+trztHSdXsHe/LgYyugG3ZgkSJZOEZOn
	 IaxqiyVIwK75ZpQEPPSYAYge5E9RzN9M6YBoejTRlgLWV9iihwtet8K7BInAN79LtclCk
	 bD7Ag8t1nip+zPeJzZD2CoXGy7pgN4rYNsJwAgHIxovQq2lQR4BvD2yaaR3y3G0qFA3Uh
	 MyOMlvPtoK9JIzon/ti7oD1gIL0FsNvqqwINgdE97X4Al4+S3dRJ7c4Xa9jRujZf0EzOP
	 44CEHiuy4vsCLEH0x+fY1vXMZPIg+s9wydBz7ym3M1JWMx0gnOHnSGsSTFCVlbeYyog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y5XymzaN;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F4606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 08:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB6F4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y5XymzaN
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4550d8ab15so153948166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 01:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792484904; x=1793089704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LqA+OZmo2M6tqsVAGTcyRM8yq3jp+Ep4XD34ypKdY3g=;
        b=Y5XymzaN7gktLjs3agPH8rqJ6jlP1aeR213eG5LJYHHMcCCrmqDXF6esthVnI0EbMb
         pNXj71VKps1mfZ0/6qbJz13qWehaaAy9WPW1VIlthsFp3zFAjBcgVuO1KJ3ar6M5TJUj
         SFw2yN5L6TBRuNfeymv8kCHtx4I03HrRldkum/kUoKtNIsOR2l7duYWMmJNI0gf89bOo
         CfIqxlYIItNocv8xTAvxq0xKxxkvStk6I+DVBNhUmV7xu361KyvmI/i4VxYnhOFKfNcH
         LMHMS+uE0KUttJ0OBp8dKklkitIuyvl+ItCeWBVqYqO7sT637y3SIsPCxkqumm0Dcjx1
         Zrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484904; x=1793089704;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqA+OZmo2M6tqsVAGTcyRM8yq3jp+Ep4XD34ypKdY3g=;
        b=dRdc4BrM59uub/phS48t30wW6HRsMYWaHEI0fG6oM4qy77YGztshJSa7qGWRNt9VOa
         Xv0jjbOEEsg1+DsbX8XZ1TWw4U93w/2q3iwK6P+ylXL7B+HKVnQNBFf/SRUSlTXXCSal
         X0SvrrNUP5K1l0GV2ITCy4aYYqY7YXtUPIx6HWONwc7MFog6FHnmWQs2zVfsJ59spqVz
         H714ERxPDeql/57URepuMs6XkuE0ULc3WkZ5I2lXlq2NCcluFybtIgyg1K4U+kakLzp9
         QUfxMKsgDLJ85nFnTabMnrXQIjSQVU6GuYwsNuTZ2f2V44AXlHCIxqcbMyym50SuvFvO
         7Tbg==
X-Gm-Message-State: AFq9FYJYxXKt1HNCqWlesNcgrGCmRX4JwvWg0MR2sb7tXzGwIFGoTsMb
	R0xk0qimOjcjTcg2pIJ6KONFJlsod2IKZn2FPZEtspmO3pWfVKJ01qP/VMU+xpSfPW8LTA==
X-Gm-Gg: AYBFou1hLXwy6apvE6YRFhat2ksPGnHojUn/PzvPGZ8q1FUCvm5yaEdUnRmdCcAzrc+
	HmxFsvFO17njYVSL2YHi16lf5EWk3oMaR7XyillvAuYUANH6r+i3KhOWjV3EBVwoCZuTuh5SUhX
	GlOxYJ0pfAEWsdlJYj6sEmfBkPqJYqIjbxJQe3wUpLKBk5rhJDb63TSPLDhniAgOU/5KxtKb+LQ
	kpCU4JZAT8tgxDL3KQ+kfk+GGZqXMpSvTwegaSYlDg+D5GkpyA7uPNgbkvFqVsSiK1xNugxaDnO
	DiMyGN4Kbweh+7naCugCp36+60sP6PbQ2VmPUeOn5ffxGA0YTAcU2bQNQWLzZXY1FZ/R5rmg19p
	gJXMHwJblY7IkFlS0KuDRnSigaH5wnBgn6T0NWgjuEJqx3HaBjbUMkO1UohZxrXUH0iJ71/3lMj
	n2n2Y4jGTZKmETMJnGlaUgHp4FTLrh5+g97wCn92bn+bNboRGC8c62DRRjLKFuB+bLJdCeHaFjn
	Fiu7RQiIVvTw4uL+UPUZar6b5p2EOxl0Uhx62w+9vjMBa/WRTfYBtITYe0C+VqmQ6bbtL0eS/Qi
	vrNCk95yCKSbsAAtRCvunfS2cPP3/M0teCYorxSNDl82D4AJKGzc4EXIgYrujpcZfR++KmvW+/s
	1ZlC/P00e3zM9Tgcws8Se1JcWmA2wUNBtVQ==
X-Received: by 2002:a17:907:c408:b0:c40:d920:7489 with SMTP id a640c23a62f3a-c419f9fd9e0mr704689566b.39.1792484903869;
        Tue, 20 Oct 2026 01:28:23 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb164fsm453402866b.70.2026.10.20.01.28.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 01:28:23 -0700 (PDT)
Message-ID: <2ba329a1-ad8c-4b6a-8dd6-1f93c85224c0@gmail.com>
Date: Tue, 20 Oct 2026 10:28:23 +0200
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
Subject: Re: [PATCH v4] fat: make rename recovery safe after metadata write
 errors
To: linux-fsdevel@vger.kernel.org
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
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <87wlrdy8ch.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/26 18:15, OGAWA Hirofumi wrote:
> Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:
> 
>> A failed synchronous FAT metadata write clears BH_Uptodate. Rename
>> recovery can then modify and dirty the same retained buffer, which
>> triggers the !buffer_uptodate warning in mark_buffer_dirty().
>>
>> Stop on-disk rollback after a failed dotdot update or old-entry removal,
>> where a complete rollback can no longer be guaranteed.
>>
>> An inode-position write can also fail through another associated metadata
>> buffer. In that case the retained new-entry buffer remains uptodate, so
>> remove the added entry directly. Check the buffer state and dirty the
>> entry while holding the buffer lock. If the entry buffer itself failed
>> writeback, leave it untouched instead of reading it again and submitting
>> another write from FAT.
>>
>> Keep the existing replacement and exchange inode-position recovery. When
>> recovery starts after an exchange position write fails, attempt both
>> restorations so a failure of one does not suppress the other.
>>
>> Report recovery errors as corruption and preserve the original forward
>> error.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
>> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
>> ---
>> Changes in v4:
>> - Trust a final block-layer write error. Do not reread or retry the retained
>>   new-entry buffer from FAT when it is no longer uptodate.
>> - Remove the added entry directly when its retained buffer remains uptodate.
>>   Hold the buffer lock across the state check, entry mutation and dirty mark.
>> - Keep failed dotdot writes and failed old-entry removal on the v3
>>   no-rollback path.
>>
>> v3: https://lore.kernel.org/all/20261014082315.190262-1-krystianmkaniewski@gmail.com/
>>
>>  fs/fat/dir.c         | 27 +++++++++++++++++--
>>  fs/fat/fat.h         |  2 ++
>>  fs/fat/namei_msdos.c | 37 +++++++++----------------
>>  fs/fat/namei_vfat.c  | 64 ++++++++++++++++----------------------------
>>  4 files changed, 62 insertions(+), 68 deletions(-)
>>
>> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
>> index 35bdb62944a2e..70433361359cb 100644
>> --- a/fs/fat/dir.c
>> +++ b/fs/fat/dir.c
>> @@ -1066,7 +1066,9 @@ static int __fat_remove_entries(struct inode *dir, loff_t pos, int nr_slots)
>>  	return err;
>>  }
>>  
>> -int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
>> +static int fat_remove_entries_internal(struct inode *dir,
>> +				       struct fat_slot_info *sinfo,
>> +				       bool require_uptodate)
>>  {
>>  	struct super_block *sb = dir->i_sb;
>>  	struct msdos_dir_entry *de;
>> @@ -1079,8 +1081,15 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
>>  	 */
>>  	nr_slots = sinfo->nr_slots;
>>  	de = sinfo->de;
>> -	sinfo->de = NULL;
>>  	bh = sinfo->bh;
>> +	if (require_uptodate) {
>> +		lock_buffer(bh);
>> +		if (!buffer_uptodate(bh)) {
>> +			unlock_buffer(bh);
>> +			return -EIO;
>> +		}
>> +	}
>> +	sinfo->de = NULL;
> 
> Looks like strange to check buffer_uptodate() (or
> buffer_write_io_error()?) at here. Why lock_buffer is required (rename
> locks are not enough? which race?), and why not checked at rename error
> path?
> 
>>  	sinfo->bh = NULL;
>>  	while (nr_slots && de >= (struct msdos_dir_entry *)bh->b_data) {
>>  		de->name[0] = DELETED_FLAG;
>> @@ -1088,6 +1097,8 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
>>  		nr_slots--;
>>  	}
>>  	mmb_mark_buffer_dirty(bh, &MSDOS_I(dir)->i_metadata_bhs);
>> +	if (require_uptodate)
>> +		unlock_buffer(bh);
>>  	if (IS_DIRSYNC(dir))
>>  		err = sync_dirty_buffer(bh);
>>  	brelse(bh);
> 
> [...]
> 
>> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
>> index d46d1a3851f25..6c833ed1affb3 100644
>> --- a/fs/fat/namei_msdos.c
>> +++ b/fs/fat/namei_msdos.c
>> @@ -441,7 +441,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>>  	struct fat_slot_info old_sinfo, sinfo;
>>  	struct timespec64 ts;
>>  	loff_t new_i_pos;
>> -	int err, old_attrs, is_dir, update_dotdot, corrupt = 0;
>> +	int err, old_attrs, is_dir, update_dotdot, rollback_err = 0;
>>  
>>  	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
>>  	old_inode = d_inode(old_dentry);
>> @@ -533,7 +533,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>>  		if (IS_DIRSYNC(new_dir)) {
>>  			err = sync_dirty_buffer(dotdot_bh);
>>  			if (err)
>> -				goto error_dotdot;
>> +				goto error_no_rollback;
>>  		}
>>  		drop_nlink(old_dir);
>>  		if (!new_inode)
>> @@ -543,7 +543,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>>  	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
>>  	old_sinfo.bh = NULL;
>>  	if (err)
>> -		goto error_dotdot;
>> +		goto error_no_rollback;
> 
> Hm, I may be confused more or less though, do we have to give up whole
> if dotdot_bh and here are failure? Maybe we give up only if old_sinfo.bh
> was the cause of I/O error actually? Checking and tracking the error
> state is too complex or something?
> 
>>  	inode_inc_iversion(old_dir);
>>  	fat_truncate_time(old_dir, &ts, FAT_UPDATE_CMTIME);
>>  	mark_inode_dirty(old_dir);
>> @@ -561,37 +561,24 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>>  	brelse(old_sinfo.bh);
>>  	return err;
>>  
>> -error_dotdot:
>> -	/* data cluster is shared, serious corruption */
>> -	corrupt = 1;
>> -
>> -	if (update_dotdot) {
>> -		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
>> -		mmb_mark_buffer_dirty(dotdot_bh,
>> -				      &MSDOS_I(old_inode)->i_metadata_bhs);
>> -		corrupt |= sync_dirty_buffer(dotdot_bh);
>> -	}
>> +error_no_rollback:
>> +	/* Do not continue an on-disk rollback that cannot be completed. */
>> +	rollback_err = err;
>>  error_inode:
>>  	fat_detach(old_inode);
>>  	fat_attach(old_inode, old_sinfo.i_pos);
>>  	MSDOS_I(old_inode)->i_attrs = old_attrs;
>>  	if (new_inode) {
>>  		fat_attach(new_inode, new_i_pos);
>> -		if (corrupt) {
>> +		if (!rollback_err) {
>>  			mark_inode_dirty(new_inode);
>> -			corrupt |= sync_inode_metadata(new_inode, 1);
>> +			rollback_err = sync_inode_metadata(new_inode, 1);
>>  		}
>> -	} else {
>> -		/*
>> -		 * If new entry was not sharing the data cluster, it
>> -		 * shouldn't be serious corruption.
>> -		 */
>> -		int err2 = fat_remove_entries(new_dir, &sinfo);
>> -		if (corrupt)
>> -			corrupt |= err2;
>> -		sinfo.bh = NULL;
>> +	} else if (!rollback_err) {
>> +		/* Do not retry a write error reported for this buffer. */
>> +		rollback_err = fat_remove_entries_if_uptodate(new_dir, &sinfo);
>>  	}
>> -	if (corrupt < 0) {
>> +	if (rollback_err < 0) {
>>  		fat_fs_error(new_dir->i_sb,
>>  			     "%s: Filesystem corrupted (i_pos %lld)",
>>  			     __func__, sinfo.i_pos);
> 
> [...]
> 
>> @@ -1067,7 +1056,7 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>>  	struct inode *old_inode, *new_inode;
>>  	struct timespec64 ts = current_time(old_dir);
>>  	loff_t old_i_pos, new_i_pos;
>> -	int err, corrupt = 0;
>> +	int err, rollback_err = 0;
>>  	struct super_block *sb = old_dir->i_sb;
>>  
>>  	old_inode = d_inode(old_dentry);
>> @@ -1106,13 +1095,13 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>>  		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
>>  					    old_dotdot_de);
>>  		if (err)
>> -			goto error_old_dotdot;
>> +			goto error_no_rollback;
>>  	}
>>  	if (new_dotdot_de) {
>>  		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
>>  					    new_dotdot_de);
>>  		if (err)
>> -			goto error_new_dotdot;
>> +			goto error_no_rollback;
>>  	}
>>  
>>  	/* if cross directory and only one is a directory, adjust nlink */
>> @@ -1135,24 +1124,17 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>>  
>>  	return err;
>>  
>> -error_new_dotdot:
>> -	if (new_dotdot_de) {
>> -		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
>> -						 new_dotdot_bh, new_dotdot_de);
>> -	}
>> -
>> -error_old_dotdot:
>> -	if (old_dotdot_de) {
>> -		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
>> -						 old_dotdot_bh, old_dotdot_de);
>> -	}
>> -
> 
> Here gives up whole if a buffer had error too?
> 
> Thanks.
Thanks, you are right. This is my first FAT patch, and it turned out to be
more complicated than I expected. Thank you very much for taking the time
to review it.

I am thinking of handling this in v5 by checking buffer_uptodate() directly
in the rename error path, without the extra helper or buffer lock. A
non-uptodate dotdot or destination-entry buffer would be left untouched, but
rollback of independent metadata would continue.

The exception is an error returned by fat_remove_entries(old_dir, ...). That
can only come from syncing the retained old_sinfo.bh, so the source-entry
state would be uncertain and further on-disk rollback would stop in that
case.

For exchange, the failed dotdot buffer would not be retried. If the second
dotdot write failed, the first update would be restored if its buffer were
still uptodate, and then both inode positions would be restored. The original
forward error would still be returned.

Does this match the behavior you had in mind?
-- 
Krystian Kaniewski
