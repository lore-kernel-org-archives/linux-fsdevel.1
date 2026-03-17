Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B9395259
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735153; cv=none; b=BW5Rig4mm1ov8KLp4Zc83sIT9FRT/OjvHgerEiJKV8sGprOkIyVTNCO7y3RdVQ+ETfwQZvMA2omdPxA6dDesqXsaVk3UrYKRCdG1fHV0aLMwnPRUMkijOop/CNydqqdiVAuwM30wRk6K6HwvvITNwEsvuWipMmi8qsszAw4+bWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735153; c=relaxed/simple;
	bh=kd60VLBztlICSB2/2oYHC9TW+pxMenwHzAeSqzKgQdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tt2HZQooCtd9wX/EUCDLMwgIJ7ChR+ietEr9G7bhJpyzdhJPt0VuKs5zn6zM71PbA2uoNSd02eLPqs0l/fL/RTkTPPxkh8sRCf+muYi3IJ80hY0v1HNthJKkzAUWpbkFNsN2tF8M9/BBylBkPQMRL8s1CYi8SfnT72elpisCtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 030449f821d911f1a21c59e7364eecb8-20260317
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:9ee9cd9a-a678-47db-97f5-c9009c77d721,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:d1dba8bde471f1f731c0e331bbb750a9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 030449f821d911f1a21c59e7364eecb8-20260317
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1214560612; Tue, 17 Mar 2026 16:12:16 +0800
Message-ID: <bdc6c640-517c-457b-ae3c-e3ea3cacfcca@kylinos.cn>
Date: Tue, 17 Mar 2026 16:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: rename confusing ring->max_payload_sz
To: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20260305123511.4222-1-liwang@kylinos.cn>
 <eae6aa8a-9550-4c82-9b77-12642af62cff@bsbernd.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <eae6aa8a-9550-4c82-9b77-12642af62cff@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bernd,

On 11/03/2026 00:31, Bernd Schubert wrote:
> 
> 
> On 3/5/26 13:35, Li Wang wrote:
>> In the fuse_uring_create_ring_ent function of dev_uring.c,
>> when payload_size < ring->max_payload_sz, it reports an error,
>> which is confusing because  ring->max_payload_sz feels like
>> it should represent the allowed upper limit. Therefore, rename it
>> to indicate the maximum possible payload size of the fuse requests.
>>
>> Signed-off-by: Li Wang <liwang@kylinos.cn>
>> ---
>>  fs/fuse/dev_uring.c   | 14 +++++++-------
>>  fs/fuse/dev_uring_i.h |  4 ++--
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 3a38b61aac26..9afa0c7cf92a 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -229,7 +229,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>>  	struct fuse_ring *ring;
>>  	size_t nr_queues = num_possible_cpus();
>>  	struct fuse_ring *res = NULL;
>> -	size_t max_payload_size;
>> +	size_t max_req_payload_size;
>>  
>>  	ring = kzalloc_obj(*fc->ring, GFP_KERNEL_ACCOUNT);
>>  	if (!ring)
>> @@ -240,8 +240,8 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>>  	if (!ring->queues)
>>  		goto out_err;
>>  
>> -	max_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
>> -	max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
>> +	max_req_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
>> +	max_req_payload_size = max(max_req_payload_size, fc->max_pages * PAGE_SIZE);
>>  
>>  	spin_lock(&fc->lock);
>>  	if (fc->ring) {
>> @@ -255,7 +255,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>>  
>>  	ring->nr_queues = nr_queues;
>>  	ring->fc = fc;
>> -	ring->max_payload_sz = max_payload_size;
>> +	ring->max_req_payload_sz = max_req_payload_size;
>>  	smp_store_release(&fc->ring, ring);
>>  
>>  	spin_unlock(&fc->lock);
>> @@ -590,7 +590,7 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>>  	if (err)
>>  		return -EFAULT;
>>  
>> -	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
>> +	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_req_payload_sz,
>>  			  &iter);
>>  	if (err)
>>  		return err;
>> @@ -621,7 +621,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>>  		.commit_id = req->in.h.unique,
>>  	};
>>  
>> -	err = import_ubuf(ITER_DEST, ent->payload, ring->max_payload_sz, &iter);
>> +	err = import_ubuf(ITER_DEST, ent->payload, ring->max_req_payload_sz, &iter);
>>  	if (err) {
>>  		pr_info_ratelimited("fuse: Import of user buffer failed\n");
>>  		return err;
>> @@ -1056,7 +1056,7 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>>  	}
>>  
>>  	payload_size = iov[1].iov_len;
>> -	if (payload_size < ring->max_payload_sz) {
>> +	if (payload_size < ring->max_req_payload_sz) {
>>  		pr_info_ratelimited("Invalid req payload len %zu\n",
>>  				    payload_size);
>>  		return ERR_PTR(err);
>> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
>> index 51a563922ce1..544f7afb3866 100644
>> --- a/fs/fuse/dev_uring_i.h
>> +++ b/fs/fuse/dev_uring_i.h
>> @@ -112,8 +112,8 @@ struct fuse_ring {
>>  	/* number of ring queues */
>>  	size_t nr_queues;
>>  
>> -	/* maximum payload/arg size */
>> -	size_t max_payload_sz;
>> +	/* maximum request payload/arg size */
>> +	size_t max_req_payload_sz;
>>  
>>  	struct fuse_ring_queue **queues;
>>  
> 
> I don't have a strong opinion here, wouldn't be sufficient to update the
> comment?
> 
Thanks for the review. I'm fine with either approach, so I'd like to defer to Miklos's preference. 
> 
> Thanks,
> Bernd

