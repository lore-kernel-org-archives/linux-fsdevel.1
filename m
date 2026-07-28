Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3046F4B8
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270847; cv=none; b=TidtOZJcxThhIIYNq7/BDLqwKOumsPFxt4bwM1/DXe7YoWp9jHGjjR4BJ2hbdpTeFovsuB8nLLy5R9oOCjPYIK5ajEag/dN+HFpG0bOIWaiB8RFmsf4STzZ9vL9GHgEk5vH4zggHxejuiUYG1pgbmrKHJV68txQwgsLM/K3z5bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270847; c=relaxed/simple;
	bh=OskdLpIbABB2AmTd1ojCfz6jwFlku/RgfQmsOH0bjwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGX1r+DbSDadAZqNMKofoP8ppgQsYnJ5Di3wVowkw4aXKR96MN+6lguUlSNy2gn9kLYlQ27cYR4TO81kKkmOiar8lwfK1E7u2+O64rorPB51CYIzdVsUd9I/cwx6FEJQo/PMlZfzjSGCU0JRme5LB3oLVuKqkEMikYTVN2n5wWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7tAVN48; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7tAVN48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785270844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NadbsigzlfpEpTT1POIr4Z/BIVqOZxQfrFeEDio9Ik4=;
	b=P7tAVN48GJrlVFSBKu8iI3ZRW6HxETlRhsZGRKSqmBDe9WJbwrgPY7PT5ZEAZaAqgLnMh0
	YF1HsNDuqdBX6mE/B+916f1woa+0JYIJ/g/aRzVbTOz1U2qLfxLHhoTwnUVx237sukIaTa
	ODPAsSHnGgrnvP7tpa5cgPOKn1AKUr4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-vUphpVblPqWsFFmnst8d6A-1; Tue,
 28 Jul 2026 16:34:00 -0400
X-MC-Unique: vUphpVblPqWsFFmnst8d6A-1
X-Mimecast-MFC-AGG-ID: vUphpVblPqWsFFmnst8d6A_1785270839
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5405918002C3;
	Tue, 28 Jul 2026 20:33:59 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.2])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B47F414;
	Tue, 28 Jul 2026 20:33:56 +0000 (UTC)
Date: Tue, 28 Jul 2026 16:33:53 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, sgrubb@redhat.com
Subject: Re: [PATCH v2] audit: add FSCONFIG auxiliary record to log
 filesystem configuration
Message-ID: <amkSMbeRoW66rxO5@madcap2.tricolour.ca>
References: <20260727173710.964626-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727173710.964626-1-rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 2026-07-27 14:37, Ricardo Robaina wrote:
> Modern mount tools (util-linux >= 2.39.1) use the new mount API
> (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> syscall. The generic SYSCALL audit record logs the fsconfig syscall but
> does not capture the configuration parameters, creating an audit gap for
> critical mount information such as the device being mounted.
> 
> Add an FSCONFIG auxiliary record that logs the command type, parameter
> name (key), parameter value, and aux parameter passed to fsconfig(2).
> 
>  ----
>  type=SYSCALL : syscall=fsconfig ... a1=FSCONFIG_SET_STRING ...
>  type=FSCONFIG : fs_cmd=1 fs_key=source fs_val="tmpfs" fs_aux=0
>  ----
>  type=SYSCALL : syscall=fsconfig ... a1=FSCONFIG_CMD_CREATE ...
>  type=FSCONFIG : fs_cmd=6 fs_key=(null) fs_val=(null) fs_aux=0
>  ----
>  type=SYSCALL : syscall=fsconfig ... a1=FSCONFIG_SET_BINARY ...
>  type=FSCONFIG : fs_cmd=2 fs_key=hidepid fs_val="<binary>" fs_aux=4
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/153
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
> Changes in v2:
> - Fixed null-check for fs_key field.
> - Clarified trimmed SYSCALL output in commit message examples. 
> 
>  fs/fsopen.c                |  7 +++++++
>  include/linux/audit.h      | 13 +++++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index ae19e5136598..9b3c02f59df4 100644
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
> @@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
>  	struct fs_context *fc;
>  	int ret;
>  	int lookup_flags = 0;
> +	const char *value_str = NULL;
>  
>  	struct fs_parameter param = {
>  		.type	= fs_value_is_undefined,
> @@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
>  			goto out_key;
>  		}
>  		param.size = strlen(param.string);
> +		value_str = param.string;
>  		break;
>  	case FSCONFIG_SET_BINARY:
>  		param.type = fs_value_is_blob;
> @@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
>  			ret = PTR_ERR(param.blob);
>  			goto out_key;
>  		}
> +		value_str = "<binary>";
>  		break;
>  	case FSCONFIG_SET_PATH_EMPTY:
>  		lookup_flags = LOOKUP_EMPTY;
> @@ -445,6 +449,7 @@ SYSCALL_DEFINE5(fsconfig,
>  		}
>  		param.dirfd = aux;
>  		param.size = strlen(param.name->name);
> +		value_str = param.name->name;
>  		break;
>  	case FSCONFIG_SET_FD:
>  		param.type = fs_value_is_file;
> @@ -458,6 +463,8 @@ SYSCALL_DEFINE5(fsconfig,
>  		break;
>  	}
>  
> +	audit_log_fsconfig(cmd, param.key, value_str, aux);
> +
>  	ret = mutex_lock_interruptible(&fc->uapi_mutex);
>  	if (ret == 0) {
>  		ret = vfs_fsconfig_locked(fc, cmd, &param);
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 45abb3722d30..978eb881974c 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -449,6 +449,8 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
>  			      enum audit_nfcfgop op, gfp_t gfp);
> +extern void __audit_log_fsconfig(unsigned int cmd, const char *key,
> +				 const char *value, int aux);
>  
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -598,6 +600,13 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
>  		__audit_log_nfcfg(name, af, nentries, op, gfp);
>  }
>  
> +static inline void audit_log_fsconfig(unsigned int cmd, const char *key,
> +				      const char *value, int aux)
> +{
> +	if (!audit_dummy_context())
> +		__audit_log_fsconfig(cmd, key, value, aux);
> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -730,6 +739,10 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
>  				   enum audit_nfcfgop op, gfp_t gfp)
>  { }
>  
> +static inline void audit_log_fsconfig(unsigned int cmd, const char *key,
> +				      const char *value, int aux)
> +{ }
> +
>  #define audit_n_rules 0
>  #define audit_signals 0
>  #endif /* CONFIG_AUDITSYSCALL */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index e8f5ce677df7..5cd0eb602528 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -122,6 +122,7 @@
>  #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
>  #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
>  #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
> +#define AUDIT_FSCONFIG		1341	/* Record showing fsconfig args */
>  
>  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6610e667c728..fefc5c5dd4aa 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2882,6 +2882,33 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
>  }
>  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
>  
> +void __audit_log_fsconfig(unsigned int cmd, const char *key,
> +			  const char *value, int aux)
> +{
> +	struct audit_buffer *ab;
> +
> +	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_FSCONFIG);
> +	if (!ab)
> +		return;
> +
> +	audit_log_format(ab, "fs_cmd=%u", cmd);
> +	audit_log_format(ab, " fs_key=");
> +	if (key)
> +		audit_log_untrustedstring(ab, key);
> +	else
> +		audit_log_format(ab, "(null)");
> +
> +	audit_log_format(ab, " fs_val=");
> +	if (value)
> +		audit_log_untrustedstring(ab, value);
> +	else
> +		audit_log_format(ab, "(null)");
> +
> +	audit_log_format(ab, " fs_aux=%d", aux);
> +
> +	audit_log_end(ab);
> +}
> +
>  static void audit_log_task(struct audit_buffer *ab)
>  {
>  	kuid_t auid, uid;
> -- 
> 2.53.0
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

