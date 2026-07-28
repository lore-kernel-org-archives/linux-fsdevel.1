Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1104749C5
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270925; cv=none; b=hEkTL95U/Geb5JZIVAPn6NMnBmaRjg/8FGWYjEKDbYwmnTHoLxCPl15isRgBA8b/hPyytYOc1qW61ni4V6tkv02qSWSuFAloDikRTn84XQhxLf4L/e/1TbocAC4KpzS2pnyi+Jnc/92Dr+EITMOMhUc3mOagEHujBcANJSKrYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270925; c=relaxed/simple;
	bh=U+lLKCY0/w93eWsjz8487mJt+6NDu0yjnjNJQWdKrhI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=HSKnhU/VOraRLtFIa160H8aGb6VArjQcJqQgR4N1+9jw+0snkKuMGEqrEuMLy2LX9Mw0eYaWchjnD7b/HXnmdt5G0WV7b05o4GdA+D+UwdR2bB1Hs9lcUn7/KiVci2AO9n/jMeu0Df2aczxmGx+kl0xIFDXPhGcp0zrS1XIDTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YGh+shex; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YGh+shex"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90004d2f7b7so2426476d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 13:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785270922; x=1785875722; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iSEcN1E6s5lwXI7JRu7ScxVibRaffsPscjiA9BZ0LTc=;
        b=YGh+shexvq1CjsefBmoEodQLeHvME5lTkgU0YCWsNq7PWIDcEmaXJjHaJtGJ29rxul
         ExjzmXmavxwZJefklb8xwbwqiiYHH2s4hPUdEe1m3/adqvx7lFeTXhrbf5zSbI3pKyH8
         v5PciBZaXv2dPRy09RM5utyVXy8t9eBUPzADSJ5lw0F6d8ElL56Xm3fZQ3GdxOgUqaF7
         +srYLjC1tRSGMyDoAA6mi/xYnHgwlsXBT2dvhCWyu/5VyExve5AYhLwqaAzKd476zPc7
         EKUW17z8In+Cy/vqc/8zQLAdTBBFjgqYJa4KW1xUL7idGD6tTyTv1JkQe7uuPAPyAm1u
         QoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785270922; x=1785875722;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iSEcN1E6s5lwXI7JRu7ScxVibRaffsPscjiA9BZ0LTc=;
        b=IJjpjS+GVdHpnmxo6kF5Zk5peZECK6GaNQiunORqRYMLnq75XxiW6xnApJlHAkB12R
         I5FeXESthjf/LXSwhCB1JAJa8L5jUvlbmJzoXvOTvzT83PR5jUqa0cUegcRpGIRpoBbQ
         3Rsn59QGp7NsJkrxNkwlyJ34QKMuuy21/hkveCLcAmjW/q3KojvNNMBakbDmwfJOrQD/
         YQNWzAESguubUeUloJyHYUYcao1M3klsz4asGg8fFJtKpF61J6+3lep297zNIvTlI/z+
         s4/r6GxmewmJblimtDMvejq8kUD/sSyPm0zPNI7fC3FEaeoomC51nKxKxX7CIpQC1pPc
         tgmw==
X-Forwarded-Encrypted: i=1; AHgh+RqghGspSyDT9X5QWTQv2jKNwiMNE/tue/YK21zKm8/nbhhfGHSrRFDz1wUfC1csNDtXKnAVIfyYeBIpbFrw@vger.kernel.org
X-Gm-Message-State: AOJu0YxpKHZk6cfFnfah9FTGgLHpG2bHaYPrn6m/wAYdsnR8p9rIRYaG
	8JOFTpSgpFcLHBCrFMIHWvbDPYOuSGXgv8N1YCT/siIRU02gunFF8BGnTRjep+Au5g==
X-Gm-Gg: AR+sD110YyN4h7mIZEAEstu0K+zUubAaiyw48Cm8Zd0C/HeZFgYYFtufyFPbRmWAp0C
	CKiDQmwzhn35a7HihpQiq3eZCA0zwbksdo8ExTUFqU1+tB7zh9uYHeCFyw1UYNkru90RapK7hFA
	jwgKMJX5H283Cs6T06sglHgIAliD/U/VqtA082XsGZdGZqv70fqjEFWsJgsNurFQuoQIZUh0SwJ
	Z3atnwKimqSlfLcyJk+MpE0YijtvhV6rpD0gY/nC9SuqpOGeX6OUjbvGeqCdMR1o+OaZaKfFOHM
	4n6xyePAi9Hh4C99i6b7cn9PYcpjYMVLBKvOFrnwPRczG/FJxBm8i//39uIsiJBIfLOvp3Sxuzz
	NBr5xQwJufRLL5YPjZE1hyzgHGIxUTf1EjnS3cfuaTOdSopwxCt8i3im2KBNFB32e9bWXa9ydtf
	yazVDGWlUNsbv9gBeg27bBhMTjH7L6jPxZ/cHujbv9g7WpE7vFTYz2tIUTQmoD5tV57d/ZtPyJy
	oH9H4b7jq9QutZmHcMtJcoTvojmXBT8DQ==
X-Received: by 2002:a05:6214:5a01:b0:906:2b80:4684 with SMTP id 6a1803df08f44-90816fbbd62mr45289446d6.3.1785270922456;
        Tue, 28 Jul 2026 13:35:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc44d0fsm7433266d6.6.2026.07.28.13.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:35:21 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:35:20 -0400
Message-ID: <4fad20e4737ff546ce0a822d9522adac@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260727_1648/pstg-lib:20260728_1147/pstg-pwork:20260727_1648
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, sgrubb@redhat.com, rbriggs@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: add FSCONFIG auxiliary record to log filesystem  configuration
References: <20260727173710.964626-1-rrobaina@redhat.com>
In-Reply-To: <20260727173710.964626-1-rrobaina@redhat.com>

On Jul 27, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
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

Is there a reason why we're not logging the binary data?  We might want
to impose a size limit to truncate the logged data (although we have
provisions to log rather large binary chunks), but I don't see a reason
why we couldn't log the binary data as a hex string.

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

...

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

Calling into audit_log_format() is expensive due to the string
processing, we should combine this into a single audit_log_format()
call:

 audit_log_format(ab, "fs_cmd=%u fs_key=", cmd);

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

--
paul-moore.com
