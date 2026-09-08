Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2C4B1B39
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909055; cv=none; b=QpyKrYY8Z8PCepE9W1C4fsQKFYNK7t0y1keO1NBtZ8V8R1Hcs4mbpHlIXE+Sl9DswfdEMEztOMpSqDGBkdaxqX4aLgng5kC2XivORzZzlbJdY5l2hRmL+uvy/4194xeChzBn5yY5mwm7gQ+Z/tRm4T0P/eLOWKF4uNbjl3pmXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909055; c=relaxed/simple;
	bh=7kdKAv1UutyivaCl7H1vS0Jdc3NzhJZAlxtP4jKPHik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8z8NDiolACeyhpDDHDv+jHxIuIBhvNah094SIGDJiZrP/toQoIHq2Ar51OVKcVUQZdeTldJeSL5GSWrqj8W7WP2Lyu++68/XjjOyzUiBLR8f4AcTbXtUzpAh+W49Ti4ow66sSNZf9XyqkC6SuTIvQ0B7WRb3Sbbw1p8LymElhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dj5Jryrm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sRcFuDHT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dj5Jryrm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sRcFuDHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788909052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHZMGWGGrZxmd1plGNxBzFOjbHBtD/NVRGD+NRqVMTQ=;
	b=Dj5JryrmFNdRykxG/33Wz+3g+4bwsBomODn0RdI1PJtvmfp+BWPKy45MGI0UA9uVwyaovN
	GiNvAmsSg9uy8eS82UZKcP1a5w9/1mCnG4WBbQ9A4YfkCQaCIOYe0Y5t1ApAD1OecIAcZR
	MDcfvqxo/osIYDilOR8a+xC5qP1AtD0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-NEw5Z4YxOdOBUvlLWZglTg-1; Tue, 08 Sep 2026 19:10:50 -0400
X-MC-Unique: NEw5Z4YxOdOBUvlLWZglTg-1
X-Mimecast-MFC-AGG-ID: NEw5Z4YxOdOBUvlLWZglTg_1788909050
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91043af01d9so79904446d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788909050; x=1789513850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GHZMGWGGrZxmd1plGNxBzFOjbHBtD/NVRGD+NRqVMTQ=;
        b=sRcFuDHTda0H7m8LHKiif11aGzflPoNGjZUaeQmWNhvyX+hj48LkigIJ7dXYGZwOeh
         X5n5jsN3yTf4AIKhwN5mzQrB9KCWY221mzMpze6j/gWmvrQKjBFRBok8W30JQd5uCwvj
         /LAVUDO1E0UqwfWZtrVnntU+j9p+ezvkXDary4qZdSwfgecv5/NjI8ZWPPRXrDQRldQv
         R6IwU/ufQHBJcRnqxy3sTco/N9N8aJ8GR9e8cBOGIfMWB3mKEu6+Xbr0PyBWTTRIaBod
         1yc1AgikbT9beOf1EOCs+oHc9vxpeXouuv96Zex8jBUD3a6S6oOwHmFdjgtJTmUoGzGU
         mUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788909050; x=1789513850;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GHZMGWGGrZxmd1plGNxBzFOjbHBtD/NVRGD+NRqVMTQ=;
        b=lGtSni4+gYVck3D5E1S/5AdQUbtth0gPY9EX3K9iQKjIB8/6S6jGWqaDPmWHmZPV64
         /mSWzC8jykDkTnXShJ0YgImULDANi8/ej5fIW4M0nYhtdHAhBrwZ8+27NnGNW3gu2WKh
         yn9JZ6MbTbgc8JySX4RdqAYVRjTVzJPewcrjgVAGjLQVaQXAcPL971g4jrysLVBIVr6U
         GsTPPPAwhTFtRHjEB2KXJKyxuMsu216gOO6vL4dr0MVWxVmlS4f1vCOGJ7Brc4kM9c6W
         Th7paDOBvCEwzWDnIZyyM3JOFTP8k6O52aHx3MM/SiPv0YDw8NBMUfI7Fns6Njiye0YG
         TEPA==
X-Gm-Message-State: AFuF++kPi5deO4WVrYtgjMwsVJZlrBHlBbyDWqBv05a24wQ9AC3zCCBU
	MfYr8eMNOcK+xQXEjvCJgTNbb0EjDPbYJUXjMCKGXXECUsLZzl55omH8MPapsGons7Qkpg8PUzl
	o2nMlT/i4bWF53FSfQaesm9nkRafjFGQz324Gc4R0uAi6rqaZTZYdxmbAQOiOwfObxXc=
X-Gm-Gg: AYBFou2N8iRjbyYmsUMhLzwMu4T4mFmFtaQIaaPEOix6sIn1Gz9kWv1zdLOX3YPxvJL
	tHmm0F2r4LizieIe2j51numR0yXhVt/N0UbLWt9ZtNFJ1WtvWkRagtam58vtD6as/Qf7z0A9l79
	QnKG9G1AWfDTGJIc9KTxNpMmStKpKk4zQNWIPqlKFeY2kXRpQ8ToPV7+enbEJJf8mMpDBv0ZM9v
	aO4gyImcmPee2gJHV/Mv0IhttjXQKo/MDVW0V/FYcSoW7dEoe/Y2iJP2FPQnM5AGwnleOdGWapn
	bMUsiYB+CM2sMs+6yLGXdv0wfrv979TFjBBmGdxU2Vp5oIx3ML4ueK3xeVu4w0vdgtPCnPEKYF3
	GaMsgqnFrHhEerPAcN/zPZcnkbzDBJFGoqD5sR8HYeg==
X-Received: by 2002:a05:620a:691a:b0:936:cae5:8b38 with SMTP id af79cd13be357-939802fa452mr3511632985a.10.1788909050209;
        Tue, 08 Sep 2026 16:10:50 -0700 (PDT)
X-Received: by 2002:a05:620a:691a:b0:936:cae5:8b38 with SMTP id af79cd13be357-939802fa452mr3511625685a.10.1788909049657;
        Tue, 08 Sep 2026 16:10:49 -0700 (PDT)
Received: from [10.0.4.228] (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb70fbdsm1246505785a.32.2026.09.08.16.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 16:10:48 -0700 (PDT)
Message-ID: <fb4bcf42-cb41-4a1e-b307-78dfdc914e00@redhat.com>
Date: Tue, 8 Sep 2026 18:10:47 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: cache-align lock_class_keys in struct
 file_system_type
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>, lkp@intel.com, oe-lkp@lists.linux.dev,
 Alexander Viro <aviro@redhat.com>
References: <9fbb6bf2-70ae-4d49-9221-751d28dcfd1a@redhat.com>
 <o6cnjqy4ivjqaj4n5xphstfnk5jznufaygwmfkm2gyixqgfump@7fc6c6h6d5if>
 <28f144f8-431d-4c3a-a362-56083bb77541@redhat.com>
 <CAGudoHFJne0q+dnjYdXOyDKEfu_zZ71_z+kSiUPiHWG7jCBw-Q@mail.gmail.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <CAGudoHFJne0q+dnjYdXOyDKEfu_zZ71_z+kSiUPiHWG7jCBw-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hohum, well I spent a bunch of tokens in claude/opus and basically got

¯\_(ツ)_/¯ 

I could be wrong but I'm not sure sashiko would do a deep dive across
all the involved code.

I was going to paste the summary of the AI analysis which I generally
dislike but tbh there's just nothing to go on :(

It did point out that s_lock_key seems dead/unused and thought removing
it might magically fix the problem as well.

-Eric

On 9/8/26 3:07 AM, Mateusz Guzik wrote:
> While I'm not convinced spending time on the resulting bug is
> worthwhile, with the arrival of sashiko I think you should rebase &
> resend -- it very well might just point out the problem with 0 human
> effort.
> 
> On Tue, Dec 30, 2025 at 11:45 PM Eric Sandeen <sandeen@redhat.com> wrote:
>>
>> On 12/30/25 4:04 PM, Mateusz Guzik wrote:
>>> On Tue, Dec 30, 2025 at 03:07:10PM -0600, Eric Sandeen wrote:
>>>> LKP reported that one of their tests was failing to even boot with my
>>>> "old mount API code" removal patch. The test was booting an i386 kernel
>>>> under QEMU, with lockdep enabled. Rather than a functional failure, it
>>>> seemed to have been slowed to a crawl and eventually timed out.
>>>>
>>>> I narrowed the problem down to the removal of the ->mount op from
>>>> file_system_type, which changed structure alignment and seems to have
>>>> caused cacheline issues with this structure. Annotating the alignment
>>>> fixes the problem for me.
>>>>
>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>> Closes: https://lore.kernel.org/oe-lkp/202512230315.1717476b-lkp@intel.com
>>>> Fixes: 51a146e05 ("fs: Remove internal old mount API code")
>>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>>> ---
>>>>
>>>> RFC because I honestly don't understand why this should be so critical,
>>>> especially the structure was not explicitly (or even very well) aligned
>>>> before. I would welcome insights from folks who are smarter than me!
>>>>
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index 9949d253e5aa..b3d8cad15de1 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -2279,7 +2279,7 @@ struct file_system_type {
>>>>      struct file_system_type * next;
>>>>      struct hlist_head fs_supers;
>>>>
>>>> -    struct lock_class_key s_lock_key;
>>>> +    struct lock_class_key s_lock_key ____cacheline_aligned;
>>>>      struct lock_class_key s_umount_key;
>>>>      struct lock_class_key s_vfs_rename_key;
>>>>      struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
>>>>
>>>
>>> There is no way is about cacheline bouncing. According to the linked
>>> thread the test vm has only 2 vcpus:
>>>> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>>>
>>> Even if the vcpu count was in hundreds and the ping pong was a problem it
>>> still would not have prevented bootup.
>>
>> Fair enough, it really didn't make sense to me.
>>
>>> Instead something depends on the old layout for correctness.
>>
>> If I add ->mount back to the /end/ of the structure, it boots fine again,
>> so I guess nothing is expecting specific offsets within the structure
>> at least.
>>
>> (If I turn off lockdep in the kernel config, it boots fine again too,
>> FWIW.)
>>
>>> By any chance is this type-punned somewhere?
>>
>> I don't think so...
>>
>>> While I can't be bothered to investigate, I *suspect* the way to catch
>>> this would patch out all of the lock_class_key vars & uses and boot with
>>> KMSAN (or was it KASAN?). Or whatever mechanism which can tell the
>>> access is oob.
>>
>> Can't do KASAN or KMSAN on i386, AFAIK. :(
>>
>> I suppose I could try such things on x86_64 just in case something shows
>> up...
>>
>> Thanks!
>>
>> -Eric
>>
> 

