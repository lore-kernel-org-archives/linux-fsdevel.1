Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4A2E718F
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871249; cv=none; b=cPirgvoHygtHI+onxJehW+xfWwEfKB3l08Rftgay2rkrvoK0lhhVaLh/mfmfIxfDQ3z/WOnpojAFhRytnUPKWIn9fZLGMQ7lHw4AqqalXR8ZJVpTwUp6Q6sExuL02XYu4wxk3GecG+YJUDRY85Qy7Hujf/NBO07Rur16m9WpI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871249; c=relaxed/simple;
	bh=rM8ojsb+AhMZ4pHl81A5AQ+/0yEd/96Rza7L0hdxLK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+2J38+HTkIw47FE+bMxRj8EC286I1Xy3tRbix8ZvLnpPFzHZRhreQkS8opqtKiSG4Y4oKOAwEwbOrPXQZLa5k07JSy3OHNDds4/7joKlaXOkW6tHs3PzmaJ8nwb8mYGIl4/YiAmLkQ+On/DXdrHQN+OcNoEkD5Wyl3JAZMr78U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gVSHoqnf; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gVSHoqnf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779871245; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=voreuBlVXEz00PuIDXmHDVpO2UN+uL6CphUqhH/13Sw=;
	b=gVSHoqnfC7aIeUhwQq1ZZn/B2fgy0cocITiJ6u05aAlVXDHIiRXbFR+BEl2/inXLR04L9NENn/Yyp3subzxhzZSASPFSHYMBiGwC90M0EDJcb9k3h+TxyYnDD3UYfbKgD+iFUPXUERZ3ZvApmCMTViHzL8+tA8cbdaK8a+REJTw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X3j8T30_1779871243;
Received: from 30.221.147.201(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3j8T30_1779871243 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 16:40:44 +0800
Message-ID: <9d0057dc-7d73-4033-8a96-9f4566f7c0f9@linux.alibaba.com>
Date: Wed, 27 May 2026 16:40:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] fuse: use named constants for io-uring iovec
 indices
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-8-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260402162840.2989717-8-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/4/3 00:28, Joanne Koong wrote:
> Replace magic indices 0 and 1 for the iovec array with named constants
> FUSE_URING_IOV_HEADERS and FUSE_URING_IOV_PAYLOAD. This makes the usages
> self-documenting and prepares for buffer ring support which will also
> reference these iovec slots by index.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good!

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
>  fs/fuse/dev_uring.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 045394a7ae41..a85acd9c2b71 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -18,7 +18,8 @@ MODULE_PARM_DESC(enable_uring,
>  		 "Enable userspace communication through io-uring");
>  
>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
> -
> +#define FUSE_URING_IOV_HEADERS 0
> +#define FUSE_URING_IOV_PAYLOAD 1
>  
>  bool fuse_uring_enabled(void)
>  {
> @@ -1063,8 +1064,8 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>  }
>  
>  /*
> - * sqe->addr is a ptr to an iovec array, iov[0] has the headers, iov[1]
> - * the payload
> + * sqe->addr is a ptr to an iovec array, iov[FUSE_URING_IOV_HEADERS] has the
> + * headers, iov[FUSE_URING_IOV_PAYLOAD] the payload
>   */
>  static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
>  					 struct iovec iov[FUSE_URING_IOV_SEGS])
> @@ -1094,8 +1095,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>  {
>  	struct fuse_ring *ring = queue->ring;
>  	struct fuse_ring_ent *ent;
> -	size_t payload_size;
>  	struct iovec iov[FUSE_URING_IOV_SEGS];
> +	struct iovec *headers, *payload;
>  	int err;
>  
>  	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> @@ -1106,15 +1107,16 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>  	}
>  
>  	err = -EINVAL;
> -	if (iov[0].iov_len < sizeof(struct fuse_uring_req_header)) {
> -		pr_info_ratelimited("Invalid header len %zu\n", iov[0].iov_len);
> +	headers = &iov[FUSE_URING_IOV_HEADERS];
> +	if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
> +		pr_info_ratelimited("Invalid header len %zu\n", headers->iov_len);
>  		return ERR_PTR(err);
>  	}
>  
> -	payload_size = iov[1].iov_len;
> -	if (payload_size < ring->max_payload_sz) {
> +	payload = &iov[FUSE_URING_IOV_PAYLOAD];
> +	if (payload->iov_len < ring->max_payload_sz) {
>  		pr_info_ratelimited("Invalid req payload len %zu\n",
> -				    payload_size);
> +				    payload->iov_len);
>  		return ERR_PTR(err);
>  	}
>  
> @@ -1126,8 +1128,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>  	INIT_LIST_HEAD(&ent->list);
>  
>  	ent->queue = queue;
> -	ent->headers = iov[0].iov_base;
> -	ent->payload = iov[1].iov_base;
> +	ent->headers = headers->iov_base;
> +	ent->payload = payload->iov_base;
>  
>  	atomic_inc(&ring->queue_refs);
>  	return ent;


