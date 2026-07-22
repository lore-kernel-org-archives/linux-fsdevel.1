Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A533B96B
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726542; cv=none; b=XkMWDIAmBX5IwLQUNGMR9e343X10YJDgu4AF7F76MgQEFHx8w4AndQG6kF9QlIk1dClrrgjNuGgyX6gO7nIg0uMMqm8GN1Jr8/xg2RLq4VYOn7YgRgJ/Gh4jGq/V6hgJ7bC0p6FEnm21ZTEHA48th4s+i8QXAnMsQcU3my+ZIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726542; c=relaxed/simple;
	bh=gb7ddQHiT+tMQ0lfH+mGwqPhC5v4sQB5i18+U/GNU+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/m3mP9jx4DkFC4B1OPBdQBvzWNnLpaOnlGBFSovAJEpT7yEwPp42NGAnU5j06FzbCE1SJwbyijkx5TufXQTPdjCZvLeF7d5SniHkp32mUVipWxzi02D8phkOELmJ155aeHunQL3+JOmWj+8AZUDMlUdIoWOhnfKKOJ1higmIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjEKma9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjEKma9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784726539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feEVvExtCwbDdg7aSX8cuuWXWuzFoLtfoMT1v05EBhU=;
	b=QjEKma9BIpH/xqhi+XkxisLsvIjzP5Pt6xd92Y2VtUnVK9Quf/Ca1eremYqj3fDO1i/8uh
	FWF+xoAY8T8GIyZpGAIYRWigvf48JDQJxGZzxbAcf9fRVFj1DMRn62rBdGCFBKmaeu+LP4
	rMaEWtEFxa6jJr7+1H7NzqtOXOUz0zY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-O3z-pCoTM_20hCLgVKA5sA-1; Wed,
 22 Jul 2026 09:22:16 -0400
X-MC-Unique: O3z-pCoTM_20hCLgVKA5sA-1
X-Mimecast-MFC-AGG-ID: O3z-pCoTM_20hCLgVKA5sA_1784726534
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5440518002C3;
	Wed, 22 Jul 2026 13:22:14 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.58.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27FF51955D88;
	Wed, 22 Jul 2026 13:22:12 +0000 (UTC)
Date: Wed, 22 Jul 2026 09:22:09 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, sgrubb@redhat.com
Subject: Re: [PATCH] audit: add FSCONFIG auxiliary record to log filesystem
 configuration
Message-ID: <amDEAQD1Wb5HHWe6@madcap2.tricolour.ca>
References: <20260713170013.4073499-1-rrobaina@redhat.com>
 <al/wQsmHmVMSo+RH@madcap2.tricolour.ca>
 <CAABTaaBP3g-np2MhYHebiQpGHFpTe6Z_itqvt2qu9hsymkbHCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABTaaBP3g-np2MhYHebiQpGHFpTe6Z_itqvt2qu9hsymkbHCw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 2026-07-22 10:05, Ricardo Robaina wrote:
> On Tue, Jul 21, 2026 at 7:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > On 2026-07-13 14:00, Ricardo Robaina wrote:
> > > Modern mount tools (util-linux >= 2.39.1) use the new mount API
> > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > > syscall. The generic SYSCALL audit record logs the fsconfig syscall but
> > > does not capture the configuration parameters, creating an audit gap for
> > > critical mount information such as the device being mounted.
> > >
> > > Add an FSCONFIG auxiliary record that logs the command type, parameter
> > > name (key), parameter value, and aux parameter passed to fsconfig(2).
> > >
> > >  ----
> > >  type=SYSCALL : syscall=fsconfig a1=FSCONFIG_SET_STRING ...
> >
> > This looks like it is missing "a0=..."?
> >
> > >  type=FSCONFIG : fs_cmd=1 fs_key=source fs_val="tmpfs" fs_aux=0
> > >  ----
> > >  type=SYSCALL : syscall=fsconfig a1=FSCONFIG_CMD_CREATE ...
> >
> > This looks like it is missing "a0=..."?
> > I'm guessing this isn't actually real test output?
> >
> 
> Thanks for reviewing this patch, Richard!
> 
> That's real test output; I just trimmed the SYSCALL record output to
> fit in the commit message. Since this patch does not touch this
> record, I don't see a problem. I can
> add a0=... for consistency if you prefer, though.

Consistent use of ... would help to clarify that.

> > >  type=FSCONFIG : fs_cmd=6 fs_key=(null) fs_val=(null) fs_aux=0
> >
> > Was there a fs_key output here that didn't make it due to the issue below?
> 
> Actually, in this case, the test result happened to be right (that's
> why I missed it).
> FSCONFIG_CMD_CREATE has no key or value, so both are NULL[1].

Yup, fair, had to ask.  :-)

> [1] https://man7.org/linux/man-pages/man2/fsconfig.2.html
> 
> > >  ----
> > >  type=SYSCALL : syscall=fsconfig a0=0x4 a1=FSCONFIG_SET_BINARY ...
> > >  type=FSCONFIG : fs_cmd=2 fs_key=hidepid fs_val="<binary>" fs_aux=4
> > >
> > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > ---
> > >  fs/fsopen.c                |  7 +++++++
> > >  include/linux/audit.h      | 13 +++++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
> > >  4 files changed, 48 insertions(+)
> > >
> > > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > > index ae19e5136598..9b3c02f59df4 100644
> > > --- a/fs/fsopen.c
> > > +++ b/fs/fsopen.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/namei.h>
> > >  #include <linux/file.h>
> > >  #include <uapi/linux/mount.h>
> > > +#include <linux/audit.h>
> > >  #include "internal.h"
> > >  #include "mount.h"
> > >
> > > @@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >       struct fs_context *fc;
> > >       int ret;
> > >       int lookup_flags = 0;
> > > +     const char *value_str = NULL;
> > >
> > >       struct fs_parameter param = {
> > >               .type   = fs_value_is_undefined,
> > > @@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >                       goto out_key;
> > >               }
> > >               param.size = strlen(param.string);
> > > +             value_str = param.string;
> > >               break;
> > >       case FSCONFIG_SET_BINARY:
> > >               param.type = fs_value_is_blob;
> > > @@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >                       ret = PTR_ERR(param.blob);
> > >                       goto out_key;
> > >               }
> > > +             value_str = "<binary>";
> > >               break;
> > >       case FSCONFIG_SET_PATH_EMPTY:
> > >               lookup_flags = LOOKUP_EMPTY;
> > > @@ -445,6 +449,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >               }
> > >               param.dirfd = aux;
> > >               param.size = strlen(param.name->name);
> > > +             value_str = param.name->name;
> > >               break;
> > >       case FSCONFIG_SET_FD:
> > >               param.type = fs_value_is_file;
> > > @@ -458,6 +463,8 @@ SYSCALL_DEFINE5(fsconfig,
> > >               break;
> > >       }
> > >
> > > +     audit_log_fsconfig(cmd, param.key, value_str, aux);
> > > +
> > >       ret = mutex_lock_interruptible(&fc->uapi_mutex);
> > >       if (ret == 0) {
> > >               ret = vfs_fsconfig_locked(fc, cmd, &param);
> > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > index 45abb3722d30..978eb881974c 100644
> > > --- a/include/linux/audit.h
> > > +++ b/include/linux/audit.h
> > > @@ -449,6 +449,8 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
> > >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> > >  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
> > >                             enum audit_nfcfgop op, gfp_t gfp);
> > > +extern void __audit_log_fsconfig(unsigned int cmd, const char *key,
> > > +                              const char *value, int aux);
> > >
> > >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> > >  {
> > > @@ -598,6 +600,13 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
> > >               __audit_log_nfcfg(name, af, nentries, op, gfp);
> > >  }
> > >
> > > +static inline void audit_log_fsconfig(unsigned int cmd, const char *key,
> > > +                                   const char *value, int aux)
> > > +{
> > > +     if (!audit_dummy_context())
> > > +             __audit_log_fsconfig(cmd, key, value, aux);
> > > +}
> > > +
> > >  extern int audit_n_rules;
> > >  extern int audit_signals;
> > >  #else /* CONFIG_AUDITSYSCALL */
> > > @@ -730,6 +739,10 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
> > >                                  enum audit_nfcfgop op, gfp_t gfp)
> > >  { }
> > >
> > > +static inline void audit_log_fsconfig(unsigned int cmd, const char *key,
> > > +                                   const char *value, int aux)
> > > +{ }
> > > +
> > >  #define audit_n_rules 0
> > >  #define audit_signals 0
> > >  #endif /* CONFIG_AUDITSYSCALL */
> > > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > > index e8f5ce677df7..5cd0eb602528 100644
> > > --- a/include/uapi/linux/audit.h
> > > +++ b/include/uapi/linux/audit.h
> > > @@ -122,6 +122,7 @@
> > >  #define AUDIT_OPENAT2                1337    /* Record showing openat2 how args */
> > >  #define AUDIT_DM_CTRL                1338    /* Device Mapper target control */
> > >  #define AUDIT_DM_EVENT               1339    /* Device Mapper events */
> > > +#define AUDIT_FSCONFIG               1341    /* Record showing fsconfig args */
> > >
> > >  #define AUDIT_AVC            1400    /* SE Linux avc denial or grant */
> > >  #define AUDIT_SELINUX_ERR    1401    /* Internal SE Linux Errors */
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index 6610e667c728..222bf79ee9bd 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -2882,6 +2882,33 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
> > >  }
> > >  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
> > >
> > > +void __audit_log_fsconfig(unsigned int cmd, const char *key,
> > > +                       const char *value, int aux)
> > > +{
> > > +     struct audit_buffer *ab;
> > > +
> > > +     ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_FSCONFIG);
> > > +     if (!ab)
> > > +             return;
> > > +
> > > +     audit_log_format(ab, "fs_cmd=%u", cmd);
> > > +     audit_log_format(ab, " fs_key=");
> > > +     if (value)
> >
> > This looks like it should be "if (key)".
> 
> Good catch!
> 
> > > +             audit_log_untrustedstring(ab, key);
> > > +     else
> > > +             audit_log_format(ab, "(null)");
> > > +
> > > +     audit_log_format(ab, " fs_val=");
> > > +     if (value)
> > > +             audit_log_untrustedstring(ab, value);
> > > +     else
> > > +             audit_log_format(ab, "(null)");
> > > +
> > > +     audit_log_format(ab, " fs_aux=%d", aux);
> > > +
> > > +     audit_log_end(ab);
> > > +}
> > > +
> > >  static void audit_log_task(struct audit_buffer *ab)
> > >  {
> > >       kuid_t auid, uid;
> > > --
> > > 2.53.0
> >
> > - RGB
> 
> -Ricardo

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
Upstream IRC: SunRaycer
Voice: +1.613.860 2354 SMS: +1.613.518.6570

