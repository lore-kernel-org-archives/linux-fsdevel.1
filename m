Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333C282F10;
	Fri, 24 Apr 2026 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776998733; cv=none; b=NSbWZ7fDegbhrSyW7iC7I8mTlx+sxIHrDPSisB6Vqa7U9V0q2luQX2xGjhIyfykhiyJtYGgjd4qnLjftx2AAOvwO2S9vKsD+cszgvnPuQANIGVSwxVjj4YFe2QwpYw56Bch7+QP/DjClMSFnKudZtLBJu5SjM8feJLvtr44ZN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776998733; c=relaxed/simple;
	bh=C8piuNF9BQpuSQ+pyDZZxw5WhJB3TAHxH5vB9JK4F0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAKQQAwasq1lwGjVBYVCVTxYIfpUhzVbtknf39DVJWB3Gpkzueo9sfxSUSDIZH3dMHC1oh8eKMaISZy1LxzarmQ05ie6UUntN6BilJ2q8/vv+W5wbFCRySufTcyd2X23fx25RK6jBIADs15II7/8LuQeKycjl6Fl0SdU5SQebXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HLE0DMxF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HLE0DMxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=oNbv4fFLhCQRDdHmX5aLXE/aEmEX3dnjKMKzSIYnqGc=;
	b=HLE0DMxFQK59AKxxuPZIeV7g7S/R/jjqZvu0hgPTNhsD2zTX3uWy4YOf8v4DBC
	Ez9RTjwJs3DDjPvSJWA+uCF6hl21iPlE437pAxgSHlvbOer867pqhs4L+c0ZZWj+
	EbYn2Ylw/NJzXuYrDQ44Gy1sbWHUCbey4iJepIFMbuqYU=
Received: from [192.168.56.68] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wC3THAQ2eppD_TcBQ--.29694S2;
	Fri, 24 Apr 2026 10:44:39 +0800 (CST)
Message-ID: <1c59927a-2768-472e-bf89-34133a03749e@163.com>
Date: Fri, 24 Apr 2026 10:44:32 +0800
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
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <e1a0e7ab-8cdb-4c60-abcd-82c4e0be6e97@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3THAQ2eppD_TcBQ--.29694S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr45XrW3CFWfuFyrCw17Jrb_yoW5JFWDpF
	Z8A3Waq3WUGF1UG347Cw4xuFZFya4IyayjgFnF9w1fKr98Cw1Sgw43tF15ZF93Jry8Aay0
	vrs2ga43Z347AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOzV8UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6heQW2nq2RfUZgAA3J



在 2026/4/23 23:55, Randy Dunlap 写道:
> Hi--
> 
> Why is "ext4" in the Subject?
> Probably just drop that word?
> 
> 
> On 4/22/26 11:56 PM, Baolin Liu wrote:
>> From: Baolin Liu <liubaolin@kylinos.cn>
>>
>> Commit e24ccaaf7ec4 ("block: remove last remaining traces of IDE
>> documentation") removed the IDE section but left its table of
>> contents entry behind.
>> Fix the stale entry and renumber the following sections.
>>
>> Fixes: e24ccaaf7ec4 ("block: remove last remaining traces of IDE documentation")
>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>> ---
>>   Documentation/filesystems/proc.rst | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>> index 7ce02573a3d9..70db35987ee1 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -23,13 +23,13 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>>     1	Collecting System Information
>>     1.1	Process-Specific Subdirectories
>>     1.2	Kernel data
>> -  1.3	IDE devices in /proc/ide
>> -  1.4	Networking info in /proc/net
>> -  1.5	SCSI info
>> -  1.6	Parallel port info in /proc/parport
>> -  1.7	TTY info in /proc/tty
>> -  1.8	Miscellaneous kernel statistics in /proc/stat
>> -  1.9	Ext4 file system parameters
>> +  1.3	Networking info in /proc/net
>> +  1.4	SCSI info
>> +  1.5	Parallel port info in /proc/parport
>> +  1.6	TTY info in /proc/tty
>> +  1.7	Miscellaneous kernel statistics in /proc/stat
>> +  1.8	Ext4 file system parameters
>> +  1.9	/proc/consoles - Shows registered system consoles
>>   
>>     2	Modifying System Parameters
>>   
> 
> Where/how is this Table of Contents used?
> 
> But yes, the intent of the patch is good.
> Thanks.
> 
Hello, this directory contains the subsequent content of the file proc.rst.

My modification is due to a previous commit e24ccaaf7ec4 ("block: remove 
last remaining traces of IDE documentation")
which removed "1.3 IDE devices in /proc/ide" from the subsequent content 
and modified the labels of the various items.
However, this previous commit forgot to remove "1.3 IDE devices in 
/proc/ide" from the directory itself.
This caused a misalignment between the directory entry and the actual 
subsequent content items.

My modification is to remove the "1.3 IDE devices in /proc/ide" that was 
forgotten in the previous commit and correct the labels of the other 
subsequent items.

Thanks,
Baolin

