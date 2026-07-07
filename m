Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF53F54CC;
	Tue,  7 Jul 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422135; cv=none; b=I/49HpsPJhFyzcZdYypA5KaleumFo4oKIqOoBZpjyOOUBsfRRJmqiIJPwJZnqP2reX4CmHad0PvTp3gKvUQxBsgxKgBDdwQ1ZAq8XAdG3W11Q/2xooUiuJGwcLbL50ePlkuFsv3Mgx4Ur/7DMu2FMK3Wy8Lijoy2D56KZnY5BJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422135; c=relaxed/simple;
	bh=v7zg2qCQsTEo10UD+roP0qnbDkvm4NPLPvXdiuiUP/g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=aZxxHd6i4OcqS5jJw7iSkW5Du4lgyjkBOmhP3vRVUrwK4VCaz3HuRvyr8k8yBf/dD3HV1LRF0SWpapulL6u07Ekq53MU1wyzMdlsmMovW+WKB8gwhsci0BkQBuxf2Trd7ejm5o/osGTVkAsgDT9qHPXGl2KRn31I3460QSh9Wns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsgZiBer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsgZiBer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319711F000E9;
	Tue,  7 Jul 2026 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783422134;
	bh=ZZSMUzOXrzSnSc5a15tq3LDEwCotl56yX4e8egwm56U=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LsgZiBerlYXDzZCJeZfm/poKFwL/nWxwgiKopIDaOo1mp4s6b8JqcwMn5tZb7TQe3
	 yKEfEyCFn3xIvNTndPfQFTVDdIBuhN4EgGTX0U2iVl3F3l+CbyJAIR0rj+93s3sKZ3
	 FnUKWkYPi6tDe+nJm9mBw3K/n5cUMjUhAesc4gEeVo6w9rFqg6t2+xy1Axats23+8c
	 acG4MiNflcLJgmfE/6fKWpyhQrVePCZbFCAXHJffrOfjm6uo5vD7y+Na3ew0pq/dpk
	 7ZXjhmyA/Av5LO6WmhhVIyymKxaZBXpxmI8xtJQMr7zu+vKHMepUNyCOGRwpeMZLPL
	 5irBMvWgHhI7A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v4 2/3] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260705123826.3818443-3-jkoolstra@xs4all.nl>
References: <20260705123826.3818443-1-jkoolstra@xs4all.nl>
 <20260705123826.3818443-3-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 13:02:05 +0200
Message-Id: <20260707-werkvertrag-walzen-anteil-4aef3ab6e47f@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2985; i=brauner@kernel.org;
 h=from:subject:message-id; bh=v7zg2qCQsTEo10UD+roP0qnbDkvm4NPLPvXdiuiUP/g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53Nms2OlisytFlMtOYCNbzdIVDInRbicuyM6+1tKkp
 Nn2dP75jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncX8nwT2vV7E020/fb3y9v
 kN711yXscvoZDiZfnnmWi8OeeLG3HmZkmC+xJzja/u1cY3/JJRMWOIvz9+g6PJT84/uj+/WbdUZ
 P2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> highly problematic behaviour, because it leaves the receiver
> wondering what happened. As per man page MSG_CTRUNC is supposed to
> indicate that the control buffer was sized too short, but suddenly
> a permission error might result in the exact same flag being set.
> Moreover, the receiver has no chance to determine how many fds got
> originally sent and how many were suppressed.[1]
> 
> Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> truncating the message at the first blocked fd, keep every fd slot
> and store the LSM errno in the blocked slot.
> 
> [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
> +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> +		    bool notrunc)
> +{
> +	int error;
> +
> +	if (!ufd)
> +		return -EFAULT;
> +
> +	error = security_file_receive(f);
> +	if (error)
> +		return notrunc ? put_user(error, ufd) : error;
> +
> +	FD_PREPARE(fdf, flags, get_file(f));
> +	if (fdf.err)
> +		return fdf.err;
> +
> +	error = put_user(fd_prepare_fd(fdf), ufd);
> +	if (error)
> +		return error;
> +
> +	__receive_sock(fd_prepare_file(fdf));
> +	return fd_publish(fdf);
> +}

Seems good.

> +
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)
>  {
>  	struct cmsghdr __user *cm =
>  		(__force struct cmsghdr __user *)msg->msg_control_user;
> @@ -365,12 +389,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
>  		return;
>  
>  	if (msg->msg_flags & MSG_CMSG_COMPAT) {
> -		scm_detach_fds_compat(msg, scm);
> +		scm_detach_fds_compat(msg, scm, notrunc);
>  		return;
>  	}
>  
>  	for (i = 0; i < fdmax; i++) {
> -		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
> +		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
>  		if (err < 0)
>  			break;
>  	}
> @@ -542,8 +566,14 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
>  	if (!__scm_recv_common(sock->sk, msg, scm, flags))
>  		return;
>  
> -	if (scm->fp)
> -		scm_detach_fds(msg, scm);
> +	if (scm->fp) {
> +		struct unix_sock *u;
> +		bool notrunc;
> +
> +		u = unix_sk(sock->sk);
> +		notrunc = READ_ONCE(u->scm_rights_notrunc);
> +		scm_detach_fds(msg, scm, notrunc);

Minor nit: Really no need for the boolean. Would be enough to do:

scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc));

-- 
Christian Brauner <brauner@kernel.org>
