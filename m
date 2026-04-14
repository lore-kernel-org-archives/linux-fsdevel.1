Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36B30EF89
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200711; cv=none; b=P2cBqfhcaYSyL8KHbPPOFQMil41cpbIp5bP9vsmoEUKe2E5Z3s6MGzNPrDvR5oEIBMFozAM/JZ0E7xOIwDwpRxqmjJ1w0wODslkP/uR/F4RGQDMDdYlBu5rBNELfwtq9bnX+KRWffx18pUaGS4p8jMP2QmXXWrEdeVoZtAz4f6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200711; c=relaxed/simple;
	bh=exomypjfBeYVLFKQL6dgsEirh5l3F4AHKNYdc/Kwna4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2OqYSYqkoQZeaYpNj0Lctq2ptQOIuWnX5eASS1uyuGLe2R4j9na71MWDf50gmmQMqvvdjkhuQQRsYnEoNAq3qVnDiwzZCH43gCYIZd9lqz1lUWj083oFPOeQodugtI9aCulUOqQH4lwDh0mG2HFxXBNNgQDqy/glGRty5+037E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=dMSXZEPm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+uDg0vX; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="dMSXZEPm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+uDg0vX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 615CC1D001BA;
	Tue, 14 Apr 2026 17:05:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 17:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776200708;
	 x=1776287108; bh=VN34HDAfftOAi4fza5l5+mwMARMoAueOHn2rM1UxC8A=; b=
	dMSXZEPmRk5CzVVBaTqFmAAuAhWGTQoj3MD7oS1i0oox+wdqgwdZI47rnEA5RF2i
	PXsGzk0eNKKjzhzRz7Xkfa/sIqwnILClwF3nuH2dxl1lTcG5ZLmr+szub6bvIudU
	ebqi/vW1P6VqCQWh5Cjp3svwwlr3K4QYoAk6c3EGBDv9C6JNYODTjDE5O+V9E6vU
	mPZflJ0F3BQxynBSMmBKbzaeonmyo63KVqbjOgtCLI84wHlkw8Np4j5VErJhJpER
	Q6QGf6fArtBJGR7bilSM83SxEGnf1p6hIBJDp4fGp3BKeZnTbg7c/BA7VB8Q7iKY
	WVTx3ux4J+n3GEsyfRMdGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776200708; x=
	1776287108; bh=VN34HDAfftOAi4fza5l5+mwMARMoAueOHn2rM1UxC8A=; b=F
	+uDg0vXwGbezuvGJLCCVIw04N4EKyxZdkLvjWKaD3HnKoczlydDzIxveGlydBmJ5
	MOQyV8rh2RBi2vz3QxnIYFwrBHA7nyBmEaeWnqKVSaSthbaMiSU8AoNVnz1Kjunr
	Zut24atx11VfR5Zi9Uh8Tbdoy2woC4T6Ikn5QMuDbaLdjs+9NCgvW2AfVYmk83k6
	w806bLm13WEw5lfw24UOKPloeUY0KOVULU9vxlrUMYnPWzOJCBWUDA704ZlltTkg
	s3h061UeWWEyO2iMtTvNHPhz0eIfb/ReP8ArIqc03MeVJftiobpViixXaL+DBCiu
	hIMDeMyXgY+uBJma7BFDw==
X-ME-Sender: <xms:A6zeaUP9wYplKTXepREgBkAvGCf_b26XVfGQ2k93IHyCJUxrFPlCuA>
    <xme:A6zeaR_IFVWlA90zprK076N14ZXm81VGmfF0Qu5tVhJ31cCqUeFuDPnD46RbQMuhT
    FgM1UqpqjuwLec3seoE76QC-I-OiPK2voAiZucYD8NcCb17NWGG>
X-ME-Received: <xmr:A6zeaQQdkJjHMdXTx8lLAkIxqu7NMcdOI0FmIurjwAZGsn4YpgL_F4rrjTrrknjSSp8Hk5TXwehoR-F3J6FSoAzXj_Zgzl4Po0knzEyNdQLnuo5PHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvddvtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:A6zeabkAPoDeBXbNz1Rutto1-xv2FvVuZCB0hS7kScVEiO8Xkq_-Zw>
    <xmx:A6zeaYS62RRWW1VE-K0Ox90wmnyC7zBIPReh_-DfXxKCICbWmzB5jg>
    <xmx:A6zeaRNQjTarqdEP7w69QQFFiKbG8JO4AdP-2z3xNiIsP41y_FwU5A>
    <xmx:A6zeaZU9iwPVrTxQuBWRSO3GTjOSb944xUg6qBGWZz2kiMzrHIFC1g>
    <xmx:BKzeafqTjV3NfNlP57PDSNaKjkbnO-rgYDPNfcXfePnWwuLt7cZGAJT3>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 17:05:05 -0400 (EDT)
Message-ID: <0f2b87c5-2c98-4463-9a9c-bfca91e83cfc@bsbernd.com>
Date: Tue, 14 Apr 2026 23:05:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] docs: fuse: add io-uring bufring and zero-copy
 documentation
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-15-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260402162840.2989717-15-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/26 18:28, Joanne Koong wrote:
> Add documentation for fuse over io-uring usage of buffer rings and
> zero-copy.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  .../filesystems/fuse/fuse-io-uring.rst        | 189 ++++++++++++++++++
>  1 file changed, 189 insertions(+)
> 
> diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Documentation/filesystems/fuse/fuse-io-uring.rst
> index d73dd0dbd238..bc47686c023f 100644
> --- a/Documentation/filesystems/fuse/fuse-io-uring.rst
> +++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
> @@ -95,5 +95,194 @@ Sending requests with CQEs
>   |    <fuse_unlink()                         |
>   |  <sys_unlink()                            |
>  
> +Buffer rings
> +============
>  
> +Buffer rings have two main advantages:
>  
> +* Reduced memory usage: payload buffers are pooled and selected on demand
> +  rather than dedicated per-entry, allowing fewer buffers than entries. This
> +  infrastructure also allows for future optimizations like incremental buffer
> +  consumption where non-overlapping parts of a buffer may be used across
> +  concurrent requests.
> +* Foundation for pinned buffers: contiguous buffer allocations allow the
> +  kernel to pin and vmap the entire region, avoiding per-request page
> +  resolution overhead
> +
> +At a high-level, this is how fuse uses buffer rings:
> +
> +* The first REGISTER SQE for a queue creates the queue and sets up the
> +  buffer ring. The server provides two iovecs: one for headers and one for
> +  payload buffers. Each entry gets a fixed ID (sqe->buf_index) that maps
> +  to a specific header slot.

Hi Joanne,

thanks a lot for this document! Could we discuss if we could just hook
in here and allow SQEs with different iovecs for the payload buffer?
Let's say fuse-server wants multiple IO sizes - it could easily do that
via different pBufs and just needs to specify the dedicated IO size per
pBuf. Those buffers could then get sorted into an array - we could
define either via FUSE init the number of buf sizes or use a fixed size
array. Fuse requests then would just need to pick the right array.
This is basically what I'm currently working on for ublk.

I think it would be good to agree on the design before it gets merged so
that uapi doesn't change.

Thanks,
Bernd


> +* When a client request arrives, the kernel selects a payload buffer from
> +  the ring (if the request has copyable data), copies headers and payload
> +  data, and completes the sqe.
> +* The buf_id of the selected payload buffer is communicated to the server
> +  via the fuse_uring_ent_in_out header. The server uses this to locate the
> +  payload data in its buffer.
> +* The server processes the request and sends a COMMIT_AND_FETCH SQE with
> +  the reply. The kernel processes the reply and recycles the buffer.
> +
> +Visually, this looks like::
> +
> + Headers buffer:
> + +-----------------------+-----------------------+-----+
> + | fuse_uring_req_header | fuse_uring_req_header | ... |
> + | [ent 0]               | [ent 1]               |     |
> + +-----------------------+-----------------------+-----+
> + ^                       ^
> + |                       |
> + ent 0 header slot       ent 1 header slot
> + (sqe->buf_index=0)      (sqe->buf_index=1)
> +
> + Payload buffer pool:
> + +-----------+-----------+-----------+-----+
> + | buf 0     | buf 1     | buf 2     | ... |
> + | (buf_size)| (buf_size)| (buf_size)|     |
> + +-----------+-----------+-----------+-----+
> + selected on demand, recycled after each request
> +
> +Buffer ring request flow
> +------------------------::
> +
> +|  Kernel                                  |  FUSE daemon
> +|                                          |
> +|  [client request arrives]                |
> +|  >fuse_uring_send()                      |
> +|    [select payload buf from ring]        |
> +|    >fuse_uring_select_buffer()           |
> +|    [copy headers to ent's header slot]   |
> +|    >copy_header_to_ring()                |
> +|    [copy payload to selected buf]        |
> +|    >fuse_uring_copy_to_ring()            |
> +|    [set buf_id in ent_in_out header]     |
> +|    >io_uring_cmd_done()                  |
> +|                                          |  [CQE received]
> +|                                          |  [read headers from header slot]
> +|                                          |  [read payload from buf_id]
> +|                                          |  [process request]
> +|                                          |  [write reply to header slot]
> +|                                          |  [write reply payload to buf]
> +|                                          |  >io_uring_submit()
> +|                                          |   COMMIT_AND_FETCH
> +|  >fuse_uring_commit_fetch()              |
> +|    >fuse_uring_commit()                  |
> +|     [copy reply from ring]               |
> +|     >fuse_uring_recycle_buffer()         |
> +|    >fuse_uring_get_next_fuse_req()       |
> +
> +Pinned buffers
> +==============
> +
> +Servers can optionally pin their header and/or payload buffers by setting
> +FUSE_URING_PINNED_HEADERS and/or FUSE_URING_PINNED_BUFFERS flags. When
> +set, the kernel pins the user pages and vmaps them during queue setup,
> +enabling memcpy to/from the kernel virtual address instead of
> +copy_to_user/copy_from_user.
> +
> +This avoids the per-request cost of pinning/unpinning user pages and
> +translating virtual addresses. Buffers must be page-aligned. The pinned pages
> +are accounted against RLIMIT_MEMLOCK (bypassable with CAP_IPC_LOCK).
> +
> +Zero-copy
> +=========
> +
> +Fuse io-uring zero-copy allows the server to directly read from / write to
> +the client's pages, bypassing any intermediary buffer copies. This requires
> +the FUSE_URING_ZERO_COPY flag, buffer rings with pinned headers and buffers,
> +and CAP_SYS_ADMIN.
> +
> +The kernel registers the client's underlying pages as a sparse buffer at
> +the entry's fixed id via io_buffer_register_bvec(). The fuse server can
> +then perform io_uring read/write operations directly on these pages.
> +Non-page-backed args (eg out headers) go through the payload buffer as
> +normal. Pages are unregistered when the request completes.
> +
> +The request flow for the zero-copy write path (client writes data, server
> +reads it) is as follows:
> +
> +Zero-copy write
> +---------------::
> +|  Kernel                                   |  FUSE server
> +|                                           |
> +|  "write(fd, buf, 1MB)"                    |
> +|                                           |
> +|  >sys_write()                             |
> +|    >fuse_file_write_iter()                |
> +|      >fuse_send_one()                     |
> +|        [req->args->in_pages = true]       |
> +|        [folios hold client write data]    |
> +|                                           |
> +|  >fuse_uring_copy_to_ring()               |
> +|    >copy_header_to_ring(IN_OUT)           |
> +|      [memcpy fuse_in_header to            |
> +|       pinned headers buf via kaddr]       |
> +|    >copy_header_to_ring(OP)               |
> +|      [memcpy write_in header]             |
> +|                                           |
> +|    >fuse_uring_args_to_ring()             |
> +|      >setup_fuse_copy_state()             |
> +|        [is_kaddr = true]                  |
> +|        [skip_folio_copy = true]           |
> +|                                           |
> +|      >fuse_uring_set_up_zero_copy()       |
> +|        [folio_get for each client folio]  |
> +|        [build bio_vec array from folios]  |
> +|        >io_buffer_register_bvec()         |
> +|          [register pages at ent->id]      |
> +|        [ent->zero_copied = true]          |
> +|                                           |
> +|      >fuse_copy_args()                    |
> +|        [skip_folio_copy => return 0       |
> +|         for page arg, skip data copy]     |
> +|                                           |
> +|    >copy_header_to_ring(RING_ENT)         |
> +|      [memcpy ent_in_out]                  |
> +|    >io_uring_cmd_done()                   |
> +|                                           |
> +|                                           | [CQE received]
> +|                                           |
> +|                                           | [issue io_uring READ at
> +|                                           |  ent->id]
> +|                                           | [reads directly from
> +|                                           | client's pages (ZERO_COPY)]
> +|                                           |
> +|                                           | [write data to backing
> +|                                           | store]
> +|                                           |  [submit COMMIT AND FETCH]
> +|                                           |
> +|  >fuse_uring_commit_fetch()               |
> +|    >fuse_uring_commit()                   |
> +|      >fuse_uring_copy_from_ring()         |
> +|    >fuse_uring_req_end()                  |
> +|      >io_buffer_unregister(ent->id)       |
> +|        [unregister sparse buffer]         |
> +|      >fuse_zero_copy_release()            |
> +|        [folio_put for each folio]         |
> +|      [ent->zero_copied = false]           |
> +|      >fuse_request_end()                  |
> +|        [wake up client]                   |
> +
> +The zero-copy read path is analogous.
> +
> +Some requests may have both page-backed args and non-page-backed args.
> +For these requests, the page-backed args are zero-copied while the
> +non-page-backed args are copied to the buffer selected from the buffer
> +ring:
> +  zero-copy: pages registered via io_buffer_register_bvec()
> +  non-page-backed: copied to payload buffer via fuse_copy_args()
> +
> +For a request whose payload is zero-copied, the registration/unregistration
> +path looks like:
> +
> +register:  fuse_uring_set_up_zero_copy()
> +	     folio_get() for each folio
> +	     io_buffer_register_bvec(ent->id)
> +
> +[server accesses pages via io_uring fixed buf at ent->id]
> +
> +unregister: fuse_uring_req_end()
> +	      io_buffer_unregister(ent->id)
> +	      -> fuse_zero_copy_release() callback
> +		 folio_put() for each folio

