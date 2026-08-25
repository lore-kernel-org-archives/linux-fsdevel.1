Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E31A682E;
	Tue, 25 Aug 2026 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787620228; cv=none; b=HRwHSu5dQiuIDyJcnWI6YA82GO78/wXFOow2D06kWry+oVFvi7fXzyu+cvXiqSjnX4r+g2zczUbKmqWHJ5xdLvgEmaW+3kB9HLYQ6FRdE3oS5cMVP0c5uO84M0IoXWLjyZYp3sCPyQr9tcSXU8UaB8Sqb31aFo4oC27nM0Et0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787620228; c=relaxed/simple;
	bh=dwuW2nOddpZHdnsZ15aq6RlP4WWE2WfK4JDLoND/QkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igvCbGMkK3e9SxLYRYWGPEpCT91vl48zrQoYmaIIvgMoLkMY0fDLT88DChobKJxBzDxRRNpUiGUz9zkIVhbhOymveVPh/oA4XU99A3M9WD9k/A6wwwjNZuTu4Zq8gw/A5RvAT3mJOWwWcwJ29l1C4KRcH7cYuKZjGzsXF0YzmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=uevL+jt/; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="uevL+jt/"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id B91BB1D45F;
	Tue, 25 Aug 2026 01:10:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me B91BB1D45F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1787620220; bh=dwuW2nOddpZHdnsZ15aq6RlP4WWE2WfK4JDLoND/QkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uevL+jt/Dhd63MOE+jSdiv7Kiq5BTRvQVof0o6tWc3ckh53+fTQlal090DzkHJ7hX
	 R4BO/dOLVr6lUWuDJ9vXRdp4HCEK8t1UpQSOIKa4orgLxa20G+OmH2ci3SnKZN3YSf
	 z+4AMruNT3nb/a0IeWGXWmoFrYwVO+6Vx17cLTjA=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id y+rnGXvrjGodjAEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Tue, 25 Aug 2026 01:10:19 +0000
Message-ID: <787aea79-beb0-4f29-bb67-ee57f6c654c4@dev.snart.me>
Date: Tue, 25 Aug 2026 10:10:15 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fat: add noflush mount option
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260822173732.10230-1-dxdt@dev.snart.me>
 <871pbn6edz.fsf@mail.parknet.co.jp>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <871pbn6edz.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 18:45, OGAWA Hirofumi wrote:
> David Timber <dxdt@dev.snart.me> writes:
>
>> On most distros, udisks manages users' removable volume mount requests.
>> Udisks is configured to always mount FAT volumes with the 'flush' mount
>> option. This is largely okay for populating directory in small sizes,
>> but when a large number of files are involved, the flush behaviour acts
>> as a bottleneck point in fat_file_release(). The user may want to
>> disable the flush option temporarily before commencing such an intensive
>> operation.
>>
>> To cover this use case, introduce the new 'noflush' mount option. When
>> used in the mount options to mount a volume, it overrides the 'flush'
>> option previously specified. When used in remount, update it updates the
>> flag.
>>
>> This is a breaking change as traditionally, the mount options other than
>> rw and ro are ignored. The patch breaks this tradition by allowing
>> reconfiguration of 'flush' and 'noflush' mount options.
>>
>> Signed-off-by: David Timber <dxdt@dev.snart.me>
>> ---
>>  fs/fat/inode.c | 26 +++++++++++++++++++++-----
>>  1 file changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>> index 28f78df086ef..850df43ba354 100644
>> --- a/fs/fat/inode.c
>> +++ b/fs/fat/inode.c
>> @@ -813,10 +813,14 @@ int fat_reconfigure(struct fs_context *fc)
>>  	bool new_rdonly;
>>  	struct super_block *sb = fc->root->d_sb;
>>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>> +	struct fat_mount_options *new_opts = fc->fs_private;
>>  	fc->sb_flags |= SB_NODIRATIME | (sbi->options.isvfat ? 0 : SB_NOATIME);
>>  
>>  	sync_filesystem(sb);
>>  
>> +	/* allow reconfiguring "flush" or "noflush" */
>> +	sbi->options.flush = new_opts->flush;
>> +
>>  	/* make sure we update state on remount. */
>>  	new_rdonly = fc->sb_flags & SB_RDONLY;
>>  	if (new_rdonly != sb_rdonly(sb)) {
> Maybe, better to set after changed the read-only?
ACK

>> @@ -1047,7 +1051,7 @@ enum {
>>  	Opt_charset, Opt_shortname, Opt_utf8, Opt_utf8_bool,
>>  	Opt_uni_xl, Opt_uni_xl_bool, Opt_nonumtail, Opt_nonumtail_bool,
>>  	Opt_obsolete, Opt_flush, Opt_tz, Opt_rodir, Opt_errors, Opt_discard,
>> -	Opt_nfs, Opt_nfs_enum, Opt_time_offset, Opt_dos1xfloppy,
>> +	Opt_nfs, Opt_nfs_enum, Opt_time_offset, Opt_dos1xfloppy, Opt_noflush
>>  };
>>  
>>  static const struct constant_table fat_param_check[] = {
>> @@ -1110,6 +1114,7 @@ const struct fs_parameter_spec fat_param_spec[] = {
>>  	fsparam_flag	("debug",	Opt_debug),
>>  	fsparam_flag	("sys_immutable", Opt_immutable),
>>  	fsparam_flag	("flush",	Opt_flush),
>> +	fsparam_flag	("noflush",	Opt_noflush),
> fsparam_flag() is not including the "noflush" too?
I think I should use fsparam_flag_no() here. My bad.

It seems that you don't object to the idea. That's a good start!

If we want to do this, the
documentation(Documentation/filesystems/vfat.rst and mount(8)) should be
updated, too. fyi, `udisksctl mount -o` won't accept "noflush" so
that'll have to be fixed, too. Also have to make sure if "noflush" is
used in fstab, udisks2 overrides the system default settings.

Davo
