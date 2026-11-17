Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904345;
	b=O/KKYSt3KqX0OmVCoQDxZusIO06EwUV329yb6FBT6pAP2O7QabFsR7p78hEBQiSWZT1n
	 e4SkCOHNnVPFYbD6ueB1kEYT8I7eHOAdXn/KX7sz5N1ATrMexji0kGZMTpjDBdg6G4b1v
	 QoyCvbTAe+Ngs5uQsULpC2ojdLZOgCEKY6z5fGH72UjNBFq7GNpNxEJTMHVCmJYdUbzy/
	 YzLhch+DDjN6Wx9naR6zH0RJTmXV+b1vudixjTL7Uh+8+m1uWZzTn0VL/XKzZ1dG9CzQ6
	 kDBMt/iQv/c9eABWrh301FG8cyrT2LPnQjGfkG2Zrm61xLBJnl14vGzFA0uKV6SpGaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
	b=09TWhJEpBolKi+4ZPPoKtnj7744CM+LOWMbUOgFlnAmN8xDxvCrWo8VlC7ZvIxsHiSt4
	 rqSa+yH7AJyeXSYF4LoTAlnC5IhPrTzxHM1P6l2bx3TTEbaKyFWkPrjPnUJpIzhw2ub6M
	 hbGps1Mu1fX6hO9LGs5Nsx5BIuaAdKMZbJFiHe1w/ZqIje1ctmeeHdNCjXBDe69vAIahV
	 LGb40wYKRbx6yZDlP+ud/O8zQkKJCkWOOuOyFkdunOoj4qLPv7DhJ/XSsLifmVfomuOfO
	 Fll0iNsNIF3XyeWfp1BEAo6HLlbMDGCAANRkey9wYCq0Z0Is3xTHnFkoHeJ+UrG/9mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E18606A885
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E18606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso178007f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 00:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904343; x=1795509143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=EFPX8Vuf7iz+NzEUQG+pPgjK/MbrESqv3n9ATmra3Zopp4tpstszPHFfE2sR6EI1XH
         /MuIqTxoWkMXSLrvcYnqUGQvNVGY6YndEf7Smwels/t/G0PiJAqa5YTB3/XSR2c5vF/4
         5S685rADCuM7kD+KTHsn5xD0Bbvj+kfNJN7h3Eeu6Tgpz77cxc6E5ixV5T0A3r/KAOuP
         +pclbSVYUTOzYQ2RRiRVVs4C5Z7y/NhXCRc6Of4Q0fL8jD/Em4FfidsaQN0h6TdkChBo
         DufH5bn8tmF4fp27j4WWCE7M7sjar8yCORXmuz1wFPQxfWworU2xHCWyEC/YN83R4E+t
         3i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904343; x=1795509143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=ztf4ucQbOlgBw06p3Lt61pSmLJQW9X2d+nhNtBpVQaQvjibEF23SERpr5bTuxwaC8A
         ZIacrK4jU68FY3Aq1xapmPojr37qDPuVmEWS74BfDQc4VWAaU7eabqpcrOKm8yXmkoCC
         d1ZctOq4TlNe166LYgDb/MXmCvxuPihbhfEAvSn859rHEZmixK2UXBWXHLHzDH+rrwff
         OwuXxVMRxie/lllheSDL+P91kGy2pdK5p2pFSU+C2GM7vbzCn82WMQfbD4FRZ4NmangF
         GZOp1EYa1mF0DwnR/qSf1R+406ygB6pKXUDTIX75cDxELR72d8OUuTH1dk6A39yaqJ6A
         w5YA==
X-Forwarded-Encrypted: i=1; AL+hErE5qrrEeG08W8k1RRDBQiwvUzIKAtFKfaMeNC3dovUs4Y5Qr2FSgIOsW46KeGscQNWOQuyGoowdgeua1uT4@vger.kernel.org
X-Gm-Message-State: APuU4Z/yYJtGsEU6bHDxSOA5pgTIwsBU1Mvo/jytu4mcqCsPAn0jbcQj
	mLQY50CEgVBaZDAcgje3mAGWJ0wtpaFVPWlNtxR+eJqU6zbkpd4DSdCCUNX16/nsIT46
X-Gm-Gg: AZFdTZeWJrS8fG6A9mipod+VEYYvqOLTpZIL5SkOUU+9LcJPkdoYF1RG5Qd0ShnpdFK
	UXJ/aumOvlL37VZeed7Njp6sDn3vaO02sSdArpjZXYMmevKtkwnEOZ+vhhVNAN5yHSyn9v37zlt
	pIl/lTM97MDJpIxmdHVXSjk7I/HZCeebEawldcc/gAI8vofd9FbHZK3ZJdBU7mm+0LMTzTViSLz
	CNKRKW4LPT+FAQp3oURAeM6OCKe+1zTvWPsjC3f7S2iABo3xaJkmZLr/yQEpwozPSfOeyE+z9hT
	YgPg3qQ2nCWWtqbHu+a4ncl9mZSFrbzl57otUtFiITjGNdfzjrZm+rALPCyoT6wVczFwy8Thotv
	Ds5jBdS83q+Hm1YCaieJDZceEvLMtnKmyOD7smZ/KAd/Ed/DTIlS68WfBOJOt1PxI+N/lbHHkAx
	7Wcny+2w7k+eKgPhqkN0qZaXWq8m8ghSeDOceg+AUgurkgCZapQrh2hFXwgnjeLBfJW6MnDtZv7
	AhWhKVOdEHrEJdT4dDdlyR09/PADf7ULrCk1UB7gFxPWiKDVnH+kiqp3Ic0usUj082RFVfzRX0T
	WmbcunB9wC6NG5Ohgs3kUoKPFkbfp+wXK6oBYsZd9upL/FBUWbWO9U/aSOj40b4QRnuwjr7l4pc
	AIz5j6kqGaLbCYhUGUzZ53SAIRvg1lIHW2lnV4y5PvSVc5PS/+E4/CsGL
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr27089117f8f.45.1794904343236;
        Tue, 17 Nov 2026 00:32:23 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm43646659f8f.44.2026.11.17.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:32:22 -0800 (PST)
Message-ID: <fd39200976086130cc82d59699a988fc3e0689cf.camel@amutable.com>
Subject: Re: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:32:20 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/openpromfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index fb8d84bdedfb2..6cd02d456bac9 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/seq_file.h>
> @@ -419,6 +420,7 @@ static const struct fs_context_operations
> openpromfs_context_ops =3D {
> =C2=A0
> =C2=A0static int openpromfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &openpromfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
