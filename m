Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80D30E838
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780860995; cv=none; b=ivYiuwb71PsRmGBguI/o4xVOA9quJ3ZJdLtSoI6MLI0nGoEwplUsFbkhYva1ugeZPu6LaAtXhkFoS5y/dPLdRBCh7E5ZNvuPZJkJFEbzmOfq68A+clbJahOXuC9C9l770Va8YGWMPYueAh2GAL45sqcN1X6NDLgzSOckfuHXz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780860995; c=relaxed/simple;
	bh=XkUR9tf10XvlaAoORBGQLAImMyjVjlWonI9NzNNf9i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqWFGp1tp4Ss0JB4l9kwEGigWikLZ0Ih2CK1L7oUqNX9Q6WNorECAmvhcO306iFwJECcdhFX5VkjXMZjcAfMHeEQFY3cH3a9Lex0dD06weuQC2OkszvLMm3Y/Kli3Q+Mwj/s6/eBSk7srYjCMP6J1yOsUifg8LgiX7txIOBlWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=EPvV2kip; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4MOlcsa; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="EPvV2kip";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4MOlcsa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A54C3EC0088;
	Sun,  7 Jun 2026 15:36:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 07 Jun 2026 15:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780860992;
	 x=1780947392; bh=XSwwL419DcNkxB4bTWBifhWQAJb+qLSQNt44TgbIJ0Y=; b=
	EPvV2kipa2/TJFV5H4jBvw8g4ZreaUAN39E7lVRCkhq4LhEEi0YjP3Me9a8Nex6h
	RZISv3Ew0b2/IqzJ2pdlQLzbPUWggbBp3E92NDdm46ecg4z9AXQNLeNhJdssht6R
	VUXuLMMkNQwBMacBBcwoRg+kfGza3i14oWZHOIcxciPoEwNJzppF3M55b1Bv0ZKk
	kdoehsGiKOXwIiD9wKSCHVr41uce0X5VyyOhvf1sBMVjNKe6isi9FG3nJJ8CgOuJ
	ygxQam7DSsC1xcBJ5XCcyL9KStLmUDVRp6vG0Jiv5Mje8waNaKhFCgKjU+uDOROF
	GL7EvYpPVdFC345ilTZgKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780860992; x=
	1780947392; bh=XSwwL419DcNkxB4bTWBifhWQAJb+qLSQNt44TgbIJ0Y=; b=B
	4MOlcsa/T8Z32cJA3zmemTKk5BQ2EFuBQAvs+NgjzlZo/r61ONci/nylJI0olvlG
	vKB/7sGWMJOPr2rEdaZNh1u0a5+sii0mvenhkuUjYi5gkkaYzilwVX/+TN5lXKG2
	ml8nML/z1x437zNL2R6djJOOFo/ZLG58rPPeN0unMWyHxNsDUN4EMXa32l7DE47V
	ujniY8SJ5eNcLhQEYtr1SBRdRTI/oqe4DKeQc2baUVBS4si2s4UxdYeV4YdFDEZx
	K4wH3EuXu62Y/0webZ0odbF7hfGIGoPIC4npCiEjUvjnxuSs+QXaUQ+FvbcEYo0n
	9k5zTdyKd5Xlp4zQIRc9w==
X-ME-Sender: <xms:QMglamVCd7TvAWAVROrJZxB-kSmisHfguooQu1A__AczhhVKxlpWew>
    <xme:QMglaqWGVLBzKNW1yndxoZQRRDCuK37LKxrq9XgRCyY10Ow6g8ScR-gP7jBF94bo0
    lQsyafo-SYrvPraaxPhUHgBA-Cai6slAbvCHysnl3VpyDGlBhpq>
X-ME-Received: <xmr:QMglatcNc6XEkUZHNsTs1iGFy7kH3XikZkklhga-9EatBlUd92rbaARHcfM0X94SBzb9yohzGYmXg-m9O74P_K0aA0Mr6U27_7cd_wbZsBvFkQabxg>
X-ME-Proxy-Cause: dmFkZTGYKfWrHwMoSt7CsAPhHuasxa8Kdu+hu/0kE4AjmrCOkQNq8X/rtsZnAtc1fr5NEh
    +Fo4cpoydqHHMXft1idvRvA7926fHyjaWpnT4an9RVt1h2UvEM3Va/gspmdDihNufXA0r/
    PgO97iaDJq0toyrcdqutRmDyVIZIG3DIWB7zUrsvjouhCHJZPZGH8lnzqNN2X95kw+F3kA
    tOBhLowJpsfzUYDKQqAB/pr9ICKIngiW9ETAp5oFfy/6RjY9XQDWJphIv2Wf/RixsmFkAN
    O2QVWp7JX/mCfxvQyjYmIb0rF0WWnFYo9N9yBKoyPaPgO4682MQ3OItqs4lNB9Ha+IfaFK
    tAOv4VZ/+Gjc84K810oB3ycIL78fs5drBJtXZdyiQ00111J8x2Gi9tiu7BouCPgi+uAkgF
    eHbefah3seMW/PJ269aMeKKmJc3DZ0LS46BkRJBUd7oiZU7xQVbQ8Bagwd8Dr7ly6qiLkD
    453Rjg1GpZWR61m2AU23PElXc1h/0n2nvjRmSl4ETc28klUjOm185k/VeR2Jqg6muR9ljQ
    HMhOmdceE7Xbf9r8NGXuPv2WfHmyVGf9Ley+/+UNLDWFUtw3NOBPu/oO/jHYGaWMoQzTdu
    yRVIeoNgdmrGCr8GXGXaT5FirmW9KToTDDYLdChRVSzTIWxWC4OaveWhwBQg
X-ME-Proxy: <xmx:QMglarWPMQ8QcPBV9U_AvRAH1lkw1mIfPDG1056hCE0dW_0JPXK7Vg>
    <xmx:QMglaufX5d0GxSwD3YWqnd9cbWpOxuXnYjZhUpB7ns5llrGGcVOY4Q>
    <xmx:QMglavM3-bjACbQe_a7wgsAIXE7zF7Wt8qk5fWgYq7m8Y9b5Q2woVg>
    <xmx:QMglakgyT2Y7tJjiuB-ogM8XVHlMPJFfZw4UGicUO4HJQzBBhx8OVQ>
    <xmx:QMglavkPgmqGErEdNhEc6WFtUKldXYppu7eMftsM4ozt3kXbIjwy3pq3>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jun 2026 15:36:31 -0400 (EDT)
Message-ID: <a36689e2-705f-4311-a04e-55462fee1713@bsbernd.com>
Date: Sun, 7 Jun 2026 21:36:30 +0200
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

Btw, what does "oc" stand for? I would have probably called it "cmd".

Thanks,
Bernd
