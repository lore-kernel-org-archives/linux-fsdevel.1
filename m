Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592945;
	b=hCQMNDg+b2VjGvVGoqeHNt4JMkGp1yYRheZV4neLjC8jLWdM3kMJoXn2LrL63maxPe4V
	 ONpIP/yKnPs5vFC+ap7Kt3u8WkHTTn6RWQx8ztShOHfRkQ17w7xxONjg8nZV72kawod/0
	 07/kfHb0q4H9MYlEeY9fxAPlRzdKqoyDqP5wklgZAR7Lua7TyKI1EXNU2yAUdlPPGzHpu
	 RmyNO9N4IKEAxhl4qCeigg73MDm8B5QXUIjS+YJnQnOiIEHhzxI9K/RAz6+kq/hC3NdCZ
	 pjlys3QMJ0/vUxynPc21CCYsn35a1Hm0iEhg+/3dm1NzlAxnsZvKspMImvI8noVEYIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592945;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NHziLxnIYyaGgH9iRMQeAbyOtg13/DENqLY2yDhYbX8=;
	b=kxeVZmq5YIpjYiyJnt3G5n4A2FaOEU3bFMMqnCoSyCafbmJjZf7VI1BSJ5xc2HXP400P
	 K1ODkIz/3JyaVs1aaf6qbUU78WOmyDihVrBhNQzoPTtUSe6+FY1LBsfvcKmdomzV7L3GX
	 4EhXr6StMFHjppGBuNLV40l2bgAdfdEPPe3exfcv86Tf0rNiD0xQOVT6jjE0DGRYwl+bM
	 vXYtAmLyYrLp/LBUmgvHNwESIRjUxiq8XGvcXblHZfmnhZCw4Lyq5FyRkOjb8QE+P5oGT
	 awitj0T1UYsUjLr7qBw41PEUZmLSFmDp0LLL3gNr+rdUDq81EqvaZ3CxCJ+q6NBwdvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543A606A32D;
	Wed, 25 Nov 2026 07:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D543A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: abb7b9c6e8a411f19a56ed5b684f684d-20261125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b541b372-0249-414a-b05f-4931f132ded4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:90e84ad07b0fbd8a599329838e687d2c,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: abb7b9c6e8a411f19a56ed5b684f684d-20261125
X-User: fuqingshuang@kylinos.cn
Received: from [10.42.20.11] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fuqingshuang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 410151515; Wed, 25 Nov 2026 15:48:57 +0800
Message-ID: <fac38220-6a40-49e1-bd37-732519e74a88@kylinos.cn>
Date: Wed, 25 Nov 2026 15:48:55 +0800
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
Subject: Re: [PATCH] selftests/proc: skip fd-003-kthread if run as non-root
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Shuah Khan <shuah@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261120062933.3169112-1-fuqingshuang@kylinos.cn>
 <20261124223355.15a364523377daf5cf2734cb@linux-foundation.org>
Content-Language: en-US
From: Qingshuang Fu <fuqingshuang@kylinos.cn>
In-Reply-To: <20261124223355.15a364523377daf5cf2734cb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/11/25 14:33, Andrew Morton 写道:
> Fair enough.
> 
>> --- a/tools/testing/selftests/proc/fd-003-kthread.c
>> +++ b/tools/testing/selftests/proc/fd-003-kthread.c
>> @@ -36,6 +36,7 @@
>>    *
>>    * Return /proc/$PID/fd descriptor if process is kernel thread.
>>    * Return -1 if a process is userspace process.
>> + * Return -EACCES if run as non-root.
>>    */
>>   static int kernel_thread_fd(unsigned int pid)
>>   {
>> @@ -88,6 +89,8 @@ static int kernel_thread_fd(unsigned int pid)
>>   	fd = -1;
>>   	if (flags & PF_KHTREAD) {
>>   		fd = openat(dir_fd, "fd", O_RDONLY|O_DIRECTORY);
>> +		if (fd == -1 && errno == EACCES)
>> +			fd = -EACCES;
>>   	}
>>   	close(dir_fd);
>>   	return fd;
>> @@ -168,6 +171,8 @@ int main(void)
>>   		pid++;
>>   	}
>>   	/* EACCES if run as non-root. */
>> +	if (fd == -EACCES)
>> +		return 4;
>>   	if (pid >= 1024)
>>   		return 1;
> 
> Why "4"?

4 is KSFT_SKIP.  The convention in selftests/proc is a bare "return 4"
on skip paths -- 9 tests do it, e.g.:

	proc-loadavg-001.c:32
	proc-net-dev-lseek.c:35
	proc-self-syscall.c:40
	proc-self-wchan.c:30
	setns-dcache.c:56
	setns-sysvipc.c:55

Notably proc-pid-vm.c includes kselftest.h and still returns a bare
4 at the end of main().  So the bare 4 just follows the directory's
existing style.

> 
> (and why didn't they call it EACCESS.  Also s/creat/create/)

Ha.  Renaming it now would break 50 years of userspace, but I agree
the historical spelling is unfortunate.

-- 
Qingshuang Fu

