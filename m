Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD382DECB2
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021504; cv=none; b=IKjFhzSddcL2NIp+srtFdHIdRFd86pCyFcHsZg4lBpbewCRiR5WIkjSLq6nre96qa/32wghxIZNDa+nBwsUNJBhIyoiSjwexxYgBn0wZBFAjfncAi7p75/d4uCTT26ffXmuzrNcF4AchV3dqO6gcSriJyUGyYrLDKXX8Mjhsgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021504; c=relaxed/simple;
	bh=ZlBIl2Jc5E+J+jOQihWK5jQ1mpLFC8nUUmOm66Fn9kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4yetMvPyHTG9nGHGOKsyE/OmHxDWaeZzgfeBw4X3xrFX+NM7XowtWwnbmVyrruKfhkwzu/vP1kyw6Pu6CXpZ8QJFSHdt+u4+LYmq0dsOZLYUaROUVoCFHPNNYOL3AVNBNJPfzlD3oNG4rhoy0oftPA9Z+912OqKNn4BR0xjeHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=OzESSAuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHaxh2dO; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="OzESSAuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHaxh2dO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34D8E1400031;
	Tue,  5 May 2026 18:51:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 05 May 2026 18:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778021502;
	 x=1778107902; bh=OJsA88cp4O3xdcrJNOx7gnTuj4dac2i8zmKY3almzfE=; b=
	OzESSAuXDxzblVJcSlv7W1T0Ik7H8ZBAS8RUQvWpCB34XNIPxtdoBVRRIXfs0V64
	wpYtFJU5Uj3+Fp5+qH0FWaqg33N7wFm9Pd+kUGZEoqjoiIlMUWYUvfxQXIvsMm6U
	r/KMx3UJf+WqX/nB6NetcUf/XHyFEDdSUp+dQgwtkVtPPXgl89ld927BEXFw5E2n
	VcUgN/ixQovS+4fwatYXYgq14wrimNisfzX/PoP12bvYUmMKybzThBqMTvXSB74W
	+1cDt2iCgmQtjHaJZyqaj0ueep2GoUEm8ZxPrCXeU/cjdyNkCQhZA6MtTkMHUx/R
	AfbjG+oibbjAMVk4L+hbrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778021502; x=
	1778107902; bh=OJsA88cp4O3xdcrJNOx7gnTuj4dac2i8zmKY3almzfE=; b=P
	Haxh2dOnSB+3bfs3WHKbjGuPUK9b3eMfSAwb7v2+6UKidIWJxSVyfsC8XdsCcWYF
	LnP6JegsBVngAGcBDysis30lVVxehWI6F3beyW3tbddT+8K8KiG49/xAMlbCIb+m
	Llz5MrLVEjGBNsx3XxrP9e/yAWAeNulv0QHLwOa0XWP9QJzM6+uhIM53g+dZhTuF
	gDKUABJFLIayM3FoAxsjiFogBG03qqvb41+sajY+Q2zg6bY06Ie4iSraLACGV8OS
	HVvfm82GoUAatoKtPDwkic+xHaoKbbMpvhVRfDss89RhQ4TdDTELr1G2xISRmxdH
	PqDnz88r8TalAL8t4R22A==
X-ME-Sender: <xms:fXT6ad4Iz5RuOLMfw7hTd71Vgpku3lu4La4SOAqlF6AQ8gGG5Gn3gA>
    <xme:fXT6aR779HEjfpOFQRRIAK57BdiJz2BwtoGo9WJq5UWbLOEKau-W5QOG1DoV45pay
    kVMlsqwt-vCLOGFaRRsnZI1tmt9pBSFxJFI5Egk8Zq5upZNTx-7>
X-ME-Received: <xmr:fXT6aZftfZDZ7WuCxf-hD0bjgpTDBfAHk4SlndOhAiUe_FMtOae5xirEc2irQhaHBkMVf4jWFszmRLYBftSYdgeaIo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    rgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fXT6aVDhZ3vxTuaYy2QP9WBwhrg9U4xFejvgtYCLt5ojYxMJD_aAAQ>
    <xmx:fXT6ac8EqqItOb_lGTN6bRDXfa-coqGQ6ETGXNdEcN5LzQvtO3FhqA>
    <xmx:fXT6aQJUIEJZPfD_UQ6z0gXO97hcVLTsR2LDOeazWHuY7Z5BMjvlGw>
    <xmx:fXT6aVikAOmovqE9MLdKi2T_793aqOjisX-AvlGvHMnqFKMqjrWfsw>
    <xmx:fnT6aS3nFLENj9X1eubn9eaOQsnAzV_RDSiy8t66O4A94QcnKvFPcq9H>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 18:51:38 -0400 (EDT)
Message-ID: <859d0c7b-8457-481c-af7e-a58704749b72@bsbernd.com>
Date: Wed, 6 May 2026 00:51:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] fuse: add pinned headers capability for io-uring
 buffer rings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-12-joannelkoong@gmail.com>
 <81b7ce30-50c3-4148-b0dc-fbf0a870f76e@bsbernd.com>
 <CAJnrk1bTdqEGdNkJ1tod62ovRXjam3GDj_g_M23YtxwYv_srqg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAJnrk1bTdqEGdNkJ1tod62ovRXjam3GDj_g_M23YtxwYv_srqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/15/26 02:48, Joanne Koong wrote:
> On Tue, Apr 14, 2026 at 5:47 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 4/2/26 18:28, Joanne Koong wrote:
>>> Allow fuse servers to pin their header buffers by setting the
>>> FUSE_URING_PINNED_HEADERS flag alongside FUSE_URING_BUFRING on REGISTER
>>> sqes. When set, the kernel pins the header pages, vmaps them for a
>>> kernel virtual address, and uses direct memcpy for copying. This avoids
>>> the per-request overhead of having to pin/unpin user pages and translate
>>> virtual addresses.
>>>
>>> Buffers must be page-aligned. The kernel accounts pinned pages against
>>> RLIMIT_MEMLOCK (bypassed with CAP_IPC_LOCK) and tracks mm->pinned_vm.
>>> Unpinning is done in process context during connection abort, since vmap
>>> cannot run in softirq (where final destruction occurs via RCU).
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>  fs/fuse/dev_uring.c       | 228 ++++++++++++++++++++++++++++++++++++--
>>>  fs/fuse/dev_uring_i.h     |  23 +++-
>>>  include/uapi/linux/fuse.h |   2 +
>>>  3 files changed, 243 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index 9f14a2bcde3f..79736b02cf9f 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -11,6 +11,7 @@
>>>
>>>  #include <linux/fs.h>
>>>  #include <linux/io_uring/cmd.h>
>>> +#include <linux/vmalloc.h>
>>>
>>>  static bool __read_mostly enable_uring;
>>>  module_param(enable_uring, bool, 0644);
>>> @@ -46,6 +47,11 @@ static inline bool bufring_enabled(struct fuse_ring_queue *queue)
>>>       return queue->bufring != NULL;
>>>  }
>>>
>>> +static inline bool bufring_pinned_headers(struct fuse_ring_queue *queue)
>>> +{
>>> +     return queue->bufring->use_pinned_headers;
>>> +}
>>> +
>>>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>>>                                  struct fuse_ring_ent *ring_ent)
>>>  {
>>> @@ -200,6 +206,37 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
>>>       return false;
>>>  }
>>>
>>> +static void fuse_bufring_unpin_mem(struct fuse_bufring_pinned *mem)
>>> +{
>>> +     struct page **pages = mem->pages;
>>> +     unsigned int nr_pages = mem->nr_pages;
>>> +     struct user_struct *user = mem->user;
>>> +     struct mm_struct *mm_account = mem->mm_account;
>>> +
>>> +     vunmap(mem->addr);
>>> +     unpin_user_pages(pages, nr_pages);
>>> +
>>> +     if (user) {
>>> +             atomic_long_sub(nr_pages, &user->locked_vm);
>>> +             free_uid(user);
>>> +     }
>>> +
>>> +     atomic64_sub(nr_pages, &mm_account->pinned_vm);
>>> +     mmdrop(mm_account);
>>> +
>>> +     kvfree(mem->pages);
>>> +}
>>> +
>>> +static void fuse_uring_bufring_unpin(struct fuse_ring_queue *queue)
>>> +{
>>> +     struct fuse_bufring *br = queue->bufring;
>>> +
>>> +     if (bufring_pinned_headers(queue)) {
>>> +             fuse_bufring_unpin_mem(&br->pinned_headers);
>>> +             br->use_pinned_headers = false;
>>> +     }
>>> +}
>>> +
>>>  void fuse_uring_destruct(struct fuse_conn *fc)
>>>  {
>>>       struct fuse_ring *ring = fc->ring;
>>> @@ -227,7 +264,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>>>               }
>>>
>>>               kfree(queue->fpq.processing);
>>> -             kfree(queue->bufring);
>>> +             if (bufring_enabled(queue)) {
>>> +                     fuse_uring_bufring_unpin(queue);
>>> +                     kfree(queue->bufring);
>>> +             }
>>>               kfree(queue);
>>>               ring->queues[qid] = NULL;
>>>       }
>>> @@ -309,14 +349,131 @@ static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
>>>       return 0;
>>>  }
>>>
>>> +static struct page **fuse_uring_pin_user_pages(void __user *uaddr,
>>> +                                            unsigned long len, int *npages)
>>
>> I think this is a duplicate of io_pin_pages(), can we just export that
>> and use here? I'm basically going to propose to use the same technique
>> in ublk - would be another duplicate.
>>
> 
> Tbh I think this is generic logic that makes more sense to live in the
> mm layer instead of fuse calling this as an exported io-uring
> function. The memory it's passing in is not related to io-uring, so
> that was my hesitation. For your ublk use case, is the memory you're
> passing into this user-allocated memory that's not part of io-uring?
> If so, then maybe it's best to move io_pin_pages() out of io-uring and
> into generic mm.

Maybe we could quickly check with Jens tomorrow how to proceed? Maybe
export it in io-uring for now and then later move it to mm/?

I definitely have exactly the same function in the ublk multi buf size
patch (maybe I sent it out as alpha-RFC in the morning).


Thanks,
Bernd

