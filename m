Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334870;
	b=YRSbjqa5WyRroc/UD6FT2cq4Uz5oEFDDeR1sR42Ety/ytG8eyeY/cXYUPcWF6/YoRFJV
	 H9pFjRRV8u4tHeFPoCRJcgRZM0CJAWq/0BeqmQc82B3nf71+YWfamOnpVyDvQsSWSGjsV
	 /PxjCjgU3ZAvTt/MKDd4QATK5Xb1ZT9e9PXnkld32LiitqQuahqNUWWAvGxe8uKf/t4q8
	 Sv4SJmBIvGQmF+sopTLhQAv5BVFFMITTRq0cWnDk1RlaQ8BzxkAnzRWBiK9NI5dj+ixIx
	 y7ZnadNb/pT65LM7EIXK2XboO0H4i4Te2eeSOPNzZIKe6mNYMb9V4TL0drzhDOdBt2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334870;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4yqAEqXDiqcRK/Rodw9bnYdTEm0yL9iMD53ji8KEPTk=;
	b=iJ45G47jr3bBanhiHVT4/xCeAzcGyPtfe0yC/+lyV9+ydiyWh/0GodBfxNRqxFN312Qj
	 CPvQgDqOUDBOWJJryRARRculGRlkhykShoxjNbiqR9+VxtLs0zmlOlv2LOwDIKXpUsrk2
	 jW8BJNlUPG76+ckohgx0NLFnehhgzseX11PqTxK9qwrvd1Fokvlqhdac5eTy0igzXv9OE
	 OVOhjDpdF51S2iaraBr/bPu56nGi5WLZMBieNGqOook+G5cTdeerfj13PN2J8vJmsLXwW
	 MsRhWOOkXWOROWilM5oSQABTUJqwrPZTuc9yrog9IoFQ85HOmlvTPyQN0dwofbTukLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=VR96PyGm;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=9gwbiEW7;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C1606A31C;
	Fri, 30 Oct 2026 04:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC4C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=VR96PyGm;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=9gwbiEW7
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 3533526F7699;
	Fri, 30 Oct 2026 13:34:27 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793334867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4yqAEqXDiqcRK/Rodw9bnYdTEm0yL9iMD53ji8KEPTk=;
	b=VR96PyGmBKLr4KY4QP1YVHn5wYfITYeUPjsb73oWyzH7KQrQSgHKa3yBGhuizfOrkr7Bj0
	CSBvp8GdXQYFtnvYTyNYYxhohj0fdcCafvhA2YZElx4Bdo3/CQDk6Hnay+8e7mZivEePum
	8x3qdnyk6feAVN0jHePnT1y8cuI6ZExHcmUUEx3kAQvlIk92BM2Kho0MGUS9W8sDxiwB7z
	4Xg7u89bv9YbEmYnL686hLW/+q7KBz1bL1x9IJUCkOarw05sQ2mGwOR8z3Z0vq8s+x5Anq
	uVTnun2nseOZz4zQqd+jbU+VSlLwevwCfugP3HVVH0nFQ65VAM5S5C7RQWHVwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793334867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4yqAEqXDiqcRK/Rodw9bnYdTEm0yL9iMD53ji8KEPTk=;
	b=9gwbiEW7dinUGr+WeHCWaUOvFSiQXq4tjUA+GgY2AlVAWr0WFNYTkIi0Mvws8JU468krUk
	RlpADRglOCZc9ZCw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id B6648E0011E;
	Fri, 30 Oct 2026 13:34:26 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A469422001E2; Fri, 30 Oct 2026 13:34:26 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fat: fix parent link count when replacing a sibling
 directory
In-Reply-To: <87y0bfstbk.fsf@mail.parknet.co.jp>
References: <20261029202352.59890-1-dennylin0707@gmail.com>
	<87y0bfstbk.fsf@mail.parknet.co.jp>
Date: Fri, 30 Oct 2026 13:34:26 +0900
Message-ID: <87pkwrst65.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Hungyu Lin <dennylin0707@gmail.com> writes:
>
>> vfat_rename() and do_msdos_rename() adjust parent link counts only when
>> updating the dotdot entry for a move between different parents. Replacing
>> an existing empty directory in the same parent also removes a
>> subdirectory, but leaves the parent's link count unchanged.
>>
>> For example, renaming one of two sibling directories over the other
>> leaves the parent with four links instead of three. stat and ls report
>> the stale count, and find -links 3 does not match the parent.
>>
>> Drop the parent's link count for this case after the source entry has
>> been removed successfully. Leave cross-parent renames, regular files
>> and the existing error paths unchanged.
>>
>> As in rmdir, check that the parent's link count is at least three before
>> decrementing it. Report a filesystem error if corrupted directory entries
>> have left the count too low, rather than reducing it below two.
>>
>> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
>> ---
>> Changes in v2:
>> - Check the parent link count before decrementing it and report low
>>   counts with fat_fs_error(), matching rmdir(), as noted by Sashiko.
>> - Retain Hirofumi's Acked-by from v1.
>>
>> v1: https://lore.kernel.org/r/20261028211626.26103-1-dennylin0707@gmail.com
>> Review: https://sashiko.dev/#/patchset/20261028211626.26103-1-dennylin0707@gmail.com
>>  fs/fat/namei_msdos.c | 8 ++++++++
>>  fs/fat/namei_vfat.c  | 8 ++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
>> index c7500c2859e0..97289c9d9261 100644
>> --- a/fs/fat/namei_msdos.c
>> +++ b/fs/fat/namei_msdos.c
>> @@ -565,6 +565,14 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>>  		(void)sync_inode_metadata(old_dir, 1);
>>  
>>  	if (new_inode) {
>> +		if (is_dir && old_dir == new_dir) {
>> +			if (old_dir->i_nlink >= 3)
>> +				drop_nlink(old_dir);
>> +			else
>> +				fat_fs_error(old_dir->i_sb,
>> +					     "parent dir link count too low (%u)",
>> +					     old_dir->i_nlink);
>> +		}
>>  		drop_nlink(new_inode);
>>  		if (is_dir)
>>  			drop_nlink(new_inode);
>> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
>> index ff7652bf0410..c4d5628c05fa 100644
>> --- a/fs/fat/namei_vfat.c
>> +++ b/fs/fat/namei_vfat.c
>> @@ -1011,6 +1011,14 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>>  	vfat_update_dir_metadata(old_dir, &ts);
>>  
>>  	if (new_inode) {
>> +		if (is_dir && old_dir == new_dir) {
>> +			if (old_dir->i_nlink >= 3)
>> +				drop_nlink(old_dir);
>> +			else
>> +				fat_fs_error(old_dir->i_sb,
>> +					     "parent dir link count too low (%u)",
>> +					     old_dir->i_nlink);
>> +		}
>>  		drop_nlink(new_inode);
>>  		if (is_dir)
>>  			drop_nlink(new_inode);
>
> Thanks. Hm, how about move those same code to fat module
>
> 	fat_dir_drop_nlink()
>         EXPORT_SYMBOL_GPL(fat_dir_drop_nlink)
>
> as such function for 3 places?

Ouch, it should be 4 places.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
