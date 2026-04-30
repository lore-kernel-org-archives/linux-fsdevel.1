Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190C40DFD7
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777523641; cv=pass; b=EAs7Cxs+7VqrmS5w/zTgETQKZ5sllh4hjMH5F0i+zBa+cK4PMURxU+HfDBs+RPwtgtFQRGtNCXauq/YCwNf2yiyFkKBg58dLmxcSv9e0RLAlqE4AvOFwPUel7SZ66iBsrS3eZPP7Y+gu0c9P5rujj0Y9HPx28uu2DCAdgUuUl2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777523641; c=relaxed/simple;
	bh=GUdIAWCWBvZ87PdCZf77qJNo0fjqOsqh1svrUL2Ht70=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iGha/P5yBzMGuzlbzTr9LX1xuzYvUTRcQeb6qZ+1wqGNraLxdT5qiCm2IUYNXXtG3z0C0dUG+wnxQtJ96GJYGFfILyZjBq3mGsIpJVMD1k73rjuSEhFi2bOnANWybkIHgsBNpFKTs/OARCAXHTdCa2nya7A9wup8QHRo4hLHbZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEWSnfZn; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEWSnfZn"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-656d749109cso249729d50.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 21:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777523638; cv=none;
        d=google.com; s=arc-20240605;
        b=W2ok+Hed5FoLBOZbzjMO06lhhUzpcaS/lqevQqn3P0WQAvaRSH5LQ+TQR2N/0Ui/XP
         5VPI1gvAp+MGrh/yzCqMNCC37ZgXdYQVTBiZ6FErUgMdn1bcko+jzsYOTo1eY4b45OtA
         WbvVVJ6EyD/wIKlMtYmRtlt+hbTHmZWk86RzTPvFp2rb3e1hLs25ulFFKHlIBL5YMnk6
         Y59Mv+pfBSLiJMzhXl5Ui8cS/xJRP2ezzH6meyuUZMC4188nvITVHAC8KAIkVQ4OCXf5
         gY/E818tGVbgJlyb3wLOfjWzcI6Ovhm0f9/EpQsVOE+znWDnwuqz9Rb20nrMc51Molhm
         fACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ReTcQ8WomYbvcLoKBR3DjWCQ3wtT0PpRDdgNLjlgfSQ=;
        fh=7yzVB5GHoApDxsP1Y24r6qzk2eDCEJTTJVIlHqll2/I=;
        b=bqw6arT6XYaFy5ylM6u5tL0YPykv+KdWC1wFXwlfnJjiXRfKR8QugrpHBZXnZ/D2pI
         Qs5cA759+wGWzz0ptvazvBNE4pIAN+fDMTiQXop7gBanD8GJ20Q+SdD3CpByy80XwW72
         Lp5f+abqeQzFd3b8Jr8hb9vePw52+bfe53xHSa/IksPZbJKx5eeSF6z5DpBw7l17xqgv
         p4bjanlHVSJJIR5/GZnzbKjbzFq5Zf+Ku1UcTz/QwkCGuEnZIw3OLh/ttOuGZTkB4OVp
         BHGBt9LokOng+khYgdnW6Sw+hs8K+RUlV/seBV620CYkPvlLDlMezxgp5FtMMvH0AJ60
         mvXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777523638; x=1778128438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ReTcQ8WomYbvcLoKBR3DjWCQ3wtT0PpRDdgNLjlgfSQ=;
        b=BEWSnfZndXsfv/6Uwwh/9J9CK5ihUZmPUFZ9GyZGrN6Srt4o49FGsGe8HylfX2FL/b
         XVSMPwr34l6g+kkDYg1mdE5ITZ+PaL+K8pao5JsyX1v9lPpnnqTTT3GzjSkircnbN4GK
         XreBD5kYKP8A2qLJ/e2IQQ80X/Sni5w/vgY8nKHQ38VKIyxKDLNOXUqM0HaoZKL9u4Ht
         BovF6av9bNT3lJ63zdzrbCBgs3hKwS3Y3vNr2pyhP8JcKwhYu3+T30w7AsQok1Nsdw3k
         Hk0L+KmtwNpgh3pKLTPGO+Ljt5FTrBqhep7YdIuxVdVF/OAvc7a+A7c986bp3SoAxKxu
         SEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777523638; x=1778128438;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReTcQ8WomYbvcLoKBR3DjWCQ3wtT0PpRDdgNLjlgfSQ=;
        b=Qg16wimhKiRKh1j5OhaRhXGbdi1Pf2VAMOd7hpw0Ov+0nqP2VgfHA8LVjAeu5DXumy
         6MqRaXMQadHHriJpoQtmMs0LLKXXBh+yROlTBukPW6QB4TXC4QyUKGunZTJ6HMo8xdrc
         Hv8nuF5ZGpKLpf3y6/wOtqIcVX1meC1h2vUl9Vmx5JKQuCo9dxQH08p9Nkx36WHCfkh/
         PD+LYKEiAde5h83LPxHJoRnx47xq/LurGvNwOMu8YDcwt8ZLD2/ii8UHH5IKJcUGBK+0
         T4VZyeTAz6YQJqve4CkEfIGzbz3ASwhK34LtOJM5FyJPWD2AZ2dxB4+S3otaG+ByJZG6
         Gpnw==
X-Gm-Message-State: AOJu0YzU9ZyqhgBUtPsn5YK3QWPs9vkoMTylxinfOggGnHfFQmbSXY6F
	nH7rhL+Wj1ATL9SnmFkkTt//QWPQqu20hqOvyWvlHd9dEdB9cu7PW6OkkHtLPU4wQKQ1Lk7/jNC
	P/1wCAamCCvIlgi8nYPoONk4SkeE0qtutkNRA
X-Gm-Gg: AeBDievu+6E/RF+n8+9d7DNdX/LUT1tRkr7tH+ismobQRVl5SUEEKpdJIUIqiKHKnQM
	lKMsYL5zmKLFerITwNVzIROR/2aNKKF1sWkfy8Uq0gbexFik0wiRhiM1sFKUY/+JcdgBDbHF+Xs
	KVXFoQIUlXAQmp+CrF316FImm9fxsENk+gSLZbREenOy9M4NtgdcDmo8FEcfa1Y8EJAq7jBxEpH
	j5yPcq74HhuPmOD4FfsHsIcXZrCkHsZDxRLo5/2EvvQ20a9jOtMqGw2HJRRRWL8FKa/BrQYH+un
	mj0SsZWSTpIUtbzguWvRk1AkM5MbweT35p54iG5ryTKhNmECDR5WSiol7tozVSInQegNzxw4ZEO
	CQetlD6E=
X-Received: by 2002:a05:690e:134f:b0:651:b728:6f49 with SMTP id
 956f58d0204a3-65c18f7f291mr894763d50.49.1777523638313; Wed, 29 Apr 2026
 21:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabriel Sakash <gabrielsakash@gmail.com>
Date: Thu, 30 Apr 2026 00:33:47 -0400
X-Gm-Features: AVHnY4I5krczZC4JxofcXK_rmS1EozxPAjbo8i5jIpJKtTz_T6KvLE4l8wu1glY
Message-ID: <CA+PzELx7nhdo9XAJ7v3mb3hzK2LLTv6OOCHNdfnKJojX1ijoaQ@mail.gmail.com>
Subject: Faulty interaction between open_tree_clone and OPEN_TREE_NAMESPACE?
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.

Christian Brauner, I have CC'd you since you're the author of
https://lore.kernel.org/all/20251229-work-empty-namespace-v1-0-
bfb24c7b061f@kernel.org/.

Due to Arch Linux updating the kernel to 7.0.2 today, I have been able to test
the new OPEN_TREE_NAMESPACE open_tree flag on my main workstation.
However, I have found that it and open_tree_attr do not work together.

At the end is the C program I used to test the following.
I expect that the output is something like:
TARGET SOURCE                    FSTYPE OPTIONS PROPAGATION
/               /dev/nvme0n1p2[/@] btrfs         <options> private
But I get:
open_tree_attr /: Operation not permitted

Using "plain" open_tree works as expected. I have narrowed down 3 issues:

1:
fs/namespace.c:5196 => wants_mount_setattr(...) to check if the attribute
changes are sound.
fs/namespace.c:5101 => may_mount() to check if the permission are met

may_mount is:
return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);

Because this is from open_tree_attr, the process has not entered the new mount
namespace yet. This will check if the process has CAP_SYS_ADMIN in the init
user namespace, which it won't.

2:
fs/namespace.c:5198 => do_mount_setattr(&file->f_path, ...)
fs/namespace.c:5198 => path_mounted(path)

This attempts to make the mount attribute changes on the path of the namespace
"file", and not to the (root) mount in the new mount namespace. It will fail on
path_mounted because the namespace "file" won't be the root of the NS FS.

3:
fs/namespace.c:4952 => !anon_ns_root(mnt) && !check_mnt(mnt)

This checks if the mount is anonymous (it won't be), and if not,that
it's in the same
mount namespace as the process (also false).
It appears that the current mount attribute calls aren't set up to handle
mount namespaces different from that of the current process.

This issue is still prevalent when running a VM with a kernel built off of
Linus's master branch. Apologies if this is already known about.

Thank you for your time and good day.



C code to reproduce:
==================================================
#include <fcntl.h>
#include <linux/mount.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mount.h>
#include <syscall.h>
#include <unistd.h>

// linux-api-headers on Arch is only up to 6.19 so /usr/include/linux/mount.h
// doesn't have this constant yet
#define OPEN_TREE_NAMESPACE (1 << 1)

int open_tree_attr(int dirfd, const char *path, unsigned int flags,
                   struct mount_attr *attr) {
    return (int) syscall(SYS_open_tree_attr, dirfd, path, flags, attr,
                         sizeof(struct mount_attr));
}

int main(void) {
    if (unshare(CLONE_NEWUSER) != 0) {
        perror("unsharing user namespace");
        return EXIT_FAILURE;
    }

    struct mount_attr attrs = {.propagation = MS_PRIVATE};

    const int namespace_fd = open_tree_attr(AT_FDCWD, "/",
        OPEN_TREE_CLOEXEC | OPEN_TREE_NAMESPACE, &attrs);

    if (namespace_fd < 0) {
        perror("open_tree_attr /");
        return EXIT_FAILURE;
    }

    if (setns(namespace_fd, CLONE_NEWNS) != 0) {
        perror("setns");
        return EXIT_FAILURE;
    }

    close(namespace_fd);

    char *args[] = {
        "/usr/bin/findmnt",
        "--kernel=listmount", // Needed due to proc not being mounted
        "-o", "+PROPAGATION",
        NULL
    };

    execv(args[0], args);

    perror("exec");
    return EXIT_FAILURE;
}
==================================================
