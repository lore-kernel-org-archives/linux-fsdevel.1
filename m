Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49843D810C
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169319; cv=none; b=NGOFLeyX5Z4n9jC8wz5WhD0RJ5GdpOhuHn4eBsPX0hDH40Z/Kh4P4Gjs3QsD70FSMwv1BTWlTBFPHYcvEbbGgWQDKfHf9ZqeBi9SlsJ1p5pRd7m2HBF+89QNzS7t7cVDDv7MKd+Xt6CSAhxBuY5KbwefBIUuAAZklPTlm0tPryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169319; c=relaxed/simple;
	bh=qEvlKFsk4AwbU+LQWqteKJrut7PfeQWIBm6Wrs4NbAM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EYqrkQgj6txYAsYybUxvTmEx9U/E/7JezmGLu+2NouxNGaYz1OcTlwD63LHmFaPv4TteIw2E2sX17frAeWTICwjAu4Q+su5IRC2OSAHBKuOlYlzZ9bEld/O35Qi83w9UyZbHighvGMw1AL3uaAf0X5iSG8mWm5unUafLuy8DNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=eyG2vuIs; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="eyG2vuIs"
X-KPN-MessageId: 097e8153-a520-11f1-8f56-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 097e8153-a520-11f1-8f56-005056992ed3;
	Mon, 31 Aug 2026 11:40:44 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 097845df-a520-11f1-b37e-0050569977a2;
	Mon, 31 Aug 2026 11:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=UAEFgs/i0fSHFS1CNQSSnmqB5aisXdzzG/5ljYY2Wfw=;
	b=eyG2vuIslvAMm7wL8+rjwsq4nGUFfCUxNno9Z73HPaePOkoPI7a6G3b/B2syg/XAziyr0J1uFsGmL
	 vQNMB3drdfvgeWj/eKeEQtatIKD97xv9/4BoQ7Eg/dVgltOSzmQY1bNxEgI8dLK9UPGDHUxA4N6jl3
	 uyEVzFxwDtkZ2rqwp9Dn8VQlvsEzMQ6kOI7EohFISHPRXQPRveumOqRhrMA702RDtPCcsQJchjtpuU
	 0qW/rJnb+OZ3n19ZpaYmZag+tljjHwhrmFGoElDLnKJotG3G9GTkasumNbIJncvVcQYHGmik2s6trh
	 mITV+fERCXTuvWEqYdmlUA8Zgn3VEqw==
X-KPN-MID: 33|kb03t+oZ68yz6BGWwZ1dHq6KE4vd2Wu3cYv9IvZOIjMSVo+gT81YjbD77XcvSzG
 b/ttyy9/ETCw+q5oGGBp3TKXC8JpCbE9yxKkR4e4D/K4=
X-CMASSUN: 33|hs2VVt2Jjl/NlBuB6s3CKkP8DEegeAR7vhF4cR5UmuJ/3jmVvgo3MNniC1N0DSf
 v//9c9jgWrtLu/zU+Oh0jVA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 096b0344-a520-11f1-916a-005056995d6c;
	Mon, 31 Aug 2026 11:40:44 +0200 (CEST)
Date: Mon, 31 Aug 2026 11:40:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1028946868.2301677.1788169244070@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260831-zutreffen-umgeladen-wahrt-abfce6317a86@brauner>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
 <20260823160706.358293-7-jkoolstra@xs4all.nl>
 <20260831-zutreffen-umgeladen-wahrt-abfce6317a86@brauner>
Subject: Re: [PATCH v5 06/10] vfs: add O_CREAT|O_DIRECTORY to open*(2)
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


> Op 31-08-2026 11:34 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>
> > +static inline
> > +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *,
> > +				 struct dentry *, umode_t,
> > +				 struct delegated_inode *);
> >  /*
> >   * Look up and maybe create and open the last component.
> >   *
> > @@ -4462,6 +4501,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  	struct mnt_idmap *idmap;
> >  	struct dentry *dir = nd->path.dentry;
> >  	struct inode *dir_inode = dir->d_inode;
> > +	bool create_dir = O_IS_MKDIR(op->mode);
> 
> So this is called on op->mode which is 16-bit an O_DIRECTORY is bit 16.
> Hence, "create_dir" is always false. I think you wanted to test
> op->open_flag...

Yes, during rebasing somehow this happened. I fixed it, but then apparently forgot to
format-patch again... So this garbage series does not even run the selftests. Anyhow,
I am going to resend it today or tomorrow, but the structure remains the same, so I
can then also incorporate anything else you've found.

Thanks for looking into this again, Christian.
