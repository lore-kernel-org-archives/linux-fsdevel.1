Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D036F8F5;
	Wed, 30 Sep 2026 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812368; cv=none; b=OtVFlnNxlOGulvEvEya4bbkrE2ZSlA83HMMSAJmv/DUQaeKdE/9sh3DLq0M64yhK+soueBbxBdAPTlbetXh7cy9ppxm9DU7NOMDPelUsY/TTorcS8jX1mNQ/We9donKlQ+wPNk3qiUbOXyeAVPjXcvbHu9pAaslzIKIkH2LkHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812368; c=relaxed/simple;
	bh=qsXZP3yY/GB1E5sPKXQzrKe6sxpylczAZnBKhEuILtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHGFWWRedGlJggbXVg6aU8Pc+M6c1jxqsumsFrVCxcaT6HlCbMXnykj2lM7ozBOiMMAbZDvvpD7lRu1uG5Ar3rX1Xuzinsm5cFsD/GFivJfaUxYFwl7rMx6qJNawYZ50ujTMxZ57oNG21NWf++Zv2+ZazBabb5QRH2cFm07PQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hDN7eRNh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hDN7eRNh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=P9RWBcGCk3Xbo2z7CDVaItHHT0O3h9NosdATHob8PdA=; b=hDN7eRNh67X0PekbsBzW2+rDOf
	mtR7HpYvp2xusS7YIqGiuXU6PRqVYvODwaT3ZK8gOPhhv6vOBPIHDFtz0pD7zwak/SKC8/ZspB1vG
	dRwpB86m8J0ngM9uEtUWXAMdloZCc5mpBnvRTFalRttu0VTJglDw8EuSO1lN9sx6MHKgE7BzG86is
	CM+tyEFvX+b0fChVlABEblXxfGS6a+FT/zkPpXHbo/pB91/RVNprNBEBBPbdmZ6YpRjsXk3MPIAOt
	hIoSslZvZBXwlfrnVO6Wyijs47D+Vq7UCrTa7bwPYdKD6Rktnb7o3coKc7ZgP5NpEW6rrVqSlvVQd
	kKGbDm0g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC46N-00000007U38-1Jqd;
	Wed, 30 Sep 2026 23:52:43 +0000
Message-ID: <7959d56d-b626-4a7b-b874-7ba1b50d9db7@infradead.org>
Date: Wed, 30 Sep 2026 16:52:42 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] VFS: d_duplicate: repair comments to avoid kernel-doc
 warnings
To: NeilBrown <neil@brown.name>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20260930224330.2110958-1-rdunlap@infradead.org>
 <179080947944.37859.7499013622677289038@noble.neil.brown.name>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <179080947944.37859.7499013622677289038@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/30/26 4:04 PM, NeilBrown wrote:
> On Thu, 01 Oct 2026, Randy Dunlap wrote:
>> Use a typical list style for comments to prevent kernel-doc warnings:
>>
>> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2029: ERROR: Unexpected indentation. [docutils]
>> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2030: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
>>
>> Also, modify the spelling of "whiteout" to match all other uses in
>> the kernel source tree and to be consistent on the same line.
>>
>> Fixes: 33d76519f0cc ("VFS: add d_duplicate()")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> v2: dropped Jan's Reviewed-by since the patch changed.
>>
>> Cc: NeilBrown <neil@brown.name>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: linux-fsdevel@vger.kernel.org
>>
>>  fs/dcache.c |   11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> --- linux-next-20260930.orig/fs/dcache.c
>> +++ linux-next-20260930/fs/dcache.c
>> @@ -2025,11 +2025,12 @@ EXPORT_SYMBOL(d_alloc);
>>   * @dentry: the dentry to duplicate
>>   *
>>   * Some rename operations need to be combined with another operation
>> - * inside the filesystem.
>> - * 1/ A cluster filesystem when renaming to an in-use file might need to
>> - *   first "silly-rename" that target out of the way before the main rename
>> - * 2/ A filesystem that supports white-out might want to create a whiteout
>> - *   in place of the file being moved.
>> + * inside the filesystem::
>> + *
>> + *   1. A cluster filesystem when renaming to an in-use file might need to
>> + *      first "silly-rename" that target out of the way before the main rename
>> + *   2. A filesystem that supports whiteout might want to create a whiteout
>> + *      in place of the file being moved.
>>   *
>>   * For this they need two dentries which temporarily have the same name,
>>   * before one is renamed.  d_duplicate() provides for this.  Given a
>>
> 
> Is "::" the right thing to do here?  The docs I could find suggests that
> it introduces literal text.  Usage in Documentation/ supports this.
> Don't we just want a simple numbers list?  Maybe a single ":", but not
> 2.

Hi Neil,
You are correct. Thanks for catching that.

I'll send v3 later...

-- 
~Randy

