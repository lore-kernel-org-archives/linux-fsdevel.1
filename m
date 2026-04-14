Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE83242B8
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198584; cv=none; b=ZgKB8aV7CkDajBsZS7LCZvoAjzmcXgySQisW1s8o+q+Y/peQ1CwYjyuznP/34BnzqItH3HJf+upiQSFixZTPtDgeO8gSQdzia4QA5Qh3AnMR4zD9bD+EjeFgwylVkUGG1OqzfRsPwspllSxouIo2crcOUAFTfy2AHFLj6jvxxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198584; c=relaxed/simple;
	bh=yQFz8DM3su/UkwgPRuXCLRbPCiZ8ugq/3jme6jahFPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gd9B1Gm2yv2bX+mTAJHT7PqrbOX4QpvJTwqWw0EBVswCgZ4CGpMNrELfC6IM9lTGlUnbkAfMjL+j/P0KWP3xAcG4yyk1am4FV3LbwRktxPiTFbqDuUSEdmDdjMVtgAOVZqWCXfxJ9rwZCAut1PbtMy93HEJlYQYMVmFrCw5a574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=k22q0YhV; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="k22q0YhV"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EKRF402605295
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 16:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=WXFq
	nVJ4T9hxAVeyiDV1ooSXjwN82kyD0WFAZyEIayY=; b=k22q0YhVQZiPT7EsK4qY
	kXKKf20d6Eyoq5zv/bCMosbe1p6ZTAAFqGYN1jql5TMO79N5C7HaZt6Z/cwriJjh
	i908rxBG1P3Tp2CF3EvYaZY5/Hh5bH5gz+cbWycowOy/ULW12oZEyg7fnlzlbtCW
	g1tmittXLgbbnNnyoVTcES5p2xk8gc68UqDO+MLS2VTyn0RAe4ulKHNSip2O7W0f
	wus22rwT2+tQnLCpj7WtrZzSZq7OwUEon5xcKGVHybeez2whx+pca7FQyi3SR4Su
	EhEEbwNysh4gXoSo/YVDtxTkm4zxUm6aRBUNyXOKjCaGjPahOa1IEuFxK2LP5O6s
	qg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4dh85dr3b7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 16:29:35 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cfdc479f68so702440885a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 13:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776198574; x=1776803374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXFqnVJ4T9hxAVeyiDV1ooSXjwN82kyD0WFAZyEIayY=;
        b=eaC8RHz+UqCCVUYpcs8u4W9suc+a0HQ9bkyz68pRRT1i78pPpvGGNDJQKwsyj+HAvF
         Jsnh9r+0cXRBrTrrzf7PVM3bFHKto8qRxlv6sOS7QmgQqtn9W6wTCRLJiid+LAfG/TGp
         YBwTMrevWjlazOVzEzzQwAZ0ZJkqX8PqWk34GowPNsZ3R23G/m5TJ/aKf8Prxmr/2KGn
         vue67f9IjKLfOeT6bNVq7gmN1+iIiuNDqsKvN0quo3wHo2P7XmaXDjSKsUsh4PbDOTzS
         ev2Asjsr8kod1u2nUlBqxnn4olQaJ/qpBIb8w6eJDviYNkshU8W/F41RB57yW4c7JRe9
         QSkw==
X-Forwarded-Encrypted: i=1; AFNElJ9LfUVwRR8kY5sroayY3JihpCbNGB1BfvuHlVw8/AT47XIwyn4ij2dUFcDKkT9ZKiy/fa01GXgd9fOmM9Df@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/AqSD8xJFxjUhsO6D5Nk25AjFxo4MLavBiwalgwUcVHbD28f
	cWhja6zoWPGfnEqKHCd5msIamwGmwQflHKL64i+TSK2gXk7p8NaAVRAcPL8sZvpwq4Xt0WxUlgT
	cj/paBY3eA+5/KdQoCP8dulQl9v/e2CDwkyAvgAMmt3MgNYDLb27SJ318bWuk3Go=
X-Gm-Gg: AeBDies9DDMuY7SiQ5LzHO46Rgo4PqF9iPe4Z8u6U5EIhLLIQ6uEpqXq+1gwxxTMZZl
	uIG1s7pHAtweyP+0BErjvzFZJErDe0HSfodWanVcrDKAN9YL7NAFTRwMANA9Eai4JXWc1YQctbJ
	nYUR0HzdDmx0+IdKtLUMC0T1xhdmUGI/FasbmWjJoDecZppMsGS+DCIev18bOWW6+P29Oud/C3/
	jCyz9P/jiEGjSNFDuqPc66MC0kFEcyTu3QKaYGj34HS5yJnCz/GAzfsBfyTc/oeO7sO6B5YMZzB
	pHVh5Vb7EGJMTfCYHBO0YbdBDQMq46B+YSdI1cn+T8RnfcT/enLCOfcIFN6D8KXap7/VwsG/Itq
	41aiNRKg9Xt1B9tPQMwJCVlaqsYdDzTM/8I8oNUBlLh/aEp+6eDcagQw0DLIAYhnlW7wWifk=
X-Received: by 2002:a05:620a:a281:10b0:8de:b9dd:8528 with SMTP id af79cd13be357-8deb9dd85ebmr1694559385a.24.1776198573929;
        Tue, 14 Apr 2026 13:29:33 -0700 (PDT)
X-Received: by 2002:a05:620a:a281:10b0:8de:b9dd:8528 with SMTP id af79cd13be357-8deb9dd85ebmr1694555685a.24.1776198573428;
        Tue, 14 Apr 2026 13:29:33 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849db4e6sm131911086d6.4.2026.04.14.13.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 13:29:31 -0700 (PDT)
Message-ID: <fd94b108-22c1-4eb6-8fb4-b009214976dc@columbia.edu>
Date: Tue, 14 Apr 2026 16:29:29 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <97b81868-6410-4c79-a242-679a9f04f073@columbia.edu>
 <95F28FA1-5CEF-4E80-BBB7-A429B4437D12@kernel.dk>
 <7e468bd2-e52b-4165-95c6-3f04e1dca21e@columbia.edu>
 <fb64ba71-7284-4768-979b-84919f2aa5f0@kernel.dk>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <fb64ba71-7284-4768-979b-84919f2aa5f0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE5MCBTYWx0ZWRfX4Z0/zumfks7G
 GJoxw64HQY2TrbFqol2CoSlnTV+p/9XahHIgjvn8OlTn/lPkAgZF/VpV32tpEaIvA9PSwmxdvu6
 V+JcY233lIxFGcK3OfD6e838JpBQv1E3Z9qEm5k0B2u/Bdh2pamI1XSz/h3ZiovVPQYf2rtPZgG
 Il6IJXTvWSyObz9O3viBVFFo/5SY61Y1zeYxyVLSWvSyg/Q8wsVGPwXm3qJVVZVJn3kKJbQOBGI
 7xRefbi1dnAAEzFfn5srAzfjL7txObtpqq7AlPooWRvvFnrslTM1ApekUoJbCZmtEQSOUGaMHiW
 3li6PoPpjF7lp7V8g+0zd+s5JaBg5/BFyee5h2ThZgc7eGF0pcCMhbrrjIIAMatZOFBm0RYo9aN
 eNFiYgn2051kwCIWYNWsTJWI1sw14CkLE5tOBtjMXSxOjl071FeXtpWNJscj5ZPvavT3ZuAnImM
 iHMQBw+yxZqYcY8IzdA==
X-Proofpoint-ORIG-GUID: ykp3TvQrmzcEghu9nSNVB74vTfCaEfo6
X-Authority-Analysis: v=2.4 cv=eJYjSnp1 c=1 sm=1 tr=0 ts=69dea3af cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=g0XPL2zXmNQOemVH8wcA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ykp3TvQrmzcEghu9nSNVB74vTfCaEfo6
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11759
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=10 phishscore=0 bulkscore=10 malwarescore=0 adultscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140190



On 4/9/26 8:46 PM, Jens Axboe wrote:
> On 4/9/26 12:54 PM, Tal Zussman wrote:
>> On 4/8/26 7:36 PM, Jens Axboe wrote:
>>> On Apr 8, 2026, at 4:51PM, Tal Zussman <tz2294@columbia.edu> wrote:
>>>>
>>>> Going to send v5 shortly -- tested with and without the llist reversal and
>>>> it didn't seem to make much of a difference. This was on a single-disk VM
>>>> though, so any stress testing you could do would be very helpful.
>>>>
>>>
>>> With all due respect, a single test like that isn?t going to be that useful. I'd be wary of making that change willy nilly and just thinking it's fine, worked fine on the one case I tested?.
>> 
>> Understood -- unfortunately that's what I have access to at the moment. I
>> can requisition a machine with 2, maybe 3 disks, and test more thoroughly on
>> that before sending the next version, but that'll take a few days. You had
>> previously offered to test on your big box, so was hoping that was still on
>> the table :)
> 
> I can do that, but I'm OOO for the next week, so won't be until I'm
> back.
> 

No problem, thanks!

>> (Although Christoph seems to have proposed moving away from llist again)
> 
> I think that's a good idea, not a fan of using llist for this, in case
> that wasn't clear. These are per-cpu lists anyway, and having a constant
> overhead is better than needing to reverse an llist. IMHO.

Will change it back for the next version.

> -- 
> Jens Axboe
> 

