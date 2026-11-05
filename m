Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793908147;
	b=VB9QHLN1Vm/CXWaAQS0O5ZbIy0qZ9Uv4NwF6NKsF+nPQFuVysp0u8VCQN1J9j66gMisN
	 rwLxtq/4hicBCp8bcEacOOzIe3K/MKwkFZiq+u9uOCqtH7FENK+rjpQJ3YE6EEqacG6cI
	 wxhGvWSEwGsCHZYYY6WYTwAcuYLMET7+ZN09DXHbwz3cAQ/i1pfodS/bOXmzP6ZkPS2h9
	 nt5e4JsKdgxzMkElBvYHUkBizPO0MrSQO9Rvb4J6KAiLQUtCa0SHNl1n+ajLN54LwrJBB
	 OrtSusxnQQxwXNLiKjzWCDvRX8+d5lDryTSZS/vlAsC8FO2Zgv+BtmuDgQ+Hd65Lw4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=N5scGhz5LxdwjNU1yVLwQJMho5xvAY73RNio+z9h7DA=;
	b=rSD/JoAULY+ke7yJAf6xq7g78ih0CUeDdc8knclOm6MkstTem0p3t3Zx6fiazgcSyaqP
	 AaDyOfdHyqVC0sriMIDB00BBo6BucxSL4XZvMjMCVsOYbHCA8a5Q61pw6/IRlVtr6R9hS
	 gFldaXNbsyQ6fUB5JFzn7CJk1UbmucpUk4Vzs8fMD3OuKDM+ATcIbg/4AklXnh4nTBFai
	 VcOpV0b3su21TZ8kOOt16fOekijWq2+rXA06Zg9RmgsZoS/iI1aWwyge5/3u+WzWAmf+j
	 Ft6Ixum2pgY9ZxVVXgKOx5q3fWXgQxCLUA25zO3bQGKK1KOLy5MP/9wOxvncBp722yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=databricks.com;
	spf=pass smtp.mailfrom=databricks.com;
	dkim=pass header.d=databricks.com header.i=@databricks.com header.a=rsa-sha256 header.s=google header.b=NDtf8UjY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65C606D510
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 19:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F65C606D510
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=databricks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=databricks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=databricks.com header.i=@databricks.com header.a=rsa-sha256 header.s=google header.b=NDtf8UjY
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-679e6ab6471so1059876d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 11:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793908146; cv=none;
        d=google.com; s=arc-20260327;
        b=dEDMsDGO6slueqzr4xTlEIIcZIgorhsv05xeUVDiE57FUa2Z+jpj3NAFLB1cGqmyRW
         HxdMU8VqDN2eC/ZFSMd/vzZJHeDnNoG290+pxcWWxBENAKHr2rCt7Zx1oyrz9O2aNou+
         7Ordk2UqacIuwl942NMhQJlk6Q1/HmSXFOQ7XAFrZfrIhhTsoVS21Zuh5iS6rEZDZc+N
         gOiB2sAJNmdgiFnhSBpPzZs6sRfhXPrjeFc5HOkZYy/Qj4REpZ0Mc3B8dKUk98UFZdvx
         Ho3uoCvx2f8qMZJHFPsnycrGvdOiL5CJNOGSh5e3TCp7lGPhiZ1Nf39RLaeMWZ6Al5ct
         GNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=N5scGhz5LxdwjNU1yVLwQJMho5xvAY73RNio+z9h7DA=;
        fh=ENuSgE8qqMXxAp/8TU9QI06+UAkRBbvczcq6C1gn38I=;
        b=YVthcNypgRY6eIdBx98JrOLY9hPhWD6oJ3Yo1YdCSZlEij3fGbRPlb19J+iNhe16cU
         n1eh++EkqfnWAzd+ps1o1ZNJayEtZUk9d4pbJKyE+cFCK8joNTh0IeDnGwtiCalEQ9r8
         yBjAmhwgw09lDtRtATMk7WwGC+LDgcn/wi0+rldqBG5OohEMg1ma/eH+maWYMqzsGjS1
         CPl280g7KoOA6emiUeYsYY/iSWvkea0zBfg4oUdswujumBeTGsSw/kIPF5LQwEXwNkkW
         ij3rhKOz2FSW2yRUOxaZNWhbuSW6wY0gj2M7DxhsxFkJikbxNSijS2STEdkXs7FczByQ
         H12w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=databricks.com; s=google; t=1793908146; x=1794512946; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N5scGhz5LxdwjNU1yVLwQJMho5xvAY73RNio+z9h7DA=;
        b=NDtf8UjYO1SM4bYzH6d3Qn3OABrWEv+rCx6bstt4X0ASNc647KopUmC8slRCxA6qOo
         OtVq1uKyThrHSnUAkRdj9O5cwAWCOceJCLvIHobdVKppyfSY1vYfg0Ml2x8dms+W9r7T
         LyyKLe+fvyAJsqd2BBYeBKwgjBy5+aWAGYw6iv1wDSgMWV9pPHGcDL2kSknFg8+h+VJo
         iKuz2Y924a7c0jaKclqdk/Jvp0xuT+J1LbrozS2/2h1N+D3FOad0HyL1N/WG6FIH4669
         PCfFqmGzS0bN9Ab+N6942ciWemdDP2fecMPl7MCt/cOp+m6ApMV/0yhqkYCGTu9/Et0f
         KKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793908146; x=1794512946;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N5scGhz5LxdwjNU1yVLwQJMho5xvAY73RNio+z9h7DA=;
        b=v84fMW8nTasW8cXiUcKFWkPcMZ1bVzkGyMRvyW0I/kuqfHsNupZfpAyL/wqdYAaJZl
         xHFNTHl37b3KcdsBfiTFczzUyPsJgAmFUJsCBBsEykq/1RI8NNmSxZO87ro//YiytUAr
         tcBxoWxXgX7VKjtqf7ucAR7OA09R7IJpI4HW3LIzI/h5QOXbqvj+cId/dUTY886JFBo3
         kh2AhdY4KfSKoWzXL20wmOjC+tKYbPgip0A0LkZWSLJrMIWn/FTAYfVffd3Uotf4rKU8
         mLhhz2GVdjm1F18v/Gw/NQT54Kr3nALIR1GM3T0HAE2Gq/A1l3ElBxxstwu0/elmJHR/
         hjFw==
X-Forwarded-Encrypted: i=1; AL+hErHcshJvatS64f+3oUeFcGb/IGosg6xCJIsofZ5t0g8PqmsivRqrDliP+bo78IYJxcqCWjx0UDATrOYn99pA@vger.kernel.org
X-Gm-Message-State: APuU4Z8tF8yObJ76SkMUf+mSLezCbHNynjHIEaX3HBHmMIyhhuSWwo+3
	2kWsoi58XMumaxA5V7ACgCx5z7oQGClgTUOLprNwU93hVEC4/t3TaUfv1wxuvzYk4MfJA2RpNU2
	8zYM6yfsMBhGKIjnnGDaVA/TQSgBQf6QZOYRkq3+Rug==
X-Gm-Gg: AYBFou1GB5uAbnnGoDRG+Wj4x00BEcR5edscMsotHuOGKbH2z2Ynh/sseL/ww6jVsCg
	bUSMZwXh2HCgO4MkRqX6ksnEg8uFkfxli7sG63PTBj01pMR+/g24h0I9F8TBHlVBmATyAgcdkUq
	mBpMMzJ42nElV+H4UjDl2Wf1a4BgBblWvHBtYh4oDSOAi5s9oyLbvTnZv3JtvCK7N2Y2Ds5ZcuD
	xWX1kDOWRk5Oyr1OwicdJ+BkLEdf50roJ147IGNoVWZffgwnDHs/XipF8wkoywmzCUv8O/whpUz
	7cHRj4a5gUGTfFdb4mjhNx1w0Cs3gVcLr24IoUvUgFIk/KSdZO16c81XbCTSrng7MY66Hg9y1Hr
	gf5xUDchJS9V7rb59ke/teL5s4vC7n11k0ks=
X-Received: by 2002:a53:c045:0:10b0:673:e272:f3ec with SMTP id
 956f58d0204a3-67c03574d3cmr1676191d50.16.1793908146013; Thu, 05 Nov 2026
 11:49:06 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Lakshita Jain <lakshita.jain@databricks.com>
Date: Thu, 5 Nov 2026 11:48:53 -0800
X-Gm-Features: AclHuK86O9Kk2D4NIGqxQ7jet_z__LeBB-Hzqe3C7yoJqWGYxhQHMmpa1pCI8qQ
Message-ID: <CALE1rk6tGt_Pe7CpFL1NSTgugVpXLH_iguO2D9VsAVHn1p-02w@mail.gmail.com>
Subject: [REGRESSION] fuse: non-owner POSIX ACL writes get EPERM before
 reaching daemons without default_permissions (since 6.2)
To: brauner@kernel.org, miklos@szeredi.hu
Cc: sforshee@kernel.org, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Christian, Miklos,

Since 6.2, a non-owner setting system.posix_acl_access on a
host-mounted FUSE filesystem gets EPERM before the request reaches the
daemon, when the daemon does not set FUSE_POSIX_ACL and is mounted
without default_permissions. Before 6.2 the write was passed through
and the daemon made the decision.

User-visible effect: on a FUSE filesystem that reports files as owned
by root and does its own permission checks, a non-root user running
"sed -i" gets "preserving permissions for './sedXXXXXX': Operation not
permitted", and "install -m 644" fails, even on files the user just
created. chmod on the same files works.

The check that rejects it is in set_posix_acl(), reached from
vfs_set_acl() since 318e66856dde ("xattr: use posix acl api"):

    if (!inode_owner_or_capable(idmap, inode))
            return -EPERM;
    ...
    return inode->i_op->set_acl(idmap, dentry, acl, type);

facd61053cff ("fuse: fixes after adapting to new posix acl api",
https://lore.kernel.org/all/20230118-fs-fuse-acl-v1-1-a628a9bb55ef@kernel.org/)
restored passing these ACLs through to daemons without FUSE_POSIX_ACL,
but this owner check still runs first. In v6.1, the same write went
through fuse_xattr_handler, and xattr_permission() places no VFS
restriction on system.* xattrs, so the daemon saw it.

For daemons without default_permissions, FUSE already leaves
permission decisions to the daemon for attribute changes:
fuse_setattr() sets ATTR_FORCE, so chmod/chown/utimes skip the VFS
owner checks. Would it make sense to treat POSIX ACL writes the same
way, i.e. not apply the owner check in set_posix_acl() for FUSE inodes
without default_permissions, and let the daemon decide? Happy to test
a patch.

Reproducer

libfuse's example/passthrough shows it, using libfuse's generic
uid=/gid= option to report every file as owned by root. As an
unprivileged user (mounted without default_permissions), in a
directory that user owns:

    $ ./passthrough -f -s -d -o uid=0,gid=0 /tmp/mnt 2>fuse.log &
    $ cd /tmp/mnt$HOME && echo hello > f.txt
    $ sed -i s/hello/hi/ f.txt
    sed: preserving permissions for './sedtTZojI': Operation not permitted
    $ install -m 644 f.txt g.txt
    install: setting permissions for 'g.txt': Operation not permitted
    $ echo $?
    1
    $ chmod 600 f.txt        # succeeds

fuse.log contains no SETXATTR request. Without -o uid=0,gid=0, both
commands succeed and fuse.log shows two SETXATTR requests for
system.posix_acl_access.

Tested on 7.0 (Ubuntu 7.0.0-1014-aws, libfuse 3.14.0). We see the same
failure on 6.8 hosts in production.

Thanks,
Lakshita Jain
Databricks
