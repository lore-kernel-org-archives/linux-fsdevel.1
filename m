Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E1274652;
	Thu,  2 Jul 2026 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999127; cv=none; b=qKAr+fCqOS4qlCcxabAbRb9oX++9sN9QysJBA21BZf1DXmhS2coIdfsXuXPFcWeRTKUV9JoPrkkMoER2tMS7PIrtKXz9DNdv2yeSpOrIgFGkLqHGEH2JlPKkNcf8EaN+JojJEaVhPrnbUJf2qR9jYTEjMJ/5JXWTFlYlCcUmnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999127; c=relaxed/simple;
	bh=lp85fhAOEgwFcqwgTg7sWvKFl9q5aH8fiv0If3atHIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFQTFVFHNvdNOi2TeB9+w4xD7RFwFrun0A7vjDqJrjbv2On5hBMcAITz0QsgfQzf8y7YKuS5OawIbqTeVvFXm6LXTov1GkXE3pxNMeHIm0ZPrR5spcln2arBwfdABUdIH2/AvdkJgy7sDkpMbLzHFOO/d+QVND4xDWwa7o55wyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W/1NR+rp; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W/1NR+rp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=lpLLWBfubNtrX8pZlTMUerQKAzw0YJutgibjvYaaKvI=;
	b=W/1NR+rpvGUce/NMkouDG4VWVUdxku0Tugy7VKSSN5xqkqVXuQE7YGc7KNn/No
	oBDRbIIRij6sFzVhCB+bYYXupOIcemEPUPSix2iwgDi4DCc+BDA6z4dAMC5EeYPa
	qLDMxzqpZF49Pb2u47a5ASgZ7qwpqbi3Zd1LWBIlXiPbw=
Received: from [192.168.5.209] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3FycxaEZqm7QvHA--.31168S2;
	Thu, 02 Jul 2026 21:31:30 +0800 (CST)
Message-ID: <07eb8caf-cb21-44c2-b869-47fd8f0a7b68@163.com>
Date: Thu, 2 Jul 2026 21:31:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] exfat: validate cached iomaps during buffered writes
 and writeback
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260702024534.847681-1-chizhiling@163.com>
 <CAKYAXd-3RuD03RJJvdKGvLbm1QuwuGFhGDcAdmjQ+OStUxPCDg@mail.gmail.com>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <CAKYAXd-3RuD03RJJvdKGvLbm1QuwuGFhGDcAdmjQ+OStUxPCDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3FycxaEZqm7QvHA--.31168S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw48Zr45Ar17XFWruw47CFg_yoWfXwcE93
	Wqvr4vkw4rKFs8Zw1I9Fs8tFZ8ta15KF15X39Yv3W7G34fAF9rXFn2qrsYkrWDJFWUGrnI
	kFWkuFnFvwnF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj8nY7UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2xJS72pGaDJKUgAA3a

On 7/2/26 8:54 PM, Namjae Jeon wrote:
> On Thu, Jul 2, 2026 at 11:45 AM Chi Zhiling <chizhiling@163.com> wrote:
>>
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> Writeback does not hold i_rwsem and can race with truncate or other
>> operations that change the file's block mapping. This may leave cached
>> iomaps stale, causing writeback to write data to blocks that no longer
>> belong to the file.
> Do you have an actual reproducer or an observed corruption for this ?
> Thanks.

I haven't actually observed any data corruption, and I haven't been able 
to reproduce the issue.

I just checked the code again, and it seems this issue cannot actually 
occur. The reason is that no operation other than truncate can modify 
the block mapping, and truncate waits for page reclaim to complete 
before releasing it.

Sorry for taking up your time, and thank you very much for your help :)

