Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8A1B6D08
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779854527; cv=none; b=ncYCoTTq8gi6WNHpXbTCOMRrcaKUOrwIUPLa1jj+wSYInpxEQ03Jo7UJvL9f/m74jSS86sqYrf0KsjVyt3yGO+1dNvdB17SGHLTavlAyEz0qlsZoij6z65DNzSYA1hk+P44JXGFwxtT/kDq9kbuMe+DrxUjPMkE2KAcNJVf5Qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779854527; c=relaxed/simple;
	bh=PBo9WJBNLPr1LmLfMBPVMZDrF/mbA+/0SIP/Vgrcqwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vi97XBBIRGk5HyLCHi0+Rpy4xR+Ibsc+QuZAj/vP14grbjgdKAL2bn6wY+g7H38AkDdorlMt1i7I/p4OgnOhiWtmoF4CiFsd7IpCFuEXI43N2OuQ20Oenkw//Y5ZozFpXZgrePK1EnthxQNWiKHY8RIBA9FX837FeZ1uSj5ZUws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v009e4+R; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v009e4+R"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779854516; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/+zyqx8gn2iTtVFgyD6t8bCRdM/S+Gv6/O+8VfPFdaw=;
	b=v009e4+RWfkINimGME8+a/6sQt5GZknrI1yJWY2nbu0f63JR5DYE0+hvHeraaKlXBovVIQPOmPTl2/VnOOoOysv+ljRKrOIIw9R3E5itqFqv/e6sgEBGQT4jMteWNtzcRfedmplcx0BigPfpniIOCBZMu0idK1qvL3YZSnb5vqk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X3i7I3R_1779854515;
Received: from 30.221.147.201(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3i7I3R_1779854515 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 12:01:56 +0800
Message-ID: <ae5355a5-b10d-47e2-88f8-fc3eaa0de54e@linux.alibaba.com>
Date: Wed, 27 May 2026 12:01:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] fuse: separate next request fetching from
 sending logic
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-2-joannelkoong@gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260402162840.2989717-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/4/3 00:28, Joanne Koong wrote:
> Simplify the logic for fetching + sending off the next request.
>
> This gets rid of fuse_uring_send_next_to_ring() which contained
> duplicated logic from fuse_uring_send(). This decouples request fetching
> from the send operation, which makes the control flow clearer and
> reduces unnecessary parameter passing.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>


Nice cleanup. 

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
>  fs/fuse/dev_uring.c | 78 ++++++++++++++++-----------------------------
>  1 file changed, 28 insertions(+), 50 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 3a38b61aac26..54436d3fda4d 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -714,34 +714,6 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
>  	return err;
>  }
>  
> -/*
> - * Write data to the ring buffer and send the request to userspace,
> - * userspace will read it
> - * This is comparable with classical read(/dev/fuse)
> - */
> -static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
> -					struct fuse_req *req,
> -					unsigned int issue_flags)
> -{
> -	struct fuse_ring_queue *queue = ent->queue;
> -	int err;
> -	struct io_uring_cmd *cmd;
> -
> -	err = fuse_uring_prepare_send(ent, req);
> -	if (err)
> -		return err;
> -
> -	spin_lock(&queue->lock);
> -	cmd = ent->cmd;
> -	ent->cmd = NULL;
> -	ent->state = FRRS_USERSPACE;
> -	list_move_tail(&ent->list, &queue->ent_in_userspace);
> -	spin_unlock(&queue->lock);
> -
> -	io_uring_cmd_done(cmd, 0, issue_flags);
> -	return 0;
> -}
> -
>  /*
>   * Make a ring entry available for fuse_req assignment
>   */
> @@ -838,11 +810,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
>  }
>  
>  /*
> - * Get the next fuse req and send it
> + * Get the next fuse req.
> + *
> + * Returns true if the next fuse request has been assigned to the ent.
> + * Else, there is no next fuse request and this returns false.
>   */
> -static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
> -				     struct fuse_ring_queue *queue,
> -				     unsigned int issue_flags)
> +static bool fuse_uring_get_next_fuse_req(struct fuse_ring_ent *ent,
> +					 struct fuse_ring_queue *queue)
>  {
>  	int err;
>  	struct fuse_req *req;
> @@ -854,10 +828,12 @@ static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
>  	spin_unlock(&queue->lock);
>  
>  	if (req) {
> -		err = fuse_uring_send_next_to_ring(ent, req, issue_flags);
> +		err = fuse_uring_prepare_send(ent, req);
>  		if (err)
>  			goto retry;
>  	}
> +
> +	return req != NULL;
>  }
>  
>  static int fuse_ring_ent_set_commit(struct fuse_ring_ent *ent)
> @@ -875,6 +851,20 @@ static int fuse_ring_ent_set_commit(struct fuse_ring_ent *ent)
>  	return 0;
>  }
>  
> +static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
> +			    ssize_t ret, unsigned int issue_flags)
> +{
> +	struct fuse_ring_queue *queue = ent->queue;
> +
> +	spin_lock(&queue->lock);
> +	ent->state = FRRS_USERSPACE;
> +	list_move_tail(&ent->list, &queue->ent_in_userspace);
> +	ent->cmd = NULL;
> +	spin_unlock(&queue->lock);
> +
> +	io_uring_cmd_done(cmd, ret, issue_flags);
> +}
> +
>  /* FUSE_URING_CMD_COMMIT_AND_FETCH handler */
>  static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
>  				   struct fuse_conn *fc)
> @@ -947,7 +937,8 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
>  	 * and fetching is done in one step vs legacy fuse, which has separated
>  	 * read (fetch request) and write (commit result).
>  	 */
> -	fuse_uring_next_fuse_req(ent, queue, issue_flags);
> +	if (fuse_uring_get_next_fuse_req(ent, queue))
> +		fuse_uring_send(ent, cmd, 0, issue_flags);
>  	return 0;
>  }
>  
> @@ -1196,20 +1187,6 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  	return -EIOCBQUEUED;
>  }
>  
> -static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
> -			    ssize_t ret, unsigned int issue_flags)
> -{
> -	struct fuse_ring_queue *queue = ent->queue;
> -
> -	spin_lock(&queue->lock);
> -	ent->state = FRRS_USERSPACE;
> -	list_move_tail(&ent->list, &queue->ent_in_userspace);
> -	ent->cmd = NULL;
> -	spin_unlock(&queue->lock);
> -
> -	io_uring_cmd_done(cmd, ret, issue_flags);
> -}
> -
>  /*
>   * This prepares and sends the ring request in fuse-uring task context.
>   * User buffers are not mapped yet - the application does not have permission
> @@ -1226,8 +1203,9 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
>  	if (!tw.cancel) {
>  		err = fuse_uring_prepare_send(ent, ent->fuse_req);
>  		if (err) {
> -			fuse_uring_next_fuse_req(ent, queue, issue_flags);
> -			return;
> +			if (!fuse_uring_get_next_fuse_req(ent, queue))
> +				return;
> +			err = 0;
>  		}
>  	} else {
>  		err = -ECANCELED;


