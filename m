Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795298362;
	b=rqqdmrRJHscKRzOYTprPQJwCXj+SnBmfbnR/YI56iM+wIlGuOEDXiHqQMW6yr5gQUxOd
	 z8qOJUE+LP1smFRp9fWiAj2X57vjS/wATrWT2PU4gHJXMH640qnlKPHHnXohluy2pqOcp
	 K60Nb+I0zejS/x4/eABLZCAd+0ZygQ0x4x8ivoUkXZFbTSNBHdWVxWobvRcoWBt8x+gp+
	 ozxZ+VWqCBpA+to6TKqKX5IeJ5/ePVl6umGu6XcgKaLDs48jowe/E/iDxiwmX7v5K1ReY
	 1bspgVcQSsFu06sLLsaWcc7TXSjBBi/NX3sx3FU7EW+s5NaJ0JgHKB/5LzKkvGbAfRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795298362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cizSpuD6AQD7saKDCptAezv8VsgPBzDcqDJo8Km8r6w=;
	b=1VHHSRqhKGc1Pe0xc4uZBsLIuuwmXp1HQ9zsY58IMHiloeuuWXXBGtkYO5U14DY3EMYp
	 QGWJUd37Yme+CLT9mF/dezEytNB+uqHKF8/yz0Z1Hgl3rtrBGkT+H0OuqOByZdOwDT15X
	 VnPQmAULSIUmufy2CyqZrwOGZ1WCub3t31FUCR40jGlyLZPAQ9MmjWwcW/ZEaiIhs0DMn
	 KOC78jV9DlDqwmhnOCJGp4gR5v1REBFdAjgFVMc9UBN7L/nGl9mLLGJQiNbgafp+Pmqht
	 n4pL2l8KnyQYdZLFYMSWwBqU1J7TpP/iVX8JgyGF3+3F26eDIy2zXNJMuGqZ5tWV9Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=o1ddPjLx;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB398606A32A
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 21:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB398606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=o1ddPjLx
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f04ad2c46dso9578185ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 13:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795298361; x=1795903161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cizSpuD6AQD7saKDCptAezv8VsgPBzDcqDJo8Km8r6w=;
        b=o1ddPjLxJdJa2bMwWiU3woIQla1Jtio2NftVkFbtIJosheg7D7Jq/Wyh40e7AYheUj
         t7mBUjZ80VxMeiTMhtA6pKUmCt8qGiLYF0oRELBIx6kW8RpCEqfxufgzMqvSqGDKWFQi
         MuvFyW4zoaE0cDVcWZEj5SuhaAZ6da++28h++DN0UHTwSZCf5gHe8Ai480LBMKfBS3XC
         oOQRt6/BR6G0wSnDpfGI/zi0QgGaPbzBMHQfPrNdyMFgywnKuHk22fHwJ+t1tDxJj0A/
         Or/vc22zD55E74rQ4LzfKj1OiDIriVEVJgvtxVVC5Fip0MJDdXdkmT0dqOQ+vA1yOZXE
         Zynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795298361; x=1795903161;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cizSpuD6AQD7saKDCptAezv8VsgPBzDcqDJo8Km8r6w=;
        b=S9hZk8ji87r39TJfbAdp2V4Sejkzc3NFBrcOASUENDYjpractYTkcDgiyKynpsHN7A
         BG4ft5xO2A3J6UYlthghRyFfktgQ0OWq7/Tky04VgsMjYAfNX5EQs3nfcqIsHTMtjGXQ
         /NA9oqoPBX6UtHXTLBrGUI9QfpEbMRlMITHjsOVDpLxSUro28wQvg26USMZFM234MRX4
         VeaYXIiUBDYAV20zbtSQWT5oYceVaBcobsV6p5HMBsPh6x24Zw4g00N7mO0kBPR3iD75
         52tRIgk5145qZ/i1BWGCZaF4TJBysiWJMX9TuB9TtcHMe+PQMz7+ioOCrmzH/V2/xZyp
         bdHQ==
X-Forwarded-Encrypted: i=1; AL+hErFziitY1558GxAk+/qlo+SdsoHojzjH1ZNi+JEX7k8Pj2b1RZ5cCzHlXxMyGQfHjgZju9x+0hgtG5NiEKf7@vger.kernel.org
X-Gm-Message-State: APuU4Z+oJs1TXARnlisy04vDm/j1PtmXA6twdgDV1t0ExhmLgob62MJA
	4+QGGs5wjXCoh+uosx5jib357NUQ7S9LGoSBNkgRRBIbQvsgPeMClpcNnSMwOWtHqTQ=
X-Gm-Gg: AZFdTZfrwTpebKdE1a0LaLRgBdGh/p0p5yhPC/yKZn5FMRY9ACE1KXCN/s+7JBFsH23
	hFr0a1DbbuR1ntNoqgsOttLkCs85zIp0OZ9++CeJewwWACZ9niG0TrK8bfDNRTI4imGt+bridJw
	jNawecy3isZonPUarixb7opglTqxrLx5HE28x/+fSo9k771XRvdgDH6UeeYQCoe2RK6LjCv2FNq
	UQKWaEMIWQWd4/v05tJQ3pgHeOXuqOkgOGbA2vajjKNMX6M/oDanih1ZhtD2JiGpq7ZDkJE8tbK
	gJSkdr34Wk+UpvKFLExcoDYLZYSPbRsGhYYodIl6wd/lVc/JYWJoor22mePYsLBLIAHWVH6PODB
	n8oQ3L1Gto/iF3yNDnv66Sf4QAP9UnH4pFnn4gVE7rs3Q+XKB5afYj4ZPa7q8sQxo+XZcED59GL
	Ijvr2IUgnBkvl8Nnb+CkdGPemjxCGdFjXc9Dxmg+JFE4+SpP2UcFB5uRjdkVKPzdjkmXslUCRmB
	c4WL2I0Oa6Bbl01ugqI9lTQh9AdADIB0GAdwTI611ZIImDVGBy+E0+SYSSVRlin42w9+OoMGTTf
	7SDrX2kYaayQTnvdQ//wlvv2B9WgnS0ts/VRCTuxnForWIVUjIYJ+vg+P0qg3+AfbOYmfUJ1buz
	sZXrkjgn7aGgJbz5Jcjdb4Y3LXEDRGObhPAh/NhcrpTpsssip
X-Received: by 2002:a17:90b:288e:b0:3aa:f875:3385 with SMTP id 98e67ed59e1d1-3b41c907e21mr6285185a91.26.1795298361220;
        Sat, 21 Nov 2026 13:59:21 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fe711sm2622799a91.1.2026.11.21.13.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2026 13:59:20 -0800 (PST)
Message-ID: <d1a1bfcd-234d-41a5-a0c4-16065e5f4857@kernel.dk>
Date: Sat, 21 Nov 2026 14:59:19 -0700
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
Subject: Re: [PATCH v2] fs: shorten I/O that would extend past the maximum
 file offset
To: Matteo Croce <technoboy85@gmail.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Ding Feng <dingf3ng@gmail.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, LKML <linux-kernel@vger.kernel.org>,
 io-uring@vger.kernel.org
References: <20261121003356.290201-1-technoboy85@gmail.com>
 <CAFnufp2uT0D8-5jw3DLhQzdfpB=eSuzhmGdmDqoB7arExaw9jw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFnufp2uT0D8-5jw3DLhQzdfpB=eSuzhmGdmDqoB7arExaw9jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 5:49 PM, Matteo Croce wrote:
> Il giorno sab 21 nov 2026 alle ore 01:34 Matteo Croce
> <technoboy85@gmail.com> ha scritto:
>>
>> rw_verify_area() fails with -EINVAL any read or write where
>> pos + count would exceed LLONG_MAX, even when pos itself is valid.
>> Such a request should not fail: a read should return the bytes that
>> are there up to the maximum offset, or 0 at end of file, and a write
>> should write what fits and return a short count.
>>
>> This breaks ordinary programs that read a file up to an end at or near
>> LLONG_MAX, even with ordinary buffer sizes. For example, dd fails on
>> the last block, where it should get a short read, and cat fails where
>> it should get end of file:
>>
>>   $ truncate -s $((2**63 - 1)) hugefile
>>   $ dd if=hugefile of=/dev/null bs=1M skip=$((2**43 - 2))
>>   dd: error reading 'hugefile': Invalid argument
>>   1+0 records in
>>   1+0 records out
>>   1048576 bytes (1,0 MB, 1,0 MiB) copied, 0,103536 s, 10,1 MB/s
>>
>>   $ (dd bs=1 skip=$((2**63 - 1)) count=0 status=none; cat) < hugefile
>>   cat: -: Invalid argument
>>
>> The same happens on a 100-byte file:
>>
>>   preadv2(fd, 200 bytes, pos = LLONG_MAX - 50) = -1 EINVAL
>>   preadv2(fd,  50 bytes, pos = LLONG_MAX - 50) = 0
>>
>> With a large count, the range crosses LLONG_MAX even far from it:
>> splice() of a 20 MB file with a count of 0x7FFFFFFFFF000000 fails once
>> the position reaches 16 MB. sendfile(), aio and io_uring fail in the
>> same way as read() and splice().
>>
>> Files with FOP_UNSIGNED_OFFSET, such as /dev/mem and /proc/pid/mem,
>> have the same problem at U64_MAX, their maximum offset: a read or
>> write that starts below U64_MAX but would end past it fails with
>> -EOVERFLOW.
>>
>> Add rw_clamp_count(), which shortens the count so that the range ends
>> at the maximum offset, LLONG_MAX or U64_MAX for files with
>> FOP_UNSIGNED_OFFSET, and call it before rw_verify_area() in the read
>> and write paths of the VFS, splice, aio and io_uring. Where the I/O is
>> described by an iov_iter, truncate the iterator. This is what
>> filemap_read() already does for s_maxbytes. In io_uring, also save the
>> iterator state again after truncating it, so that the short read retry
>> loop does not restore the full length.
>>
>> A read that starts at the maximum offset returns 0. A write that starts
>> there cannot transfer anything and still fails in rw_verify_area(), as
>> do negative positions on files without FOP_UNSIGNED_OFFSET and counts
>> above SSIZE_MAX. For files with FOP_UNSIGNED_OFFSET, the file's own
>> read and write methods still decide how much of the shortened range
>> they can actually transfer.
>>
>> rw_verify_area() keeps its check, so callers that are not converted
>> behave as before. copy_file_range() already clamps the range in
>> generic_copy_file_checks() and is not changed.
>>
>> Reported-by: Ding Feng <dingf3ng@gmail.com>
>> Closes: https://lore.kernel.org/linux-fsdevel/20261120051457.47753-1-dingf3ng@gmail.com/
>> Suggested-by: Paul Eggert <eggert@cs.ucla.edu>
>> Link: https://lists.gnu.org/archive/html/coreutils/2025-12/msg00097.html
>> Link: https://lore.kernel.org/linux-fsdevel/20251219125250.65245-1-teknoraver@meta.com/
>> Signed-off-by: Matteo Croce <technoboy85@gmail.com>
> 
> Forgot to re-run get_maintainer.pl after the io_uring change

Maybe send it again then if it's something we shoudl see. You cut the
patch out of this reply...

-- 
Jens Axboe

