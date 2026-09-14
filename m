Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F59470EB5
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391888; cv=none; b=TMqDzB7J0x16ETz5DqFBzttUBTfgA1xlHTttnYAB9vQ4QMIPTztJlLBt0LPT1S92SZJ+fT++EQK2Xpdyt8cNIDGztXS+k+GGbG2O9GRmUyYeIc9MkDb7ptQEmzTSu3RpiwURk7VPRxmCa6dgrMNH8zkxyoPjFmymzVQlnaCG8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391888; c=relaxed/simple;
	bh=EOyR6SalVox0H0hrdlVW+8+z4Da0ASIKZT7MEnIxkPE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=b/ncm8hCNmAlqWXEqPpq4LJF6KKGIOAHBjD0I6nhgBw1S30QjpAFqYIg86MQw+DRrZOjrTAfco0glYCpG10EWBPgmvd4KVeGlL6yNE0il/DKbJbe+QUENDL/+vPePUXl1yiRDjO9nPncK8uOic//oIzS/lbX1dTbY4F+v11Gjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=tZB7SZuD; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="tZB7SZuD"
X-KPN-MessageId: b6620427-b03e-11f1-bfbc-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b6620427-b03e-11f1-bfbc-00505699b430;
	Mon, 14 Sep 2026 15:18:01 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id b66095aa-b03e-11f1-a076-0050569981f5;
	Mon, 14 Sep 2026 15:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=3u7KwN3SbW8HijwGtqhZaoaB1O7NjTl5DIhCkuHvKmg=;
	b=tZB7SZuDqkaF0jwIy2NGs8s5oOsIFJUKLWUyFoOZX03dQjmzPxReUWsxWGYa1hS4PXGBrLSamOZ+s
	 5mq3Qm1m26t1Xf9Uz5wGI42erGfnncVPh8BNEdE3lZ25LlHDKb7qAXbzC/1C2xzNVZjZKVHgBzQm32
	 O0knydZolg4bl5HJdqAxkIPvwbcctbNTw1aHM62e2ahOQs9FwwPR2di+PTJd0HY93xoPmlEjhO7BFm
	 kDd3cnOIuHZ/t2//Ukjtx25RHWwtR83bZdzGLo4iY4+qR/cX+wFnsRUqwiKIQv0/vDf4/wgh00HTO+
	 vQOzTtJkzfDhmiEpSSsLcgMcZCvLuWg==
X-KPN-MID: 33|epUVl1Vf80vdm0hDsF2RTy6MDc6fmqeAqnJ8rubgb54bHLLeSktCKRvORX1xFtP
 +m0eT7dYjiMOoNL9EPeR0ouQxcnhh0s++PxDVxqCKQH4=
X-CMASSUN: 33|Lh93+RFDwZObGnvBJIxlFNIp0E9k0fYGAWu+SvzPtgvKjHdOWtwIh7XzzqDDYq1
 W+KJaBWH/Vf6rAYRYUQ8lfg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id b650fe66-b03e-11f1-8edc-00505699eff2;
	Mon, 14 Sep 2026 15:18:01 +0200 (CEST)
Date: Mon, 14 Sep 2026 15:18:01 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: Daan De Meyer <daan@amutable.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <1264706227.899081.1789391881838@kpc.webmail.kpnmail.nl>
In-Reply-To: <aqffHOsZaT92Fkg_@sirena.co.uk>
References: <aqffHOsZaT92Fkg_@sirena.co.uk>
Subject: Re: linux-next: manual merge of the security tree with the
 vfs-brauner tree
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

Hi Mark/Christian,

@Mark Wasn't aware that Christian pulled this already. There are some obvious
errors in the v5 of the O_CREAT|O_DIRECTORY that Christian also pointed out.
I messed something up during rebasing and somehow forgot to format-patch
again when sending that series out.

Anyway, finally got back from holiday and fixed everything in the v6, which
I sent yesterday. So please don't pull this just yet. I am a bit surprised,
because I hadn't gotten an explicit reviewed-by on every patch in the series.

@Christian, could you review the v6 so that we can fix this for next quickly?
It fixes the rebase issues, but there are some other small changes someone
else should also look at.

> Op 14-09-2026 13:48 CEST schreef Mark Brown <broonie@kernel.org>:
> 
>  
> Hi all,
> 
> Today's linux-next merge of the security tree got a conflict in:
> 
>   fs/namei.c
> 
> between commit:
> 
>   449c7265d60d4 ("vfs: add O_CREAT|O_DIRECTORY to open*(2)")
> 
> from the vfs-brauner tree and commit:
> 
>   16959c469f232 ("lsm: expose mount idmaps to inode hooks")
> 
> from the security tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.



> 
> diff --cc fs/namei.c
> index ca4f5e3be99ac,99f894f3f7e13..0000000000000
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@@ -4227,11 -4188,16 +4227,11 @@@ int vfs_create(struct mnt_idmap *idmap
>   		return -EACCES;	/* shouldn't it be ENOSYS? */
>   
>   	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> - 	error = security_inode_create(dir, dentry, mode);
> + 	error = security_inode_create(idmap, dir, dentry, mode);
>   	if (error)
>   		return error;
>  -	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
>  -	if (error)
>  -		return error;
>  -	error = dir->i_op->create(idmap, dir, dentry, mode);
>  -	if (!error)
>  -		fsnotify_create(dir, dentry);
>  -	return error;
>  +
>  +	return vfs_create_no_perm(idmap, dentry, mode, di);
>   }
>   EXPORT_SYMBOL(vfs_create);
>   
> @@@ -4368,21 -4328,7 +4368,21 @@@ static int may_o_create(struct mnt_idma
>   	if (error)
>   		return error;
>   
>  -	return security_inode_create(idmap, dir->dentry->d_inode, dentry, mode);
>  +	if (create_dir)
> - 		error = security_inode_mkdir(dir_inode, dentry, mode);
> ++		error = security_inode_mkdir(idmap, dir_inode, dentry, mode);
>  +	else
> - 		error = security_inode_create(dir_inode, dentry, mode);
> ++		error = security_inode_create(idmap, dir_inode, dentry, mode);
>  +
>  +	return error;
>  +}
>  +
>  +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
>  +		const struct inode *dir, int open_flag, umode_t mode)
>  +{
>  +	if (O_IS_MKDIR(open_flag))
>  +		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFDIR);
>  +	else
>  +		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
>   }
>   
>   /**

OK, doesn't look too bad. It's just that the struct mnt_idmap in now being passed
around, it looks like.

Thanks,
Jori.
