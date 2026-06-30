Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BC407CC1
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821839; cv=none; b=VOWm8QeUrKgVDIEok0VrAsGv7P+ecqBVgsfFoe6tvAqqWIxoW5E0KNex4TR2/bRcbT9M36d/m98LsSSDGJSznQV5sAimujdvcGR4ms0vh4N/LAriDdGGtW+LOuMVprkZmIYm218GJ2lGfSyTkPFqg4Ak8LaF8KzixL9/6BL3iEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821839; c=relaxed/simple;
	bh=pVFWRdmduSXd0EI7LOQGs6oToijJeU2YlwTDktUqB6Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uhecjOI1F2fzLULTblBwZ8mi3XbpOBAfauOn4SnZaDTAP3ANPbuwVcxdTSHDuAuckRjMoy8dRvd0lTUySusH6BLTrqWM1WsQz++v3wQ6EzwuDpuSJv2kl82LHy9eJdr0jnOQkLeLdN8TV6404eV2L0s8JsRxR1BeoRTmq8LEr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=CX2oM8FO; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="CX2oM8FO"
X-KPN-MessageId: a0bcb971-747d-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a0bcb971-747d-11f1-a59f-005056994fde;
	Tue, 30 Jun 2026 14:17:14 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id a0bb8d43-747d-11f1-9b04-00505699693e;
	Tue, 30 Jun 2026 14:17:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=HoaUdutcVjzwLlkWs3t1/fLAplllrYSdfUovTEYFf/Y=;
	b=CX2oM8FOasD0LfV3NG0GB1BEtOiD5etbHQ102TrTCs2sdn1v5oZjpYfgXP2K+8/RNa0KZSkqeiS7Z
	 C7cALcGK9hTBDTsedhZF8GJ1koenP1tpFwxr7Bw31ELas6lyKmycYiXwWKo0OHN7WbX3bVQoAYyTLJ
	 IlYGxzT5baFjdqPy8pewhUXe3twRzF4zWyT1mkxvI2B7BtKSjjarp0a3ABeDsHhq1d5sXvgeY0GUIv
	 5aS+kp1VdCZ5qTE0fLCQhY4DSmiOXSIlOzZR8qo4x/qAU0SOTd8HIe8VXW3Sf39BURsoleV0OYPZG8
	 T1vDwajXGn7LRj187TIRlJ1pVk3JNRQ==
X-KPN-MID: 33|OFYpm1P/Nt8SYcBlYsmaTYPF0qERzll8sV44nr1wrEwv67WCimJpjCHdRix9Bgq
 eFOVIbIJJTMgaVKU/aaBroU+a/AOj08YJYFo9cdM8Ec4=
X-CMASSUN: 33|OrooBAzrv2xmU0EZVbA0G0ujgPElX0jqUXaNl7wbv+rPuDBb+5DvFwarGO7uX0S
 M5qNHL3Z8Itq/9C6FeSXZog==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id a0abbb1e-747d-11f1-8edb-00505699eff2;
	Tue, 30 Jun 2026 14:17:14 +0200 (CEST)
Date: Tue, 30 Jun 2026 14:17:14 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <158151977.3525022.1782821834050@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260630-getoppt-granit-gekrochen-78244e8979d9@brauner>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
 <20260629194327.2270798-4-jkoolstra@xs4all.nl>
 <20260630-getoppt-granit-gekrochen-78244e8979d9@brauner>
Subject: Re: [PATCH net-next v3 3/5] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
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


> Op 30-06-2026 11:58 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> > Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> > receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> > that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> > highly problematic behaviour, because it leaves the receiver
> > wondering what happened. As per man page MSG_CTRUNC is supposed to
> > indicate that the control buffer was sized too short, but suddenly
> > a permission error might result in the exact same flag being set.
> > Moreover, the receiver has no chance to determine how many fds got
> > originally sent and how many were suppressed.[1]
> > 
> > Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> > handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> > truncating the message at the first blocked fd, keep every fd slot
> > and store the LSM errno in the blocked slot.
> > 
> > [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> >
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index 34f53dde65ce..bb1b3dee02e8 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -49,6 +49,7 @@ struct unix_sock {
> >  	struct scm_stat		scm_stat;
> >  	int			inq_len;
> >  	bool			recvmsg_inq;
> > +	bool			scm_rights_notrunc;
> >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> >  	struct sk_buff		*oob_skb;
> >  #endif
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index c52519669349..761cda0803fb 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -50,8 +50,8 @@ struct scm_cookie {
> >  #endif
> >  };
> >  
> > -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> > -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
> > +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
> > +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
> >  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
> >  void __scm_destroy(struct scm_cookie *scm);
> >  struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
> > @@ -108,11 +108,18 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
> >  		   struct scm_cookie *scm, int flags);
> >  
> >  static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> > -				  unsigned int flags)
> > +				  unsigned int flags, bool notrunc)
> >  {
> > +	bool filtered;
> > +	int error;
> > +
> >  	if (!ufd)
> >  		return -EFAULT;
> > -	return receive_fd(f, ufd, flags);
> > +
> > +	error = receive_fd_filtered(f, ufd, flags, &filtered);
> > +	if (filtered && notrunc)
> > +		return put_user(error, ufd);
> 
> This helper makes no sense to me. The boolean return argument is just
> really nasty and you need an additional put_user() as well. At this
> point, just drop receive_fd() and open-code it instead of using another
> custom helper. Something like the completely untested:
> 

It's not very pretty no. I thought about several different options but they
all kinda suck.

You could override the error returned from the LSM to -EACCES. Since nothing
else in receive_fd() produces this, if you get it you can be sure that you had
an LSM fd block. However, this masks the real returned error and is also a bit
fragile if receive_fd() does ever return -EACCES in another path (unlikely but still).
You can also signal blocking by setting the ufd to the security_file_receive() error
no matter the socket option. But this does change userspace.

But open-coding might be a better idea.

I also choose to not put -EPERM as sentinel as suggested first, but use the
actual LSM error. Agreed?


> diff --git a/include/net/scm.h b/include/net/scm.h
> index 761cda0803fb..171b5ccd0b77 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -116,10 +116,22 @@ static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
>         if (!ufd)
>                 return -EFAULT;
> 
> -       error = receive_fd_filtered(f, ufd, flags, &filtered);
> -       if (filtered && notrunc)
> -               return put_user(error, ufd);
> -       return error;
> +       error = security_file_receive(file);
> +       if (error)
> +               return notrunc ? put_user(error, ufd) : error;
> +
> +       FD_PREPARE(fdf, flags, f);
> +       if (fdf.err)
> +               return fdf.err;
> +       get_file(f);
> +
> +       error = put_user(fd_prepare_fd(fdf), ufd);
> +       if (error)
> +               return error;
> +
> +       __receive_sock(f);
> +       return fd_publish(fdf);
>  }
> 
> -- 
> Christian Brauner <brauner@kernel.org>
