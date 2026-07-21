Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996183E5A03
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672352; cv=none; b=Lle0856WyMx1BxViIQ+WoKPgbvmrfJhUL0OvtT/GXZhnF13VWjRiQdvOrVtx6DVIh4aKBctPpqfzW+YTe74fovDnvXhCSLi2U+DgkJ3z92UGV/SorgSfo++NYsfEEHf1XeAE8+wGgVvq69gjR+l/lOR14JNX0eqlTWvlb1az/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672352; c=relaxed/simple;
	bh=mFicWt8aljInn2brndV6GeUi5W3rCzOm8ugvkdiJ0FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFAEEh56RZdXrzoLJSeDHU+GzoqNHlZDiAY6dU2GsX430uS76Q3o/pNiVufFUEb6i9e7itptjixyGpSFSnvwxo63bq2m5/bjpoeImN4tke3QJNzYnlslvILUbDwOqjF++P5E+OO5BYI2QbPw1FWm6Bqgd4NCJfOcVgbBWfxdRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiWJSzYz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiWJSzYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784672349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPXEp+EfITlWhZAB6Di0vMxuPC1WvdgC2PfXnEXo3Bs=;
	b=UiWJSzYzbcsn7O8CnvyNfNZPb2zubtM6MYBTZv4NsmBRi15H6GTgFcDps46JAwPrfVrWAf
	vNPm50INJaxkneZxBj3QWaD/k4pjbX0LsOvabMP4HOUg4wdRXJ3drVYy0bNriiyvo8/7cu
	f4CSExA6ZJoJm5Kl1WEmv19iEIGepQA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-W1GBf-SfOSuXR1PCiT9nHw-1; Tue,
 21 Jul 2026 18:17:58 -0400
X-MC-Unique: W1GBf-SfOSuXR1PCiT9nHw-1
X-Mimecast-MFC-AGG-ID: W1GBf-SfOSuXR1PCiT9nHw_1784672276
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38D80195FD25;
	Tue, 21 Jul 2026 22:17:56 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF90118008F7;
	Tue, 21 Jul 2026 22:17:53 +0000 (UTC)
Date: Tue, 21 Jul 2026 18:17:51 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, sgrubb@redhat.com
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount
 relocation
Message-ID: <al/wD4wI4SbSalTa@madcap2.tricolour.ca>
References: <20260713170035.4073532-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713170035.4073532-1-rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 2026-07-13 14:00, Ricardo Robaina wrote:
> Modern mount tools (util-linux >= 2.39.1) use the new mount API
> (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> syscall. The generic SYSCALL audit record logs the move_mount syscall
> but does not capture the flags argument, creating an audit gap for
> mount relocation operations.
> 
> Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
> to move_mount(2). Pathnames and file descriptors are captured through
> existing PATH records and SYSCALL record arguments.
> 
>  ----
>  type=PATH : item=0 name=/mnt/test_src inode=1 dev=00:41 ...
>  type=SYSCALL : arch=x86_64 syscall=move_mount ...
>  type=MOVE_MOUNT : fs_flags=0x4
>  ----
>  type=PATH : item=0 name=/mnt/test_dst inode=27460862 dev=fc:00 ...
>  type=SYSCALL : arch=x86_64 syscall=move_mount ...
>  type=MOVE_MOUNT : fs_flags=0x4
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/152
> Link: https://github.com/linux-audit/audit-kernel/issues/153
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  fs/namespace.c             |  3 +++
>  include/linux/audit.h      | 10 ++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           | 13 +++++++++++++
>  4 files changed, 27 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 3d5cd5bf3b05..a6b0286744d9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -34,6 +34,7 @@
>  #include <linux/mnt_idmapping.h>
>  #include <linux/pidfs.h>
>  #include <linux/nstree.h>
> +#include <linux/audit.h>
>  
>  #include "pnode.h"
>  #include "internal.h"
> @@ -4625,6 +4626,8 @@ SYSCALL_DEFINE5(move_mount,
>  	if (flags & MOVE_MOUNT_F_EMPTY_PATH)
>  		uflags = AT_EMPTY_PATH;
>  
> +	audit_log_move_mount(flags);
> +
>  	CLASS(filename_maybe_null,from_name)(from_pathname, uflags);
>  	if (!from_name && from_dfd >= 0) {
>  		CLASS(fd_raw, f_from)(from_dfd);
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 45abb3722d30..d1dc4035cb3c 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -449,6 +449,7 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
>  			      enum audit_nfcfgop op, gfp_t gfp);
> +extern void __audit_log_move_mount(unsigned int flags);
>  
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -598,6 +599,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
>  		__audit_log_nfcfg(name, af, nentries, op, gfp);
>  }
>  
> +static inline void audit_log_move_mount(unsigned int flags)
> +{
> +	if (!audit_dummy_context())
> +		__audit_log_move_mount(flags);
> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -730,6 +737,9 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
>  				   enum audit_nfcfgop op, gfp_t gfp)
>  { }
>  
> +static inline void audit_log_move_mount(unsigned int flags)
> +{ }
> +
>  #define audit_n_rules 0
>  #define audit_signals 0
>  #endif /* CONFIG_AUDITSYSCALL */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index e8f5ce677df7..40abf3dfd307 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -122,6 +122,7 @@
>  #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
>  #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
>  #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
> +#define AUDIT_MOVE_MOUNT	1342	/* Record showing move_mount flags */
>  
>  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6610e667c728..4aca04d33d00 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2882,6 +2882,19 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
>  }
>  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
>  
> +void __audit_log_move_mount(unsigned int flags)
> +{
> +	struct audit_buffer *ab;
> +
> +	ab = audit_log_start(audit_context(), GFP_KERNEL,
> +			     AUDIT_MOVE_MOUNT);
> +	if (!ab)
> +		return;
> +
> +	audit_log_format(ab, "fs_flags=0x%x", flags);
> +	audit_log_end(ab);
> +}
> +
>  static void audit_log_task(struct audit_buffer *ab)
>  {
>  	kuid_t auid, uid;
> -- 
> 2.53.0

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

