Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90248BD5B
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398078; cv=none; b=QswnMj/SgAEMlQMefflOEhA3FglznafqT9P36QUP06n34GP27di5Emm29l8YijipteAsP5ukJTWS+5G9LhoC2+VR4E+QhdB2RdGAm8ZL+9+pVRwcYftvMeorps72KX+QBzPibHyt9/UH9jh9p/v9HbTm+jmI4oGOX72uRFHtMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398078; c=relaxed/simple;
	bh=EalQDU4IYycXB8IzvH7mx5DaPfn6lSTeFNCMbg9uHYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqpiqMbAJNWiS/p1s36ZsDqedMG1oOEZJmrJkLVxXF5ztYlDdVWH3V0TVvDfHaVXHSVKDI0z1SHR1UTBjG5Gib9hJ3FWenJrMjZsrLO37vdUomEVzvprnz+jrmZmbfT63i0Rj6kgJFABffDKu+6h5INT6m83x4sxsKrW0fTovoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLq4iiCl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLq4iiCl"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c414e5d282eso195387666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792398075; x=1793002875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqARml2eRxc6et7vGQaWdyqklu54c3RuOpXb7dukqxo=;
        b=JLq4iiClFxw5QZJVJzY2rMdCVHqNJo2T7MOp70cXN4+OENfT3UD3JCATXwARujZYZP
         1DcvSkXVNKVhvEvw8WrGyGqxPpXeRk0TIZM1Ff+Nk5A9u8wJWPIGfmD5Z0ve0CkMxR5M
         359ukSLBWExlFxLtNPhvyegoSwF6rwFCyco9J9Gv1HK6yjl0o2gfiX0A2ThYLvNGDFvi
         ugOEtYpBL3bQpTEbQ3r10LVU98oF3/Xuc9DQLbRF1M2/okqqvlXbF7fmz2jqmEdjdV2O
         0SnnZ3rOEbc8qutOm0LqbcKC1A9WVJ5XKYarnldMqT+prWzUvDOpXaNqE4g1kvwP2bNX
         qFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398075; x=1793002875;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DqARml2eRxc6et7vGQaWdyqklu54c3RuOpXb7dukqxo=;
        b=fkLo3EslsX9I0NWj9k+9Z8xSqNjYqcE1r2wS9kwpPVmpMDjz1GkD5BNF8A1AfKaDpu
         dG3boleGIFjMVnIFJcipTUmhw9aO/w+NZhImGL/cFYtiVB1qCddjB7VkOtUn7RMMN6ty
         TtEAKBu4ZSoNsrmeBVxzWRPa2rs1VqoOYN2eENLgNU8ecRiBEAefVJ0haY97kf2Nkz7j
         k+g8zn1QorIEivrdSnIXGsv3XLNfDdyAj7pbvX76uRRxpyHCPRROnXUe2QgG+9R+ztrR
         heFl2zU85a2s+Qb09Lsejuo4yzyivPR45v1iDdHvt21GL0pVj4XKZcOBFvl1IxyfUb0A
         QZQA==
X-Forwarded-Encrypted: i=1; AKwUvBw2c6eUlhfEIDJUZ4jk8fv6NC/Xz6uDKUf59UPLGL3m7u/FjDgk01VObWMZ1VF1gVhLMiaO0qhVqe2QH774@vger.kernel.org
X-Gm-Message-State: AFq9FYKTkDaOwjXu72elDtfyMcbV8noZARqSMVamn/nbY3cT7Tkwvxl5
	clJaO78INet5gGyDy0BjGYrOHwnAnYYIZ/7jf5w4CIk3a4nc5j7w2JL7
X-Gm-Gg: AYBFou14P5Uqsfkc5xTlvs2RSnQBaYKrol72eXkPa+/suxOr3HOQ+1piSpKyazd58yy
	SDYl3UZRnI4Vq0hho9iCyr7vvKh8v8eKO21BJS6d4GUWlqeH+t7Qy0I1DkuqKqyjLgfHdUt+Cc/
	usX4zrOB/3u7gzTllxzNWuknOxVAqExxfTmxkS5Pj87xz/BMCF+ateinZ+AkC5HriFaiBwy/zM1
	qced+gRGLsuusmn2Ad5fGCGUkaJDSD2OQHQJJgx/d/GXqMUDvJddt6fucPOiESj796LpSZaV8fx
	51q9eQAwcRIyCSQdFzL8WkIBf+sdsEvFBdNiENkMIPJ9YRUsTovYxVSodJB4z45GYST7fojTR2D
	MEOV+urG5B3Cu7gCrI27WkgPXFFU526vf7cJvQr2wknhAFO9SHe46tgT0IfU0M3vVlDqdORhcrc
	7r8y8XsEDVAo2Tc1139oLvxF9YhZheXg26e6SXEw5JZkZGmXiQECGSxDjo52s+0RKKHlBRMRqGl
	pByiGNZ+/5fk58uzsb8pOod45gP7CuF+HKJlRYDGOyxH1x3sGyy+M1uV/VwMePklIdf6aAy4Qig
	HDYtktFZH47ADvWMyLYczZ5HvnAjFnT2+UGEbWHyZysShYFl/bD3x3E2IaFGbFcgGY8iSI4daAq
	8oMI5+fCl7nzGJSg+LnX+E8mq4dMqu4lAmw==
X-Received: by 2002:a17:907:c819:b0:c33:923b:ad50 with SMTP id a640c23a62f3a-c419e03af5amr426962066b.19.1792398074683;
        Mon, 19 Oct 2026 01:21:14 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40913c6153sm332041566b.40.2026.10.19.01.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 01:21:14 -0700 (PDT)
Message-ID: <c820357a-a7cf-4f4b-ab23-91530a12218b@gmail.com>
Date: Mon, 19 Oct 2026 10:21:13 +0200
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
 <55a1f016-a7a2-469f-b481-37223d695f29@gmail.com>
 <87cxt921rc.fsf@mail.parknet.co.jp>
 <f9b27432-4104-4323-8cd7-e2cda73db2f9@gmail.com>
 <875wz11xfg.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <875wz11xfg.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 17:23, OGAWA Hirofumi wrote:
> Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:
> 
>> On 10/16/26 15:50, OGAWA Hirofumi wrote:
>>> Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:
>>>
>>>> On 10/15/26 20:54, OGAWA Hirofumi wrote:
>>>>
>>>>>> +	} else if (!rollback_err) {
>>>>>> +		/* Read the entry block again if a failed write invalidated it. */
>>>>>> +		rollback_err = bh_read(sinfo.bh, 0);
>>>>>
>>>>> Why do this read the bh from on disk?
>>>>>
>>>>
>>>> The bh_read(sinfo.bh, 0) is needed because a failed inode-position write clears BH_Uptodate. fat_remove_entries() modifies and dirties that retained buffer directly, which otherwise triggers the warning. Reading it first refreshes the whole block. If the read fails, the buffer is left untouched.
>>>>
>>>> The same reasoning applies to both the VFAT and MS-DOS paths.
>>>
>>> If sinfo.bh is required to read because of failure of I/O error, I guess
>>> the bh will fail to write again. I think we should give up to rollback
>>> in that case.
>>>
>>> Thanks.
>>
>> Thanks. I was trying to handle transient errors here. The old entry still exists at this point, so if the read and removal succeed, the rename can be fully rolled back.
>>
>> In my tests with a single injected write error, giving up left the new entry pointing at the root directory, and fsck.fat wanted to remove it. Retrying the cleanup left the filesystem clean. If either the read or the cleanup write fails, we stop and report corruption anyway.
>>
>> Do you still think we should give up here? If you prefer not to retry the new-entry block after its failed write, should we also avoid rereading and rewriting dotdot_bh after a failed .. update?
> 
> Basically that path is not the failure of sinfo.bh, true? If so, we will
> not need to re-read sinfo.bh here, just removing the added entries would
> be ok. 
> 
> If we have to read sinfo.bh, the sinfo.bh may be failed the write and
> cleared the uptodate. If so, I wonder why succeed by retry?
> 
> The above is my understand.
> 
> Thanks.
Thanks. error_inode can also be reached when a different metadata buffer fails. In that case, sinfo.bh is still uptodate and bh_read() returns 1 without doing any I/O, so the removal proceeds directly.

The test I mentioned did fail the write of sinfo.bh itself. The trace shows __sync_dirty_buffer() called from fat_sync_inode_metadata() failing on the new-entry block. The retry succeeded because fault injection was configured with times=1, so only that single write failed. bh_read() then reloaded the block and the cleanup write succeeded.

That is why I kept the read. It is a no-op when sinfo.bh is still uptodate, and it allows a complete rollback after a transient write error. Would you still prefer to give up when the failed write cleared BH_Uptodate?

-- 
Krystian Kaniewski
