Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089343358DA
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245794; cv=none; b=TBThzg5xX4FWev9tCwGJ/7TLYEmmqqJct5FnCTW+hsJsMZLI8hYg6wSvWeT9EUmtYhLmVboeY3ORVrvVKtDAUPnGjd0LAXumyeE7Eja0ugrbH07kFWoqsbc5I5RoANIaz5zDINVRO1uh5aed/6f+hO2wkGAwMrVDEoPikUcOZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245794; c=relaxed/simple;
	bh=hLEjpAIWEsdCV5PktXkPPMCpJveadwAa7xLE/qklbp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBOYE3aEUCDXdQq4ajluI4aNtW9HPUTCM5P4s5k+n00gSAi89GYN2FjvK9otGEUG0kMo/slI5L8e8+L+lIgqdcg/ioTptGNfaEiFu0xDIcj8zZwNi+GF05LKhpTDPCW3QwtbVDNoEBzoIe2Bwrou3PPB5CLn9jDMJO1CGQx9tUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=IMseKf/i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lk9pUAWw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="IMseKf/i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lk9pUAWw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 180627A01D9;
	Wed, 15 Apr 2026 05:36:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 05:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776245791;
	 x=1776332191; bh=T3TwWJkt1rA0M3buJJdbT2/Gf3ero9v/y2L6lLrMXZM=; b=
	IMseKf/il5yTfLqaQHZQmWFwQXwr34LrYwMO8y9ITjyqGnJ1iysSw1Jjr4Lt/mre
	XCvcDvWLoPdHGBWnboXkf5MEBb7pLfkjhYsiZH7anMGvR7BcHv2jIgLKM10wSvg/
	54zFhJAd3NSj2BzapFWZCfWdsnIgu0nHRwkFYAhEbalRaAFcOmPxwTPvYtg9RfxT
	2RPck4ZKcroq2MM5Fg0rHH6/sHfd1304upIUtIH+ljSwqavV4gsOF0JnHV4MYygP
	7fcdlHJaIxlTEqW42+I7Fvxbd2mLwlIKxmgpOPCo18JIqKOiwRscS14+1cxLZvbR
	oYm5XWhDeM1pLfeFiF07WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776245791; x=
	1776332191; bh=T3TwWJkt1rA0M3buJJdbT2/Gf3ero9v/y2L6lLrMXZM=; b=L
	k9pUAWwkiWSZYBrbDOeDKUOhJ0nsb2kR3z+wCjWJk4TYhtts27g0lWxqPO5Qofi/
	H93YmZXNsdSqkUDLUJCG/eAEduNurqfFK1gtYtE3eqW4hknQ7BP/BVOHalPPcTdw
	WrsGdcXFSS/RAKlxARiNC+vGMlOIHEEN1NyJLEHdAU/2oYm7ItDKtOo7rWdeqO2H
	46yqpZbT5dFroVRpD5j2lHf9MZDD+IB1O0ZBfVgm0AuAHKvrok8TukWQGGDpUAAi
	cFrkR093MNkjTdhQyZ0E1VnuI9QuIGeHBq3EJCpPsOCjKZbTN/OdL5bH0LdNxW1o
	q1Q2lnUcCoyDKp513mSag==
X-ME-Sender: <xms:H1zfaRI0plQaKVtcba9ZCU7DLae7GIJ1-3ZIbWau9W9nWvtypAPIZQ>
    <xme:H1zfaUIYU10mxlJ1Qd05nyzM6ReBGZ6daOFVWl0AKGpAmWjvT_g9fvkNIXPEnlqpd
    hzY-wFktN1wJ1HCz9QdClYTt-VTOvtbB5efxd3naPoFkDPUeqLA>
X-ME-Received: <xmr:H1zfaeut7mphAJ5Be9eClkSvnZoi1pUxkssMUq3FMdXh9Qwhhv158Qxi5GKu12Y02RILlnV2K0Kxnbw2WSWicX4eNU1Q8gSpoGKUkMwXH-KC93qpIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeejgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:H1zfaRQ9pe_MecUa-GFGZkVezOS4eZ_D72ljk2zSebk47Ju7nh5jDw>
    <xmx:H1zfaUMv7NFy48UDcwN8k1YmVi1sXiLUl8kZ0n0PVq5yVJXvvAjHCA>
    <xmx:H1zfaWafYI52r5GcUmgCOdLJPSHVWOyfdAV_15FBmTKbmgIo9Zk6hg>
    <xmx:H1zfaeyVTFw9hNncjmojH4IZwORsDkztE6WW7nPH9gDlrB719ZaOig>
    <xmx:H1zfaQGpL5xfnITt2vFH0HQYHUYnmBmqHcLps7SHakbvQsaeZq1Rar4B>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 05:36:30 -0400 (EDT)
Message-ID: <65abb01d-9f73-4fc5-abd5-ed5150034c3b@bsbernd.com>
Date: Wed, 15 Apr 2026 11:36:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] fuse: use named constants for io-uring iovec
 indices
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-8-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260402162840.2989717-8-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/26 18:28, Joanne Koong wrote:
> Replace magic indices 0 and 1 for the iovec array with named constants
> FUSE_URING_IOV_HEADERS and FUSE_URING_IOV_PAYLOAD. This makes the usages
> self-documenting and prepares for buffer ring support which will also
> reference these iovec slots by index.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
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

LGTM, thanks, I should have done that from the beginning.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
