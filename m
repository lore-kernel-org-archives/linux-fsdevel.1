Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA823EA976
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528178; cv=none; b=FK1sXPG1bVSOq/iDNP0lwx0MGhlM17G+If61TDQmZUw4nUAQJBP3o/eOjsVvo1JWb/PYzsuCNSkuvXkNQMWz99Mrf+ugT7PNgcCDVcuUhLuom2LQ972Gf1a+/hCqs+vK0oQEMfyf429UlXzYY14dhS1P21Izy+d21hATLPh6UPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528178; c=relaxed/simple;
	bh=KrdUUATIzJoYt6Kb+c9o6LEnMwvz+UMnP6GJLpP6ffs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UEldTX6Gwk8JoIoKFjL32U97DMz4MAlVzD3cw3MdWH278J/ABA80IGgnznVXSFzEoNEv0hz0ojHdTe/yoizK1OhivsnhMtOBXMiFW32OWpFJps7SuycxCnQx+cgLAg5Ygm9xW8URCN0F0MQxtZwkK/VkYRfpv6/xmsvHkup+MwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=umlN/mDG; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="umlN/mDG"
X-KPN-MessageId: 92a97e1a-68b9-11f1-89f8-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 92a97e1a-68b9-11f1-89f8-00505699b430;
	Mon, 15 Jun 2026 14:56:06 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 92a7748b-68b9-11f1-83df-00505699891e;
	Mon, 15 Jun 2026 14:56:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=E5RnpTF2GUtIcG5hYYV90nRDBCcqC8slIo783/2qoeU=;
	b=umlN/mDG5IaSFQ3qHPby/q5WkA830oZ+4h25LTipnSckTMpR8dW1PucmYG+GVmoFibGTMDE0E6MrP
	 OLjfkq7A2NSkdu0GG39FOXR67mwsdFdelrEb+ozyOpn1bcCX6qe4FH/HcZpNm3B6lblWSBF0LLHDS/
	 og4KhFTZ8Afcut5MbE4RRcGQKwBkZ+iZKIOgzpgJGmqBBEXAkGpCNB2utmCmBUz8O5n5sJNkybDprM
	 hPkxST02OHUmZhtbUYesE9lDHCmnzILdGbY9r3dZykqHYB0j4wsKOxIiRphHzncNXlw/02IMpQ0viT
	 OScyTxKvTesV4BRuxjMjeu2sx5ppD7g==
X-KPN-MID: 33|dPCDxaA97sbcPrgdHed+QFSAUsB+0lolN0DTeVT1dThMw9BlLQaOnF/MJCnHuc/
 I/3QMRXp0oDgxEfXGTqSzPmxlSCN2splQ562iTfKKE0U=
X-CMASSUN: 33|YjjSMN/SVIAUw7o75KsW22PbNFqsWLkeJs1VmViDHtZAFyZPzvqSCXjVYaE1za3
 jvBkQ4fcTPGPuXQUc8SnUUw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 92990daf-68b9-11f1-94b1-00505699eff2;
	Mon, 15 Jun 2026 14:56:06 +0200 (CEST)
Date: Mon, 15 Jun 2026 14:56:06 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <299847877.1794863.1781528166291@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260614164438.2980769-12-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
 <20260614164438.2980769-12-jkoolstra@xs4all.nl>
Subject: Re: [PATCH 11/12] vfs: short-circuit MAY_WRITE access for
 O_DIRECTORY opens
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 14-06-2026 18:44 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> 
>  
> Requesting write access on a directory can never succeed. Rather
> than performing a path-walk to determine whether the target is
> actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
> to -ENOTDIR.
> 
> Currently O_WRONLY for directories is only blocked in may_open(),
> which happens after we have the inode for the target, so after any
> create via O_CREAT|O_DIRECTORY.
> 
> The advantage of short-circuiting is that we don't have to add even
> more logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also,
> for filesystems that define atomic_open(), handling this cannot even be
> done at the VFS level, as we can't know ahead of calling
> ->atomic_open() what the result of the lookup is.
> 
> Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/open.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 5cf8ada58483..be980a737c82 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1268,9 +1268,16 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  
>  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
>  
> +	/*
> +	 * Requesting write access on a directory can never succeed. Rather
> +	 * than performing a path-walk to determine whether the target is
> +	 * actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
> +	 * to -ENOTDIR.
> +	 */
> +	if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
> +		return -ENOTDIR;
> +

I just realized this is not going to work. It should also check that __O_TMPFILE
isn't set, because of how O_TMPFILE is implemented. I'll fix this later.


>  	if (flags & O_CREAT) {
> -		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
> -			return -EISDIR;
>  		op->intent |= LOOKUP_CREATE;
>  		if (flags & O_EXCL) {
>  			op->intent |= LOOKUP_EXCL;
> -- 
> 2.54.0
