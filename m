Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E9368D5A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354943; cv=none; b=Q2jCtxBccSOPSqCvpEDuIWnjESkuVNmi84gC/MTDaHdzCwusj5kVgLOICHUPZLXobgG3ErS2EreRj02JhkBl0AaaAaKQ6NkbIChDvKu/N7f5kHVztHaiVhSarVOkEjaw+ZlJ8QcbUuor8HIZNNGWKfDISxUFSjsTtBCmTSChjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354943; c=relaxed/simple;
	bh=NME2wg+8LeL6k4Ln27qfnBCaPKML1EwO42d7Byy3Lb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6gMT3nT/YHBkj9ihgdPo0fFr1dwJ5WdkNJBa+gB2OkQL+hyCnLKOZpEcnC/I9ufEGXGvGjcWY8CZ6AuRAoG2WeoA99sxSVw7CcftjWJyJujx+eZg5CmqRhPrVZM1LvQSCLCqEVSCB+Dimcq2b0xuwWEdwJay1vQLr1WIOAWln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=MMhiu7d1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iwdp5ux2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="MMhiu7d1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iwdp5ux2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 042B97A003E;
	Thu, 21 May 2026 05:15:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 21 May 2026 05:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779354940;
	 x=1779441340; bh=TU5901KgKhH4jL7QNn74nNfgljFNJDTLXdqCNfAIiZU=; b=
	MMhiu7d1r/Kjr4CttPb7vw1gv5LEMiaYahnxdLuibnA1UPDI99mP3FyaqJOxbCIr
	G+YjzltgUxhVkjglpijhZD1qO63WR9aaEuta+vdEJcs3lopXRBhOb+AjylaSlg86
	fk5skt4CXSI0hr0zGG9vvgaT6QdH2+A9PLlQpmdNQ0a90Zbol/l7kGIAPcNrTMmL
	LTW5ncEWQ8TMIOHcImzExtE69puX9+08+B+1xgjabioSm9JSX2iCFvyfixFHZlEI
	kcNtXVB87jS1YTuAgVxF+Q5NZX8qZrLo3ReP0XLLPNo2B6+XojknHlxUDFqvlqxB
	LD+h9wW8riW6LCqjOTqsFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779354940; x=
	1779441340; bh=TU5901KgKhH4jL7QNn74nNfgljFNJDTLXdqCNfAIiZU=; b=I
	wdp5ux26ektO5PQfkAgmqV0fZMeq82GpskuDpyzoUENdAkjy5buV/cI63v2+ftHO
	2QxO7QC4GlQnsv7uf5cnf84F6AWkA6uI1o8jNeZ54qe3qJNMHGw/jyjFX5IvgXVM
	oH8p2yn5OIC6IObaP6n52gcC3PPn88bIqX5P0nUpXuAd95/FADwRo6x0EcrRaCf2
	4KWYUtDP/bQMirpY4QC4Zik6kvvpNSI99IUqr509mL/6Ky1/GK3fpPJ6tOKSSxvV
	+Ju1CVPFTfdVmFET2bMWTtrsphbB6BlS+1Y1PRW0FLuX91vlObZxSnJfT6UXCvOE
	y7MpseOcVpb4JIobkseNQ==
X-ME-Sender: <xms:PM0OankATeLAigqpQyEWpYx4IG4UYCsU54CTtPxk-_Hl1cjot4Pl8w>
    <xme:PM0OakJZr8qcMVlwqP9hmBkhB6IanmD3Wn2UJr1_8csRP0dRfElVHFizkQreWv83p
    eNUDrqZWggDzV7_rULKI37M845T_MeyF4VfBZfX0nvdSmMI3zKt>
X-ME-Received: <xmr:PM0Oak4cKMKxqzEypLWsxffJcgA0lNOGhFqJo2jWfe0pqaAzlHK5M6SJa2kHSKlZ7Gf3vLAkIBhHQ14ujrHledXrIIct2oX8rS9bUlMhUMXt0JuqCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvug
    hirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlihhsthhsrdhlihhnuh
    igrdguvghv
X-ME-Proxy: <xmx:PM0Oag1Amv9srQxD_haVCojZgJIbWvJgLlPHxE5-afnQh8Gwisva6g>
    <xmx:PM0OaidqPcoO7WCIeVHpDYRTQRTCDqF3FML0_LZiHUMu0QqV6KUUsA>
    <xmx:PM0OaudAR_ZLhe_Nwg0pWzUvW9pBZwbIdmf8RX9vFZKLLGhRFcJhRw>
    <xmx:PM0OalwI3vJfPVrJscuw35jfeu75pEY2OmjKH31jjanw0IwXQeODHQ>
    <xmx:PM0OalunrlCoFotUqNusNDay8P3rexhNnkH0IW-dDfHbkyxx2LrFU5nx>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 05:15:39 -0400 (EDT)
Message-ID: <9954c0ab-3d5e-4318-9b04-4d636520d6ce@bsbernd.com>
Date: Thu, 21 May 2026 11:15:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] fuse_service: fix uninitialized variable
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
 <177933241518.3536631.717770834444587345.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <177933241518.3536631.717770834444587345.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/26 05:07, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Initialize the sockaddr_un variable so that subsequent comparisons won't
> fail in weird ways if getsockname doesn't fill out the object.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  lib/fuse_service.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/lib/fuse_service.c b/lib/fuse_service.c
> index d14aced29e8268..4340304eaf57b9 100644
> --- a/lib/fuse_service.c
> +++ b/lib/fuse_service.c
> @@ -388,7 +388,7 @@ static int check_sendbuf_size(int sockfd)
>  static int find_socket_fd(int nr_fds)
>  {
>  	struct stat stbuf;
> -	struct sockaddr_un urk;
> +	struct sockaddr_un urk = { };
>  	socklen_t urklen = sizeof(urk);
>  	int ret;
>  
> 
> 

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

And hmm, we kind of have a test issue - they passed. Uninitialized
memory is the only reason why there is still valgrind.

Thanks,
Bernd
