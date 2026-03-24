Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D52C324D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375384; cv=none; b=sTs4k1xIl5rqT2nQw1uiPjgD2b0hcr8I/ffYwQxy6Vk0FeYB1cRz7i2nedHyhl2rWsnBnoK9eMk2ajS2q2hwsZkIjXpbWyZYrt9DtLCESH81cxg4izA8RSoB6uC5L30mN1Fa4CVyMGYoqnPjTJFkqzsismClMMLZFrsDlFQ44C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375384; c=relaxed/simple;
	bh=edUyR+QDDRyLFMuhV5Gg2BHaasp0ndG65ZvB4ZssrnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljV0zTFpl5ubWJ24SljWE3pSu3UaiSwyJ1YQk3e+xNrWiC1XZxfneWfncSmnOH5pqgq9tWXjMmOgTfyHXoHxHP9mlsB0Wrfu41A9udXkr4bgiDaWkfUlKiOr9xhedxHStKxl+vj8SNXdid5jnmMzt6hlPdgqxdmZuEV98qYR3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=AGyeYQ+F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M/tkD7aP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="AGyeYQ+F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M/tkD7aP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id AB0AAEC008F;
	Tue, 24 Mar 2026 14:03:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Mar 2026 14:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774375382;
	 x=1774461782; bh=ZBeW6fiT+Aq11W60V2Jh/4kN1JZALljTDvE/0DW2xnQ=; b=
	AGyeYQ+F5H+5hf4W6ASGDos/+TZ1tuW94Ea4JHaRqY7/OhWUACS5s3dUY+paHzJ+
	8xE+lYfVKtACONsCJd3AveLVyG/C/H5OEsdii7HamdRuSKOse2R3HhigR/kbJyeS
	KQkzORtXde0D6mZerLf8n8F3z3pfrcUxL8BvVb2BwgznEUssHYy9zV1cvhw2t9SP
	wmFNE4ATNkTNK6fvudfmR8FEJ0MgvEo8JeRFgj29T7mMFMgayQY3/lwm4oBWIjgU
	Qe1AIxSNphIETu7wEDIcaRW/O3imp2eQOCxHL2tY5lkaZfc4jiNQUaq9/9XDCYld
	iJ4iTNKMsz/hUgdvmyPskw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774375382; x=
	1774461782; bh=ZBeW6fiT+Aq11W60V2Jh/4kN1JZALljTDvE/0DW2xnQ=; b=M
	/tkD7aPoD9sQu8pwzJNXHPXa3cPo+GRxIXR3QfhTHdxbgHD5/Gi9VDqJxxxghMry
	R3tYMAln1+5NFpa9Me9D0XBuCwDk+lCzZCGATIEBzXR9tN8yWeNSKTi4y8VevZZC
	lP9KTHvwN9JTTUnh2gdJZ2WCP8fOQy2wq99CMVtX/OM4x9cJs8RQi2FhXmOtnj80
	B7L/DZm/2i17DscAx2VNMuA8RbikO4VYCQmsM4oqFA9EI0R+CsV/b/o0+KZmiIXH
	JgZrRQjJ3CEynobZoZufZQNb6fcjfhs3Kn8KBpc6ofJGDdosQHlWuEFdF+11myTG
	dcdRbTF15aHVJ4QnjMkfg==
X-ME-Sender: <xms:1tHCafEC5r_z9cmFmLWr0ShqjPlpP2cDR6KSidbzVgD8FY10HYx3TQ>
    <xme:1tHCaTOt7CqLNZ7dcKyNfm3Lv31aT3cYpD9CNg-YSb_G-Nzrs4CCu1MAMWO9Xz80u
    -x-w3WycpBkbsdbu_AfFqGQeo_rpTJPheLXGidliPH6bzaXPV0>
X-ME-Received: <xmr:1tHCaZcjeHKS84ywP3sHfPwFAEyqZC35B7OWdmWGq_f9bfJ2RaKhGqMakBTMmEX_5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorg
    hnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghr
    thesuggunhdrtghomh
X-ME-Proxy: <xmx:1tHCaYv79fNPx-eomT3gHU812kw0Wg2L4L49klqcKPZiwtp37TukVQ>
    <xmx:1tHCaSm59ILEVsZI8MIV1iOurvTlC0V8am-Pe7jpci9UvskLTGBoXg>
    <xmx:1tHCaSwGVuSdG9QZULkjEU1kWYru83k6VAYMfS9WXSXDXLyrZNef-Q>
    <xmx:1tHCacNw9bC5NMK59R1XroaqOIRSXiRw1_BZ83EsBF-98dBB8YzNyw>
    <xmx:1tHCaY_fhvPgwrR1fHzUPAKMR4qdb2zOMAuHPpxD0zBlnxLm2YCY3Ej0>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 14:03:01 -0400 (EDT)
Message-ID: <2dc1090e-9a85-4f55-a0ce-e8f03176fdc3@bsbernd.com>
Date: Tue, 24 Mar 2026 19:03:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] Add FUSE_MOUNT_FALLBACK_NEEDED define for -2 mount
 errors
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-7-a52d3040af69@bsbernd.com>
 <20260323223607.GI6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260323223607.GI6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/23/26 23:36, Darrick J. Wong wrote:
> On Mon, Mar 23, 2026 at 06:45:02PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> Magic numbers in the code are not good - we better use a define.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  lib/fuse_i.h | 3 +++
>>  lib/mount.c  | 6 +++---
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
>> index 9e3c5dc5021e210a2778e975a37ab609af324010..b4c1d3eef41010287f6c9555ec0b2442d904d192 100644
>> --- a/lib/fuse_i.h
>> +++ b/lib/fuse_i.h
>> @@ -217,6 +217,9 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
>>   */
>>  void fuse_chan_put(struct fuse_chan *ch);
>>  
>> +/* Special return value for mount functions to indicate fallback to fusermount3 is needed */
>> +#define FUSE_MOUNT_FALLBACK_NEEDED -2
> 
> ...and you might want to put that in parentheses to avoid weird
> interactions elsewhere.  Or maybe just make fuse_kern_do_mount return an
> enum so that callers have to handle FUSE_MOUNT_{OK,FAIL,FALLBACK} and
> can do so via switch statements?

I'm going the simple way for now and put it in parentheses. I think the
old API needs further clean up later on.

Thanks,
Bernd
