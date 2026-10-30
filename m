Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341286;
	b=zu9U03QssxtSEwla9NHtsyzZI14GHcomziVVN1lu0m6Lr6oNUKKnG1KvRS1GqMKXcyNS
	 1jSbEqR+klhZ87w11bQ0g67SuR3KNqNW1j2MHL6JuQpJH6PlUCB7gas1Xj683e4nyNBuc
	 W9GQq6N10nRiEty7Qg9L0zf1CsRVd2VH7AxEkVYTPDN4tzF/GkGAEoeW/avxOFg4CnkgK
	 q+VGbd8cmPHI3zYDMYK7E6e7px12/C96AQd2zNnm0Ocv2zUjYGqHws2iligOB+W3o1r6s
	 /HL4A862S93+Vv1UxlmoJvDulfNZSeYS/gm0tB3t2XiLw6S+HUWZLzuztJeJhAUIo5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341286;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=GiXNO1xoFrtVmJgmRNqxC8OP6M0JGgWXZ3yX3zeP6fc=;
	b=lGsUMhOd0tCtXauVGR2Baea3MkzdCEAP2InwjeL1yFa1krfyup1aF7tbu+ThVhzR7THZ
	 Yswa/vMz0p6/8J7VJH2w/YZiictpBVh5WywXhoUGByiexJk9dHzH8Rm9vM3+p63Yv9Khn
	 HERXL6hkGh1Pd9lBEUbBhaDSNTSLPMq+B5egwqXa/ev4GIF0saVMBs6IS8GX65slJFFhq
	 m/sn9hYsQOMYl+K3ij7+AE/XtP3GmIkAR59kB0uDphUEkPCS4InkaxsKzxtcsN/ZEEDB3
	 sMR8EcmtTBnbYgW2cBNXT7+5hcxJaIWUARSDEVkB3SmFoxdm8cSrBZS/yrSbSr6MBGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b="f/rROE65";
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=g4Qc11vf;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6E606A32C;
	Fri, 30 Oct 2026 06:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A6E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=f/rROE65;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=g4Qc11vf
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E1B9C26F7664;
	Fri, 30 Oct 2026 15:21:23 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793341283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GiXNO1xoFrtVmJgmRNqxC8OP6M0JGgWXZ3yX3zeP6fc=;
	b=f/rROE65RKXRnGHsEAXSHI3/wXWtNro+5uzAgdLlywgD+BcnGWCZNMyDxF7rAOoQ1A1V4Q
	jdK++9cOtMBuw//gD9Fb75d+2dm8BUnCBwn97Ua1oMlqNm31aN93sF/n1tAWRLyPU0Z8WE
	Ogb6X8W7NyAqiZZwzWYOOsOnGpLJ37Yr0OnzrNgl3d+QTZlAssSpMxGyHH1eYd16CotJlu
	gS3qBnUwxzKW/WuxiZcggSZHHoUuza6ot9sl8b15gg4nEuYB5iSXh/F9tdmtxD+quljLvR
	tV/7hh27qNqw818BFIl8qZA6QRwCFaFWPZnXc7h6ymkVDW+ed3h76paeT44ZYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793341283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GiXNO1xoFrtVmJgmRNqxC8OP6M0JGgWXZ3yX3zeP6fc=;
	b=g4Qc11vfghoikZdM7Up/8OuE1dotH0vg38eC9Hy5E2tGhOF1DA3xdhF6Y7kRN42XFA2MfJ
	TmIxWY4sEZ8v/PAg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 720CFE00144;
	Fri, 30 Oct 2026 15:21:23 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 5DB9A22001FE; Fri, 30 Oct 2026 15:21:23 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Jan Kara <jack@suse.cz>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fat: use write_inode_now() on flush to avoid racing
 the flusher
In-Reply-To: <87ik2jsp9n.fsf@mail.parknet.co.jp>
References: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>
	<878q3gth64.fsf@mail.parknet.co.jp>
	<457c34c8-b52f-41c6-8b58-ed334b0dc483@manhattantech.edu>
	<87ik2jsp9n.fsf@mail.parknet.co.jp>
Date: Fri, 30 Oct 2026 15:21:23 +0900
Message-ID: <87a4nvso7w.fsf@mail.parknet.co.jp>
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

> Bryanna Marihugh <bryannamarihugh@manhattantech.edu> writes:
>
>> On 10/29/26 2:56 PM, OGAWA Hirofumi wrote:
>>> Looks like this waits the I/O, and sounds like optimization only for
>>> specific drives. Well, so no slowdown for other drives by this patch?
>>
>> Thanks for the rapid reply and feedback.
>>
>> writeback_inode is called only when flush is set. My understanding is
>> that mode is for storage that could disconnect. I set write_inode_now
>> to wait as that seemed to be right for flush. Given it does change
>> behavior I should have explained that better. I can change it to 0 if
>> you want the old behavior. Because I_SYNC is still set no matter if
>> it waits or not, it should keep the kernel flusher from writing the
>> same file.
>>
>> I focused on the reduced write request size causing the stall, and
>> tested for slowdowns mostly doing a cp and looking at the times, for
>> big and small files. Everything in MB/s
>>
>> PNY 32G stick (usb-storage), copying a 3 GiB file 3x
>>
>>   before: 16.3, 13.2, 11.6
>>   after:  18.0, 18.0, 17.6
>>
>> Samsung 64G stick (usb-storage), copying a 3 GiB file 3x
>>
>>   before: 33.4, 33.5, 33.5
>>   after:  33.5, 33.5, 33.5
>>
>> PNY 250G stick (uas), copying a 4 GiB file 3x
>>
>>   before: 365, 200, 322
>>   after:  365, 255, 251
>>
>> Samsung 870 EVO in a USB-SATA adapter (uas), copying a 4 GiB file 3x
>>
>>   before: 379, 346, 346
>>   after:  376, 378, 379
>>
>> The PNY 250G numbers vary on both kernels because the stick slows
>> itself down partway through.
>>
>> For small files I saw maybe improvements on the cheap stick, with no
>> harm on the nicer Samsung stick.
>>
>> PNY 32G stick (usb-storage), copying 1000 x 1 MiB files 2x
>>
>>   before: 5.37, 5.55
>>   after:  5.64, 5.62
>>
>> Samsung 64G stick (usb-storage), copying 1000 x 1 MiB files 2x
>>
>>   before: 7.33, 7.37
>>   after:  7.35, 7.36
>>
>> PNY 250G stick (uas), copying 1000 x 1 MiB files 2x
>>
>>   before: 9.61, 9.61
>>   after:  9.28, 9.26
>>
>> 870 EVO in USB-SATA adapter (uas), copying 1000 x 1 MiB files 2x
>>
>>   before: 9.61, 9.61
>>   after:  9.59, 9.51
>>
>> There is some regression with small files on the uas drives from the
>> wait.
>
> Is this wait=1? The flush should just be early flush, no guarantee to
> flush completely. So I think it should be wait=0.
>
> And the flush is assuming basically for removable media though, we can't
> choose. I think we need to check the result of such HDD/SSD.

And maybe it needs to check unmount time (check how many dirty was
missing to flush).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
