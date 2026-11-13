Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564705;
	b=FTqZJlhhfXX3f5dFm3jvAxzlFnuFL4Gi8VCt192bsqdmXYeiahao8im4nDVMDSDX47ba
	 v8VhMNji+RmAYu+k1G7WEYMPY050lOdJHRQhbswsDm/E0EgyM5Qw9zNSXMuLDHqbZt3MF
	 GIMxGp3yYGoKSfhqmBR0pFelAHHKeX+kxpW+CjnVBOn9GbljLDGU9Oz2xTBWAHby+1dFL
	 YGtIkctSN+5p2xuMFAqwgO8XDSNR/LCOqDXFSF1MU1gg9VdA5xPn1b68LbC7TLfXNf6kT
	 3w7gyADx6tPXZSdxnKKQmEnYh4yQ8022Y4Pbk96QaCVlU3CTKVwRJRZEVQYPcaCutqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
	b=TehYIS+d2Wo0mIWLcloaZhkQmktfCMQvlcqJV10+xgmOmxB3McUVqccXWWv+nGZax/xo
	 sjbH0im4uHGp+FGT3O1oVJHCl7SPrZ8jBFqubTOxE0PyELM1M7t4wGfU9/bmqwSei5KPD
	 6IgtqUvauYryUOHHOhSJTQqwtt3+Nv/64CU05QHirSDwwsMxvW0ocwT6dWd41+wWMxSng
	 07OU9km1w3Ot7hxAJmkK40IoLZnce/SgrreWxDg5p+wTuUhlKAiNcd6QlHpTUctBQnJVy
	 DCzp6haw4gnJG7T+bwpvBuCAFJ9OELj4XZ8eQo75lR/KId6MnZHKvOHwofCqk9bU3NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BADxd+iU;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ABB606A897
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97ABB606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BADxd+iU
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-497614c95f0so327658f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564703; x=1795169503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=BADxd+iUI5Bylfm9xHmZjb4pgHg0fbyWkyp8vNCt747iYknkt4pGGRNYLQ78EH/z4x
         Vbi/Jq3+E8iOs58TJRk6WPlWSpFf2OpeZbjgHeXjXzKeHm9XnJ+eEvU2VLt6liCBRq7I
         79Td6VY4SiSTAXWOIivpd5ztVkC+DBAB/J4OfHn49+YeU7s/KQ9yNfnwb8sPZOTKoGu0
         Zirp8LScbJznGaQAXzatlGuiy/pBfqScnET/jGobuhYjlwMbyAqyeVJ7smTe1nJkO+dB
         h89eeA8CIS4pNdPKyjqDo55n+EKX5qBSzrC2C/95dZzzzQLBvHRJ+46c+P8Bzg/7r93a
         +u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564703; x=1795169503;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=2CCsP7hocq/ixfFFq857M+C6HE/FHdBMWsFbaWfRoQZsDLGOicdEBbdyvPVSsoE1FE
         Gw9EecasVeuR56IxQZCq4BiLPk/DcZdEBKzZuzVBzpcK4wo6//1NZlDY4Zz0fCA+MwCR
         bMot8b1QKzcqYEZ35s51hvTsB1hU/eQxF+TxXOEiaYb/jUrb7YoLkV9+kGuKhy1pL4cG
         5Ry0waCHhkEoeH8uHBYsKIhR4uJotMdkGyNRzTYfCI9B56xbXQ+lkGK/IMGRpZb/jWQT
         s7ods1x9GA55HcXNJzkgFJaEFj59HavZzqNHsfGJtZf2lQ9RGqnqQlvaNtgNamxXxle0
         ZOKw==
X-Forwarded-Encrypted: i=1; AL+hErF6VjkxRF3M/+2p3gSMzyS+iVfumGCQrwMwqg6Y2qPSaJ+DwCeXn8n14tZzABYNqOUfNdqeS8QYJgXIvqTa@vger.kernel.org
X-Gm-Message-State: APuU4Z+bYVFZGRIBAoOgqUmS5Bv1Aw3S10O6eUFeEm4jZ6TbSca/euZe
	4R6tDHB1eOEz6KDlU2WQCLLyhBvOv/HyI6Kw0RbI2BGIyONZqBHdmXlmBhdPIHG9ScDY
X-Gm-Gg: AYBFou2Ul3trQik9T1X4ZvlZXdTj9upSe/5qm0+xBpiFb6bKGyIC3NylGZUxU0bixr4
	9+KC47A6kIMqR6JIXAyiArppW5cgAaY4oFictIHr7gxOkqojNflgkh1H8hAxokz9rl67XdQOP9U
	ONkHk675BZg9kjeBP1Jf3D6lgojv41wWOqVR+o7dx413rMAZ79CZ9kKaC+5j6YTPS4YUdgphAaO
	ufQ8ftN/b9sg8AwluH6OYC1lEiSokEt4l+aoboGJ90ulXfWxAxyu0zMd4lky6gjHP0x0dCRyOzx
	9D+huJXfpoI2CP6VYZrY6xa0hZUHVZ8UUWWhKO8CDDS60PjtgX8aBMvI1IETg7JXvxCBMzr2p9c
	cHzT5akHywx+xzjZb4Ksct1bZ0RQ/rx86MpfDIBeRsVnSYZlZQwYRg+euEvVCXkidVDj2/V/52P
	5Ij2oRlOc+CIvW7fbPOHXTJdCXTDvNBeJ23M9jKZSDcqjZRctwkrW4w8c9UBklITvSeiZphRVJS
	GSmW+OUkNy/ng5/KJ6gU/99ccPS/dygGNXT8APnhQgQUsj5A4Y1YjQgNLKEIDiTt2frZxjwubQV
	SWqb/HyicZ3I5mwuDi4AfhWbNruSyjBMpriSuuhX3AMlmvcOt8p+qArZBG9IvV4=
X-Received: by 2002:a05:6000:2501:b0:488:88ec:59c3 with SMTP id ffacd0b85a97d-49c73259cc3mr5012611f8f.14.1794564703010;
        Fri, 13 Nov 2026 02:11:43 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm4931434f8f.11.2026.11.13.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:11:42 -0800 (PST)
Message-ID: <ff6d2a8c8623f5476d5c352dac1ad98ab3da303c.camel@amutable.com>
Subject: Re: [PATCH RFC 18/41] selinux: use fc_init_pseudo() for selinuxfs
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
Date: Fri, 13 Nov 2026 11:11:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
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
> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
>=20
> But selinuxfs needs device nodes. The kernel replaces file
> descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't
> care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear
> SB_I_NODEV
> again in sel_fill_super().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
   I.=20
> ---
> =C2=A0security/selinux/selinuxfs.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index 310e19efff1d..d7ae853b6d68 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/vmalloc.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/hex.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/mutex.h>
> @@ -1852,6 +1853,9 @@ static int sel_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0 /* last one */ {"", NULL, 0}
> =C2=A0 };
> =C2=A0
> + /* Android init opens the null device below by path. */
> + sb->s_iflags &=3D ~SB_I_NODEV;
> +
> =C2=A0 ret =3D selinux_fs_info_create(sb);
> =C2=A0 if (ret)
> =C2=A0 goto err;
> @@ -1955,6 +1959,7 @@ static const struct fs_context_operations
> sel_context_ops =3D {
> =C2=A0
> =C2=A0static int sel_init_fs_context(struct fs_context *fc)
> =C2=A0{
> + fc_init_pseudo(fc);
> =C2=A0 fc->ops =3D &sel_context_ops;
> =C2=A0 return 0;
> =C2=A0}
