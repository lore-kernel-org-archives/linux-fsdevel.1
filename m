Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A84AF16C
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509452; cv=none; b=qBWDgSw+HLE89tZ2xwy2Qsdo11R/NguW9CAa3wPr4wvs+4gsLsEm9ZBF5kJi17meFfpT91nj/HkyykyMgVlr2aeispJaYnrmRHDAttdKAIQVaw/8Ah9S9PTzO4gww7qc7L3s+OMZXA2KqRF3OPlztyNwlRNAsKsE5ajxPMmzYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509452; c=relaxed/simple;
	bh=Lt8qyrqJYc7cQtJe32wNNIxLi9HPtu1msWByVRtr87Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=J1KNZfrWKRH2SGKbUKOCmnajrSWBepa6HffVwGbDuTtXhAYYoBXU6xCqMo4JvYj/tCLpnivwajEuM/jEcIRYd9eIaqMw8/TrPMH7y3HqQjYVjcO/6nGsL642kx1IsTmD0DmSsp5o9cYA6mxDPqf9tUmWKB14n+SwCMfyOK+qVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=DT2XibuD; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="DT2XibuD"
X-KPN-MessageId: 465c6649-b150-11f1-a5a2-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 465c6649-b150-11f1-a5a2-005056994fde;
	Tue, 15 Sep 2026 23:56:16 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 465bc48e-b150-11f1-9202-00505699891e;
	Tue, 15 Sep 2026 23:56:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=a0u+GbFOErpHePUx6+BI03U2sMvyd1zwQqxiBlKg7VA=;
	b=DT2XibuDIiyd7iJ053ua69Jt2ODdzNoOW7NCavtZZ3+oT4tBI6eTUD6wjCcp8sV+if1K2hz8HGidD
	 +tpYOZf3CzEV+rcknXT2kvxqY+QggKleNqbeVy3HIxIHfEPIPAtmdOn7XtzXK8SgfMvx5L/J51Merh
	 chtM5w9zQNTOC1vxv0Pb3exj0VGJsL0boaddBo/R+5TxfF0cXJaus3zvUdQzhqV0XDhpdlrbQg5Phx
	 S2kutYs4hf3ur86WEKeZR8fXe9AEaZyQTkEBJIrEbiDKzTbu4ZIV5Mq5j/phJrn552bm2TxP3eK9Kl
	 +FSNqKqNv2yGNwVtPwPKBuzeLcxXUow==
X-KPN-MID: 33|hKTD0EDuwhRhNaWcuXfiGcqODChJZ1fJcoc7DkNAErAfnSKm5IeiJZsNeeYSNDd
 Gs1JuRStdxTDOcknHmnRjzmyuMOw6z+nHpBKt+K6vYyU=
X-CMASSUN: 33|C+AJVU/bsno60VidSRcGj9m4Ai0QkFg1pbcKbK8HxySbj5Po4bY7Xssi8hO3ZdB
 jfln7omMohXrCmcC6E0PBSQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 464fb62a-b150-11f1-916a-005056995d6c;
	Tue, 15 Sep 2026 23:56:16 +0200 (CEST)
Date: Tue, 15 Sep 2026 23:56:16 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>, Dan Carpenter <error27@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Message-ID: <1913061521.1120051.1789509376030@kpc.webmail.kpnmail.nl>
In-Reply-To: <hftpz62zoc7rjn3xdcaqgnujjnicpgv6betqbqfyvp45tynmep@l7m75b46jxpz>
References: <aql0YTgwtRI0VZyG@stanley.mountain>
 <hftpz62zoc7rjn3xdcaqgnujjnicpgv6betqbqfyvp45tynmep@l7m75b46jxpz>
Subject: Re: [PATCH] vfs: clean up indenting in lookup_open()
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

This is about linux-next, right?

This should not have been pulled into next yet. I rebased this series after
Neil's vfs_lookup_open() landed in 7.3. There were some rebasing conflicts that
I fixed, but I left something out, which I fixed later but forgot to format-patch
again when sending out (including this whitespace). Christian pointed this
out to me, and I have fixed these things in v6 of O_CREAT|O_DIRECTORY.[1]

Please, pull that into vfs tree and then next. Some of the patches also need an
explicit review still, although Neil looked through most of it. Maybe you want
to take a look as well, Jan? :)

[1]: https://lore.kernel.org/linux-fsdevel/20260913185016.523376-1-jkoolstra@xs4all.nl/

> Op 15-09-2026 22:40 CEST schreef Jan Kara <jack@suse.cz>:
> 
>  
> On Tue 15-09-26 19:37:53, Dan Carpenter wrote:
> > These lines are indented too far.  Delete a tab.
> > 
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
> > ---
> >  fs/namei.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 1dd4ec7d0e62..48b28ed44a9e 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4636,9 +4636,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  	if (create_dir) {
> >  		struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry,
> >  						       mode, &delegated_inode);
> > -			error = PTR_ERR_OR_ZERO(res);
> > -			if (!error)
> > -				dentry = res;
> > +		error = PTR_ERR_OR_ZERO(res);
> > +		if (!error)
> > +			dentry = res;
> >  	} else {
> >  		error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
> >  	}
> > -- 
> > 2.53.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
