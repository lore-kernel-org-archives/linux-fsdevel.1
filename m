Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565074;
	b=PtkOdXs/3PGATgk6JkPqp+O1+MFpYEDK+WS2Mg6tq6ag2mihvuSwrJEloXLcISJ5A5bK
	 xPDt3I0zUvmbck3bQDvkPH20oMbyTQ/yC+9f+PbfpkP4/OW3uz2L7jknHAF1oWEhkbvo5
	 xP8234O+QpD2ZcWYdxsZcQH5dlqjWeJjJXj/GADI2zrAD01gVI+YZdmtM0cMVZ6N67GYN
	 buYKqpk1MhFd6nRp3OJlYvdw1DYn6iUooHvxww+pVse6lLGKxvPNfBdD69LMF9R1gvBAo
	 TWrGvafMOVR2bUWTk29avJG1plvp3ZXw/oC3c3tTfnWrG8SjgBEc1qOlTHqng19lEBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
	b=FVQGnUxdqXhpINKpoK7coryGWm+UgBK3VoIRkLygvVhU7mkHmlg+9pW+ljakWReYQXz3
	 A+WG3EUwyTA7GQxFhnJcots4zcA+NJ5wGdRUW43F7D61dxLp5nt/PJHcEaBvYIldHTt4x
	 oaKRQkb+mMGZJ/XvK1a2xR4vOOzP5R4zW7SfrQusvv9a3GEdYIW3XPCgPe/Ife9tggsEx
	 IqSerN29Skoka82CwZojedsWPcKWXGgMwS2/pZ/OChXCv1d3KQJeYFV4FGzAsPLBI+oAI
	 VOqVrHroLBkacCc3oKo/+cAHirLiL5csWkdZzsB2/UoN45Dl6HLrIzkbCwE4QSIf+6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C4606A880
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636C4606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so13807535e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565072; x=1795169872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=hEEG7fG6RzQkOoGSL66zkn+hWpy0b8TxpW+CxGFBwGxbhLfdgmFqwESmbjaY7MScGa
         1TTEC4ZDzMo/nTmQbATUq4OC5CVK8FiegRjrCOceUr+V68t+3IyOPEhrmauT/typpuMH
         7BtZ7bLX9twnpc3pST7EzNdPnkg3BFhqHXhYG5RTwPNXEKUOMAEYxir+CLBCGEbp4xnq
         ot2tG8XA7sYEn5cZCga4RcL6w3I4tCQX2A1rGgTmCQohN7lvb4NCOhavzOt0i7fRXz7K
         0fiOYrUI/s1Mo3f+qCL5v2ciULr5WU1WUhy3OFmgCMCM2mU4bZM+JgAT1J65gELN03wt
         2Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565072; x=1795169872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=ysSd300f94t82qPm8fMgq41MratlVSUWzP8Lx1ne6Gduwr1lGoHGMCe6C2jnDxwvFi
         oC3JfittU+ZPviTvBAE5xzVSHrbjxfUXQ6keI4NAzq+H1FRCjtxats6nzSLfdLPQWH0F
         44e/uu/vSk4OQtpwu9O3mgW04eHI4jFNJ1RuSSasJ4hMnkCy8n/2RwXj1/6oHJl3eqT1
         mLsoYH/vnQCFkZjkVc+VkkU6i2LVvlMOeCptgrRjAUU7jlWrpAYfPOdmcWWONsWWLZN5
         7ou72WAb0R8c6ZBmsUPszHgYy5sPAKiD/8n4VvDhx34uMMbcXACr1aUE7+GpDZNe7xfe
         f9fA==
X-Forwarded-Encrypted: i=1; AL+hErG2RBHLsNKPJMIT+aqF4nAxHGXWmGR5JfK+GBxZ887mhLaIr9vh+YoapS1wJHeADrQ5qpTbHlXy5fmiSOug@vger.kernel.org
X-Gm-Message-State: APuU4Z8BTtpENMgakMuQ6JqR+O9zmfs+5v9j4+7LGnhbKo6FbB6HMrpo
	Gg4T0aQaBsh+6nBETX+szEpIwqCbYXsxT3hTAhZajpXCizxwr5mo7POE9XtgMFkQoCJf
X-Gm-Gg: AYBFou3gJ2LdkRSGwOtXHq77dMW1kKjVLgiY6ctTYFmqkgw6ubHNdFHpTU5hGfSvcem
	ghq2rblWjZPwZo9y1O07aVlY71tH1uVQZakb17/tDmHqb6na4M3aLo244H2pKSWN2eS6zqCWrVt
	8XoeE1bc45/mMrB65bitQXjVRlLykVgKMl7UEdhWo9lxI1X7sMz5JTaCsQ0GCadKSuYF0YzBYNo
	9jKb/aXiSv8/krjvy4GaIq5PC9xRsziM4/6isngbZa4ORWO9rH6keSLpqgblYw27ofcZUx01ctX
	hU/KUUAz/ubeZC8lOryjQI7iKXVqtpGRcxWZgEgph349rky9q5aTvaU6vAFtP9fLyiQMZN+5jpY
	J9RfqYw6cT7VRusyHy2XG6a0CCF1dpo0w/XzcdUsMK+zZNKn27GOtGBYlmS8T9aS45hcK0cPNIM
	A7kxLSFJx1BCW9JNtAKX2IC/RY16XnYHqDH10NNoLbq2gfwf4s4yoS8Q/fOTMpoyq+cwBLcg96c
	hQqYkSMUjhIycKFHOpozScjY+nYzOYwP9IrAbPchqakIaamInOpaamar7IRTYeFL8autseIDeyi
	ddQRyDkGV+vMTdUuWy5GHq9QyrKGorcEzauWskutlDsYQTMVFuHUvbs7IJRcagM=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43851425e9.2.1794565071804;
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm3937770f8f.5.2026.11.13.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Message-ID: <7cde6f3091f9d90593e4a6441723b6b889cc4024.camel@amutable.com>
Subject: Re: [PATCH RFC 35/41] zloop: refuse zone files on pseudo filesystems
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:17:48 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> zloop opens its zone files by name below the base directory but a
> bind
> mount can put any file there, including a procfs or sysfs file.
> Refuse
> files on pseudo filesystems as zone files just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/zloop.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 65634a39b0bf..dcc06dd47b04 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1137,6 +1137,11 @@ static int zloop_init_zone(struct zloop_device
> *zlo, struct zloop_options *opts,
> =C2=A0		goto out_fput;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(zone->file)) {
> +		ret =3D -EINVAL;
> +		goto out_fput;
> +	}
> +
> =C2=A0	if (zlo->block_size) {
> =C2=A0		ret =3D zloop_get_block_size(zlo, zone);
> =C2=A0		if (ret)
