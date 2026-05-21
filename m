Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678429993D;
	Thu, 21 May 2026 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779327055; cv=none; b=QkeVJGNJZC8Rj0v7f7pL3HXejiPqWSko1Coi78ir6MYWlrcp2/x8muqv+E+2LIF/2h4cYi2ll45LBa994Em2TG/WMiGxZs+vtn4BKNXlYvxgIDCzqsEhWMFTpR0aYWfc+Qy7+GzULJMPoWl7kCPTZw9oWvWHYtGt6XVvACK4WJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779327055; c=relaxed/simple;
	bh=o92EDX/iRk3EPRk7mqdefPDx7IHasvyN2cNWnI9t7ow=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=ssbwAh45781kzrr1JngjNDtCqdhUliTmF4/gLZQz2xWyf+Qa5uumVOZ3gWCZn7yGRTmHWpUrSQZaf0yO8XVbMHGye+0kckWg4MZee801KM08aWAgkne4h+FGr2Hohydn0a4TOumeBBA7khW/i19M4bK0qaR6Wu7QYKEsmlk8PiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OUIU2Djh; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OUIU2Djh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=kelPoP0Tsa1ZGNFsr8A4EIw5TDiskzOGm6nwAwH0AvA=;
	b=OUIU2DjhhiytT9d3gm4NKLYc3ruwIJqQEAyehFqlsuWbgYGpcz8VLzjZwD2F2F
	sGK+1rzN0VoFUgzO+s8CWoUGhdnnbnPnVrg/Qiy8nrz1MeP64KhWGtiYEJ7458Qv
	WfffTcarxPj6tFNPu94xrW8Dsg8vrleVI4bdx8MCkx6T4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXj14yYA5qecgOBw--.57027S2;
	Thu, 21 May 2026 09:30:27 +0800 (CST)
Message-ID: <6A0E603B.7080603@126.com>
Date: Thu, 21 May 2026 09:30:35 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: CharSyam <charsyam@gmail.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: linkinjeon@kernel.org, hyc.lee@gmail.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Validate error in ntfs_lookup()
References: <20260520111555.79902-1-zenghongling@kylinos.cn> <CAMrLSE5LM1Okkh8zhBH1Pch=JF2U3e+B2H6ZqWo_NRaBcP_uYg@mail.gmail.com>
In-Reply-To: <CAMrLSE5LM1Okkh8zhBH1Pch=JF2U3e+B2H6ZqWo_NRaBcP_uYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXj14yYA5qecgOBw--.57027S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF13GF4rurWkXF1xGw47XFb_yoW8Kr1fpF
	n3AFnYkr4Ygr10y3s2yF4jqw1fZw1kKr4UCr98GrsrArZ8Kr1UtF4aq3W09F1FkrWDWw4F
	qa1jqry5uFyrZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUfHUUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoRNCE2oOYDPXFAAA3X

   Hi, DaeMyung.
   Thank you for the detailed review. You are absolutely right.

   After looking at the code more carefully, I agree that:
   1. ntfs_lookup_inode_by_name() already normalizes zero err to -EIO
      before ERR_MREF(err), so MREF_ERR(mref) will never be 0 here.
   2. Even if it were 0, returning NULL would be incorrect since this
      is an error path.

   The correct fix would be:
       int err = MREF_ERR(mref);
       return ERR_PTR(err ?: -EIO);

   This ensures we return a proper error code instead of masking
   the bug as success.
   Should I submit a new version with this fix, or just drop this
   patch entirely since the issue doesn't actually exist in practice?

   Thanks for catching this.
   Best regards,
Hongling


在 2026年05月20日 23:10, CharSyam 写道:
> Hi, Hongling.
>
>   I don't think returning NULL is the right fallback here. This branch is
> already the IS_ERR_MREF(mref) path, and -ENOENT has been handled above as
> the negative-dentry case. If MREF_ERR(mref) ever decodes to 0 here, it
> should probably remain an error, e.g. -EIO, rather than being converted
> to a successful lookup return.
>
>    Also, I do not see a current producer for MREF_ERR(mref) == 0:
> ntfs_lookup_inode_by_name() normalizes zero err to -EIO before
> ERR_MREF(err).
>
> The Fixes tag also seems wrong, since the same return is
> already present in af0db57d4293^.
>
> Thanks.
> DaeMyung.
>
> 2026년 5월 20일 (수) 오후 8:16, Hongling Zeng <zenghongling@kylinos.cn>님이 작성:
>> Check that MREF_ERR returns non-zero before using as error pointer.
>> This prevents potential ERR_PTR(0) when error code is zero
>>
>> Fixes: af0db57d4293 ("ntfs: update inode operations")
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>   fs/ntfs/namei.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
>> index 10894de519c3..bb075aa97b53 100644
>> --- a/fs/ntfs/namei.c
>> +++ b/fs/ntfs/namei.c
>> @@ -236,7 +236,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
>>          }
>>          ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
>>                          -MREF_ERR(mref));
>> -       return ERR_PTR(MREF_ERR(mref));
>> +       return MREF_ERR(mref) ? ERR_PTR(MREF_ERR(mref)) : NULL;
>>   handle_name:
>>          {
>>                  struct mft_record *m;
>> --
>> 2.25.1
>>
>>

