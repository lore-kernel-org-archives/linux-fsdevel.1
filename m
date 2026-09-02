Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F007395AF0
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377712; cv=none; b=iUdhIcEby/BpcnkB4VAuBriuPkHdgCggI1bEh0ZS1DCQq4CvkZrKEu7I5t8UM1jDP4I024XmZrpfyZVWWBx6UUn6ZVOPmA+ZqaWdxsnjgryVDWmwApZbO5ppn7p+48VWeaVXYpvC4CKN7mgosgJfAnKlzQTdfpfBC+uNIj5zhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377712; c=relaxed/simple;
	bh=3WGPUky1hmwDKOIR30PGoglOqPg/CfPHhhz1D/WGWTI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=scPXL85E/cpbEjTo497B9HnKaMrC+72r13+SqSwAsaehnt/jt00gn2UJaricYLHSKoWl8ZHXGs6vWnqxFaac+EAXrnUNvs7icyRjCC9hZN1x0W2k7sq4FTTOcd5xAvDkUuFvMZRdCJgiZlKdYUbhhAnNidI2mnXS9INkCo2UpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dA1yL4xF; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dA1yL4xF"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5304310b3e0so3009901cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788377689; x=1788982489; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tTllqewIXAY5+sR//IBZWAZfUENL/NuhQCFU0zl+dm8=;
        b=dA1yL4xFmI/xLm4gRSWgFben1ST4myVImRVF3JDQcxKkV0fYD1Ntg9aKbmMS+Z+l78
         1/PWPbsjSZySmLHZideqKf+2aZzOLMAX9z2/84wXgSVlWbAm5hXDMv9KcEjc/puDweL3
         S6hUENsBnMQqsWYW9wDYNaFFFD1w8xhepjmDHisqycyUmz76aqSpxZvHM4OwoAAiQvlw
         62c4LWA0DWUYE6qqfOJzANDT6279+eDBPO0QC5/KDtprAIrbEoN2zG0aTCWDkC8nh72q
         TxsRBcE/AJeHtQGYCav2Fm3C30T4flhV5XQnCvzHynsxo+HzPMRVXjx9/tNF0MFsGTZa
         6OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377689; x=1788982489;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTllqewIXAY5+sR//IBZWAZfUENL/NuhQCFU0zl+dm8=;
        b=eB4O3p6EeSecLwL2l7H4+DLkY/aVIcGTLJOnR7SHiQ33Qrk9x94YMrIVVf/8G+hVTn
         6ATZCXMJJky2fMlmtvJSei5RReaPRaN4UMGO8OctCGbKPTLTWzIC8h2NMLydUq4anSgI
         my3kD2qRlmz4N9oN0Kh/YPCK9zmCMJVNnDlBT1O9ao0iiqtPTScsZhoxE/SKGkj1WSSW
         gzqF8UoyEpEG2D3BMiVLcu6wGOgZ78yUIj7DllYlk84F7Nsi4DiP3aDrgve1fuNK86Wr
         onnOztK/YrAxBRjmDw0BbGo/Phd98q1Xc5jixcC25kHAjxPzY0w1TZulNSzuDl6dfbjY
         M/sg==
X-Forwarded-Encrypted: i=1; AKwUvBzzLLGv8S0TtlmI4eMsPt1HjDx76dtUGqVIC+YWWLOkDglH86EH1NA+YX8XMnRm9ubnKohSz/m+VngVVVyI@vger.kernel.org
X-Gm-Message-State: AFuF++keW3DZExC8pk485zm+rgxrTJ32oMhvr7r9Owrqy27+DwD5mLeA
	addMVDcY9XHaEDJFF/7sZf6xz6ad8CSPEKgQPXYWPvmsCEVJ3PiFInWAfYZklJXXsQ==
X-Gm-Gg: AYBFou1Edn64bmOxVD4aDnI6nLRH+vx1XLV9EcTbvM7jYpSmNiT4MkpHn0yvSkj4Iti
	lC0u+M1g203QRSTvoWpyZGPlNxNkchjCRSZ0D75rFVaJB654XdpCSrne9KXwUfkyiOGNNhPhzIM
	gJhJPM/LCuw0JCaRHgdeT3I59GR+leKl1DU3zxBGBINuxowm5PXoVhi7F0Bf3JPG2/qDwGd8OMa
	AsKtWaYn7oi08DPSHuSeLQEZ8LSe6yFkYwsem5viiwbFuOiMxQySNNEa178CSY56GtuMLxx1Fjz
	DGAj2Sz2o+uKcOa6emUa5pDs3oO/xnRJq1F0ND0IjX1CKx8ey/dh0W+w6YEDgNY8kkGg2cP/MRQ
	41Njt/y48952VqR5guRDyUunWO/Wm5zd7+LVEgp0geIv8FBJgc0hqkCWVG2h3p0r9zgotgk6lFZ
	FObp16ZG940sVpfNWAWo6s/uPiXd2mv7rPl04fUhXVAtxfLZjN7KxSAendVAp9rCQbmFZz5Dcsk
	LG79Aa+tvkZvyTcBurTdVBkrA5WbOsVUA==
X-Received: by 2002:a05:622a:1f8d:b0:51b:f25c:2896 with SMTP id d75a77b69052e-53036bfdbebmr93564831cf.11.1788377688931;
        Wed, 02 Sep 2026 12:34:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53033252530sm25672391cf.28.2026.09.02.12.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:48 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:34:47 -0400
Message-ID: <4bcb6be827e73a667592e7110ba78682@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260902_1319/pstg-lib:20260901_1604/pstg-pwork:20260902_1319
From: Paul Moore <paul@paul-moore.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Seth Forshee <sforshee@kernel.org>, linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 12/27] fs: port ->permission() to pass const mnt_idmap
References: <20260901-work-idmap-const-v1-12-54ccd48e100b@kernel.org>
In-Reply-To: <20260901-work-idmap-const-v1-12-54ccd48e100b@kernel.org>

On Sep  1, 2026 Christian Brauner <brauner@kernel.org> wrote:
> 
> Convert to const struct mnt_idmap.
> 
> A mount's idmapping is immutable. The only thing that is allowed to be
> modified afterwards is the reference count and that is hidden behind
> mnt_idmap_get() and mnt_idmap_put(). Everything else only ever reads
> from the idmapping. This is the same model that struct cred uses and the
> idmapping is also rather sensitive.
> 
> So make the idmap argument const wherever we can. The conversion is done
> from the bottom up so callers can continue to pass a non-const pointer
> to a const parameter until the conversion is finished.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  Documentation/filesystems/locking.rst |  2 +-
>  Documentation/filesystems/vfs.rst     |  2 +-
>  fs/afs/internal.h                     |  2 +-
>  fs/afs/security.c                     |  2 +-
>  fs/attr.c                             |  2 +-
>  fs/autofs/root.c                      |  4 ++--
>  fs/bad_inode.c                        |  2 +-
>  fs/btrfs/inode.c                      |  2 +-
>  fs/btrfs/ioctl.c                      |  2 +-
>  fs/ceph/inode.c                       |  2 +-
>  fs/ceph/super.h                       |  2 +-
>  fs/coda/coda_linux.h                  |  2 +-
>  fs/coda/dir.c                         |  2 +-
>  fs/coda/pioctl.c                      |  4 ++--
>  fs/ecryptfs/inode.c                   |  2 +-
>  fs/failfs.c                           |  2 +-
>  fs/fuse/dir.c                         |  2 +-
>  fs/gfs2/inode.c                       |  2 +-
>  fs/gfs2/inode.h                       |  2 +-
>  fs/hostfs/hostfs_kern.c               |  2 +-
>  fs/internal.h                         |  2 +-
>  fs/kernfs/inode.c                     |  2 +-
>  fs/kernfs/kernfs-internal.h           |  2 +-
>  fs/namei.c                            | 22 +++++++++++-----------
>  fs/nfs/dir.c                          |  2 +-
>  fs/nilfs2/inode.c                     |  2 +-
>  fs/nilfs2/nilfs.h                     |  2 +-
>  fs/ocfs2/file.c                       |  2 +-
>  fs/ocfs2/file.h                       |  2 +-
>  fs/orangefs/inode.c                   |  2 +-
>  fs/orangefs/orangefs-kernel.h         |  2 +-
>  fs/overlayfs/inode.c                  |  2 +-
>  fs/overlayfs/overlayfs.h              |  2 +-
>  fs/proc/base.c                        |  4 ++--
>  fs/proc/fd.c                          |  4 ++--
>  fs/proc/fd.h                          |  2 +-
>  fs/proc/proc_sysctl.c                 |  2 +-
>  fs/smb/client/cifsfs.c                |  2 +-
>  fs/smb/server/vfs.c                   |  2 +-
>  fs/smb/server/vfs.h                   |  2 +-
>  fs/tracefs/inode.c                    |  2 +-
>  include/linux/fs.h                    |  8 ++++----
>  include/linux/nfs_fs.h                |  2 +-
>  security/selinux/selinuxfs.c          |  2 +-
>  44 files changed, 61 insertions(+), 61 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (SELinux)

--
paul-moore.com
