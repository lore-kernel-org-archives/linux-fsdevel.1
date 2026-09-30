Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45250B437
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788947; cv=pass; b=J01awgshu1D6bHkFNJ/DPMy4hylcRR51FQydSI+wse+ukDw0YNcKxiXXI+lM75yJzm9GaDagPQ4KiMnEO6UOYbipqPnobzgVUk7TrPNST2D7ViI+x4l5h9TcZiExSDWePgvBEu+oUBs3yjXfDMFDFC75N7kBkpuelN026beIfho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788947; c=relaxed/simple;
	bh=zRVMMlc5fCEgysqgVDUi/YSuX/Ogj7bmJUVr37RK9ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQT5OqOv9OV8wvZYA4Ozz6QjXlGRbvZTllUAnqFWXykN7OGhB2U2vPSiPYwh3RK//cWTD29urABuFP+WKKHsq+wIG7mEXu337yPByY8zPeJbNyWBGJENnuMdEpET/J+OTzdM/1/cq5t6KEll8EKblP+CxaZgBG1H4LNIRDTwFww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwNGCm9f; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwNGCm9f"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8167e0d1f90so3588509a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 10:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790788943; cv=none;
        d=google.com; s=arc-20260327;
        b=TMdzQ3PPoLpk8vSIjQwIb1FLsWgztzJa71OonZSU3z2eEqJJEQV8bA3jXbmgF2w+9I
         QcERwY51oi2Fbl2zmnxB2+UEZlYKgagzz+MHQhCQQPdJDH71DXmQZH0nomu9nb7rNUYw
         DunG7dDza6VkngdRwx6FXm50o3IWSEZf/PvxI4pitp2W6480KD4EXdjDSH9WX/JlRS8y
         DjxTYb9EiGbM6Y2UOutyEGSpNU/vlfESh/sYWRsOnYcLarIlViR9IW8RAm5d4PMUOfQN
         agqZ/swwcCDNEQwiAR7nWTRWPqkC5YAOfBC37WNMziap/+TM3f1OPaqEE8ewr594zPdU
         LcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yu5vPNZRGHwBy2ovp25s5yW4Pu1HCw1xplpSec6o1bA=;
        fh=X48nnFN4EWX7kMf60hJZ9TUuf6zavisxpKfZ31LDLcA=;
        b=L14oMez99HjWTzQDMP4z01k9yiyXmV9zweCDAXVMqcJP9i4hAfunL82M9eM96jbqSK
         hmr84kNmwgLOscyx43Zce4PjlKc/eyoU6Tw4fADx+qZvGLul1egbOMRCUfunpf3TM9Ax
         rFkYygjosf6ATnO9R4GHbNsZkjaoHkz7qN0WtWyp3IbRitmZ37j2QiGSkoB0DAqVWjdj
         zY72xloLmUftWCHIr18g1YqeEZ7Y56QEMJCfMyAkopaOauaRl0mWEbOYckaC05DIDStQ
         9IPvkj7oEWzSaoxIyCIM0X8UZ1JnkUNpq/yC/ynQmmKZqjVEv9GNoLSTDPyqXbtUcWH5
         0LQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788943; x=1791393743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yu5vPNZRGHwBy2ovp25s5yW4Pu1HCw1xplpSec6o1bA=;
        b=lwNGCm9fTR04Eqo37bFz84HGQ5rJtphgobS00cWxmeDuQkySwL4MWn+gwF1w1S9+9U
         AmHKNcEL6omevnWV7aM3VOhp51vBVHvUCSsEhi3Qpa/UpnNpOlSiKdLm+HqwDO9YBkq/
         Tzs42UY/3QmQSh7H/iAtQJ2GNQqrDf6NWcJiDXlyNZqLSv4LZiHc1IPKlHN2cwcfZLdK
         c82FI+Tfbw3kXGT1IsCzafHYJxFRMOE1uFyKrqHEf1RWqq1LjUgUXdA+mMMfVoNBaNwV
         ld9mOrg+GocXEyj8iWXiS/ApVQlXuKoBt2k92Zc/rRC9xexwAtiIPOvKIEhg09f/WMaX
         AXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788943; x=1791393743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yu5vPNZRGHwBy2ovp25s5yW4Pu1HCw1xplpSec6o1bA=;
        b=UE2m50M7jNzoicvuClYzW6eWe0skteURZkp6fanViHymt+G6wYO0wnoG4MWHB1yiM/
         txRRGHlP0wzvPo5u1ckBpTA+MZdCb4xccQfqA1ysTp/I5+nZFxAtBC1Inb+BG5lxjj56
         fT6mAH4Y3EWQVnFZJjbRyqRf/aS0eBrZPxcoimo8r+r6wgyPNXn7KmQ5/bzKN6t8/nP5
         E9Z7scegSeuAocyOS5WQXjxBWYGgtH3ar3GceZ8b6hr4qdTlpcaDdnKv6RXtmjfw5iHv
         4yJfo9Sl/XzwNCX5fqBxm2XQxd52DFp82kdJAMUDFpIcesTk79u+ttNmofyjZ0Qf4XJI
         eODQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo2vgadquTa3AL0qO8msQRUQ5e1dRzBvvRuKoER4sd+GNMeVWtgabLFsOLqgVuecw7huw9k+Mgcy5s1ily@vger.kernel.org
X-Gm-Message-State: AFuF++lWerbxVa0IoYk5wQ7og2XLKIW+d8omzUz1JFNcm7d1mGTyBG5L
	/RkNSXgMwRi2/MIEgWp8dqW8jYDAAtpPg6Y1ZxJ+9uz3P1J11h4J8xdt9Cv5q0W5RCAKPf2JYnZ
	/KB2OdCwM9njmx1QgKm1F+5t1yDt385g=
X-Gm-Gg: AYBFou1iJO0h78rWlDawC0ksQxB96lNFFffYm89fRmdo+WfPVgnESqL7l2OZgQXmHXL
	9lxVPoULlFUhvinyxGitbw8byq12bWsuFNnEc+juK5SlWDLxG1iAYXe41S3w0NqB8fypV5blNqb
	H2Noy5MAqtFd+YrhM9Y5mx358ajr0gyxetyPmMwKJxc0ERY0AMD46ok3NmEa+yAYNjAYhr18CmQ
	r09NMg5GO07Slj5i8BXflicvUahJB0a4kuB4Bd0lN5HegMIipYoRukWA1SLGsP/qXr3PXo+xxt0
	nkySBfHTCvSvx99At7CNOXYN9fJkfDn9Bw6awoctQCMjqw63A/znrSTSPN5rtECW
X-Received: by 2002:a05:6830:2a0d:b0:81c:37e2:2012 with SMTP id
 46e09a7af769-82049efa6ffmr2348274a34.15.1790788941936; Wed, 30 Sep 2026
 10:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926-nsfs-prune-rfc-v2-0-53509260e4e7@gmail.com> <20260926-nsfs-prune-rfc-v2-1-53509260e4e7@gmail.com>
In-Reply-To: <20260926-nsfs-prune-rfc-v2-1-53509260e4e7@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 30 Sep 2026 10:22:10 -0700
X-Gm-Features: AclHuK_q_WkZKtIVvL2_JZxQzOyxiVzzsuWi72MjhRzmIxNO0_froXd1yw4BveA
Message-ID: <CANaxB-yj2QV183nk3UC-2PD6qh6hh-_iLRuryTdUsebd+RqxdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mount: add OPEN_TREE_DROP_MNTNS_MOUNTS
To: Kir Kolyshkin <kolyshkin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, David Howells <dhowells@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Andrei Vagin <avagin@google.com>, Shuah Khan <shuah@kernel.org>, 
	Giuseppe Scrivano <giuseppe@scrivano.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	containers@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 12:01=E2=80=AFAM Kir Kolyshkin <kolyshkin@gmail.com=
> wrote:
>
> A recursive open_tree(OPEN_TREE_CLONE) copies the nsfs mounts of any
> mount namespaces pinned below the source.  When the clone is attached
> inside a mount namespace younger than a pinned one, move_mount(2) fails
> with ELOOP from check_for_nsfs_mounts(), per the rule from commit
> 8823c079ba71 ("vfs: Add setns support for the mount namespace") that
> prevents mount namespace reference loops.
>
> This breaks container runtimes that use OPEN_TREE_NAMESPACE, such as
> crun [1].  The new namespace is younger than everything else, so bind
> mounting e.g. the host root fails on any host that pins a mount namespace
> (snapd does, under /run/snapd/ns).  By the time it fails, setns() has
> already run and userspace cannot recover: the host tree is out of reach,
> and the offending mounts cannot be unmounted from the detached copy.
>
> copy_mnt_ns() and create_new_namespace() already leave these mounts
> behind; only get_detached_copy() copies them.  Add an open_tree() flag to
> drop them from the clone, as suggested by Aleksa [2].  Locked nsfs mounts
> are dropped the same way copy_mnt_ns() does it, so nothing new is exposed=
.
>
> Keep it opt-in: open_tree(OPEN_TREE_CLONE) plus move_mount(2) is how
> mount --rbind works through a file descriptor, and in the caller's own
> or an older namespace such mounts remain usable.
>
> The flag requires OPEN_TREE_CLONE or OPEN_TREE_NAMESPACE.  With the
> latter it is a no-op, so a runtime can pass it unconditionally.
>
> Link: https://github.com/containers/crun/issues/2262 [1]
> Link: https://lore.kernel.org/all/2026-01-07-oldest-grim-captions-spills-=
ywC2O3@cyphar.com/ [2]
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> ---
>  fs/namespace.c             | 14 ++++++++++++--
>  include/uapi/linux/mount.h |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ae5dc64f8b45..a95173996a8f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3062,7 +3062,8 @@ static struct mnt_namespace *get_detached_copy(cons=
t struct path *path, unsigned
>                         ns->seq_origin =3D src_mnt_ns->ns.ns_id;
>         }
>
> -       mnt =3D __do_loopback(path, (flags & AT_RECURSIVE), CL_COPY_MNT_N=
S_FILE);
> +       mnt =3D __do_loopback(path, (flags & AT_RECURSIVE),
> +                           (flags & OPEN_TREE_DROP_MNTNS_MOUNTS) ? 0 : C=
L_COPY_MNT_NS_FILE);

Overall, the patch looks good. One small thing is that open_tree() with
OPEN_TREE_DROP_MNTNS_MOUNTS doesn't fail on a mntns file if AT_RECURSIVE
isn't set:

  open_tree(AT_FDCWD, "/proc/self/ns/mnt",
            OPEN_TREE_CLONE|OPEN_TREE_CLOEXEC|0x4) =3D 3

With AT_RECURSIVE, __do_loopback() calls copy_tree(), which checks
!(flag & CL_COPY_MNT_NS_FILE) && is_mnt_ns_file(dentry) and returns
-EINVAL, but without AT_RECURSIVE it calls clone_mnt(), which doesn't
have such check.

Thanks,
Andrei
