Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5738F232
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506311; cv=pass; b=JTxaTs61TocNKJFLqduojDVcxl7e9l0jmRSAmOuohnWXMeMxUq6V2+F88Yq6KzEW+RliowIxBKT8kfrBK7yKbmlMYaa7iEcpuoroA2nCs2c7UDPSZDlJo5VtGX0BQaoPHrZgRwYCa58dh+cTiWBm9uHWq+Gqgx+rStg0DdRJkVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506311; c=relaxed/simple;
	bh=v2iptkwSmC7pfjv/tAPSoVfRUn3ZZPHoGdlB4QA7hqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXO6gvX1X0tLgOj/jULJ/TA6TTF6e4crelX8vIeYgwWcpqdOs6/gVVrrzb1SKRfqNKD3J/tgAQceKDJgdoh1i3NJ1hCGwn6htNJgyXqfA0sZkHQIVoOOm/Zt1G9pfxlooH6daIzSRwloW71AQZWHRO25dEqv0Y/1ewb3choge2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Mg3hHQdB; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Mg3hHQdB"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c04bf4711so3726041cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 03:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783506308; cv=none;
        d=google.com; s=arc-20260327;
        b=YG9UxY1NuoKaxFDrLDjhNS2HfNCxepzP1Ky6iPG/fdTkpDYhJoE8QlZqfkW50WdbfY
         xbZ8IwaRo9wvkrTFjY6w8zAjr3NTMNhFqeax61zHdB0t/B6F/1G7mzw0YX6xDJp3gKCA
         ao/0xG9Nt8gIQylSjxrlQk/LKwqnIIl8DvT2Brih552CQw7uqyiPoE+ZJVGNskB+pL1o
         1CAEgA1fB9y2G0TcAu0sazTHcmKN+BeaiO7eE3nyl11IlJdP2fy3z4BTZvE9fYIJCQTt
         tAECjbmi8W1o9unGIoxrJslxU/iMsgGPk/dpXDr44/NV1/qpEdB/OM8ua4NCek5YlXF/
         hseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yQ494GWLnZ57cIKhXAy1AeNd/Rccg66OrqluMTPjUdM=;
        fh=KZkblFZLoTvHkXku+xNaKXWbjVBz1Vqnm9lKrpAX/Ck=;
        b=e3OOhXR+0Z6KfDBTTkYj5VdgLI0ybjFmvkR2ssumm2HIYtH8gffzoSt0cl9MVubIDP
         NGlxtFtk2TXCV2tH9nye/v177iWgTd3WbsY9hZguxOzRQcWslXtv8TjJrXgjoAPFumDA
         kjmlz4cSw+KzMWY5FUXhmATGkJ1n7mfGlIPV4mTwsP1lBhgRYf43Jvs3ExOvFJE+nxU5
         7tMm3phOMxIkpgCbEGTO6QrCYZFVT9Ro5pJswNOqv+QS12bpzd4jcS3Op2T/fX6DidBU
         ocRLZbyjUp+Lbt28nohlhpSBNkKvppfdTu5s1XwyyilgW3smuFvsfG2dBkNrWJ0JkEqE
         ISSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783506308; x=1784111108; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQ494GWLnZ57cIKhXAy1AeNd/Rccg66OrqluMTPjUdM=;
        b=Mg3hHQdBKffZVJhW6YLkcvGtjjXB91BMFTVl6H2iE5b/QH5Nbmgx3zo8BP4c3l7kM6
         SwmNstjdVPqU+3PweEYhncYDXK508yMmQiWHh8TaZ73FZsseRKxhoUBvVNr6tNaG3sox
         ympDg+MP7NgjdQpTjAu0GQw/nUN38fegAoPLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506308; x=1784111108;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yQ494GWLnZ57cIKhXAy1AeNd/Rccg66OrqluMTPjUdM=;
        b=Iae54QtzquaQFoaV09WyAHTNV9QW6u2uQvn5uPwzR20rVgA9MI1dXUAu8zUkni4ZYX
         VJJpwy7u9yAwYIHu3UVu7q2xc1zFroDPnbWDeCIkrQzsn5CiCbL6sTnS121bZ/w3z/2+
         Q75KkVY7eNfPm0jZD5gS6+7iNR15ykQ9i2wORJvadmfYqx8AzeUv9rIa3cIlVRurP6wo
         GZq+DcP794gM2HR/k8s+lmNpwM1nJfPlXuinfqX8oLtLsn11DEUGLlQFemIFnkYRrK16
         f00QctEVOZCSXdjIE5X3fZo9ubS7n1mzm5RLArOpzLPQpbB0FspJkB0D+Xybeu8wD0aU
         mWNw==
X-Forwarded-Encrypted: i=1; AHgh+RrZ3RVr6kry222X/WPWed2uN+WWjHJWFk2WwOSmlQMGmYVCAj8tFOgJNd0CFbRdUr7HviytHPSQhbnsOhYU@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBvK6WeqF3NV9icmLXJMNLtX0ATaX0A2CzaaDwJIB7bbrO9eA
	r94KEG6rM8Ng178hqBomvOga0vjbEIU+pCxpEciaseGvX/1yzpi3kmOcEUqD8KkgpoOYOhfbkB1
	ajbvBgxXBtk6y5d8gPa09SnXUQ1y6rJ8hxDBDLofCrw==
X-Gm-Gg: AfdE7cnj0/BkxOZjZM3WEtgvg+hsmIAZDWz4qPz7zJRN5LvGXUSdCkByRVqOzqsJAcf
	8GykHoIPXn+/Pm6Wz8cYt0urx/vsvmQz+SNTp5WYXx3MwH3wa6JZCQiCZWQoNXXlgYfe4OYCBH1
	th6EiMvlY+6/Uhc8TVP3zquRsc/0Y9t8QhHTCpUR52sNYY011bKp7Ke7l20d+zzR7cmTkV658c8
	oZuWwXAlivl+mJ4LKz8yqwaHJq220wyK3CehKKiF4MW3IDQspvMEJ6r4+Tk2fwaSIbkz9qUw52J
	nYH/7dP8uXCuS3Uv4iqdHm/4Jpc=
X-Received: by 2002:a05:622a:2282:b0:51c:7b12:5fcd with SMTP id
 d75a77b69052e-51c8b40a23amr19083641cf.73.1783506308598; Wed, 08 Jul 2026
 03:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com>
In-Reply-To: <20260708095831.3381978-1-gscrivan@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 12:24:56 +0200
X-Gm-Features: AVVi8CfCXklAzPR7aDHbzayp-qscildNngPjuk9ohznhtjXLzwjf1tF6bysoZxo
Message-ID: <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 12:00, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Add two ioctls to overlay filesystem to allow userspace to retrieve
> information about the overlay layers:
>
> OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
>                         arg == 0 returns the upper layer (-ENOENT if
>                         no upper is configured), arg >= 1 returns
>                         lower layers (-ENOENT if index is out of
>                         range).

We could do this with a plain open() call.  Something like the magic
symlinks we have under /proc/PID/fd/.   Question is where could these
live...

> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
>                         with numlower, numlowerdata, and has_upper.

Isn't this info obtainable via statmount(2) already?  If not, it
should be there, instead of a specialized ioctl.

> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -35,6 +35,8 @@ struct ovl_layer {
>         struct vfsmount *mnt;
>         /* Trap in ovl inode cache */
>         struct inode *trap;
> +       /* Keeps the original fsmount file alive for OVL_IOC_OPEN_LAYER */
> +       struct file *origin;

Don't need to keep the file open: the only info missing is the
original vfsmount, everything else is already there to reconstruct the
file.

Thanks,
Miklos
