Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5E377559
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788370924; cv=pass; b=AYoXCLtUfR/U583SmVvySgDnjjzvB63sdfoqTVg1RbysudrDLwX3kWp7/IIM1pr3QIZTaEjl+XpFWCqciNHkTTy/f/ppMok2BmSWoItvoRQW5nnFHc5Mi5aVRdu87tHkTga4xNPgkf9DZLXFDmZdtP5WOQXESYj5X+bwwflkqlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788370924; c=relaxed/simple;
	bh=Eqf+0eLXc0FgwrVSCs0yu4jlrvNHZXop5gKzjh5NsZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgxecsxGYV8wx6ifGJFARtO4chiPaaYFqI3ZFtJbISjsOxg4OP/JagAVuXKvuygjfLH2Gw+3JTbB8bzKq4JvtDRSFWkE48rxSEuS060m+l1swnvVDLtcEaMbzQCY2MaeI6R5gUnOUPpsMcJToUwwgHKPYg/W/4UdgSbFYqa0SJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gM6Ivsc+; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM6Ivsc+"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c169ae1cb26so22254366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 10:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788370921; cv=none;
        d=google.com; s=arc-20260327;
        b=SfEUbEcMUo6OYerakvAoyW2rAARqDPwORXZTNRucyGzBArhEDVxVKaYmybCw3Ijw1M
         w5XiMVJAzUyCwtKFuzQK4WPl5Pn4ZCJ3eK7rwmNm+DJkPxEkpgEP9ZQB/sOl+v9/0OM0
         XCZd3i5LPPI2PEHWU9TPYZUf3deGXmDG3Y920Ons7fZgXJcyG29Uyw7S6Q7I87Fw4Nzk
         1Tra6yRubz03njoMyhH7ePOQyJNkdVcQqufJQAc2pZHs37Vvvj/RH5TWFa7IHifDPTYZ
         X9z1rdDvtD4Zavisq38YQOqwvsTjrhyU0/3MlQ7EXk87xRqv4RFN3GdB59EcTY24sgmz
         89tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kL4zW5dUcB4WBV68XjuqIRKZ+3RhJuwWbxJD+z3Zrro=;
        fh=WjcggNRJMNoQbdpoihgcCyGwl3aREiOhp36/0S/Rtuo=;
        b=rV1fCyoUsL2dEDGRWEPIGqayyjL9b/oTtb4A/jGst0Q6OroFDHyrHe6WiFGULP2zdu
         75+Z/9mvV6EomHenWMIGZKXe9tRL5CDKFNWyuoQAwkjuPG9IMUh9EMMI2qhXkGwzPRot
         JiU/+80JabQfciGGVKGVK/qQl/upq9zqpomZcCkU31ohrcCcItzIHiNjo/EoEIvgo5gI
         6HTlr/s8p24c1OjU79IGheO4Hru3VwmVv4T4of8/uqN6Nxg/+vbuY6JNcCbHJU5BVrAJ
         ctHKwsfNUO66abH9NRWPAF4KHH5AKLC3gTAr81EKga7ZjO9VpHqGLTbBW9HPHHAZyXIM
         KnCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788370921; x=1788975721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL4zW5dUcB4WBV68XjuqIRKZ+3RhJuwWbxJD+z3Zrro=;
        b=gM6Ivsc+60a1pX0TEbpr+kxC2zWsscOy9Wl5CGnDVlh/G7KN6XUL+/Ly0CWNnzJTyd
         hKstUv73UnNSZ03n9MWNi0L/sTLUYwey0wLXMpSdkVmUds3MoAVmkPYdzl9R0DomkHxL
         TL3xfH227fo1XkpZlRFh4tysurXf4m6x0+FSV+LQ0x+6cpL4HeIYoaYViUnkn7i0gOtn
         zDHipB36O/J3m4+1Z68AiRcxzLjJtYl1lwrdkcLJc114tk+CQ+r/SGjI8+JCenx5q94w
         USPKhdEyTqK5ZC+ZSKDo2JbkkBX2LCQQyH+1pyOPxbRwQhbhBf5xIn30JtaOfsj1SjIS
         QleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788370921; x=1788975721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL4zW5dUcB4WBV68XjuqIRKZ+3RhJuwWbxJD+z3Zrro=;
        b=tZR2AZ5fTu3sSoDssQQPPHc9kKTx9WV3ZNVV6bMktjymCpQO1xQ7uULptB07JUR4cY
         K76uLL/0gSXfXVHgGZL2NwLus0cqEKROte5M4HBtfMcGq+9k7WxjuCmTaGbho3cC+I+X
         DQPrt8SLMM6Aa6OjMqsj4pjOI/sWxifOvvzSjZ1GCkAxo9Lum6O1mqWCpQvPQcIu/Jko
         IFaOz/F9byv/YnYtlFTyAR93fVqzMjCwdehO9wrtgcYQgMtTt1iY5rcV8s2Xte1KOlxX
         yKcD/pjV60LRjpcHKhGUGsqsjm3tQWGGZ7UNStrU6Aep5kXy776uBxagvBLLNqiccXvA
         w2uA==
X-Forwarded-Encrypted: i=1; AKwUvBz6DIIJD3RZ+OYqZCAMd0Tf0L0Ua0HTYFyn/XnQOtSwsil77mKkK5QP29SWlixuhMFKc4kMY/UAM34jnuBi@vger.kernel.org
X-Gm-Message-State: AFuF++lt/ycG/7GhdavhoASUbFKYIBXq1xblh8RPGAdZlIYzn8WvOcG2
	75gD7yWCDR/1R/W/jNimR2o55zyHsRzncidvyX7TKXQV8BPS/uRSWXXDeCu/ilLwATZovJ8lAxO
	8kVluvXLKHnyILnMdtotaf02hegMATmI=
X-Gm-Gg: AYBFou0Antd1P+LzSBaH+MHeVjWY2GG4kXlmmG8mdJOYNyfbnpvuntzc/5pMLWZrWXc
	bsjRj0A18/gZtq0HJj46+CInqfoH0oFukiLdX1Puvmpvl9sOJjdyGrHyIAQ83k2l9fsabvkGNrS
	54CHcZo7fLMM4gM53obbqn0Vt/kzb5l4dvj/+PzK7AxypIrlnqfQgrWG2tLr67OURIqo/uaf1mK
	UKeVpEa7cSo36D0QfuOQvu8SOLaRMOVysNoxFXTGeaxRg25VRlS9LIwIEQLdIX0ED2JKhp0pjX8
	wA+oUZx5Uox0TWhO1QaxKvM9jXfJSRA05NeSgYhyia3cllww/hrbgq7WGEiMTOATu6oUgVklEbf
	B
X-Received: by 2002:a17:907:da17:b0:c25:5e10:1ca9 with SMTP id
 a640c23a62f3a-c25efd3b676mr49128666b.5.1788370921232; Wed, 02 Sep 2026
 10:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org> <20260902-work-coredump-unlock-self-v2-3-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-3-1bece368cbb1@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 2 Sep 2026 19:41:49 +0200
X-Gm-Features: AcwNN1Wb5WnZxkPqm9jWDmkYIVwzbgnswh4v2eJHgiN4HZYIgJru__5CaCpbdN0
Message-ID: <CAGudoHEqtpkeeKZn4K3zWjXP=VZ14EgvD+M_G2Apk6wg2cG-aQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 03/16] fs: rename do_close_on_exec() to close_cloexec_files()
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:58=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Rename the helper and align it with close_files().
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/exec.c               | 2 +-
>  fs/file.c               | 2 +-
>  include/linux/fdtable.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 745f6eb5279e..92a02bce11d5 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1220,7 +1220,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>          * trying to access the should-be-closed file descriptors of a pr=
ocess
>          * undergoing exec(2).
>          */
> -       do_close_on_exec(me->files);
> +       close_cloexec_files(me->files);
>
>         if (bprm->secureexec) {
>                 /* Make sure parent cannot signal privileged process. */
> diff --git a/fs/file.c b/fs/file.c
> index 59673547de90..be06e09df41c 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -884,7 +884,7 @@ struct file *file_close_fd(unsigned int fd)
>         return file;
>  }
>
> -void do_close_on_exec(struct files_struct *files)
> +void close_cloexec_files(struct files_struct *files)
>  {
>         unsigned i;
>         struct fdtable *fdt;
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index c45306a9f007..e6b641d9eb91 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -105,7 +105,7 @@ struct fd_range {
>         unsigned int from, to;
>  };
>  struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __=
latent_entropy;
> -void do_close_on_exec(struct files_struct *);
> +void close_cloexec_files(struct files_struct *);
>  int iterate_fd(struct files_struct *, unsigned,
>                 int (*)(const void *, struct file *, unsigned),
>                 const void *);
>
> --
> 2.53.0
>

Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>
