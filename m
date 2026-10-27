Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135393;
	b=QZBdaSuWSXC15t1QYmtPLMf4lP/NtLIYy2BbKGC4mJFJEhM/zL/3QoK6dG8GMVsIyzrD
	 h3yK9Zky1JEZmXWtHCbKHKpsz79AjA0rdgw20Lm+sVqX73tAetcf5zihzJ5c23RXXA1qC
	 709oNDswBSx1/FA70m5vUQWNPKpkID6UH82huUMp+MrBHEXtK1pSFzGQjYA28Nmw6OMZs
	 vBFayUB4D2/bXTCD0D4QVzDOpvft73QDtBXYe46siKOvf/c5KkrQOvRt1Ls89fdHKx6IV
	 IJ/NeLjXgi7QaD18v0bVNGBYitXSyPgRKICl7zFm9v9WU66NDk+Dx0wMvg9QGP+qggg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=HAhPDfSNI1m9jMsgOVCEGKYJnC7ZRumB7Co5M2j8QiA=;
	b=QtoB5U9BW9lUIajAoMRIf4jrSZbbkPipIBW9x5G8VcmruvULQ+AR/HHWzUmPN49DzYOX
	 ruDTPzbnPKDGMtw6STyTjtmX5tdo3cfoOnyOUQJ8PXP9GlTT4pGSWqvGDbySGeMtbWkas
	 D4fIMFMXp2adu1rIRCe1P65u3XHbf2XQWkfHscrlLuHSJX7z6boIXkEojIoXPl6K68XqY
	 Gx+FyMTySt/LHKaxhAkUL05MdrvmIFFzsZDHcuF2TkcQhYOR+NF8Mcnm2iRv8GW8cWPBi
	 jWMZYNHhVlHFtXrZn6GxqP9m/0GoZZOyCizT552Ceij2YUu5LVccQsljrbNA2lwcpdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hOU79HFU;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767A60A262C
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B767A60A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hOU79HFU
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c11468b5fso3621736d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793135392; x=1793740192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAhPDfSNI1m9jMsgOVCEGKYJnC7ZRumB7Co5M2j8QiA=;
        b=hOU79HFUF5XVQIP1i0LutIU/umJRpfeIAGlIU85PQ+VvN8AhJ2xV/+Ckj7hUn0FiXT
         Vo7Bqt5A2O7gVi2FXZ7LR1GJBkC3682be/KrfbJUx3Oze79iZ02cF+nWdL8HAMH+TkA/
         RqJRdc529Hs/8A6MizbL1tlCPDHiaNo4rAfVeS4PCd+pYvNB8GiE3hhXUKHhQVK+xtN8
         JXcziCJ3xyZB8L1d8uSyg8o8tM/93MhtFnhO+nATDdlG/gpAAJwbl8XdWTjLI3geZAFt
         Fqe9NEA86+d0c+71frtm+HrDiotx5CzEsaAF6tQp+yTnBApEwLxl6fqpDPD3/OU7RekT
         j33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135392; x=1793740192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAhPDfSNI1m9jMsgOVCEGKYJnC7ZRumB7Co5M2j8QiA=;
        b=K5nKCxDql4EmU/yqkPFYyHsHh/k0VSmw/FA8hb7uRTB29scmnRDOmBgKGO3lIeZpb0
         PQDR1Re9BbCEZUtwpfgFSRhdzFc7PxJKNE5VttZUzao8Bfwc8CaGLbHL0OujRA3p32Mr
         p+Kln7XpaXGWEeO6lmg2jZtBqQirHM6FF/ySzzc57rBZGmBJ2iFLdcxLi+6oqFLqVVFI
         bzhAIraXYVB8/kgXKhY23NiRqTi0buVartrNoxTK4tLDFtTZ8gBzQH+GYfazSjag8mUZ
         kkzn5VIzQiH1rq9S09v163TH8VSNkidKZiGpv1xhnRH4Y14RDG7U9mFWJe7OKtHtEvpK
         L/Kg==
X-Forwarded-Encrypted: i=1; AKwUvBzL8uGWEX7HqOI6Qkuh9NBH5LZZWqhKjft2PC0xvy8HMBf6ketV3CdafZlnzwmTgys34J7b6bSXGahCKEk3@vger.kernel.org
X-Gm-Message-State: AFq9FYI7+JHzu0AhQeQUPyYtI2heqdOXRl5q+YVQpO5gEbyMR0TtIGqB
	DvrspraotrTEjoVqjcTzBn51mSOgYQeTdI2WXteJnJ2su7LhH8CwyKTg2JJ2OgI0VdU=
X-Gm-Gg: AYBFou3oSWwa7SUCV1aKhDUcLYnDFj4//pVyn+H8pRsV7+VeCnsaln6K2HnFO/n2iiZ
	/QKZ8h+p7nHwiOAGNuRWOR0OmNoEjdM6NmREqLVrHeq/T2r22OaKhw0ebM70u5URyl6ENXwnDRx
	lF1aI0xr7+fy5rAQqwP3esRtTCJcM60NfVBjU0eV/G4U3pBnKd9Vby6gmvgZGGAANseFbwi6HuN
	9dp2dQS//YqQ5ypNoye9WyV4nc6gjU3dFIQmgn6UGuA5THvibvDALaBDdgWN2eVkJgHmjLkUB/y
	OGbh+svWwclmfNvzWry1R7zBVb7n7HNyldeneyp9UZNqUopy+bseC5DzkY10dU//QfOyO04VZK5
	GbQ5sR7o40eQrQIEw8FHHwVA9Zjlt43v6TIx91D5HvXgM0kS1aKImdyEPJMXzyVbSopUZpEfVET
	sDIUJmCiMptJJnqFmF2BTjQCGIgOfSdQClH+uNbivpELwF6vbwee/M82ONQjaSC6W+oZraWLsOa
	F1K1S6UYdl8CObqxNKqvo3MQbHc/hvz2KpIa7CDJ8QbnT/Jcbia1TcGXCs/DMdVJzufPH82RBD1
	KbqwgXUpe9NIIaBXgQ==
X-Received: by 2002:a05:622a:8887:b0:535:92a6:22f2 with SMTP id d75a77b69052e-53fcb20dfd5mr9618051cf.15.1793135391683;
        Tue, 27 Oct 2026 14:09:51 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c565esm88811961cf.6.2026.10.27.14.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:09:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 21:09:30 +0000
Subject: [PATCH 04/10] btrfs: set SB_I_OVL_USE_SYNC_FS
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-b4-ovl-containerized-sync-v1-4-802e512379a6@toxicpanda.com>
References: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
In-Reply-To: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>, 
 David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793135381; l=741;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=KS+Jdp4IcUSZ6tCav8kl7acTQpMUNvtXOKDv7b4wQHs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJlIHMWE4mD9Fg4D+/nCw/fqbncWcTX25kEPMy8XebnWW9mJFVsO6uNMHNrIavR2Gh6YLS/9QxQ
 cP8BX8zQgBQ0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Metadata is changed in a transaction, and btrfs_sync_fs() waits for the
ordered extents and commits it.  There is no ->write_inode().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7fabb775d4e3..cdecf90bdae0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -981,7 +981,7 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM;
+	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM | SB_I_OVL_USE_SYNC_FS;
 
 	ret = super_setup_bdi(sb);
 	if (ret) {

-- 
2.55.0

