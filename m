Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26744C659
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960195; cv=pass; b=NF8iIcbJLTCBFWU2YUgsvjVV/hafJbjUCL640DPCNs17YHlOSfUOAlhavGo3/Z+zWrf39GbEH+fMUL16MoeSygwAtBKaP1f78fjS5Ns/oZQ+Si3OTtPE/aANZwdhumu1Li8hFH/AMdJNXB6rvtzO89M8G03TojALgaIn+ZvBxHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960195; c=relaxed/simple;
	bh=kF9c+8KKO+ipWwSE4hjYVCkfFFSKZ4K0zjQHaC5WzaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zotll3bnxtjn915btt3w0epM+5kNKHYhzRjy4dHNDftnjrUjP5XRYsPB9FLbAg5JxOzuuPAbCdb59AuPRwgL5+40sujJXKebIPdQoFtrl/4LOfPb0cQ3TD/FRd+GVXH76TiHhLKQQyp/MzdWpf80bnHX8i+aJ/dd5n7XL2FnH/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLoD31v+; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLoD31v+"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a980c01033so5083511fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 23:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791960192; cv=none;
        d=google.com; s=arc-20260327;
        b=chFy+MqgVu9Q6ks9Zf73GRpn6bh/UGaIgHYt+Ck1cgG0BYRiRSljhN5c3YDU/hyggg
         xWU+QdQXTE61nnH2mliajsNNxtZ7ZCn9KTC7DJN5wbjIR72BRGYgaJEiGm8kUnDLNBVp
         4AWxXOnWGerH4COp9kC9ZfikQ9vrKHrQr3P9h2XdxKEkg7gnLwMm9r7KY5kYCuHebrUS
         3zHPdUFpCQe4Gh/aMjzYYzulLGSy1fhHTnOJevqA3IyNx+mRdvQCl0fDXSp+lqlatEJ3
         4vmMjYU/niW/7uR6MQspCYQQ6bPSddhrOdpPUgZgu0RGMebNvMKPucYC2eCIUxpMeq3O
         9HmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZwsjYHPheqBa+JzSbow2ZB78X+lBjsll/uWCTK8ljxY=;
        fh=6AK2X7PTQ0sdLEM8waxGkhwlJhWjhzPrDM/6q2VDqO0=;
        b=l1DdpQAFProrsToqKtYLCMSVhVS0uAs+WD6PwMgpyrI1KgAjc0ZeNjhMQxUUfOB/cN
         ggDBlDdHWDVHgN9minMcoVUPIaRYBswHz4Bn95iAFvlbHqQXCuJrMN9oZuCW33Sz2Dnf
         wtGohZfVDUvu2WDTj9aup5rqt/GalcoOz2UWIZOK6RCOvq3uFNKFJNjJNwuDIp69/vBb
         5UtVVIjpYTus1FK+We3ombAw/CTqiYlId6sz1x+daU83pF62mmtvwdsEPDjeo+PUP1Ep
         0Cak8mjrAhJqid66vG35EjbrqbWCbOehFKT94uj2gzbrVlfMR2So7pmQlG9YCAYqZ0bt
         OOug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791960192; x=1792564992; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZwsjYHPheqBa+JzSbow2ZB78X+lBjsll/uWCTK8ljxY=;
        b=CLoD31v+l1P72fEBKMMdTK/TXv9KLYzmoKJNius6R6Byr8VKxMGnOOzvfpavPXzbz9
         qiRs7/egnR+74oM8DggBI8FU859CG5PQ2cN5BOWJq0amkZ+nKidrM49O11RHAC7zQKLr
         crF/kJD1Wp/UkMsdRlCXbI1ooqI9nQLlhGf+RRPWspNKKSAB5T0d0l8XJJCUFsH/YenU
         rcPJRWd8r96/8jjRxcu1sTGCKIuD7DmSVcyt87IpbbGYgvuJZdP2sQF4thbB5jKphRgq
         3NRw80c1OQSuhCVzr1Yju7hgD6iAwwec+4RRmi+hhInmQ5E9s7vYi1FxBzksp5io1Jlp
         154g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791960192; x=1792564992;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZwsjYHPheqBa+JzSbow2ZB78X+lBjsll/uWCTK8ljxY=;
        b=xLyA9UQZqZDq7/gOCBU1xD45a8nzqQhqHdEup4jjgk7+ywSbgPXmFmPlN4hV/o8URY
         WBRUP66OaVqRe5i5AjtUrCAItnAAyNsO4sVIqhN5kZJaI/lnDff3V74S9Qhf6MzHUbCi
         yqAgJjJR3z0B9XQ3QQG9zlsUfB4RnQZQ/eqX6wOc/VlgmeBmaR45uoJOHZ4/EBe8v0UJ
         UjgAMEaHWvhaHEiGjUrY8RMHZ0/oTLgBQX8mZLCTqr9c0acyF8Z/3ci5nnyCZboC8pEC
         1Y5G6rVY+F1PhlQw13QeLO+FhuS9vhwERE9MfnrX57YHuDaA/Uc5IYi2QKNdlP9+WGRg
         qIwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzg/fk0yrR69GQFROG6Ydv7MPNcNjPEGTqyBOeYFT5hn1idmZ9K+sCAhtBztWq/M7H1gI4bl1mcPA8Zvyt3@vger.kernel.org
X-Gm-Message-State: AFq9FYKcjdEAo/GZSDwrJ1HJhnbP6r9lKWmLmuRdxBvv8OPBAXKDK6JJ
	OyfC4d+VGQyWyReaonaPuMxS7qNLKi+jQMCA9dx/Hdm3Lhv46DdG/MxgErGp9lBEnBkQ+1yVHxW
	Wyht/8qirxmVApJcwCM/UkqJ+4ooYeMM=
X-Gm-Gg: AYBFou0VjlvouPUiPPjrAg7jf6wYvckwbeyGart7SVk6/EBmNl46BHhPLXxYzFOQYwB
	upllaC+MSZWoMiErTTakFuC26UIXMuaIGqkXyVkG/hGpnLz2FKV/pWNnwiFhm0t548iYp0uDeZW
	Yr4zGXvnVjE9GAVLTq30KKfiof6xDDNgA4uSXmWGxk7wcSpwDhtmtZG5rFGIuee8jQj+KWpIZsm
	R8ebwvlRSq73dwkHDi4IPccl33qqj3T+FgyGAin6Bzz52lOuJwi1w37wjf0cl375ZKPBSS5SFCi
	NAwKsj/VHc/Rp4mYLIlvHweiwpP3V3usW6PMLjvzBySG6eEhwZF5k/fBkzMzv+0f4ya7bxJwi80
	eKp+AXSgb7/f2nXnikWI4cy+OdtcvyLtEziOtt6ZJaeoQzMNvF5bc9Lqw3EplxsqK0AawJ9fthQ
	==
X-Received: by 2002:a2e:b888:0:b0:3a9:82c2:ec1e with SMTP id
 38308e7fff4ca-3a9c537ed07mr33111191fa.15.1791960191931; Tue, 13 Oct 2026
 23:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929094812.93374-1-tkhandelwal32@gmail.com> <CAPwBhz_ow3BFEns2WL69Gj2BmOHGiFOEzP7U-=FfzSvoH=DZSA@mail.gmail.com>
In-Reply-To: <CAPwBhz_ow3BFEns2WL69Gj2BmOHGiFOEzP7U-=FfzSvoH=DZSA@mail.gmail.com>
From: Tarun Khandelwal <tkhandelwal32@gmail.com>
Date: Wed, 14 Oct 2026 12:12:34 +0530
X-Gm-Features: AclHuK_roABVrEaRhuHK5p8P-AhgVeh6e8Rm4bmNzCFIfTidAX3p_1c6lDNfvkM
Message-ID: <CAPwBhz-yAXeZTca0iFT=9fVhD8k7rUQBtjNKCw_FKPFzYFC2gw@mail.gmail.com>
Subject: Re: [PATCH] fuse: propagate SB_POSIXACL to submounts
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, German Maglione <gmaglione@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Tarun Khandelwal <tarun@supabase.io>
Content-Type: text/plain; charset="UTF-8"

(Resending as plain text, the lists bounced the previous copy.)

Hi Miklos,

Gentle ping on this one.

It fixes POSIX ACLs being unusable (and not enforced) on virtiofs
submounts, so it may be a candidate for fixes. If leaving SB_POSIXACL
off submounts was intentional, I'm happy to rework or drop it.

Thanks,
Tarun

On Wed, 14 Oct 2026 at 11:22, Tarun Khandelwal <tkhandelwal32@gmail.com> wrote:
>
> Hi Miklos,
>
> Gentle ping on this one.
>
> It fixes POSIX ACLs being unusable (and not enforced) on virtiofs
> submounts, so it may be a candidate for fixes. If leaving SB_POSIXACL
> off submounts was intentional, I'm happy to rework or drop it.
>
> Thanks,
> Tarun
>
> On Tue, 29 Sept 2026 at 15:18, Tarun Khandelwal <tkhandelwal32@gmail.com> wrote:
>>
>> From: Tarun Khandelwal <tarun@supabase.io>
>>
>> fuse_fill_super_common() always sets SB_POSIXACL on the superblock, but
>> fuse_fill_super_submount() never does. Submount superblocks are created
>> from an fs_context with no sb_flags, so the superblock of an automounted
>> FUSE_ATTR_SUBMOUNT directory (e.g. a virtiofs export containing another
>> host mount) lacks SB_POSIXACL, even though it shares the fuse_conn, and
>> thus fc->posix_acl, with its parent.
>>
>> Since IS_POSIXACL() is false on such a submount, the VFS:
>>
>>  - fails setting POSIX ACLs with -EOPNOTSUPP and hides existing ACLs,
>>    without sending any request to the server;
>>  - applies the umask itself on create, so default ACLs on the server are
>>    not honoured for new files;
>>  - skips ACL checks in acl_permission_check(), so with
>>    default_permissions (implied by FUSE_POSIX_ACL) access is decided by
>>    the mode bits alone and restrictive ACL entries are not enforced.
>>
>> Copy SB_POSIXACL from the parent superblock, as is already done for the
>> other superblock fields inherited from it. It cannot be set in
>> fuse_sb_defaults(), because fuse_fill_super_common() checks whether the
>> flag was passed at mount time to decide fc->dont_mask before setting it.
>>
>> Reproducer, with virtiofsd 1.10.0 started with --posix-acl and an export
>> containing a nested mount:
>>
>>   host# mount -t tmpfs none /srv/share
>>   host# mkdir /srv/share/child
>>   host# mount -t tmpfs none /srv/share/child
>>   host# touch /srv/share/rootfile /srv/share/child/childfile
>>   guest# mount -t virtiofs <tag> /mnt
>>   guest# setfacl -m u:12345:rw /mnt/rootfile           # works
>>   guest# setfacl -m u:12345:rw /mnt/child/childfile
>>   setfacl: /mnt/child/childfile: Operation not supported
>>
>> With this patch the second setfacl succeeds, ACLs set on the host are
>> reported by getfacl on the submount, and default ACLs and ACL-based
>> access checks behave the same as on the root mount. Tested on v7.3-rc5
>> in a QEMU guest.
>>
>> Signed-off-by: Tarun Khandelwal <tarun@supabase.io>
>> ---
>> I wasn't sure whether leaving SB_POSIXACL off submount superblocks was
>> intentional. I would have opened an issue first, but since the fix is a
>> one-liner I'm sending the patch directly. If there is a reason for the
>> current behaviour, I'm happy to rework this or drop it.
>>
>>  fs/fuse/inode.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index e9552be36..ef3c7fac4 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1629,6 +1629,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
>>         WARN_ON(sb->s_bdi != &noop_backing_dev_info);
>>         sb->s_bdi = bdi_get(parent_sb->s_bdi);
>>
>> +       sb->s_flags |= parent_sb->s_flags & SB_POSIXACL;
>> +
>>         sb->s_xattr = parent_sb->s_xattr;
>>         sb->s_export_op = parent_sb->s_export_op;
>>         sb->s_time_gran = parent_sb->s_time_gran;
>> --
>> 2.43.0
>>
