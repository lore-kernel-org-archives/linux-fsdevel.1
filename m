Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19A35CBD7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354147; cv=none; b=DFau4d6Fd52rlbL1V0ZhefFNf59yI1lt4K8oXdfDpbQSYNDMlg7vvAVsRzREjhVtADqPYTpq/08LMMjndavdxJYxrbweYYw5z3qAvJKsK1OGybIh2eiqO6/xW1l7qQkjolOcARFPxvN7CSQqL2GvDtyLs6lh8QEJmRgwErb1zrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354147; c=relaxed/simple;
	bh=MJTHKbO+c6eNmEMwrUNV1+JBb/n86A8lF8NgOoZi8yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XreCUl8jzu9GCjLhyJ9GQ+sIhKoZCuty28TkMchcrx2k7/iYs90E+PBfTDdAwKRe8fLC5tfsFkGo14XX4d6A3jxi47NnV8n1gtuowj+FPNbsw3XvX+wggwBWnm/M/TVz2OsaXMJ0yoWI8FoaD1drQbXeU8iYXlL7+DkBpJi+0s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=RglQy+3C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qo++fNzw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="RglQy+3C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qo++fNzw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CF447A0017;
	Thu, 21 May 2026 05:02:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 05:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779354144;
	 x=1779440544; bh=/FCdekhJONF+JOI0FRf3Fj4XUPPpz0/4JnyGwJAQjY8=; b=
	RglQy+3Cw0eNwDEg7gth6rKF1U2p5ICVdQA4SThC3m6TPSs6MRKn6uZfqo0NmY58
	I0vaC0r436V65BsSttsp9LfG9pxXLqigH/inpQ8Qu5ssaLmgarPES2kLostu9tt+
	/LBvk7f1FhEctPu9y57fnWzHzavr/+JHszpay8damP+ZlBKW5ic3XXIv8lpNOVUt
	Ci2y19RrLC0ECsA2HsQImbDpzZCB8kAE7TNyzOT3LBy3OArb9b60IXkOYtKgR8Bg
	jpGwsK7h0xaTzwe9RIDPtkhgWpJFwqdPIAAl3mWSoHtMApfmKNRi8/v2joaoHMHU
	+Le9/l5MOIAIQPsVIK/loQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779354144; x=
	1779440544; bh=/FCdekhJONF+JOI0FRf3Fj4XUPPpz0/4JnyGwJAQjY8=; b=Q
	o++fNzwZcF3iTuwQlyLjgRrTOs7VSbflUDB56yEqbdQlORlAxw7OT2pr/V11Xo7K
	diTCpRSZRdOtZsNXSMB/v2Xx5jZs/SesvO+5RqildPGAnSAFnSp1uohy6AaT/rIU
	WFZ00hpci5yEZL8E/4pQEMUhQLMOfmW/Mb70C9ur6ENfU5/oL/v9l6u0wMmXUxbl
	A0Cvsz+M+LXzmrNiXrbtLqpurN++8PY9JrXlCvRXRE0926Wp0quxiOPfNdb2lXid
	86Q7KtviotMpPOaKAiJLFQmzw4/mk9V7JFmUTfFPLJvBlPNQ9LkR+YwN15yllT8x
	B2mWblfkvuzkqbYSZg/Aw==
X-ME-Sender: <xms:IMoOanoJhHLVcGOHuVPl1SAvi1iBhLf0I5zOGZyY6nmTG8tezPzoMw>
    <xme:IMoOaq8UIc8sg7d8DYRrQc3mqzNvECFkFzVH2N38sBy-Thv-djM1f834Tv0ki4RYD
    3OJXsUkGd-ef5G35REwIsiTsE74Z3GB-OvN1rn_iWd2-dGHlGti>
X-ME-Received: <xmr:IMoOarfXdCN1vCNsDUBCLaMFtYSWzcXk5hKVVE6Bo0Pj_qzlrkqgC5RolAVIU4DiZNAwm5I92yKlhUx3E4279S6mgPvy0TZ037Gurcovj3qCGTip-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejuddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:IMoOasJhcjDO7Vm9Pj8lnD-bst5NoIbIn20DflwSNZrCfUEYCWFlzw>
    <xmx:IMoOajhiaM2kcdj8q5KzaieW2pRjkIBoifOHf0XBpx-hJVqMguSRmw>
    <xmx:IMoOaiQmHliqCTbNWmcBDZp5EPd-Gg2U0JC4bfbuj5XCSNk-9R-z2A>
    <xmx:IMoOalVxjucnxHf_Dju_Xlvul_Usj0xGIZZ0zvMFqsWXqPIKdqIf2g>
    <xmx:IMoOas4BdMthupWF38UyXjOhWX9ArlOpY2BxBXRiCY4TpcrCeKd3igKI>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 05:02:23 -0400 (EDT)
Message-ID: <fb545c0d-a8e1-4dc1-8d06-1c8ec4ec47fc@bsbernd.com>
Date: Thu, 21 May 2026 11:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mount_service: fix some pointer handling
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
 <177933241501.3536631.17487472051183408289.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <177933241501.3536631.17487472051183408289.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/26 05:07, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Don't leak memory or try to free static data.  Pointed out by
> clang-check.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  util/mount_service.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/util/mount_service.c b/util/mount_service.c
> index 8b0eecf5b00ab2..a86a53c6fff40e 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -974,6 +974,7 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
>  				fprintf(stderr,
>  	"%s: option %s only allowed if 'user_allow_other' is set in %s\n",
>  					mo->msgtag, tok, FUSE_CONF);
> +				free(mntopts);
>  				return mount_service_send_reply(mo, EPERM);
>  			}
>  
> @@ -1036,7 +1037,8 @@ static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
>  	/* strtok_r mutates tokstr aka oc->value */
>  	while ((tok = strtok_r(tokstr, ",", &savetok)) != NULL) {
>  		if (!strcmp(tok, "-n")) {
> -			free(mo->mtabopts);
> +			if (mo->mtabopts != &IGNORE_MTAB)
> +				free(mo->mtabopts);
>  			mo->mtabopts = &IGNORE_MTAB;
>  		}
> 
Hmm, IGNORE_MTAB as type char is super confusing with the other define
in mount_util.c and fusermout.c - could you rename that to something
else? Maybe just change the case to "static char ignore mtab"?


Thanks,
Bernd
