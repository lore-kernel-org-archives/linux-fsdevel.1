Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B283911DD
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559793; cv=none; b=pBFSUnR69OfnaHre6ZkfopODD7YTXVPi39mlgjqcnCSPfYx8IKscDHA9GqndevZHA7eGhRUasVZX0oehOD9OYMGrR46yhR4uBv1ArF8zebz+3S8nDXdrDZ5Qk40Bic8uVDyjOlcwQz1zWTFKDG3BVXSrmX32gYacWq62ASLlO9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559793; c=relaxed/simple;
	bh=Pd5Sl5AzbTXa6b5twhmEGn5bGEIv3/Sb3U2ADM9N3Ow=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CVDjM48fPxR0CQNuk+lCE9GN2PUMWVa11v8ytubCir+iH/194jK3Df22SADbJ8yQ3v/qoZTdanDdFIb6iwWqm8XBqgN7KFWnMqGftEqcODLAjIfsMowx8sjTB3Xabcb6fnmvm+gqhdUSH97jZ8x2KDPsdDWS2N+R/TNks7H8lWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=asmf0tCX; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="asmf0tCX"
X-KPN-MessageId: 2f143246-6903-11f1-beab-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2f143246-6903-11f1-beab-005056992ed3;
	Mon, 15 Jun 2026 23:43:02 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 2f132e56-6903-11f1-b5d6-0050569981f5;
	Mon, 15 Jun 2026 23:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=DSCLhqtg8yDsV4guDYrCxhWCyf30kEWOPtpSgHo5VhA=;
	b=asmf0tCXYjDMEtPq9XoXJcS8wTaJ9YBsbdkZtzsr3IRqS6YZmWKBgVfZv5ymIbROtRHYh/a1qLXeZ
	 ES1MUtQFY4nHpKo7ANzQ8RnmJYoabkx3voCt6AZneP1Md69zCKGZN27rAFi3koz77P725Rc3KL2ywO
	 N9yy+gx1I0JH1aMiEFZyfpfF5ccE878z64Kwm1KnAWjTal3Lb7+eD9XFML2LtXISuZGSK0x/+959Oh
	 Xhg5yl7lszB4y/Af6q2rO6sJffelcNKArt0RF+7lEPSOsHCouQkv8xIBhDbLnEnTS4oblCq9e4rnmq
	 2GmkeOw0AVRi57Jzjomf/WegooNrJmw==
X-KPN-MID: 33|t1FEEscCGf3xSeKblJw44ZcyvX0nxy8paq8KRTC2fmfuzqEB/z7WSGga3l/UKMP
 qJuideIvjr5KbqwrHbpaN1gNOsReWKjBcF8icrht+sN4=
X-CMASSUN: 33|Ge3DvZ22tlCZ/jKrY+INnqi93GZ8Dchw17P/uyFN8anWnHlBdSgqt3WZbW4IElB
 LoHyfWsKk2JoJ42BShfq0uQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 2f078835-6903-11f1-b8d7-005056995d6c;
	Mon, 15 Jun 2026 23:43:02 +0200 (CEST)
Date: Mon, 15 Jun 2026 23:43:01 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>,
	Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	"audit@vger.kernel.org" <audit@vger.kernel.org>
Message-ID: <526417482.1849950.1781559782000@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260614164438.2980769-5-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
 <20260614164438.2980769-5-jkoolstra@xs4all.nl>
Subject: Re: [PATCH 04/12] fs/namei.c: lookup_open(): move
 audit_inode_child() up
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
> In the mknod(2) path of calling vfs_create() we call audit_inode_child()
> before permission checks in may_create_dentry() (but after path-based
> LSM check). Copy this behaviour to lookup_open() and move
> audit_inode_child() to may_o_create().
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 6bf1ded26377..a4a8cdbb48e2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4345,6 +4345,8 @@ static int may_o_create(struct mnt_idmap *idmap,
>  	if (error)
>  		return error;
>  
> +	audit_inode_child(dir->dentry->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> +
>  	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
>  		return -EOVERFLOW;
>  
> @@ -4532,7 +4534,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  			goto out_dput;
>  
>  		file->f_mode |= FMODE_CREATED;
> -		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
>  		if (!dir_inode->i_op->create) {
>  			error = -EACCES;
>  			goto out_dput;
> -- 
> 2.54.0

CC, audit@vger.kernel.org

Went too quick with this one... audit_inode_child() probably shouldn't be called
if we are in the lookup case. So there isn't really a way to do this exactly
symmetrical to the vfs_create()/vfs_mkdir() paths.

But certainly the current implementation is also wrong. In the atomic_open case
audit_inode_child() is called only once (in the final fsnotify call in
open_last_lookups()), but in the regular ->create case audit_inode_child() is
called twice.

What behavior is actually wanted here?
