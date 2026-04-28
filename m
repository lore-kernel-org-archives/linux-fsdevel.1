Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F438B7A6;
	Tue, 28 Apr 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367195; cv=none; b=o0lliZQVr3G2khpeAQyY7JYIAz87pWiv8h+F7tThgsUGqeR8UgKrDqEoBQVzawA09wEusu/t4B0QxcG33hf5iMICXBI7mBTTVROhx15tq1YAKOMCpmPtfD4klk/IgGhuzML8OmgKfFN9tbQb79x2jBiaMF4d7eIfKu6IPoteiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367195; c=relaxed/simple;
	bh=Rdreh0rOxu59fNzVnDD80hfeAYW8yIM3SzVIMTErH2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPq1dbU+AeZANca5IO/dl+q6FC8cJfaTny8w58KMKZ1O7RgByFeTZsEeqvzRwOvMk+wCnZrpqvSIRSUZ3b1c4gDsjhogf6698mplfeDqBSY/82sA/aiYh5RQ4ThDdT3usehsMLWMu+AcvaRs4mFyRWjTqHu+Ko2FHOyxeyYy0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8b68e17242e111f1aa26b74ffac11d73-20260428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9cdee483-f2ce-49ea-9d15-10d2869a6acc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:633d47b7ef80243002578ac13e3f591d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8b68e17242e111f1aa26b74ffac11d73-20260428
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1140275200; Tue, 28 Apr 2026 17:06:29 +0800
Message-ID: <25cfcc60-03c9-4343-9b15-4424e1e419a0@kylinos.cn>
Date: Tue, 28 Apr 2026 17:06:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: optional FORGET delivery over io_uring
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>,
 fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260403035752.20206-1-liwang@kylinos.cn>
 <20260423110954.2676-1-liwang@kylinos.cn>
 <CAJnrk1Zb=+syR_aOLVs4aXMTOUO7BRBi=MU-20xQOcDpf2iQ5g@mail.gmail.com>
 <1a25fd7d-f122-42b0-91e2-487235263af5@bsbernd.com>
 <25e00efd-c0ef-446e-a246-6eebd7a68c9d@kylinos.cn>
 <CAJnrk1ZyucU4LMn6UFDAJpmpUJzhzroLTvJnA-hL5SHR5zedMw@mail.gmail.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <CAJnrk1ZyucU4LMn6UFDAJpmpUJzhzroLTvJnA-hL5SHR5zedMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

On 27/04/2026 19:31, Joanne Koong wrote:
> On Mon, Apr 27, 2026 at 10:56 AM Li Wang <liwang@kylinos.cn> wrote:
>>
>> Hi Bernd and Joanne,
>>
>> On 26/04/2026 23:48, Bernd Schubert wrote:
>>>
>> Furthermore, in the current implementation, forget and I/O requests are
>> dispatched through different paths and handled by different sets of threads.
>> This means we cannot guarantee their original priority order upon reception,
> 
> I don't think ordering matters. forgets are inherently asynchronous
> and there's no correctness dependency on a forget arriving before or
> after a read/write request. In the /dev/fuse path ordering isn't
> preserved either (eg the order they're queued by the kernel is not the
> order they're delivered to userspace).
> 

Yeah, I agree, and I apologize for the confusion. By 'original', 
I meant the logic used before the io_uring path was introduced — where the 
system prioritized reading FORGET requests into the userspace buffer 
while still maintaining fairness. I wasn't referring to the order in which 
the system receives those requests.

That said, I’m curious: since FORGET is asynchronous and doesn't require 
a reply, it doesn't seem particularly urgent. Why prioritize it? To prevent 
a large memory footprint for metadata-heavy workloads? Could we be more 
aggressive with delays and only send them in batches once a certain 
threshold is met? Also, if a FORGET request is lost for whatever reason, 
what are the consequences? Is it just a matter of causing a memory leak?

Thanks,
Li

