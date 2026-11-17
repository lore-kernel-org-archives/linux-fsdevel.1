Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903941;
	b=PlpDpoq2lzWDFpIet9ZOhTW99wlSvld2xG7TJouHEiq1NgKrMapEnXir5mNLPed7iZyo
	 qBsemIqdtUJeRGHn1wJtYL94KueN874ar1obz7c79O8d1GyOk6d8ZDOQ2hFJOAj0mN2n8
	 KNiBRRRvHf7VTWdTIzXGOSr2Bk1OQnRdiWh0BItdfU2bTvR9tm+K5gEvYfB1CSe403gYn
	 UA+cQS93ZjrjKQnST61sPwwfV4TqOAktTDUt9qn2uyb3z3Lx5HiPuDCSKwxxxaLuwfjAu
	 H3EuHl/j5Ql9oYzG7NjEt2m7ZFaQaLDbe3quPjNtxiT2HE5AsxMgOkkAzHjzMu/BqEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
	b=hZem5nTvv60q8J+zNyQxc1Zc5nGlg9PbEco1947h4LLpiN9W9sADbzR0prqBiGg7PLVY
	 HL/fkBO8qX5DeCCYCCeBRpXXUgbfqRcuOsmHktZgzLzaw5L3dvDGNU9bMtGGdoWA3PFE/
	 twYkh0HHJsv99vFHOPOx/sv46RZ10tmkAEjHGO2NCw8UeYSKem/asPjD8x2oPfwKccflm
	 Z3IRHtUeQekv11XWItFqg4vWmiAO56jeLLSkvmj8usG97AbNM+EsijAIXzzpISZRqlCAh
	 Rz6my7i1KV2eO3KG54Weu4Nn1KE8P1vxKL9oKCGJl9r2r7cHkG8piwTOdH2JZx7Bv5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="QoCmkI1/";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3C606A32F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA3C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QoCmkI1/
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492690dd5daso4102904f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903939; x=1795508739; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=QoCmkI1/XbLLMuB5pWQjj6w7lhYbbqiM96jQW+pj9RZ000aRRl9S7H2qSmbtORMNOo
         ePt1TXAWzVIR/TrMeI58Zu3n81XgIdPHavzyhyljr/3uEJYZwsW6Sg14gd450d308jE0
         RrvE2vSlthe4MhW9V05IsJzW8g0CM3u+nfQ1hkfntpYQW6a4z4zmXmxD0w/TiuzDbd7U
         U8xZ2FexNWbZhSQ3d3pA0tlH/f0MOfn4O69UeuIyRM8vQ/YXTKpGPDyGoQczoxEfoynP
         BDcwZppUf46pJGXZ+RH52kug0iZSl25eld2NGIqCa+XVs4XFwFr0CZI1pzljVyhbNHw0
         NmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903939; x=1795508739;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=QI1a7W8tQF6uzEfrBHC+YDw9Wll/ap1SrqAlh8D6Qqyf5S4jPQsF4Fs/myVv0Jtcph
         b6wozz+EIF8gKTzHZlz3q880VxWdKKT5i58P7p/iTwL6CyJ8cYafD7Bc6Aq4gDSmrxKH
         ELjgcmT/gPsej2Cr0co5NID87oUh5UG8EM062/EeB//W/YgAkL1fI2avtJFs//X8HvMS
         MJF6Uw3wo4V11KNPP9VMOYz5v0pbx8787eTFPGPouRsBQ+q8prt9LEsN65BsO00A+sZA
         CUhKYm42cj5EdF9IXYn6ySM0TStu0mZH1cfeFxznlHmZerPjLEZG7o7DeR4PC3frQG91
         CV7Q==
X-Forwarded-Encrypted: i=1; AL+hErH4Q7HWQj8PyDDDZ6LfHAMda/UWyGQcq4BU2MpgbK92jb7LTwPNTsPRC8w6plqJmHh94DTRFxkJYtNDmR9+@vger.kernel.org
X-Gm-Message-State: APuU4Z+GHDFlcqYcId6H253gqlKg+DutrCKq/GbvzVW2MUFPDpZnF90l
	NmRJJMphpfeA/wzUqJJFDy01dVFIaa92VK15Lfj7ClcQTfdtUJldZN7RNurFSbRAm3EC
X-Gm-Gg: AZFdTZcl/HFRvxAMbT34BFsO6eYT6psYMrpB1nAaptjuQgViqxlNki8M9DZooEOF4D6
	hSGSj0+O4useSdM/HYhSVFpJvY+V/i9Y0N0yDgZBVjV7Byts397Y8hXZ3iTCfFagA0gJ+SdEdUK
	0Iv0TZZjzJUltBID8jUHDYWU5bVB/VBuUfVsA8CJU7hxBpTm2hKuKB3a7WVXkvTOn/5CTgCZ7rb
	jm5beIwqAl7cpYkNYzWPfi/GuJWNoq6KPv4Xa2wm5JOkPlJoiskf5HtsIGT7UMZAlRZrWUVU5CB
	spTZM1beFWZmC4S4bR0V8bmR8cycu3P4Epg+KhmqnpRacB6z/aCMY8JReWz83Ytpe523kggmKNG
	cDcN9ra4dwsq5+ERRG3MXIsj0B//0LMQ4yB6xnmCsn4wzeMPwsx4Vr5Fz/8MD1Go4WJu2Y9w8K6
	nx7Wt5q9wG7OBtnGX/9/Bi112py/F69/wws0/eDD1/oGfkXCmlmfIGS48s97VKwEtSc9AR0ANnS
	OanPvLFcS/0E9aMpHbSryrQgPLy9mtl7gE0vm7DvG62zptjSIZ7QDQ6WLFlm23TI5RYn7S6j4BF
	YOzsi87JgF8qk1/o7p77+ECD8VMxqLVAfY54WurqmgB/KS/73R+5iRKZwInvc2nxdV3Uk26UePR
	O41zY1U0GUSKWYkyQ//5WsAaRHlMY00vzey+NH4FusHqtRNiJE0unylhjcLaCjkQ3o5rUGgA6Lz
	extA==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr25238543f8f.13.1794903938925;
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm26907832f8f.28.2026.11.17.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Message-ID: <a9124bf1c858cef3e8ac06b1b2396dcb0e19e2a5.camel@amutable.com>
Subject: Re: [PATCH RFC v3 02/44] nvmet: check that the file backend
 supports ->{read,write}_iter
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:25:36 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> The file backend calls ->read_iter() and ->write_iter() of the
> backing
> file directly but never checks that they exist. Everything that isn't
> a
> block device ends up in the file backend. So a namespace pointing to
> a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such
> files.
>=20
> Refuse them when the namespace is enabled the same way zloop does
> since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/nvme/target/io-cmd-file.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/nvme/target/io-cmd-file.c
> b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932ee..dfa8aa46188c8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	if (!ns->file->f_op->read_iter || !ns->file->f_op-
> >write_iter) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> =C2=A0	nvmet_file_ns_revalidate(ns);
> =C2=A0
> =C2=A0	/*
