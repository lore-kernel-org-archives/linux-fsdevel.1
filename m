Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A23C1D70
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348697; cv=none; b=Fo2qvMrntn/K59Be+FzjctV45jGQ6QEX8OBT/WWxhIqCgdwW95i8kU8sOmv8t3Wa88qAEpJ1S51338zg/ephRk2IWUsBcN7tnP1Fre0NmKGeH7Ji7mZRndut6hhG8iOHYjBDmblcLvCNXsywXYQxtImLrm1i6xOv13AMiPEUhuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348697; c=relaxed/simple;
	bh=/yI3vFaZB68stktGXcccKC05BkwsFx749+vS7sHar9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyvVGlhBZoMFDuo5pq7WsPbMuociG1uGzS7a9UPQmMa8xXLGyl47WOQu2YJ1IGauwkYEIqBMDqyBQqG9yymig8lvgsPrXMu1bLiSRXE7v9JzMwJJugLaWv+XSfZX7FIX7u1RtsFxVQsxbXqsvQA7E/sD0+w0EAreFD4Vu04UHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjJw/JC9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjJw/JC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785348691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cM+cB0fhrrgjh22i56aPmAETyzcO6T23MwoLY3ZQgp0=;
	b=WjJw/JC9TkP72hOgCyxgGhTwrx8bapdwsz49AwTekmspRvCt9ozn9byR5qNIb1r9HvXfzv
	i1ecp0nYwCiNn3XCfamehPVdM+35rZs4XcWbgI2eRRsNiMmTYH9+tMkLFDBg/WZzp7xNO6
	d359JMMInLqM6jVUJxLg4iYnGRyelLU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-Ex3xmxqZNEmW1NYcoOLPLQ-1; Wed,
 29 Jul 2026 14:11:25 -0400
X-MC-Unique: Ex3xmxqZNEmW1NYcoOLPLQ-1
X-Mimecast-MFC-AGG-ID: Ex3xmxqZNEmW1NYcoOLPLQ_1785348684
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3DC61956094;
	Wed, 29 Jul 2026 18:11:23 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.89.105])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3EDA1800480;
	Wed, 29 Jul 2026 18:11:20 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>
Cc: eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, rbriggs@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject:
 Re: [PATCH v2] audit: add FSCONFIG auxiliary record to log filesystem
 configuration
Date: Wed, 29 Jul 2026 14:11:19 -0400
Message-ID: <-GF9cdtWTQSigd6gY6zWOw@redhat.com>
Organization: Red Hat
In-Reply-To: <4fad20e4737ff546ce0a822d9522adac@paul-moore.com>
References:
 <20260727173710.964626-1-rrobaina@redhat.com>
 <4fad20e4737ff546ce0a822d9522adac@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tuesday, July 28, 2026 4:35:20=E2=80=AFPM Eastern Daylight Time Paul Moo=
re wrote:
> On Jul 27, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the fsconfig syscall but
> > does not capture the configuration parameters, creating an audit gap for
> > critical mount information such as the device being mounted.
> >=20
> > Add an FSCONFIG auxiliary record that logs the command type, parameter
> > name (key), parameter value, and aux parameter passed to fsconfig(2).
> >=20
> >  ----
> >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_STRING ...
> >  type=3DFSCONFIG : fs_cmd=3D1 fs_key=3Dsource fs_val=3D"tmpfs" fs_aux=
=3D0
> >  ----
> >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_CMD_CREATE ...
> >  type=3DFSCONFIG : fs_cmd=3D6 fs_key=3D(null) fs_val=3D(null) fs_aux=3D0
> >  ----
> >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_BINARY ...
> >  type=3DFSCONFIG : fs_cmd=3D2 fs_key=3Dhidepid fs_val=3D"<binary>" fs_a=
ux=3D4
> >=20
> > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> > Changes in v2:
> > - Fixed null-check for fs_key field.
> > - Clarified trimmed SYSCALL output in commit message examples.
> >=20
> >  fs/fsopen.c                |  7 +++++++
> >  include/linux/audit.h      | 13 +++++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
> >  4 files changed, 48 insertions(+)
> >=20
> > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > index ae19e5136598..9b3c02f59df4 100644
> > --- a/fs/fsopen.c
> > +++ b/fs/fsopen.c
> > @@ -15,6 +15,7 @@
> >=20
> >  #include <linux/namei.h>
> >  #include <linux/file.h>
> >  #include <uapi/linux/mount.h>
> >=20
> > +#include <linux/audit.h>
> >=20
> >  #include "internal.h"
> >  #include "mount.h"
> >=20
> > @@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
> >=20
> >  	struct fs_context *fc;
> >  	int ret;
> >  	int lookup_flags =3D 0;
> >=20
> > +	const char *value_str =3D NULL;
> >=20
> >  	struct fs_parameter param =3D {
> >  =09
> >  		.type	=3D fs_value_is_undefined,
> >=20
> > @@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
> >=20
> >  			goto out_key;
> >  	=09
> >  		}
> >  		param.size =3D strlen(param.string);
> >=20
> > +		value_str =3D param.string;
> >=20
> >  		break;
> >  =09
> >  	case FSCONFIG_SET_BINARY:
> >  		param.type =3D fs_value_is_blob;
> >=20
> > @@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
> >=20
> >  			ret =3D PTR_ERR(param.blob);
> >  			goto out_key;
> >  	=09
> >  		}
> >=20
> > +		value_str =3D "<binary>";
>=20
> Is there a reason why we're not logging the binary data?  We might want
> to impose a size limit to truncate the logged data (although we have
> provisions to log rather large binary chunks), but I don't see a reason
> why we couldn't log the binary data as a hex string.

I did a search for any user of this. There are no known consumers. Last=20
=46ebruary, fsparam_blob() / fs_param_is_blob parser support was removed. T=
hat=20
means we don't really have a use case. If, for example, someone decided to=
=20
use this API to insert a private key used for decryption or something, we=20
probably don't want that in logs. So, without an actual use case, it's hard=
=20
to say if logging this would be a liability or something needed. But yes, i=
t=20
could be done with the hex string encoding if required.

=2DSteve


> >  		break;
> >  =09
> >  	case FSCONFIG_SET_PATH_EMPTY:
> >  		lookup_flags =3D LOOKUP_EMPTY;
> >=20
> > @@ -445,6 +449,7 @@ SYSCALL_DEFINE5(fsconfig,
> >=20
> >  		}
> >  		param.dirfd =3D aux;
> >  		param.size =3D strlen(param.name->name);
> >=20
> > +		value_str =3D param.name->name;
> >=20
> >  		break;
> >  =09
> >  	case FSCONFIG_SET_FD:
> >  		param.type =3D fs_value_is_file;
> >=20
> > @@ -458,6 +463,8 @@ SYSCALL_DEFINE5(fsconfig,
> >=20
> >  		break;
> >  =09
> >  	}
> >=20
> > +	audit_log_fsconfig(cmd, param.key, value_str, aux);
> > +
> >=20
> >  	ret =3D mutex_lock_interruptible(&fc->uapi_mutex);
> >  	if (ret =3D=3D 0) {
> >  =09
> >  		ret =3D vfs_fsconfig_locked(fc, cmd, &param);
>=20
> ...
>=20
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6610e667c728..fefc5c5dd4aa 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2882,6 +2882,33 @@ void __audit_log_nfcfg(const char *name, u8 af,
> > unsigned int nentries,>=20
> >  }
> >  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
> >=20
> > +void __audit_log_fsconfig(unsigned int cmd, const char *key,
> > +			  const char *value, int aux)
> > +{
> > +	struct audit_buffer *ab;
> > +
> > +	ab =3D audit_log_start(audit_context(), GFP_KERNEL, AUDIT_FSCONFIG);
> > +	if (!ab)
> > +		return;
> > +
> > +	audit_log_format(ab, "fs_cmd=3D%u", cmd);
> > +	audit_log_format(ab, " fs_key=3D");
>=20
> Calling into audit_log_format() is expensive due to the string
> processing, we should combine this into a single audit_log_format()
> call:
>=20
>  audit_log_format(ab, "fs_cmd=3D%u fs_key=3D", cmd);
>=20
> > +	if (key)
> > +		audit_log_untrustedstring(ab, key);
> > +	else
> > +		audit_log_format(ab, "(null)");
> > +
> > +	audit_log_format(ab, " fs_val=3D");
> > +	if (value)
> > +		audit_log_untrustedstring(ab, value);
> > +	else
> > +		audit_log_format(ab, "(null)");
> > +
> > +	audit_log_format(ab, " fs_aux=3D%d", aux);
> > +
> > +	audit_log_end(ab);
> > +}
> > +
> >=20
> >  static void audit_log_task(struct audit_buffer *ab)
> >  {
> > =20
> >  	kuid_t auid, uid;
>=20
> --
> paul-moore.com




