Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F01A681B
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170837; cv=none; b=aaTjFktT68SUoCDtWfShU+HUjtPUbHP9mI5/Bj/CTU6m+S2VOuY9q+nDXdxZA/pWW54JumQpq1WUWwwYDwYUUBLDsTXcIHUMBeg2Piy4U8O9SKRgk7mksQs1s+Q7sgw7kem5XuwY2ng3z+QdbeprcTrCjxLwgAc75g0fZSNTJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170837; c=relaxed/simple;
	bh=7psQKgCYnBisZRrE0Fj4k0l873mVJQ+756AZLNstwqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGF86UdoScca6IKIPCAoGChOnW9G5VZ8pjHuQWPFSZRaQTiCS5+tevD+rC7arKgDJ3N8YipptvDX5lfITig2IbqWOJpRZH06bxybkj8w0CZHn10Bg90YkoMZJzxoqKYEdGy+mi+v5g+2PthwKybEKxGZb6LjpbTXd1kxFAkdgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=mWJhv9h/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crxbjdrb; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="mWJhv9h/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crxbjdrb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C7427A026B;
	Tue, 14 Apr 2026 08:47:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 14 Apr 2026 08:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776170834;
	 x=1776257234; bh=rqrU/3Vu1AMnAQABoJM8/LSEDWmwdOnR8nzTyJKavNo=; b=
	mWJhv9h/XI2ih2h31mTGvSp1CYfy7yOGrAXhqqZB7CNlAnCcrNV0KIkRreKwAXcz
	Aej/T4lGlwK2IxKAL1auScidT3oeOs9UVhc6s4pAAJo+SqSsCWE/bNfHx4taAgk0
	qwh9gDy+vRol5p/5qm0AEDtZRlSH1PRKNpOgwtlEpwFo65NF2rYr9cgiY8s/Aevr
	3I3mGLDE0hYD41SJfngKW1woQqNIuYeGPTULo2xTAuHx9VXam/UstcSxfzCNqIKn
	6jf2TJLChAa7/Sc1mtVOMDaVt2y7SjcMuVSx+NkRTetELqI3jcwrtY1oTx7FKf98
	K3IqAZR3bFNwl0MQOZ/jqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776170834; x=
	1776257234; bh=rqrU/3Vu1AMnAQABoJM8/LSEDWmwdOnR8nzTyJKavNo=; b=c
	rxbjdrbD6S/rGnXOCsJFmMPEPMVdO+RQj5oQZR8bkrZ2UFAQ/llhaFWG1oFHSk4U
	+vW+m78lQ+n8TvtLXGC5BA4iQ6R02qFSIlWrTp0l0qzPzPghIjWxG7rVDvbU/Wyk
	U8sYefC+6Ik3nm41h4jOytPXXYOA8mj6+rMRJulUbiYrLr0dLQ4PH14glPjvjU8f
	cTMbW0rK0tXoe+N7/Fj7QUSc5C8u9FPhSwwjTrXXjl9SDItSewmQC7nEJE6Bxl96
	TOlSCOQbmJ2AYGyE/KrKuKSwuVB44JnpIAdO4sm+vEaxfR/UpIl4PDV+Ts6aRb23
	nXX5sXnIkacHPlX8jVviw==
X-ME-Sender: <xms:UTfeabU8eWV9Wcmj4Drz0ep9o9t5xhjfSQsSNjtJDTbxWtOZ70SxUQ>
    <xme:UTfeaak3NHH7P-LTIDJRDUwoJWpHokhlo1uGENJH8JBeyDgC-ZiTe5M56qaUkAHkn
    A-nvhP5HKMSDPJgBy3q7ZtWFNG1MBIwZZRaDVbqQiEFV7hLHtYIfw>
X-ME-Received: <xmr:UTfeacaW82jzcO9mDkXKb58wdXG79E3TtvhqZzFpW7ozqPzwnXpGBO7MGzC4S3M2anxNlWmYfNk590yBKNEubeCJ0hCqlnXLJOTuxTZNlAj1jr-hOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeguddulecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:UTfeaVMk1RQzekstlTgxFPYCjMLexB-DZXHhP45wGrNgtm6voOZDBA>
    <xmx:UTfeaRY_KIF0WQYf8G2QQhiePMRm-E_-WVOSbNEtBazNWqUrycjUdA>
    <xmx:UTfeaT3urrE4re78aD-agsgI8BNiJ35QVugypvE-IZmY0YbJxBEhyQ>
    <xmx:UTfeaXdRrd8xjP3TrFQvVOsSjTzPC1fx95i5uCYtcRpyDAbg0qUxJw>
    <xmx:UjfeaXyDgvuZ1fBbyC_LXc2auGlLYIa6eslrqef9MWX4d0RziBiOrnrg>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 08:47:12 -0400 (EDT)
Message-ID: <81b7ce30-50c3-4148-b0dc-fbf0a870f76e@bsbernd.com>
Date: Tue, 14 Apr 2026 14:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] fuse: add pinned headers capability for io-uring
 buffer rings
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-12-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260402162840.2989717-12-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/26 18:28, Joanne Koong wrote:
> Allow fuse servers to pin their header buffers by setting the
> FUSE_URING_PINNED_HEADERS flag alongside FUSE_URING_BUFRING on REGISTER
> sqes. When set, the kernel pins the header pages, vmaps them for a
> kernel virtual address, and uses direct memcpy for copying. This avoids
> the per-request overhead of having to pin/unpin user pages and translate
> virtual addresses.
> 
> Buffers must be page-aligned. The kernel accounts pinned pages against
> RLIMIT_MEMLOCK (bypassed with CAP_IPC_LOCK) and tracks mm->pinned_vm.
> Unpinning is done in process context during connection abort, since vmap
> cannot run in softirq (where final destruction occurs via RCU).
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c       | 228 ++++++++++++++++++++++++++++++++++++--
>  fs/fuse/dev_uring_i.h     |  23 +++-
>  include/uapi/linux/fuse.h |   2 +
>  3 files changed, 243 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 9f14a2bcde3f..79736b02cf9f 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/fs.h>
>  #include <linux/io_uring/cmd.h>
> +#include <linux/vmalloc.h>
>  
>  static bool __read_mostly enable_uring;
>  module_param(enable_uring, bool, 0644);
> @@ -46,6 +47,11 @@ static inline bool bufring_enabled(struct fuse_ring_queue *queue)
>  	return queue->bufring != NULL;
>  }
>  
> +static inline bool bufring_pinned_headers(struct fuse_ring_queue *queue)
> +{
> +	return queue->bufring->use_pinned_headers;
> +}
> +
>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>  				   struct fuse_ring_ent *ring_ent)
>  {
> @@ -200,6 +206,37 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
>  	return false;
>  }
>  
> +static void fuse_bufring_unpin_mem(struct fuse_bufring_pinned *mem)
> +{
> +	struct page **pages = mem->pages;
> +	unsigned int nr_pages = mem->nr_pages;
> +	struct user_struct *user = mem->user;
> +	struct mm_struct *mm_account = mem->mm_account;
> +
> +	vunmap(mem->addr);
> +	unpin_user_pages(pages, nr_pages);
> +
> +	if (user) {
> +		atomic_long_sub(nr_pages, &user->locked_vm);
> +		free_uid(user);
> +	}
> +
> +	atomic64_sub(nr_pages, &mm_account->pinned_vm);
> +	mmdrop(mm_account);
> +
> +	kvfree(mem->pages);
> +}
> +
> +static void fuse_uring_bufring_unpin(struct fuse_ring_queue *queue)
> +{
> +	struct fuse_bufring *br = queue->bufring;
> +
> +	if (bufring_pinned_headers(queue)) {
> +		fuse_bufring_unpin_mem(&br->pinned_headers);
> +		br->use_pinned_headers = false;
> +	}
> +}
> +
>  void fuse_uring_destruct(struct fuse_conn *fc)
>  {
>  	struct fuse_ring *ring = fc->ring;
> @@ -227,7 +264,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>  		}
>  
>  		kfree(queue->fpq.processing);
> -		kfree(queue->bufring);
> +		if (bufring_enabled(queue)) {
> +			fuse_uring_bufring_unpin(queue);
> +			kfree(queue->bufring);
> +		}
>  		kfree(queue);
>  		ring->queues[qid] = NULL;
>  	}
> @@ -309,14 +349,131 @@ static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
>  	return 0;
>  }
>  
> +static struct page **fuse_uring_pin_user_pages(void __user *uaddr,
> +					       unsigned long len, int *npages)

I think this is a duplicate of io_pin_pages(), can we just export that
and use here? I'm basically going to propose to use the same technique
in ublk - would be another duplicate.


(Not a complete a review yet, just something I just noticed).


Thanks,
Bernd
