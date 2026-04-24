Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A01366DCF;
	Fri, 24 Apr 2026 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013707; cv=none; b=kDvV6+8FQENEmkGyXkTc3liOPQBatubktjamPs1YdJCTtKgcES2AsZVvUe4fkO0fgg3I5oepzKjRFShHs8AX9cPEMJ/T8kA2xeKZRaX534coShaXolS21h3Uo2xK/R4jq1caqbgvoFidru1lWqeaEOMUVyGKo0Ik+3JeA5S5/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013707; c=relaxed/simple;
	bh=YqWoWua2/Wc7PHuce4f8sh3BLnmIUCvUaupWZksb8eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raHNO+A1AcCOwQS1EavqdFoiydrCNdQ6YNE/mN8QtPVcAXPX2tJ193lTsPyd16B/ohKKunPmRN+a2H/bTm56U4IhM79m2Gy5YiZAhuPBN9UwlDr+JIgFQl7/rq6wpf0Dswn1zwwdzFNSsI26et09AGSzRC3EX8p9AJSpxnPEvfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XW7ENsMR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XW7ENsMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=fJGZRW6SJwvAmPVVxVjo5olSr7jogTPEZBPW//VV6+4=;
	b=XW7ENsMRoP5RA5dPhXrgveLwXiFnuho2tQqrc77d/oS4mtmqRz+Us+sVMUv8GD
	na1NSzm7RVUqIXwZW+c/eBvv/zWp6EuRlb+k8EFCpNrAMVlQyoHg3dhNABg500Nm
	kLf8uX1Tm3MpJt1/9r4lrj5gL84ZIgZ0djet9BLKwuG+w=
Received: from [192.168.56.68] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3eeuFE+tpeZn3BA--.109S2;
	Fri, 24 Apr 2026 14:54:04 +0800 (CST)
Message-ID: <255bdd69-e0f0-4300-864a-15fd077ea748@163.com>
Date: Fri, 24 Apr 2026 14:53:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 v1] Documentation: proc: fix ext4 section numbering in
 table of contents
To: Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net,
 skhan@linuxfoundation.org, surenb@google.com, cyphar@cyphar.com,
 witcher@wiredspace.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, wangguanyu@vivo.com,
 Baolin Liu <liubaolin@kylinos.cn>
References: <20260423065642.11218-1-liubaolin12138@163.com>
 <e1a0e7ab-8cdb-4c60-abcd-82c4e0be6e97@infradead.org>
 <1c59927a-2768-472e-bf89-34133a03749e@163.com>
 <8668e0f3-49c1-4748-97ab-00ee2befde10@infradead.org>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <8668e0f3-49c1-4748-97ab-00ee2befde10@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3eeuFE+tpeZn3BA--.109S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyxXr4kXr4xWF47Xw1DZFb_yoW5Cr1fpF
	W5J3W3ta1UGF1UGrnrKw1xZr4qya4xtayUWFnFg34Igr90ywnagr43tF15uF97Gr18Jay0
	qr17Ka43Zry3AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gw9CGnrE4yxZQAA3a



在 2026/4/24 10:54, Randy Dunlap 写道:
> 
> 
> On 4/23/26 7:44 PM, liubaolin wrote:
>>
>>
>> 在 2026/4/23 23:55, Randy Dunlap 写道:
>>> Hi--
>>>
>>> Why is "ext4" in the Subject?
>>> Probably just drop that word?

Dear Randy Dunlap,
    I apologize for missing the first part of your email. You're right, 
the commit message title should remove the word"ext4". I will submit a 
v2 patch to fix this error later. Thank you for your review.

Thanks,
Baolin

>>>
>>>
>>> On 4/22/26 11:56 PM, Baolin Liu wrote:
>>>> From: Baolin Liu <liubaolin@kylinos.cn>
>>>>
>>>> Commit e24ccaaf7ec4 ("block: remove last remaining traces of IDE
>>>> documentation") removed the IDE section but left its table of
>>>> contents entry behind.
>>>> Fix the stale entry and renumber the following sections.
>>>>
>>>> Fixes: e24ccaaf7ec4 ("block: remove last remaining traces of IDE documentation")
>>>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>>>> ---
>>>>    Documentation/filesystems/proc.rst | 14 +++++++-------
>>>>    1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>>>> index 7ce02573a3d9..70db35987ee1 100644
>>>> --- a/Documentation/filesystems/proc.rst
>>>> +++ b/Documentation/filesystems/proc.rst
>>>> @@ -23,13 +23,13 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>>>>      1    Collecting System Information
>>>>      1.1    Process-Specific Subdirectories
>>>>      1.2    Kernel data
>>>> -  1.3    IDE devices in /proc/ide
>>>> -  1.4    Networking info in /proc/net
>>>> -  1.5    SCSI info
>>>> -  1.6    Parallel port info in /proc/parport
>>>> -  1.7    TTY info in /proc/tty
>>>> -  1.8    Miscellaneous kernel statistics in /proc/stat
>>>> -  1.9    Ext4 file system parameters
>>>> +  1.3    Networking info in /proc/net
>>>> +  1.4    SCSI info
>>>> +  1.5    Parallel port info in /proc/parport
>>>> +  1.6    TTY info in /proc/tty
>>>> +  1.7    Miscellaneous kernel statistics in /proc/stat
>>>> +  1.8    Ext4 file system parameters
>>>> +  1.9    /proc/consoles - Shows registered system consoles
>>>>        2    Modifying System Parameters
>>>>    
>>>
>>> Where/how is this Table of Contents used?
>>>
>>> But yes, the intent of the patch is good.
>>> Thanks.
>>>
>> Hello, this directory contains the subsequent content of the file proc.rst.
>>
>> My modification is due to a previous commit e24ccaaf7ec4 ("block: remove last remaining traces of IDE documentation")
>> which removed "1.3 IDE devices in /proc/ide" from the subsequent content and modified the labels of the various items.
>> However, this previous commit forgot to remove "1.3 IDE devices in /proc/ide" from the directory itself.
>> This caused a misalignment between the directory entry and the actual subsequent content items.
>>
>> My modification is to remove the "1.3 IDE devices in /proc/ide" that was forgotten in the previous commit and correct the labels of the other subsequent items.
> 
> Yes, I understood all of that, but I had questions (which you ignored).
> 


