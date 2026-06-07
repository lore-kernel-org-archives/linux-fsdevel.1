Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD891A262D
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861718; cv=none; b=rqUkrndrRFyhuIe47bm5iuLzNhF0Oj4saQRP3C86vjhpCXaUEvZcDgzAhDx1bKfU6wzC0EMwbSQJD6UFVfNZSImd+oaEZaJF/Hz/qxcsS+3PpBldkTa5rMkzKohQ/A+dEXddJSpi5PP7apqMZCkFeqkC98sc5PWk7m/vfNGjat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861718; c=relaxed/simple;
	bh=G20GcOrX6+CGaKGOIV5guEJ3jwzC6ddpTkB7zGUUneQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rledxGrSxipoTNyBbE4ZORKVgXDT5nFD4uAu1q0zWHdhXNrhQyXq6S5i+oI7znLCBWNcgHQ3c4+eKuPn0Ese5u7ZxnseNEYCgfs+Iqvd4a5FzrxJoKBbJ/RZ8mSVbuQuyQ4+5ceCu/OW6JJJQ39xElBplo9DfpSMiQINfvDikLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=mErCY45Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gw9pjOzg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="mErCY45Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gw9pjOzg"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id EF65FEC00FB;
	Sun,  7 Jun 2026 15:48:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 07 Jun 2026 15:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780861715;
	 x=1780948115; bh=ZnKN/f0qBAtORJ7B2OJO4R0odBgi6aleDgJZnOdbtkc=; b=
	mErCY45Yu5ng48ISmFCE20vupfMec2I71IKAX1uh+060uqEtaEXwjAk9DiOwAPu9
	ms1Nsnu11+7PJI9wXllrWhKKG01ZceAMYKlRUpdktDyzWk9tQz5lbFv6OHgK9nTn
	+JUBooFwExhJtsC7s3dVbN54KdQAf7zv8If4CTj1T5I6af0zU2ubBYYhBaHeGdLJ
	TTRwcH4KRgGylR/+56h5ngQlzxLwZ7b4LO8/t936/QZnqksHy4a/s8UPFZcVBgsS
	RmMy9AzXf2JRteqhQTos+MB/W1lOvzo+6YOLPK0ZFLgnz8WQmE9z/9Aq7fat6TpJ
	T8Z5i2ChpscktBXBte0HMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780861715; x=
	1780948115; bh=ZnKN/f0qBAtORJ7B2OJO4R0odBgi6aleDgJZnOdbtkc=; b=G
	w9pjOzgsSmmUo0sHYcFtXiAbPsbg74pEGtFzEjsgVwa9vLoV5XwzBK3rRI002JEC
	h1k0kmlIt9A4GMSdLSfEQ0Ux97qJgaDgBLkS1rsQPAT+4+5VtXWlhD2ddlT2etGd
	2xyJuOvyGQO28T115unVYwMeBiq48G04IbAuBkdf/Cth0MkMv4aeIrupFp1abc92
	ODemYYiLe53PzR2aOz+CZMyjwnUz5SQqtUrInW2x73GjNnLcuG5NQpPXISkfkqQb
	DX14QRENqjvrKGRLjcrCjquVRHq4EneBJEswnaoirDqJAMmDjwJvHJgqylcLx62M
	I40ieWnRZzpLfWpO3F6ig==
X-ME-Sender: <xms:E8slat9a9mTnZqvb3198q9LBCAL2XxtlkY13LsyjfQ6miRPgRu3oqg>
    <xme:E8slapeO52IvIILO7HAXew5sYy7tjGtSjnX35Q9cix0Sde7p3ZD3-z3V8tlBRaPGA
    yec-qAkb6eZO_CHn7-zWip2yla9pYvyn83jDTE7NL7yryy4m1yZ>
X-ME-Received: <xmr:E8slauHbSPbNdCcugswiO7M5apdiHk80vevkDLZkiaFMnjngNMp3EONrnyfZQSQXs6Yc7FhjQ3fJFvvderY6HwR4FYGDKr26lW5ofz9fe6R4mXwgiA>
X-ME-Proxy-Cause: dmFkZTESejR6ipOvY3VuKo6FBc+Z1pBmqJ7bwaY4DsssYilvgQjwhXomTIUw5Oq23OSZ58
    5MLF2AqsWfj64kXJkwQ+Qkk7xM9tKtCUwO8SraS6wluVSw4a3Z8/8M34gDEQJha2yINuFt
    TuRH0hDX/EVJ9dF6+sWlkd4/qd7wmqVXvQqiX+e5OhWpsXdijo/lmcpb1ZOdcy9Qb0ikBr
    23CvYzmDp90Azhy49X3jAzfBgMlrbRRbDARsaCtLvNONFTEtK+RzNi0+e8Urav5Vqv/4A/
    xDEz5cNl3haDSe9N4gTMgaLT09WDUjarDqrcRWvqer+/JyE1Ti3v+7YeFJii04WDOTWYMm
    4kOzjDVXVqWzn9x8E5y88ygrj8/UGPbcnvl5Kb+2crlG1b0DOabPFhj9iOZe4z4Abi26Zm
    93jnzWXQ8z5HLVQYgnBRgKJ68mQgksxHKPKFo+3Q6wgDQ/LiNXhmsmgvoRwDa5ti+79Ptx
    WgljBqlJRNgDRFqA5yIoSWauFvdRkHNWWUxmlhtc95KHIouw29mGUGVs5jy5Ht04ZSr5K/
    7noY9KCccwEXyLXbgJAcaIRLZA5JhYhNT4p26z1/hmTzDlA9JXt1SSL5PF3NVqrLYah0Ak
    SOqegYfgHrze9mRunEhJ/nEPPHrTNWt/HkTPilhTWitazfm2hWDiEx6MAJmQ
X-ME-Proxy: <xmx:E8slavdFjy77fxF0E2hvqo3uwA9eiyGf8Iu84v1dS-HpozEsc8zfww>
    <xmx:E8slagG-Y6u8MDFptpNrmqXx-6r-VKVtiHmy7tw67948gMphHMftLw>
    <xmx:E8slagWNRwCJgtYBAqyQV1kQhkAH_2So2PfQuNH1OboORkt0ULPQBw>
    <xmx:E8slavKWryufsNvismt6c9MfgauWa6-uCYsw52jNbpFtAkC_Kt-4yA>
    <xmx:E8slaluBI1BOSc1LdHgBZGR6tiRuZGQVEe-noK7Cu_WdW-oGpwwUqd4t>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jun 2026 15:48:35 -0400 (EDT)
Message-ID: <14b642b6-0df3-4d4c-a33a-fa9dddbe952f@bsbernd.com>
Date: Sun, 7 Jun 2026 21:48:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mount_service: don't pass the chopped buffer to
 apply_fsconfig_mount_opts
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
References: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
 <178044567862.1435997.14889132979032394431.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <178044567862.1435997.14889132979032394431.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/26 02:15, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If mount_service_handle_mntopts_cmd previously looked at the mount
> options to screen for allow_{other,root}, then tokstr (aka oc->value)
> has been modified and not put back.  This causes truncation of the mount
> options passed to fsconfig, so let's use the snapshot that we took
> previously.  Codex noticed this.
> 
> Fixes: 7211953256526f ("mount_service: use the fsmount API helpers from mount_fsmount.c")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  util/mount_service.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/util/mount_service.c b/util/mount_service.c
> index adcc7a296645ff..360a78bab3bd3d 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -994,7 +994,7 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
>  
>  #ifdef HAVE_NEW_MOUNT_API
>  	if (mo->fsopenfd >= 0) {
> -		int ret = apply_fsconfig_mount_opts(mo->fsopenfd, oc->value);
> +		int ret = apply_fsconfig_mount_opts(mo->fsopenfd, mntopts);
>  
>  		if (ret < 0) {
>  			free(mntopts);
> 

Wouldn't it be easier to read if strtok would operate on the string the
was duped than letting it work on the original? And also cleaner, let's
say oc->value would get uses somewhere else? Checking for "allow_other"
and "allow_root" could be even factored into a helper function.


Thanks,
Bernd
