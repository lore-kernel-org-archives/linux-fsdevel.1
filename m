Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E053EC2F8
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057608; cv=none; b=vBhWiXkCgglYjkBqnl0VofsS44Wo6PHLWzrvfvKwZQllYB4+R2wRzK5Qkjy2MFW7O9PPKlt0Q623Zn2Effl9sI3ZL568PRtRL4DzI7JmGD4xPyYYmKd6Ao+OQbu6qxkhMAnJv/f7hVYz+Bzt8o31vqrX0/e3u27PXvXY+aRAxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057608; c=relaxed/simple;
	bh=gVM/d5SfAe6uHLAYzW7X9QBgcgocaO2VKDsMxwQpo0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkiGSAHutDgeJaFAlrk6fZJ7VmgCNpUNk61AeqQyL+jVCgT8azg+LA/VydrgFJW7bEM/L6qQn2H1UrtEJOC0XpPR2r+P2E1QXpsiwMVEtD3rYgzzZUe3/ir4GTS0fBIcoV8ufp5Fz0WoUG6gaGDINX191znA35VB3qrk1R4orMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikfFvchK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikfFvchK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784057606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOyx3Ss1GDlj0S08vrxO5V3zk5u0XYHPcKtfFy4rKzs=;
	b=ikfFvchK5wjbUTH5FcjxQLGv3iczNg2t8Q3Kkd1Wr5ofdVvHOYYCm/nOG0eh0Qzlw6f7MX
	eRl69NWLK+UoopzsSPhshhFUIr08etWvBmdQIzMWHKyI9TNS77jNAnkrWWZur6kWJgKLPk
	STLEpqGFYaIfrc8Tk+DR5M79LSSv+t4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-sWOUTYU9PceUFgeNZI6QoA-1; Tue,
 14 Jul 2026 15:33:22 -0400
X-MC-Unique: sWOUTYU9PceUFgeNZI6QoA-1
X-Mimecast-MFC-AGG-ID: sWOUTYU9PceUFgeNZI6QoA_1784057601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF8351956060;
	Tue, 14 Jul 2026 19:33:20 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 633F01955F7B;
	Tue, 14 Jul 2026 19:33:15 +0000 (UTC)
Date: Tue, 14 Jul 2026 15:33:12 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz
Subject: Re: [PATCH v2] audit: add FSOPEN record to log filesystem name
Message-ID: <alaO+HZ7qJ1Iv9SP@madcap2.tricolour.ca>
References: <20260703122548.1623981-2-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703122548.1623981-2-rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 2026-07-03 09:25, Ricardo Robaina wrote:
> Modern mount tools (util-linux >= 2.39.1) use the new mount API
> (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> syscall. The generic SYSCALL audit record logs the fsopen syscall but
> does not capture the filesystem name string, creating an audit gap for
> filesystem mount operations.
> 
> Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> name string passed to fsopen(2).
> 
>   type=SYSCALL ... : arch=x86_64 syscall=fsopen ... a1=FSOPEN_CLOEXEC
>   type=FSOPEN  ... : fs_name="tmpfs"
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/152
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
> Changes in v2:
> - Better placement of audit_log_fsopen() call to avoid UAF.
> 
>  fs/fsopen.c                |  3 +++
>  include/linux/audit.h      | 10 ++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           | 13 +++++++++++++
>  4 files changed, 27 insertions(+)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index ae19e5136598..70024870fefa 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/file.h>
>  #include <uapi/linux/mount.h>
> +#include <linux/audit.h>
>  #include "internal.h"
>  #include "mount.h"
>  
> @@ -134,6 +135,8 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
>  	if (IS_ERR(fs_name))
>  		return PTR_ERR(fs_name);
>  
> +	audit_log_fsopen(fs_name);
> +
>  	fs_type = get_fs_type(fs_name);
>  	kfree(fs_name);
>  	if (!fs_type)
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 45abb3722d30..077b2667180d 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -449,6 +449,7 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
>  			      enum audit_nfcfgop op, gfp_t gfp);
> +extern void __audit_log_fsopen(const char *fs_name);
>  
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -598,6 +599,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
>  		__audit_log_nfcfg(name, af, nentries, op, gfp);
>  }
>  
> +static inline void audit_log_fsopen(const char *fs_name)
> +{
> +	if (!audit_dummy_context())
> +		__audit_log_fsopen(fs_name);
> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -730,6 +737,9 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
>  				   enum audit_nfcfgop op, gfp_t gfp)
>  { }
>  
> +static inline void audit_log_fsopen(const char *fs_name)
> +{ }
> +
>  #define audit_n_rules 0
>  #define audit_signals 0
>  #endif /* CONFIG_AUDITSYSCALL */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index e8f5ce677df7..abae0524746e 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -122,6 +122,7 @@
>  #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
>  #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
>  #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
> +#define AUDIT_FSOPEN		1340	/* Record showing fsopen fs_name arg */
>  
>  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6610e667c728..c82fd5606de5 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2882,6 +2882,19 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
>  }
>  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
>  
> +void __audit_log_fsopen(const char *fs_name)
> +{
> +	struct audit_buffer *ab;
> +
> +	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_FSOPEN);
> +	if (!ab)
> +		return;
> +
> +	audit_log_format(ab, "fs_name=");
> +	audit_log_untrustedstring(ab, fs_name);
> +	audit_log_end(ab);
> +}
> +
>  static void audit_log_task(struct audit_buffer *ab)
>  {
>  	kuid_t auid, uid;
> -- 
> 2.53.0
> 
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

