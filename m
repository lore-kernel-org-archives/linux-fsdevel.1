Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF433D171A;
	Wed, 22 Apr 2026 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857994; cv=none; b=ETuptH0GDyVwmWjrhkc7mqg2AWg7GR2n1tLDalmVA1JMlK4xPdRMKlSY//Rtt/+f3DFH77xT1w8rEUMA34YnxL0hVhoqj8H7LS4quH7HJH+OTi6L5khlCUmsuXP6tlzHBD6WACTsMeGcAcDOL8vDuMCuAdFDADxjAMyMZRber2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857994; c=relaxed/simple;
	bh=tC5wF27MBmw+fRne7GCRZMNjLzjpd8iLsJmhdq8zPrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gC5FtWs5xqEr7HRbC/VhIXmn0bDPEowdfrdkIIpDFJl7Kls/9Gj8SkAsb9ldJkKR2GsSqm+49+qDs1Gbg/PjqLxKnakkFRDENveFNEkHZYw/eORXP0QwKDuGQrn0CPaAHv3IlFugyuAbm4PDwq2gzysd/ShZdhtBw7aPykMp7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=tRsB682z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nr6ZgTlG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="tRsB682z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nr6ZgTlG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CF333EC0653;
	Wed, 22 Apr 2026 07:39:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 22 Apr 2026 07:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776857986;
	 x=1776944386; bh=M1ez79K/phZCLQ4wfmXX44So8lZrAJRQzqxObznauYc=; b=
	tRsB682zACvjYPsEKNMrhY5UiPdrkwvaM9IN+fPU8FeQbsPkC9hoqZap0VCroxzv
	i75vRwzgfJKVamkYe97hcjobbuJxQQEtqO03ZHmWsf//Wezy+3VYPycyMYwUXFVn
	aBQLmX0iWrGU/2tI1/pVww3c46nxuH5Ntxn1r+tx4TL8wLkmEExGg+kqbR80gcN5
	vpexPSvX9UWfcHYFuO2+M/ldpMVC1Dx92dSsP9/VVJon3QQSUyBMRDR81vM5uaBA
	cefebD2jzWWJ1FW4/XI8hyVsWVnnVEJJn8c2lzT4+aUEm24qbaaW+U4ImmQgJO+z
	MCs3EWVapLgiDd5g/LaRVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776857986; x=
	1776944386; bh=M1ez79K/phZCLQ4wfmXX44So8lZrAJRQzqxObznauYc=; b=n
	r6ZgTlGD1QCoWptoXTYesIep3vgEd23Vb1bKUI/JOj8kWAhARa122dyf+GF8trIc
	1aTz7SOsL8uOVlnFcb74PQUdeg7M3P+xy4Gct4ec/aZkQHvgYo5g9gn5z4Nr1/tb
	pJnzz3L/UfOBLU2wGlaSJXViq/5FM/CVzsgKA0YQh6i57zUpzr2V7XcvR7TDuOBM
	X9TF9v+hHnMZxqZ9+x6HyxXT3H9C8YhQ3q81ADnNsWcOtYBTszev8yfnu4mt5KWS
	ZV0pmQlK4BHdMAyuhEBdiRXeelQvBIZMn04DG+h99Tz1dp5JXCabKe+98TIQu1he
	ljaJdsCGcAH/yDQXwe2/w==
X-ME-Sender: <xms:grPoaWNtvL974zMO5BRGGpmeexFyWoHOJJVwmErLp7j2ljBqEIH-Zw>
    <xme:grPoaf6j9S3kPa-FijLh30vjldU8f_t2xR0bHGsFzs-VTRfy6xssMQf3yJInn0_qZ
    kC2vQxVjAcKuksdwZ2Gof-uf7Vp5d20kSmceaTpvksZsWo8yefG>
X-ME-Received: <xmr:grPoacR9HcOYWF79lbWPpdphVh8JCr3EDF4i-UuUG1xmpPAh0hn-GR66h_cfQSA-3gODseQ0LfQm-lcJ-W1MfzhzYJT8JZuIMeL3mEICjsGWLWtm6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhifigrnhhgsehkhihlihhnohhsrdgtnhdprhgtph
    htthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorghnnhgv
    lhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhushgvqdguvghvvghlse
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:grPoacCoCnqlq364CSXNiY-kvLMwB_4f74TmYVpAxIWRyb5-NmMWwg>
    <xmx:grPoacE1aoZKI_xErkAMgluciyE3yaDCDP3Lsn7vJiOmUuUmQgU-tQ>
    <xmx:grPoaWC3HyKNuknR_MO7rf4HDnHMRtuzQXhXclzYiG_801ClaPO1Yw>
    <xmx:grPoaUUodprDXhrdch7YmPXbngACsToI4jf8j_Pjm1gEn7EYb71Z8g>
    <xmx:grPoaXtGFqcIlcPbClprKGxSerLldAJS4P7rlBpmvfe2VpUm3RHADZ6p>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 07:39:45 -0400 (EDT)
Message-ID: <4ff484d8-c1a3-4828-b500-796f4fb8790c@bsbernd.com>
Date: Wed, 22 Apr 2026 13:39:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix kernel NULL pointer dereference in
 fuse_uring_add_to_pq()
To: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422103603.4554-1-liwang@kylinos.cn>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260422103603.4554-1-liwang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/26 12:36, Li Wang wrote:
> A kernel NULL pointer dereference was triggered when testing the
> 'fuse over io_uring' feature with passthrough_ll. The call trace
> is as follows:
>   BUG: kernel NULL pointer dereference, address: 0000000000000878
>   RIP: 0010:fuse_uring_add_req_to_ring_ent+0x89/0xd0 [fuse]
>   Call Trace:
>   <TASK>
>   fuse_uring_queue_fuse_req+0x82/0x100 [fuse]
>   fuse_chan_send+0xe6/0x180 [fuse]

Is this linux-next?

>   fuse_lookup_name+0x131/0x2b0 [fuse]
>   fuse_lookup+0x78/0x1a0 [fuse]
>   fuse_atomic_open+0xfc/0x140 [fuse]
>   atomic_open+0x4b/0xf0
>   path_openat+0x746/0x1080
>   do_file_open+0xc9/0x180
> 
> fuse_uring_create_queue() must initialize struct fuse_pqueue before assigning
> the per-hash processing table:
> 
> - Call fuse_pqueue_init() before setting fpq.processing. fuse_pqueue_init()
>   clears fpq.processing; assigning the kcalloc'd bucket array must happen
>   afterwards.
> 
> - After allocating the processing bucket array with kzalloc_objs(), initialize
>   each list head with INIT_LIST_HEAD(), matching fuse_pqueue_alloc() in dev.c.
>   Zeroed list_head values are not valid empty lists; list_move_tail() would
>   dereference NULL prev/next.
> 
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/dev_uring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index d6d75e024b35..b765c1ff5e2d 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -282,6 +282,8 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>  		kfree(queue);
>  		return NULL;
>  	}
> +	for (int i = 0; i < FUSE_PQ_HASH_SIZE; i++)
> +		INIT_LIST_HEAD(&pq[i]);
>  
>  	queue->qid = qid;
>  	queue->ring = ring;
> @@ -295,8 +297,8 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>  	INIT_LIST_HEAD(&queue->fuse_req_bg_queue);
>  	INIT_LIST_HEAD(&queue->ent_released);
>  
> -	queue->fpq.processing = pq;
>  	fuse_pqueue_init(&queue->fpq);
> +	queue->fpq.processing = pq;
>  
>  	spin_lock(&fch->lock);
>  	if (ring->queues[qid]) {

I don't think this patch is right. The existing order is

	queue = kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
	queue->fpq.processing = pq;
	fuse_pqueue_init(&queue->fpq); =====> INIT_LIST_HEAD() of pg


I need to look at Miklos' patches, I guess it sends to fuse-io-uring,
although that is not ready yet.


Thanks,
Bernd

