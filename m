Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09E4CA776
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157441; cv=none; b=Lg5TBtcVsBYKYP+A1VdG0BZuzDricE9wkpnBUx5+gCvDC84GsDBY3svzMVyLYV2ipOq4Zn58HMZ97+KM6m57iAsVSarVG5fvJsnjdojTMPIZrp4HHYH05YPutIwMOFg5yT06rataFCG+h+zrEhZhJNS6TDajeeBn4tnkuydc/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157441; c=relaxed/simple;
	bh=m7dsLq/wKmVRGvzLDRZvUS/FDv3R0+5Ku7yQvLAF4ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfW4mSeTlt++KguexG9HRo08eWos31THHnjbF1TxKYS7rSJ4r2CDqZ+aER6xAfUEWzXU1fSE7vvOY9gzGHWKMYBP2SkgEeFSi7FaoBwsfbqv7HMTuc3bP9a8TGVyEFw4ewVJ6ED5F02x6hvYbkBWt/UJmYBDsaqlxB7EEOaFXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cga1Juy2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cga1Juy2"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso547980066b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157427; x=1792762227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kN27WiywL9AeUaxnGRN/QPN0W0/4s85ChSl9l6b2SN0=;
        b=cga1Juy2zILm3PIuRYhAbSy7oSn9ml0uEkKRzqMi/zTHOZsMSGdmTZv4IHqRZOH2IR
         xsodk5nTKsu4eqFo94ucZWxpUiQFJq+wwCVJn1GuwyRqu4ZRlSrNEuedx11lglgEJtdC
         4rQM/U3CmQqHHvvYNlWJ958z617tQq7BAuVCaq8UnxsyQiKuFNTxUysZZNSmETMR+RQh
         68Qlyw1J9DGDYLiUF3F/7N3SECRoHyeHgfsgCep7kRaWJ6cH2Q4Tq6hYj1WBoGz5Ps8P
         hQu2uirkSurFVwl4PC6dlJWd3InTb5zYo1l+r3geW9D74VRqthfZhYZGmEylmcMtq/7y
         IoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157427; x=1792762227;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kN27WiywL9AeUaxnGRN/QPN0W0/4s85ChSl9l6b2SN0=;
        b=mgqIgawWYFhPR9CzJILh6wmLQepZJCzt2R9x351amzImIfLoUxRAh274XhRh44u+dE
         G+0WsVNraThGoRPk2lE5xe/NwLXXQcC+vGyBvm+9oktS4Mb3LboljroRTpTZ9V4mpdLG
         KSf+cSLFzWMeuvZC3n0qO9DMGe+oAtrLfHyF9E7nnbUq0zlJLKIF7oSxP5Rle28O6Szo
         t4DTd3jkJGe4gjAzIgqqj4rKxCGFpADJkEcqWGaClwmm3NxwwdVPkv7zdPjdGQNuR0PJ
         Iic5NpDh2dp/V7T81oQeYSy7opebxc7+zOBwzZXGbtQ+ICFHMdbthq540oRv0ILCU+4z
         3HLQ==
X-Forwarded-Encrypted: i=1; AKwUvByam4hmyofNW5orF4U8RohG+MFvwhJ5nPumXXpJ7sXcpEvY/QxPRBt2bTfJr+GbtLVGZmBZo0aZDc+szZKR@vger.kernel.org
X-Gm-Message-State: AFq9FYIpEvANoqgCCnM5AjTZf+OCOCyzehCuL/e+ouqt0KPyfAjlRoF4
	/hJyz5pSFuewRIjXDnpM9ml3dRRtHfbRv6WjFAiDycZEvmvyxF0mo6LJ
X-Gm-Gg: AYBFou3Gok4qOHsh06te995rDDXBv44e8YGXCAZ5qbLImY8oIylVTcnVWw6EYMaHUPV
	kcxV85oPtgbGw2oRS9dOAv/JtKtQwd3IkW6NAYU7Hb14jBN/FRbdqBU6/LSO+NJQ6Ivs65x3006
	4GKSCSW7iP4N/0BMWcn+LZEr0EBq0htnowCNRIRdn52Ilwv3PFGiCu0lRFfRGm8pdcM+Bq0TY5u
	o9B/e6rU1k8/yocj7O0PHbG/ZJ55QBrx0uAaVsR82TzBR/CCa5nCaLBv5+8EMdy0z+I+qT158Eo
	lMhWIpkZObQYSlKE0c95cZOwZRNiZ1z3bvf4YW+ZKfxuJvCkpCx7erEjaX0+YO7UaNBOALhs60I
	kkbPwhQ/Vj+Wea9Kkkdp8l5+f+jL2+Kdw410hMjt2eWaoI7+6J/wCBbx11jj3Rlr/gd0lWYGQys
	Ma6e2ntuPmXyn1IXyOCPY2A0mcr3oBx/eBO3E7YNGH81f4MDqkH9GPr0kaahi+7mZgOX3JWRAzJ
	7Ye0TfZs6RhgiR6rcKmZ9AdRtzdwIlUMYIT9f0EEx9NsyOumrqDrEQqwR+gC8ZYbNW/OTkyEww9
	hoQcx/6jDDwYzNxKRUHDngAY3s+tMtzFRL9pzQiu2KromIvLTWbujwvqMnM+O6JUAhT6p4lJ6Hk
	B2zaOl6dsp4SgdWD2FMxt/rzVyuXjD5TRvvA3bucpCMPj
X-Received: by 2002:a17:907:969e:b0:c3f:4d1:8cd7 with SMTP id a640c23a62f3a-c3f04e0e43fmr450871766b.25.1792157426634;
        Fri, 16 Oct 2026 06:30:26 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091fade41sm70478466b.82.2026.10.16.06.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:30:26 -0700 (PDT)
Message-ID: <55a1f016-a7a2-469f-b481-37223d695f29@gmail.com>
Date: Fri, 16 Oct 2026 15:30:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fat: make rename recovery safe after metadata write
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
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <87qzhqvloo.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 20:54, OGAWA Hirofumi wrote:

>> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
>> index d46d1a3..0aab2b1 100644
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
> What is wrong to try to revert dotdot_bh?
> 

Thanks, you are right about dotdot_bh. After a failed dotdot write, the source entry has not been removed yet. The buffer can be read again with bh_read() and, if that succeeds, the old dotdot value can be restored. A failure while removing the old entry is different because the on-disk state of that entry may already be uncertain. I can address this in v4 patch.

>>  	inode_inc_iversion(old_dir);
>>  	fat_truncate_time(old_dir, &ts, FAT_UPDATE_CMTIME);
>>  	mark_inode_dirty(old_dir);
>> @@ -561,37 +561,26 @@ out:
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
>> +		/* Read the entry block again if a failed write invalidated it. */
>> +		rollback_err = bh_read(sinfo.bh, 0);
> 
> Why do this read the bh from on disk?
> 

The bh_read(sinfo.bh, 0) is needed because a failed inode-position write clears BH_Uptodate. fat_remove_entries() modifies and dirties that retained buffer directly, which otherwise triggers the warning. Reading it first refreshes the whole block. If the read fails, the buffer is left untouched.

The same reasoning applies to both the VFAT and MS-DOS paths.

-- 
Krystian Kaniewski
