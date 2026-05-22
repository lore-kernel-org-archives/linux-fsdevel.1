Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283E3594A;
	Fri, 22 May 2026 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779416938; cv=none; b=pu/2XhbxiXx5gTGM5SGolxZpU2ZPsf73mMyZmLbozG9rnq7xz+8lCtdgPLrTTNMlGVgd3KGQMnw3k+s2XRbvz8Pyg5mOKYD9IEE3TEAjazPlpOYvG6ad24wJnQdEH1t+nZGRq2iB62sZpZnDVrgn1+6WFTvmaOQSMugeYnXMglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779416938; c=relaxed/simple;
	bh=VrGmQQKRmLxqwW/n7/v7HUzasLetAeP+8hEMqYIGaRc=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=gkFY5DhcsJgkxwzoQ/99wDpfDVEFHaxcgRSVDUZeZ6tpFn7WsvOFukm6PoTIQ6dFShjcHsEu4VY6MGbMz1CBskWMAuMx8TjDFCA0oN0lazUmcP7qnXRQT4RCEkg3PCbOKcEVTpK18NgBhLIoLRAlhKjldVBOjklHqglVSrTjYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nWJFdX/q; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nWJFdX/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=yBn6DtGLHt7P1AuSXad2ISo81BXaNCarTfe00AyHDT4=;
	b=nWJFdX/qNdWPOYAvQTl1hBBxxy+B/W/z8epBIA5N/nfZNEZbCP39m1PGyhvmsw
	b8P2xrL7emJNmQHJOJb5eChIHHvpIPsd8MWuOXCB2tDJLiwUjOL3Xll/TZtqZtq8
	dUayo3lSjqXDQzQy1R0turm9MjkfEhegClmYQCWU9kAYU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3vxZOvw9qvpArAA--.26858S2;
	Fri, 22 May 2026 10:28:31 +0800 (CST)
Message-ID: <6A0FBF56.2080107@126.com>
Date: Fri, 22 May 2026 10:28:38 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: CharSyam <charsyam@gmail.com>
CC: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org, 
 hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Validate error in ntfs_lookup()
References: <20260520111555.79902-1-zenghongling@kylinos.cn> <CAMrLSE5LM1Okkh8zhBH1Pch=JF2U3e+B2H6ZqWo_NRaBcP_uYg@mail.gmail.com> <6A0E603B.7080603@126.com> <CAMrLSE6xFngy-C9wT4YjRy8WEeTgXT_TwHRSbLYs4gdaobDeTw@mail.gmail.com>
In-Reply-To: <CAMrLSE6xFngy-C9wT4YjRy8WEeTgXT_TwHRSbLYs4gdaobDeTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vxZOvw9qvpArAA--.26858S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrW7KFW7Zw45tF4UZFy7KFg_yoW5CryUpF
	1fAan0kr45Gr10y3s7ta1jqw1Sv3s3Kr4UWrn8JrsrC390kF17JF47tr1j9Fn5CrWUWw4j
	qa1jyrW3uFy8uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jI0PfUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoA9hMmoPv08H6QAA3H


   Hi, DaeMyung.

   I agree. Dropping this patch is the cleaner option since
   the issue doesn't exist in practice. I've verified that
   ntfs_lookup_inode_by_name() normalizes zero err to -EIO,
   so MREF_ERR(mref) can never be 0 here.

   Thank you for the thorough analysis.

   Best regards,
   Hongling


在 2026年05月21日 23:00, CharSyam 写道:
> Hi, Hongling.
>
> My impression is that dropping the patch may be the cleaner option here,
> unless we can identify a real path that produces ERR_MREF(0).
>
> Thanks.
> DaeMyung.
>
> 2026년 5월 21일 (목) 오전 10:31, Hongling Zeng <zhongling0719@126.com>님이 작성:
>>     Hi, DaeMyung.
>>     Thank you for the detailed review. You are absolutely right.
>>
>>     After looking at the code more carefully, I agree that:
>>     1. ntfs_lookup_inode_by_name() already normalizes zero err to -EIO
>>        before ERR_MREF(err), so MREF_ERR(mref) will never be 0 here.
>>     2. Even if it were 0, returning NULL would be incorrect since this
>>        is an error path.
>>
>>     The correct fix would be:
>>         int err = MREF_ERR(mref);
>>         return ERR_PTR(err ?: -EIO);
>>
>>     This ensures we return a proper error code instead of masking
>>     the bug as success.
>>     Should I submit a new version with this fix, or just drop this
>>     patch entirely since the issue doesn't actually exist in practice?
>>
>>     Thanks for catching this.
>>     Best regards,
>> Hongling
>>
>>
>> 在 2026年05月20日 23:10, CharSyam 写道:
>>> Hi, Hongling.
>>>
>>>    I don't think returning NULL is the right fallback here. This branch is
>>> already the IS_ERR_MREF(mref) path, and -ENOENT has been handled above as
>>> the negative-dentry case. If MREF_ERR(mref) ever decodes to 0 here, it
>>> should probably remain an error, e.g. -EIO, rather than being converted
>>> to a successful lookup return.
>>>
>>>     Also, I do not see a current producer for MREF_ERR(mref) == 0:
>>> ntfs_lookup_inode_by_name() normalizes zero err to -EIO before
>>> ERR_MREF(err).
>>>
>>> The Fixes tag also seems wrong, since the same return is
>>> already present in af0db57d4293^.
>>>
>>> Thanks.
>>> DaeMyung.
>>>
>>> 2026년 5월 20일 (수) 오후 8:16, Hongling Zeng <zenghongling@kylinos.cn>님이 작성:
>>>> Check that MREF_ERR returns non-zero before using as error pointer.
>>>> This prevents potential ERR_PTR(0) when error code is zero
>>>>
>>>> Fixes: af0db57d4293 ("ntfs: update inode operations")
>>>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>>>> ---
>>>>    fs/ntfs/namei.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
>>>> index 10894de519c3..bb075aa97b53 100644
>>>> --- a/fs/ntfs/namei.c
>>>> +++ b/fs/ntfs/namei.c
>>>> @@ -236,7 +236,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
>>>>           }
>>>>           ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
>>>>                           -MREF_ERR(mref));
>>>> -       return ERR_PTR(MREF_ERR(mref));
>>>> +       return MREF_ERR(mref) ? ERR_PTR(MREF_ERR(mref)) : NULL;
>>>>    handle_name:
>>>>           {
>>>>                   struct mft_record *m;
>>>> --
>>>> 2.25.1
>>>>
>>>>

