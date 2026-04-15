Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8753358A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246035; cv=none; b=RFSWtMEH/xqz2Cf7MfU/HzcGOakZqKD1QaNvpDkYEi3lnBssAvsiwidUyH3ppsCoTejORN28XUe51zVypH75DsE6qVpKiKwExnCwidbAL0xV9f/TMS7MAJ8kddM1b6n/zaUDC8qj8OYmxcv4JtTtKRKqExNZPEFaFw581H8dQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246035; c=relaxed/simple;
	bh=IfHGkQV1ErVOjfKXc9lcn9Cv1pCbt1cZfoyPS+CT658=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+/sRNwCaxcPVf7kGKvBsCKaHrl6wixDYQYuXdOKHqHspCo/CU+bP13wOIAy/M9IKMNxxsR5QxKIUK310+BbWkvWtwPy3SxYSxClBwHYcjl06OdadEN2qFw0/46qrxGJ2ezwtpzSoWwNioQ6bfPxunMdf0uOc9Uj41jPnwc6olQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=JRDQuyew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7TSlXod; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="JRDQuyew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7TSlXod"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CE6281D001BD;
	Wed, 15 Apr 2026 05:40:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 15 Apr 2026 05:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776246032;
	 x=1776332432; bh=3MXANH8cEdgF/3ULWFr/eDiALBtW0OcJ1EIBfF+d4LU=; b=
	JRDQuyewW6dYfaXMozeWPQE+pICBNRgH3+FNdgQMiFxPiGfh0kDbQniMYH3YLzOp
	ST9+qhxJ7vF+hcuuzsLvm8wIdp3WUDzSZRgOWksBNHAcXDVRw4r5bYX+0XfEmqTd
	rdX/H05hvWaqW60A73kpI45fuVCEJ0PDim+MjW17gsSmrbJLU3ZsL2YIjxw/0HIt
	aiqiSEWm7dwyo/Gy7FjUAJIND4xstfs7VYIZPkxXT87WdnT1jdk/MDAuc4ssakrV
	4h6CjZZuHP9LZ01Oh3n2P1AhZu47Y4+ZOWBEbLuwla+JsVE1TQaya6rxpYlTm16a
	uYAxD/a25+xs7xHVD18aHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776246032; x=
	1776332432; bh=3MXANH8cEdgF/3ULWFr/eDiALBtW0OcJ1EIBfF+d4LU=; b=Q
	7TSlXod3o0JKj+pLsXfLJGjfJ75qgTl8IjINb0GQqPl47o/e5otWdcgwFShd5G3v
	u/SBYvDYwEP9YpvxZpkv+P1zu18Cj664qTYt42iI5kt5HOy0quxgbeLKJvbdx7Sh
	leJczZlVbUJmQarjAts1yQvcQO4kP/DKzR12GJYrm+8dFxq3iq8CvGe+RZmTuyNw
	F2gbDetMqdBIrG3imM0yeWc/sY0hIv5yXLM+7S1fZvvNQVBVa/x+obDNd0HtKfFM
	qGUrkevK6Cz+P4GgFAcWx7s6iGnULV560uX+3SnMAUqgEDrDXURRYvaGUCzAVd3c
	xEOAN81EHvZoRwuLAEwJg==
X-ME-Sender: <xms:EF3faRDgXp1ssPZvRZqlar_U7dtrxc3ERjyIJxw0JLCNg6PiCHqp-Q>
    <xme:EF3faWiHohBPHmhs9zSyWrBzAZrV-bxiA-j-cdFgT9gTxkSj_zaTYGTFx4sMRI9cj
    nr_bdm0utz6HFWcKFs9Ikp3s62WDKD-WAQUKuso73lYolErDqmbcg>
X-ME-Received: <xmr:EF3faRklpYwU-kjSbQ382ez1mjJbMSoix01kdAsh3YWteImVEi55HkkE6K8EMTohyh27YGiBEdXrS3RSFS7B6xX3hSBtjGSPCZBD44S16ccb0ULHEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegr
    gigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EF3faapP0fulcGlaRwi7S2N3Ayc50zxgH8sopnAbulCJgsYz9Y-uhA>
    <xmx:EF3faSHdqs89tfJO08POldAukKybnyx-t3Lui-al_luRpdjuQwAzbQ>
    <xmx:EF3faewabrUyaOReFNXSJ2Hwcn9zqt3GcvUjcfbmHBSf3NAv7NfWgw>
    <xmx:EF3fafqRjC3mNzkSS7TttBNo94mrO5tBWdLYekWz9zADSKxsvQ4d9g>
    <xmx:EF3fabnITjS1lMgUuW4a1X4q_iY4-9YHFvc0poC5HEOFlpdIKFIQKmJr>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 05:40:31 -0400 (EDT)
Message-ID: <08c9575f-3740-4b2c-b87c-797877b0adab@bsbernd.com>
Date: Wed, 15 Apr 2026 11:40:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] fuse: move fuse_uring_abort() from header to
 dev_uring.c
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-9-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260402162840.2989717-9-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/26 18:28, Joanne Koong wrote:
> Move fuse_uring_abort() out of the inline header definition and into
> dev_uring.c. This function calls several internal helpers (abort
> requests, stop queues) that are all defined in dev_uring.c so inlining
> it in the header unnecessarily exposes implementation details.
> 
> This will make the subsequent commit that adds pinning capabilties for
> fuse buffers cleaner.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c   | 17 +++++++++++++++--
>  fs/fuse/dev_uring_i.h | 16 +---------------
>  2 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index a85acd9c2b71..cce8994241b7 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -129,7 +129,7 @@ static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
>  	fuse_dev_end_requests(&req_list);
>  }
>  
> -void fuse_uring_abort_end_requests(struct fuse_ring *ring)
> +static void fuse_uring_abort_end_requests(struct fuse_ring *ring)
>  {
>  	int qid;
>  	struct fuse_ring_queue *queue;
> @@ -477,7 +477,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
>  /*
>   * Stop the ring queues
>   */
> -void fuse_uring_stop_queues(struct fuse_ring *ring)
> +static void fuse_uring_stop_queues(struct fuse_ring *ring)
>  {
>  	int qid;
>  
> @@ -501,6 +501,19 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
>  	}
>  }
>  
> +void fuse_uring_abort(struct fuse_conn *fc)
> +{
> +	struct fuse_ring *ring = fc->ring;
> +
> +	if (ring == NULL)
> +		return;
> +
> +	if (atomic_read(&ring->queue_refs) > 0) {
> +		fuse_uring_abort_end_requests(ring);
> +		fuse_uring_stop_queues(ring);
> +	}
> +}
> +
>  /*
>   * Handle IO_URING_F_CANCEL, typically should come on daemon termination.
>   *
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce1..349418db3374 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -137,27 +137,13 @@ struct fuse_ring {
>  
>  bool fuse_uring_enabled(void);
>  void fuse_uring_destruct(struct fuse_conn *fc);
> -void fuse_uring_stop_queues(struct fuse_ring *ring);
> -void fuse_uring_abort_end_requests(struct fuse_ring *ring);
> +void fuse_uring_abort(struct fuse_conn *fc);
>  int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
>  bool fuse_uring_remove_pending_req(struct fuse_req *req);
>  bool fuse_uring_request_expired(struct fuse_conn *fc);
>  
> -static inline void fuse_uring_abort(struct fuse_conn *fc)
> -{
> -	struct fuse_ring *ring = fc->ring;
> -
> -	if (ring == NULL)
> -		return;
> -
> -	if (atomic_read(&ring->queue_refs) > 0) {
> -		fuse_uring_abort_end_requests(ring);
> -		fuse_uring_stop_queues(ring);
> -	}
> -}
> -
>  static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
>  {
>  	struct fuse_ring *ring = fc->ring;

I had it put in there because of

#else /* CONFIG_FUSE_IO_URING */

but sure, we can also move the real function into the c file.


Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
