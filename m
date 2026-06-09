Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17F40D57F
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044026; cv=none; b=qLYqLQ1rez+e4ysAcMEvRWQ+p1FE15W5oS98I5DCNUPcXkO7nI5s321CYtee1TSSacLjm92wxUrydUEwUHYdVSxsCjBsTaX6dMV2NLtSH9NYlC5/RvSrYexqSMykqzD/md1oI1gRnH09TDaXWid3Qg1iPzA7/vQC0Orf6mCWO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044026; c=relaxed/simple;
	bh=kLovsygXZ41YdWzidjZ64FJs81003+GprnfEqKdvo80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRaDibTHK++09mXon8yog6WdinhJFOR2Yl0tpyCFIuoXo64MlfFvdAAWRlzXUs3ksIeT1OkHhue4vohRu9GN85HTkJywwpvm6tjqXJxONC95ePQQ4+9yTMLCUeHUR8spSxGGO88eSJZ6/psP3DMwY8VYkH1arzypZqPjzM2tvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B40EE1C2CAE;
	Tue,  9 Jun 2026 22:26:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 8B34720027;
	Tue,  9 Jun 2026 22:26:56 +0000 (UTC)
Date: Tue, 9 Jun 2026 18:26:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>, Tyler
 Hicks <code@tyhicks.com>, Namjae Jeon <linkinjeon@kernel.org>, Andreas
 Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 1/6] tracefs: use d_splice_alias() in ->lookup()
 instances
Message-ID: <20260609182655.3a907b49@fedora>
In-Reply-To: <20260606064956.2722874-2-viro@zeniv.linux.org.uk>
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
	<20260606064956.2722874-2-viro@zeniv.linux.org.uk>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 8B34720027
X-Stat-Signature: 986c83yj5a5dtpwxuhmxcyd3yk8d39s9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/TuVW8g9P1QCWmmFCSiV8I8u9Ifai5DNg=
X-HE-Tag: 1781044016-563766
X-HE-Meta: U2FsdGVkX1/781rMT79nrKWTewcbFdmBThtmmgFvdVm/d8974T7LUkvqSbplu9pt9QP50KnP9Fi+mRzqr1dpy1Ub4EUSjT2RwQveg2lXlMKUsm63KqwbjOtJWLkwnzTM0DmGYsC79ZXJteHyY7ZL2niLxrL0sVc2xMUqF2UB6CQQcLmpIu4Zis0SzKBBhGFNlY3QS6a53cJVvB1p7gQ1MW7yo6UMFS9jwwTEesMbkU6Afquwj8O+2wv19Wya0OKWeQnlMRFkSCRC5W75T5zLpEFwMEDHnIrRnQNNLukUYO4+g+XeS5FcxaeMzWIy5L583corLO8PysPBL3mYJ6NR67m2/ZQdHsSD59g59gl3N+Vi220BhrC20TBv5HO6MKSysKehVAFxbRkI/OCI9jvtD1AtpPO2S3E2HSGO7P9nCy7JErTqILKWPe25bSDT1Zqa

On Sat,  6 Jun 2026 07:49:51 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> d_add() is not wrong there (inodes are freshly allocated), but
> d_splice_alias() is more idiomatic.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

This looks fine to me, but I haven't tested it. But anyway:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> ---
>  fs/tracefs/event_inode.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 26b6453de30e..39c7a34531e8 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -389,8 +389,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
>  	// Files have their parent's ei as their fsdata
>  	dentry->d_fsdata = get_ei(parent_ei);
>  
> -	d_add(dentry, inode);
> -	return NULL;
> +	return d_splice_alias(inode, dentry);
>  };
>  
>  /**
> @@ -420,8 +419,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
>  
>  	dentry->d_fsdata = get_ei(ei);
>  
> -	d_add(dentry, inode);
> -	return NULL;
> +	return d_splice_alias(inode, dentry);
>  }
>  
>  static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char *name)

