Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2B3803F1;
	Mon, 11 May 2026 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489083; cv=none; b=cf93nKmkKpuDVWpC2M1pdnZsdSuCnmvluSnNf2HmQyeUjka6XiyM5UXVIdAjJ2CeD+OfG9EBDW6jtJWlFf+o/P+vC0rbL6SFCN4tqVIYnhIzVyv5tz1ZXtf3T4vgOrqU3d5rYyjFl31z/N2KiPVrW7hcIYANEoudmnv/+OaOPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489083; c=relaxed/simple;
	bh=r7E1bGhdsZi0miaB9eI/+/OI9PLQJ1A2kS6KgYUaHNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBgtgXJWB+W7mq03OCt2EiMt3JKESAHvMYd0STMd+iY0+gJppFxTCU6VwsYnUVKiFDzewYSLEuLG9SuaS5XVkFvJq3Kia4eSyxFCSLluHLq2f2iHuvpWJSr2xsogpXjWcXGwMUJpRXOVe1kPZFN2eRIwfD7DjoJimkj2bEoORZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a31b84624d1511f1aa26b74ffac11d73-20260511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b187f54d-c9e6-486c-94e4-59cc23cf0daa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e3d2900e4aa113a218b7eea4ec9b5546,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a31b84624d1511f1aa26b74ffac11d73-20260511
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1293493804; Mon, 11 May 2026 16:44:35 +0800
Message-ID: <ac112955-d484-4b6e-b597-14eb83076e3e@kylinos.cn>
Date: Mon, 11 May 2026 16:44:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: propagate async RELEASE queue errno in
 fuse_file_put()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong
 <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>,
 fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509102337.272593-1-liwang@kylinos.cn>
 <CAOQ4uxjRtUkWB6oCttv-VnznCB3T+HNXgoYgEcU3RwU6BokaYQ@mail.gmail.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <CAOQ4uxjRtUkWB6oCttv-VnznCB3T+HNXgoYgEcU3RwU6BokaYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Amir,

On 09/05/2026 22:46, Amir Goldstein wrote:
> On Sat, May 9, 2026 at 12:24 PM Li Wang <liwang@kylinos.cn> wrote:
>>
>> fuse_file_put() queues asynchronous FUSE_RELEASE via fuse_simple_background().
>> When queueing fails, the failure branch always passed -ENOTCONN into
>> fuse_release_end(). fuse_simple_background() can however fail for multiple reasons
>> with different return values, such as -ENOMEM or -EINTR. Pass the actual negative
>> errno into fuse_release_end(). Currently, the callback does not interpret it,
>> but passing the real value avoids misleading future development or debug printf
>> that assumes -ENOTCONN meant disconnect.
>>
> 
> Hi Li,
> 
> If fuse_release_end() does not do anything with the error, just drop this
> argument.
> 
> I see no point in this patch as is, serving some unknown future development.
> If future development needs the error, future developers can pass the error.
> 
I would have loved to drop it, however, while fuse_file_put() calls 
fuse_release_end() directly if sending the async request fails, it also 
registers fuse_release_end() as the success callback. Consequently, 
fuse_release_end() must strictly adhere to the callback signature; removing 
any parameter would trigger a compilation error. 

A similar pattern occurs when fuse_send_readpages() calls fuse_readpages_end(). 
In that case, if sending the request fails, fuse_readpages_end() is invoked 
directly using the error value returned by the sending function as an argument. 
Furthermore, the same applies to fuse_async_req_send() calling 
fuse_aio_complete_req(). This patch aligns with those cases. I'll send out 
a v2 patch with an updated commit message to clarify these points. 
Looking forward to your feedback.

Thanks,
Li

> Thanks,
> Amir.
> 
>> Add an explicit (void)error in fuse_release_end() so builds that enable
>> -Wunused-parameter (for example make W=3) stay clean.
>>
>> Signed-off-by: Li Wang <liwang@kylinos.cn>
>> ---
>>  fs/fuse/file.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 3bdab8d03373..8b7badb7721a 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -96,6 +96,8 @@ static void fuse_release_end(struct fuse_args *args, int error)
>>  {
>>         struct fuse_release_args *ra = container_of(args, typeof(*ra), args);
>>
>> +       (void)error;
>> +
>>         iput(ra->inode);
>>         kfree(ra);
>>  }
>> @@ -117,6 +119,8 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
>>                         fuse_simple_request(ff->fm, args);
>>                         fuse_release_end(args, 0);
>>                 } else {
>> +                       int err;
>> +
>>                         /*
>>                          * DAX inodes may need to issue a number of synchronous
>>                          * request for clearing the mappings.
>> @@ -124,9 +128,10 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
>>                         if (ra && ra->inode && FUSE_IS_DAX(ra->inode))
>>                                 args->may_block = true;
>>                         args->end = fuse_release_end;
>> -                       if (fuse_simple_background(ff->fm, args,
>> -                                                  GFP_KERNEL | __GFP_NOFAIL))
>> -                               fuse_release_end(args, -ENOTCONN);
>> +                       err = fuse_simple_background(ff->fm, args,
>> +                                                    GFP_KERNEL | __GFP_NOFAIL);
>> +                       if (err)
>> +                               fuse_release_end(args, err);
>>                 }
>>                 kfree(ff);
>>         }
>> --
>> 2.34.1
>>
>>

