Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711731E89C;
	Thu, 23 Apr 2026 02:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776909901; cv=none; b=rq3nobi6WJfN4lKSjrMAquDhfxri+/GGdLhJlpzVo0szlwni2bL/iAUQif0I6TTjSFmdOUBwI4jLb5PuSL4biIbr1PO2sAUjkra8vROUzfK7oA8g6mbd+eC75vQB6DjMLUopwlI1TRJtDPqiAiYzyZhsEzKRErX7daVJH9r86lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776909901; c=relaxed/simple;
	bh=KejzeyKLH/tRD9KJfKqVfAUqNjuhUZ4uz5vP1O5fZPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2eLbVE8Sv7wBP04w14+uggiemVC6dsKTG+b8DLEPRfnUQzzEjGwcwnCb5COuBJH2OEQYiIVIhWL5qC/KUglzwJoTK+PzUlRlaoFElWnUrhG9JIhZ+MFcGGZYIsmooimnxm5xBXPBbIh3H/nh/6xlkle4damAx+Xkay8PlJHYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d1c4cf463eb811f1aa26b74ffac11d73-20260423
X-CID-CACHE: Type:Local,Time:202604230952+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7c4f08a1-bc88-4d97-b9c0-49e2f3e1a639,IP:0,U
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
X-UUID: d1c4cf463eb811f1aa26b74ffac11d73-20260423
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 884005677; Thu, 23 Apr 2026 10:04:53 +0800
Message-ID: <2088c32d-e01f-4553-b4ab-eb69739878e5@kylinos.cn>
Date: Thu, 23 Apr 2026 10:04:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix kernel NULL pointer dereference in
 fuse_uring_add_to_pq()
Content-Language: en-GB
To: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422103603.4554-1-liwang@kylinos.cn>
 <4ff484d8-c1a3-4828-b500-796f4fb8790c@bsbernd.com>
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <4ff484d8-c1a3-4828-b500-796f4fb8790c@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bernd,

On 22/04/2026 19:39, Bernd Schubert wrote:
> 
> I don't think this patch is right. The existing order is
> 
> 	queue = kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
> 	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
> 	queue->fpq.processing = pq;
> 	fuse_pqueue_init(&queue->fpq); =====> INIT_LIST_HEAD() of pg
> 
> 
> I need to look at Miklos' patches, I guess it sends to fuse-io-uring,
> although that is not ready yet.
> 
> 
> Thanks,
> Bernd

The test is based on 
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next
It seems the code ordering has been changed.

Thanks,
Li
