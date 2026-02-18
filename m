Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF327FB05;
	Wed, 18 Feb 2026 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440172; cv=none; b=IiUxIWFe8jbsciOEYPvNDlMgLKFMEULfKsWvdF1zT9x8UC2+w7t8zU27KErnwryXJfJi2klf6dN8tl7bBwJvitMgHWdEyy5CqxL5Upw4aOlEnalOf/e1ZvUuQ4KUYVvOXthFWz2lSYgcZ02C08WKSP/WyUszL2tW/WG4xfEDfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440172; c=relaxed/simple;
	bh=wMG3a8yty3q5hsDYex7pLyw4esOnTubg17mGWcotKkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HpKGiguetybUG4Hf+YtKZGjwbEcSoCIu/ydFPC6G6EM7GJ+EwOIdZzR1e1LCE03LtJGUbkuu2wvxe0kaO3CR6Rp72vS35pzE9VGmCKmRVgLYa6Xo5nNy1hukR9dKUkEVEfMGieBUfKBpBx8ChA43quKIxWuTvdao5aXvBvHlzbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=wjunCpWb; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=TaO2UKY5; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="wjunCpWb";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="TaO2UKY5"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 7AD1120A0176;
	Thu, 19 Feb 2026 03:42:47 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1771440167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4aSVxNTrcPoLuUQ8MfP8p4PehR2j2Jw8GKjFubqoPI8=;
	b=wjunCpWbNDotMdFEBJPg5zmEnLRrm0TBvJGjEyd3eGVjSn3LUvdtuUfa+tVHQp/DfoiWj1
	9Zxw0174T7LUkWh4Xy0XgV5SeTddCTgO2RAMUq7geYeH0L2pmL1gOyOo8HmWIEkU8b9iKd
	UGistMnGzufImEbu6E1B/lGH2GQK992OnW2PlQAm0zqwM28GyD9lkZOkdTTmvsrMztCYTV
	s7PHi1oQmXkNqdHILSg1nwJ6VolHxh0PkJoH6A7FVW4lF7CgFdM08fRzLOVunwPDE0PP2R
	2DwMhW5QziU2rDzRYbjmA0oOLzu2e6KK1fi0HrkcYVv8YvRmKtSxE24ay07eGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1771440167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4aSVxNTrcPoLuUQ8MfP8p4PehR2j2Jw8GKjFubqoPI8=;
	b=TaO2UKY5dOV9hCh1O3Y1kI+B7QKpJ7gFSTqPMrdzJgxBVf0Agys8nndJf35XuUiHOAzmnq
	tMIqRwaXK2TyRKCA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.2/8.18.2/Debian-1) with ESMTPS id 61IIgkbn124368
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 03:42:47 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.2/8.18.2/Debian-1) with ESMTPS id 61IIgkf1398552
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 03:42:46 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.2/8.18.2/Submit) id 61IIgkYn398551;
	Thu, 19 Feb 2026 03:42:46 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
In-Reply-To: <594BF488-47D8-498F-9777-7E48F6997F5E@zetier.com>
References: <594BF488-47D8-498F-9777-7E48F6997F5E@zetier.com>
Date: Thu, 19 Feb 2026 03:42:46 +0900
Message-ID: <87wm09evvd.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ethan Ferguson <ethan.ferguson@zetier.com> writes:

>> I didn't check how to know the label though, the label is only if
>> ATTR_VOLUME? IOW, any other attributes are disallowed?
> I'm pretty sure ATTR_VOLUME is disallowed except for:
> * Volume labels, where it is the only flag present
> * Long file name entries, where it is /not/ the only flag present
> This is why I check if attr == ATTR_VOLUME, not attr & ATTR_VOLUME

What happen on Windows if ATTR_VOLUME | ATTR_ARCH, for example? There
are many strange behavior tools for FAT.

>> What if label is marked as deleted?
> As far as I know, a Volume label can never be marked as deleted, but if you want me to change the behavior of my patch, just let me know how you would like me to handle it and I'd be happy to change it.

That state is easily happen too, I'd like to emulate Windows behavior if
possible.

>> I'm not sure though, no need to update timestamps? (need to investigate
>> spec or windows behavior)
> It's not in the spec that I know either, I'm happy to remove if you deem this unnecessary.

Rather I'd like to know if Windows updates it or not.

>>> +static int fat_convert_volume_label_str(struct msdos_sb_info *sbi, char *in,
>>> +                    char *out)
>>> +{
>>> +    int ret, in_len = max(strnlen(in, FSLABEL_MAX), 11);
>>> +    char *needle;
>> 
>> Silently truncate is the common way for this ioctl?
> When I implemented this in exfat, I returned -EINVAL for names that were longer than allowed, but only after converting from nls to UTF16. I can copy this behavior here as well.

I think we should avoid userspace adds workaround for per fs
behavior. So if possible, ioctl should behave same behavior or meaning
of error code.

>>> +    ret = msdos_format_name(in, in_len, out, &sbi->options);
>>> +    if (ret)
>>> +        return ret;
>> 
>>> +    /*
>>> +     * msdos_format_name assumes we're translating an 8.3 name, but
>>> +     * we can handle 11 chars
>>> +     */
>>> +    if (in_len > 8)
>>> +        ret = msdos_format_name(in + 8, in_len - 8, out + 8,
>>> +                    &sbi->options);
>>> +    return ret;
>> 
>> fat module should not import msdos module.
> Fair. How would you implement checking the validity of the new volume label?

For example, move label verifier to fat module instead, and export to
msdos module if required.

>> This rename will have to take same or similar locks with rename(2)?
> Sure, so should I only lock on sbi->s_lock through the whole function?

Hm, I expected to take same locking with vfs what does for rename(2)
syscall path. Otherwise, this would be able to race with normal dir rename.

>>> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>>> index 6f9a8cc1ad2a..a7528937383b 100644
>>> --- a/fs/fat/inode.c
>>> +++ b/fs/fat/inode.c
>>> @@ -736,6 +736,21 @@ static void delayed_free(struct rcu_head *p)
>>> static void fat_put_super(struct super_block *sb)
>>> {
>>>  struct msdos_sb_info *sbi = MSDOS_SB(sb);
>>> +    struct buffer_head *bh = NULL;
>>> +    struct fat_boot_sector *bs;
>>> +
>>> +    bh = sb_bread(sb, 0);
>>> +    if (bh == NULL)
>>> +        fat_msg(sb, KERN_ERR, "unable to read boot sector");
>>> +    else if (!sb_rdonly(sb)) {
>>> +        bs = (struct fat_boot_sector *)bh->b_data;
>>> +        if (is_fat32(sbi))
>>> +            memcpy(bs->fat32.vol_label, sbi->vol_label, MSDOS_NAME);
>>> +        else
>>> +            memcpy(bs->fat16.vol_label, sbi->vol_label, MSDOS_NAME);
>>> +        mark_buffer_dirty(bh);
>>> +    }
>>> +    brelse(bh);
>> 
>> Why this unconditionally update the vol_label at unmount?
> I can add a dirty bit to msdos_sb_info, and only write if it's present.

And why this update at unmount? Looks like it is natural to update like
normal rename.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
