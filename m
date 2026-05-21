Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525E366067
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384082; cv=none; b=JVsOl0b4hO50vro7JenELmh6Mzqa1T7JpAsDpwceH43D3K3w4az4kCWxkb96Ej3TaEL0EYYrqI7IyglxshdfeBC9R3aTMv0zimc9KgK46VhtJO7/yxrdpmsI2utdvwTtZax2wGifGNlqw7ynhhSXAKURDA7kHUjmnWNtiaqCwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384082; c=relaxed/simple;
	bh=x27Cn5ayT5fe1CxPdz2u22XzMo1DJKlFv1D1TLB6NZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I15t28qxD6zfnWhvf3ZAiQcLxABVDcVoPJeRsI6/kat+CW/Q8j/9kHa1mkLl24jIezQ7zF86atyg6lFaGxdDJu6POuO4T6oOK4wb4MC9KRxPUDXMxuWw4V7QX6TOCpUWc8+uGbUU7DAjzNX4q8TuoZfpoWRl0hAyJMx/f3Jjrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=0wnOfCZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHVkk7VJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="0wnOfCZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UHVkk7VJ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 122511400041;
	Thu, 21 May 2026 13:21:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 21 May 2026 13:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779384080;
	 x=1779470480; bh=zNE1It4yf/xuMam/Cs2Z4WwClwyD1XaC70SnEu3CCyE=; b=
	0wnOfCZPT4Ogmq1Q24FWsrB8zOYl8VSzYCJ3kaV8Apms9mKcmds0uz3/9vUJSB1h
	CwQABKt5kNbVhdp6RIj5Ha2Eulhl7Ew3UlKW1rYPDRJJz/d2k1MrQQXkc1Z08fan
	jseHLQP56q9mQ08skUx1CsKIiUUTBf2WHeZECdfoLWpuFW3iJBQULk3NbccwDHlv
	PIhdtnHhf8JDH4h/971uBpU4hoYowVCEycl6KRFLmk1tKvOjWuUXW7jxa1gAwiXX
	rkvsnWQrKz3NREtnI7/irT8fXurEBCIpeQi6KWn26HN7Oy7SwmbraIIgdEO/twkc
	Gcqz2NgHsNiffyBSYlCu5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779384080; x=1779470480; bh=z
	NE1It4yf/xuMam/Cs2Z4WwClwyD1XaC70SnEu3CCyE=; b=UHVkk7VJNVCcLO/qA
	nygZ8QY1vR3aNF6hq+Wbqe0IrNekmiDwwPa+zpb6boBrXpiauDz+s5b80Enxnjq/
	A0LciPLn0iRxyFmWI+AEiRjnXoEVfLh+wYyBKjvnlMqE7nVZOcpuzQ6VzD24gLrZ
	ajSvq+f9/kqPMEM1Q9nkrNZpm2KTfHFk1DAD6+GS2J0SUrqXL7mk6Tt9DruO7JqX
	PhMqPE+MsBwI5tJdNQoyZKxl/P75HD4qKeBEM9iYAQvcZHPo9hMDpkXckMbGdiOR
	+Tgtx48smonuTyq0zi8175mlmwxlJssS/FKR0B/FAd6DEfhHWqggiNg+M8rxQ9el
	zsdQw==
X-ME-Sender: <xms:Dz8ParCQUdvGW-SBx78sEopbfFzq2qJTOSeIlErwQReTBiqlei78Yw>
    <xme:Dz8PapQ-w5Tx3FdcQnsnLCZPmV6-AQFQhoVUyEcFsrA6TEDItz8IN8ylcBPMPHsGC
    Uem1wcQUPVDSgF0_AdlzeK-N-LVAmotYqAdqNYubWHPPUa8MXM>
X-ME-Received: <xmr:Dz8PapoYLDSjr3mcmvgbD7a0k9Bg7SvYs4OU81LBjE6E-WPNVjZbVzkbot22Oo9-7nHiSjBVf7Q-Z7wndacKAKY9Sy8hSX8ZJubgjIy8SW3CBm2tZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepvdellefhuefghedugfefteeuffejgfethfeuleegueethfegffegueffteeh
    geetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehfuhhsvgdquggvvhgvlheslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Dz8ParxWahnhMZfZcGjZrDftRi28_IS9-ch__mE2hWgBN8QL-S4YJw>
    <xmx:Dz8PauLfVsfkNK0e5j-jWGpj1ITEKhdNsroOpaoKZY6EP0IUr1A6iw>
    <xmx:Dz8PatIfqbDfrnPqayTvzzs4RklpHEmzAHwNpFxkW7GRsCDlVf9U9A>
    <xmx:Dz8PajtGGwoU8pM0m8CIZZO7U5QHw8Gr77QqYL-E9LQu6SATeVbEjw>
    <xmx:ED8Pat0SK4ndugfqT4rYPW0T8ymyjl9bAvn-3VIzi-A7tjeUXydx46CK>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 13:21:19 -0400 (EDT)
Message-ID: <a8aa3a49-7491-4085-80f2-19f89da00489@bsbernd.com>
Date: Thu, 21 May 2026 19:21:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
References: <20260429102058.1362965-1-mszeredi@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260429102058.1362965-1-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/26 12:20, Miklos Szeredi wrote:
> This stands for "fuse extended/experimental".
> 
> The purpose is to provide a clean base for big features like the FUSE_IOMAP
> api.
> 
> It's also a good way to try new stuff like file handles and compound
> requests without the risk of breaking something in the large and complex
> fuse codebase.
> 
> Whether these features will be migrated back into the main fuse codebase,
> or fusex is going to end up as a major version update is still up in the
> air.
> 
[...]

> +#define ADD_IN_ARG_ZERO(args) \
> +	ADD_IN_ARG(args, 0, NULL)

Hi Miklos,

could we avoid that? If we don't want to change existing op codes, could
we avoid it at least for any new op code?

DDN currently has a problem with

LOOKUP
STATX

and fuse_permission() calling into getattr.

Issues come from DLM and distributed metadata operations. It is
relatively simple to handle a total dentry/inode invalidation when a
file gets removed or moved to another dir. The really hard part are time
stamps and file size. I.e. most of the time fuse-client attributes are
just in state invalid. But then for single client access it also makes
sense to have attributes cached for ininity. So DLM invalidates
attributes if things change on a remote system.

Issue are now file creations of multiple clients in the same dir - the
parent does not have updated file attributes and actually does not need
to have them either for plain revalidate or permission attribute fetch.

For perm getattr it is relatively straight forward to use statx and add
in sx_flags that the server has to fetch. It can respond with more and
then cache time stamp gets updated. If some attr missing, time stamp is
not changed (detable it should be set to invalid)

Revalidate is harder, in the range to impossible with the curent
FUSE_LOOKUP call. There is no header, where a flag could get passed in
that it is a revalidate and not all attribtes are needed.

From my point of view, every single op code should have their own u32
feature flags field, so that an op code is easy to extend and without
the need to update the global flags.


[...]

> +
> +static struct inode *fusex_do_lookup(struct inode *base, const struct qstr *name)
> +{
> +	FUSE_ARGS(args);
> +	struct fuse_entryx_out outarg;
> +	struct fusex_id id;
> +	int err;
> +
> +	args.opcode = FUSE_LOOKUPX;
> +	ADD_IN_ARG_ZERO(args);

Here is would be good to have something like

#define FUSE_LOOKUPX_IN_IS_REVALIDATE (1u << )

struct fuse_lookupx_in {
      int32_t op_flags; /* op code feature flags */
      int32_t lookup_flags; /* so far FUSE_LOOKUPX_IN_IS_REVALIDATE */
};



Thanks,
Bernd
