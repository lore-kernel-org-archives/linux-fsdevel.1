Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08042DFF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953161; cv=none; b=CN/Nbh52B6a1PvTB75tr4gfUWGbRMpmYW6r8pSJjXjqGM/OTmZ5+4C/kjzX8UTr//ABfKh7SoZtfnFPwkrk+JvgZAN7gW80KKC5kFLFmrqtzFaNA0SMd+QXz1CaI3VJnFZxKtJkybsBr2nYHFyHynZj2jUsaJLu4vlaBf3Sr6nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953161; c=relaxed/simple;
	bh=sF6v1IDuQq939BWpVkK1+YyCt8GInJ0taks92LpLtnY=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=K8AQJ6XAv8Eo3u9BrIyWt8sUsySfNrIrHvShHkiQb7BarOADyqNMTXf8xjvD/ApQtOZUy8swrlg5jqFoOHJ+uJLc53mAdtjB1WQ8BJ9PUVi7Zg4nBzsfy2wbbR9AFwSBQs+XiyDEjs46Na02zO5WfpFLax/1vI084I/RVoMTVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Vjsmum2w; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Vjsmum2w"
X-KPN-MessageId: ad7d4ccb-7ec7-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ad7d4ccb-7ec7-11f1-bfba-00505699b430;
	Mon, 13 Jul 2026 16:32:29 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id ad7c1500-7ec7-11f1-9b0c-00505699693e;
	Mon, 13 Jul 2026 16:32:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=Wx81lLP7hXUWJpNdKKWFqKhuIhTVDLNbjdJ9wFEaxLo=;
	b=Vjsmum2w933ZyTK5cB2X53qNTJbgso8rlnFI4j4pdVepnUZcDwk8YQItf8LQIJLqFP9qdyJVI8qBv
	 85N3NWJfDUKA3Eu0a3FCFaxlQjttR5UE6CwJk/dRN+F6nMTxVoOwz3BporkglqwdnnHjAB3JEdRs1B
	 hAL+zISqZ/FsrcBKJTXWSSEl+gXGzSA2fNwFdQs/+uIDnQltv/2rhMu1yg04HfNnEhzu/TR+ZP6F/v
	 7iKSmzcySatxoP5TwsDCyRp4HP7R/5UZnibMaonvX2f2sLBGDutpDEufnI37GpSWasd9YRFqlc0HcY
	 iNYsTyvZFxAv0fN5DlYwAQ7U+p+ou4A==
X-KPN-MID: 33|3+OlfgVqbcMIEEQFDcEBG8eBe3RhSoMNqW54Q5xHnxEVzNRiws05DdT9asDlHa3
 StuybeOzK526e2Prf8xlNf8tV3dhGJOojIqysec/nfVs=
X-CMASSUN: 33|UECqIwgb+KCUC/D7dwz4qoLi5L8hFlRu4mLz9tNSV+/8whLQ0IZJ6FB8Yrbnl+u
 Hg6L6wXg9qV5S6EAMrlLoLA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id ad690d8a-7ec7-11f1-8edb-00505699eff2;
	Mon, 13 Jul 2026 16:32:29 +0200 (CEST)
Date: Mon, 13 Jul 2026 16:32:29 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Message-ID: <1316781808.864168.1783953149809@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH v3 10/24] binfmt_misc: remove the VERBOSE_STATUS toggle
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

On Fri, Jul 10, 2026 at 11:33:11AM +0200, Christian Brauner wrote:
> VERBOSE_STATUS is a compile-time constant that has been fixed to 1
> for as long as git history reaches. Turning it off requires editing
> the source and yields entry files that only ever report
> "enabled"/"disabled", a format nothing has ever seen in the wild.
> Remove the pretend knob and the dead branch it guards.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 9be57f387524..96f9ac752511 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -38,10 +38,6 @@
>  # define USE_DEBUG 0
>  #endif
>  
> -enum {
> -	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
> -};
> -
>  /* Entry status and match type bit numbers. */
>  enum binfmt_misc_entry_bits {
>  	MISC_FMT_ENABLED_BIT	= 0,
> @@ -611,11 +607,6 @@ static void entry_status(struct binfmt_misc_entry *e, char *page)
>  	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
>  		status = "enabled";
>  
> -	if (!VERBOSE_STATUS) {
> -		sprintf(page, "%s\n", status);
> -		return;
> -	}
> -
>  	dp += sprintf(dp, "%s\ninterpreter %s\n", status, e->interpreter);
>  
>  	/* print the special flags */
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
