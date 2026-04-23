Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8F1096F;
	Thu, 23 Apr 2026 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776909183; cv=none; b=g2pkCtCO88kBVqIuft8ZNh3x2Y782K1vzhzU7vMa0kVzC5BcdoCONFeY89nQp0DwS0RDSiqRu3RsYrDBPYVZJtpvrsza2j2rHgV8U+kiPjPs4XE5JLRLJbeeo6NTIvU1K92R49cp5GdfWTLm2quIvTZIu7NKr208ornQajY9rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776909183; c=relaxed/simple;
	bh=VeC+ja38ty7HiGNyCikvATG/flifMAUmQK+jfP0NL8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAIyQLO65qrv/6Zkh1e4kWFFXgsukI4iBDMjSaJl/ZiER1v0/DjOurnLsbdk5qcsQZ5OxSbaXmuW65u8eWIbmComeorTH1vOLWo9iJmRKd8rcNYv5C7N+jDWkrvS8SRHSMh3g0VYm1bjCcwkMEEdoBudCVp7Lvqtx9yQiTdgETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 206fb2523eb711f1aa26b74ffac11d73-20260423
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4ad37d44-7346-4ee1-9fc4-339bf5b53819,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:7b62465d7524e2479d0233267941e3d4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 206fb2523eb711f1aa26b74ffac11d73-20260423
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1158859117; Thu, 23 Apr 2026 09:52:46 +0800
Message-ID: <c26c666f-2d6e-44e1-8974-d9e46e329ee1@kylinos.cn>
Date: Thu, 23 Apr 2026 09:52:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix kernel NULL pointer dereference in
 fuse_uring_add_to_pq()
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert
 <bernd@bsbernd.com>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422103603.4554-1-liwang@kylinos.cn>
 <e6077b7c-160c-4444-8ab8-ccab8b14ac27@linux.alibaba.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <e6077b7c-160c-4444-8ab8-ccab8b14ac27@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jingbo,

On 22/04/2026 19:18, Jingbo Xu wrote:
> 
> 
> On 4/22/26 6:36 PM, Li Wang wrote:
>> A kernel NULL pointer dereference was triggered when testing the
>> 'fuse over io_uring' feature with passthrough_ll. The call trace
>> is as follows:
>>   BUG: kernel NULL pointer dereference, address: 0000000000000878
>>   RIP: 0010:fuse_uring_add_req_to_ring_ent+0x89/0xd0 [fuse]
>>   Call Trace:
>>   <TASK>
>>   fuse_uring_queue_fuse_req+0x82/0x100 [fuse]
>>   fuse_chan_send+0xe6/0x180 [fuse]
> 
> I don't see fuse_chan_send() in upstream kernel.  I think you are
> testing kernel with this patchset[1] applied?
> 
> [1] https://lore.kernel.org/all/20260416091658.462783-1-mszeredi@redhat.com/
> 

The test is based on 
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Thanks,
Li
